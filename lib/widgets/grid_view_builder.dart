import 'package:e_com/models/product_model.dart';
import 'package:e_com/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../constants/styles.dart';

class GridViewBuilder extends StatelessWidget {
  const GridViewBuilder({
    Key? key,
    required this.products,
  }) : super(key: key);

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: GridView.builder(
        padding: const EdgeInsets.all(0),
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        shrinkWrap: true,
        itemCount: products.length,
        itemBuilder: (context, index) => SizedBox(
          width: size.width * .44,
          height: 210,
          child: ProductLayout(
              product: products[index],
              width: size.width * .44),
        ),
      ),
    );
  }
}
