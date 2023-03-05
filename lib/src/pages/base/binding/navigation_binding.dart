import 'package:beauty_care/src/pages/base/controller/navigation_controller.dart';
import 'package:beauty_care/src/pages/product/controller/product_controller.dart';
import 'package:get/get.dart';

class NavigationBinding extends Bindings{

  @override
  void dependencies() {

    //vamos injetar na memoria
    //o lazyPut nao vai injetar assim que o app for iniciado, mas sim, sempre quando nós precisarmos usar o objeto
    Get.lazyPut(() => NavigationController());

    Get.lazyPut(() => ProductController());



  }



}