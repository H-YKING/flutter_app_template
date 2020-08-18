import 'dart:ui';

import 'package:flutter_app_template/common/Colors.dart';
import 'package:flutter_app_template/common/Constant.dart';
import 'package:flutter_app_template/common/Styles.dart';
import 'package:flutter_app_template/utills/storageUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension ThemeModeExtension on ThemeMode {
  String get value => ['System', 'Light', 'Dark'][index];
}

class ThemeModel extends ChangeNotifier {
  void syncTheme() {
    final String theme = StorageUtil.getString(Constant.theme);
    if (theme.isNotEmpty && theme != ThemeMode.system.value) {
      notifyListeners();
    }
  }

  void setTheme(ThemeMode themeMode) {
    StorageUtil.putString(Constant.theme, themeMode.value);
    notifyListeners();
  }

  ThemeMode getThemeMode() {
    final String theme = StorageUtil.getString(Constant.theme);
    switch (theme) {
      case 'Dark':
        return ThemeMode.dark;
      case 'Light':
        return ThemeMode.light;
      default:
        return ThemeMode.system;
    }
  }

  ThemeData getTheme({bool isDarkMode = false}) {
    return ThemeData(
        errorColor: isDarkMode ? Colours.dark_red : Colours.red,
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
        primaryColor: isDarkMode ? Colours.dark_app_main : Colours.app_main,
        accentColor: isDarkMode ? Colours.dark_app_main : Colours.app_main,
        // Tab指示器颜色
        indicatorColor: isDarkMode ? Colours.dark_app_main : Colours.app_main,
        // 页面背景色
        scaffoldBackgroundColor:
            isDarkMode ? Colours.dark_bg_color : Color(0xfff1f1f1),
        // 主要用于Material背景色
        canvasColor: isDarkMode ? Colours.dark_material_bg : Colors.white,
        // 文字选择色（输入框复制粘贴菜单）
        textSelectionColor: Colours.app_main.withAlpha(70),
        textSelectionHandleColor: Colours.app_main,
        textTheme: TextTheme(
          headline6: isDarkMode
              ? TextStyles.textTitle.copyWith(color: Colours.dark_text_title)
              : TextStyles.textTitle.copyWith(color: Colours.text_title),
          // TextField输入文字颜色
          subtitle1: isDarkMode ? TextStyles.textDark : TextStyles.text,
          // Text文字样式
          bodyText1: isDarkMode ? TextStyles.textDark : TextStyles.text,
          subtitle2: isDarkMode
              ? TextStyles.textSubTitle
                  .copyWith(color: Colours.dark_text_sub_title)
              : TextStyles.textSubTitle.copyWith(color: Colours.text_sub_title),
        ),
        // 提示文字
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: isDarkMode ? TextStyles.textHint14 : TextStyles.textHint14,
        ),
        appBarTheme: AppBarTheme(
          elevation: 0.0,
          textTheme: TextTheme(
            headline6: TextStyle(
                fontSize: 16, color: isDarkMode ? Colors.white : Colors.black),
          ),
          iconTheme:
              IconThemeData(color: isDarkMode ? Colors.white : Colors.black),
          color: isDarkMode
              ? Colours.dark_appbar_bg_color
              : Colours.appbar_bg_color,
          brightness: isDarkMode ? Brightness.dark : Brightness.light,
        ),
        iconTheme: IconThemeData(
            color: isDarkMode ? Colours.dark_text : Colours.text_sub_title),
        tabBarTheme: TabBarTheme(
          unselectedLabelStyle:
              TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          labelColor: isDarkMode ? Colours.dark_app_main : Colours.app_main,
          unselectedLabelColor:
              isDarkMode ? Colours.dark_text : Colours.text_gray,
        ),
        dialogTheme: DialogTheme(
          backgroundColor: isDarkMode ? Colours.dark_material_bg : Colors.white,
        ),
        dividerColor: isDarkMode ? Color(0xFF273040) : Colours.line,
        dividerTheme: DividerThemeData(
            color: isDarkMode ? Colours.dark_line : Colours.line,
            space: 0.6,
            thickness: 0.6),
        cupertinoOverrideTheme: CupertinoThemeData(
          brightness: isDarkMode ? Brightness.dark : Brightness.light,
        ));
  }
}
