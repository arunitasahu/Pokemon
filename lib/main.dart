import 'package:flutter/material.dart';

import 'package:pokemon/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => PokemonModel(),
      child: const MyApp(),
    ),
  );
}
