import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_app/src/movie_app.dart';
import 'package:movie_app/src/service_locator.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initServiceLocator();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MovieApp());
}