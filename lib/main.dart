// Desenvolvido por Thiago Lucas de Oliveira

import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

void main() {
  runApp(MaterialApp(
    home: Home(), //stateful widget para podermos interagir
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final List<String> itemsRenda = [
    "Até um salário mínimo",
    "Até dois salários minímos",
    "Três ou mais salários mínimos"
  ];

  final List<String> itemsFilhos = [
    "Até 2 filhos em escola e vacinados",
    "3 ou mais filhos em escola e vacinados"
  ];

  String? valorSelecionadoRenda;
  String? valorSelecionadoFilhos;

  final List<bool> _toggleMaeSolteira = <bool>[true, false];

  static const List<Widget> opcoesMae = <Widget>[
    Text('Sim'),
    Text('Não'),
  ];

  String _infoText = "";

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _resetFields() {
    _formKey = GlobalKey<FormState>();
    valorSelecionadoRenda = null;
    valorSelecionadoFilhos = null;
    setState(() {
      _infoText = "";
    });
  }

  void _calculate() {
    setState(() {
      if(valorSelecionadoRenda == itemsRenda[0] && valorSelecionadoFilhos == itemsFilhos[0] && !_toggleMaeSolteira[0]) {
        _infoText = "Você tem o direito a 3030,00 reais";
      }
      else if(valorSelecionadoRenda == itemsRenda[1] && valorSelecionadoFilhos == itemsFilhos[0] && !_toggleMaeSolteira[0]) {
        _infoText = "Você tem o direito a 1818,00 reais";
      }
      else if(valorSelecionadoRenda == itemsRenda[0] || valorSelecionadoRenda == itemsRenda[1] && valorSelecionadoFilhos == itemsFilhos[1] && !_toggleMaeSolteira[0]) {
        _infoText = "Você tem o direito a 3636,00 reais";
      }
      else if(valorSelecionadoRenda == itemsRenda[0] && valorSelecionadoFilhos == itemsFilhos[0] && _toggleMaeSolteira[0]) {
        _infoText = "Você tem o direito a 3630,00 reais";
      }
      else if(valorSelecionadoRenda == itemsRenda[1] && valorSelecionadoFilhos == itemsFilhos[0] && _toggleMaeSolteira[0]) {
        _infoText = "Você tem o direito a 2418,00 reais";
      }
      else if(valorSelecionadoRenda == itemsRenda[0] || valorSelecionadoRenda == itemsRenda[1] && valorSelecionadoFilhos == itemsFilhos[1] && _toggleMaeSolteira[0]) {
        _infoText = "Você tem o direito a 4236,00 reais";
      }
      else if(valorSelecionadoRenda == itemsRenda[2] && valorSelecionadoFilhos == itemsFilhos[0] ||  valorSelecionadoFilhos == itemsFilhos[1] && _toggleMaeSolteira[0]) {
        _infoText = "Você tem o direito a 600,00 reais";
      }
      else if(valorSelecionadoRenda == null || valorSelecionadoFilhos == null){
        _infoText = "Insira os valores!";
      }
      else {
        _infoText = "Você não recebe nenhum auxílio";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("YSolutions - Cálculo de auxílio", style: TextStyle(
          color: Colors.black,
        )),
        centerTitle: true, //centralizando o texto
        backgroundColor: Colors.indigo.shade600,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh), onPressed: _resetFields),
        ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 5.0, bottom: 40.0),
                  child: Text(
                    'Insira os valores e veja se tem direito',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),
                Icon(
                  Icons.house,
                  size: 120.0,
                  color: Colors.indigo.shade600,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: DropdownButton2(
                    hint: Text(
                      'Selecione a sua renda',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                    items: itemsRenda
                        .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ))
                        .toList(),
                    value: valorSelecionadoRenda,
                    onChanged: (value) {
                      setState(() {
                        valorSelecionadoRenda = value as String;
                      });
                    },
                    isExpanded: true,
                  ),
                ),
                DropdownButton2(
                  hint: Text(
                    'Quantos filhos você tem?',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  items: itemsFilhos
                      .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ))
                      .toList(),
                  value: valorSelecionadoFilhos,
                  onChanged: (value) {
                    setState(() {
                      valorSelecionadoFilhos = value as String;
                    });
                  },
                  isExpanded: true,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Center(child: Text('É mãe solteira?', style: TextStyle(fontSize: 20, color: Colors.black))),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Center(
                    child: ToggleButtons(
                      onPressed: (int index) {
                        setState(() {
                          // The button that is tapped is set to true, and the others to false.
                          for (int i = 0; i < _toggleMaeSolteira.length; i++) {
                            _toggleMaeSolteira[i] = i == index;
                          }
                        });
                      },
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      selectedBorderColor: Colors.indigo.shade600,
                      selectedColor: Colors.white,
                      fillColor: Colors.indigo,
                      color: Colors.black,
                      constraints: const BoxConstraints(
                        minHeight: 40.0,
                        minWidth: 80.0,
                      ),
                      isSelected: _toggleMaeSolteira,
                      children: opcoesMae,
                    ),
                  ),
                ),

                const SizedBox(height: 20),
                Padding(
                    padding: EdgeInsets.only(top: 30.0, bottom: 10.0),
                    child: Container(
                        height: 50.0,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!
                                .validate()) //Se meu formulario for valido , posso chamar a funcao
                              _calculate();
                          },
                          child: Text(
                            "Calcular",
                            style:
                            TextStyle(color: Colors.white, fontSize: 25.0),
                          ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.indigo.shade600),
                        ))),
                Text(
                  '$_infoText',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 23, color: Colors.black),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}