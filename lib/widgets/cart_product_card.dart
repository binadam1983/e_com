// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:e_com/constants/styles.dart';
import 'package:e_com/logic/cart/cart_cubit.dart';
import 'package:e_com/models/product_model.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.product,
    required this.quantity,
  }) : super(key: key);

  final Product product;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            height: 100,
            width: 120,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(product.imageUrl), fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(width: 5),
          SizedBox(
            width: 135,
            height: 100,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(product.name,
                        style: Styles.body1.copyWith(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold)),
                    Text(product.category,
                        style: Styles.body2.copyWith(
                            color: Colors.grey, fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 25,
                    ),
                    Text('\$${product.price}',
                        style: Styles.body1.copyWith(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold)),
                  ]),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    BlocProvider.of<CartCubit>(context).removeProduct(product);
                  },
                  icon: const Icon(
                    Icons.remove_circle_rounded,
                    size: 30,
                  ),
                ),
                Text(quantity.toString(),
                    style: Styles.heading5.copyWith(color: Colors.black87)),
                IconButton(
                    onPressed: () {
                      BlocProvider.of<CartCubit>(context).addProduct(product);
                    },
                    icon: const Icon(
                      Icons.add_circle_rounded,
                      size: 30,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
