import 'package:googlemap/features/googleMap/domain/entites/details_entites.dart';

import 'address_component.dart';
import 'current_opening_hours.dart';
import 'editorial_summary.dart';
import 'geometry.dart';
import 'opening_hours.dart';
import 'photo.dart';
import 'plus_code.dart';
import 'review.dart';

class Result extends DetailsEntites {
  final List<AddressComponent>? addressComponents;
  final String? businessStatus;
  final CurrentOpeningHours? currentOpeningHours;
  final EditorialSummary? editorialSummary;
  final String? adrAddress;
  final String? formattedPhoneNumber;
  final Geometry? geometry;
  final String? icon;
  final String? iconBackgroundColor;
  final String? iconMaskBaseUri;
  final String? internationalPhoneNumber;
  final String? name;
  final OpeningHours? openingHours;
  final String? placeId;
  final PlusCode? plusCode;
  final double? rating;
  final String? reference;
  final List<Review>? reviews;
  final List<dynamic>? types;
  final String? url;
  final int? userRatingsTotal;
  final int? utcOffset;
  final String? vicinity;
  final String? website;
  final bool? wheelchairAccessibleEntrance;
   Result({
    required String formattedAddress,
    required List photos,
    this.addressComponents,
    this.businessStatus,
    this.currentOpeningHours,
    this.editorialSummary,
    this.adrAddress,
    this.formattedPhoneNumber,
    this.geometry,
    this.icon,
    this.iconBackgroundColor,
    this.iconMaskBaseUri,
    this.internationalPhoneNumber,
    this.name,
    this.openingHours,
    this.placeId,
    this.plusCode,
    this.rating,
    this.reference,
    this.reviews,
    this.types,
    this.url,
    this.userRatingsTotal,
    this.utcOffset,
    this.vicinity,
    this.website,
    this.wheelchairAccessibleEntrance,
  }) : super(
          address: formattedAddress,
          photo: photos,
          placelocation: geometry!.location!,
        );

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        addressComponents: (json['address_components'] as List<dynamic>?)
            ?.map((e) => AddressComponent.fromJson(e as Map<String, dynamic>))
            .toList(),
        adrAddress: json['adr_address'] as String,
        businessStatus: json['business_status'] as String?,
        currentOpeningHours: json['current_opening_hours'] == null
            ? null
            : CurrentOpeningHours.fromJson(
                json['current_opening_hours'] as Map<String, dynamic>),
        editorialSummary: json['editorial_summary'] == null
            ? null
            : EditorialSummary.fromJson(
                json['editorial_summary'] as Map<String, dynamic>),
        formattedAddress: json['formatted_address'] as String,
        formattedPhoneNumber: json['formatted_phone_number'] as String?,
        geometry: json['geometry'] == null
            ? null
            : Geometry.fromJson(json['geometry'] as Map<String, dynamic>),
        icon: json['icon'] as String?,
        iconBackgroundColor: json['icon_background_color'] as String?,
        iconMaskBaseUri: json['icon_mask_base_uri'] as String?,
        internationalPhoneNumber: json['international_phone_number'] as String?,
        name: json['name'] as String?,
        openingHours: json['opening_hours'] == null
            ? null
            : OpeningHours.fromJson(
                json['opening_hours'] as Map<String, dynamic>),
        photos: (json['photos'] as List<dynamic>)
            .map((e) => Photo.fromJson(e as Map<String, dynamic>))
            .toList(),
        placeId: json['place_id'] as String?,
        plusCode: json['plus_code'] == null
            ? null
            : PlusCode.fromJson(json['plus_code'] as Map<String, dynamic>),
        rating: (json['rating'] as num?)?.toDouble(),
        reference: json['reference'] as String?,
        reviews: (json['reviews'] as List<dynamic>?)
            ?.map((e) => Review.fromJson(e as Map<String, dynamic>))
            .toList(),
        types: json['types'] as List<dynamic>?,
        url: json['url'] as String?,
        userRatingsTotal: json['user_ratings_total'] as int?,
        utcOffset: json['utc_offset'] as int?,
        vicinity: json['vicinity'] as String?,
        website: json['website'] as String?,
        wheelchairAccessibleEntrance:
            json['wheelchair_accessible_entrance'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'address_components':
            addressComponents?.map((e) => e.toJson()).toList(),
        'adr_address': address,
        'business_status': businessStatus,
        'current_opening_hours': currentOpeningHours?.toJson(),
        'editorial_summary': editorialSummary?.toJson(),
        'formatted_address': address,
        'formatted_phone_number': formattedPhoneNumber,
        'geometry': geometry?.toJson(),
        'icon': icon,
        'icon_background_color': iconBackgroundColor,
        'icon_mask_base_uri': iconMaskBaseUri,
        'international_phone_number': internationalPhoneNumber,
        'name': name,
        'opening_hours': openingHours?.toJson(),
        'photos': photo.map((e) => e.toJson()).toList(),
        'place_id': placeId,
        'plus_code': plusCode?.toJson(),
        'rating': rating,
        'reference': reference,
        'reviews': reviews?.map((e) => e.toJson()).toList(),
        'types': types,
        'url': url,
        'user_ratings_total': userRatingsTotal,
        'utc_offset': utcOffset,
        'vicinity': vicinity,
        'website': website,
        'wheelchair_accessible_entrance': wheelchairAccessibleEntrance,
      };
}
