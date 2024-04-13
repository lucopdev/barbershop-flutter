import 'package:barbearia_dos_brabos/_common/my_colors.dart';
import 'package:flutter/material.dart';

InputDecoration getInputDecoration(String label) {
  return InputDecoration(
    filled: true,
    fillColor: Colors.white,
    label: Text(label),
    contentPadding: const EdgeInsets.only(left: 20),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(50),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(50),
      borderSide: const BorderSide(color: Colors.black),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(50),
      borderSide: const BorderSide(color: MyColors.secondary, width: 3),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(50),
      borderSide: const BorderSide(color: Colors.red, width: 3),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(50),
      borderSide: const BorderSide(color: Colors.red, width: 3),
    ),
  );
}

InputDecoration getPasswordInputDecoration(
    String label, Function fn, bool isObscured) {
  return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      label: Text(label),
      contentPadding: const EdgeInsets.only(left: 20),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: const BorderSide(color: Colors.black),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: const BorderSide(color: Colors.blue, width: 3),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: const BorderSide(color: Colors.red, width: 3),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: const BorderSide(color: Colors.red, width: 3),
      ),
      suffixIcon: IconButton(
        icon: Icon(isObscured ? Icons.visibility_off : Icons.visibility),
        onPressed: () => fn(),
      ));
}
