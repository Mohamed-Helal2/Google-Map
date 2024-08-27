import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:googlemap/core/error/exception.dart';
import 'package:googlemap/core/error/failure.dart';
import 'package:googlemap/core/network/network_info.dart';
import 'package:googlemap/features/googleMap/data/datasources/routes_data_source.dart';
import 'package:googlemap/features/googleMap/data/model/location_info_model/location_info_mode.dart';
import 'package:googlemap/features/googleMap/data/model/routes_model/routes_model.dart';
import 'package:googlemap/features/googleMap/domain/repostories/routes_repostories.dart';

class RoutesRepostoriesImpl extends RoutesRepostories {
  final RoutesDataSource routesDataSource;
  final NetworkInfo netwotkInfo;
  RoutesRepostoriesImpl(
      {required this.routesDataSource, required this.netwotkInfo});
  PolylinePoints polylinePoints = PolylinePoints();
  Set<Polyline> polyline = {};
  List<LatLng> points = [];

  @override
  Future<Either<Failure, RoutesModel>> getRoutes({
    required LocationInfoModel origin,
    required LocationInfoModel destination,
  }) async {
    if (await netwotkInfo.isconnected) {
      try {
        final response = await routesDataSource.getRoutes(
            origin: origin, destination: destination);
        return right(response);
      } on ServerException {
        return left(ServerFailure());
      } on RoutesException {
        return left(RoutesFailure());
      } on DioException {
        return left(ServerFailure());
      }
    } else {
      return left(OfflineFailure());
    }
  }

  @override
  Future<List<LatLng>> getrouteData(
      {required String polypoints,
      required GoogleMapController googleMapController}) async {
    List<PointLatLng> result = polylinePoints.decodePolyline(polypoints);
    List<LatLng> latLngPoints = result
        .map(
          (e) => LatLng(e.latitude, e.longitude),
        )
        .toList();
    points = latLngPoints;
    setCameraBoubds(googleMapController);
    // displayroute(points: latLngPoints);
    return latLngPoints;
  }

  @override
  Set displayroute({required List<LatLng> points}) {
    Polyline route = Polyline(
      polylineId: const PolylineId('1'),
      points: points,
      width: 5,
      color: Colors.blue,
      patterns: [
        PatternItem.dash(30),
        PatternItem.gap(10),
      ],
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
    );
    polyline.add(route);
    return polyline;
  }

  @override
  LatLngBounds getLagLngBounds() {
    var southwestlatitude = points.first.latitude; // min
    var southwestlongtitude = points.first.longitude; // min

    var nourtheastlatitude = points.first.latitude; // max
    var nourtheastLongtitude = points.first.longitude; // max

    for (var point in points) {
      if (point.latitude < southwestlatitude) {
        southwestlatitude = point.latitude;
      }

      if (point.longitude < southwestlongtitude) {
        southwestlongtitude = point.longitude;
      }

      if (point.latitude > nourtheastlatitude) {
        nourtheastlatitude = point.latitude;
      }

      if (point.longitude > nourtheastLongtitude) {
        nourtheastLongtitude = point.longitude;
      }
    }

    LatLngBounds latLngBounds = LatLngBounds(
        southwest: LatLng(southwestlatitude, southwestlongtitude),
        northeast: LatLng(nourtheastlatitude, nourtheastLongtitude));
    return latLngBounds;
  }

  @override
  setCameraBoubds(GoogleMapController? googleMapController) {
    LatLngBounds latLngBounds = getLagLngBounds();
    googleMapController
        ?.animateCamera(CameraUpdate.newLatLngBounds(latLngBounds, 50));
  }

  @override
  Future<Either<Failure, Unit>> firstRoute(
      {required String placeid, required int id}) async {
    if (await netwotkInfo.isconnected) {
      try {
        if (id == 1) {
          return right(unit);
        } else if (id == 0) {
          return right(unit);
        }
      } on ServerException {
        return left(ServerFailure());
      } on RoutesException {
        return left(RoutesFailure());
      } on DioException {
        return left(ServerFailure());
      }
    } else {
      return left(OfflineFailure());
    }
     return right(unit);
  }
}

 
