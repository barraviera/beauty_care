import 'package:beauty_care/src/config/custom_colors.dart';
import 'package:beauty_care/src/models/cart_item_model.dart';
import 'package:beauty_care/src/pages/cart/controller/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:beauty_care/src/config/app_data.dart' as appData;
import 'package:get/get.dart';
import '../../services/utils_services.dart';
import 'components/cart_tile.dart';

class CartTab extends StatefulWidget {
  const CartTab({Key? key}) : super(key: key);

  @override
  State<CartTab> createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {

  final UtilsServices utilsServices = UtilsServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('Carrinho'),
      ),

      body: Column(
        children: [

          //Lista de itens do carrinho
          Expanded(
              child: GetBuilder<CartController>(

                builder: (controller){

                  //controller é o nosso controlador do carrinho
                  //cartItems é a listagem dos nossos itens do carrinho
                  //isEmpty para verificar se a lista de itens está vazia
                  if(controller.cartItems.isEmpty){

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.remove_shopping_cart,
                          size: 40,
                          color: CustomColors.customSwatchColor,
                        ),
                        const Text('Não há itens no carrinho'),
                      ],
                    );

                  }

                  //Aqui mostra os itens
                  return ListView.builder(
                    itemCount: controller.cartItems.length,
                    itemBuilder: (_, index){
                      return CartTile(
                        cartItem: controller.cartItems[index],
                      );
                    },
                  );
                },
              ),
          ),


          Container(

            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 3,
                  spreadRadius: 2,
                ),
              ],
            ),

            child: Column(

              crossAxisAlignment: CrossAxisAlignment.stretch,

              children: [

                Padding(
                  padding: const EdgeInsets.only(left: 8),

                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      const Text(
                        'Total geral',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      GetBuilder<CartController>(
                        builder: (controller) {
                          return Text(
                            utilsServices.priceToCurrency(
                              controller.cartTotalPrice(),
                            ),
                            style: TextStyle(
                              fontSize: 23,
                              color: CustomColors.customSwatchColor,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }
                      ),

                    ],
                  ),
                ),

                SizedBox(

                  height: 50,
                  child: ElevatedButton(

                    style: ElevatedButton.styleFrom(
                      primary: CustomColors.customSwatchColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    onPressed: () {  },

                    child: const Text(
                      'Concluir pedido',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),

                  ),
                ),

              ],

            ),

          ),


        ],
      ),

    );
  }
}
