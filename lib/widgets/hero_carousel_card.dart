// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:animate_do/animate_do.dart';
import 'package:e_com/constants/styles.dart';
import 'package:e_com/screens/categories_screen.dart';
import 'package:flutter/material.dart';
import 'package:e_com/models/category_model.dart';

class HeroCarouselCard extends StatelessWidget {
  const HeroCarouselCard({
    Key? key,
    required this.category,
  }) : super(key: key);

  final Category category;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context, rootNavigator: true).pushNamed(
          CategoriesScreen.routeName,
          arguments: {'category': category.name.toLowerCase()}),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          child: FadeInDown(
            child: Stack(
              children: <Widget>[
                Image.asset(category.imageUrl,
                    fit: BoxFit.cover, width: 1000.0),
                Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(199, 68, 68, 68),
                          Color.fromARGB(0, 52, 51, 51)
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 20.0),
                    child: FadeInDown(
                        child: Text(category.name,
                            style:
                                Styles.heading4.copyWith(color: Colors.white))),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
