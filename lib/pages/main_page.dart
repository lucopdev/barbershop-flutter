import 'package:barbearia_dos_brabos/_common/my_colors.dart';
import 'package:barbearia_dos_brabos/components/menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MainPage extends StatefulWidget {
  final User user;

  MainPage({required this.user, super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedHour = TimeOfDay.now();

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 30)),
    ).then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  _showTimePicker() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then(
      (pickedHour) {
        if (pickedHour == null) return;
        setState(() {
          _selectedHour = pickedHour;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primary,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: MyColors.secondary),
        toolbarHeight: 100,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Bem vindo ${widget.user.displayName}',
                  style: const TextStyle(
                    color: MyColors.secondary,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ],
        ),
        backgroundColor: MyColors.primary,
      ),
      drawer: Drawer(
        backgroundColor: MyColors.secondary,
        elevation: 5,
        width: MediaQuery.of(context).size.width * 0.8,
        child: Menu(),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              'Para que dia precisa?',
              style: TextStyle(
                color: MyColors.secondary,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Dia: ',
                  style: TextStyle(color: MyColors.secondary, fontSize: 20),
                ),
                TextButton(
                  onPressed: _showDatePicker,
                  child: Text(
                    '${DateFormat('dd / MM / y').format(_selectedDate)}',
                    style: TextStyle(color: MyColors.secondary, fontSize: 20),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(MyColors.secondary)),
              onPressed: () => {},
              child: Text(
                'Vamos ver os barbeiros(as) disponíveis',
                style: TextStyle(color: MyColors.darkText),
              ),
            )
          ],
        ),
      ),
    );
  }
}
