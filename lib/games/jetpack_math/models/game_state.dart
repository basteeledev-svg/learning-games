import 'dart:math';

enum DifficultyLevel {
  easy(2, 5, 3),      // 2-5 times tables, 3-4 platforms
  medium(3, 7, 4),    // 3-7 times tables, 4-5 platforms
  hard(5, 10, 5);     // 5-10 times tables, 5-6 platforms

  final int minMultiplier;
  final int maxMultiplier;
  final int basePlatforms;

  const DifficultyLevel(this.minMultiplier, this.maxMultiplier, this.basePlatforms);
}

enum BackgroundType {
  buildings,
  rocks,
  mountains,
  trees;

  static BackgroundType random() {
    return BackgroundType.values[Random().nextInt(BackgroundType.values.length)];
  }
}

class MultiplicationProblem {
  final int jumpSize;      // How many units per jump
  final int numJumps;       // How many jumps needed
  final int answer;         // jumpSize * numJumps
  final List<int> platforms; // The numbers on each platform

  MultiplicationProblem({
    required this.jumpSize,
    required this.numJumps,
    required this.answer,
    required this.platforms,
  });

  factory MultiplicationProblem.generate(DifficultyLevel difficulty) {
    final random = Random();
    final jumpSize = difficulty.minMultiplier + 
        random.nextInt(difficulty.maxMultiplier - difficulty.minMultiplier + 1);
    final numJumps = difficulty.basePlatforms + random.nextInt(2); // basePlatforms or +1
    
    final platforms = List.generate(
      numJumps,
      (index) => jumpSize * (index + 1),
    );

    return MultiplicationProblem(
      jumpSize: jumpSize,
      numJumps: numJumps,
      answer: jumpSize * numJumps,
      platforms: platforms,
    );
  }

  bool checkAnswer(int selectedJumps, int selectedSize) {
    return selectedJumps == numJumps && selectedSize == jumpSize;
  }
}

class JetpackGameState {
  DifficultyLevel difficulty;
  int currentLevel;
  int consecutiveFailures;
  int attemptsOnCurrentProblem;
  MultiplicationProblem? currentProblem;
  BackgroundType backgroundType;
  int? selectedNumJumps;
  int? selectedJumpSize;
  bool hasJumped;
  bool showingAnswer;

  JetpackGameState({
    this.difficulty = DifficultyLevel.easy,
    this.currentLevel = 1,
    this.consecutiveFailures = 0,
    this.attemptsOnCurrentProblem = 0,
    this.currentProblem,
    BackgroundType? backgroundType,
    this.selectedNumJumps,
    this.selectedJumpSize,
    this.hasJumped = false,
    this.showingAnswer = false,
  }) : backgroundType = backgroundType ?? BackgroundType.random();

  void generateNewProblem() {
    currentProblem = MultiplicationProblem.generate(difficulty);
    backgroundType = BackgroundType.random();
    selectedNumJumps = null;
    selectedJumpSize = null;
    hasJumped = false;
    showingAnswer = false;
  }

  void recordAttempt(bool correct) {
    attemptsOnCurrentProblem++;
    
    if (correct) {
      consecutiveFailures = 0;
      currentLevel++;
      
      // Progress to harder difficulty after 3 successful levels
      if (currentLevel % 3 == 0 && difficulty != DifficultyLevel.hard) {
        if (difficulty == DifficultyLevel.easy) {
          difficulty = DifficultyLevel.medium;
        } else if (difficulty == DifficultyLevel.medium) {
          difficulty = DifficultyLevel.hard;
        }
      }
    } else {
      if (attemptsOnCurrentProblem >= 3) {
        consecutiveFailures++;
        
        // Move to easier difficulty after 3 consecutive failures
        if (consecutiveFailures >= 3 && difficulty != DifficultyLevel.easy) {
          if (difficulty == DifficultyLevel.hard) {
            difficulty = DifficultyLevel.medium;
          } else if (difficulty == DifficultyLevel.medium) {
            difficulty = DifficultyLevel.easy;
          }
          consecutiveFailures = 0;
        }
      }
    }
  }

  void resetAttempts() {
    attemptsOnCurrentProblem = 0;
  }

  bool get canAttemptAgain => attemptsOnCurrentProblem < 3;
  
  bool get shouldShowAnswer => attemptsOnCurrentProblem >= 3;

  List<int> get availableNumbers {
    if (currentProblem == null) return [];
    
    // Provide numbers from 1 to the highest platform number
    final maxPlatform = currentProblem!.platforms.last;
    return List.generate(min(12, maxPlatform + 3), (index) => index + 1);
  }
}
