// ignore_for_file: camel_case_types

part of 'place_cubit.dart';

sealed class PlaceState extends Equatable {
  const PlaceState();

  @override
  List<Object> get props => [];
}

final class PlaceInitial extends PlaceState {}

final class LoadingPlace extends PlaceState {}

final class SucessPlace extends PlaceState {
  final List<predictionsnEntites> predictionentites;

  @override
  List<Object> get props => [predictionentites];
  const SucessPlace({required this.predictionentites});
}

final class emptysearchplace extends PlaceState {
}

final class FailurePlace extends PlaceState {
  final String errorMessage;
  @override
  List<Object> get props => [errorMessage];
  const FailurePlace({required this.errorMessage});
}

final class showbottomsheet extends PlaceState {}

final class sucessplacedetails extends PlaceState {
  final DetailsEntites placedetails;
  @override
  List<Object> get props => [placedetails];
  const sucessplacedetails({required this.placedetails});
}

final class MapStyleState extends PlaceState {
  final String stylejson;
  final int indexstyle;

  const MapStyleState({required this.stylejson, required this.indexstyle});

  @override
  List<Object> get props => [indexstyle, stylejson];
}

final class LoadingLocation extends PlaceState {}

final class failureLocationstate extends PlaceState {
  final String error_message;
  @override
  List<Object> get props => [error_message];
  const failureLocationstate({required this.error_message});
}

final class SucessLocationState extends PlaceState {
  @override
  List<Object> get props => [];
}

final class showRoutingWidgetstate extends PlaceState {
  final bool showroutingwidget;

  showRoutingWidgetstate({required this.showroutingwidget});
  @override
  List<Object> get props => [showroutingwidget];
}

final class LoadingRoutestate extends PlaceState {
  @override
  List<Object> get props => [];
}

final class SucessRoueState extends PlaceState {
  @override
  List<Object> get props => [];
}
final class Sucessoriginstate extends PlaceState {
  final List<predictionsnEntites> predictionentites;

  @override
  List<Object> get props => [predictionentites];
  const Sucessoriginstate({required this.predictionentites});
}

final class Sucessdestinationstate extends PlaceState {
  final List<predictionsnEntites> predictionentites;

  @override
  List<Object> get props => [predictionentites];
  const Sucessdestinationstate({required this.predictionentites});
}

final class firstRouteState extends PlaceState {
  @override
  List<Object> get props => [];
}

final class failureRoutingState extends PlaceState {
  final String errorMessage;

  failureRoutingState({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

final class markerroutesucess extends PlaceState {}
