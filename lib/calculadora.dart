import 'package:expressions/expressions.dart';
import 'package:flutter/material.dart';
import 'dart:math';

// Widget da Calculadora
class Calculadora extends StatefulWidget {
  const Calculadora({super.key});

  @override
  State<Calculadora> createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  String _expressao = '';
  String _resultado = '';
  bool _isDestroyed = false;

  // Função que trata a lógica dos botões
  void _pressionarBotao(String valor) {
    setState(() {
      if (_isDestroyed) return;

      if (valor == "=") {
        _calcularResultado();
      } else if (valor == '√') {
        _calcularRaiz();
      } else if (valor == '%') {
        _calcularPorcentagem();
      } else if (valor == 'C') {
        _apagarTudo();
      } else {
        _expressao += valor;
      }
    });
  }

  // Função para apagar tudo
  void _apagarTudo() {
    _expressao = '';
    _resultado = '';
  }

  // Função para calcular o resultado da expressão
  void _calcularResultado() {
    try {
      _resultado = _avaliarExpressao(_expressao).toString();

      if (_resultado == '17') {
        _ativarAutoDestruicao();
      }
    } catch (e) {
      _resultado = "Erro";
    }
  }

  // Função para calcular a raiz quadrada
  void _calcularRaiz() {
    try {
      double numero = double.parse(_expressao);
      _resultado = (numero >= 0 ? sqrt(numero).toString() : 'Erro');
    } catch (e) {
      _resultado = 'Erro';
    }
  }

  // Função para calcular a porcentagem
  void _calcularPorcentagem() {
    try {
      double numero = double.parse(_expressao);
      _resultado = (numero / 100).toString();
    } catch (e) {
      _resultado = 'Erro';
    }
  }

  // Função para avaliar a expressão usando a biblioteca expressions
  double _avaliarExpressao(String expressao) {
    expressao = expressao.replaceAll('x', '*');
    expressao = expressao.replaceAll('÷', '/');
    ExpressionEvaluator avaliador = const ExpressionEvaluator();
    double resultado = avaliador.eval(Expression.parse(expressao), {});
    return resultado;
  }

  // Função para ativar a "auto destruição" (exemplo fictício)
  void _ativarAutoDestruicao() async {
    setState(() {
      _resultado = 'Ativando auto destruição...';
    });

    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _isDestroyed = true;
    });
  }

  // Função que cria um botão da calculadora
  Widget _botao(String valor) {
    return TextButton(
      child: Text(
        valor,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      onPressed: () => _pressionarBotao(valor),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Exibe a expressão
        Expanded(
          child: Text(
            _expressao,
            style: const TextStyle(fontSize: 24),
          ),
        ),
        // Exibe o resultado
        Expanded(
          child: Text(
            _resultado,
            style: const TextStyle(fontSize: 24),
          ),
        ),
        // Exibe os botões da calculadora
        if (!_isDestroyed)
          Expanded(
            flex: 3,
            child: GridView.count(
              crossAxisCount: 4,
              childAspectRatio: 2,
              children: [
                _botao("C"),
                _botao(""),
                _botao("%"),
                _botao("√"),
                _botao("7"),
                _botao("8"),
                _botao("9"),
                _botao("÷"),
                _botao("4"),
                _botao("5"),
                _botao("6"),
                _botao("x"),
                _botao("1"),
                _botao("2"),
                _botao("3"),
                _botao("-"),
                _botao("0"),
                _botao("."),
                _botao("="),
                _botao("+"),
              ],
            ),
          ),
      ],
    );
  }
}