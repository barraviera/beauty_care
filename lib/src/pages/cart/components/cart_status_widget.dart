import 'package:beauty_care/src/config/custom_colors.dart';
import 'package:flutter/material.dart';

class CartStatusWidget extends StatelessWidget {

  final bool status;

  const CartStatusWidget({
    Key? key,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [

        const _StatusDot(isActive: true, title: 'Solicitação de agendamento',),

        const _CustomDivider(),

        _StatusDot(isActive: status, title: (status) ? 'Confirmado pelo salão' : 'Aguardando confirmação',),

      ],

    );
  }
}

class _CustomDivider extends StatelessWidget {
  const _CustomDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      height: 10,
      width: 2,
      color: Colors.grey.shade300,
    );
  }
}


class _StatusDot extends StatelessWidget {

  final bool isActive;
  final String title;

  const _StatusDot({
    Key? key,
    required this.isActive,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(

      children: [
        
        //Dot
        Container(
          alignment: Alignment.center,
          height: 20,
          width: 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
                color: Colors.green,
            ),

            color: isActive ? Colors.green : Colors.transparent,
          ),
          child: isActive ? const Icon(Icons.check, size: 13, color: Colors.white,) : const SizedBox.shrink(),
        ),

        const SizedBox(width: 5,),

        //Texto
        Expanded(
            child: Text(title, style: const TextStyle(fontSize: 12,),),
        ),
        
      ],

    );
  }
}

