import 'package:flutter/material.dart';

//Spash Screen
var width;
var height;
var verdeForte= 0xB9099002;
var vermelhoForte= 0xFF8B0000;
var verdeClaro= 0xFF67FF2E;
var corFonteGradienteUm = 0xFF928F8F;
var corFonteGradienteDois = 0xFFFFFFFF;
var corFontePretoSplashScreen = 0xFF000000;
var corIcone = Colors.white70;

double getPosition(BuildContext context) {
  print(MediaQuery.of(context).orientation);
  if(MediaQuery.of(context).orientation == Orientation.landscape){
    return MediaQuery.of(context).size.width;
  }else{
    return MediaQuery.of(context).size.height;
  }
}