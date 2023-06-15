import 'package:aafia/businessLogic/controllers/theme_controller.dart';
import 'package:aafia/data/dataSources/remote/dio/logging_interceptor.dart';
import 'package:aafia/services/navigation_service.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/dataSources/remote/dio/dio_client.dart';
import '../utils/app_constants.dart';

final sl = GetIt.instance;

Future<void> init() async {

// Core
  // sl.registerLazySingleton(() => NetworkInfo(sl()));
  sl.registerLazySingleton(() => DioClient(AppConstants.BASE_URL, sl(), loggingInterceptor: sl(), sharedPreferences: sl()));

 // Provider
  sl.registerFactory(() => ThemeController());



  //services
    sl.registerLazySingleton(() => NavigationService());



  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => LoggingInterceptor());
  // sl.registerLazySingleton(() => Connectivity());
}