import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:wikicinema/domain/entities/actor.dart';

class ActorsListview extends StatelessWidget {
  final List<Actor> actors;

  const ActorsListview({
    super.key,
    required this.actors,
  });

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;

    return SizedBox(
      height: 300,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: actors.length,
        itemBuilder: (context, index) {
          final actor = actors[index];
          return Container(
            padding: const EdgeInsets.all(10),
            width: 135,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //* Image
                FadeInRight(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      actor.profilePath,
                      height: 180,
                      width: 135,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                const SizedBox(height: 5),

                //* Actor Name
                Text(
                  actor.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                //* Character
                Text(
                  actor.character ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: textStyles.bodySmall,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
