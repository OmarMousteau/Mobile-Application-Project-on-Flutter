import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_signin/screens/barCode.dart';
import 'package:login_signin/screens/login_screen.dart';
import 'package:login_signin/screens/registration_screen.dart';

import '../model/user_model.dart';


class NewReceipt extends StatefulWidget {
  const NewReceipt({ Key? key }) : super(key: key);

  @override
  State<NewReceipt> createState() => _NewReceipt();
}



class _NewReceipt extends State<NewReceipt> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();  //Pour Pouvoir se déconnecter

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseFirestore.instance
      .collection("users")
      .doc(user!.email)
      .get()
      .then((value){
        this.loggedInUser = UserModel.fromMap(value.data());
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       title: Text("Ajout d'un nouveau ticket"),
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
                height: 150,
                child: Image.asset("assets/Welcome.png", fit: BoxFit.contain),
              ),
              Text(
                "\n Commencez à stocker vos tickets!",
                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              SizedBox(height: 15,),
              Text(
                "\n Cliquez ci-dessous pour afficher votre code personnel",
                 style: TextStyle(fontSize: 15),
                ),
//                SizedBox(height: 10,),
//                Text("${loggedInUser.fullName}",
//                  style: TextStyle(
//                    color: Colors.black54,
//                    fontWeight: FontWeight.w500,
//                  )),
//                Text("${loggedInUser.email}",
//                  style: TextStyle(
//                    color: Colors.black54,
//                    fontWeight: FontWeight.w500,
//                  )),
                SizedBox(height: 15,),

                ActionChip(label: Text("Nouveau Ticket"), onPressed: () {
                  Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => BarCode()));
                })
            ]
          )
        ) 
      ),
      );
  }

  // Fonction pour se déconnecter
  Future<void> logout(BuildContext context) async
  {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}