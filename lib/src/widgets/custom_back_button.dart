import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {

  final VoidCallback onPressed;

  const CustomBackButton({Key key, @required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Image.asset('assets/img/icons/arrow_left.png', width: 20),
      onPressed: this.onPressed
    );
  }
}