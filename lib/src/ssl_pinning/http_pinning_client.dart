import 'dart:async';
import 'dart:io';

import 'package:http/http.dart';

/// A HttpClient that takes List of PEM Certificates and validates the certificate before sending the actual request.
/// This class overrides the send method of the BaseClient class, and opens a secure connection with the server, to get the certificate from the server.
/// Then it verifies the certificate with the list of certificates provided by the user.
/// If certificates match, then the request is sent, else a TlsException is thrown.
class SSLPinningHttpClient extends BaseClient {
  /// List of trusted certificates in PEM format.
  final List<String> trustedCertificates;
  late final Client _client;

  /// Trusted certificates should be in PEM format.
  SSLPinningHttpClient(this.trustedCertificates, [Client? customClient])
      : _client = customClient ?? Client();

  /// Creates a PinnedHttpClient from a list of Certificates files in PEM Format.
  factory SSLPinningHttpClient.fromCertFiles(List<File> pemFiles,
      [Client? customClient]) {
    final List<String> trustedCertificates = [];
    for (var pemFile in pemFiles) {
      trustedCertificates.add(pemFile.readAsStringSync());
    }
    return SSLPinningHttpClient(trustedCertificates, customClient);
  }

  @override
  Future<StreamedResponse> send(BaseRequest request) async {
    try {
      final socket = await SecureSocket.connect(
        request.url.host,
        443, // default https port
        timeout: const Duration(milliseconds: 5000),
      );
      X509Certificate? serverCertificate = socket.peerCertificate;

      // verify certificate
      if (!_verifyServerCert(serverCertificate)) {
        throw const TlsException('Server certificate is not trusted');
      }

      socket.close();
    } catch (e) {
      rethrow;
    }

    return _client.send(request);
  }

  @override
  void close() {
    _client.close();
  }

  /// Verifies the server certificate with the list of trusted certificates provided by the user.
  bool _verifyServerCert(X509Certificate? serverCertificate) {
    if (serverCertificate == null) {
      throw const TlsException('Server certificate is null');
    }

    // verify certificate with trustedCertificates
    for (var pinningCert in trustedCertificates) {
      if (pinningCert == serverCertificate.pem) {
        return true;
      }
    }

    return false;
  }
}
