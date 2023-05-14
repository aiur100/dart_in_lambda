FROM dart:stable

WORKDIR /app
COPY ./lib/ /app/lib
COPY pubspec.yaml /app
RUN dart pub get
RUN dart compile exe lib/main.dart -o /app/bootstrap