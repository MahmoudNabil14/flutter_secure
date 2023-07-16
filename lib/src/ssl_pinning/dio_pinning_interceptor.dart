import 'dart:io';

import 'package:dio/dio.dart';

class SSLPinningInterceptor extends Interceptor {
  final List<String> trustedCertificates;

  SSLPinningInterceptor(this.trustedCertificates);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      final uri = options.uri;
      final host = uri.host;
      final port = uri.port;

      // Open a socket connection to retrieve the server's certificate
      final socket = await SecureSocket.connect(host, port);
      final receivedCertificate = socket.peerCertificate?.pem;
      socket.close();

      // Check if the received match the trusted certificates
      final matchingCertificates =
          trustedCertificates.contains(receivedCertificate);

      if (!matchingCertificates) {
        // No matching certificates found, reject the request
        throw DioException(
          error: const TlsException('SSL pinning validation failed.'),
          requestOptions: options,
        );
      }

      // Move to the next interceptor or proceed with the network request
      handler.next(options);
    } catch (e) {
      if (e is DioException) {
        handler.reject(e);
      } else {
        handler.reject(DioException(requestOptions: options, error: e));
      }
    }
  }
}
