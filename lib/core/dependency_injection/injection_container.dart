import 'package:base_templet/core/client/dio_provider.dart';
import 'package:base_templet/core/handle_controller/handle_cubit.dart';
import 'package:base_templet/core/network_info/network_info.dart';
import 'package:base_templet/core/session_management/session.dart';
import 'package:base_templet/core/session_management/session_impl.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';


import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';


final injection = GetIt.instance;
Future<void> initGlobalGetIt() async {
  //! Core
  injection.registerFactory(() => HandleCubit());
  injection
      .registerLazySingleton(() => NetworkInfoImpl(injection()));
  injection.registerLazySingleton(
      () => DioProvider(injection(), injection()));

  injection.registerLazySingleton(() => Dio());
//! External
  final sharedPreferencesInstance = await SharedPreferences.getInstance();
  injection.registerLazySingleton(() => sharedPreferencesInstance);
  injection.registerLazySingleton<GlobalSession>(
      () => GlobalSessionImpl(injection()));
  //
  injection.registerLazySingleton(() => InternetConnectionChecker());
  //
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  injection
      .registerLazySingleton<GlobalKey<NavigatorState>>(() => navigatorKey);
  //
}
