import 'package:flutter/material.dart';
import 'package:talkgpt/homepage.dart';
import 'package:talkgpt/loginpage.dart';
import 'package:talkgpt/pallete.dart';

void main() {
  runApp(const MyApp());
}

    class MyApp extends StatelessWidget {
      const MyApp({super.key});

      @override
      Widget build(BuildContext context) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "TalkGpt",
          theme: ThemeData.light(useMaterial3: true).copyWith(
            scaffoldBackgroundColor: Pallete.whiteColor,
                appBarTheme: AppBarTheme(
              backgroundColor: Pallete.whiteColor,
          )
          ),
          home: loginpage(),
        );
      }
    }

