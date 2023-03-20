import 'package:beauty_care/src/models/schedule_model.dart';
import 'package:beauty_care/src/pages/product/repository/product_repository.dart';
import 'package:beauty_care/src/pages/product/result/product_result.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../../services/utils_services.dart';

class ProductController extends GetxController {

  List<ScheduleModel> allSchedule = [];
  final productRepository = ProductRepository();
  final utilsServices = UtilsServices();



  //recuperar os horarios
  Future<void> getSchedule({required String productId}) async{

    //Por enquanto vamos passar um id fixo pra testar
    ProductResult<List<ScheduleModel>> result = await productRepository.getSchedule(
        productId: productId,
    );


    result.when(
      success: (schedules){

        //Adicionamos os horarios recuperados do parse em uma lista do tipo ScheduleModel
        allSchedule = schedules;

        print( allSchedule );

      },
      error: (message){
        utilsServices.showToast(message: message, isError: true);
      },
    );

    //usamos update para quando estamos trabalhando com GetBuilder na interface
    update();

  }


}