#!/bin/bash
rm *.nupkg
nuget pack
nuget push *.nupkg -source https://api.nuget.org/v3/index.json