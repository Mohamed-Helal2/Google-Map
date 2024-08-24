import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:googlemap/features/googleMap/presentation/bloc/cubit/place_cubit.dart';
import 'package:googlemap/features/googleMap/presentation/widget/search_place_widget/photo_view.dart';

class placePhoto extends StatelessWidget {
  const placePhoto({super.key, required this.state});
  final sucessplacedetails state;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      left: 0,
      child: SizedBox(
        height: 900.h,
        child: DraggableScrollableSheet(
          initialChildSize: 0.2,
          minChildSize: 0.2,
          maxChildSize: 0.6,
          builder: (BuildContext context, scrollController) {
            return Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 0.5),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                ),
                child: InkWell(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              state.placedetails.address,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w400),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              context.read<PlaceCubit>().toggleSheet();
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 5),
                              padding: const EdgeInsets.all(8),
                              child: Image.asset(
                                "assets/photo/remove.png",
                                height: 25,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Expanded(
                        child: MasonryGridView.builder(
                            controller: scrollController,
                            crossAxisSpacing: 7,
                            mainAxisSpacing: 7,
                            itemCount: state.placedetails.photo.length,
                            gridDelegate:
                                const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                            itemBuilder: (context, index) {
                              final photo = state.placedetails.photo[index];

                              final imageUrl = context
                                  .read<PlaceCubit>()
                                  .photoUrl(
                                      photowidth: photo.width,
                                      photorefrence: photo.photoReference);
                              //   '${ApiConstant.showphotoapi}?maxwidth=${photo.width}&photoreference=${photo.photoReference}&key=${ApiConstant.apiKey}';

                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          Photoview(imageUrl: imageUrl),
                                    ),
                                  );
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: CachedNetworkImage(
                                    imageUrl: imageUrl,
                                    placeholder: (context, url) => const Center(
                                        child: CircularProgressIndicator(
                                      color: Colors.blue,
                                    )),
                                    errorWidget: (context, url, error) =>
                                        const Center(child: Icon(Icons.error)),
                                    fit: BoxFit.cover,
                                    width: photo.width!.toDouble(),
                                    height: photo.height! * 0.11.toDouble(),
                                  ),
                                ),
                              );
                            }),
                      )
                    ],
                  ),
                ));
          },
        ),
      ),
    );
  }
}
