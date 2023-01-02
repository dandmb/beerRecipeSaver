import 'package:beer_recipe/recipe/cubit/recipe_cubit.dart';
import 'package:beer_recipe/repository/repository.dart';
import 'package:beer_recipe/screens/login_screen.dart';
import 'package:beer_recipe/screens/recipe_screen.dart';
import 'package:beer_recipe/screens/registration_screen.dart';
import 'package:beer_recipe/screens/tab_selection.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:http/http.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => RecipeCubit(RecipeRepository()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        //home: RegistrationScreen(),
        initialRoute: '/',
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
          '/': (context) => const LoginScreen(),
          // When navigating to the "/second" route, build the SecondScreen widget.
          '/register': (context) => const RegistrationScreen(),
          '/recipe': (context) => const TabSelection(),
        },

      ),
    );

  }
}
