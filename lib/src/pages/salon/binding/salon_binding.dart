import 'package:beauty_care/src/pages/salon/controller/salon_controller.dart';
import 'package:get/get.dart';

//o binding liga a nossa classe controller a alguma tela
class SalonBinding extends Bindings {

  @override
  void dependencies() {

    //vamos injetar a dependencia relacionadas ao Salon
    //agora vamos indicar para o SalonBinding entrar em ação sempre que a salon_tab for aberta
    //e isso a gente tem que colocar em app_pages.dart
    Get.put( SalonController() );

  }



}