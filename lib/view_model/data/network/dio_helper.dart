import 'package:dio/dio.dart';
import 'end_points.dart';
class DioHelper{
  static Dio? dio;
  static void init(){
    dio=Dio(
      BaseOptions(
          baseUrl: EndPoints.todoBaseUrl,
          receiveDataWhenStatusError: true,
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json'}
      ),
    );
  }
  static Future<Response>get({required String endPoint,String?token,Map<String,dynamic>?params})async{
    try{
      dio?.options.headers={
        "Authorization": "Bearer $token",
      };
      Response? response=await dio?.get(endPoint,queryParameters: params);
      return response!;
    }catch(e){
      rethrow;
    }
  }
  static Future<Response>put({required String endPoint,Map<String,dynamic>?body,String? token})async{
    try{
      dio?.options.headers={
        "Authorization": "Bearer $token",
      };
      Response? response= await dio?.put(endPoint,data: body);
      return response!;
    }catch(e){rethrow;}
  }
  static Future<Response>post({required String endPoint,FormData? formData,Map<String,dynamic>?body,String? token})async{
    try{
      dio?.options.headers={
        "Authorization": "Bearer $token",
      };
      Response? response= await dio?.post(endPoint,data: body??formData);
      return response!;
    }catch(e){rethrow;}
  }
  static Future<Response>patch({required String endPoint,Map<String,dynamic>?body,String? token})async{
    try{
      dio?.options.headers={
        "Authorization": "Bearer $token",
      };
      Response? response= await dio?.patch(endPoint,data: body);
      return response!;
    }catch(e){rethrow;}
  }static Future<Response>delete({required String endPoint,Map<String,dynamic>?body,String? token})async{
    try{
      dio?.options.headers={
        "Authorization":"Bearer $token" ,
      };
      Response? response= await dio?.delete(endPoint,data: body);
      return response!;
    }catch(e){rethrow;}
  }
}