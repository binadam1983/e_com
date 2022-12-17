// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_com/logic/cart/cart_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:e_com/constants/styles.dart';
import 'package:e_com/models/models.dart';
import 'package:e_com/screens/screens.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/wishlist/wishlist_cubit.dart';

class ProductLayout extends StatelessWidget {
  ProductLayout({
    Key? key,
    required this.product,
    this.width = double.infinity,
    this.height = 180,
    this.isWishlist = false,
  }) : super(key: key);

  Product product;
  final bool isWishlist;
  final double height, width;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context, rootNavigator: true)
          .pushNamed(ProductScreen.routeName, arguments: product),
      child: Stack(
        fit: StackFit.passthrough,
        alignment: Alignment.topCenter,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
            height: height,
            width: width,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              image: DecorationImage(
                  image: AssetImage(product.imageUrl), fit: BoxFit.cover),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
            height: height,
            width: width,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.center,
                colors: [
                  Colors.black.withOpacity(0.6),
                  Colors.black.withOpacity(0.35),
                  Colors.black.withOpacity(0.18),
                  Colors.black.withOpacity(0.05),
                ],
              ),
            ),
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    isWishlist
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              FadeInDown(
                                delay: const Duration(milliseconds: 1000),
                                child: IconButton(
                                  onPressed: () {
                                    BlocProvider.of<WishlistCubit>(context)
                                        .removeProduct(product);

                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            backgroundColor: Colors.red,
                                            content: Text(
                                                '${product.name} removed from Wishlist')));
                                  },
                                  icon: (const Icon(Icons.delete,
                                      size: 30, color: Colors.white)),
                                ),
                              ),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              FadeInDown(
                                delay: const Duration(milliseconds: 1000),
                                child:
                                    BlocBuilder<WishlistCubit, WishlistState>(
                                  builder: (context, state) {
                                    if (state is WishlistLoaded) {
                                      return IconButton(
                                        onPressed: () {
                                          BlocProvider.of<WishlistCubit>(
                                                  context)
                                              .addProduct(product);

                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  backgroundColor:
                                                      Colors.blueGrey,
                                                  content: Text(
                                                      '${product.name} added to Wishlist')));
                                        },
                                        icon: state.wishlist.products
                                                .toString()
                                                .contains(product.name)
                                            ? (const Icon(Icons.favorite,
                                                color: Colors.red, size: 30))
                                            : (const Icon(
                                                Icons.favorite_border_outlined,
                                                color: Colors.white,
                                                size: 30)),
                                      );
                                    } else {
                                      return const Center(
                                          child: Text('Something Went Wrong!'));
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                    Expanded(
                      child: FadeInUp(
                        delay: const Duration(milliseconds: 1200),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text('\$${product.price}',
                                            style: Styles.heading5
                                                .copyWith(color: Colors.white)),
                                      ],
                                    ),
                                  ],
                                ),
                                BlocBuilder<CartCubit, CartState>(
                                  builder: (context, state) {
                                    return IconButton(
                                      onPressed: () {
                                        if (state.props
                                            .toString()
                                            .contains(product.name)) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            content: Text(
                                                'Item already added to the cart'),
                                            backgroundColor: Colors.red,
                                          ));
                                        } else {
                                          BlocProvider.of<CartCubit>(context)
                                              .addProduct(product);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(
                                                '${product.name} added to the cart'),
                                            backgroundColor: Colors.blueGrey,
                                          ));
                                        }
                                      },
                                      icon: state.props
                                              .toString()
                                              .contains(product.name)
                                          ? const Icon(
                                              Icons.remove_shopping_cart,
                                              color: Colors.white,
                                              size: 30,
                                            )
                                          : const Icon(
                                              Icons.add_shopping_cart,
                                              color: Colors.white,
                                              size: 30,
                                            ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
