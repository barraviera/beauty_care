import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';


class UtilsServices {

  final storage = const FlutterSecureStorage();

  //salvar dado localmente
  Future<void> saveLocalData({required String key, required String data}) async{

    await storage.write(key: key, value: data);
  }

  //recuperar dado salvo localmente
  //String? nullable pois o dado pode nao ser encontrado
  Future<String?> getLocalData({required String key}) async{

    return await storage.read(key: key);
  }

  //remove dado salvo localmente
  Future<void> removeLocalData({required String key}) async{

    await storage.delete(key: key);
  }
  //--- FIM METODOS PARA SALVA, LER E REMOVER O TOKEN LOCALMENTE ---

  //METODO QUE IRÁ RETORNAR O VALOR FORMATADO
  //ESSE METODO RECEBE POR PARAMETRO UM DOUBLE
  //E VAI NOS RETORNAR UMA STRING FORMATADA
  String priceToCurrency(double price){

    NumberFormat numberFormat = NumberFormat.simpleCurrency(locale: 'pt_BR');
    return numberFormat.format(price);

  }

  void showToast({required String message, bool isError = false,}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: isError ? Colors.red : Colors.white,
      textColor: isError? Colors.white: Colors.black,
      fontSize: 14,
    );
  }


}