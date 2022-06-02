import 'package:flutter/material.dart';
import 'package:rifasonline/variaveis.dart';
import 'package:rifasonline/widgets/GradientText.dart';
import 'package:rive/rive.dart' as Rive;


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(verdeForte).withOpacity(0.4),
                  Color(verdeClaro),
                ],
              )
          ),
        width: width,
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(child:
            Column(
            children: [
              GradientText("Contabilize", style: TextStyle(
                fontSize: height*0.07,
                fontFamily: "SairaStencilOne",
              ),
                gradient: LinearGradient(colors: [
                  Color(corFonteGradienteUm),
                  Color(corFonteGradienteDois),
                ]),
              ),
              Icon(
                Icons.whatshot,
                color: corIcone,
                size: height*0.15,
              ),
            ],
        ),
                margin: EdgeInsets.only(top: height* 0.25)
            ),
            Container(child: Rive.RiveAnimation.asset('assets/loader.riv'), height: height*0.15,),
            Container(child: Text("Version 1.0 powered by APLTDA.", textAlign: TextAlign.center, style: TextStyle(
                fontSize: height*0.02,
                color: Color(corFontePretoSplashScreen).withOpacity(0.65)
            )),
              margin: EdgeInsets.only(bottom: height*0.05),
            )
          ],
        )
      ),
    );
  }
}
