import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../crud/crud.dart';
import '../utilities/custom_loading.dart';

class RecipeListScreen extends StatefulWidget {
  const RecipeListScreen({Key? key}) : super(key: key);

  @override
  State<RecipeListScreen> createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends State<RecipeListScreen> {
  CrudOperation _crudOperation = CrudOperation();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recipes"),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _crudOperation.getRecipes(),
              builder: (context, snaphot) {
                return !snaphot.hasData
                    ? const CustomLoading()
                    : snaphot.data != null
                    ? _mainBody(snaphot)
                    : const CustomLoading();
              },
            ),
          ),
        ]
      ),
      );
  }

  ListView _mainBody(AsyncSnapshot<QuerySnapshot<Object?>> snaphot) {
    return ListView.builder(
        itemCount: snaphot.data?.docs.length ?? 0,
        itemBuilder: (context, index) {
          DocumentSnapshot mypost = snaphot.data!.docs[index];

          Future<void> _showChoiseDialog(BuildContext context) {
            return showDialog(
                context: context,
                builder: (BuildContext context) {
                  return _alertDialog(mypost, context);
                });
          }

          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: InkWell(
              onTap: () {
                _showChoiseDialog(context);
              },
              child: _dietListContainer(mypost),
            ),
          );
        });
  }
  AlertDialog _alertDialog(DocumentSnapshot mypost, BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Delete Recipe',
        textAlign: TextAlign.center,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      content: _alertDialogContent(mypost, context),
    );
  }
  Row _alertDialogContent(DocumentSnapshot mypost, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        _removeButton(mypost, context),
        _giveUpButton(context),
      ],
    );
  }
  InkWell _removeButton(DocumentSnapshot mypost, BuildContext context) {
    return InkWell(
      onTap: () {
        _crudOperation.removeRecipe(mypost.id);
        Navigator.pop(context);
      },
      child: Container(
        width: 100,
        decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            "Delete",
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  InkWell _giveUpButton(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        width: 100,
        decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            'Cancel',
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }


  Container _dietListContainer(DocumentSnapshot mypost) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: _dietListColumn(mypost),
    );
  }
  Padding _dietListColumn(DocumentSnapshot mypost) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "${mypost['title'].toUpperCase()}",
              style: const TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "${mypost['description']}",
            style: const TextStyle(

                fontWeight: FontWeight.bold, color: Colors.white),
            //textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }



}
