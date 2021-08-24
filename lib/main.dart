import 'package:flutter/material.dart';
import 'package:reborn_interaction_with_user_demo/pages/registration_form_screen.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RegistrationForrmScreen(),
    );
  }
}
