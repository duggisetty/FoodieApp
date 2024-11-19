import 'package:flutter/material.dart';

import '../utils/constants.dart';

class SearchBar extends StatelessWidget {
  final Function(String) onSearch;

  const SearchBar({Key? key, required this.onSearch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          hintText: Constants.searchFood,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onChanged: onSearch,
      ),
    );
  }
}
