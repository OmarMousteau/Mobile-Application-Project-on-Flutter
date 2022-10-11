import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_signin/screens/docs/receiptex.dart';
import 'package:login_signin/screens/docs/utilsReceipt.dart';
import 'package:login_signin/screens/login_screen.dart';
import 'package:login_signin/screens/registration_screen.dart';


class Receipts extends StatefulWidget {
  const Receipts({ Key? key }) : super(key: key);

  @override
  State<Receipts> createState() => _Receipts();
}

class _Receipts extends State<Receipts> {
   User? user = FirebaseAuth.instance.currentUser;


List<ReceiptsEX> receipts =UtilsReceipt.getMockedCategories();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tickets"),
        centerTitle: true,
        leading: (
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
                    logout(context);
                  })
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {})
        ],
      ),
      body : Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(padding: const EdgeInsets.only(top: 20, bottom:10),
          child :Text('     Vos tickets de caisse :',
            textAlign: TextAlign.left,
            style: TextStyle( color: Color.fromARGB(255, 154, 6, 6),
                              fontWeight: FontWeight.bold),
            textScaleFactor: 1.18,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: receipts.length,
              itemBuilder: (BuildContext ctx, int index) {
                return Container(
                  margin : EdgeInsets.all(20),
                  height : 150,
                  child : Stack(
                    children: [
                      Positioned.fill(
                        child : ClipRRect(
                          borderRadius : BorderRadius.circular(20),
                          child : Image.asset('assets/images/'+receipts[index].imgName +'.jpg',
                          fit: BoxFit.cover
                        )
                      ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child : Container(
                            height:120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20)),
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.black.withOpacity(0.7),
                                  Colors.transparent
                                ]
                              )
                            )
                          )
                          ),
                          Positioned(
                            bottom:0,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                              children: [
                                Text( receipts[index].name,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)
                                )
                              ],),
                            ),)
                    ],
                    )
                );
              },
            ) ,)
        ]),
      );
  }

  Future<void> logout(BuildContext context) async
  {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}