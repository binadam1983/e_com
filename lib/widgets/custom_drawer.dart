// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:e_com/constants/styles.dart';
import 'package:e_com/logic/category/category_cubit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../logic/auth/auth_cubit.dart';

class CustomDrawer extends StatefulWidget {
  int _selectedIndex = 0;
  static final _instance = CustomDrawer._();

  CustomDrawer._();

  factory CustomDrawer() => _instance;

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  void _onSelectItem(int index) {
    setState(() {
      widget._selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 124, 25, 163),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if (state is AppState) {
                return UserAccountsDrawerHeader(
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 124, 25, 163)),
                  accountName: Text(
                    '${state.user!.email}',
                    style: const TextStyle(color: Colors.black),
                  ),
                  accountEmail: Text(
                    FirebaseAuth.instance.currentUser!.emailVerified
                        ? '(Verified)'
                        : '(Un-verified)',
                    style: Styles.body1.copyWith(
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.italic),
                  ),
                  currentAccountPicture: const CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      color: Color.fromARGB(255, 124, 25, 163),
                      size: 50,
                    ),
                  ),
                );
              } else {
                return const Center(child: Text('Something Went Wrong'));
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                ListTile(
                  selected: widget._selectedIndex == 0,
                  selectedTileColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  leading: const Icon(Icons.home, color: Colors.black),
                  title: Text('Home',
                      style: Styles.heading5.copyWith(color: Colors.black)),
                  onTap: () {
                    _onSelectItem(0);
                    Navigator.of(context, rootNavigator: true)
                        .pushReplacementNamed('/');
                  },
                ),
                BlocBuilder<CategoryCubit, CategoryState>(
                  builder: (context, state) {
                    if (state is CategoryLoaded) {
                      return ListTile(
                        selected: widget._selectedIndex == 1,
                        selectedTileColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        leading:
                            const Icon(Icons.category, color: Colors.black),
                        title: Text(
                          'Categories',
                          style: Styles.heading5,
                        ),
                        onTap: () {
                          _onSelectItem(1);
                          Navigator.of(context, rootNavigator: true)
                              .pushReplacementNamed('/categories',
                                  arguments: {'categories': state.categories});
                        },
                      );
                    } else {
                      return const Center(child: Text('Something went wrong!'));
                    }
                  },
                ),
                ListTile(
                  selected: widget._selectedIndex == 2,
                  selectedTileColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  leading: const Icon(Icons.new_label, color: Colors.black),
                  title: Text(
                    'New Arrivals',
                    style: Styles.heading5,
                  ),
                  onTap: () {
                    _onSelectItem(2);
                    Navigator.of(context, rootNavigator: true)
                        .pushReplacementNamed('/new_arrivals');
                  },
                ),
                ListTile(
                  selected: widget._selectedIndex == 3,
                  selectedTileColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  leading: const Icon(Icons.sell, color: Colors.black),
                  title: Text('Best Selling', style: Styles.heading5),
                  onTap: () {
                    _onSelectItem(3);
                    Navigator.of(context, rootNavigator: true)
                        .pushReplacementNamed('/best_selling');
                  },
                ),
                ListTile(
                  selected: widget._selectedIndex == 4,
                  selectedTileColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  leading: const Icon(FontAwesomeIcons.borderAll,
                      color: Colors.black),
                  title: Text('All Products', style: Styles.heading5),
                  onTap: () {
                    _onSelectItem(4);
                    Navigator.of(context, rootNavigator: true)
                        .pushReplacementNamed('/products');
                  },
                ),
                const Divider(
                  color: Colors.black,
                  thickness: 1,
                ),
                ListTile(
                  selected: widget._selectedIndex == 5,
                  selectedTileColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  leading: const Icon(Icons.history, color: Colors.black),
                  title: Text('Purchase History', style: Styles.heading5),
                  onTap: () {
                    _onSelectItem(5);
                    Navigator.of(context, rootNavigator: true)
                        .pushReplacementNamed('/profile');
                  },
                ),
                ListTile(
                  selected: widget._selectedIndex == 6,
                  selectedTileColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  leading: const Icon(Icons.favorite, color: Colors.black),
                  title: Text('My Wishlist', style: Styles.heading5),
                  onTap: () {
                    _onSelectItem(6);
                    Navigator.of(context, rootNavigator: true)
                        .pushReplacementNamed('/wishlist');
                  },
                ),
                const Divider(
                  color: Colors.black,
                  thickness: 1,
                ),
                ListTile(
                  selected: widget._selectedIndex == 7,
                  selectedTileColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  leading: const Icon(Icons.contact_phone, color: Colors.black),
                  title: Text('Contact Us', style: Styles.heading5),
                  onTap: () {
                    _onSelectItem(0);
                  },
                ),
                const Divider(
                  color: Colors.black,
                  thickness: 1,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.logout,
                    color: Colors.black,
                  ),
                  title: Text('Logout',
                      style: Styles.heading5.copyWith(color: Colors.red)),
                  onTap: () {
                    Navigator.pop(context);
                    BlocProvider.of<AuthCubit>(context).logoutRequested();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
