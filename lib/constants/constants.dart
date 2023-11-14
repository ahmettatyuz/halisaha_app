import 'package:dio/dio.dart';

const String API_BASEURL="https://localhost:7221";

final dio = Dio(
    BaseOptions(
      validateStatus: (status) {
        return status != null && status < 500;
      },
    ),
  );