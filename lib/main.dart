import 'package:flutter/material.dart';
import 'package:recipe/my_app.dart';
import 'package:recipe/view_model/data/local/shared_helper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SharedHelper.init();
  runApp(const MyApp());
}
