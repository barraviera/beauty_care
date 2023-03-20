import 'package:beauty_care/src/models/cart_item_model.dart';
import 'package:beauty_care/src/pages/common_widgets/quantity_widget.dart';
import 'package:beauty_care/src/services/utils_services.dart';
import 'package:flutter/material.dart';

import '../../../config/custom_colors.dart';
import 'cart_status_widget.dart';

class CartTile extends StatelessWidget {

  final CartItemModel cartItem;
  final UtilsServices utilsServices = UtilsServices();


  CartTile({
    Key? key,
    required this.cartItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //CRIAR A CLASSE QUE MOSTRARÁ UM MODAL PARA CONFIRMAR A REMOÇÃO DO ITEM DA AGENDA
    //RETORNARÁ UM BOOL NULLABLE
    Future<bool?>showRemoveConfirmation()
    {
      return showDialog<bool>(
        context: context,
        builder: (context){
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: const Text('Confirmação'),
            content: const Text('Deseja realmente cancelar o serviço?'),
            actions: [
              TextButton(
                  onPressed: (){
                    Navigator.of(context).pop(false);
                  },
                  child: const Text('Não'),
              ),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                  onPressed: (){
                    //remove(calendarItem);
                    Navigator.of(context).pop(true);
                  },
                  child: const Text('Sim'),
              ),
            ],
          );
        },
      );
    }

    return Card(
      //margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),

      child: Theme(
        //para que o divisor nao apaeça mais
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(

          expandedCrossAxisAlignment: CrossAxisAlignment.start,

          title: Column(
            mainAxisSize: MainAxisSize.min,
            //alinhamos a esquerda
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(cartItem.item.title),

              /*
              Text(utilsServices.formatDateTime(cartItem.schedule!.date), style: const TextStyle(
                fontSize: 12,
                color: Colors.black,
              ),),

               */

            ],
          ),

          //aplica espaçamento nos filhos
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),

          children: [

            SizedBox(
              height: 150,

              child: Row(

                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                       children: [

                          Text('(14) 98855-7744'),
                          SizedBox(height: 10,),
                          Text('Rua Regine Senger Maioral, 1-1110, Jardim Colonial - Bauru'),
                         SizedBox(height: 20,),
                      ],
                    ),
                  ),

                  //Divisão
                  VerticalDivider(
                    color: Colors.grey.shade300,
                    thickness: 2,
                    width: 8,
                  ),

                  //Status
                  Expanded(
                    flex: 2,
                    child: CartStatusWidget( status: cartItem.isConfirmed, ),
                  ),
                ],

              ),              
            ),


            //Total
            Text.rich(
              TextSpan(
                style: const TextStyle(
                  fontSize: 20,
                ),
                children: [
                  const TextSpan(text: 'Total ', style: TextStyle(fontWeight: FontWeight.bold),),
                  TextSpan(text: utilsServices.priceToCurrency( cartItem.item.price ), style: const TextStyle(fontWeight: FontWeight.bold),),
                ],
              ),
            ),


          ],
        ),
      ),



    );


  }

}
