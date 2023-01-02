import 'package:beer_recipe/screens/recipe_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../utilities/Utilities.dart';
import 'home_page.dart';
import 'myrecipe_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class TabSelection extends StatelessWidget {
  const TabSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = TextButton.styleFrom(
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
    );
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text(Utilities.appTitle)),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                  icon: FaIcon(
                FontAwesomeIcons.seedling,
              )),
              Tab(
                  icon: FaIcon(
                FontAwesomeIcons.beerMugEmpty,
              )),
              Tab(
                  icon: FaIcon(
                FontAwesomeIcons.list,
              )),
            ],
          ),
          actions: <Widget>[
            TextButton(
              style: style,
              onPressed: () async {
                var user = _auth.currentUser;
                if (user == null) {
//6
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('No one has signed in.')));
                  return;
                }

                _auth.signOut();
                final String uid = user.uid;
                Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Successfully signed out')));
              },
              child: const Text('SIGN OUT'),
            ),
          ],
          automaticallyImplyLeading: false,
        ),
        body: const TabBarView(
          children: [
            HomeScreen(),
            MyRecipeScreen(),
            RecipeScreen(),
          ],
        ),
      ),
    );
  }
}
