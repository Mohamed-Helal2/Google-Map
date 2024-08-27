import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/cubit/place_cubit.dart';

class suffixiconwidget extends StatelessWidget {
  const suffixiconwidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlaceCubit, PlaceState>(
      builder: (context, state) {
        if (state is LoadingPlace) {
          return Container(
            margin: const EdgeInsets.all(10),
            child: const CircularProgressIndicator(
              color: Colors.blue,
            ),
          );
        } else if (state is SucessPlace || state is FailurePlace) {
          return InkWell(
            onTap: () {
              context.read<PlaceCubit>().clearResults();
            },
            child: Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: const Color(0xff8F8F8F),
                  borderRadius: BorderRadius.circular(20)),
              child: const Icon(
                Icons.close,
                size: 20,
                color: Colors.white,
              ),
            ),
          );
        } else {
          return Container(
            margin: const EdgeInsets.only(right: 5),
            padding: const EdgeInsets.all(3),
            child: Image.asset(
              "assets/photo/map.png",
              height: 25,
            ),
          );
        }
      },
    );
  }
}
