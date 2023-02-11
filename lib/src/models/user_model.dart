import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  //com essa anotacao ele vai pegar o fullname que vem do parse e jogar pra variavel name
  @JsonKey(name: 'fullname')
  String? name;
  String? email;
  String? phone;
  String? cpf;
  String? password;
  String? id;
  String? token;

  //construtor
  UserModel({
    this.name,
    this.email,
    this.phone,
    this.cpf,
    this.password,
    this.id,
    this.token,
  });

  //vamos pegar o map que vem do parse e atribuir a essas variaveis usando o plugin json_serializable
  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  //aqui faremos o inverso, iremos pegar os dados das variaveis e transformar em um map para enviar para o parse serve usando json_serializable
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  //apos criarmos os fromjson e tojson e fazer os importes, temos que rodar no terminal o comando: flutter pub run build_runner build

  @override
  String toString() {
    return 'UserModel(name: $name, email: $email, phone: $phone, cpf: $cpf, password: $password, id: $id, token: $token)';
  }


}