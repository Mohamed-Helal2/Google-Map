import '../../../domain/entites/predictionsn_entites.dart';
import 'matched_substring.dart';
import 'structured_formatting.dart';
import 'term.dart';

class PredictionModel extends predictionsnEntites {
  final List<MatchedSubstring>? matchedSubstrings;
  final String? reference;
  final StructuredFormatting? structuredFormatting;
  final List<Term>? terms;
  final List<dynamic>? types;

  PredictionModel({
    required String description,
    this.matchedSubstrings,
    required String placeId,
    this.reference,
    this.structuredFormatting,
    this.terms,
    this.types,
  }) : super(place_id: placeId, descriptione: description);

  factory PredictionModel.fromJson(Map<String, dynamic> json) => PredictionModel(
        description: json['description'] as String,
        matchedSubstrings: (json['matched_substrings'] as List<dynamic>?)
            ?.map((e) => MatchedSubstring.fromJson(e as Map<String, dynamic>))
            .toList(),
        placeId: json['place_id'] as String,
        reference: json['reference'] as String?,
        structuredFormatting: json['structured_formatting'] == null
            ? null
            : StructuredFormatting.fromJson(json['structured_formatting'] as Map<String, dynamic>),
        terms: (json['terms'] as List<dynamic>?)
            ?.map((e) => Term.fromJson(e as Map<String, dynamic>))
            .toList(),
        types: json['types'] as List<dynamic>?,
      );

  Map<String, dynamic> toJson() => {
        'description': descriptione,
        'matched_substrings': matchedSubstrings?.map((e) => e.toJson()).toList(),
        'place_id': place_id,
        'reference': reference,
        'structured_formatting': structuredFormatting?.toJson(),
        'terms': terms?.map((e) => e.toJson()).toList(),
        'types': types,
      };
}
