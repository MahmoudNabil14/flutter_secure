# flutter_secure

![drawing](https://raw.githubusercontent.com/Dream-Orbit/flutter_secure/dev/assets/header_banner.png)

The `flutter_secure` library is a comprehensive Flutter package that offers various security-related functionalities for Flutter Applications. It provides developers with tools to enhance the security of their Flutter apps by detecting root access, implementing SSL pinning, securing key-value storage, detecting fake locations, detecting fake devices, and detecting app tampering. These features collectively contribute to a more robust and secure application environment, safeguarding user data and ensuring the integrity of the app's execution.

## Installation

Add the following to your `pubspec.yaml` file:

```yaml
dependencies:
   flutter_secure: ^1.0.1
```

## Platform Setup
<details>
<summary>Android Setup</summary>

#####  Set the minimum sdk version:
Set Minimum SDK Version to >=18 in your android app folder's `build.gradle` file:
```groovy 
android {
  ..
  defaultConfig {
    ..
    minSdkVersion 18
  }
}
```

##### Set the autoBackup to false
We need to disable the auto backup of FlutterSecuredStorage for the android app, because on restore it breaks the secured storage.

If you wish to completely disable backup, add the following to the `AndroidManifest.xml`:

```xml
<application
  ...
  android:allowBackup="false"
  android:fullBackupContent="false">
```

Else, you can choose to disable just the secured storage backup. Add following to the `AndroidManifest.xml`:

```xml
<application
  ...
  android:allowBackup="true"
  android:fullBackupContent="true"
  android:dataExtractionRules="@xml/data_extraction_rules">
```
Then add the `data_extraction_rules.xml` file in `res` folder's `xml` folder with following content:
```xml
<?xml version="1.0" encoding="utf-8"?>
<data-extraction-rules>
  <cloud-backup>
    <include domain="sharedpref" path="."/>
    <exclude domain="sharedpref" path="FlutterSecureStorage"/>
  </cloud-backup>
</data-extraction-rules>
```
</details>

<details>
<summary>iOS Setup</summary>
No explicit setup required.
</details>

## Feature Usage

### Root Detection
Root Detection is used to get Android device' rooted status or iOS device's Jailbroken status. To access the status, following snippet can be referred to:

```dart
void checkRooted() {
  FlutterSecure flutterSecure = FlutterSecure();
  bool rooted = await flutterSecure.isRooted;
  if (rooted) {
    // Device is rooted or jailbroken
    // Implement appropriate actions to handle rooted devices
  } else {
    // Device is not rooted or jailbroken
    // Proceed with normal application flow
  }
}
```

### SSL Pinning
SSL Pinning is used for pinning the application's network requests to a certain domain. To achieve this, the trusted domain's certificate is embedded into application and is verified on each request to server, from the application's end.

To achieve SSL Pinning, we have supported two popular networking libraries of flutter: http & Dio.

> Note: The certificates that will be used to pin, must be in PEM format as a string or File. For reference, PEM format looks like below:
> ```
> -----BEGIN CERTIFICATE-----  
> ... Certificate Content ...
> -----END CERTIFICATE-----
> ```

##### SSL Pinning with Http
To use SSL pinning with Http, you can use our http client, providing the list of trusted certificates as string or File.

```dart
// Using string PEM certificates
var client1 = SSLPinningHttpClient([pemCertificateString]);

// Using file PEM certificates
var client2 = SSLPinningHttpClient.fromCertFiles([pemCertificateFile]);

// Use client1 or client2 as normal http client to make CRUD requests
```

When there's an anomaly in received certificate, the request will not be made and the request will throw a `TlsException`. Make sure to wrap each of your requests in a `try-catch` block.

Http client usage example:

```dart
try {
  var call = await client.get(Uri.parse('https://dreamorbit.com/'));
} on TlsException {
  // Received certificate is different from trusted certificates
}
```

##### SSL Pinning with Dio
To use SSL pinning with your Dio client, you can use our Dio SSL Pinning Interceptor, providing the list of trusted certificates as string or File.

```dart

Dio dio1 = Dio()
  ..interceptors.add(SSLPinningInterceptor([pemCertificateString]));
Dio dio2 = Dio()
  ..interceptors.add(SSLPinningInterceptor.fromCertFiles([pemCertificateFile]));

// Use dio1 or dio2 as normal http client to make CRUD requests
```

When there's an anomaly in received certificate, the request will not be made and the request will
throw a `DioException` containing `error` property of type `TlsException`. Make sure to wrap each of
your requests in a `try-catch` block.

Dio Interceptor usage example:
```dart
try {
var call = await dio.get('https://dreamorbit.com/');
} on DioException catch (e) {
if (e.error is TlsException) {
// Recieved certificate is different from trusted certificates
} else {
// Some other exception
}
}
```

### Secured Storage

Secure storage uses platform's security mechanism for storing key-value data. You can access the secured storage instance from main class of the plugin:

```dart
var securedStorage = FlutterSecure().storage;
```
You can call following methods on the securedStorage
| Method  | Purpose                                                                                                  |
|---------|----------------------------------------------------------------------------------------------------------|
| write   | Writes a `value` associated with a specific `key` to the storage. This method is used to store data securely in the storage.                                      |
| read    | Reads the value associated with a specific `key` from the storage. It returns the stored `value` or `null` if the `key` doesn't exist in the storage.           |
| readAll | Retrieves all key-value pairs from the storage as a `Map`. This method returns a `Map` containing all the stored key-value pairs.                                 |
| delete  | Deletes the value associated with a specific `key` from the storage. This method removes a specific key-value pair from the storage.                              |
| deleteAll | Deletes all key-value pairs from the storage. This method clears the entire storage, removing all stored data.                                                     |

### Fake Location Detection
This feature helps detect whether the device has capability to fake its location. Its helpful when the trust in device's provided location is crucial for application's functioning.

> 🚧 Under Progress

### Emulator Detection
This feature helps detect whether the device which is hosting the application is a real device or an emulator.

> 🚧 Under Progress

### Tamper Detection
This feature is helpful in determining whether the application is original or it is tampered. This is useful in case when some hackers recompile the application mixing their own code. The application can detect tampering and block the application flow at the start of application.

> 🚧 Under Progress

## License

```  
BSD 3-Clause License  
```  
Read the [LICENSE](LICENSE) file for details.

## Changelog

Refer to the [Changelog](CHANGELOG.md) to get all release notes.