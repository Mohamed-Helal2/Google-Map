import 'package:flutter/material.dart';
import 'package:googlemap/core/widget/custom_text_form_field.dart';

class text_field_search_routing extends StatelessWidget {
  const text_field_search_routing(
      {super.key,
       
      required this.hint,
      required this.icon,
      required this.controller,
      required this.onChanged});

   final String hint;
  final Widget icon;
  final TextEditingController controller;
  final dynamic Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
        controller: controller,
        onChanged: onChanged,
        hintText: hint,
        hintStyle: const TextStyle(fontSize: 15),
        style: const TextStyle(
            color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
        fillColor: Colors.white,
        icon: icon,
        contentPadding: const EdgeInsets.all(12),
        enabledBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.blue)));
  }
}
