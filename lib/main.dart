import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:vocab/provider/database_listener.dart';
import 'screens/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DatabaseListener(),
      child: const MaterialApp(
        home: MyHome(),
      ),
    );
  }
}
