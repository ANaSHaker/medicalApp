import 'package:dio/dio.dart';

class DioHelper{

  static Dio ?dio;



  static init(){

    dio = Dio(
      BaseOptions(
          baseUrl:'https://c08e-154-134-29-109.eu.ngrok.io',
          receiveDataWhenStatusError: true,
          headers: {
            'Content-Type':'application/x-www-form-urlencoded'
          }
      ) ,
    );

  }

  static Future<Response> getDate({
    required String url,
    Map <String,dynamic> ?query
  })
  async{

    return await dio!.get(url,queryParameters: query) ;

  }

  static Future<Response> postDate({
    required String url,
    Map <String,dynamic> ?query,
    required Map<String,dynamic> data,
  })
  async{

    return await dio!.post(url,queryParameters: query,data: data) ;

  }



}
