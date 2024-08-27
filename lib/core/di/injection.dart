import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:googlemap/core/network/network_info.dart';
import 'package:googlemap/features/googleMap/data/datasources/location_data_source.dart';
import 'package:googlemap/features/googleMap/data/datasources/remote_data_source.dart';
import 'package:googlemap/features/googleMap/data/datasources/routes_data_source.dart';
import 'package:googlemap/features/googleMap/data/repostories/location_repostories_impl.dart';
import 'package:googlemap/features/googleMap/data/repostories/place_repostories_impl.dart';
import 'package:googlemap/features/googleMap/data/repostories/routes_repostories_impl.dart';
import 'package:googlemap/features/googleMap/domain/repostories/location_repostories.dart';
import 'package:googlemap/features/googleMap/domain/repostories/place_repostories.dart';
import 'package:googlemap/features/googleMap/domain/repostories/routes_repostories.dart';
import 'package:googlemap/features/googleMap/domain/usecases/ge_my_location.dart';
import 'package:googlemap/features/googleMap/domain/usecases/get_all_prediction.dart';
import 'package:googlemap/features/googleMap/domain/usecases/get_place_details.dart';
import 'package:googlemap/features/googleMap/domain/usecases/get_routes.dart';
import 'package:googlemap/features/googleMap/presentation/bloc/cubit/place_cubit.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:location/location.dart';

final getit = GetIt.instance;

Future<void> SetGetit() async {
  //Bloc
  getit.registerFactory<PlaceCubit>(
    () => PlaceCubit(
      getAllPredictionUseCases: getit(),
      getPlaceDetailsusecase: getit(),
      getMyLocationUseCase: getit(),
      getRoutesUsecases: getit()

     
    ),
  );
 
  // usecases

  getit.registerLazySingleton(
    () => GetAllPredictionUseCases(placeRepostories: getit()),
  );
  getit.registerLazySingleton(
    () => GetPlaceDetailsusecase(placeRepostories: getit()),
  );
   getit.registerLazySingleton(
    () => GetMyLocationUseCase(locationRepostories: getit()),
  );
     getit.registerLazySingleton(
    () => GetRoutesUsecases(routesRepostories: getit()),
  );
// repo
  getit.registerLazySingleton<PlaceRepostories>(
    () => PlaceRepostoriesImpl(netwotkInfo: getit(), remoteDataSource: getit()),
  );
getit.registerLazySingleton<LocationRepostories>(
    () => LocationRepostoriesImpl(locationDataSource: getit()),
  );
 getit.registerLazySingleton<RoutesRepostories>(
    () => RoutesRepostoriesImpl(routesDataSource: getit(),netwotkInfo: getit()),
  );
  // Data Sources
  getit.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(dio: getit()),
  );
   getit.registerLazySingleton<LocationDataSource>(
    () => LocationDataSourceImpl(location: getit()),
  );
     getit.registerLazySingleton<RoutesDataSource>(
    () => RoutesDataSourceImpl(dio: getit()),
  );
  // core
  getit.registerLazySingleton(
    () => Dio(),
  );
 getit.registerLazySingleton(
    () => Location(),
  );
  getit.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(internetConnectionChecker: getit()),
  );
  getit.registerLazySingleton(
    () => InternetConnectionChecker(),
  );
}
