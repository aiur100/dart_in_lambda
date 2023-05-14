import 'dart:convert';
import 'dart:io';
import 'package:aws_lambda_dart_runtime/aws_lambda_dart_runtime.dart';
import 'package:dart_lambda/handler.dart';

void main(List<String> args) async {
  /// The Runtime is a singleton. You can define the handlers as you wish.
  Runtime()
    ..registerHandler<AwsApiGatewayEvent>('hello.ALB', apiGatewayHandler)
    ..invoke();
}
