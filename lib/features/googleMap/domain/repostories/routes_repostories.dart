import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:googlemap/core/error/failure.dart';
import 'package:googlemap/features/googleMap/data/model/location_info_model/location_info_mode.dart';
import 'package:googlemap/features/googleMap/data/model/routes_model/routes_model.dart';

abstract class RoutesRepostories {
  Future<Either<Failure, RoutesModel>> getRoutes(
      {required LocationInfoModel origin,
      required LocationInfoModel destination});
  
  Future<Either<Failure, Unit>> firstRoute(
      {required String placeid, required int id});
  
  //
  Future<List<LatLng>> getrouteData(
      {required String polypoints,
      required GoogleMapController googleMapController});
  displayroute({required List<LatLng> points});
  LatLngBounds getLagLngBounds();
  setCameraBoubds(GoogleMapController? googleMapController);
}
