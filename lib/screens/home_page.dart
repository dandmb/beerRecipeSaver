import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import '../crud/crud.dart';
import 'ingredients_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _ingrNameController = TextEditingController();
  final TextEditingController _ingrAmountController = TextEditingController();
  late String _myActivity;
  late String _myActivityResult;

  String dropdownvalue = 'MALT';

  // List of items in our dropdown menu
  var items = ['MALT', 'HOPS', 'YEAST'];
  CrudOperation crudOperation=CrudOperation();

  @override
  void initState() {
    super.initState();
    _myActivity = '';
    _myActivityResult = '';
  }

  @override
  void dispose() {
    _ingrNameController.dispose();
    _ingrAmountController.dispose();
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
                    "Add Ingredients",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                ),
                Container(
                  //padding: EdgeInsets.all(16),
                  child: DropDownFormField(

                    titleText: 'My workout',
                    hintText: 'Please choose one',
                    value: _myActivity,
                    onSaved: (value) {
                      setState(() {
                        _myActivity = value;
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        _myActivity = value;
                      });
                    },
                    dataSource: const [
                      {
                        "display": "MALT",
                        "value": "MALT",
                      },
                      {
                        "display": "HOPS",
                        "value": "HOPS",
                      },
                      {
                        "display": "YEAST",
                        "value": "YEAST",
                      },
                    ],
                    textField: 'display',
                    valueField: 'value',
                  ),
                ),
                /*
                Container(
                  padding: EdgeInsets.all(8),
                  child: RaisedButton(
                    child: Text('Save'),
                    onPressed: _saveForm,
                  ),
                ),
                 */
                TextFormField(
                  // The validator receives the text that the user has entered.
                  controller: _ingrNameController,
                  decoration:
                      const InputDecoration(labelText: 'Ingredient Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  // The validator receives the text that the user has entered.
                  controller: _ingrAmountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Amount'),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Text(_myActivityResult),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25.0),
                  child: ElevatedButton(
                    onPressed: () async {

                      if (_formKey.currentState!.validate()) {


                        setState(() {
                          _myActivityResult = _myActivity;
                        });

                        String response=await crudOperation
                            .addIngredient(_ingrNameController.text, _ingrAmountController.text, _myActivityResult);

                        if(response.isNotEmpty){
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(response)),
                          );
                        }
                        _ingrNameController.clear();
                        _ingrAmountController.clear();
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
                                  const IngredientListScreen()),
                        );
                      },
                      child: const Text('Available Ingredients'),
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
