import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'main_Wiget.dart';
import 'package:zdk_app/app/common/config/Themes.dart';

class XYApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: '转得快',
      theme: defaultTargetPlatform == TargetPlatform.iOS
          ? Themes.kIOSTheme
          : Themes.kDefaultTheme, // 根据平台获取主题
      home: MainWiget(),
    );
  }
}