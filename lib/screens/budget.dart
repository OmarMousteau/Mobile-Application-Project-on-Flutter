import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_signin/screens/login_screen.dart';
import 'package:login_signin/screens/registration_screen.dart';



class Budget extends StatefulWidget {
  const Budget({ Key? key }) : super(key: key);

  @override
  State<Budget> createState() => _Budget();
}

class _Budget extends State<Budget> {

  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       title: Text("Mon Budget"),
       centerTitle: true,
       leading: (
         IconButton(
           icon: Icon(Icons.logout),
           onPressed: () {
                  logout(context);
                })
      ),
      ),

      body : Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center ,
            children: <Widget>[
              SizedBox(
                height: 250,
                child: Image.asset("assets/images/budget.png", fit: BoxFit.contain),
              )],
        )
        )
      )
      );
  }

  Future<void> logout(BuildContext context) async
  {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}