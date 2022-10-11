import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_signin/screens/home_screen.dart';
import 'package:login_signin/screens/login_screen.dart';

import '../model/user_model.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({ Key? key }) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {



  final _auth = FirebaseAuth.instance;

  // our form key
  final _formKey= GlobalKey<FormState>();
  //editing controller
  final fullNameEditingController= new TextEditingController();
  final emailEditingController= new TextEditingController();
  final numberEditingController= new TextEditingController();
  final passwordEditingController= new TextEditingController();
  final confirmPasswordEditingController= new TextEditingController();

  @override
  Widget build(BuildContext context) {


    //Full Name field
    final fullNameField = TextFormField(
      autofocus: false,
      controller: fullNameEditingController,
      keyboardType: TextInputType.name,
      validator:(value)
      {
        RegExp regex =  new RegExp(r'^.{3,}$');
        if(value!.isEmpty)
        {
          return ('Veuillez entrer votre Nom complet');
        }
        if(!regex.hasMatch(value))
        {
          return ("Veuillez entrer un nom valide (minimum 3 caractères");
        }
        return null;
      },
      onSaved: (value)
      {
        fullNameEditingController.text = value! ;

      },
      textInputAction : TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.account_circle),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Prénom & Nom",
        border: OutlineInputBorder(
          borderRadius : BorderRadius.circular(10)
        )
      )
    );



//Phone Number field
    final numberField = TextFormField(
      autofocus: false,
      controller: numberEditingController,
      keyboardType: TextInputType.number,
      validator:(value)
      {
        if(value!.isEmpty)
        {
          return ('Veuillez entrer votre Numéro');
        }
//        if(!regex.hasMatch(value))
//        {
//          return ("Veuillez entrer un nom valide (minimum 3 caractères");
//        }
        return null;
      },
      onSaved: (value)
      {
        numberEditingController.text = value! ;

      },
      textInputAction : TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.phone_iphone),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Téléphone",
        border: OutlineInputBorder(
          borderRadius : BorderRadius.circular(10)
        )
      )
    );



//Email field
    final emailField = TextFormField(
      autofocus: false,
      controller: emailEditingController,
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
        emailEditingController.text = value! ;

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


    //Password field
    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordEditingController,
      obscureText: true,
      validator:(value) {
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
        passwordEditingController.text = value! ;

      },
      textInputAction : TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.vpn_key),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Mot de passe",
        border: OutlineInputBorder(
          borderRadius : BorderRadius.circular(10)
        )
      )
    );



    //Confirm password field
    final confirmPasswordField = TextFormField(
      autofocus: false,
      controller: confirmPasswordEditingController,
      obscureText: true,
      validator: (value)
      {
        if(confirmPasswordEditingController.text !=
         passwordEditingController.text)
          
          {
            return "Les 2 mots de passes ne sont pas identiques";
          }
          return null;
      } ,
      onSaved: (value)
      {
        confirmPasswordEditingController.text = value! ;

      },
      textInputAction : TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.vpn_key),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Confirmer mot de passe",
        border: OutlineInputBorder(
          borderRadius : BorderRadius.circular(10)
        )
      )
    );


    final signupButton = Material(
      elevation : 5,
      borderRadius: BorderRadius.circular(30),
      color: Color.fromARGB(255, 79, 187, 179),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          signUp(emailEditingController.text, passwordEditingController.text);

        },
        child : Text("S'inscrire", textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, color: Colors.white,fontWeight: FontWeight.bold),
        )),
      );


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color.fromARGB(255, 72, 172, 165)),
          onPressed: () {
            //passing this to our our root
            Navigator.of(context).pop();
          }
        ),
      ),
      body : Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(36, 0, 36, 36),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment : MainAxisAlignment.center,
                  crossAxisAlignment : CrossAxisAlignment.center,
                  children: <Widget>[

                    SizedBox(
                      height: 90,
                      child: Image.asset("assets/Welcome.png",
                      fit: BoxFit.contain,
                    
                    )),
                    SizedBox(height : 30),
                    fullNameField,
                    SizedBox(height : 20),
                    numberField,
                    SizedBox(height : 20),
                    emailField,
                    SizedBox(height : 20),
                    passwordField,
                    SizedBox(height : 20),
                    confirmPasswordField,
                    SizedBox(height : 32),
                    signupButton,
                    SizedBox(height : 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: <Widget>[
                        Text("J'ai déjà un compte : "),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context, 
                              MaterialPageRoute(
                                builder: (context) =>
                                  LoginScreen()));
                          },
                          child: Text(
                            "Se connecter",
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





  void signUp(String email, String password) async
  {
    if(_formKey.currentState!.validate())
    {
      await _auth.createUserWithEmailAndPassword(email: email, password: password)
      .then((value) => {
        postDetailsToFirestore()
      }).catchError((e)
      {
        Fluttertoast.showToast(msg: e!.message);

      });

    }
  }


  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sending these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user= _auth.currentUser;

    UserModel userModel = UserModel();

    // Writing all the values
    userModel.email = user!.email;
    userModel.fullName = fullNameEditingController.text;
    userModel.number= numberEditingController.text;

  await firebaseFirestore
    .collection("users")
    .doc(user.uid)
    .set(userModel.toMap());
  Fluttertoast.showToast(msg: "Compte crée avec succès :) ");

  Navigator.pushAndRemoveUntil((context), MaterialPageRoute(builder: (context) => HomeScreen()),
   (route) => false);

  }
}