import 'package:equatable/equatable.dart';

class predictionsnEntites extends Equatable {
  final String place_id;
  final String descriptione;

  predictionsnEntites({required this.place_id, required this.descriptione});

  @override
  // TODO: implement props
  List<Object?> get props => [place_id, descriptione];
}
