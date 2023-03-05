

import 'package:beauty_care/src/models/schedule_model.dart';
import 'package:beauty_care/src/pages/product/result/product_result.dart';

import '../../../constants/endpoints.dart';
import '../../../services/http_manager.dart';

class ProductRepository {

  final HttpManager _httpManager = HttpManager();

  //metodo para recuperar os horarios
  Future getSchedule({ required String productId }) async {

    final result = await _httpManager.restRequest(
      url: Endpoints.getSchedule,
      method: HttpMethods.post,
      body: {
        productId: productId,
      },
    );

    //se result for diferente de nulo quer dizer que temos os produtos
    if(result['result'] != null){

      //no schedules teremos a nossa lista com todos os produtos vindos do backend
      List<ScheduleModel> schedules = List<Map<String, dynamic>>.from(result['result']).map( ScheduleModel.fromJson ).toList();


      return ProductResult<List<ScheduleModel>>.success(schedules);

    }else{
      return ProductResult.error('Ocorreu um erro inesperado ao recuperar os itens');
    }
  }


}