import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movise/moudlse/Browser/CategoryList.dart';
import 'package:movise/moudlse/home%20screen/MoviseDetilsScreen/movies_detils.dart';
import 'package:movise/shared/stayls/my_themedata.dart';
import 'firebase_options.dart';
import 'layout/Homelaout.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: MyTHemeData.lightTheme,
      themeMode: ThemeMode.light,
      initialRoute: HomeLayout.routeName,
      routes: {
        HomeLayout.routeName: (context) => HomeLayout(),
        CategoryView.routeName:(context)=>CategoryView(),
        MoviesDetilsScreen.routeName:(context)=>MoviesDetilsScreen()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

