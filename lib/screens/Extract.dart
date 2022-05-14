import 'package:flutter/material.dart';
import 'package:rifasonline/variaveis.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Extract extends StatefulWidget {
  const Extract({Key? key}) : super(key: key);

  @override
  State<Extract> createState() => _ExtractState();
}

class _ExtractState extends State<Extract> {
  @override
  Widget build(BuildContext context) {
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
                          dataSource: <_Values>[
                            _Values('Jan', 10),
                            _Values('Fev', 20),
                            _Values('Mar', -20),
                            _Values('Abr', -50),
                            _Values('Mai', 70),
                            _Values('Jun', 50)
                          ],
                          xValueMapper: (_Values victims, _) => victims.year,
                          yValueMapper: (_Values victims, _) => victims.values,
                          // Enable data label
                          dataLabelSettings: DataLabelSettings(isVisible: true))
                    ]),
              ),
              SizedBox(height: height * 0.05,),
              Text("Histórico", style: TextStyle(fontSize: height * 0.04),),
              SizedBox(height: height * 0.02,),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Débito", style: TextStyle(fontSize: height* 0.025),),
                        Text("Aluguel", style: TextStyle(fontSize: height* 0.025),),
                      ],
                    ),
                    Column(
                      children: [
                        Text("10/04/2022", style: TextStyle(fontSize: height* 0.015),),
                        Text("-RS 750,00", style: TextStyle(fontSize: height* 0.025),)
                      ],
                    )],
                ),
                onTap: () => {},
              ),


            ],
          ),
        ));
  }
}

class _Values {
  _Values(this.year, this.values);

  final String year;
  final double values;
}
