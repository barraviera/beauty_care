
import 'package:beauty_care/src/models/user_model.dart';
import 'package:beauty_care/src/pages/auth/repository/auth_repository.dart';
import 'package:beauty_care/src/pages/auth/result/auth_result.dart';
import 'package:beauty_care/src/pages_routes/app_pages.dart';
import 'package:beauty_care/src/services/utils_services.dart';
import 'package:get/get.dart';

import '../../../constants/storage_keys.dart';

class AuthController extends GetxController{

  //RxBool é do tipo booleano observável
  RxBool isLoading = false.obs;

  final authRepository = AuthRepository();
  final utilsServices = UtilsServices();

  UserModel user = UserModel();

  //assim que o auth_controller for instanciado ele ja chama o metodo validateToken
  @override
  void onInit(){
    super.onInit();

    validateToken();
  }

  Future<void> validateToken() async{

    //recuperar o token que foi salvo localmente
    String? token = await utilsServices.getLocalData(key: StorageKeys.token);

    //se nao encontramos o token localmente quer dizer que nao fizemos nenhuma autenticacao ainda
    if(token == null){
      Get.offAllNamed( PagesRoutes.signInRoute );
      //colocamos o return para que nada mais abaixo seja executado
      return;
    }

    AuthResult result = await authRepository.validateToken(token);
    result.when(
      success: (user){
        //se o token for válido pegamos o usuario
        this.user = user;
        //salvamos o token localmente
        saveTokenAndProceedToBase();
      },
      error: (message){
        //se o token nao for válido o usuario terá que se autenticar
        //mas antes temos que deslogar o usuario logado
        signOut();
      },
    );

  }

  Future<void> signOut() async{

    //zerar o user
    user = UserModel();

    //remover o token local
    await utilsServices.removeLocalData(key: StorageKeys.token);

    //ir para tela de login
    Get.offAllNamed( PagesRoutes.signInRoute );
  }

  void saveTokenAndProceedToBase(){

    //salvar token localmente
    //podemos colocar o ponto de exclamação ! pois temos certeza que esse campo token nao é nulo
    utilsServices.saveLocalData(key: StorageKeys.token, data: user.token!);

    //ir para tela base
    //navegar ate a tela inicial apos a autenticacao com sucesso
    //offAllNamed retira todas as telas anteriores e add uma nova que iremos informar
    Get.offAllNamed( PagesRoutes.baseRoute );
  }

  //Metodo de Cadastrar usuario
  Future<void> signUp() async{

    isLoading.value = true;

    AuthResult result = await authRepository.signUp(user);

    isLoading.value = false;

    result.when(
      success: (user){
        this.user = user;
        saveTokenAndProceedToBase();
      },
      error: (message){
        utilsServices.showToast(
          message: message,
          isError: true,
        );
      },
    );
  }

  //neste metodo recebemos por parametro o email e a senha que vem da tela de login
  Future<void> signIn({required String email, required String password}) async{

    //indica que estamos carregando a tela
    isLoading.value = true;

    //agora chamamos o metodo que consulta no endpoint e ve se os dados estao corretos
    AuthResult result = await authRepository.signIn(email: email, password: password);

    isLoading.value = false;

    //user e message que conseguimos obter da auth_result
    result.when(
        success: (user){
          //quando colocamos this quer dizer que estamos referenciando a um atributo desta nossa classe que no caso é o UserModel user = UserModel();
          this.user = user;

          saveTokenAndProceedToBase();

        },
        error: (message){
          utilsServices.showToast(
            message: message,
            isError: true,
          );
        });

  }

  //metodo de reset de senha
  Future<void> resetPassword(String email) async{

    await authRepository.resetPassword(email);

  }

}