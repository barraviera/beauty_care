
//iremos receber uma String? nullable
String authErrorsString(String? code){

  switch(code){
    case 'INVALID_CREDENTIALS':
      return 'E-mail e/ou senha inválido(s)';

    case 'Invalid session token':
      return 'Token inválido';

    case 'INVALID_FULLNAME':
      return 'Ocorreu um erro ao cadastrar usuário: Nome inválido';

    case 'INVALID_PHONE':
      return 'Ocorreu um erro ao cadastrar usuário: Celular inválido';

    case 'INVALID_CPF':
      return 'Ocorreu um erro ao cadastrar usuário: CPF inválido';

      //quando estamos dentro de um switch que retorna alguma coisa o break nao é mais necessario

    default:
      return 'Um erro indefinido ocorreu';

  }

}