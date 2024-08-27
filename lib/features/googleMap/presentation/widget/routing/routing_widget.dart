import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:googlemap/features/googleMap/presentation/bloc/cubit/place_cubit.dart';
 
class RoutingWidget extends StatelessWidget {
  const RoutingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 105,
      right: 5,
      child: InkWell(
        onTap: () {
          context.read<PlaceCubit>().routingwidget();
        },
        child: Container(
          margin: const EdgeInsets.only(right: 3),
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.blue, width: 2),
              borderRadius: BorderRadius.circular(20)),
          height: 65,
          width: 65,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                'assets/photo/route.png',
                fit: BoxFit.fill,
              )),
        ),
      ),
    );
  }
}
