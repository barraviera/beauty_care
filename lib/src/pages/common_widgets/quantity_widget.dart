import 'package:flutter/material.dart';

class QuantityWidget  extends StatelessWidget {

  //ATRIBUTOS
  final Color color;
  final IconData icon;
  //FUNCAO ANONIMA QUE NAO IRÁ RETORNAR NADA MAS SERÁ CHAMADA AO CLICARMOS NO ICONE
  final VoidCallback onPressed;

  //CONSTRUTOR
  const QuantityWidget ({
    Key? key,
    required this.color,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Material(
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: onPressed,

        child: Ink(
          height: 25,
          width: 25,

          child: Icon(
            icon,
            color: color,
          ),

        ),
      ),
    );

  }
}
