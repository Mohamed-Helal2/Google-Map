import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:googlemap/core/error/failure_message.dart';
import 'package:googlemap/core/network/api_constant.dart';
import 'package:googlemap/features/googleMap/domain/entites/details_entites.dart';
import 'package:googlemap/features/googleMap/domain/entites/predictionsn_entites.dart';
import 'package:googlemap/features/googleMap/domain/usecases/get_all_prediction.dart';
import 'package:googlemap/features/googleMap/domain/usecases/get_place_details.dart';

part 'place_state.dart';

class PlaceCubit extends Cubit<PlaceState> {
  PlaceCubit({
    required this.getPlaceDetailsusecase,
    required this.getAllPredictionUseCases,
  }) : super(PlaceInitial());
  final GetAllPredictionUseCases getAllPredictionUseCases;
  final GetPlaceDetailsusecase getPlaceDetailsusecase;
  TextEditingController searchplacecontroller = TextEditingController();
  GoogleMapController? googleMapController;
  Set<Marker> markers = {};

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

  // MapType mapType = MapType.normal;
  int myindexstyle = 0;
  String? mapstyle;
  mapStyle(
      {required String stylejson,
      required BuildContext context,
      required int indexstyle}) async {
    var style = await DefaultAssetBundle.of(context).loadString(stylejson);
    mapstyle = style;
    myindexstyle = indexstyle;
    print(">>> ------ ${myindexstyle}");
    emit(MapStyleState(stylejson: mapstyle!, indexstyle: myindexstyle));
    print(">>> New index style: $myindexstyle");
  }
}
