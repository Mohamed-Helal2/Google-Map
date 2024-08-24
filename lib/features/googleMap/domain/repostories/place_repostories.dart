import 'package:dartz/dartz.dart';
import 'package:googlemap/features/googleMap/domain/entites/details_entites.dart';
import 'package:googlemap/features/googleMap/domain/entites/predictionsn_entites.dart';

import '../../../../core/error/failure.dart';

abstract class PlaceRepostories {
  Future<Either<Failure, List<predictionsnEntites>>> getAllPrediction(
      {required String city});
  Future<Either<Failure, DetailsEntites>> getPlaceDetails({required String placeid});
}
