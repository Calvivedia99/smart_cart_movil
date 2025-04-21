import 'package:flutter/material.dart';
import 'package:smart_cart_movil/modules/auth/screens/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartCart',
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}

// ballivian02@gmail.com


// import 'package:flutter/material.dart';
// import 'package:smart_cart_movil/modules/auth/screens/login_screen.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'SmartCart',
//       debugShowCheckedModeBanner: false,
//       home: const LoginScreen(), // Cambiado a LoginScreen
//     );
//   }
// }