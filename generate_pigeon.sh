flutter pub run pigeon \
  --input lib/src/platform_api_interface.dart \
  --dart_out lib/src/platform_api.dart \
  --objc_header_out ios/Classes/pigeon.h \
  --objc_source_out ios/Classes/pigeon.m \
  --swift_out ios/Classes/PlatformAPIInterface.swift \
  --kotlin_out android/src/main/kotlin/com/dreamorbit/flutter_secure/PlatformAPIInterface.kt \
  --kotlin_package "com.dreamorbit.flutter_secure" \
  --cpp_namespace pigeon