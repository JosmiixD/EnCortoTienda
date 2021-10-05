import 'package:en_corto_tienda/src/services/auth_service.dart';
import 'package:en_corto_tienda/src/theme/constants.dart';
import 'package:en_corto_tienda/src/views/signup/signup_steps/restaurant_information_page.dart';
import 'package:en_corto_tienda/src/widgets/custom_button.dart';
import 'package:en_corto_tienda/src/widgets/custom_close_button.dart';
import 'package:en_corto_tienda/src/widgets/custom_phone_input.dart';
import 'package:en_corto_tienda/src/widgets/custom_secondary_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class PhonePage extends StatefulWidget {
  const PhonePage({ Key key }) : super(key: key);

  @override
  _PhonePageState createState() => _PhonePageState();
}

class _PhonePageState extends State<PhonePage> {
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
        )
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildWelcomeMessage( size ),
            SizedBox( height: size.height * 0.02 ),
            _PhoneForm()
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
          Text('Ingrese su numero', style: TextStyle( fontSize: 25, fontWeight: FontWeight.w600, color: Colors.black)),
          SizedBox( height: 10 ),
          Text('Su número telefonico no sera almacenado hasta haberse registrado aceptando nuestros Terminos y Condiciones', style: TextStyle( fontSize: 14,fontWeight: FontWeight.w400, color: nixEnCortoMutedColor))
        ],
      )
    );

  } 

}


class _PhoneForm extends StatefulWidget {
  const _PhoneForm({ Key key }) : super(key: key);

  @override
  _PhoneFormState createState() => _PhoneFormState();
}

class _PhoneFormState extends State<_PhoneForm> {

  final phoneController = TextEditingController();

  final _phoneKey = GlobalKey<FormState>();

  @override
  void initState() {

    final formService = Provider.of<AuthService>(context, listen: false);
    phoneController.text = formService.phone;
    print('Phone init');
    super.initState();
  }

  @override
  void dispose() { 
    phoneController?.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);
    final Size size = MediaQuery.of(context).size;

    return Form(
      key: _phoneKey,
      child: Container(
        padding: EdgeInsets.symmetric( horizontal: 20 ),
        child: Column(
          children: [
            CustomPhoneInput(
              controller: phoneController,
              hintText: 'Numero telefonico',
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.done,
              validator: ( value ) {
                if( value.isEmpty ) {
                  return 'Ingrese su numero telefonico';
                }
                bool validPhone = RegExp(
                        r'^(?:[+0]9)?[0-9]{10}$')
                    .hasMatch(value);

                if( !validPhone ) {
                  return 'Ingrese un numero valido';
                }
                return null;
              },
            ),
            SizedBox( height: 30,),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: CustomSecondaryButton(
                    text: 'Atras',
                    onPressed: () {
        
                      if( phoneController.text.length != 0 ) {
                        authService.phone = phoneController.text.trim();
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
                      if( _phoneKey.currentState.validate() ) {
                        authService.phone = phoneController.text.trim();
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
      ),
    );
  }
}
