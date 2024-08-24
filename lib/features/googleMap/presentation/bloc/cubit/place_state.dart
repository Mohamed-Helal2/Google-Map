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
  SucessPlace({required this.predictionentites});
}

final class emptysearchplace extends PlaceState {
  //final List<predictionsnEntites> predictionentites;

  // List<Object> get props => [predictionentites];
}

final class FailurePlace extends PlaceState {
  final String errorMessage;
  @override
  List<Object> get props => [errorMessage];
  FailurePlace({required this.errorMessage});
}

final class showbottomsheet extends PlaceState {}

final class sucessplacedetails extends PlaceState {
  final DetailsEntites placedetails;
 @override
  List<Object> get props => [placedetails];
  sucessplacedetails({required this.placedetails});
  
}
