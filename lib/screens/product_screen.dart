// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:e_com/logic/cart/cart_cubit.dart';
import 'package:e_com/logic/wishlist/wishlist_cubit.dart';
import 'package:flutter/material.dart';

import 'package:e_com/models/product_model.dart';
import 'package:e_com/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/styles.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({
    Key? key,
    required this.title,
    required this.product,
  }) : super(key: key);

  final String title;
  final Product product;
  static const String routeName = '/product';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: CustomAppBar(title: product.name),
      // extendBodyBehindAppBar: true,
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.all(0),
              padding: const EdgeInsets.all(0),
              height: size.height * 0.45,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(product.imageUrl), fit: BoxFit.cover),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                border: Border.all(
                  style: BorderStyle.solid,
                  color: Colors.black87,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.all(15.0),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    product.name,
                    style: Styles.heading4.copyWith(color: Colors.black87),
                  ),
                  Text(
                    '\$${product.price}',
                    style: Styles.heading4.copyWith(color: Colors.black87),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ExpansionTile(
              initiallyExpanded: true,
              title: Text(
                'Product Information',
                style: Styles.heading4.copyWith(color: Colors.black87),
              ),
              leading: const Icon(
                Icons.info,
                color: Colors.black87,
                size: 25,
              ),
              children: [
                ListTile(
                  leading: Text(
                    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s',
                    style: Styles.body1.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.black54),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            ExpansionTile(
              initiallyExpanded: true,
              title: Text(
                'Delivery Information',
                style: Styles.heading4.copyWith(color: Colors.black87),
              ),
              leading: const Icon(
                Icons.local_shipping_sharp,
                color: Colors.black87,
                size: 25,
              ),
              children: [
                ListTile(
                  leading: Text(
                    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s',
                    style: Styles.body1.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.black54),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  BlocBuilder<CartCubit, CartState>(
                    builder: (context, state) {
                      return ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              // backgroundColor: Colors.black87,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)))),
                          onPressed: () {
                            if (state.props.toString().contains(product.name)) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text('Item already added to the cart'),
                                backgroundColor: Colors.deepOrange,
                              ));
                            } else {
                              BlocProvider.of<CartCubit>(context)
                                  .addProduct(product);
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content:
                                    Text('${product.name} added to the cart'),
                                backgroundColor: Colors.blueGrey,
                              ));
                            }
                          },
                          icon: state.props.toString().contains(product.name)
                              ? const Icon(
                                  Icons.remove_shopping_cart,
                                )
                              : const Icon(
                                  Icons.add_shopping_cart,
                                ),
                          label: state.props.toString().contains(product.name)
                              ? Text(
                                  'Added to Cart',
                                  style: Styles.heading5,
                                )
                              : Text(
                                  'Add to Cart',
                                  style: Styles.heading5,
                                ));
                    },
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  BlocBuilder<WishlistCubit, WishlistState>(
                    builder: (context, state) {
                      return ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              shape: const RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.black87),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)))),
                          onPressed: () {
                            BlocProvider.of<WishlistCubit>(context)
                                .addProduct(product);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: Colors.blueGrey,
                                content:
                                    Text('${product.name} added to Wishlist')));
                          },
                          icon: state.props.toString().contains(product.name)
                              ? (const Icon(Icons.favorite, color: Colors.red))
                              : (const Icon(
                                  Icons.favorite_border_outlined,
                                  color: Colors.black87,
                                )),
                          label: state.props.toString().contains(product.name)
                              ? Text(
                                  'Added to Wishlist',
                                  style: Styles.heading5
                                      .copyWith(color: Colors.black87),
                                )
                              : Text(
                                  'Add to Wishlist',
                                  style: Styles.heading5
                                      .copyWith(color: Colors.black87),
                                ));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: const SearchFAB(),
    );
  }
}
