import 'package:dio/dio.dart';

class DioDataSource {
  static DioDataSource?  _instanace;
  DioDataSource._singelton();
static DioDataSource  getInsatance(){

if (_instanace==null) {
  _instanace=  DioDataSource._singelton();
}

return _instanace!;
}
Dio  getDioInstance(){
   var dio = Dio(BaseOptions(
        validateStatus: (_) => true,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
      ));
// dio.interceptors.add(DioCacheManager(CacheConfig(baseUrl: "http://www.google.com")).interceptor);

      return dio;
}


}