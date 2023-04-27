import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  InputField({
    super.key,
    @required this.hintText,
    required this.onChanged,
    required this.isPassword
  });

  final String? hintText;
  final void Function(String)? onChanged;
  final bool isPassword;
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      obscureText: isPassword?true:false,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.black54),
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0))
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.lightBlueAccent,width: 1,
            ),
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.lightBlueAccent,width: 2),
              borderRadius: BorderRadius.all(Radius.circular(32.0))
          )
      ),
    );
  }
}