import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_signin/screens/budget.dart';
import 'package:login_signin/screens/login_screen.dart';
import'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:login_signin/screens/new_receipt.dart';
import 'package:login_signin/screens/profile.dart';
import 'package:login_signin/screens/receipts.dart';
import 'package:login_signin/screens/search.dart';


import '../model/user_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  int index= 2;
  final screens= [
    Budget(),
    Receipts(),
    NewReceipt(),
    Search(),
    Profile()
  ] ;

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
      
      body: screens[index],
      bottomNavigationBar: CurvedNavigationBar(backgroundColor: Colors.transparent,
       height: 60,
       index: index,
       color: Color.fromARGB(255, 78, 139, 127),
       animationDuration: Duration(milliseconds: 300),     
       items: [
         Icon(Icons.account_balance_wallet_outlined,
          color: Colors.white,),
         Icon(Icons.receipt_long_rounded,
          color: Colors.white),
         Icon(Icons.post_add_rounded,
          color: Colors.white),
         Icon(Icons.search,
          color: Colors.white),
         Icon(Icons.account_circle,
          color: Colors.white),
              ],
        
        onTap: (index) => setState(() => this.index= index),

       
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
