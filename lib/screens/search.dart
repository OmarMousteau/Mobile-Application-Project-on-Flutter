import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_signin/screens/login_screen.dart';
import 'package:login_signin/screens/registration_screen.dart';
import 'package:login_signin/screens/docs/searchBar.dart';


class Search extends StatefulWidget {
  const Search({ Key? key }) : super(key: key);

  @override
  State<Search> createState() => _Search();
}

class _Search extends State<Search> {
    User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       title: Text("Recherche"),
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
                child: AnimatedSearchBar(),
              ),
              Text(
                "Recherchez vos tickets, vos commerces..",
                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),]))
       
      ));
  }

  Future<void> logout(BuildContext context) async
  {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}