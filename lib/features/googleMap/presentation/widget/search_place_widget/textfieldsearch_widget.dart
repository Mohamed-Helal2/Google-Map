import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:googlemap/core/widget/custom_text_form_field.dart';
import 'package:googlemap/features/googleMap/presentation/bloc/cubit/place_cubit.dart';

import '../../../../../core/helper/debouncer.dart';
import 'search_result.dart';
import 'suffix_icon_widget.dart';

class TextfieldsearchWidget extends StatelessWidget {
  TextfieldsearchWidget({super.key});
  final debouncer = Debouncer(delay: const Duration(milliseconds: 500));
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 16,
      left: 10,
      right: 10,
      child: Column(
        children: [
          AppTextFormField(
            hintText: "Search here",
            preficicon: Container(
              padding: const EdgeInsets.all(8),
              child: Image.asset(
                "assets/photo/search.png",
                height: 10,
              ),
            ),
            suffixIcon: const suffixiconwidget(),
            onChanged: (p0) {
              if (p0.isEmpty) {
                context.read<PlaceCubit>().clearResults();
              } else {
                debouncer(() {
                  context.read<PlaceCubit>().GetAllPrediction();
                });
              }
            },
            controller: context.read<PlaceCubit>().searchplacecontroller,
            hintStyle:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            style: const TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
            contentPadding: const EdgeInsets.all(14),
            fillColor: Colors.white,
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          const searchplaceRresult()
        ],
      ),
    );
  }
}
