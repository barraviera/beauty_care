import 'package:dio/dio.dart';

abstract class HttpMethods{

  static const String post = 'POST';
  static const String get = 'GET';
  static const String put = 'PUT';
  static const String delete = 'DELETE';
  static const String patch = 'PATCH';

}

class HttpManager {

  Future<Map> restRequest({
    required String url,
    required String method,
    Map? headers, //nullable
    Map? body, //nullable
  }) async{

    //Headers da requisição
    final defaultHeaders = headers?.cast<String, String>() ?? {}
      ..addAll({
        'content-type': 'application/json',
        'accept': 'application/json',
        //os dois dados abaixo encontraremos no back4app na aba App Settings>Security & Keys
        'X-Parse-Application-Id': 'gXEooe618pUsZd02vvO1lWzhsvB1w6GccNvKWL47',
        'X-Parse-REST-API-Key': 'y86PuLXQMO7xg4p5Sc2VadIRar8INqjeRwUPuY5p',
      });

    Dio dio = Dio();

    try{

      Response response = await dio.request(
        url,
        options: Options(
          headers: defaultHeaders,
          method: method,
        ),
        data: body,
      );

      //retorno do resultado do server do backend
      return response.data;

    } on DioError catch(error){
      //erro relacionado ao Dio request
      return error.response?.data ?? {};

    } catch(error){
      //retorno de map vazio para erro generalizado
      return {};

    }

  }

}