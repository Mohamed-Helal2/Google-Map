import 'package:flutter/material.dart';
import 'dart:core';

class SearchTextRichtest extends StatelessWidget {
  SearchTextRichtest(
      {super.key, required this.sentence, required this.searchword});
  final String sentence; // describtion
  final List<String> searchword; // textcontrold
  @override
  Widget build(BuildContext context) {
    List<TextSpan> textSpans = [];
    List<String> words = sentence.split(RegExp(r'[ ,]+')); // describtion
    for (var word in words) {
      if (searchword.contains(word.toLowerCase())) {
        textSpans.add(
          TextSpan(
            text: '$word ',
            style: const TextStyle(
              backgroundColor: Colors.yellow,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      } else {
        textSpans.add(
          TextSpan(
            text: '$word ',
          ),
        );
      }
    }
    return RichText(
      text: TextSpan(
        children: textSpans,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}

 