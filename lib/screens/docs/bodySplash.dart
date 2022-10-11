import 'package:flutter/material.dart';
import '/screens/login_screen.dart';
import '/size_config.dart';

import '/screens/docs/splash_content.dart';
import '/screens/docs/default_button.dart';

class BodySplash extends StatefulWidget {
  @override
  _BodySplashState createState() => _BodySplashState();
}

class _BodySplashState extends State<BodySplash> {
  int currentPage = 0;
  static const colorpoint= Color.fromARGB(255, 72, 172, 165);
  List<Map<String, String>> splashData = [
    {
      "text":
          "Bienvenue sur Spense! \n \n L'application sur laquelle vous pouvez stocker tous vos \n tickets de caisse..",
      "image": "assets/images/receipt.png"
    },
    {
      "text": "Pour ça, rien de plus simple! \n \n Lors de votre passage en caisse, il suffit de scanner votre \n code-barre personnel pour envoyer automatiquement \n votre ticket sur votre compte. \n\n Magique, non?",
      "image": "assets/images/code-barres.png"
    },
    {
      "text": "Profitez des nombreuses fonctionnalités de l'application! \n\n Notamment d'une gestion votre bugdet qui se met à jour \n à l'ajout de chaque nouveau ticket..",
      "image": "assets/images/budget.png"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 6,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  image: splashData[index]["image"],
                  text: splashData[index]['text'],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: Column(
                  children: <Widget>[
                    Spacer(flex : 3),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        splashData.length,
                        (index) => buildDot(index: index),
                      ),
                    ),
                    Spacer(flex: 3),
                    DefaultButton(
                      text: "Continuer",
                      press: () {
                        Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                      },
                    ),
                    Spacer(flex:4),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int? index}) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? colorpoint : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
