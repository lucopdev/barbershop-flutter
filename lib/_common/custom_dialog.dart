import 'package:barbearia_dos_brabos/_common/my_colors.dart';
import 'package:flutter/material.dart';

showCustomDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        elevation: 10,
        backgroundColor: Color.fromARGB(10, 0, 0, 0),
        child: Container(
          width: 200,
          height: 200,
          child: Center(
            child: SizedBox(
              width: 50,
              height: 50,
              child: CircularProgressIndicator(
                color: MyColors.lightText,
                strokeWidth: 5,
              ),
            ),
          ),
        ),
      );
    },
  );
}
