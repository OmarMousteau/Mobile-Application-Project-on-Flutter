//import 'dart:js';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_signin/screens/home_screen.dart';
import 'package:login_signin/screens/registration_screen.dart';
import 'package:login_signin/screens/resetpassword.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({ Key? key }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  // form key
  final _formKey= GlobalKey<FormState>();

  // editing controller
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();


  // firebase
  final _auth = FirebaseAuth.instance;




  @override
  Widget build(BuildContext context) {

    //email field
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value)
      {
        if(value!.isEmpty)
        {
          return ("Veuillez entrer votre E-mail");
        }
        // reg expression for email validation
        if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
          .hasMatch(value))  {
          return ("Veuillez entrer un Email valide");
        }
        return null;
      },
      onSaved: (value)
      {
        emailController.text = value! ;

      },
      textInputAction : TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.mail),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "E-mail",
        border: OutlineInputBorder(
          borderRadius : BorderRadius.circular(10)
        )
      )
    );


    //password field
    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordController,
      obscureText : true, // Hidden Password

      validator:(value)
      {
        RegExp regex =  new RegExp(r'^.{6,}$');
        if(value!.isEmpty)
        {
          return ('Veuillez entrer votre mot de passe');
        }
        if(!regex.hasMatch(value))
        {
          return ("Veuillez entrer un mot de passe valide (minimum 6 caractères");
        }
      },
      onSaved: (value)
      {
        passwordController.text = value! ;

      },
      textInputAction : TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.vpn_key),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Mot de passe",
        border: OutlineInputBorder(
          borderRadius : BorderRadius.circular(10) 
        )
      )
    );



    final loginButton = Material(
      elevation : 5,
      borderRadius: BorderRadius.circular(30),
      color: Color.fromARGB(255, 79, 187, 179),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () { 
          signIn(emailController.text, passwordController.text);
        },
        child : Text("Se connecter", textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, color: Colors.white,fontWeight: FontWeight.bold),
        )),
      );





    return Scaffold(
      backgroundColor: Colors.white,
      body : Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment : MainAxisAlignment.center,
                  crossAxisAlignment : CrossAxisAlignment.center,
                  children: <Widget>[

                    SizedBox(
                      height: 200,
                      child: Image.asset("assets/Welcome.png",
                      fit: BoxFit.contain,
                    
                    )),
                    SizedBox(height : 28),
                    emailField,
                    SizedBox(height : 25),
                    passwordField,
                    SizedBox(height : 35),
                    loginButton,
                    SizedBox(height : 1),
                    TextButton(
                                onPressed: (){
                                   Navigator.push(
                                   context, 
                                   MaterialPageRoute(                                    builder: (context) =>
                                    ResetPassword()));
                    }, 
                              child: Text('Mot de passe oublié?', 
                                                style: TextStyle(
                                                color : Color.fromARGB(255, 117, 2, 2),
                                                fontWeight: FontWeight.bold, 
                                                fontSize: 15)
                                              )
                                            ),
                    SizedBox(height : 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: <Widget>[
                        Text("Pas encore de compte? "),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context, 
                              MaterialPageRoute(
                                builder: (context) =>
                                  RegistrationScreen()));
                          },
                          child: Text(
                            "S'inscire",
                             style: TextStyle(
                              color : Color.fromARGB(255, 72, 172, 165),
                              fontWeight: FontWeight.bold, 
                              fontSize: 15),
                          ),
                        )
                      ]) 
                  ],
              ),
          ),
            ),
        ),
      ) ,
    )
  );
  }


  // logIn function
  void signIn(String email, String password) async
  {
    if(_formKey.currentState!.validate())
    {
      await _auth.signInWithEmailAndPassword(email: email, password: password)
        .then((uid) => {
          Fluttertoast.showToast(msg : "Connexion réussie"),
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> HomeScreen()))
          
        }).catchError((e)
        {
          Fluttertoast.showToast(msg: "Mail ou Mot de passe incorrect");
          
        });
    }
  }

}