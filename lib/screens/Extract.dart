import 'package:flutter/material.dart';
import 'package:rifasonline/variaveis.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Extract extends StatefulWidget {
  const Extract({Key? key}) : super(key: key);

  @override
  State<Extract> createState() => _ExtractState();
}



List<Widget> imprimeLista(){
  List<Widget> widgets=[];
  if(dadosDeGastos.length > 1){
    for(int i = 0; dadosDeGastos.length > i; i++){
      widgets.add(
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(dadosDeGastos[i]["isEntrada"] == 1?"Entrada":"Saida" , style: TextStyle(fontSize: height* 0.025),),
                    Text(dadosDeGastos[i]["descricao"] , style: TextStyle(fontSize: height* 0.025),),
                  ],
                ),Row(
                  children: [
                     Text(dadosDeGastos[i]["categoria"] , style: TextStyle(fontSize: height* 0.025),),
                  ],
                ),
                Column(
                  children: [
                    Text("${dadosDeGastos[i]["month"]}/${dadosDeGastos[i]["year"]}", style: TextStyle(fontSize: height* 0.015),),
                    Text(dadosDeGastos[i]["valor"].toString(), style: TextStyle(fontSize: height* 0.025),)
                  ],
                )],
            ),
            onTap: () => {},
          )
      );
    }
  }else{
   widgets.add(ListTile(
     title: Text("Não há dados a serem mostrados"),
   ));
  }

  return widgets;

}

class _ExtractState extends State<Extract> {
  List<_Values> values =[];

  gerarCalendario() async{
    List months =["Jan", "Fev","Mar", "Abr", "Mai", "Jun", "Jul", "Ago", "Set", "Out", "Nov", "Dez"];
    for(int i = 0;months.length > i; i++){
      var value = 0.0;
     for(int j = 0;  dadosDeGastos.length > j; j++) {
        if((i+1).toString() == dadosDeGastos[j]["month"]){

          if (dadosDeGastos[j]["isEntrada"] == 1)
            {
              value = value + dadosDeGastos[j]["valor"];
            }
          else
            {
              value = value - dadosDeGastos[j]["valor"];
            }
        }
      }
      setState(() {
        values.add(_Values(months[i].toString(), value));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    gerarCalendario();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Extrato'),
          backgroundColor: Colors.green,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: height*0.3,
                child: SfCartesianChart(
                    primaryXAxis: CategoryAxis(),
                    // Chart title
                    title: ChartTitle(text: 'Posição Financeira'),
                    // Enable legend
                    legend: Legend(isVisible: false),
                    // Enable tooltip
                    tooltipBehavior: TooltipBehavior(enable: true),
                    series: <ChartSeries<_Values, String>>[
                      LineSeries<_Values, String>(
                          dataSource: values,
                          xValueMapper: (_Values victims, _) => victims.year,
                          yValueMapper: (_Values victims, _) => victims.values,
                          // Enable data label
                          dataLabelSettings: DataLabelSettings(isVisible: true))
                    ]),
              ),
              SizedBox(height: height * 0.05,),
              Text("Histórico", style: TextStyle(fontSize: height * 0.04),),
              SizedBox(height: height * 0.02,),
              SizedBox(height: height * 0.50,
                child: ListView(
                    children: imprimeLista()
                ),
              )
            ]
          ),
        ));
  }
}



class _Values {
  _Values(this.year, this.values);

  final String year;
  final double values;
}
