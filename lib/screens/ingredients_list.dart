import 'package:beer_recipe/crud/crud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../utilities/custom_loading.dart';

class IngredientListScreen extends StatefulWidget {
  const IngredientListScreen({Key? key}) : super(key: key);

  @override
  State<IngredientListScreen> createState() => _IngredientListScreenState();
}

class _IngredientListScreenState extends State<IngredientListScreen> {
  CrudOperation _crudOperation = CrudOperation();

  Future<bool> _onWillPop(BuildContext context) async {
    bool? exitResult = await showDialog(
      context: context,
      builder: (context) => _buildExitDialog(context),
    );

    return exitResult ?? false;
  }

  AlertDialog _buildExitDialog(BuildContext context) {
    return AlertDialog(
      title: const Text('Please confirm'),
      content: const Text('Do you want to exit the app?'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text('No'),
        ),
        TextButton(
          onPressed: () {
            _crudOperation.signOut();
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/', (route) => false);
          },
          child: Text('Yes'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("My Ingredients"),
        ),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _crudOperation.getMaltData(),
                builder: (context, snaphot) {
                  return !snaphot.hasData
                      ? const CustomLoading()
                      : snaphot.data != null
                          ? _mainBody(snaphot,"kilograms","MALT")
                          : const CustomLoading();
                },
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _crudOperation.getHopsData(),
                builder: (context, snaphot) {
                  return !snaphot.hasData
                      ? const CustomLoading()
                      : snaphot.data != null
                      ? _mainBody(snaphot,"grams","HOPS")
                      : const CustomLoading();
                },
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _crudOperation.getYeastData(),
                builder: (context, snaphot) {
                  return !snaphot.hasData
                      ? const CustomLoading()
                      : snaphot.data != null
                      ? _mainBody(snaphot,"grams","YEAST")
                      : const CustomLoading();
                },
              ),
            ),
          ],
        ));
  }

  ListView _mainBody(AsyncSnapshot<QuerySnapshot<Object?>> snaphot,String unit,String title) {
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
              child: _dietListContainer(mypost,unit,title),
            ),
          );
        });
  }

  AlertDialog _alertDialog(DocumentSnapshot mypost, BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Delete Ingredient',
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

  Container _dietListContainer(DocumentSnapshot mypost,String unit,String title) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: _dietListColumn(mypost,unit,title),
    );
  }

  SingleChildScrollView _dietListColumn(DocumentSnapshot mypost,String unit,String title) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            Card(
              child: ListTile(
                leading: Text("${mypost['amount']}"),
                title: Text(unit),
                trailing: Text("${mypost['name']}",
                    style: const TextStyle(
                        color: Colors.red,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                        fontSize: 15)),
              ),
            ),
          ],
        ),
      ),
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
        //_crudOperation.removeData(mypost.id,mypost.);
        //Navigator.pop(context);
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
}
