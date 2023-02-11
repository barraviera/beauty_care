import 'package:beauty_care/src/models/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_result.freezed.dart';

@freezed
class AuthResult with _$AuthResult{

  //para retonar essas mensagens de sucesso e de erro estamos usando o plugin freezed

  //iremos retornar um UserModel caso o login do usuario seja um sucesso
  factory AuthResult.success(UserModel user) = Success;

  //em caso de erro iremos retornar uma mensagem
  factory AuthResult.error(String message) = Error;

  //apos essas linhas temos que rodar no terminal flutter pub run build_runner build

}
