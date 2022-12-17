import 'package:animate_do/animate_do.dart';
import 'package:e_com/constants/styles.dart';
import 'package:e_com/logic/wishlist/wishlist_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/cart/cart_cubit.dart';
import '../models/models.dart';

class WishlistProductCard extends StatelessWidget {
  const WishlistProductCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(product.imageUrl), fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            SizedBox(
              width: 180,
              height: 100,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 5),
                      Text(product.name,
                          style: Styles.body1.copyWith(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold)),
                      Text('Category: ${product.category}',
                          style: Styles.body2.copyWith(
                              color: Colors.grey, fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: Text('\$${product.price}',
                            style: Styles.heading5.copyWith(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold)),
                      ),
                    ]),
              ),
            ),
            SizedBox(
              height: 100,
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FadeInDown(
                      delay: const Duration(milliseconds: 1000),
                      child: IconButton(
                        onPressed: () {
                          BlocProvider.of<WishlistCubit>(context)
                              .removeProduct(product);

                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.red,
                              content: Text(
                                  '${product.name} removed from Wishlist')));
                        },
                        icon: (const Icon(Icons.delete, size: 30)),
                      ),
                    ),
                    FadeInDown(
                      child: IconButton(
                        onPressed: () {
                          BlocProvider.of<CartCubit>(context)
                              .addProduct(product);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content:
                                Text('${product.name} added to the Wishlist'),
                            backgroundColor: Colors.blueGrey,
                          ));
                        },
                        // },
                        icon: const Icon(
                          Icons.add_shopping_cart,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ]),
            ),
          ],
        ));
  }
}
