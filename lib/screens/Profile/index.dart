import "package:flutter/material.dart";


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key key}) : super(key: key);

  @override
  ProfileState createState() => new ProfileState();
}

class ProfileState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return  Text('Profile', style: TextStyle(fontSize: 20));
  }
}
