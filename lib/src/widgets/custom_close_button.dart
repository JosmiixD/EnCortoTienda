import 'package:flutter/material.dart';

class CustomCloseButton extends StatelessWidget {


  final VoidCallback onPressed;

  const CustomCloseButton({Key key, @required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon( Icons.close, size: 18),
      onPressed: this.onPressed,
    );
  }
}