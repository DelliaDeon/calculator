import 'package:calculator/button_model.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var _userinput = '';
  var _output = '0';

  List<String> _labels = [
    'C', 'DEL', '%', '/',
    '9', '8', '7', 'x',
    '6', '5', '4', '—',
    '3', '2', '1', '+',
    '0', '.', 'ANS', '='
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade100,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        title: Text('Standard Calculator'),
      ),
      drawer: Drawer(),

      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.pink.shade200,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(_output, style: TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                            fontWeight: FontWeight.w600,
                          ),),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          child: Text(_userinput, style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w400,
                          ),),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ),
        
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                  ),
                  itemCount: _labels.length,
                  itemBuilder: (context, index){
        
                    if(index == 0 || index == 1){
                      return MyButton(
                        onTap: (){
                          setState(() {
                            if(index == 0){
                              _userinput = '';
                              _output = '0';
                            }
                            else if(index == 1){
                              _userinput = _userinput.substring(0, _userinput.length - 1);
                            }
                          });
                        },
                        buttonText: _labels[index],
                        color: Colors.pink.shade800,
                        textColor: Colors.pink.shade100,
                      );
                    }
                    else if(index == _labels.length - 2 || index == _labels.length - 1){
                      return MyButton(
                        onTap: (){
                          setState(() {
                            if(index == _labels.length - 1){
                              equalPressed();
                            }
                            else if(index == _labels.length -2){
                              _userinput = _output;
                            }
                          });
                        },
                        buttonText: _labels[index],
                        color: Colors.pink,
                        textColor: Colors.white,
                      );
                    }
                    else{
                      return MyButton(
                        onTap: (){
                          setState(() {
                            _userinput += _labels[index];
                          });
                        },
                        buttonText: _labels[index],
        
                        color: isOperator(_labels[index]) ?
                        Colors.pink.shade200 : Colors.pinkAccent,
        
                        textColor: isOperator(_labels[index]) ?
                        Colors.pink.shade800 : Colors.white,
                      );
                    }
        
        
                  }
                ),
              )
            ),
          ],
        ),
      ),
    );
  }

  bool isOperator(String x){
    if(x == '%' || x == 'x' || x == '/' || x == '—' || x == '+' || x == '='){
      return true;
    }
    return false;
  }

  void equalPressed(){
    String finalInput = _userinput;
    finalInput = finalInput.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(finalInput);

    ContextModel cm = ContextModel();

    double eval = exp.evaluate(EvaluationType.REAL, cm);

    _output = eval.toString();

  }

}
