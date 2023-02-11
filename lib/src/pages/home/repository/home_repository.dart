
import 'package:beauty_care/src/constants/endpoints.dart';
import 'package:beauty_care/src/models/category_model.dart';
import 'package:beauty_care/src/models/item_model.dart';
import 'package:beauty_care/src/pages/home/result/home_result.dart';
import 'package:beauty_care/src/services/http_manager.dart';

class HomeRepository {

  final HttpManager _httpManager = HttpManager();

  //metodo para recuperar todas as categorias
  Future<HomeResult<CategoryModel>> getAllCategories() async{

    //nesse caso de recuperar todas as categorias, não precisaremos de um body
    final result = await _httpManager.restRequest(url: Endpoints.getAllCategories, method: HttpMethods.post);

    //vamos ver se neste retorno do result tem algo
    if(result['result'] != null){

      //lista de categorias
      List<CategoryModel> data = ( List<Map<String, dynamic>>.from( result['result'] ) ).map(CategoryModel.fromJson).toList();
      return HomeResult<CategoryModel>.success( data );

    }else{
      //erro
      return HomeResult.error('Ocorreu um erro inesperado ao recuperar as categorias');
    }
  }

  //metodo para recuperar todos os produtos
  Future<HomeResult<ItemModel>> getAllProducts(Map<String, dynamic> body) async {

    final result = await _httpManager.restRequest(
      url: Endpoints.getAllProducts,
      method: HttpMethods.post,
      body: body,
    );

    //se result for diferente de nulo quer dizer que temos os produtos
    if(result['result'] != null){

      //no data teremos a nossa lista com todos os produtos vindos do backend
      List<ItemModel> data = List<Map<String, dynamic>>.from(result['result']).map( ItemModel.fromJson ).toList();

      return HomeResult<ItemModel>.success(data);

    }else{
      return HomeResult.error('Ocorreu um erro inesperado ao recuperar os itens');
    }

  }

}