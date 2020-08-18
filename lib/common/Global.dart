// 提供五套可选主题色
import 'package:beeui/bee.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_template/common/Constant.dart';
import 'package:flutter_app_template/states/AppModel.dart';
import 'package:flutter_app_template/states/ThemeModel.dart';
import 'package:flutter_app_template/states/UserModel.dart';
import 'package:flutter_app_template/utills/device_utils.dart';
import 'package:flutter_app_template/utills/storageUtils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Enum.dart';

const _themes = <MaterialColor>[
  Colors.blue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.red,
];

class Global {
  //默认是本地
  static Env env = Env.LOCAL;

  static String ticket;

  static SharedPreferences _prefs;

  // 网络缓存对象
//  static NetCache netCache = NetCache();

  // 可选的主题列表
  static List<MaterialColor> get themes => _themes;

  // 是否为release版
  static bool get isRelease => bool.fromEnvironment("dart.vm.product");

  //初始化全局信息，会在APP启动时执行
  static Future init({Widget child}) async {
    WidgetsFlutterBinding.ensureInitialized();

    await StorageUtil.getInstance();

    // 解决SharedPreferences运行报错问题
//    SharedPreferences.setMockInitialValues({});

    _prefs = await SharedPreferences.getInstance();
    var _profile = _prefs.getString("profile");

    if (_profile != null) {
      try {} catch (e) {
        print(e);
      }
    }

    //初始化网络请求相关配置
//    Net.init();

    String _ticket = await _prefs.getString(Constant.Ticket);

    if (_ticket != null && _ticket != '') {
      ticket = _ticket;

      // todo init
    }

    AppModel appModel = AppModel();
    UserModel userModel = UserModel();
    ThemeModel themeMode = ThemeModel();

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
        .then((_) {
      //开启界面辅助线
      debugPaintSizeEnabled = false;

      runApp(MultiProvider(
        providers: [
          //不仅能够提供数据供子孙节点使用，还可以在数据改变的时候通知所有听众刷新
          ChangeNotifierProvider.value(value: appModel),
          ChangeNotifierProvider.value(value: userModel),
          ChangeNotifierProvider.value(value: themeMode),
        ],
        child: child,
      ));

      // 透明状态栏
      if (Device.isAndroid) {
        final SystemUiOverlayStyle systemUiOverlayStyle =
            SystemUiOverlayStyle(statusBarColor: Colors.transparent);
        SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
      }
    });
  }
}
