import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:googlemap/features/googleMap/presentation/bloc/cubit/place_cubit.dart';
import 'package:googlemap/features/googleMap/presentation/widget/search_place_widget/failure_widget.dart';
import 'package:googlemap/features/googleMap/presentation/widget/search_place_widget/sucess_place.dart';

class searchplaceRresult extends StatelessWidget {
  const searchplaceRresult({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlaceCubit, PlaceState>(
      builder: (context, state) {
        if (state is SucessPlace) {
          return sucessresultwidget(
            state: state,
          );
        } else if (state is FailurePlace) {
          return failureWidget(
            message: state.errorMessage,
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
