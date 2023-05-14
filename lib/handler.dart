import 'package:aws_lambda_dart_runtime/aws_lambda_dart_runtime.dart';
import 'package:aws_lambda_dart_runtime/runtime/context.dart';

Future<AwsApiGatewayResponse> apiGatewayHandler(
    Context context, AwsApiGatewayEvent event) async {
  print("Hello world!");
  print(event.toJson());
  final response = {'message': 'hello ${context.requestId}'};
  return AwsApiGatewayResponse.fromJson(response);
}
