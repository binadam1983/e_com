// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'wishlist_cubit.dart';

abstract class WishlistState extends Equatable {
  const WishlistState();

  @override
  List<Object> get props => [];
}

class WishlistLoading extends WishlistState {}

class WishlistLoaded extends WishlistState {
  final Wishlist wishlist;

  const WishlistLoaded({
    this.wishlist = const Wishlist(),
  });

  @override
  List<Object> get props => [wishlist];
}
