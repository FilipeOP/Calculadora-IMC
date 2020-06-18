import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

//StatefulWidget termite a interação com a tela
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController pesoController =
      TextEditingController(); //guarda o valor do peso
  TextEditingController alturaController =
      TextEditingController(); // guarda o valor da altura

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados!";

  void _resetTela() {
    pesoController.text = "";
    alturaController.text = "";
    setState(() {
      _infoText = "Informe seus dados!";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calcula() {
    setState(() { //informa que ouve uma mudança no layout
      double peso =double.parse(pesoController.text); //converte o texto em double
      double altura = double.parse(alturaController.text) / 100; //converte o texto em double
      double imc = peso / (altura * altura);
      
      if (imc < 18.6) {
        _infoText = "Abaixo do peso (${imc.toStringAsPrecision(4)})"; // tranforma a string em um texto com 4 digitos
      } else if (imc >= 18.6 && imc <24.9){
        _infoText = "Peso ideal (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 24.9 && imc <29.9){
        _infoText = "Levemente acima do peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 29.9 && imc <34.9){
        _infoText = "Obesidade grau I (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 34.9 && imc <39.9){
        _infoText = "Obesidade grau II (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 40){
        _infoText = "Obesidade grau III (${imc.toStringAsPrecision(4)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calcula IMC"),
          centerTitle: true,
          backgroundColor: Colors.deepPurpleAccent,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _resetTela, //chama função que limpa os campos
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          //permite a rolar a página
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0), //adiona bordas
          child: Form(
            key: _formKey,
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch, //centralisa
            children: <Widget>[
              Icon(Icons.person_outline,
                  size: 120.0, color: Colors.deepPurpleAccent),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Peso (kg)",
                    labelStyle: TextStyle(color: Colors.deepPurpleAccent)),
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: Colors.deepPurpleAccent, fontSize: 25.0),
                controller: pesoController,
                validator: (value) {
                  if (value.isEmpty){
                    return "Insira seu peso!";
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Altura (cm)",
                    labelStyle: TextStyle(color: Colors.deepPurpleAccent)),
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: Colors.deepPurpleAccent, fontSize: 25.0),
                controller: alturaController,
                validator: (value) {
                  if (value.isEmpty){
                    return "Insira sua altura!";
                  }
                },
              ),

              Padding(
                padding: EdgeInsets.only(
                    top: 15.0, bottom: 15.0), //adciona borda em cima e em baixo
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _calcula();
                      }
                    },
                    child: Text("Calcular",
                        style: TextStyle(color: Colors.white, fontSize: 25.0)),
                    color: Colors.deepPurpleAccent,
                  ),
                ),
              ),
              Text(
                _infoText, //exibe texto de acordo com o valor da variável
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.deepPurple, fontSize: 25.0),
              )
            ],
          ),
          )
        ),
      );
  }
}
