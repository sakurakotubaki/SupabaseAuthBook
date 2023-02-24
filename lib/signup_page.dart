import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Supabaseをインスタンス化する.
final supabase = Supabase.instance.client;

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  // ログインと新規登録に使用するTextEditingController.
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  //ユーザーの新規登録をするメソッド.
  Future<void> signUpUser(String _email, String _password) async {
    try {
      if (_email.isEmpty) {
        throw ('メールアドレスが入力されていません!');
      }

      if (_password.isEmpty) {
        throw ('パスワードが入力されていません!');
      }

      final AuthResponse res =
          await supabase.auth.signUp(email: _email, password: _password);
      log(res.toString());
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            // throwのエラーメッセージがダイアログで表示される.
            title: Text(e.toString()),
            actions: <Widget>[
              ElevatedButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SignupPage'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _email,
              decoration: InputDecoration(hintText: 'メールアドレスを入力'),
            ),
            TextField(
              controller: _password,
              decoration: InputDecoration(hintText: 'パスワードを入力'),
            ),
            ElevatedButton(
              // 新規登録用のボタン.
              onPressed: () async {
                signUpUser(_email.text, _password.text);
              },
              child: const Text('新規登録'),
            ),
          ],
        ),
      ),
    );
  }
}
