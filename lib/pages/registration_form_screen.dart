import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegistrationForrmScreen extends StatefulWidget {
  const RegistrationForrmScreen({Key key}) : super(key: key);

  @override
  _RegistrationForrmScreenState createState() =>
      _RegistrationForrmScreenState();
}

class _RegistrationForrmScreenState extends State<RegistrationForrmScreen> {
  bool _hidePassword = true;

  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _aboutController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  final List<String> _countries = [
    'Russia',
    'Ukraine',
    'Germany',
    'Japan',
  ];

  String _selectedCountry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registration form"),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            TextFormField(
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
              validator: _validateName,
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
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                FilteringTextInputFormatter(
                  RegExp(r'^[()\d - ]{1,20}$'),
                  allow: true,
                ),
              ],
              validator: (value) => _validatePhoneNumber(value)
                  ? null
                  : 'Phone number must be entered as (XXX)XXX-XXXX',
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration:
                  InputDecoration(labelText: "Email adress *", hintText: "@"),
              validator: _validateEmail,
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
              inputFormatters: [
                LengthLimitingTextInputFormatter(100),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            DropdownButtonFormField(
              items: _countries.map((country) {
                return DropdownMenuItem(
                  child: Text(country),
                  value: country,
                );
              }).toList(),
              onChanged: (data) {
                print(data);
                setState(() {
                  _selectedCountry = data;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                icon: Icon(Icons.map),
                labelText: 'Country?',
              ),
              value: _selectedCountry,
              validator: (val) {
                return val == null ? 'Please select a country' : null;
              },
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
              validator: _validatePassword,
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _confirmController,
              obscureText: _hidePassword,
              decoration: InputDecoration(labelText: "Confirm password *"),
              validator: _validatePassword,
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();

                  print(_nameController.text);
                  print(_phoneController.text);
                  print(_emailController.text);
                  print(_aboutController.text);
                  print(_passwordController.text);
                } else
                  print("Form is not valid");
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

  String _validateName(String value) {
    final _nameExp = RegExp(r'^[A-Za-z]+$');
    if (value.isEmpty)
      return 'Name is required';
    else if (!_nameExp.hasMatch(value)) {
      return 'Please enter alphabetical characters.';
    } else
      return null;
  }

  bool _validatePhoneNumber(String input) {
    final _phoneExp = RegExp(r'^\(\d\d\d\)\d\d\d\-\d\d\d\d$');
    return _phoneExp.hasMatch(input);
  }

  String _validateEmail(String value) {
    if (value.isEmpty) {
      return 'Email cannot be empty';
    } else if (!_emailController.text.contains('@')) {
      return 'Invalid email adress';
    } else {
      return null;
    }
  }

  String _validatePassword(String value) {
    if (_passwordController.text.length < 8) {
      return '8 characters required for password';
    } else if (_confirmController.text != _passwordController.text) {
      return 'Passwords does not match';
    } else {
      return null;
    }
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
