import 'package:e_com/screens/screens.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route onGenerateRoutes(settings) {
    final arguments = settings.arguments;
    Widget screen = Container();

    switch (settings.name) {
      case '/':
        screen = const HomeScreen(
          title: 'e-CART',
        );
        break;
      case '/login':
        screen = LoginScreen();
        break;
      case '/cart':
        screen = const CartScreen(title: 'CART');
        break;
      case '/search':
        screen = SearchScreen(title: 'Search Products');
        break;
      case '/splash':
        screen = const SplashScreen();
        break;
      case '/wishlist':
        screen = const WishlistScreen(title: 'WISHLIST');
        break;
      case '/profile':
        screen = const ProfileScreen(title: 'PROFILE');
        break;
      case '/categories':
        screen = CategoriesScreen(
          title: 'CATEGORIES',
          category: arguments['category'],
          categories: arguments['categories'],
        );
        break;
      case '/products':
        screen = const ProductsScreen(title: 'ALL PRODUCTS');
        break;
      case '/product':
        screen = ProductScreen(title: '', product: arguments);
        break;
      case '/new_arrivals':
        screen = const NewArrivalsScreen(title: 'NEW ARRIVALS');
        break;
      case '/best_selling':
        screen = const BestSellingScreen(title: 'BEST SELLING');
        break;
      case '/onsale':
        screen = const OnSaleScreen(title: 'ON SALE');
        break;

      // default:
    }

    return MaterialPageRoute(builder: (context) => screen);
  }
}
