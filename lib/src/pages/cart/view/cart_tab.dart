import 'package:beauty_care/src/pages/cart/controller/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/custom_colors.dart';
import '../../../services/utils_services.dart';
import '../components/cart_tile.dart';

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

      //APPBAR
      appBar: AppBar(
        backgroundColor: CustomColors.customContrastColorBottomBar,
        //PARA REMOVER A SOMBRA
        elevation: 0,
        centerTitle: true,
        title: const Text.rich(
          TextSpan(
            style: TextStyle(fontSize: 22,),
            children: [
              TextSpan(text: 'Agenda', style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),

      body: GetBuilder<CartController>(

        builder: (controller) {
          return RefreshIndicator(
            onRefresh: () => controller.getCartItems(),

            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              //animação
              //physics: BouncingScrollPhysics(),
              //AlwaysScrollableScrollPhysics para que sempre apresente comportamento de rolagem na lista
              //para que o RefreshIndicator posso sempre funcionar
              physics: AlwaysScrollableScrollPhysics(),
              itemBuilder: (_, index){
                return CartTile(cartItem: controller.cartItems[index]);
              },
              separatorBuilder: (_, index) => const SizedBox(height: 10,),
              itemCount: controller.cartItems.length,
            ),
          );
        }

      ),

    );
  }
}
