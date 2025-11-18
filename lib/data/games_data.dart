import 'package:flutter/material.dart';
import '../models/game.dart';

class GamesData {
  static final List<Game> allGames = [
    // Math Games
    Game(
      id: 'jetpack_math',
      name: 'Jetpack Math',
      description: 'Help animals jump across platforms by solving multiplication problems!',
      gradeLevel: GradeLevel.grade2,
      subject: Subject.math,
      icon: Icons.rocket,
      color: Colors.indigo,
      route: '/jetpack_math',
    ),
    Game(
      id: 'number_match',
      name: 'Number Match',
      description: 'Match numbers with their quantities in this fun counting game',
      gradeLevel: GradeLevel.preK,
      subject: Subject.math,
      icon: Icons.looks_one,
      color: Colors.blue,
    ),
    Game(
      id: 'addition_adventure',
      name: 'Addition Adventure',
      description: 'Solve addition problems and collect stars',
      gradeLevel: GradeLevel.grade1,
      subject: Subject.math,
      icon: Icons.add_circle,
      color: Colors.lightBlue,
    ),
    Game(
      id: 'multiplication_maze',
      name: 'Multiplication Maze',
      description: 'Navigate through the maze by solving multiplication problems',
      gradeLevel: GradeLevel.grade3,
      subject: Subject.math,
      icon: Icons.clear,
      color: Colors.purple,
    ),
    
    // Reading Games
    Game(
      id: 'alphabet_explorer',
      name: 'Alphabet Explorer',
      description: 'Learn letters and their sounds through interactive activities',
      gradeLevel: GradeLevel.kindergarten,
      subject: Subject.reading,
      icon: Icons.abc,
      color: Colors.green,
    ),
    Game(
      id: 'word_builder',
      name: 'Word Builder',
      description: 'Build words from letter tiles and expand your vocabulary',
      gradeLevel: GradeLevel.grade2,
      subject: Subject.reading,
      icon: Icons.text_fields,
      color: Colors.teal,
    ),
    Game(
      id: 'story_sequencer',
      name: 'Story Sequencer',
      description: 'Put story events in the correct order to improve comprehension',
      gradeLevel: GradeLevel.grade4,
      subject: Subject.reading,
      icon: Icons.auto_stories,
      color: Colors.cyan,
    ),
    
    // Science Games
    Game(
      id: 'animal_explorer',
      name: 'Animal Explorer',
      description: 'Learn about different animals and their habitats',
      gradeLevel: GradeLevel.grade1,
      subject: Subject.science,
      icon: Icons.pets,
      color: Colors.orange,
    ),
    Game(
      id: 'solar_system',
      name: 'Solar System Explorer',
      description: 'Discover planets and learn about our solar system',
      gradeLevel: GradeLevel.grade5,
      subject: Subject.science,
      icon: Icons.rocket_launch,
      color: Colors.deepPurple,
    ),
    
    // Writing Games
    Game(
      id: 'letter_trace',
      name: 'Letter Tracing',
      description: 'Practice writing letters with guided tracing',
      gradeLevel: GradeLevel.preK,
      subject: Subject.writing,
      icon: Icons.draw,
      color: Colors.pink,
    ),
    Game(
      id: 'sentence_builder',
      name: 'Sentence Builder',
      description: 'Create proper sentences by arranging words correctly',
      gradeLevel: GradeLevel.grade2,
      subject: Subject.writing,
      icon: Icons.create,
      color: Colors.red,
    ),
    
    // Geography Games
    Game(
      id: 'world_explorer',
      name: 'World Explorer',
      description: 'Learn about countries, capitals, and landmarks',
      gradeLevel: GradeLevel.grade4,
      subject: Subject.geography,
      icon: Icons.map,
      color: Colors.brown,
    ),
    
    // Art Games
    Game(
      id: 'color_mixer',
      name: 'Color Mixer',
      description: 'Learn about primary and secondary colors through mixing',
      gradeLevel: GradeLevel.kindergarten,
      subject: Subject.art,
      icon: Icons.color_lens,
      color: Colors.amber,
    ),
  ];
}
