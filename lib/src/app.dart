// import 'package:flutter/material.dart';
// import 'package:matp/pages/navpages/main_page.dart';
// import 'package:matp/src/providers/provider.dart';
// import 'package:matp/src/screens/forgot_password.dart';
// import 'package:matp/src/screens/home_screen.dart';
// import 'package:matp/src/screens/login_screen.dart';
// import 'package:matp/src/screens/signup_screen.dart';
// import 'package:matp/src/services/auth_service.dart';

// class App extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Provider(
//       child: MaterialApp(
//         title: "Rest Auth",
//         home: FutureBuilder(
//           future: AuthService.getToken(),
//           builder: (_, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return CircularProgressIndicator();
//             } else if (snapshot.hasData) {
//               return HomeScreen();
//             } else {
//               return LoginScreen();
//             }
//           },
//         ),
//         routes: {
//           '/': (_) => MainPage(),
//           '/login': (_) => new LoginScreen(),
//           '/signup': (_) => new SignupScreen(),
//           '/forgot_password': (_) => new ForgotPassword(),
//         },
//       ),
//     );
//   }
// }
