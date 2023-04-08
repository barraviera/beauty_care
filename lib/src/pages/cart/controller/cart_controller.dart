import 'package:beauty_care/src/models/cart_item_model.dart';
import 'package:beauty_care/src/models/item_model.dart';
import 'package:beauty_care/src/models/schedule_model.dart';
import 'package:beauty_care/src/pages/auth/controller/auth_controller.dart';
import 'package:beauty_care/src/pages/cart/cart_result/cart_result.dart';
import 'package:beauty_care/src/pages/cart/repository/cart_repository.dart';
import 'package:beauty_care/src/pages/home/view/home_tab.dart';
import 'package:beauty_care/src/services/utils_services.dart';
import 'package:get/get.dart';

//esta classe é basicamente um Controlador GetX
class CartController extends GetxController{

  //vamos iniciar a classe CartRepository onde vem o resultado da requisição
  final cartRepository = CartRepository();
  //vamos chamar o auth controller para podermos pegar o token
  final authController = Get.find<AuthController>();
  final utilsServices = UtilsServices();

  List<CartItemModel> cartItems = [];


  @override
  void onInit() {
    super.onInit();

    //chamar este metodo assim que está classe for instanciada
    getCartItems();
  }



  double cartTotalPrice(){

    double total = 0;

    //vamos percorrer todos os itens do carrinho
    for(final item in cartItems){

      total += item.totalPrice();
    }

    return total;
  }

  //veja que temos uma classe com o mesmo nome em cart_repository
  //uma depende da outra para funcionar
  Future<void> getCartItems() async{

    final CartResult<List<CartItemModel>> result = await cartRepository.getCartItems(
      //a essa altura nós sabemos que o usuario ja terá um token e que
      //authController.user.token nao será nulo entao colocaremos um ponto !
      token: authController.user.token!,
      userId: authController.user.id!,
    );

    result.when(
        success: (data){

          //Todos os itens do carrinho ja estarão dentro da lista List<CartItemModel> cartItems = [];
          //vamos ordenar os pedidos usando ordenação de cascata data..sort( (a, b) =>  b.createdAt.compareTo(a.createdAt));
          //onde "a" e "b" são o primeiro e segundo pedido e depois o "a" será o terceiro pedido e o "b" o quarto e assim constantemente
          //iremos ordenar da data mais atual(createdAt) para a mais antiga(createdAt)
          //colocamos interrogação ! no createdAt! para indicar que ele não é nulo neste ponto do codigo
          cartItems = data..sort( (a, b) =>  b.schedule.compareTo(a.schedule));
          update();

        },
        error: (message){
          utilsServices.showToast(message: message, isError: true);
        },
    );
  }

  //recuperar o id do item
  int getItemIndex(ItemModel item){

    return cartItems.indexWhere((itemInList) => itemInList.id == item.id);

  }

  //metodo para adicionar produto ao carrinho
  Future<void> addItemToCart({ required ItemModel item, int quantity = 1, required DateTime schedule,
    required double price, required String scheduleId }) async{

    int itemIndex = getItemIndex(item);

    //se for maior ou igual a zero quer dizer que ja existe na nossa listagem
    if(itemIndex >= 0){

      cartItems[itemIndex].quantity += quantity;

    }else{//nao existe

      final CartResult<String> result = await cartRepository.addItemToCart(
        userId: authController.user.id!,
        token: authController.user.token!,
        productId: item.id,
        schedule: schedule.toIso8601String(),
        quantity: quantity,
        price: price,
        scheduleId: scheduleId,
      );

      result.when(
        success: (cartItemId){

          cartItems.add(
            CartItemModel(
              item: item,
              id: cartItemId,
              quantity: quantity,
              isConfirmed: false,
              schedule: schedule,
              price: price,
            ),
          );



        },
        error: (message){
          utilsServices.showToast(message: message, isError: true);
        },
      );



    }
    update();
  }


}