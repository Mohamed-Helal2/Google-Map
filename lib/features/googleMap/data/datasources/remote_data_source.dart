import 'package:googlemap/core/error/error_strings.dart';
import 'package:googlemap/core/error/exception.dart';
import 'package:googlemap/core/network/api_constant.dart';
import 'package:googlemap/features/googleMap/data/model/place_details_model/place_details_model.dart';
import 'package:googlemap/features/googleMap/data/model/place_details_model/result.dart';
import 'package:googlemap/features/googleMap/data/model/places_autocomplete_model/prediction.dart';
import 'package:googlemap/features/googleMap/domain/entites/predictionsn_entites.dart';
import 'package:dio/dio.dart';

import '../../domain/entites/details_entites.dart';
import '../model/places_autocomplete_model/places_autocomplete_model.dart';

abstract class RemoteDataSource {
  Future<List<predictionsnEntites>> getAllPrediction({required String city});

  Future<DetailsEntites> getplacedetails({required String placeid});
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final Dio dio;
  RemoteDataSourceImpl({required this.dio});
  @override
  Future<List<predictionsnEntites>> getAllPrediction(
      {required String city}) async {
    final response = await dio.get(ApiConstant.placeautocomplete,
        queryParameters: {'key': ApiConstant.apiKey, 'input': city});
    if (response.statusCode == 200) {
      PlacesAutocompleteModel placesAutocompleteModel =
          PlacesAutocompleteModel.fromJson(response.data);
      if (placesAutocompleteModel.status == ErrorStrings.zero_result) {
        throw UnDefinedCityException();
      } else {
        List<PredictionModel> prediction =
            placesAutocompleteModel.predictions!.toList();
        return prediction;
      }
    } else {
      throw ServerException();
    }
  }

  @override
  Future<DetailsEntites> getplacedetails({required String placeid}) async {
    final response = await dio.get(ApiConstant.placedetails,
        queryParameters: {"key": ApiConstant.apiKey, "place_id": placeid});
    if (response.statusCode == 200) {
      PlaceDetailsModel placeDetailsModel =
          PlaceDetailsModel.fromJson(response.data);
      Result result = placeDetailsModel.result!;
      return result;
    } else {
      throw ServerException();
    }
  }
}
