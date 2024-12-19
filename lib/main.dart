import 'package:flutter/material.dart'; // Importa o pacote Flutter para criar a interface gráfica

void main() {
  runApp(CalculatorApp()); // Executa o aplicativo inicial
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove a faixa de "debug" do aplicativo
      home: CalculatorHome(), // Define a tela inicial do aplicativo
    );
  }
}

class CalculatorHome extends StatefulWidget {
  @override
  _CalculatorHomeState createState() => _CalculatorHomeState(); // Cria o estado para gerenciar os dados da calculadora
}

class _CalculatorHomeState extends State<CalculatorHome> {
  String _output = "0"; // Variável para armazenar o valor exibido na tela
  String _operand = ""; // Variável para armazenar o operador selecionado
  double _num1 = 0; // Primeiro número da operação
  double _num2 = 0; // Segundo número da operação

  void _buttonPressed(String buttonText) { // Função chamada quando um botão é pressionado
    setState(() {
      if (buttonText == "C") { // Verifica se o botão pressionado é "C" (limpar)
        _output = "0"; // Reseta o valor exibido
        _num1 = 0; // Reseta o primeiro número
        _num2 = 0; // Reseta o segundo número
        _operand = ""; // Reseta o operador
      } else if (buttonText == "+" ||
          buttonText == "-" ||
          buttonText == "x" ||
          buttonText == "/") { // Verifica se o botão pressionado é um operador
        _num1 = double.parse(_output); // Converte o valor exibido para número e armazena como o primeiro número
        _operand = buttonText; // Armazena o operador selecionado
        _output = "0"; // Reseta o valor exibido para entrada do próximo número
      } else if (buttonText == "=") { // Verifica se o botão pressionado é "=" (igual)
        _num2 = double.parse(_output); // Converte o valor exibido para número e armazena como o segundo número

        switch (_operand) { // Realiza a operação com base no operador
          case "+":
            _output = (_num1 + _num2).toString(); // Soma os números
            break;
          case "-":
            _output = (_num1 - _num2).toString(); // Subtrai os números
            break;
          case "x":
            _output = (_num1 * _num2).toString(); // Multiplica os números
            break;
          case "/":
            _output = (_num2 != 0) ? (_num1 / _num2).toString() : "Error"; // Divide os números, verificando se o divisor não é zero
            break;
        }

        _operand = ""; // Reseta o operador após a operação
        _num1 = 0; // Reseta o primeiro número
        _num2 = 0; // Reseta o segundo número
      } else {
        if (_output == "0") { // Verifica se o valor exibido é zero
          _output = buttonText; // Substitui o zero pelo número pressionado
        } else {
          _output += buttonText; // Adiciona o número pressionado ao valor exibido
        }
      }

      // Remove o ".0" se o resultado for um número inteiro
      if (_output.contains(".") && _output.endsWith("0")) {
        _output = double.parse(_output).toString();
      }
    });
  }

  Widget _buildButton(String text, Color color) { // Função para criar um botão
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color, // Define a cor do botão
          padding: EdgeInsets.all(20), // Define o espaçamento interno do botão
        ),
        onPressed: () => _buttonPressed(text), // Define a ação ao pressionar o botão
        child: Text(
          text, // Exibe o texto do botão
          style: TextStyle(fontSize: 20, color: Colors.white), // Define o estilo do texto
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora"), // Define o título da barra superior
        backgroundColor: Colors.blue, // Define a cor da barra superior
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20), // Adiciona espaçamento ao redor do valor exibido
              alignment: Alignment.bottomRight, // Alinha o texto exibido à direita inferior
              child: Text(
                _output, // Exibe o valor atual
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold), // Define o estilo do valor exibido
              ),
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  _buildButton("7", Colors.grey), // Botão para o número 7
                  _buildButton("8", Colors.grey), // Botão para o número 8
                  _buildButton("9", Colors.grey), // Botão para o número 9
                  _buildButton("/", Colors.orange), // Botão para a operação de divisão
                ],
              ),
              Row(
                children: [
                  _buildButton("4", Colors.grey), // Botão para o número 4
                  _buildButton("5", Colors.grey), // Botão para o número 5
                  _buildButton("6", Colors.grey), // Botão para o número 6
                  _buildButton("x", Colors.orange), // Botão para a operação de multiplicação
                ],
              ),
              Row(
                children: [
                  _buildButton("1", Colors.grey), // Botão para o número 1
                  _buildButton("2", Colors.grey), // Botão para o número 2
                  _buildButton("3", Colors.grey), // Botão para o número 3
                  _buildButton("-", Colors.orange), // Botão para a operação de subtração
                ],
              ),
              Row(
                children: [
                  _buildButton("C", Colors.red), // Botão para limpar a calculadora
                  _buildButton("0", Colors.grey), // Botão para o número 0
                  _buildButton("=", Colors.green), // Botão para calcular o resultado
                  _buildButton("+", Colors.orange), // Botão para a operação de adição
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
