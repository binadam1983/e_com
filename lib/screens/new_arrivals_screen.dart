import 'package:e_com/constants/styles.dart';
import 'package:e_com/logic/product/product_cubit.dart';
import 'package:e_com/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewArrivalsScreen extends StatelessWidget {
  const NewArrivalsScreen({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;
  static const String routeName = '/new_arrivals';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: CustomAppBar(title: title),
      // extendBodyBehindAppBar: true,
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.all(0),
              height: 300,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/bestsell2.jpg'),
                    fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'New Arrivals'.toUpperCase(),
                style: Styles.heading4.copyWith(color: Colors.black87),
              ),
            ),
            BlocBuilder<ProductCubit, ProductState>(
              builder: (context, state) {
                if (state is ProductLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is ProductLoaded) {
                  return GridViewBuilder(
                      products: state.products
                          .where((product) => product.isNewArrival == true)
                          .toList());
                } else {
                  return Center(
                    child:
                        Text('Something Went Wrong!', style: Styles.heading4),
                  );
                }
              },
            )
          ],
        ),
      ),
      floatingActionButton: const SearchFAB(),
    );
  }
}
