import 'package:dartz/dartz.dart';
import 'package:googlemap/core/error/failure.dart';
import 'package:googlemap/features/googleMap/domain/entites/predictionsn_entites.dart';
import 'package:googlemap/features/googleMap/domain/repostories/place_repostories.dart';

class GetAllPredictionUseCases {
  final PlaceRepostories placeRepostories;

  GetAllPredictionUseCases({required this.placeRepostories});
  Future<Either<Failure, List<predictionsnEntites>>> call(
      {required String city}) async {
    return await placeRepostories.getAllPrediction(city: city);
  }
}
