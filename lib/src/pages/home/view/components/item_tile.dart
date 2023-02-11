import 'package:beauty_care/src/config/custom_colors.dart';
import 'package:beauty_care/src/pages/product/product_screen.dart';
import 'package:beauty_care/src/services/utils_services.dart';
import 'package:flutter/material.dart';
import '../../../../models/item_model.dart';



class ItemTile extends StatelessWidget {

  //INSTANCIAMOS A CLASSE ITEM MODEL ONDE TERÁ OS PRODUTOS FICTICIOS
  final ItemModel item;
  final UtilsServices utilsServices = UtilsServices();

  ItemTile({
    Key? key,
    required this.item,
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
                    return ProductScreen(item: item,);
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
                          tag: item.imgUrl, //tag unica
                          child: Image.network(item.imgUrl),
                        ),
                      ),

                      Text(
                        item.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Text(
                        item.salonName,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),

                      Text(
                        utilsServices.priceToCurrency( item.price ),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: CustomColors.customSwatchColor,
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
                      item.distance.toString(),
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
