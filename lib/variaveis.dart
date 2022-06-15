import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

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
var db;
List<Map<String, dynamic>> dadosDeGastos = [];
double saldoTotal = 0.0;

double getPosition(BuildContext context) {
  print(MediaQuery.of(context).orientation);
  if(MediaQuery.of(context).orientation == Orientation.landscape){
    return MediaQuery.of(context).size.width;
  }else{
    return MediaQuery.of(context).size.height;
  }
}

var categorias = ["Alimentação","Casa","Educação","Impostos","Lazer","Pets","Saúde","Veiculo", "Outros"];




criarDataBaseLocal() async{
  final database = openDatabase(
      join(await getDatabasesPath(), 'local.db'),
      onCreate: (db, version) {
  return db.execute(
  'CREATE TABLE IF NOT EXISTS gastos(id INTEGER PRIMARY KEY, descricao TEXT, valor REAL,categoria TEXT, data TEXT, isEntrada INTEGER )',
  );
  },
  version: 1,
  );


  db = await openDatabase('local.db');
}

inserirDadosBanco(String descricao , double valor, String data, String categoria, bool isEntrada) async {

    int id1 = await db.rawInsert(
        'INSERT INTO gastos(descricao, valor, data, categoria, isEntrada) VALUES(${descricao}, ${valor}, ${data}, ${categoria}, ${isEntrada == true?1:0})');
    print('inserted1: $id1');
}

Future<List<Map<String, dynamic>>> buscarDadosBanco() async {
  return await db.rawQuery('SELECT * FROM gastos');

}
