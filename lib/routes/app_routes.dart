import 'package:flutter/material.dart';
import 'package:flutter_galang_12rpl1/pages/form_pages.dart';
import 'package:flutter_galang_12rpl1/Row_column/ColumnWidget.dart';
import 'package:flutter_galang_12rpl1/Row_column/LatihanDua.dart';
import 'package:flutter_galang_12rpl1/Row_column/LatihanSatu.dart';
import 'package:flutter_galang_12rpl1/list_grid_view/GridProductPage.dart';
import 'package:flutter_galang_12rpl1/list_grid_view/List-Screen.dart';
import 'package:flutter_galang_12rpl1/pages/about.pages.dart';
import 'package:flutter_galang_12rpl1/pages/home.pages.dart';
import 'package:flutter_galang_12rpl1/pages/input-form.dart';
import 'package:flutter_galang_12rpl1/pages/input_eskul.dart';
import 'package:flutter_galang_12rpl1/AssalaamFood/main.dart';

class AppRoutes {
  static const home = '/';
  static const gridProductPage = '/grid-product-page';
  static const about = '/about';
  static const detailScreen = '/List-Screen';
  static const columnWidget = '/ColumnWidget';
  static const latihanSatu = '/LatihanSatu';
  static const latihanDua = '/LatihanDua';
  static const formPages = '/form_pages';
  static const inPut = '/input-form';
  static const inputEskul = '/input_eskul';
  static const Main = '/main';

  static Map<String, WidgetBuilder> routes = {
    home: (context) => HomePage(),
    gridProductPage: (context) => GridProductPage(),
    about: (context) => AboutPage(),
    detailScreen: (context) => ArticleListScreen(),
    columnWidget: (context) => ColumnWidget(),
    latihanSatu: (context) => LatihanSatu(),
    latihanDua: (context) => LatihanDua(),
    formPages: (context) => FormApp(),
    inPut: (context) => BelajarForm(),
    inputEskul:(context) => input_eskul(),
    Main:(context) => AssalaamFoodApp(),
  };
}