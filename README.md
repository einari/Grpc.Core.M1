# Grpc.Core.M1

[![Nuget](https://img.shields.io/nuget/v/contrib.grpc.core.m1)](http://nuget.org/packages/Contrib.Grpc.Core.M1)

The purpose of this project is to provide a prebuilt version of the needed native **.dylib** for
 M1 CPUs when using the legacy [C# Grpc library](https://www.nuget.org/packages/Grpc.Core).

The future of Grpc and C# is described [here](https://grpc.io/blog/grpc-csharp-future/).

## Building a new lib

This package relies on having to build a native `.dylib` and put into this folder.
Get the tooling installed as described [here](https://github.com/grpc/grpc/blob/master/BUILDING.md#macos)
and then perform the build using cmake as described [here](https://github.com/grpc/grpc/blob/master/BUILDING.md#building-with-cmake).

## Usage

In addition to your Grpc package reference, just add a reference to this package in your *.csproj* file:

```xml
<ItemGroup>
    <PackageReference Include="Grpc" Version="2.41.0" />
    <PackageReference Include="Contrib.Grpc.Core.M1" Version="2.41.0" />
</ItemGroup>
```

> Note: The version number for this package matches the official Grpc package and I'll be building from source
> every now and then. But chances are its not critical for NuGet and versioning, as it is the underlying library that is packaged.

If you're leveraging another package that implicitly pulls this in, you might need to explicitly include a package
reference to the **Grpc** package anyways - if your library works with the version this package is built for.
