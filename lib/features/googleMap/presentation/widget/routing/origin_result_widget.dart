import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:googlemap/features/googleMap/presentation/bloc/cubit/place_cubit.dart';
import 'package:googlemap/features/googleMap/presentation/widget/routing/sucess_origin_widget.dart';

class OriginResultWidget extends StatelessWidget {
  const OriginResultWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlaceCubit, PlaceState>(
      builder: (context, state) {
        if (state is Sucessoriginstate) {
          return SucessOriginWidget(
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
