import 'package:animate_do/animate_do.dart';
import 'package:badges/badges.dart';
import 'package:e_com/constants/styles.dart';
import 'package:e_com/logic/cart/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.black),
      title: Text(title, style: Styles.heading4.copyWith(color: Colors.black)),
      centerTitle: true,
      actions: [
        Row(
          children: [
            FadeInDown(
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true)
                        .pushNamed('/wishlist');
                  },
                  icon: const Icon(Icons.favorite)),
            ),
            BlocBuilder<CartCubit, CartState>(builder: (context, state) {
              if (state is CartLoaded) {
                return Badge(
                  badgeColor: Colors.white,
                  position: BadgePosition.topEnd(top: 0, end: 3),
                  badgeContent: Text(state.cart.products.length.toString(),
                      style: Styles.body2.copyWith(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      )),
                  child: FadeInRight(
                    child: IconButton(
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true)
                              .pushNamed('/cart');
                        },
                        icon: const Icon(Icons.shopping_cart_sharp)),
                  ),
                );
              } else {
                return Container();
              }
            }),
            const SizedBox(
              width: 5,
            ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50.0);
}
