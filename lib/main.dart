import 'package:flutter/material.dart';
import 'package:flutter_galang_12rpl1/routes/app_routes.dart';
import 'package:flutter_galang_12rpl1/Row_column/LatihanDua.dart';
import 'package:flutter_galang_12rpl1/Row_column/LatihanSatu.dart';
import 'package:flutter_galang_12rpl1/Row_column/RowColumn.dart';
import 'package:flutter_galang_12rpl1/Row_column/ColumnWidget.dart';
import 'package:flutter_galang_12rpl1/container/LatihanContainer.dart';
import 'package:flutter_galang_12rpl1/container/ContainerSatu.dart';
import 'package:flutter_galang_12rpl1/list_grid_view/DetailScreen.dart';
import 'package:flutter_galang_12rpl1/list_grid_view/GridProductPage.dart';
import 'package:flutter_galang_12rpl1/list_grid_view/List-Screen.dart';
import 'package:flutter_galang_12rpl1/list_grid_view/ListView.dart';
import 'package:flutter_galang_12rpl1/navigator.dart';
import 'package:flutter_galang_12rpl1/sized_expand_stack/ExpandedWidget.dart';
import 'package:flutter_galang_12rpl1/sized_expand_stack/Latihan3.dart';
import 'package:flutter_galang_12rpl1/sized_expand_stack/Latihan4.dart';
import 'package:flutter_galang_12rpl1/sized_expand_stack/Layout1.dart';
import 'package:flutter_galang_12rpl1/sized_expand_stack/Layout2.dart';
import 'package:flutter_galang_12rpl1/sized_expand_stack/Layout4.dart';
import 'package:flutter_galang_12rpl1/sized_expand_stack/SizedBoxWidget.dart';
import 'package:flutter_galang_12rpl1/sized_expand_stack/StackWidget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: AppRoutes.routes,
      // home: Scaffold(
      //   appBar: AppBar(
      //     backgroundColor: Colors.blue,
      //     centerTitle: true,
      //   ), 
      //   body: NavigatorWidget(),
      // ), //Scaffold
    ); //MaterialApp
  }
}

class HelloWidget extends StatelessWidget {
  const HelloWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
     child: Text("Hello, Flutter!", style: TextStyle(
       fontSize: 24,
       fontWeight: FontWeight.bold,
       color: const Color.fromARGB(255, 2, 244, 196),
       backgroundColor: Colors.white,
     )),
    );
  }
}