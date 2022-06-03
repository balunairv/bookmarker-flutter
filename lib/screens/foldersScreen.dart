import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class FolderScreen extends StatefulWidget {
  const FolderScreen({Key? key}) : super(key: key);

  @override
  State<FolderScreen> createState() => _FolderScreenState();
}

class _FolderScreenState extends State<FolderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: 12,
        itemBuilder: (context, index) {
          return Container(
            color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Lottie.network(
                    'https://assets1.lottiefiles.com/packages/lf20_5hyqudpp.json'),
                const Text("Folder Name")
              ],
            ),
          );
        },
        padding: const EdgeInsets.all(10),
      )),
    );
  }
}
