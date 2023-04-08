import 'package:beauty_care/src/models/item_salon_model.dart';
import 'package:beauty_care/src/pages/salon/result/salon_result.dart';
import '../../../constants/endpoints.dart';
import '../../../services/http_manager.dart';

class SalonRepository {

  final HttpManager _httpManager = HttpManager();


  //metodo para recuperar todos os produtos
  Future<SalonResult<ItemSalonModel>> getAllSalons(Map<String, dynamic> body) async {

    final result = await _httpManager.restRequest(
      url: Endpoints.getAllSalons,
      method: HttpMethods.post,
      body: body,
    );

    //se result for diferente de nulo quer dizer que temos os saloes
    if(result['result'] != null){

      //no data teremos a nossa lista com todos os produtos vindos do backend
      List<ItemSalonModel> data = List<Map<String, dynamic>>.from(result['result']).map( ItemSalonModel.fromJson ).toList();

      print(data);

      return SalonResult<ItemSalonModel>.success(data);

    }else{
      return SalonResult.error('Ocorreu um erro inesperado ao recuperar os itens');
    }
  }


}