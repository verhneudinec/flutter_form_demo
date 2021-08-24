import 'package:flutter/material.dart';

class RegistrationForrmScreen extends StatefulWidget {
  const RegistrationForrmScreen({Key key}) : super(key: key);

  @override
  _RegistrationForrmScreenState createState() =>
      _RegistrationForrmScreenState();
}

class _RegistrationForrmScreenState extends State<RegistrationForrmScreen> {
  bool _hidePassword = true;

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _aboutController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registration form"),
      ),
      body: Form(
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
                labelText: "Full name *",
                hintText: "What do people call you?",
                suffixIcon: Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                icon: Icon(Icons.ac_unit_outlined),
                prefixIcon: Icon(Icons.call),
                labelText: "Phone number *",
                helperText: "Phone format: (XXX) XXX - XXXX",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration:
                  InputDecoration(labelText: "Email adress *", hintText: "@"),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _aboutController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: "About me *",
                hintText: "Tell us about ur self",
                helperText: "Keep it short",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _passwordController,
              obscureText: _hidePassword,
              maxLength: 8,
              decoration: InputDecoration(
                labelText: "Password *",
                hintText: "Enter the password",
                suffixIcon: IconButton(
                  icon: Icon(
                      _hidePassword ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _hidePassword = !_hidePassword;
                    });
                  },
                ),
                icon: Icon(Icons.security),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _passwordController,
              obscureText: _hidePassword,
              decoration: InputDecoration(labelText: "Confirm password *"),
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () {
                print(_nameController.text);
                print(_phoneController.text);
                print(_emailController.text);
                print(_aboutController.text);
                print(_passwordController.text);
              },
              child: Text("Submit form"),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _aboutController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }
}
