import 'dart:convert';
import 'dart:io';
import 'dart:core';
import 'package:aws_lambda_dart_runtime/runtime/context.dart';
import 'package:aws_lambda_dart_runtime/aws_lambda_dart_runtime.dart';
import 'package:uuid/uuid.dart';
import 'package:dart_lambda/api_gateway/handler.dart';

const Uuid uuid = Uuid();

Future<void> main() async {
  final server = await createServer();
  print('Server started: ${server.address} port ${server.port}');
  await handleRequests(server);
}

Future<void> handleRequests(HttpServer server) async {
  await for (HttpRequest request in server) {
    final contextIdString = uuid.v4();
    final event = AwsApiGatewayEvent(
        headers: convertHttpHeadersToAwsEventHeaders(request.headers),
        queryStringParameters: request.uri.queryParameters,
        httpMethod: request.method,
        path: request.uri.toString(),
        body: await utf8.decoder.bind(request).join());
    print(
        "${request.method} received ${request.uri} ${request.uri.queryParameters}\n${event.toJson()}");
    Context context =
        Context(requestId: contextIdString, handler: 'apiGatewayHandler');
    request.response.headers.contentType = ContentType('application', 'json');
    request.response.write((await apiGatewayHandler(context, event)).toJson());
    await request.response.close();
  }
}

AwsApiGatewayEventHeaders convertHttpHeadersToAwsEventHeaders(
    HttpHeaders httpHeaders) {
  return AwsApiGatewayEventHeaders(
    accept: httpHeaders.value(HttpHeaders.acceptHeader),
    acceptEncoding: httpHeaders.value(HttpHeaders.acceptEncodingHeader),
    cloudfrontIsDesktopViewer:
        httpHeaders.value('CloudFront-Is-Desktop-Viewer'),
    cloudfrontIsMobileViewer: httpHeaders.value('CloudFront-Is-Mobile-Viewer'),
    cloudfrontIsSmartTvViewer:
        httpHeaders.value('CloudFront-Is-SmartTV-Viewer'),
    cloudfrontForwardProto: httpHeaders.value('X-Forwarded-Proto'),
    cloudfrontIsTabletViewer: httpHeaders.value('CloudFront-Is-Tablet-Viewer'),
    cloudfrontViewerCountry: httpHeaders.value('CloudFront-Viewer-Country'),
    upgradeInsecureRequests: httpHeaders.value('Upgrade-Insecure-Requests'),
    cacheControl: httpHeaders.value(HttpHeaders.cacheControlHeader),
    host: httpHeaders.value(HttpHeaders.hostHeader),
    via: httpHeaders.value(HttpHeaders.viaHeader),
    userAgent: httpHeaders.value(HttpHeaders.userAgentHeader),
    xAmzCfId: httpHeaders.value('X-Amz-Cf-Id'),
    xAmznTraceId: httpHeaders.value('X-Amzn-Trace-Id'),
    xForwardedFor: httpHeaders.value('X-Forwarded-For'),
    xForwardedPort: httpHeaders.value('X-Forwarded-Port'),
    xForwardedProto: httpHeaders.value('X-Forwarded-Proto'),
  );
}

Future<HttpServer> createServer() async {
  InternetAddress address = Platform.environment['RUNNING_IN_DOCKER'] == 'true'
      ? InternetAddress('0.0.0.0')
      : InternetAddress.loopbackIPv4;
  const port = 8080;
  return await HttpServer.bind(address, port);
}
