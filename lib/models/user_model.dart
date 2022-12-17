import 'package:equatable/equatable.dart';

class User extends Equatable {
  String id;
  String? email;
  String? name;
  String? photo;

  User({
    required this.id,
    this.email,
    this.name,
    this.photo,
  });

  static final empty = User(id: '');

  bool get isEmpty => this == User.empty;
  bool get isNotEmpty => this != User.empty;

  @override
  List<Object?> get props => [id, email, name, photo];
}
