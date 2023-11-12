 import 'package:app/theme/app_theme.dart';
import 'package:flutter/material.dart';

class MyTextButton extends StatelessWidget {
   final String label;
  final double width;
  final void Function() onPressed;

   const MyTextButton({
    required this.onPressed,
    required this.label,
    required this.width,
    super.key});
 
   @override
   Widget build(BuildContext context) {
     return  SizedBox(
       width: width,
      child: TextButton(
        
        onPressed: onPressed,
        child: Text(label,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w100,
          color: Colors.white,
        ),
        ),
        
      
        
      ),
    );
   }
 }
 
 
