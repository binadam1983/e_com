import 'package:e_com/constants/styles.dart';
import 'package:e_com/logic/product/product_cubit.dart';
import 'package:e_com/models/models.dart';
import 'package:e_com/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({
    Key? key,
    required this.title,
    this.category,
    this.categories,
  }) : super(key: key);

  final String title;
  String? category;
  List<Category>? categories;
  static const String routeName = '/categories';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: CustomAppBar(title: title),
      // extendBodyBehindAppBar: true,
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ProductLoaded) {
              return category != null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(0),
                          height: 300,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/categ.jpg'),
                                fit: BoxFit.cover),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          category!.toUpperCase(),
                          style:
                              Styles.heading4.copyWith(color: Colors.black87),
                        ),
                        const SizedBox(height: 10),
                        GridViewBuilder(
                          products: state.products
                              .where((product) =>
                                  product.category.toLowerCase() == category)
                              .toList(),
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 300,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/categ.jpg'),
                                fit: BoxFit.cover),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: categories!.length,
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    categories![index].name.toUpperCase(),
                                    style: Styles.heading4
                                        .copyWith(color: Colors.black87),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  GridViewBuilder(
                                    products: state.products
                                        .where((product) =>
                                            product.category.toLowerCase() ==
                                            categories![index]
                                                .name
                                                .toLowerCase())
                                        .toList(),
                                  ),
                                ],
                              );
                            }),
                      ],
                    );
            } else {
              return Center(
                child: Text('Something Went Wrong!', style: Styles.heading4),
              );
            }
          },
        ),
      ),
      floatingActionButton: const SearchFAB(),
    );
  }
}
