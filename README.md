# Grpc.Core.M1

[![Nuget](https://img.shields.io/nuget/v/contrib.grpc.core.m1)](http://nuget.org/packages/Contrib.Grpc.Core.M1)

The purpose of this project is to provide a prebuilt version of the needed native **.dylib** for
 M1 CPUs when using the legacy [C# Grpc library](https://www.nuget.org/packages/Grpc.Core).

> Important: You should only use this if you're depending on the legacy version v1.46.x of Grpc.Core.
> The future of Grpc and C# is described [here](https://grpc.io/blog/grpc-csharp-future/) and the Grpc.Core library is
> deprecated and the maintenance period will possibly be ended in October 2024.

## Building a new lib

This package relies on having to build a native `.dylib` and put into this folder.
Get the tooling installed as described [here](https://github.com/grpc/grpc/blob/master/BUILDING.md#macos)
and then perform the build using cmake as described [here](https://github.com/grpc/grpc/blob/master/BUILDING.md#building-with-cmake).
We want to have the shared libraries, so the `cmake` process should be:

```shell
$ mkdir -p cmake/build
$ cd cmake/build
$ cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo \
      -DgRPC_BACKWARDS_COMPATIBILITY_MODE=ON \
      -DgRPC_XDS_USER_AGENT_IS_CSHARP=ON \
      ../../
$ make grpc_csharp_ext
```

Then copy the resulting `libgrpc_csharp_ext.dylib` to the `Grpc.Core.M1` folder and rename it to `libgrpc_csharp_ext.arm64.dylib`.

## Usage

In addition to your Grpc package reference, just add a reference to this package in your *.csproj* file:

```xml
<ItemGroup>
    <PackageReference Include="Grpc" Version="2.46.7" />
    <PackageReference Include="Contrib.Grpc.Core.M1" Version="2.46.7" />
</ItemGroup>
```

> Note: The version number for this package matches the official Grpc package and I'll be building from source
> every now and then. But chances are its not critical for NuGet and versioning, as it is the underlying library that is packaged.

If you're leveraging another package that implicitly pulls this in, you might need to explicitly include a package
reference to the **Grpc** package anyways - if your library works with the version this package is built for.
