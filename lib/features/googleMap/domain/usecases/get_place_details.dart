import 'package:dartz/dartz.dart';
import 'package:googlemap/core/error/failure.dart';
import 'package:googlemap/features/googleMap/domain/entites/details_entites.dart';
import 'package:googlemap/features/googleMap/domain/repostories/place_repostories.dart';

class GetPlaceDetailsusecase {
  final PlaceRepostories placeRepostories;

  GetPlaceDetailsusecase({required this.placeRepostories});

  Future<Either<Failure, DetailsEntites>> call({required String placeid})async{
   return await placeRepostories.getPlaceDetails(placeid: placeid);
  }
}
