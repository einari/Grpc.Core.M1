#!/bin/bash
if [ -n "$1" ]; then
    VERSION_TO_RELASE="$1"
fi

if [ -z "$VERSION_TO_RELASE" ]; then
    VERSION_TO_RELASE=$(curl -sS  https://azuresearch-usnc.nuget.org/query\?q\=grpc.core | jq -r '.data[] | select(.id=="Grpc.Core")' | jq -r '.versions[-1:]' | jq -r '.[0].version')
fi

CURRENT_VERSION=$(curl -sS  https://azuresearch-usnc.nuget.org/query\?q\=Contrib.Grpc.Core.M1 | jq -r '.data[] | select(.id=="Contrib.Grpc.Core.M1")' | jq -r '.versions[-1:]' | jq -r '.[0].version')
echo "Current Grpc.Core version: $CURRENT_VERSION"
echo "Version to release: $VERSION_TO_RELASE"

if [ "$VERSION_TO_RELASE" == "$CURRENT_VERSION" ]; then
    echo "No new version to release"
    exit 0
else
    echo "New version to release"
    sed -i -e "s/INSERTVERSION/${VERSION_TO_RELASE}/g" Grpc.Core.M1.nuspec
    sed -i -e "s/CURRENTVERSION/${CURRENT_VERSION}/g" Grpc.Core.M1.nuspec
    rm *.nupkg
    nuget pack
    nuget push *.nupkg -source https://api.nuget.org/v3/index.json    
    exit 1
fi