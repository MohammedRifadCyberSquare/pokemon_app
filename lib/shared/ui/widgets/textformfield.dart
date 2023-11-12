import 'package:app/shared/utils/sizes.dart';
import 'package:app/theme/app_theme.dart';
import 'package:flutter/material.dart';

class PokeTextField extends StatefulWidget {
  const PokeTextField({
    required this.label,
    required this.prefixIcon,
    this.isPassword = false,
    required this.textController,
    required this.TextInputType,
    super.key,
  });

  final String label;
  final IconData prefixIcon;
  final bool? isPassword;
  final TextEditingController textController;
  final TextInputType;

  @override
  State<PokeTextField> createState() => _PokeTextFieldState();
}

class _PokeTextFieldState extends State<PokeTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: widget.textController,
      style: TextStyle(
        fontFamily: 'circular',
        color: FormColors.fieldTextcolor,
        fontSize: 18,
      ),
      obscureText: widget.isPassword ?? false,
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: TextStyle(
            fontFamily: 'circular',
            fontSize: 18,
            color: Colors.white.withOpacity(0.4)),

        filled: true,
        fillColor: FormColors.fieldBackgroundColor.withOpacity(0.25),
        //enabled
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(fieldBorderRadius),
        ),

        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppTheme.primaryColor, width: 2),
          borderRadius: BorderRadius.circular(fieldBorderRadius),
        ),

        contentPadding: fieldPadding,

        prefixIcon: Icon(
          widget.prefixIcon,
          color: Colors.white.withOpacity(0.4),
        ),
      ),
    );
  }
}
