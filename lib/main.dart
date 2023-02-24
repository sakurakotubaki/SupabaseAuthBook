import 'package:flutter/material.dart';
import 'package:supabase_auth/signin_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // URLとanon keyの設定をする
  await Supabase.initialize(
    url: 'https://phcevaqoenyuqtuktkbb.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBoY2V2YXFvZW55dXF0dWt0a2JiIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzcyNDUzNjQsImV4cCI6MTk5MjgyMTM2NH0.YKGic5SB-idx7FS97T2_ybHSb50eL1_KlS1M5_84-q0',
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          // テーマを使ってAppBar全体にスタイルを適用する.
          appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black54,
        foregroundColor: Colors.grey,
        centerTitle: true, // AndroidでAppbarのタイトルを中央寄せにする.
      )),
      home: const SigninPage(),
    );
  }
}
