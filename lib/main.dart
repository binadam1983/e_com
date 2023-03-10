// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:auth0_flutter/auth0_flutter.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:e_com/app_router/app_router.dart';
import 'package:e_com/constants/styles.dart';
import 'package:e_com/repository/repos.dart';
import 'package:e_com/screens/screens.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'app_router/initial_routes.dart';
import 'logic/cubits.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      'pk_test_51M80UlELKVVYCS7SnLlzkxbTrL1uliSnP4EomGpBu0wWFd2pHrCeM2nWX9f4CBWoKLFRhnYHtVKHF81ZqMhAVIpz00n7lBP0VF';
  Stripe.instance.applySettings();
  await Firebase.initializeApp();
  runApp(MyApp(
    categoryRepo: CategoryRepo(),
    productRepo: ProductRepo(),
    authRepo: AuthRepo(),
  ));
}

class MyApp extends StatelessWidget {
  final CategoryRepo categoryRepo;
  final ProductRepo productRepo;
  final AuthRepo authRepo;
  const MyApp({
    Key? key,
    required this.categoryRepo,
    required this.productRepo,
    required this.authRepo,
  }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WishlistCubit>(
          create: (context) => WishlistCubit(),
        ),
        BlocProvider<CartCubit>(
          create: (context) => CartCubit(),
        ),
        BlocProvider<CategoryCubit>(
          create: (context) => CategoryCubit(categoryRepo: categoryRepo),
        ),
        BlocProvider<ProductCubit>(
          create: (context) => ProductCubit(productRepo: productRepo),
        ),
        BlocProvider<FilteredProductsCubit>(
          create: (context) => FilteredProductsCubit(productRepo: productRepo),
        ),
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(authRepo: authRepo),
        ),
      ],
      child: MaterialApp(
        title: 'e-CART App',
        theme: Styles.themeData,
        // home: const MainPage(),
        // home: const HomeScreen(title: 'e-CART'),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRouter.onGenerateRoutes,
        initialRoute: SplashScreen.routeName,
        home: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is AppState) {
              return FlowBuilder(
                  state: context.select((context) => state.appStatus),
                  onGeneratePages: onGenerateAppViewPages);
            } else {
              return const Center(child: Text('Something Went Wrong!'));
            }
          },
        ),
      ),
    );
  }
}
