import 'package:beauty_care/src/models/item_salon_model.dart';
import 'package:beauty_care/src/pages/salon/view/salon_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../config/custom_colors.dart';
import '../../../product/view/product_screen.dart';

class ItemSalonTile extends StatelessWidget {

  //INSTANCIAMOS A CLASSE ITEM MODEL ONDE TERÁ OS PRODUTOS FICTICIOS
  final ItemSalonModel itemSalonModel;

  ItemSalonTile({
    Key? key,
    required this.itemSalonModel,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {


    return

      Stack(

        children: [

          //CONTEUDO DO TILE
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (c) {
                  return SalonScreen(itemSalonModel: itemSalonModel);
                }),
              );
            },

            child:
            Card(
              elevation: 1,
              shadowColor: Colors.grey.shade300,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),

              child: Padding(
                padding: const EdgeInsets.all(12),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,

                  children: [

                    //imagem
                    Expanded(
                      child: Hero(
                        tag: itemSalonModel.imgUrl, //tag unica
                        child: Image.network(itemSalonModel.imgUrl),
                      ),
                    ),

                    Text(
                      itemSalonModel.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text(
                      itemSalonModel.phone,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),


                  ],
                ),
              ),
            ),

          ),

          Positioned(
            top: 4,
            right: 4,
            child: Container(

              height: 30,
              width: 45,
              decoration: BoxDecoration(
                color: CustomColors.customSwatchColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  topRight: Radius.circular(20),
                ),
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [

                  Text(
                    itemSalonModel.distance.toString(),
                    style: const TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),
                  ),

                  const Text(
                    'Km',
                    style: TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),
                  ),

                ],
              ),
            ),
          ),


        ],
      );

  }


}