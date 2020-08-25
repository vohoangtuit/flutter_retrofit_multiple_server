import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'app_config.dart';

void main() {
  var configuredApp = new AppConfig(
    appName: 'Build flavors',
    flavorName: 'production',
    apiBaseUrl: 'https://api.example.com/',
    child: new MyApp(),
  );
  runApp(configuredApp);
}