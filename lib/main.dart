import 'package:flutter/material.dart';
import 'package:flutter_mobx_demo/screens/home.dart';
import 'package:flutter_mobx_demo/screens/riverpod_home.dart';
import 'package:flutter_mobx_demo/screens/riverpod_user_details.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

MyApp mobXApp() => const MyApp(home: Home());
ProviderScope riverPodApp() => const ProviderScope(child: MyApp(home: RiverpodHome()));

void main() {
  runApp(riverPodApp());
}

class MyApp extends StatelessWidget {
  final Widget home;

  const MyApp({required this.home, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text('Riverpod State Management Demo')
        ),
        body: home,
      )
    );
  }
}