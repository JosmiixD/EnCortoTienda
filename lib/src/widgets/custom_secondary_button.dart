import 'package:en_corto_tienda/src/theme/constants.dart';
import 'package:flutter/material.dart';

class CustomSecondaryButton extends StatelessWidget {
  const CustomSecondaryButton({
    Key key,
    @required this.text,
    @required this.onPressed,
    this.backgroundColor = Colors.white,
    this.borderColor = nixEnCortoPrimaryColor,
    this.textColor = nixEnCortoPrimaryColor,
    this.radius = 5,
  }) : super(key: key);

  final String text;
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
  final double radius;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        primary: this.backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular( this.radius ),
          side: BorderSide(
            color: this.borderColor,
          )
        )
      ),
      child: Container(
        width: double.infinity,
        height: 50,
        child: Center(
          child: Text( this.text, style: TextStyle( color: this.textColor ),),
        ),
      ),
      onPressed: this.onPressed,
    );
  }
}