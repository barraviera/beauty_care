
import 'package:beauty_care/src/pages/home/controller/home_controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {

  @override
  void dependencies() {

    //injetamos a classe HomeController usando binding
    Get.put( HomeController() );

  }



}