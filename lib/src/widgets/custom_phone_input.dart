import 'package:en_corto_tienda/src/theme/constants.dart';
import 'package:flutter/material.dart';

class CustomPhoneInput extends StatefulWidget {

  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;
  final TextInputAction textInputAction;
  final FormFieldValidator<String> validator;
  final bool isPassword;
  final int maxLines;
  final TextStyle textStyle;
  
  const CustomPhoneInput({
    Key key,
    @required this.hintText,
    @required this.controller,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction = TextInputAction.done,
    this.validator,
    this.textStyle = const TextStyle( fontSize: 16 ),
    this.maxLines = 1,
  }) : super(key: key);

  @override
  _CustomPhoneInputState createState() => _CustomPhoneInputState();
}

class _CustomPhoneInputState extends State<CustomPhoneInput> {

  bool showPassword = false;

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all( 2 ),
          child: TextFormField(
            maxLines: this.widget.maxLines,
            validator: this.widget.validator != null ? this.widget.validator : ( value ) {
              if( value.isEmpty ) {
                return 'Ingrese un valor al campo';
              }
              return null;
            } ,
            style: this.widget.textStyle,
            controller: this.widget.controller,
            cursorColor: nixEnCortoPrimaryColor,
            autocorrect: false,
            keyboardType: this.widget.keyboardType,
            textCapitalization: this.widget.textCapitalization,
            textInputAction: this.widget.textInputAction,
            obscureText: this.widget.isPassword ? this.showPassword ? false : true : false, 
            decoration: InputDecoration(
              prefixIcon: Align(
                widthFactor: 1.2,
                alignment: Alignment.centerLeft,
                child: Text('🇲🇽 +52')
              ),
              hintText: this.widget.hintText,
              border: UnderlineInputBorder(
                borderSide: BorderSide( color: nixEnCortoMutedColor)
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide( color: nixEnCortoMutedColor)
              ),
              errorBorder: UnderlineInputBorder(
                borderSide: BorderSide( color: nixEnCortoDangerColor)
              ),
              errorStyle: TextStyle(
                color: nixEnCortoDangerColor
              ),
            ),
          ),
        ),
      ],
    );
  }
}