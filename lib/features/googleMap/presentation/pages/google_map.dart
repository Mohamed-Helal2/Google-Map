import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:googlemap/features/googleMap/presentation/bloc/cubit/place_cubit.dart';
import 'package:googlemap/features/googleMap/presentation/widget/map_style/map_style_widget.dart';
import 'package:googlemap/features/googleMap/presentation/widget/my_location/my_location_widget.dart';
import 'package:googlemap/features/googleMap/presentation/widget/routing/routin_search.dart';
import 'package:googlemap/features/googleMap/presentation/widget/routing/routing_widget.dart';
import 'package:googlemap/features/googleMap/presentation/widget/search_place_widget/location_photo.dart';

import '../widget/search_place_widget/textfieldsearch_widget.dart';

class GoogleMapScreen extends StatelessWidget {
  const GoogleMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: BlocBuilder<PlaceCubit, PlaceState>(
          builder: (context, state) {
            return Stack(
              children: [
                GoogleMap(
                  mapType: MapType.normal,
                  style: context.read<PlaceCubit>().mapstyle,
                  zoomControlsEnabled: false,
                  markers: context.read<PlaceCubit>().markers,
                  polylines: context.read<PlaceCubit>().polylines,
                  initialCameraPosition: const CameraPosition(
                      target: LatLng(30.55497584959975, 31.38114948515961),
                      zoom: 12),
                  onMapCreated: (controller) {
                    context.read<PlaceCubit>().googleMapController = controller;
                  },
                ),
                const MyLocationWidget(),
                const RoutingWidget(),
                const MapStyleWidget(),
                if (state is sucessplacedetails) placePhoto(state: state),
                context.read<PlaceCubit>().showRoutingWidget
                    ? RoutinSearch()
                    : TextfieldsearchWidget(),
              ],
            );
          },
        ),
      ),
    );
  }
}
