flutter pub run pigeon \
  --input pigeon/message.dart \
  --dart_out lib/pigeon.dart \
  --java_out ./android/app/src/main/java/dev/flutter/pigeon/Pigeon.java \
  --java_package "com.example.flutter_router_demo" \
  --objc_header_out ios/Runner/pigeon.h \
  --objc_source_out ios/Runner/pigeon.m \
