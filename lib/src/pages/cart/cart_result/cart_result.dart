import 'package:freezed_annotation/freezed_annotation.dart';

//vamos indicar que terá uma participação nesta classe a classe que será auto gerada
part 'cart_result.freezed.dart';

@freezed
class CartResult<T> with _$CartResult<T>{

  //vamos ter dois possiveis casos, sucesso e erro

  //como vamos ter tipos diferentes em cada result vamos colocar o T generic
  factory CartResult.success(T data) = Success;

  factory CartResult.error(String message) = Error;

}