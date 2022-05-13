import 'package:flutter/material.dart';
import 'package:rifasonline/variaveis.dart';
import 'package:rifasonline/widgets/NavDrawer.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final _formKey = GlobalKey<FormState>();
  var _valorTotal = 0;
  var _name;
  var _valor = 0;
  bool isChecked = false;


  @override
  Widget build(BuildContext context) {
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
                child:Column(
                  children: [
                    new SizedBox(height: height*0.05),
                    TextFormField(
                        decoration: new InputDecoration(hintText: 'Descrição de gasto'),
                        keyboardType: TextInputType.text,
                        maxLength: 100,
                        validator:(String? val){
                          if (val?.length == 0) {
                            return "Informe a observação";
                          } else {
                            return null;
                          }},
                        onSaved: (var val) {
                          _name = val;
                        }),
                    TextFormField(
                        decoration: new InputDecoration(hintText: 'Valor'),
                        keyboardType: TextInputType.number,
                        maxLength: 100,
                        validator:(String? val){
                          if (val == 0) {
                            return "Informe um valor positivo";
                          } else {
                            return null;
                          }},
                        onSaved: (var val) {
                          _valor = int.parse(val!);
                        }),


                        Row(
                          children: [
                            Text("Saida"),
                            Switch(
                              value: isChecked,
                              onChanged: (value) {
                                setState(() {
                                  isChecked = value;
                                  print(isChecked);
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

                          onPressed: (){
                          },
                          child: new Text('Adicionar'),
                        ),

                    SizedBox(
                      height: height*0.1,
                    ),
                    Text("Saldo Total", style: TextStyle(
                        color: Color(corFontePretoSplashScreen),
                        fontSize: height*0.05
                    ),),
                    Text("RS ${_valorTotal},00", style: TextStyle(
                      color: _valorTotal>0?Color(verdeForte):Color(vermelhoForte),
                      fontSize: height*0.05
                    ),),
                    SizedBox(height: height * 0.1,),
                    Container(
                      width: width * 0.5,
                      child:
                        Column(
                          children: [

                            SizedBox(height: height*0.04,),
                            ElevatedButton(onPressed: ()=>{}, style: ButtonStyle(
                                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                backgroundColor: MaterialStateProperty.all<Color>(Color(verdeForte)),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                        side: BorderSide(color: Colors.black)
                                    )
                                )
                            ), child: Text("Extrato", style: TextStyle(color: Colors.white, fontSize: height*0.035),))
                  ],
                        )
                    )
                  ],
                )

            ),
          )
      )
    );
  }
}
