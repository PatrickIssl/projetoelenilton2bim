import 'dart:ffi';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rifasonline/variaveis.dart';
import 'package:rifasonline/widgets/NavDrawer.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _formKey = GlobalKey<FormState>();

  var _name;
  var _valor;
  var _categoria = "Outros";
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    dados() async {
        dadosDeGastos = await buscarDadosBanco();
    }

    calculoValorTotal() {
      saldoTotal = 0.0;
      dadosDeGastos.forEach((element) => {
            if (element["isEntrada"] == 1)
              {
                setState(() {
                  saldoTotal = saldoTotal + element["valor"];
                })
              }
            else
              {
                setState(() {
                  saldoTotal = saldoTotal - element["valor"];
                })
              }
          });
    }

    criarDataBaseLocal();
    dados();
    calculoValorTotal();

    return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          backgroundColor: Color(verdeForte),
          title: Text('Contabilize'),
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.all(height * 0.03),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  new SizedBox(height: height * 0.05),
                  Row(
                    children: [
                      Text(
                        "Descrição de gasto",
                        style: TextStyle(fontSize: height * 0.03),
                      ),
                    ],
                  ),
                  TextFormField(
                      keyboardType: TextInputType.text,
                      maxLength: 100,
                      validator: (String? val) {
                        if (val?.length == 0) {
                          return "Informe a observação";
                        } else {
                          return null;
                        }
                      },
                      onChanged: (var val) {
                        _name = val;
                      }),
                  Row(
                    children: [
                      Text(
                        "Valor",
                        style: TextStyle(fontSize: height * 0.03),
                      ),
                    ],
                  ),
                  TextFormField(
                    onChanged: (var val) {
                      val = val.substring(4, val.length);
                      val = val.replaceAll(",", ".");
                      val = val.replaceAll(".", "");
                      val =
                          val.replaceRange(val.length - 3, val.length - 2, ".");
                      _valor = double.parse(val);
                    },
                    initialValue: CurrencyTextInputFormatter(
                      locale: 'pt-br',
                      symbol: 'R\$ ',
                    ).format('0'),
                    inputFormatters: [
                      CurrencyTextInputFormatter(
                        locale: 'pt-br',
                        symbol: 'R\$ ',
                      ),
                    ],
                    keyboardType: TextInputType.number,
                    maxLength: 100,
                    validator: (String? val) {
                      if (val == 0) {
                        return "Informe um valor positivo";
                      } else {
                        return null;
                      }
                    },
                  ),
                  Row(
                    children: [
                      Text(
                        "Categoria",
                        style: TextStyle(fontSize: height * 0.03),
                      ),
                    ],
                  ),
                  Container(
                      width: width,
                      child: DropdownButton(
                        value: _categoria,
                        icon: Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        isExpanded: true,
                        style: TextStyle(color: Color(verdeForte)),
                        underline: Container(
                          height: 2,
                          color: Color(verdeForte),
                        ),
                        onChanged: (String? newValue) {
                          _categoria = newValue!;
                        },
                        items: categorias
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      )),
                  Row(
                    children: [
                      Text("Saida"),
                      Switch(
                        value: isChecked,
                        onChanged: (value) {
                          setState(() {
                            isChecked = value;
                          });
                        },
                        activeTrackColor: Colors.lightGreenAccent,
                        activeColor: Colors.green,
                      ),
                      Text("Entrada")
                    ],
                  ),
                  RaisedButton(
                    color: Colors.green,
                    textColor: Colors.white,
                    onPressed: () {
                      setState(() {
                        inserirDadosBanco(
                            "'${_name}'",
                            _valor,
                            "'${DateTime.now().month.toString()}/${DateTime.now().year.toString()}'",
                            "'${_categoria}'",
                            isChecked);
                        dados();
                      });
                      calculoValorTotal();
                    },
                    child: new Text('Adicionar'),
                  ),
                  SizedBox(
                    height: height * 0.1,
                  ),
                  Text(
                    "Saldo Total",
                    style: TextStyle(
                        color: Color(corFontePretoSplashScreen),
                        fontSize: height * 0.05),
                  ),
                  Text(
                    "R\$ ${saldoTotal}",
                    style: TextStyle(
                        color: 0 < saldoTotal
                            ? Color(verdeForte)
                            : Color(vermelhoForte),
                        fontSize: height * 0.05),
                  ),
                  SizedBox(
                    height: height * 0.1,
                  ),
                  Container(
                      width: width * 0.5,
                      child: Column(
                        children: [
                          SizedBox(
                            height: height * 0.04,
                          ),
                          ElevatedButton(
                              onPressed: () =>
                                  {Navigator.pushNamed(context, '/extract')},
                              style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Color(verdeForte)),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          side: BorderSide(
                                              color: Colors.black)))),
                              child: Text(
                                "Extrato",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: height * 0.035),
                              ))
                        ],
                      ))
                ],
              )),
        )));
  }
}
