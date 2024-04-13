import 'package:flutter/material.dart';
import 'package:barbearia_dos_brabos/_common/my_colors.dart';

void showCustomSnackBar({
  required BuildContext context,
  required String text,
  bool isError = true,
  int duration = 3,
}) {
  SnackBar snackBar = SnackBar(
    content: Text(
      text,
      style: const TextStyle(color: MyColors.greyText),
    ),
    backgroundColor: isError ? Colors.red : Colors.green,
    duration: Duration(seconds: duration),
    showCloseIcon: true,
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
