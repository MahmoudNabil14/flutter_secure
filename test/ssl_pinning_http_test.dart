import 'dart:io';

import 'package:flutter_secure/flutter_secure.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> main() async {
  var pemCertificateFromGoogle = '''-----BEGIN CERTIFICATE-----
MIIEhzCCA2+gAwIBAgIQaIqdcIkiQpQSu0HdwEZSEDANBgkqhkiG9w0BAQsFADBG
MQswCQYDVQQGEwJVUzEiMCAGA1UEChMZR29vZ2xlIFRydXN0IFNlcnZpY2VzIExM
QzETMBEGA1UEAxMKR1RTIENBIDFDMzAeFw0yMzA1MTkxMjU4MTNaFw0yMzA4MTEx
MjU4MTJaMBkxFzAVBgNVBAMTDnd3dy5nb29nbGUuY29tMFkwEwYHKoZIzj0CAQYI
KoZIzj0DAQcDQgAE5+JO07UF+YkqU7GHvvPFBFuTI4beEUeTtUrrXXDVk4/yBMA7
afFVUoiN4TF3f1iR9ZYb39ofxQeRI3ibvDcoH6OCAmcwggJjMA4GA1UdDwEB/wQE
AwIHgDATBgNVHSUEDDAKBggrBgEFBQcDATAMBgNVHRMBAf8EAjAAMB0GA1UdDgQW
BBSVxeavHNbSACqKv9drJts57JT6BzAfBgNVHSMEGDAWgBSKdH+vhc3ulc09nNDi
RhTzcTUdJzBqBggrBgEFBQcBAQReMFwwJwYIKwYBBQUHMAGGG2h0dHA6Ly9vY3Nw
LnBraS5nb29nL2d0czFjMzAxBggrBgEFBQcwAoYlaHR0cDovL3BraS5nb29nL3Jl
cG8vY2VydHMvZ3RzMWMzLmRlcjAZBgNVHREEEjAQgg53d3cuZ29vZ2xlLmNvbTAh
BgNVHSAEGjAYMAgGBmeBDAECATAMBgorBgEEAdZ5AgUDMDwGA1UdHwQ1MDMwMaAv
oC2GK2h0dHA6Ly9jcmxzLnBraS5nb29nL2d0czFjMy9mVkp4YlYtS3Rtay5jcmww
ggEEBgorBgEEAdZ5AgQCBIH1BIHyAPAAdgDoPtDaPvUGNTLnVyi8iWvJA9PL0RFr
7Otp4Xd9bQa9bgAAAYg0Tc50AAAEAwBHMEUCIHGOV17ZNpEAGeREava8cY+XozN/
QKv1zDHux8gi87lpAiEAgBf7dAkXNCSrc2m6rdPES6ouwAYm0Y/uFYxeYsF3mZAA
dgCzc3cH4YRQ+GOG1gWp3BEJSnktsWcMC4fc8AMOeTalmgAAAYg0Tc6pAAAEAwBH
MEUCIC/iBqmdZUT62MWoWhFU1QV75YI9asAb9ULHU5iU0H3QAiEA1XvfAVlBQiVK
8LcZgIAlIX6nkxY0+kVeJdZpWkYgnZAwDQYJKoZIhvcNAQELBQADggEBANBuETkw
YEBzrBXuu1hyMyOlTg2PlOjiAK3/JrJ8XxONWB9vJ3HpmKYPQa6hGtO2XlQQ4BDD
XWwmeXrLM3La9Nf4kMHM7KmhTUu6NSycINuvF4w28KxkP0y+VRNpmvm7k723xGk+
7FkjdhpAMhD7322FMZlqYV3wDRDEHaSDNZnBnTniNaWx+cXjPvlGHrYyojaZ2R7+
cQMGU++TfvGeykPton+K3CPrGA0NgohxzyqOy5x1Py3RtLrUZCHy3JuxtuX/FvlM
XDu0YAoUHfqhmBoSqWj8sHLb++c5d4AWO4rhjHFvF4/CVHkuxehKl2ytwGIZqisJ
WRhOiYq0rqjzgLQ=
-----END CERTIFICATE-----
''';

  var client = SSLPinningHttpClient([pemCertificateFromGoogle]);

  group('SSL Pinning Test', () {
    test(
      'it does not throw TlsException when certificate is added for host',
      () async {
        try {
          var call = await client.get(Uri.parse('https://www.google.com'));
          expect(call.statusCode, 200);
        } on TlsException {
          fail('It throws TlsException even if certificate is added for host');
        }
      },
    );

    test(
      'it throws TlsException when certificate is not added for host',
      () {
        var call = client.get(Uri.parse('https://www.facebook.com'));
        expectLater(() async => await call, throwsA(isA<TlsException>()));
      },
    );
  });
}
