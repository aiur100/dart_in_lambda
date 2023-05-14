import 'package:aws_lambda_dart_runtime/aws_lambda_dart_runtime.dart';
import 'package:aws_lambda_dart_runtime/runtime/context.dart';

Future<AwsApiGatewayResponse> apiGatewayHandler(
    Context context, AwsApiGatewayEvent event) async {
  try {
    if (!routes.containsKey(event.path)) throw new Exception('Path not found');
    final routeFunction = routes[event.path]!;
    final response = routeFunction(event);
    return AwsApiGatewayResponse.fromJson(response);
  } catch (e) {
    return AwsApiGatewayResponse.fromJson(
        {"message": "An error occurred", "error": e.toString()},
        statusCode: 400);
  }
}

Map<String, dynamic> helloRoute(AwsApiGatewayEvent event) {
  return {"message": "Hello route hit!"};
}

Map<String, dynamic> worldRoute(AwsApiGatewayEvent event) {
  return {"message": "World route hit!"};
}

Map<String, Function> routes = {
  "/v1/hello": helloRoute,
  "/v1/world": worldRoute
};
