import 'package:flutter/material.dart';

class DropdownSchedule extends StatefulWidget {
  DropdownSchedule({Key? key}) : super(key: key);

  @override
  State<DropdownSchedule> createState() => _DropdownScheduleState();
}

class _DropdownScheduleState extends State<DropdownSchedule> {
  List<String> listaHorarios = ['item 1', 'item 2', 'item 3', 'item 4','item 5'];

  String? valorEscolhido;

  @override
  Widget build(BuildContext context) {
    return Container(

      child: DropdownButton<String>(

        value: valorEscolhido,
        items: listaHorarios.map((e) {

          return DropdownMenuItem<String>(
            value: e,
            child: Text( e ),
          );

        }).toList(),

        onChanged: (escolha) => setState(() => valorEscolhido = escolha),

      ),

    );
  }
}
