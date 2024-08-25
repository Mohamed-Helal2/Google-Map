import 'package:dartz/dartz.dart';
import 'package:googlemap/core/error/exception.dart';
import 'package:googlemap/core/error/failure.dart';
import 'package:location/location.dart';

abstract class LocationDataSource {
  Future<Either<Failure, Unit>> requestLocationService();
  Future<Either<Failure, Unit>> requestLocationPermission();
  Future<LocationData> getMyLocation();
}

class LocationDataSourceImpl extends LocationDataSource {
  final Location location;

  LocationDataSourceImpl({required this.location});
  @override
  Future<Either<Failure, Unit>> requestLocationService() async {
    bool isserviceenabled = await location.serviceEnabled();
    if (!isserviceenabled) {
      isserviceenabled = await location.requestService();
      if (!isserviceenabled) {
        throw (LocationServiceException());
      }
    }
    return right(unit);
  }

  @override
  Future<Either<Failure, Unit>> requestLocationPermission() async {
    PermissionStatus permissionstatus = await location.hasPermission();
    if (permissionstatus == PermissionStatus.deniedForever) {
      permissionstatus = await location.requestPermission();
    }
    if (permissionstatus == PermissionStatus.denied) {
      permissionstatus = await location.requestPermission();
      if (permissionstatus != PermissionStatus.granted) {
        throw (LocationPermissionException());
      }
    }
    return right(unit);
  }

  @override
  Future<LocationData> getMyLocation() async {
    LocationData locationData = await location.getLocation();
    return locationData;
  }
}
