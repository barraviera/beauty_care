

import 'package:get/get.dart';

String? emailValidator (String? email){

  if(email == null || email.isEmpty){
  return 'Digite seu e-email';
  }

  if(!email.isEmail){
  return 'Digite um e-email válido';
  }
  return null;
}


String? passwordValidator (password){

  if(password == null || password.isEmpty){
  return 'Digite sua senha';
  }

  if(password.length < 7){
  return 'Digite uma senha com pelos menos 7 caracteres';
  }

  return null;
}


String? nameValidator (String? name){

  if(name == null || name.isEmpty){
    return 'Digite um nome';
  }

  //o split serve para dividir uma string baseado em um padrao, e aqui iremos usar o espaço entre as palavras
  //para saber se o nome que o usuario digitou é composto
  final names = name.split(' ');

  //vamos pegar o tamanho dessa lista de nomes
  if(names.length == 1) return 'Digite seu nome completo';

  return null;

}

String? phoneValidator(String? phone){

  if(phone == null || phone.isEmpty){
    return 'Digite um celular';
  }

  //isPhoneNumber do pacote GetX faz todas as verificações se é realmente um telefone
  if(phone.length < 14 || !phone.isPhoneNumber){
    return 'Digite um número válido';
  }

  return null;
}

String? cpfValidator(String? cpf){

  if(cpf == null || cpf.isEmpty){
    return 'Digite um CPF';
  }

  if(!cpf.isCpf) return 'Digite um CPF válido';

  return null;
}
