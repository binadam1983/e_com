
import 'package:bloc/bloc.dart';
import 'package:e_com/models/category_model.dart';
import 'package:e_com/repository/category/category_repo.dart';
import 'package:equatable/equatable.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final CategoryRepo _categoryRepo;
  // StreamSubscription<List<CategoryRepo>>? _categoryRepoStream;

  CategoryCubit({required CategoryRepo categoryRepo})
      : _categoryRepo = categoryRepo,
        super(CategoryLoading()) {
    final state = this.state;
    if (state is CategoryLoading) {
      _categoryRepo
          .getAllCategories()
          .listen((categories) => emit(CategoryLoaded(categories: categories)));

      // _categoryRepoStream!.cancel();
    }
  }

  // void updateCategories(List<Category> categories) {
  //   final state = this.state;
  //   if (state is CategoryLoaded) {
  //     // _categoryRepoStream!.cancel();
  //     _categoryRepo
  //         .getAllCategories()
  //         .listen((categories) => emit(CategoryLoaded(categories: categories)));

  //     // _categoryRepo.getAllCategories().
  //   }
  // }
}
