// Import the test package
// Import the test package
import 'dart:convert';
import 'package:aws_lambda_dart_runtime/runtime/context.dart';
import 'package:test/test.dart';
import 'dart:io' show File;
import 'package:dart_lambda/handler.dart';
import 'package:aws_lambda_dart_runtime/aws_lambda_dart_runtime.dart';

final String filePath = './test/apigateway_get_event.json';
final String contents = new File(filePath).readAsStringSync();
final Map<String, dynamic> json = jsonDecode(contents);

void main() {
  // Define a group of tests
  group('API Gateway Handler Tests', () {
    // Define a single test
    test('Test an HTTP Get Request and status 200', () async {
      // Arrange: setup the conditions for your test

      AwsApiGatewayEvent testEvent = AwsApiGatewayEvent.fromJson(json);
      Context testContext =
          Context(requestId: 'TESTID', handler: 'apiGatewayHandler');
      final response = await apiGatewayHandler(testContext, testEvent);

      expect(response.statusCode, equals(200));
      // Assert: check that the result is what you expected
      //expect(result, equals(expectedResult));
    });
  });
}
