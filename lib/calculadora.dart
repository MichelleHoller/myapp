import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculadora extends StatefulWidget {
  const Calculadora({super.key});

  @override
  State<Calculadora> createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  String _input = '';
  String _resultado = '0';

  void _adicionarValor(String valor) {
    setState(() {
      _input += valor;
    });
  }

  void _calcularResultado() {
    try {
      if (_input.isEmpty) {
        setState(() {
          _resultado = 'Erro: Entrada vazia';
        });
        return;
      }

      Parser p = Parser();
      Expression exp = p.parse(
        _input.replaceAll('x', '*').replaceAll('÷', '/'),
      );
      ContextModel cm = ContextModel();

      double eval = exp.evaluate(EvaluationType.REAL, cm);

      setState(() {
        _resultado = eval.toString();
      });
    } catch (e) {
      setState(() {
        _resultado = 'Erro: não foi possível calcular';
      });
    }
  }

  void _limpar() {
    setState(() {
      _input = '';
      _resultado = '0';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora'),
        backgroundColor: Colors.deepPurple.shade200,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _input,
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _resultado,
                    style: const TextStyle(
                      fontSize: 28,
                      color: Colors.deepPurple,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 5, // Reduzi a proporção para que a área cinza fique menor
            child: Center(
              child: Container(
                width: 350, // Definir uma largura fixa para a área
                height: 450, // Definir uma altura fixa para a área
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: GridView.count(
                        crossAxisCount: 4,
                        padding: const EdgeInsets.all(8),
                        crossAxisSpacing: 4, // Menor espaçamento entre os botões
                        mainAxisSpacing: 4, // Menor espaçamento entre as linhas
                        childAspectRatio: 1.2, // Ajusta o tamanho dos botões
                        children: [
                          _botao('7'), _botao('8'), _botao('9'), _botao('÷'),
                          _botao('4'), _botao('5'), _botao('6'), _botao('x'),
                          _botao('1'), _botao('2'), _botao('3'), _botao('-'),
                          _botao('0'), _botao('.'), _botao('='), _botao('+'),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: _limpar,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: Text(
                          'Limpar',
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _botao(String texto) {
    return InkWell(
      onTap: () {
        if (texto == '=') {
          _calcularResultado();
        } else {
          _adicionarValor(texto);
        }
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(3, 3),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          texto,
          style: const TextStyle(
            fontSize: 18, // Tamanho de fonte menor
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
