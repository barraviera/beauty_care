import 'package:beauty_care/src/constants/endpoints.dart';
import 'package:beauty_care/src/pages/cart/cart_result/cart_result.dart';
import 'package:beauty_care/src/services/http_manager.dart';

import '../../../models/cart_item_model.dart';

class CartRepository {

  //vamos precisar para fazer as requisições
  final _httpManager = HttpManager();

  //metodo para recuperar os itens do carrinho
  //vamos informar que este metodo irá retornar um tipo CartResult
  //vamos dizer tambem que o seu data será um List
  Future<CartResult<List<CartItemModel>>> getCartItems({ required String token, required String userId }) async{

    //quando fizermos a requisição para o servidor ele irá nos retornar uma response
    final result = await _httpManager.restRequest(
      url: Endpoints.getCartItems,
      method: HttpMethods.post,
      headers: {
        //vamos receber o token por parametro
        'X-Parse-Session-Token': token,
      },
      body: {
        //que tambem vamos receber por parametro
        'user': userId,
      }
    );

    //agora vamos tratar o retorno result
    //se result for diferente de nulo quer dizer que temos dados dentro do result
    if( result['result'] != null ){
      //em caso de sucesso, ou seja, caso tenha dados retornados
      //iremos coloca-lo dentro de uma lista do tipo CartItemModel
      //demos o nome dele de data
      //e vamos indicar que estamos criando uma nova lista do tipo Map<Strin, dynamic>
      List<CartItemModel> data = List<Map<String, dynamic>>.from( result['result'])
          .map(CartItemModel.fromJson).toList();


      return CartResult<List<CartItemModel>>.success(data);

    }else{
      //em caso de erro
      return CartResult.error('Ocorreu um erro ao recuperar os itens do carrinho');
    }
  }

  Future<CartResult<String>> addItemToCart({ required String userId, required String token, required String productId,
    required int quantity, required String schedule, required double price, required String scheduleId }) async{

    final result = await _httpManager.restRequest(
      url: Endpoints.addItemToCart,
      method: HttpMethods.post,
      body: {
        'user': userId,
        'quantity': quantity,
        'productId': productId,
        'schedule': schedule,
        'price': price,
        'scheduleId': scheduleId,
      },

      //token do usuario
      headers: {
        'X-Parse-Session-Token': token,
      },
    );

    //se for diferente de nulo quer dizer que teve sucesso
    if( result['result'] != null ){
      //adicionamos o produto
      return CartResult<String>.success( result['result']['id'] );

    }else{
      //erro
      return CartResult.error('Não foi possível adicionar item no carrinho');
    }

  }

}