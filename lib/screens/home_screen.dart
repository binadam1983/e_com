import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_com/constants/styles.dart';
import 'package:e_com/logic/category/category_cubit.dart';
import 'package:e_com/screens/screens.dart';
import 'package:e_com/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;
  static const String routeName = '/';
  static Page page() => const MaterialPage(child: HomeScreen(title: 'e-CART'));

  @override
  Widget build(BuildContext context) {
    // final User user =
    //     context.select((AuthCubit bloc) => bloc.state.(value) => value.User(id: id) ?? User.empty);

    // final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: CustomAppBar(
        title: title,
      ),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () => Navigator.of(context, rootNavigator: true)
                      .pushNamed(NewArrivalsScreen.routeName),
                  child: Container(
                    margin: const EdgeInsets.all(0),
                    height: 300,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/new_arrival.jpg'),
                          fit: BoxFit.cover),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 0.0,
                          left: 0.0,
                          right: 0.0,
                          child: Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(197, 0, 0, 0),
                                  Color.fromARGB(0, 0, 0, 0)
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 20.0),
                            child: Row(
                              children: [
                                Text('New Arrivals',
                                    style: Styles.heading2
                                        .copyWith(color: Colors.white)),
                                const SizedBox(width: 5,),
                                const Icon(Icons.arrow_right_alt, size: 40, color: Colors.white,)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            BlocBuilder<CategoryCubit, CategoryState>(
                builder: (context, state) {
              if (state is CategoryLoading) {
                return const CircularProgressIndicator();
              } else if (state is CategoryLoaded) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('CATEGORIES',
                              style: Styles.heading4
                                  .copyWith(color: Colors.black87)),
                          TextButton(
                              onPressed: () =>
                                  Navigator.of(context, rootNavigator: true)
                                      .pushNamed(
                                    CategoriesScreen.routeName,
                                    arguments: {'categories': state.categories},
                                  ),
                              child: Text(
                                'More >',
                                style: Styles.body1
                                    .copyWith(color: Colors.black87),
                              )),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    CarouselSlider(
                      options: CarouselOptions(
                        enlargeStrategy: CenterPageEnlargeStrategy.height,
                        // autoPlay: true,
                        aspectRatio: 1.8,
                        viewportFraction: 0.9,
                        enlargeCenterPage: true,
                      ),
                      items: state.categories
                          .map((category) =>
                              HeroCarouselCard(category: category))
                          .toList(),
                    ),
                  ],
                );
              } else {
                return Center(
                  child: Text(
                    'Something went wrong',
                    style: Styles.heading4.copyWith(color: Colors.white),
                  ),
                );
              }
            }),
            const SizedBox(height: 5),
            const BestSelling(),
            const SizedBox(height: 5),
            const OnSale(),
          ],
        ),
      ),
      floatingActionButton: const SearchFAB(),
    );
  }
}
