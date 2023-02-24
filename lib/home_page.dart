import 'package:flutter/material.dart';
import 'package:supabase_auth/signin_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                // ログアウトするボタン.
                await Supabase.instance.client.auth.signOut();
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const SigninPage()));
              },
              icon: const Icon(Icons.logout)),
        ],
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Wolcome!',
              style: TextStyle(fontSize: 50),
            )
          ],
        ),
      ),
    );
  }
}
