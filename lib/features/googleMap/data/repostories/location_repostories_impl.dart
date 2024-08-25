import 'package:dartz/dartz.dart';
import 'package:googlemap/core/error/exception.dart';
import 'package:googlemap/core/error/failure.dart';
import 'package:googlemap/features/googleMap/data/datasources/location_data_source.dart';
import 'package:googlemap/features/googleMap/domain/repostories/location_repostories.dart';
import 'package:location/location.dart';
import 'package:location_platform_interface/location_platform_interface.dart';

class LocationRepostoriesImpl extends LocationRepostories {
  final LocationDataSource locationDataSource;

  LocationRepostoriesImpl({required this.locationDataSource});
  @override
  Future<Either<Failure, Unit>> requestLocationService() async {
    try {
      await locationDataSource.requestLocationService();
      return right(unit);
    } on LocationServiceException {
      return left(LocationServiceFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> requestLocationPermission() async {
    try {
      await locationDataSource.requestLocationPermission();
      return right(unit);
    } on LocationPermissionException {
      return left(LocationPermissionFailure());
    }
  }

  @override
  Future<Either<Failure, LocationData>> getMyLocation() async {
    try {
      await requestLocationService();
      await requestLocationPermission();
      return right(await locationDataSource.getMyLocation());
    } on LocationServiceException {
      return left(LocationServiceFailure());
    } on LocationPermissionException {
      return left(LocationPermissionFailure());
    }
  }
}
