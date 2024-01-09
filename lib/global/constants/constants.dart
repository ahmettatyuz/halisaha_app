// ignore_for_file: constant_identifier_names

import 'package:dio/dio.dart';

// const String API_BASEURL = "https://127.0.0.1:7221";
// const String API_BASEURL = "https://172.20.10.7:7221";
// const String API_BASEURL = "http://192.168.43.216:5290";
const String API_BASEURL = "http://localhost:5290";
const String SECRET_KEY = "ahmetHalisahaProjesiDeneme123123123123";

final dio = Dio(
  BaseOptions(
    validateStatus: (status) {
      return status != null && status <= 500;
    },
  ),
);
