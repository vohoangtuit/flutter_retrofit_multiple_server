import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';

import 'app_config.dart';
void main() {
  var configuredApp = new AppConfig(
    appName: 'Build flavors DEV',
    flavorName: 'development',
    apiBaseUrl: 'https://vohoangtu-authencation.herokuapp.com/api/',
    child: new MyApp(),
  );

  runApp(configuredApp);
}