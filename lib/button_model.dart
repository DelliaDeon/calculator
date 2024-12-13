import 'package:flutter/material.dart';


class MyButton extends StatelessWidget {
  final String buttonText;
  final Color color;
  final Color textColor;
  final onTap;

  MyButton({
    super.key,
    required this.buttonText,
    required this.color,
    required this.textColor,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GestureDetector(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: Container(
            color: color,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Center(
                child: Text(buttonText, style: TextStyle(
                  color: textColor,
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),)
              ),
            ),
          ),
        ),
      ),
    );
  }
}

