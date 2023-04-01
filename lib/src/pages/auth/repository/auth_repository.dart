import 'package:beauty_care/src/constants/endpoints.dart';
import 'package:beauty_care/src/models/user_model.dart';
import 'package:beauty_care/src/pages/auth/repository/auth_errors.dart' as auth_errors;
import 'package:beauty_care/src/pages/auth/result/auth_result.dart';
import 'package:beauty_care/src/services/http_manager.dart';

class AuthRepository{

  final HttpManager _httpManager = HttpManager();

  //externalizando em um metodo que retorna o usuario ou um erro
  AuthResult handleUserOrError(Map<dynamic, dynamic> result){

    //se a chave result nao for nulo quer dizer que o signin funcionou
    if(result['result'] != null){

      //passamos o map result que vem como resposta do parse, para a nossa factory que atribui o map nas nossas variaveis
      final user = UserModel.fromJson(result['result']);
      //em caso de sucesso no login passamos o user como parametro para o auth_result
      return AuthResult.success(user);

    }else{
      //em caso de erro no login
      return AuthResult.error( auth_errors.authErrorsString( result['error'] )  );
    }

  }

  Future<bool> changePassword({
    required String email,
    required String currentPassword,
    required String newPassword,
    required String token
  }) async{

    final result = await _httpManager.restRequest(
      url: Endpoints.changePassword,
      method: HttpMethods.post,
      body: {
        'email': email,
        'currentPassword': currentPassword,
        'newPassword': newPassword
      },

      headers: {
        'X-Parse-Session-Token': token,
      }
    );

    //se erro for igual a nulo a alteração de senha deu certo
    return result['error'] == null;

  }


  //metodo para validacao de token
  Future<AuthResult> validateToken(String token) async{

    final result = await _httpManager.restRequest(
      url: Endpoints.validateToken,
      method: HttpMethods.post,
      headers: {
        'X-Parse-Session-Token' : token,
      },
    );

    //externalizamos o retorno de sucesso ou erro em um metodo para nao ficar repetindo codigo
    return handleUserOrError( result );
  }

  //lembre-se que o AuthResult a gente usa o freezed pra gerar o sucesso ou erro e retornar isso pra cá, que sao os reultados possiveis na hora do login
  Future<AuthResult> signIn({required String email, required String password}) async{

    final result = await _httpManager.restRequest(
      url: Endpoints.signin,
      method: HttpMethods.post,

      body: {
        'email': email,
        'password': password,
      },
    );
    //externalizamos o retorno de sucesso ou erro em um metodo para nao ficar repetindo codigo
    return handleUserOrError( result );
  }

  //metodo de cadastrar usuario
  Future<AuthResult> signUp(UserModel user) async{

    final result = await _httpManager.restRequest(
      url: Endpoints.signup,
      method: HttpMethods.post,
      body: user.toJson(),
    );

    print(user);

    //externalizamos o retorno de sucesso ou erro em um metodo para nao ficar repetindo codigo
    return handleUserOrError( result );
  }

  //metodo para resetar senha
  Future<void> resetPassword(String email) async{

    await _httpManager.restRequest(
      url: Endpoints.resetPassword,
      method: HttpMethods.post,
      body: {'email': email}
    );

  }


}