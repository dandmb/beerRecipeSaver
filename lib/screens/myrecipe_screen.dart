import 'package:flutter/material.dart';

import '../utilities/Utilities.dart';

class MyRecipeScreen extends StatelessWidget {
  const MyRecipeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: myAppBar(context),
      body: Center(
        child: Column(
          children: [
            Image.network(
                Utilities.imageLink),
            Text(
              'Welcome to My recipe Screen!',
              style: Theme
                  .of(context)
                  .textTheme
                  .displaySmall,
            ),
          ],
        ),
      ),
    );
  }
}