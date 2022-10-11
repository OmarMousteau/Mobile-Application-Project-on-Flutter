import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_signin/screens/login_screen.dart';
import 'package:login_signin/screens/registration_screen.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({ Key? key }) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPassword();
}

final TextEditingController emailController = new TextEditingController();
final _auth = FirebaseAuth.instance;
final _formKey= GlobalKey<FormState>();

class _ResetPassword extends State<ResetPassword> {

  @override

  Widget build(BuildContext context) {
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
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment : MainAxisAlignment.center,
                  crossAxisAlignment : CrossAxisAlignment.center,
                  children: <Widget>[

                    SizedBox(height : 40,
                        
                             child : Text("Mot de passe oublié",
                                          style: TextStyle(fontWeight: FontWeight.bold,
                                                           color: Color.fromARGB(255, 117, 2, 2),
                                                           fontSize: 25),
                                                          )),

                    SizedBox(height : 120),

                    SizedBox(height : 40,
                             child : Text("Afin de réinitialiser votre mot de passe, saisissez votre adresse E-mail :",
                                          style: TextStyle(fontWeight: FontWeight.bold,
                                                           fontSize: 15),)),
                    
                    SizedBox(height : 15),

                    TextFormField(
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
                      ),
                      
                      SizedBox(height : 50),

                      Material(
                      elevation : 5,
                      borderRadius: BorderRadius.circular(30),
                      color: Color.fromARGB(255, 79, 187, 179),
                      child: MaterialButton(
                        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                        minWidth: MediaQuery.of(context).size.width,
                        onPressed: () 
                        { 
                          if (_formKey.currentState!.validate()) {
                          _auth.sendPasswordResetEmail(email: emailController.text);
                          Navigator.of(context).pop();
                        }
                        },

                        child : Text("Envoyer", textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20, color: Colors.white,fontWeight: FontWeight.bold),
                        )),
                      ),

                      SizedBox(height: 80,)
                      
                      ]
                )
              )
            )
          )
        )

      )
    );
  }
}

