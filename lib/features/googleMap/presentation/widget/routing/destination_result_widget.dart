import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:googlemap/features/googleMap/presentation/bloc/cubit/place_cubit.dart';
import 'package:googlemap/features/googleMap/presentation/widget/routing/sucess_destination_widget.dart';

class DestinationResultWidget extends StatelessWidget {
  const DestinationResultWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlaceCubit, PlaceState>(
      builder: (context, state) {
        if (state is Sucessdestinationstate) {
          return SucessDestinationWidget(
            state: state,
          );
        } 
         else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
