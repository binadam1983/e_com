import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/styles.dart';
import '../logic/cubits.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/grid_view_builder.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  static const String routeName = '/search';
  final TextEditingController _searchText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: CustomAppBar(title: title),
      // extendBodyBehindAppBar: true,
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(padding: EdgeInsets.all(8.0)),
            ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: const BorderSide(
                      style: BorderStyle.solid, color: Colors.deepPurple)),
              title: TextField(
                onChanged: ((value) =>
                    BlocProvider.of<FilteredProductsCubit>(context)
                        .updateFilteredProducts(value.toLowerCase())),
                controller: _searchText,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search Here',
                    enabled: true),
              ),
              trailing: IconButton(
                  onPressed: () {
                    _searchText.clear();
                  },
                  icon: const Icon(Icons.cancel_sharp)),
              leading: const Padding(
                padding: EdgeInsets.only(top: 5.0),
                child: Icon(
                  Icons.search,
                  size: 28,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            BlocBuilder<FilteredProductsCubit, FilteredProductsState>(
              builder: (context, state) {
                if (state is FilteredProductsLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is FilteredProductsLoaded) {
                  return GridViewBuilder(products: state.products);
                } else {
                  return Center(
                    child: Text(
                      'Something Went Wrong',
                      style: Styles.heading4,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
