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
      print(json);
      //final result=json.map((e){
      /*  
      return RecipeModel(
            id :e['id'],
            name :e['name'],
            tagline :e['tagline'],
            firstBrewed :e['first_brewed'],
            description :e['description'],
            imageUrl :e['image_url'],
            abv :e['abv'],
            ibu :e['ibu'],
            targetFg :e['target_fg'],
            targetOg :e['target_og'],
            ebc :e['ebc'],
            srm :e['srm'],
            ph :e['ph'],
        attenuationLevel :e['attenuation_level'],
            volume :e['volume'],
            method :e['method'],
            ingredients :e['ingredients'],
            foodPairing :e['food_pairing'],
            brewersTips :e['brewers_tips'],
            contributedBy :e['contributed_by'],
        );*/
    }else{
      throw "Something went wrong code ${response.statusCode}";
    }
  }

}