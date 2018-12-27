import 'package:flutter/material.dart';
import './app/app.dart';
import 'package:flutter/rendering.dart' show debugPaintSizeEnabled;

void main() {
  debugPaintSizeEnabled = false;      //打开视觉调试开关
  runApp(new XYApp());
}