import 'package:equatable/equatable.dart';
import 'package:googlemap/features/googleMap/data/model/place_details_model/location.dart';

class DetailsEntites extends Equatable {
  final LocationModel placelocation;
  final String address;
  final List photo;

  DetailsEntites({
    required this.placelocation, 
    required this.address, required this.photo});
  @override
  // TODO: implement props
  List<Object?> get props => [ address,photo,placelocation];
}
