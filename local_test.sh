#!/bin/bash
echo "Pulling dart environment..."
docker pull arm64v8/dart
echo "Dart environment pulled!"

echo "Building docker images..."
docker build -t dart-sdk-arm64 -f compile.Dockerfile .
echo "Building docker images complete!"

echo "Running dart docker container that compiles code..."
docker run --name dart_container dart-sdk-arm64
echo "Running dart docker container that compiles code complete!"

echo "Copying compiled dart code..."
docker cp dart_container:/app/bootstrap bootstrap
chmod +x bootstrap
docker rm -f dart_container
echo "Compiled dart code compiled!"

echo "Build lambda runtime with compiled dart code..."
zip -j lambda.zip bootstrap

sam local invoke -e ./events/test_event.json