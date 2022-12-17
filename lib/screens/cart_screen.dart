// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:e_com/constants/styles.dart';
import 'package:e_com/logic/cart/cart_cubit.dart';
import 'package:flutter/material.dart';

import 'package:e_com/models/models.dart';
import 'package:e_com/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/link.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  static const String routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: CustomAppBar(title: title),
        // extendBodyBehindAppBar: true,
        drawer: CustomDrawer(),
        body: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is CartLoaded && state.cart.products.isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                'Add \$${CartModel(products: state.cart.products).freeDeliveryString} for FREE delivery',
                                style: Styles.heading5.copyWith(
                                    fontSize: 18, color: Colors.black87)),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context, rootNavigator: true)
                                    .pushNamed('/');
                              },
                              style: ElevatedButton.styleFrom(
                                // side: const BorderSide(width: 2, color: Colors.black87),
                                // backgroundColor: Colors.deepPurple,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                              ),
                              child: Text('Add More',
                                  style:
                                      Styles.heading5.copyWith(fontSize: 16)),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 250,
                          child: ListView.builder(
                              padding: const EdgeInsets.all(0),
                              itemCount: state.cart
                                  .productQuantityMap(state.cart.products)
                                  .length,
                              itemBuilder: (context, index) {
                                return ProductCard(
                                  product: state.cart
                                      .productQuantityMap(state.cart.products)
                                      .keys
                                      .elementAt(index),
                                  quantity: state.cart
                                      .productQuantityMap(state.cart.products)
                                      .values
                                      .elementAt(index),
                                );
                              }),
                        ),
                      ],
                    ),
                    // const SizedBox(height: 200),
                    Expanded(
                      child: Column(
                        children: [
                          const Divider(
                            thickness: 3,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('SUBTOTAL',
                                  style: Styles.heading5.copyWith(
                                      fontSize: 16, color: Colors.black87)),
                              Text(
                                  '\$${CartModel(products: state.cart.products).subTotalString}',
                                  style: Styles.heading5.copyWith(
                                      fontSize: 16, color: Colors.black87)),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Delivery Fee',
                                  style: Styles.heading5.copyWith(
                                      fontSize: 16, color: Colors.black87)),
                              Text(
                                  "\$${CartModel(products: state.cart.products).deliveryFeeString}",
                                  style: Styles.heading5.copyWith(
                                      fontSize: 16, color: Colors.black87)),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    style: BorderStyle.solid,
                                    color: Colors.black87,
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                margin: const EdgeInsets.all(5.0),
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'TOTAL',
                                      style: Styles.heading4
                                          .copyWith(color: Colors.black87),
                                    ),
                                    Text(
                                        '\$${CartModel(products: state.cart.products).total}',
                                        style: Styles.heading4
                                            .copyWith(color: Colors.black87)),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Link(
                                  uri: Uri.parse(
                                      'https://buy.stripe.com/test_00g9DKdc7d1kdJC4gi'),
                                  builder: ((context, followLink) {
                                    return ElevatedButton(
                                      onPressed: followLink,
                                      // onPressed: _launchUrl,
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 10),
                                        // side: const BorderSide(width: 2, color: Colors.black87),
                                        // backgroundColor: Colors.black87,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                      ),
                                      child: Text('Proceed to Checkout',
                                          style: Styles.heading4),
                                    );
                                  })),
                            ],
                          ),

                          // ElevatedButton(
                          //   onPressed: _launchUrl,
                          //   style: ElevatedButton.styleFrom(
                          //     padding: const EdgeInsets.symmetric(
                          //         vertical: 8, horizontal: 65),
                          //     // side: const BorderSide(width: 2, color: Colors.black87),
                          //     backgroundColor: Colors.black87,
                          //     shape: RoundedRectangleBorder(
                          //         borderRadius: BorderRadius.circular(30)),
                          //   ),
                          //   child: Text('Proceed to Checkout',
                          //       style: Styles.heading4),
                          // ),
                          const SizedBox(
                            height: 8,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is CartLoaded && state.cart.products.isEmpty) {
              return Center(
                child: Text('Cart is Empty',
                    style: Styles.heading4.copyWith(color: Colors.black)),
              );
            } else {
              return Center(
                child: Text('Something Went Wrong!',
                    style: Styles.heading4.copyWith(color: Colors.black87)),
              );
            }
          },
        ));
  }

  // Future<void> _launchUrl() async {
  //   final Uri url = Uri.parse('https://buy.stripe.com/test_eVa17e4FB0eyeNG289');
  //   if (!await canLaunchUrl(url)) {
  //     print('cant Launch URL');
  //   }
  // }
}
