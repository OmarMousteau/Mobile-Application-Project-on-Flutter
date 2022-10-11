import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../login_screen.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';
import '/model/user_model.dart';

class BodyProfile extends StatelessWidget {

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();  //Pour Pouvoir se déconnecter

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(),
          SizedBox(height: 20),
          ProfileMenu(
            text: "Mon compte",
            icon: "assets/icons/UserIcon.svg",
            press: () => {},
          ),
          ProfileMenu(
            text: "Notifications",
            icon: "assets/icons/Bell.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Paramètres",
            icon: "assets/icons/Settings.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Aide",
            icon: "assets/icons/QuestionMark.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Déconnexion",
            icon: "assets/icons/LogOut.svg",
            press: () => {logout(context)},
          ),
        ],
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