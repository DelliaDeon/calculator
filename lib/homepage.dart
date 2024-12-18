import 'package:calculator/button_model.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:provider/provider.dart';

import 'themes/theme_provider.dart';

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
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        title: Text('Standard Calculator'),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            ToggleButtons(
              children: [
                Icon(Icons.light_mode),
                Icon(Icons.dark_mode_outlined)
              ],
              onPressed: (int index){
                Provider.of<ThemeProvider>(context, listen: false).changeTheme();
              },
              isSelected: [
                !isDarkMode, isDarkMode
              ],
            ),
          ],
        ),
      ),

      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
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
                        color: Theme.of(context).colorScheme.primary,
                        textColor: Theme.of(context).scaffoldBackgroundColor,
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
                        color: Theme.of(context).colorScheme.tertiary,
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
                        Theme.of(context).colorScheme.secondary : Theme.of(context).colorScheme.inversePrimary,

                        textColor: isOperator(_labels[index]) ?
                        Theme.of(context).colorScheme.primary : Colors.white,
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
