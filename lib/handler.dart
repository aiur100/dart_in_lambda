import 'package:aws_lambda_dart_runtime/aws_lambda_dart_runtime.dart';
import 'package:aws_lambda_dart_runtime/runtime/context.dart';

Future<AwsApiGatewayResponse> apiGatewayHandler(
    Context context, AwsApiGatewayEvent event) async {
  final response = handleGET(event);
  return AwsApiGatewayResponse.fromJson(response);
}

Map<String, dynamic> handleGET(AwsApiGatewayEvent event) {
  if (event.httpMethod != 'GET') throw new Exception('GET requests only');
  return {'message': "Hello from: ${event.path}"};
}
