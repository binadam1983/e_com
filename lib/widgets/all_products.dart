import 'package:e_com/constants/styles.dart';
import 'package:e_com/logic/product/product_cubit.dart';
import 'package:e_com/screens/screens.dart';
import 'package:e_com/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllProductsScreen extends StatelessWidget {
  const AllProductsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final products = Product.products;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('ON SALE',
                  style: Styles.heading4.copyWith(color: Colors.black87)),
              TextButton(
                onPressed: () => Navigator.of(context, rootNavigator: true)
                    .pushNamed(ProductsScreen.routeName),
                child: Text('More >',
                    style: Styles.body1.copyWith(color: Colors.black87)),
              ),
            ],
          ),
        ),
        BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ProductLoaded) {
              final products = state.products
                  .where((product) => product.isBestSelling == true)
                  .toList()
                  .sublist(2, 8);
              return SizedBox(
                height: 200,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                    padding: const EdgeInsets.all(0),
                    scrollDirection: Axis.horizontal,
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return ProductLayout(
                        product: products[index],
                        width: MediaQuery.of(context).size.width * 0.42,
                      );
                    }),
              );
              // return GridViewBuilder(products: state.products.sublist(0, 6));
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
    );
  }
}
