import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/models.dart';

part 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  // Wishlist? wishlist;
  WishlistCubit() : super(WishlistLoading()) {
    if (state is WishlistLoading) {
      Future<void>.delayed(const Duration(seconds: 1));

      emit(const WishlistLoaded());
    }
  }

  void addProduct(Product product) {
    final state = this.state;
    try {
      if (state is WishlistLoaded) {
        final Wishlist list = Wishlist(
            products: List.from(state.wishlist.products)..add(product));

        emit(WishlistLoaded(wishlist: list));

        FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.email)
            .collection('wishlist')
            .doc(product.name)
            .set(product.toMap());

        //
      }
    } catch (_) {}
  }

  Future removeProduct(Product product) async {
    final state = this.state;

    if (state is WishlistLoaded) {
      final state = this.state;
      try {
        if (state is WishlistLoaded) {
          final Wishlist list = Wishlist(
              products: List.from(state.wishlist.products)..remove(product));

          emit(WishlistLoaded(wishlist: list));

          FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.email)
              .collection('wishlist')
              .doc(product.name)
              .delete();
        }
      } catch (_) {}
    }

    // @override
    // void onChange(Change<WishlistState> change) {
    //   print(change);
    //   super.onChange(change);
    // }
  }
}
