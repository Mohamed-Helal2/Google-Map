import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/cubit/place_cubit.dart';
import 'search_text_rich.dart';

class sucessresultwidget extends StatelessWidget {
  const sucessresultwidget({super.key, required this.state});
  final SucessPlace state;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListView.separated(
        itemCount: state.predictionentites.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              context.read<PlaceCubit>().GetPlaceDetails(
                  placeid: state.predictionentites[index].place_id);
            },
            leading: Container(
              padding: const EdgeInsets.all(1),
              child: Image.asset(
                "assets/photo/location.png",
                height: 35,
              ),
            ),
            title: SearchTextRichtest(
                searchword: context
                    .read<PlaceCubit>()
                    .searchplacecontroller
                    .text
                    .toLowerCase()
                    .split(' ')
                    .toList(),
                sentence:
                    state.predictionentites[index].descriptione.toString()),
            trailing: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.arrow_outward_rounded,
                  color: Color.fromARGB(255, 31, 75, 111),
                )),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider(
            height: 0,
          );
        },
      ),
    );
  }
}

class sucess_result_widget extends StatelessWidget {
  const sucess_result_widget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
