import 'package:flutter/material.dart';
import 'package:login_signin/screens/home_screen.dart';
import 'package:login_signin/screens/login_screen.dart';
import 'package:login_signin/screens/new_receipt.dart';
import 'package:login_signin/screens/registration_screen.dart';



class BarCode extends StatefulWidget {
  const BarCode({ Key? key }) : super(key: key);

  @override
  State<BarCode> createState() => _BarCode();
}

class _BarCode extends State<BarCode> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       title: Text("Scan du Code-Barre"),
       centerTitle: true,
       leading: (
         IconButton(
           icon: Icon(Icons.keyboard_return_outlined),
           onPressed: () {
             Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomeScreen()));
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
              Text(
                "Scannez le code-barre ci-dessous pour \n            ajouter un nouveau ticket :",
                 style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              SizedBox(height: 40,),
              SizedBox(
                height: 180,
                child: Image.asset("assets/CodeBarre.png", fit: BoxFit.contain),
              )],
        )
        )
        )
        );
  }}