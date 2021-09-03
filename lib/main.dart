import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:la_electronic/app/routes/pages.dart';
import 'package:la_electronic/app/routes/routes.dart';

void main() => runApp(GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.HOME,
      getPages: Pages.pages,
      theme: ThemeData(primaryColor: Color(0xff3168E0)),
    ));
