import 'package:beauty_care/src/config/custom_colors.dart';
import 'package:beauty_care/src/models/cart_item_model.dart';
import 'package:beauty_care/src/pages/cart/controller/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:beauty_care/src/config/app_data.dart' as appData;
import 'package:get/get.dart';
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

      appBar: AppBar(
        title: const Text('Agenda'),
      ),

      body: GetBuilder<CartController>(

        builder: (controller) {
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            //animação
            physics: BouncingScrollPhysics(),
            itemBuilder: (_, index){
              return CartTile(cartItem: controller.cartItems[index]);
            },
            separatorBuilder: (_, index) => const SizedBox(height: 10,),
            itemCount: controller.cartItems.length,
          );
        }

      ),

    );
  }
}
