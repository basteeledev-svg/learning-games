import 'package:flutter/material.dart';

enum GradeLevel {
  preK('Pre-K', 3, 4),
  kindergarten('Kindergarten', 5, 5),
  grade1('1st Grade', 6, 6),
  grade2('2nd Grade', 7, 7),
  grade3('3rd Grade', 8, 8),
  grade4('4th Grade', 9, 9),
  grade5('5th Grade', 10, 10),
  grade6('6th Grade', 11, 11);

  final String label;
  final int minAge;
  final int maxAge;

  const GradeLevel(this.label, this.minAge, this.maxAge);
}

enum Subject {
  math('Math', Icons.calculate),
  reading('Reading', Icons.menu_book),
  science('Science', Icons.science),
  writing('Writing', Icons.edit),
  art('Art', Icons.palette),
  music('Music', Icons.music_note),
  geography('Geography', Icons.public),
  history('History', Icons.history_edu);

  final String label;
  final IconData icon;

  const Subject(this.label, this.icon);
}

class Game {
  final String id;
  final String name;
  final String description;
  final GradeLevel gradeLevel;
  final Subject subject;
  final IconData icon;
  final Color color;
  final String? route;

  const Game({
    required this.id,
    required this.name,
    required this.description,
    required this.gradeLevel,
    required this.subject,
    required this.icon,
    required this.color,
    this.route,
  });

  String get ageRange => '${gradeLevel.minAge}-${gradeLevel.maxAge} years';
}
