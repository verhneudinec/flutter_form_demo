import 'package:flutter/material.dart';
import 'package:reborn_interaction_with_user_demo/model/user.dart';

class UserInfoScreen extends StatelessWidget {
  User userData = User();

  UserInfoScreen({this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User info'),
      ),
      body: Card(
        margin: EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              title: Text('${userData.name}'),
              subtitle: Text('${userData.story}'),
              leading: Icon(Icons.person),
              trailing: Text("${userData.country}"),
            ),
            ListTile(
              title: Text('${userData.phone}'),
              leading: Icon(Icons.phone),
            ),
            ListTile(
              title: Text(
                  '${userData.email.isNotEmpty ? userData.email : 'Not specified'}'),
              leading: Icon(Icons.email),
            ),
          ],
        ),
      ),
    );
  }
}
