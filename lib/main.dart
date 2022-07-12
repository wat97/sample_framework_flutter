import 'package:flutter/material.dart';
import 'config/config_base.dart';

void main() => Production();

class Production extends Env {
  final String appName = "Sample Framework";
  final String baseUrl = 'https://google.com';

  EnvType environmentType = EnvType.PRODUCTION;
}
