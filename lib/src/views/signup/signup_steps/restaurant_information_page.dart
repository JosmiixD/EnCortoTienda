import 'package:en_corto_tienda/src/services/auth_service.dart';
import 'package:en_corto_tienda/src/theme/constants.dart';
import 'package:en_corto_tienda/src/widgets/custom_button.dart';
import 'package:en_corto_tienda/src/widgets/custom_close_button.dart';
import 'package:en_corto_tienda/src/widgets/custom_input.dart';
import 'package:en_corto_tienda/src/widgets/custom_secondary_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RestaurantInformationPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: CustomCloseButton(
          onPressed: () {
            Provider.of<AuthService>(context, listen: false).disposeForm();
            Navigator.of(context).popUntil( ModalRoute.withName('login'));
          },
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildWelcomeMessage( size ),
            SizedBox( height: size.height * 0.02 ),
            _RestaurantForm()
          ],
        ),
      )
    );
  }

  Widget _buildWelcomeMessage( Size size ) {

    return Container(
      padding: EdgeInsets.symmetric( horizontal: 20),
      width: size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Información del restaurante', style: TextStyle( fontSize: 25, fontWeight: FontWeight.w600, color: Colors.black)),
          SizedBox( height: 10 ),
          Text('Dinos como tus clientes podran encontrar tu negocio', style: TextStyle( fontSize: 14,fontWeight: FontWeight.w400, color: nixEnCortoMutedColor))
        ],
      )
    );
  } 
}


class _RestaurantForm extends StatefulWidget {

  @override
  __RestaurantFormState createState() => __RestaurantFormState();
}

class __RestaurantFormState extends State<_RestaurantForm> {

  final nameController = new TextEditingController();
  final addressController = new TextEditingController();
  final latlngController = new TextEditingController();
  final _restaurantKey = GlobalKey<FormState>();

  @override
  void initState() {
    final formService = Provider.of<AuthService>(context, listen: false);
    nameController.text = formService.businessName;
    addressController.text = formService.businessAddress;
    latlngController.text = formService.latlng;
    super.initState();
  }

  @override
  void dispose() {
    nameController?.dispose();
    addressController?.dispose();
    latlngController?.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);

    return Form(
      key: _restaurantKey,
      child: Container(
        padding: EdgeInsets.symmetric( horizontal: 20),
        child: Column(
            children: [
              CustomInput(
                hintText: 'Nombre',
                controller: nameController,
                prefixIcon: Icons.storefront_rounded,
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.words,
                validator: ( value ) {
                  if( value.isEmpty ) {
                    return 'Debe ingresar el nombre de su negocio';
                  }
                  return null;
                },
              ),
              SizedBox( height: 20),
              CustomInput(
                hintText: 'Dirección',
                controller: addressController,
                prefixIcon: Icons.place_outlined,
                textInputAction: TextInputAction.done,
                textCapitalization: TextCapitalization.sentences,
                validator: ( value ) {
                  if( value.isEmpty ) {
                    return 'Debe ingresar la dirección de su negocio';
                  }
                  if( value.length < 10 ) {
                    return 'La dirección es muy corta';
                  }
                  return null;
                },
              ),
              SizedBox( height: 20),
              CustomInputLocationPicker(
                hintText: 'Localizar en el mapa',
                controller: addressController,
                prefixIcon: Icons.my_location,
              ),
              // CustomInput(
              //   hintText: 'Localizar mi dirección',
              //   controller: addressController,
              //   prefixIcon: Icons.my_location,
              //   validator: ( value ) {
              //     return null;
              //   },
              // ),
              SizedBox( height: 30,),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: CustomSecondaryButton(
                      text: 'Atras',
                      onPressed: () {
          
                        if( nameController.text.length != 0 ) {
                          authService.businessName = nameController.text.trim();
                        }
                        if( addressController.text.length != 0 ) {
                          authService.businessAddress = addressController.text.trim();
                        }

                        Navigator.of(context).pop();

                      },
                    )
                  ),
                  SizedBox( width: 5,),
                  Expanded(
                    flex: 3,
                    child: CustomButton(
                      text: 'Continuar',
                      onPressed: (){

                        FocusScope.of(context).unfocus();
                        if( _restaurantKey.currentState.validate() ) {

                          authService.businessName = nameController.text.trim();
                          authService.businessAddress = addressController.text.trim();
                          
                          Navigator.of(context).push( CupertinoPageRoute(
                            builder: ( context ) => RestaurantInformationPage()
                          ));
                        }

                      },
                    ),
                  ),
                ],
              ),
            ],
        )
      )
    );
  }
}

class CustomInputLocationPicker extends StatelessWidget {

  final String hintText;
  final TextEditingController controller;
  final int maxLines;
  final IconData prefixIcon;
  final TextStyle textStyle;
  final double prefixIconSize;
  final VoidCallback onTap;
  
  const CustomInputLocationPicker({
    Key key,
    @required this.hintText,
    @required this.controller,
    @required this.prefixIcon,
    @required this.onTap,
    this.textStyle = const TextStyle( fontSize: 16 ),
    this.maxLines = 1,
    this.prefixIconSize = 18
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all( 2 ),
      child: TextFormField(
        style: this.textStyle,
        controller: this.controller,
        cursorColor: nixEnCortoPrimaryColor,
        autocorrect: false,
        decoration: InputDecoration(
          prefixIcon: Icon( this.prefixIcon, size: this.prefixIconSize, color: Colors.grey),
          hintText: this.hintText,
          focusColor: Colors.red,
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
        onTap: this.onTap,
      ),
    );
  }
}