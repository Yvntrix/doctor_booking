import 'package:flutter/material.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({required this.size, required this.initials, super.key});
  final double size;
  final String initials;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: size,
      child: Text(
        initials,
        style: TextStyle(fontSize: size, fontWeight: FontWeight.bold),
      ),
    );
  }
}
