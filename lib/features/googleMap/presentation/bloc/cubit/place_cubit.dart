// ignore_for_file: non_constant_identifier_names
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:googlemap/core/error/failure_message.dart';
import 'package:googlemap/core/network/api_constant.dart';
import 'package:googlemap/features/googleMap/data/model/location_info_model/location_info_mode.dart';
import 'package:googlemap/features/googleMap/domain/entites/details_entites.dart';
import 'package:googlemap/features/googleMap/domain/entites/predictionsn_entites.dart';
import 'package:googlemap/features/googleMap/domain/usecases/ge_my_location.dart';
import 'package:googlemap/features/googleMap/domain/usecases/get_all_prediction.dart';
import 'package:googlemap/features/googleMap/domain/usecases/get_place_details.dart';
import 'package:googlemap/features/googleMap/domain/usecases/get_routes.dart';
import 'package:label_marker/label_marker.dart';

part 'place_state.dart';

class PlaceCubit extends Cubit<PlaceState> {
  PlaceCubit(
      {required this.getMyLocationUseCase,
      required this.getPlaceDetailsusecase,
      required this.getAllPredictionUseCases,
      required this.getRoutesUsecases})
      : super(PlaceInitial());
  final GetAllPredictionUseCases getAllPredictionUseCases;
  final GetPlaceDetailsusecase getPlaceDetailsusecase;
  final GetMyLocationUseCase getMyLocationUseCase;
  final GetRoutesUsecases getRoutesUsecases;
  TextEditingController searchplacecontroller = TextEditingController();
  GoogleMapController? googleMapController;
  Set<Marker> markers = {};
  Set<Polyline> polylines = {};
// Routing
  TextEditingController origincontroller = TextEditingController();
  TextEditingController destinationController = TextEditingController();
  String? originname;
  String? destinationname;
  LatLng? originlocation;
  LatLng? destinationlocation;
  GetAllPrediction() async {
    if (searchplacecontroller.text.isNotEmpty) {
      emit(LoadingPlace());
      final getplace =
          await getAllPredictionUseCases(city: searchplacecontroller.text);
      getplace.fold(
        (l) {
          emit(FailurePlace(errorMessage: mapFailutrToMessage(l)));
        },
        (r) {
          // predictionresult = r;
          emit(SucessPlace(predictionentites: r));
        },
      );
    }
  }

  clearResults() {
    searchplacecontroller.clear();

    emit(emptysearchplace());
  }

  GetPlaceDetails({required String placeid}) async {
    final getplace = await getPlaceDetailsusecase(placeid: placeid);
    getplace.fold(
      (l) {
        clearResults();
        emit(FailurePlace(errorMessage: mapFailutrToMessage(l)));
      },
      (r) {
        LatLng latLng = LatLng(r.placelocation.lat!, r.placelocation.lng!);
        clearResults();
        addmarker(latLng);
        setCameraPosition(latLng, 12);
        toggleSheet();
        emit(sucessplacedetails(placedetails: r));
      },
    );
  }

  void setCameraPosition(LatLng latlng, double zoom) {
    CameraPosition cameraPosition = CameraPosition(target: latlng, zoom: zoom);
    googleMapController
        ?.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  void addmarker(LatLng latlng) async {
    Marker mymarker = Marker(
      markerId: MarkerId("$latlng"),
      position: latlng,
    );
    markers.add(mymarker);
  }

  bool showsheet = false;
  void toggleSheet() {
    showsheet = !showsheet;
    emit(showbottomsheet());
  }

  String photoUrl({required int photowidth, required String photorefrence}) {
    String imageurl =
        '${ApiConstant.showphotoapi}?maxwidth=$photowidth&photoreference=$photorefrence&key=${ApiConstant.apiKey}';
    return imageurl;
  }

  int myindexstyle = 0;
  String? mapstyle;
  mapStyle(
      {required String stylejson,
      required BuildContext context,
      required int indexstyle}) async {
    var style = await DefaultAssetBundle.of(context).loadString(stylejson);
    mapstyle = style;
    myindexstyle = indexstyle;
    emit(MapStyleState(stylejson: mapstyle!, indexstyle: myindexstyle));
  }

  GetMyLocation() async {
    emit(LoadingLocation());
    final response = await getMyLocationUseCase.getMyLocation();
    response.fold(
      (l) {
        emit(failureLocationstate(error_message: mapFailutrToMessage(l)));
      },
      (r) {
        LatLng latLng = LatLng(r.latitude!, r.longitude!);
        originlocation = latLng;
        origincontroller.text = "Your Location";
        addmarker(latLng);
        setCameraPosition(latLng, 12);
        emit(SucessLocationState());
      },
    );
  }

  bool showRoutingWidget = false;
  void routingwidget() {
    showRoutingWidget = !showRoutingWidget;
    origincontroller.clear();
    destinationController.clear();
    originlocation = null;
    destinationlocation = null;
    polylines.clear();
    markers.clear();
    emit(showRoutingWidgetstate(showroutingwidget: showRoutingWidget));
  }

  originResult() async {
    if (origincontroller.text.isNotEmpty) {
      emit(LoadingPlace());
      final getplace =
          await getAllPredictionUseCases(city: origincontroller.text);
      getplace.fold(
        (l) {
          emit(failureRoutingState(errorMessage: mapFailutrToMessage(l)));
        },
        (r) {
          emit(Sucessoriginstate(predictionentites: r));
        },
      );
    }
  }

  Future<LatLng?> goingtoOrigin({required String placeid}) async {
    try {
      final originPlaceResult = await getPlaceDetailsusecase(placeid: placeid);
      return originPlaceResult.fold(
        (failure) {
          clearResults();
          emit(failureRoutingState(errorMessage: mapFailutrToMessage(failure)));
          return null;
        },
        (success) async {
          origincontroller.text = success.address;
          originlocation =
              LatLng(success.placelocation.lat!, success.placelocation.lng!);
          addmarker(originlocation!);
          clearResults();
          return originlocation;
        },
      );
    } catch (e) {
      clearResults();
      emit(failureRoutingState(errorMessage: e.toString()));
      return null;
    }
  }

  destinationResult() async {
    if (destinationController.text.isNotEmpty) {
      emit(LoadingPlace());
      final getplace =
          await getAllPredictionUseCases(city: destinationController.text);
      getplace.fold(
        (l) {
          emit(failureRoutingState(errorMessage: mapFailutrToMessage(l)));
        },
        (r) {
          emit(Sucessdestinationstate(predictionentites: r));
        },
      );
    }
  }

  Future<LatLng?> goingtodestination({required String placeid}) async {
    try {
      final destinationPlaceResult =
          await getPlaceDetailsusecase(placeid: placeid);

      return destinationPlaceResult.fold(
        (failure) {
          clearResults();
          emit(FailurePlace(errorMessage: mapFailutrToMessage(failure)));
          return null;
        },
        (success) async {
          destinationController.text = success.address;
          destinationlocation =
              LatLng(success.placelocation.lat!, success.placelocation.lng!);
          addmarker(destinationlocation!);
          clearResults();
          return destinationlocation;
        },
      );
    } catch (e) {
      clearResults();
      emit(failureRoutingState(errorMessage: e.toString()));
      return null;
    }
  }

  firstRoute({required String placeid, required int id}) async {
    final response =
        await getRoutesUsecases.firstRoute(placeid: placeid, id: id);
    response.fold(
      (l) {
        emit(failureRoutingState(errorMessage: mapFailutrToMessage(l)));
      },
      (r) async {
        if (id == 1) {
          destinationlocation = await goingtodestination(placeid: placeid);
          setCameraPosition(destinationlocation!, 12);
        }
        if (id == 0) {
          originlocation = await goingtoOrigin(placeid: placeid);
          setCameraPosition(originlocation!, 12);
        }
      },
    );
  }

  getoriginAndDestination({required String placeid, required int id}) async {
    emit(LoadingPlace());
    if (originlocation == null && destinationlocation == null) {
      firstRoute(placeid: placeid, id: id);
    } else {
      if (id == 0) {
        if (destinationlocation == null) {
          firstRoute(placeid: placeid, id: id);
        } else {
          originlocation = await goingtoOrigin(placeid: placeid);
          getRoutes();
        }
      } else if (id == 1) {
        if (originlocation == null) {
          firstRoute(placeid: placeid, id: id);
        } else {
          destinationlocation = await goingtodestination(placeid: placeid);
          getRoutes();
        }
      }
    }
  }

  routesMarker(LatLng latlng, int distance) async {
    await markers.addLabelMarker(LabelMarker(
      label: "$distance Km",
      textStyle: const TextStyle(fontSize: 35, fontWeight: FontWeight.w500),
      markerId: MarkerId("$latlng"),
      position: latlng,
      backgroundColor: Colors.green,
    ));
  emit(markerroutesucess());
  }

  getRoutes() async {
    emit(LoadingPlace());
    final response = await getRoutesUsecases.getRoutes(
      origin: LocationInfoModel(
        locationModel: LocationModel(
          latlngModel: LatlngModel(
              latitude: originlocation!.latitude,
              longitude: originlocation!.longitude),
        ),
      ),
      destination: LocationInfoModel(
        locationModel: LocationModel(
          latlngModel: LatlngModel(
              latitude: destinationlocation!.latitude,
              longitude: destinationlocation!.longitude),
        ),
      ),
    );
    response.fold(
      (l) {
        emit(failureRoutingState(errorMessage: mapFailutrToMessage(l)));
      },
      (r) async {
        final dataresponse = await getRoutesUsecases.getrouteData(
            polypoints: r.routes![0].polyline!.encodedPolyline!,
            googleMapController: googleMapController!);
        final displayresponse =
            getRoutesUsecases.displayroute(points: dataresponse);
        polylines = displayresponse;
        int center = (dataresponse.length / 2).floor();
        int distance = ((r.routes![0].distanceMeters)! / 1000).floor();
        routesMarker(dataresponse[center], distance);
        emit(SucessLocationState());
      },
    );
  }

  fromMyLocation() async {
    await GetMyLocation();
    if (destinationlocation != null) {
      getRoutes();
    }
  }
}
