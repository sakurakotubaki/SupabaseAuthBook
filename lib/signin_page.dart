import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:supabase_auth/home_page.dart';
import 'package:supabase_auth/signup_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Supabaseをインスタンス化する.
final supabase = Supabase.instance.client;

class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  // ログインと新規登録に使用するTextEditingController.
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  //ログイン判定をする変数.
  bool _redirecting = false;

  //ログインをするメソッド.
  Future<void> signInUser(String _email, String _password) async {
    try {
      if (_email.isEmpty) {
        throw ('メールアドレスが入力されていません!');
      }

      if (_password.isEmpty) {
        throw ('パスワードが入力されていません!');
      }

      final AuthResponse res = await supabase.auth
          .signInWithPassword(email: _email, password: _password);
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

  late final StreamSubscription<AuthState> _authSubscription;
  //セッションを使うための変数.
  User? _user;

  // ログインした状態を維持するためのロジック．
  @override
  void initState() {
    _authSubscription = supabase.auth.onAuthStateChange.listen((data) {
      final AuthChangeEvent event = data.event;
      final Session? session = data.session;
      // ユーザーがログインしているかをifで判定する.
      if (_redirecting) return;
      if (session != null) {
        _redirecting = true;
        // ユーザーがログインしていたら、アプリのページへリダイレクトする.
        // pushAndRemoveUntilは前のページへ戻れないようにするコード.
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const HomePage()),
            (route) => false);
      }
      setState(() {
        _user = session?.user;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _authSubscription.cancel();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LoginPage'),
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
              onPressed: () {
                //　ログイン用ボタン
                signInUser(_email.text, _password.text);
              },
              child: const Text('ログイン'),
            ),
            ElevatedButton(
              // 新規登録用のボタン.
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SignupPage()));
              },
              child: const Text('新規登録ページ'),
            ),
          ],
        ),
      ),
    );
  }
}
