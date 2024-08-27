import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:googlemap/core/error/failure.dart';
import 'package:googlemap/features/googleMap/data/model/location_info_model/location_info_mode.dart';
import 'package:googlemap/features/googleMap/data/model/routes_model/routes_model.dart';
import 'package:googlemap/features/googleMap/domain/repostories/routes_repostories.dart';

class GetRoutesUsecases {
  final RoutesRepostories routesRepostories;

  GetRoutesUsecases({required this.routesRepostories});

  Future<Either<Failure, RoutesModel>> getRoutes(
      {required LocationInfoModel origin,
      required LocationInfoModel destination}) async {
    return await routesRepostories.getRoutes(
        origin: origin, destination: destination);
  }

  Future<Either<Failure, Unit>> firstRoute({required String placeid, required int id}) async {
    return await routesRepostories.firstRoute(id: id,placeid: placeid);
  }

  Future<List<LatLng>> getrouteData(
      {required String polypoints,
      required GoogleMapController googleMapController}) async {
    return await routesRepostories.getrouteData(
        polypoints: polypoints, googleMapController: googleMapController);
  }

  displayroute({required List<LatLng> points}) {
    return routesRepostories.displayroute(points: points);
  }

  LatLngBounds getLagLngBounds() {
    return routesRepostories.getLagLngBounds();
  }

  setCameraBoubds(GoogleMapController? googleMapController) {
    return routesRepostories.setCameraBoubds(googleMapController);
  }
}
