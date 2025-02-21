import 'package:flutter/material.dart';
import 'package:pinapp_test/app/core/DI/service_locator.dart';
import 'package:pinapp_test/app/my_app.dart';

void main() {
  /// Inicializa las dependencias
  ServiceLocator.initDependencies();

  runApp(const MyApp());
}
