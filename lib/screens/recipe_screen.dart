import 'package:beer_recipe/recipe/cubit/recipe_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'detail_screen.dart';

class RecipeScreen extends StatefulWidget {
  const RecipeScreen({Key? key}) : super(key: key);

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final cubit = context.read<RecipeCubit>();
      cubit.fetchRecipe();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<RecipeCubit, RecipeState>(
        builder: (context, state) {
          if (state is RecipeInitial || state is LoadingRecipeState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ResponseRecipeState) {
            final recipes = state.recipes;
            return ListView.builder(
                itemCount: recipes.length,
                itemBuilder: (context, index) {
                  final recipe = recipes[index];
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                        child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context)=>DetailScreen(
                                      recipeModel: recipes[index],
                                    )
                                ),
                              );
                            },
                            child: Container(
                              width: 60.0,
                              height: 150.0,
                              child: CachedNetworkImage(
                                imageUrl: recipes[index].imageUrl.toString(),
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            recipes[index].name.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            recipes[index].description.toString(),
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    )),
                  );
                  ;
                });
          } else if (state is ErrorRecipeState) {
            return Text(state.message);
          }
          return Center(
            child: Text(state.toString()),
          );
        },
      ),
    );
  }
}
