import 'package:flutter/material.dart';
import 'package:validacionforms1_udemy/providers/login_form_provider.dart';
import 'package:validacionforms1_udemy/widgets/widgets.dart';
import 'package:validacionforms1_udemy/ui/input_decorations.dart';
import 'package:provider/provider.dart';


class LoginScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              
              SizedBox(height: 160,),

              CardContainer(
                
                child: Column(

                  children: [
                  
                    SizedBox(height: 10,),
                  
                    Text('Login', style: Theme.of(context).textTheme.headline4,),
                  
                    SizedBox(height: 30,),

                    //V201
                    ChangeNotifierProvider(
                      create: ( _ ) => LoginFormProvider(),
                      child: _LoginForm(),
                    ),  

                  ],
                )
              ),

              SizedBox(height: 50,),

              Text('Crear cuenta nueva', style: TextStyle( fontSize: 18, fontWeight: FontWeight.bold)),

              SizedBox(height: 50,),

            ],
          ),
        ),
      ),

   );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //Despues de envolver el LoginForm en el ChangeNotifierProvider
    // busca la instanaica de LoginFormProvider
    final loginForm = Provider.of<LoginFormProvider>(context);
    // con el loginForm tengo acceso a lo que la clase LoginFormProvider oferce

    return Container(
      child: Form(
        // ignore: todo
        //TODO mantener referencia al Key
        //v201 mantener estado 
        
        //V201
        key: loginForm.formKey,
        //v200
        autovalidateMode: AutovalidateMode.onUserInteraction,


        child: Column(
          children: [

            TextFormField( //Email

              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                hintText: 'lsalander@gmail.com',
                labelText: 'Correo electrónico',
                prefixIcon: Icons.alternate_email_sharp
              ),
              onChanged: (value){
                loginForm.email = value ;
              },
              validator: ( value ) {

                String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp  = new RegExp(pattern);

                return regExp.hasMatch(value ?? '')
                  ? null
                  : 'Correo incorrecto';

              },
            ),
            
            SizedBox( height:  20 ,),

            TextFormField(
              autocorrect: false,
              obscureText: true,

              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                hintText: '*******',
                labelText: 'Contraseña',
                prefixIcon: Icons.lock_open_outlined
              ),
              onChanged: (value ){
                loginForm.password = value;

              },
              validator: ( value ) {

                return ( value != null && value.length >= 6 ) 
                  ? null
                  : 'Contraseña mayor a 6 caractéres';

              },
            ),

            SizedBox( height:  20 ,),

            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
              ),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.deepPurple,
              child: Container(
                child: Text(
                  //v202 revision is loading
                  loginForm.isLoading
                    ? 'Espere'
                    : 'Ingresar',
                    style: TextStyle(color: Colors.white),

                ),
                padding: EdgeInsets.symmetric( horizontal: 80 , vertical: 15 ),
              ),
              //Para desactivar un boton en onPressed debe ser null, si esta cargando regresa null.
              //tambien se cambia a async
              onPressed: loginForm.isLoading ? null : () async {


                //Quitar el teclado
                FocusScope.of(context).unfocus();

                //v202 cambiar el texto, mientras hace la peticion muestra espere
                if (!loginForm.isValidForm()) return;

                //confirmacion de isLoading
                loginForm.isLoading = true;
                
                //fingir la pepticion 2 segundos
                await Future.delayed(Duration(seconds: 2));

                //regresa el _isLoading en false
                loginForm.isLoading = false;
                 
                //v202 se quita esto en la confirmacion de arriba
                Navigator.pushReplacementNamed( context , 'home' );

                


              },
            
            )

          ],
        )
      ),
    );
  }
}