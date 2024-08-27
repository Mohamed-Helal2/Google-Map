import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:googlemap/core/helper/debouncer.dart';
import 'package:googlemap/features/googleMap/presentation/bloc/cubit/place_cubit.dart';
import 'package:googlemap/features/googleMap/presentation/widget/my_location/location_photo_widget.dart';
import 'package:googlemap/features/googleMap/presentation/widget/routing/destination_result_widget.dart';
import 'package:googlemap/features/googleMap/presentation/widget/routing/origin_result_widget.dart';
import 'package:googlemap/features/googleMap/presentation/widget/routing/text_field_search_routing.dart';
import 'package:googlemap/features/googleMap/presentation/widget/search_place_widget/failure_widget.dart';

class RoutinSearch extends StatelessWidget {
  RoutinSearch({super.key});
  final debouncer = Debouncer(delay: const Duration(milliseconds: 500));
  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 5,
        left: 10,
        right: 10,
        child: Container(
          padding: const EdgeInsets.only(right: 30, left: 10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: const Color.fromARGB(255, 43, 2, 87), width: 2)),
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const location_photo_widget(),
                  BlocBuilder<PlaceCubit, PlaceState>(
                    builder: (context, state) {
                      if (state is LoadingPlace) {
                        return const CircularProgressIndicator(
                          color: Color(0xff272727),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                  InkWell(
                    onTap: () {
                      context.read<PlaceCubit>().routingwidget();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: const Color(0xff272727),
                          borderRadius: BorderRadius.circular(7)),
                      child: const Icon(
                        Icons.close,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              text_field_search_routing(
                controller: context.read<PlaceCubit>().origincontroller,
                onChanged: (p0) {
                  if (p0.isEmpty) {
                    context.read<PlaceCubit>().clearResults();
                  } else {
                    debouncer(() {
                      context.read<PlaceCubit>().originResult();
                    });
                  }
                },
                hint: "Choose start location",
                icon: const Icon(
                  Icons.circle_outlined,
                  size: 25,
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              const OriginResultWidget(),
              const SizedBox(
                height: 10,
              ),
              text_field_search_routing(
                controller: context.read<PlaceCubit>().destinationController,
                onChanged: (p0) {
                  if (p0.isEmpty) {
                    context.read<PlaceCubit>().clearResults();
                  } else {
                    debouncer(() {
                      context.read<PlaceCubit>().destinationResult();
                    });
                  }
                },
                hint: "choose your destinatoin",
                icon: const Icon(
                  Icons.location_pin,
                  size: 27,
                  color: Colors.red,
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              const DestinationResultWidget(),
              SizedBox(
                height: 8.h,
              ),
              BlocBuilder<PlaceCubit, PlaceState>(
                builder: (context, state) {
                  if (state is failureRoutingState) {
                    return failureWidget(
                      message: state.errorMessage,
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
              SizedBox(
                height: 8.h,
              ),
            ],
          ),
        ));
  }
}
