import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:googlemap/features/googleMap/data/model/map_style_model/map_style_model.dart';
import 'package:googlemap/features/googleMap/presentation/bloc/cubit/place_cubit.dart';
import 'package:googlemap/features/googleMap/presentation/widget/map_style/map_style_cubit.dart';
import 'package:googlemap/features/googleMap/presentation/widget/map_style/map_style_photo.dart';

class MapStyleWidget extends StatelessWidget {
  const MapStyleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 80,
      right: 5,
      child: InkWell(
        onTap: () {
          showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            builder: (BuildContext _) {
              return BlocProvider.value(
                value: BlocProvider.of<PlaceCubit>(context),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Map Style",
                        style: TextStyle(fontSize: 25, color: Colors.black),
                      ),
                      Expanded(
                        child: GridView.builder(
                          itemCount: mapstylemodel.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: 30,
                                  mainAxisSpacing: 25,
                                  crossAxisCount: 3),
                          itemBuilder: (contextgrid, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    context.read<PlaceCubit>().mapStyle(
                                        stylejson:
                                            mapstylemodel[index].stylejson,
                                        context: context,
                                        indexstyle: index);
                                  },
                                  child: map_style_cubit(
                                    index: index,
                                  ),
                                ),
                                const SizedBox(height: 7),
                                Text(
                                  mapstylemodel[index].stylename,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                )
                              ],
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: const map_style_photo(),
      ),
    );
  }
}
