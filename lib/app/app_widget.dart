import 'package:chat_medico/app/screens/home_screen.dart';
import 'package:chat_medico/app/screens/home_screen2.dart';
import 'package:flutter/material.dart';


class AppWidget extends StatefulWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,routes: {
      //  '/':(_)=> HomeScreen(),
        '/':(_)=> MyHomePage(),
    },
    );
  }
}
