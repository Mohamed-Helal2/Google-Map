import 'prediction.dart';

class PlacesAutocompleteModel {
	List<PredictionModel>? predictions;
	String? status;

	PlacesAutocompleteModel({this.predictions, this.status});

	factory PlacesAutocompleteModel.fromJson(Map<String, dynamic> json) {
		return PlacesAutocompleteModel(
			predictions: (json['predictions'] as List<dynamic>?)
						?.map((e) => PredictionModel.fromJson(e as Map<String, dynamic>))
						.toList(),
			status: json['status'] as String?,
		);
	}



	Map<String, dynamic> toJson() => {
				'predictions': predictions?.map((e) => e.toJson()).toList(),
				'status': status,
			};
}
