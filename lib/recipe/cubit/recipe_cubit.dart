import 'package:beer_recipe/models/recipe_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../repository/repository.dart';

part 'recipe_state.dart';

class RecipeCubit extends Cubit<RecipeState> {
  final RecipeRepository _recipeRepository;
  RecipeCubit(this._recipeRepository) : super(RecipeInitial());

  Future<void>fetchRecipe() async{

    emit(LoadingRecipeState());
    try{
      final response=await _recipeRepository.getRecipes();
      emit(ResponseRecipeState(response));
    }catch(e){
      emit(ErrorRecipeState(e.toString()));
    }

  }

}
