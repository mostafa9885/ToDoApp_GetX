import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todowithgetx/Moduels/Home%20Screen/homescreen.dart';
import 'package:todowithgetx/Shared/DataBase/database_creat.dart';
import 'package:todowithgetx/Shared/Style/Theme/theme_class.dart';
import 'package:todowithgetx/Shared/Notification/notification_services.dart';
import 'Shared/Style/Theme/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DataBaseHelper.creatDatabase();
  await GetStorage.init();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: darkTheme,
      theme: lightTheme,
      themeMode: ThemeServices().theme,
      home: HomeScreen(),
    );
  }
}
