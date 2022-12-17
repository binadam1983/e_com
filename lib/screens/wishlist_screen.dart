import 'package:e_com/constants/styles.dart';
import 'package:e_com/models/models.dart';
import 'package:e_com/widgets/widgets.dart';
import 'package:flutter/material.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;
  static const String routeName = '/wishlist';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: CustomAppBar(title: title),
      // extendBodyBehindAppBar: true,
      drawer: CustomDrawer(),
      body: StreamBuilder(
          stream: Wishlist.getWishlist(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                  child: Text('Error occurred while fetching wishlist from DB',
                      style: Styles.heading4.copyWith(color: Colors.black54)));
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              final doc = snapshot.data as List<Product>;

              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: doc.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: WishlistProductCard(product: doc[index]),
                    );
                  });
            } else {
              return Center(
                  child: Text('Wishlist Empty',
                      style: Styles.heading4.copyWith(color: Colors.black54)));
            }
          }),
      floatingActionButton: const SearchFAB(),
    );
  }
}
