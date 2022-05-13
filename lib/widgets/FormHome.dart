import 'package:flutter/material.dart';

var nome;
var celular;

Widget _formUI(_key) {
  return new Column(
    children: <Widget>[
      new TextFormField(
        decoration: new InputDecoration(hintText: 'Nome Completo'),
        maxLength: 40,
        validator:  (value) {
        if (value == null) {
        return 'Informe o valor';
        }
        },
        onSaved: (val) {
          nome = val;
        },
      ),
      new TextFormField(
          decoration: new InputDecoration(hintText: 'Celular'),
          keyboardType: TextInputType.phone,
          maxLength: 10,
          validator: (value) {
            if (value == null) {
              return 'Informe o valor';
            }
          },
          onSaved: (val) {
            celular = val;
          }),
      new SizedBox(height: 15.0),
      new RaisedButton(
        onPressed: ()=>{
          if (_key.currentState.validate()) {
          // Sem erros na validação
          _key.currentState.save(),
          print("Nome $nome"),
          print("Ceclular $celular")
          }
        },
        child: new Text('Enviar'),
      )
    ],
  );
}