import 'package:beer_recipe/screens/recipes_list.dart';
import 'package:flutter/material.dart';

import '../crud/crud.dart';
import '../utilities/Utilities.dart';

class MyRecipeScreen extends StatefulWidget {
  const MyRecipeScreen({Key? key}) : super(key: key);

  @override
  State<MyRecipeScreen> createState() => _MyRecipeScreenState();
}

class _MyRecipeScreenState extends State<MyRecipeScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _ingrTitleController = TextEditingController();
  final TextEditingController _ingrDescriptionController = TextEditingController();
  CrudOperation crudOperation=CrudOperation();
  @override
  void dispose() {
    _ingrTitleController.dispose();
    _ingrDescriptionController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    "Add Recipes",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    // The validator receives the text that the user has entered.
                    controller: _ingrTitleController,
                    decoration:
                    const InputDecoration(labelText: 'Recipe Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
                Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      // The validator receives the text that the user has entered.
                      controller: _ingrDescriptionController,
                      minLines: 6, // any number you need (It works as the rows for the textarea)
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: const InputDecoration(labelText: 'Recipe Description'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25.0),
                  child: ElevatedButton(
                    onPressed: () async {

                      if (_formKey.currentState!.validate()) {

                        String response=await crudOperation
                            .addRecipe(_ingrTitleController.text, _ingrDescriptionController.text);

                        if(response.isNotEmpty){
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(response)),
                          );
                        }
                        _ingrTitleController.clear();
                        _ingrDescriptionController.clear();
                      }

                    },
                    child: const Text('Save'),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.blue,
                        textStyle: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) =>
                              const RecipeListScreen()),
                        );
                      },
                      child: const Text('Available Recipes'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
