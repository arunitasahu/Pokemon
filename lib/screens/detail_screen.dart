import 'package:flutter/material.dart';

class PokemonDetailScreen extends StatelessWidget {
  final Map<String, dynamic> pokemon;

  const PokemonDetailScreen({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pokemon['name']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(pokemon['img']),
            const SizedBox(height: 16.0),
            Text('Type: ${pokemon['type'].join(', ')}'),
            const SizedBox(height: 8.0),
            Text('Height: ${pokemon['height']}'),
            const SizedBox(height: 8.0),
            Text('Weight: ${pokemon['weight']}'),
            const SizedBox(height: 8.0),
            Text('Candy: ${pokemon['candy']}'),
            const SizedBox(height: 8.0),
            Text('Candy Count: ${pokemon['candy_count']}'),
            const SizedBox(height: 8.0),
            Text('Egg: ${pokemon['egg']}'),
            const SizedBox(height: 8.0),
            Text('Spawn Chance: ${pokemon['spawn_chance']}'),
            const SizedBox(height: 8.0),
            Text('Average Spawns: ${pokemon['avg_spawns']}'),
            const SizedBox(height: 8.0),
            Text('Spawn Time: ${pokemon['spawn_time']}'),
            const SizedBox(height: 8.0),
            Text('Multipliers: ${pokemon['multipliers']}'),
            const SizedBox(height: 8.0),
            Text('Weaknesses: ${pokemon['weaknesses']}'),
            const SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }
}
