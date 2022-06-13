import 'package:bookmarker/screens/homeScreen.dart';
import 'package:bookmarker/screens/bookmarkListScreen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:lottie/lottie.dart';

class AuthCheck extends StatelessWidget {
  const AuthCheck({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return SignInScreen(
              providerConfigs: const [EmailProviderConfiguration()],
              headerBuilder: (context, constraints, _) {
                return Lottie.network(
                  'https://assets7.lottiefiles.com/datafiles/SkdS7QDyJTKTdwA/data.json',
                );
              },
            );
          }

          return HomeScreen(
            user: snapshot.data!,
          );
        });
  }
}
