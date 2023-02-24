import 'package:beauty_care/src/pages/cart/controller/cart_controller.dart';
import 'package:get/get.dart';

//hedar o Bindings do GetX
class CartBinding extends Bindings{

  @override
  void dependencies() {
    //aqui vamos injetar o controlador
    //put pq sempre que injetar o objeto ja queremos que ele faça algo
    Get.put(CartController());
  }


}