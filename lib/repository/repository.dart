import 'dart:convert';

import 'package:beer_recipe/models/recipe_model.dart';
import 'package:http/http.dart';

class RecipeRepository{
  String endpoint='https://api.punkapi.com/v2/beers';

  Future<List<RecipeModel>> getRecipes() async{
    Response response=await get(Uri.parse(endpoint));
    if(response.statusCode==200) {
      final List json = jsonDecode(response.body);
      return json.map(((e) => RecipeModel.fromJson(e))).toList();
    }else{
      throw "Something went wrong code ${response.statusCode}";
    }
  }

}