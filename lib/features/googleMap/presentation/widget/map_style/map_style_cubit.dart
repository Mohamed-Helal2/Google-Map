

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:googlemap/features/googleMap/data/model/map_style_model/map_style_model.dart';
import 'package:googlemap/features/googleMap/presentation/bloc/cubit/place_cubit.dart';

class map_style_cubit extends StatelessWidget {
  const map_style_cubit({
    super.key,
    required this.index
  });
  final int index;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PlaceCubit, PlaceState>(
      listener: (context, state) {
        if (state is MapStyleState) {
          state.indexstyle;
          state.stylejson;
        }
      },
      builder: (context, state) {
        return BlocBuilder<PlaceCubit, PlaceState>(
          builder: (context, state) {
            return Container(
              height: 70,
              width: 70,
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  border: context.read<PlaceCubit>().myindexstyle == index
                      ? Border.all(color: Colors.blue, width: 2)
                      : null),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                child: Image.asset(
                  mapstylemodel[index].stylephoto,
                  // "assets/photo/mapstylephoto/silver.JPG",
                  // height: 60,
                  // width: 60,
                  fit: BoxFit.fill,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
