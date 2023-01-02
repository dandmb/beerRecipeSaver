part of 'recipe_cubit.dart';

abstract class RecipeState{
}

class RecipeInitial extends RecipeState {
  @override
  List<Object> get props => [];
}
class LoadingRecipeState extends RecipeState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}
class ErrorRecipeState extends RecipeState {
  final String message;
  ErrorRecipeState(this.message);
}
class ResponseRecipeState extends RecipeState {
  final List<RecipeModel> recipes;
  ResponseRecipeState(this.recipes);

}