import 'package:flutter/material.dart';

class SearchFAB extends StatelessWidget {
  const SearchFAB({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pushNamed('/search');
      },
      child: const Icon(
        Icons.search_sharp,
      ),
    );
  }
}
