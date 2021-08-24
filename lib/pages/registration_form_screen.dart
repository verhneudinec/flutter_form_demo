import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reborn_interaction_with_user_demo/model/user.dart';
import 'package:reborn_interaction_with_user_demo/pages/user_info_screen.dart';

class RegistrationForrmScreen extends StatefulWidget {
  const RegistrationForrmScreen({Key key}) : super(key: key);

  @override
  _RegistrationForrmScreenState createState() =>
      _RegistrationForrmScreenState();
}

class _RegistrationForrmScreenState extends State<RegistrationForrmScreen> {
  bool _hidePassword = true;

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _aboutController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  final _nameFocus = FocusNode();
  final _phoneFocus = FocusNode();
  final _passwordFocus = FocusNode();

  final List<String> _countries = [
    'Russia',
    'Ukraine',
    'Germany',
    'Japan',
  ];

  String _selectedCountry;

  User userData = User();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
              focusNode: _nameFocus,
              autofocus: true,
              onFieldSubmitted: (_) {
                _fieldFocusChange(
                  context,
                  _nameFocus,
                  _phoneFocus,
                );
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
                labelText: "Full name *",
                hintText: "What do people call you?",
                suffixIcon: GestureDetector(
                  onTap: () => _nameController.clear(),
                  child: Icon(
                    Icons.delete_outline,
                    color: Colors.red,
                  ),
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
              onSaved: (value) => userData.name = value,
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              focusNode: _phoneFocus,
              onFieldSubmitted: (_) {
                _fieldFocusChange(
                  context,
                  _phoneFocus,
                  _passwordFocus,
                );
              },
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
                //FilteringTextInputFormatter.digitsOnly,
                FilteringTextInputFormatter(
                  RegExp(r'^[()\d \- ]{1,20}$'),
                  allow: true,
                ),
              ],
              validator: (value) => _validatePhoneNumber(value)
                  ? null
                  : 'Phone number must be entered as (XXX)XXX-XXXX',
              onSaved: (value) => userData.phone = value,
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration:
                  InputDecoration(labelText: "Email adress *", hintText: "@"),
              //validator: _validateEmail,
              onSaved: (value) => userData.email = value,
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
              onSaved: (value) => userData.story = value,
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
              onSaved: (value) => userData.country = value,
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _passwordController,
              obscureText: _hidePassword,
              focusNode: _passwordFocus,
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
                _submitForm();
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

  void _fieldFocusChange(
    BuildContext context,
    FocusNode currentFocus,
    FocusNode nextFocus,
  ) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  void _submitForm() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      print(_nameController.text);
      print(_phoneController.text);
      print(_emailController.text);
      print(_aboutController.text);
      print(_passwordController.text);

      _showDialog(name: _nameController.text);
    } else {
      _showMessage(message: "Form is not valid");
    }
  }

  void _showMessage({
    String message,
  }) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        duration: Duration(seconds: 5), // провисит 5 секунд
        backgroundColor: Colors.red,
        content: Text(message),
      ),
    );
  }

  void _showDialog({String name}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Registration successful'),
          content: Text('$name, hello!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserInfoScreen(userData: userData),
                  ),
                );
              },
              child: Text('Verified'),
            ),
          ],
        );
      },
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

    _nameFocus.dispose();
    _phoneFocus.dispose();
    _passwordFocus.dispose();

    super.dispose();
  }
}
