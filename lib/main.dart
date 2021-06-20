import 'package:arm_test/Provider/newsProvider.dart';
import 'package:arm_test/screens/auth/login.dart';
import 'package:arm_test/sizeConfig/dev_utils.dart';
import 'package:arm_test/sizeConfig/sizeConfig.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import 'Provider/appState.dart';


import 'package:path_provider/path_provider.dart' as path_provider;


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(DevicePreview(
      enabled: false,
      builder: (context) => MultiProvider(providers: [
        ChangeNotifierProvider(create: (_) => AppState()),
        ChangeNotifierProvider(create: (_) => NewsState()),

      ], child: MyApp())));
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    setStatusBarColor(color: BarColor.black);
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);

                if (!currentFocus.hasPrimaryFocus &&
                    currentFocus.focusedChild != null) {
                  currentFocus.focusedChild.unfocus();
                }
              },
              child: MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'ARM',
                  theme: ThemeData(
                      primarySwatch: Colors.blue,
                      fontFamily: 'BasisGrotesquePro'
                    // primarySwatch: Colors.blue,
                  ),
                  home: Login()),
            );
          },
        );
      },
    );
  }
}
