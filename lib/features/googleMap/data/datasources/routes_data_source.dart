import 'package:dio/dio.dart';
import 'package:googlemap/core/error/exception.dart';
import 'package:googlemap/core/network/api_constant.dart';
import 'package:googlemap/features/googleMap/data/model/location_info_model/location_info_mode.dart';
import 'package:googlemap/features/googleMap/data/model/routes_model/routes_model.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

abstract class RoutesDataSource {
  Future<RoutesModel> getRoutes(
      {required LocationInfoModel origin,
      required LocationInfoModel destination});
}

class RoutesDataSourceImpl implements RoutesDataSource {
  final Dio dio;
  // RoutesDataSourceImpl({required this.dio});
  RoutesDataSourceImpl({required this.dio}) {
    // dio.options.baseUrl = ApiConstants.apibaseurl;
    dio.interceptors.add(PrettyDioLogger(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
    ));
  }
  final Map<String, dynamic> headers = {
    'Content-Type': 'application/json',
    'X-Goog-Api-Key': ApiConstant.apiKey,
    'X-Goog-FieldMask':
        'routes.duration,routes.distanceMeters,routes.polyline.encodedPolyline'
  };

  Map body(
      {required LocationInfoModel origin,
      required LocationInfoModel destination}) {
    return {
      "origin": origin.toJson(),
      "destination": destination.toJson(),
      "travelMode": "DRIVE",
      "routingPreference": "TRAFFIC_AWARE",
      "computeAlternativeRoutes": false,
      "routeModifiers": {
        "avoidTolls": false,
        "avoidHighways": false,
        "avoidFerries": false
      },
      "languageCode": "en-US",
      "units": "IMPERIAL"
    };
  }

  @override
  Future<RoutesModel> getRoutes(
      {required LocationInfoModel origin,
      required LocationInfoModel destination}) async {
    final response = await dio.post(ApiConstant.routesapi,
        options: Options(headers: headers),
        data: body(origin: origin, destination: destination));
    if (response.statusCode == 200) {
      RoutesModel routesModel = RoutesModel.fromJson(response.data);
      if (response.data.isNotEmpty) {
        return routesModel;
      } else {
        throw RoutesException();
      }
    } else {
      throw ServerException();
    }
  }
}
