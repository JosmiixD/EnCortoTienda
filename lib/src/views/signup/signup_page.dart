
import 'package:en_corto_tienda/src/services/auth_service.dart';
import 'package:en_corto_tienda/src/theme/constants.dart';
import 'package:en_corto_tienda/src/views/signup/signup_steps/phone_page.dart';
import 'package:en_corto_tienda/src/widgets/custom_back_button.dart';
import 'package:en_corto_tienda/src/widgets/custom_button.dart';
import 'package:en_corto_tienda/src/widgets/custom_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';


class SignUpPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () {
        Provider.of<AuthService>(context, listen: false).disposeForm();
        Navigator.of(context).pop();
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          leading: CustomBackButton(
            onPressed: () {
              Provider.of<AuthService>(context, listen: false).disposeForm();
              Navigator.of(context).pop();
            },
          ),
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildWelcomeMessage( size ),
              SizedBox( height: size.height * 0.02 ),
              _SignUpForm()
            ],
          )
        ),
      ),
    );
  }

    Widget _buildWelcomeMessage( Size size) {

    return Container(
      padding: EdgeInsets.symmetric( horizontal: 20),
      width: size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Crea tu cuenta', style: TextStyle( fontSize: 25, fontWeight: FontWeight.w600, color: Colors.black)),
          SizedBox( height: 10 ),
          Text('Ingresa correctamente tu información y comienza a ofrecer el mejor servicio a tus potenciales clientes', style: TextStyle( fontSize: 14,fontWeight: FontWeight.w400, color: nixEnCortoMutedColor))
        ],
      )
    );

  } 
}

class _SignUpForm extends StatefulWidget {
  const _SignUpForm({ Key key }) : super(key: key);

  @override
  __SignUpFormState createState() => __SignUpFormState();
}

class __SignUpFormState extends State<_SignUpForm> {

  final nameController                  = TextEditingController();
  final lastNameController              = TextEditingController();
  final emailController                 = TextEditingController();
  final passwordController              = TextEditingController();
  final passwordConfirmationController  = TextEditingController();

  final _signUpKey                      = GlobalKey<FormState>();

  @override
  void initState() {
    final formService = Provider.of<AuthService>(context, listen: false);
    nameController.text = formService.ownerName;
    lastNameController.text = formService.ownerLastName;
    emailController.text = formService.email;
    passwordController.text = formService.password;
    passwordConfirmationController.text = formService.passwordConfirmation;
    print('Signup init');
    super.initState();
  }

  @override
  void dispose() { 
    nameController?.dispose();
    lastNameController?.dispose();
    emailController?.dispose();
    passwordController?.dispose();
    passwordConfirmationController?.dispose();
    print('Signup dispose');
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;
    final authService = Provider.of<AuthService>(context);

    return Form(
      key: _signUpKey,
      child: Container(
        padding: EdgeInsets.symmetric( horizontal: 20 ),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              CustomInput(
                hintText: 'Nombre del propietario',
                controller: nameController,
                prefixIcon: FontAwesomeIcons.user,
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.words,
                validator: ( value ) {
                  if( value.isEmpty ) {
                    return 'Debe ingresar su nombre';
                  }
                  return null;
                },
              ),
              SizedBox( height: 20),
              CustomInput(
                hintText: 'Apellidos',
                controller: lastNameController,
                prefixIcon: FontAwesomeIcons.user,
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.words,
                validator: ( value ) {
                  if( value.isEmpty ) {
                    return 'Debe ingresar sus apellidos';
                  }
                  return null;
                },
              ),
              SizedBox( height: 20),
              CustomInput(
                hintText: 'Correo electronico',
                controller: emailController,
                prefixIcon: FontAwesomeIcons.envelope,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                validator: ( value ) {

                  if( value.isEmpty ) {
                    return 'Ingrese su correo electronico';
                  } else {
                    bool emailValid = RegExp(
                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                    .hasMatch(value);

                    if( !emailValid ) {
                      return 'El correo no cumple el formato example@example.com';
                    }
                    return null;
                  }

                },
              ),
              SizedBox( height: 20),
              CustomInput(
                hintText: 'Contraseña',
                controller: passwordController,
                prefixIcon: Icons.lock_outline,
                textInputAction: TextInputAction.next,
                prefixIconSize: 22,
                isPassword: true,
                validator: ( value ) {
                  if( value.isEmpty ) {
                    return 'Debe ingresar una contraseña';
                  }
                  return null;
                },
              ),
              SizedBox( height: 20),
              CustomInput(
                hintText: 'Confirmar contraseña',
                controller: passwordConfirmationController,
                prefixIcon: Icons.lock_outline,
                textInputAction: TextInputAction.done,
                prefixIconSize: 22,
                isPassword: true,
                validator: ( value ) {
                  if( value.isEmpty ){
                    return 'Ingrese nuevamente la contraseña';
                  } else {
                    if( value != passwordController.text.trim() ) {
                      return 'Las contraseñas no coinciden';
                    }
                    return null;
                  }
                },
              ),
              SizedBox( height: 30 ),
              CustomButton(
                text: 'Continuar',
                onPressed: (){

                  FocusScope.of(context).unfocus();
                  if( _signUpKey.currentState.validate() ) {

                    authService.ownerName = nameController.text.trim();
                    authService.ownerLastName = lastNameController.text.trim();
                    authService.email = emailController.text.trim();
                    authService.password = passwordController.text.trim();
                    authService.passwordConfirmation = passwordConfirmationController.text.trim();
                    
                    Navigator.of(context).push( CupertinoPageRoute(
                      builder: ( context ) => PhonePage()
                    ));
                  }

                },
                
              ),
              SizedBox( height: 20 ),
              InkWell(
                child: RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(text: 'Ya tienes una cuenta? '),
                      TextSpan(text: 'Ingresa', style: nixEnCortoLinkStyle),
                    ]
                  )
                ),
                onTap: (){
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        )
      ),
    );
  }
}