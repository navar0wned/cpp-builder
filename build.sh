#!/bin/bash

echo "Choose the operating system:"
select os in "linux" "windows"; do
    [ -n "$os" ] && break
done

echo "Choose the compiler:"
select compiler in "clang" "msvc"; do
    [ -n "$compiler" ] && break
done

echo "Choose the build type:"
select build_type in "debug" "release"; do
    [ -n "$build_type" ] && break
done


if [ "$os" == "linux" ]; then
    dockerfile="Dockerfile.linux"
    tag="example-linux"
    executable_name="a.out"
elif [ "$os" == "windows" ]; then
    dockerfile="Dockerfile.windows"
    tag="example-windows"
    executable_name="a.exe"
    docker pull mcr.microsoft.com/windows/servercore:ltsc2022
fi

if [ "$compiler" == "clang" ] || [ "$compiler" == "msvc" ]; then
    docker build -t $tag \
                 --build-arg COMPILER=$compiler \
                 --build-arg BUILD_TYPE=$build_type \
                 -f ./$dockerfile .
    mkdir -p bin

    #docker run --rm -it $tag
    container_id=$(docker run -d $tag)
    docker wait $container_id

    docker cp $container_id:/app/build/"$build_type"/"$executable_name" ./bin/"$executable_name"
    docker cp -R $container_id:/app/build/"$build_type"/tests/ ./bin/tests/

    docker stop $container_id
    docker rm $container_id

    cp ./app/example.txt ./bin/example.txt
else
    echo "Invalid compiler choice. Exiting"
    exit 1
fi