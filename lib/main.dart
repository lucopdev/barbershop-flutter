import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:barbearia_dos_brabos/_common/my_colors.dart';
import 'package:barbearia_dos_brabos/pages/login_page.dart';
import 'package:barbearia_dos_brabos/pages/main_page.dart';
import 'package:flutter/services.dart';
import 'firebase_options.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(UserRegApp());
}

class UserRegApp extends StatelessWidget {
  final ThemeData tema = ThemeData();
  UserRegApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);

    return MaterialApp(
      theme: tema.copyWith(
        canvasColor: MyColors.light,
        colorScheme: tema.colorScheme.copyWith(
          primary: MyColors.primary,
          secondary: MyColors.secondary,
          error: Colors.red,
        ),
        textTheme: tema.textTheme.copyWith(
          headlineSmall: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: MyColors.grey,
          ),
          headlineMedium: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w700,
            color: MyColors.grey,
          ),
          bodySmall: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: MyColors.lightText,
          ),
          bodyMedium: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w700,
            color: MyColors.lightText,
          ),
        ),
      ),
      home: const MyHomeApp(),
    );
  }
}

class MyHomeApp extends StatefulWidget {
  const MyHomeApp({super.key});

  @override
  State<MyHomeApp> createState() => _MyHomeAppState();
}

class _MyHomeAppState extends State<MyHomeApp> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.userChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return MainPage(
            user: snapshot.data!,
          );
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
