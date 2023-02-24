import 'package:beauty_care/src/models/cart_item_model.dart';
import 'package:beauty_care/src/pages/common_widgets/quantity_widget.dart';
import 'package:beauty_care/src/services/utils_services.dart';
import 'package:flutter/material.dart';

import '../../../config/custom_colors.dart';

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
            content: const Text('Deseja realmente remover o item da sua agenda?'),
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
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),

      child: ListTile(

        //IMAGEM
        leading: Image.network(
          cartItem.item.imgUrl,
          height: 60,
          width: 60,
        ),

        //TITULO
        title: Text(
          cartItem.item.title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),

        //PREÇO
        subtitle: Text(
          utilsServices.priceToCurrency( cartItem.item.price ),
          style: TextStyle(
            color: CustomColors.customSwatchColor,
            fontWeight: FontWeight.bold,
          ),
        ),

        //BOTAO REMOVER
        trailing: QuantityWidget(
          color: Colors.red,
          icon: Icons.delete_forever,
          onPressed: () async{
            bool? result = await showRemoveConfirmation();
            if(result == true){
              //remove(cartItem);
            }

          },
        ),

      ),
    );


  }

}
