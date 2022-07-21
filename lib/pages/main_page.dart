import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

TextEditingController pesoController = TextEditingController();
TextEditingController alturaController = TextEditingController();

String _infoText = "Informe seus Dados.";

GlobalKey<FormState> _formKey = GlobalKey<FormState>();

void _resetarCampos() {
  pesoController.text = "";
  alturaController.text = "";
  _infoText = "Informe seus Dados";
  _formKey = GlobalKey<FormState>();
}

void calcular() {
  double peso = double.parse(pesoController.text);
  double altura = double.parse(alturaController.text);
  double imc = peso / (altura * altura);
  if (imc < 18.6) {
    _infoText = "Abaixo do Peso (${imc.toStringAsPrecision(3)})";
  } else if (imc >= 18.6 && imc <= 24.9) {
    _infoText = "Peso Ideal (${imc.toStringAsPrecision(3)})";
  } else if (imc >= 25 && imc <= 29.9) {
    _infoText = "Levemente Acima do Peso (${imc.toStringAsPrecision(3)})";
  } else if (imc >= 30 && imc <= 34.9) {
    _infoText = "Obsedida Grau I (${imc.toStringAsPrecision(3)})";
  } else if (imc >= 35 && imc <= 39.9) {
    _infoText = "Obsedida Grau II (${imc.toStringAsPrecision(3)})";
  } else if (imc >= 40) {
    _infoText = "Obsedida Grau III (${imc.toStringAsPrecision(3)})";
  }
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculadora IMC"),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              setState(() {
                _resetarCampos();
              });
            },
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Icon(Icons.person_outline, size: 120, color: Colors.black),
              TextFormField(
                controller: pesoController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Peso em Kg",
                  labelStyle: const TextStyle(fontSize: 15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                validator: (value) {
                  if (value != null) {
                    if (value.isEmpty) {
                      return "Insira seu Pesso!";
                    }
                  }
                },
              ),
              const Padding(
                padding: EdgeInsets.all(10),
              ),
              TextFormField(
                controller: alturaController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Altura",
                  labelStyle: const TextStyle(fontSize: 15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                validator: (value) {
                  if (value != null) {
                    if (value.isEmpty) {
                      return "Insira sua Altura!";
                    }
                  }
                },
              ),
              const Padding(
                padding: EdgeInsets.all(10),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      calcular();
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.black, // Background color
                  fixedSize: const Size(50, 50),
                ),
                child: const Text("Calcular"),
              ),
              const Padding(
                padding: EdgeInsets.all(10),
              ),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
