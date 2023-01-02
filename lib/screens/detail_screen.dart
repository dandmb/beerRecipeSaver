import 'package:beer_recipe/models/recipe_model.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key, required this.recipeModel}) : super(key: key);
  final RecipeModel recipeModel;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Ingredients"),
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Malt",
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: widget.recipeModel.ingredients!.malt!.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            leading: Text(widget.recipeModel.ingredients!
                                .malt![index].amount!.value!
                                .toString()),
                            title: Text(widget
                                .recipeModel.ingredients!.malt![index].amount!.unit!
                                .toString()),
                            trailing: Text(
                                widget.recipeModel.ingredients!.malt![index].name
                                    .toString(),
                                style: const TextStyle(
                                    color: Colors.red,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15)),
                          ),
                        );
                      }),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Hops",
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: widget.recipeModel.ingredients!.hops!.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            leading: Text(widget.recipeModel.ingredients!
                                .hops![index].amount!.value!
                                .toString()),
                            title: Text(widget
                                .recipeModel.ingredients!.hops![index].amount!.unit!
                                .toString()),
                            trailing: Text(
                                widget.recipeModel.ingredients!.hops![index].name
                                    .toString(),
                                style: const TextStyle(
                                    color: Colors.red,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15)),
                          ),
                        );
                      }),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Yeast",
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.recipeModel.ingredients!.yeast!.toString(),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Water",
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
                Expanded(
                  child: Card(
                    child: ListTile(
                      leading: Text(widget.recipeModel.volume!.value!.toString(),),
                      trailing: Text(
                          widget.recipeModel.volume!.unit!
                              .toString(),
                          style: const TextStyle(
                              color: Colors.red,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold,
                              fontSize: 15)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
