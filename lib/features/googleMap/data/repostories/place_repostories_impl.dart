import 'package:dartz/dartz.dart';
import 'package:googlemap/core/error/exception.dart';
import 'package:googlemap/core/error/failure.dart';
import 'package:googlemap/features/googleMap/data/datasources/remote_data_source.dart';
import 'package:googlemap/features/googleMap/domain/entites/details_entites.dart';
import 'package:googlemap/features/googleMap/domain/entites/predictionsn_entites.dart';
import 'package:googlemap/features/googleMap/domain/repostories/place_repostories.dart';

import '../../../../core/network/network_info.dart';

class PlaceRepostoriesImpl implements PlaceRepostories {
  final RemoteDataSource remoteDataSource;
  final NetworkInfo netwotkInfo;
  PlaceRepostoriesImpl(
      {required this.netwotkInfo, required this.remoteDataSource});

  @override
  Future<Either<Failure, List<predictionsnEntites>>> getAllPrediction(
      {required String city}) async {
    if (await netwotkInfo.isconnected) {
      try {
        final response = await remoteDataSource.getAllPrediction(city: city);
        return right(response);
      } on ServerException {
        return left(ServerFailure());
      } on UnDefinedCityException {
        return left(UnDefinedCityFailure());
      }
    } else {
      return left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, DetailsEntites>> getPlaceDetails(
      {required String placeid}) async {
    if (await netwotkInfo.isconnected) {
      try {
        final response =
            await remoteDataSource.getplacedetails(placeid: placeid);
        return right(response);
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      return left(OfflineFailure());
    }
  }
}
