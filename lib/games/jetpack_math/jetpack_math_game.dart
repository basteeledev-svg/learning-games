import 'package:flutter/material.dart';
import 'dart:async';
import 'models/game_state.dart';
import 'widgets/character_widgets.dart';
import 'widgets/background_widgets.dart';
import 'widgets/canister_widgets.dart';

class JetpackMathGame extends StatefulWidget {
  const JetpackMathGame({super.key});

  @override
  State<JetpackMathGame> createState() => _JetpackMathGameState();
}

class _JetpackMathGameState extends State<JetpackMathGame>
    with SingleTickerProviderStateMixin {
  late JetpackGameState gameState;
  late AnimalType characterType;
  late AnimationController _animationController;
  late Animation<double> _jumpAnimation;
  
  int currentJumpIndex = 0;
  bool isAnimating = false;
  JumpResult? jumpResult;

  @override
  void initState() {
    super.initState();
    gameState = JetpackGameState();
    characterType = AnimalType.random();
    gameState.generateNewProblem();
    
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _jumpAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOutQuad,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onNumberTap(int number) {
    if (isAnimating || gameState.hasJumped) return;
    
    setState(() {
      if (gameState.selectedNumJumps == null) {
        gameState.selectedNumJumps = number;
      } else if (gameState.selectedJumpSize == null) {
        gameState.selectedJumpSize = number;
      }
    });
  }

  void _clearJumps() {
    if (isAnimating || gameState.hasJumped) return;
    setState(() {
      gameState.selectedNumJumps = null;
    });
  }

  void _clearSize() {
    if (isAnimating || gameState.hasJumped) return;
    setState(() {
      gameState.selectedJumpSize = null;
    });
  }

  Future<void> _performJump() async {
    if (gameState.selectedNumJumps == null || gameState.selectedJumpSize == null) return;
    
    setState(() {
      isAnimating = true;
      gameState.hasJumped = true;
      currentJumpIndex = 0;
    });

    final numJumps = gameState.selectedNumJumps!;
    final jumpSize = gameState.selectedJumpSize!;
    final correctJumps = gameState.currentProblem!.numJumps;
    final correctSize = gameState.currentProblem!.jumpSize;

    // Perform each jump
    for (int i = 0; i < numJumps; i++) {
      currentJumpIndex = i;
      await _animationController.forward(from: 0);
      await Future.delayed(const Duration(milliseconds: 200));
    }

    // Determine result
    setState(() {
      isAnimating = false;
      
      if (numJumps == correctJumps && jumpSize == correctSize) {
        jumpResult = JumpResult.perfect;
        gameState.recordAttempt(true);
        gameState.resetAttempts();
      } else if (numJumps != correctJumps && jumpSize != correctSize) {
        jumpResult = JumpResult.bothWrong;
        gameState.recordAttempt(false);
      } else if (numJumps != correctJumps) {
        jumpResult = JumpResult.wrongJumps;
        gameState.recordAttempt(false);
      } else {
        jumpResult = JumpResult.wrongSize;
        gameState.recordAttempt(false);
      }
    });

    // Show result dialog after animation
    await Future.delayed(const Duration(milliseconds: 500));
    if (mounted) {
      _showResultDialog();
    }
  }

  void _showResultDialog() {
    final isCorrect = jumpResult == JumpResult.perfect;
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(
              isCorrect ? Icons.celebration : Icons.error_outline,
              color: isCorrect ? Colors.green : Colors.orange,
              size: 32,
            ),
            const SizedBox(width: 12),
            Text(
              isCorrect ? 'Perfect!' : 'Not Quite!',
              style: TextStyle(
                color: isCorrect ? Colors.green : Colors.orange.shade800,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isCorrect) ...[
              const Text(
                '🎉 Great job! You solved it correctly!',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 12),
              Text(
                '${gameState.selectedNumJumps} × ${gameState.selectedJumpSize} = ${gameState.currentProblem!.answer}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ] else ...[
              Text(
                _getErrorMessage(),
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 12),
              if (gameState.shouldShowAnswer) ...[
                const Text(
                  'The correct answer is:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  '${gameState.currentProblem!.numJumps} × ${gameState.currentProblem!.jumpSize} = ${gameState.currentProblem!.answer}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Attempts: ${gameState.attemptsOnCurrentProblem}/3',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
              ] else ...[
                Text(
                  'You have ${3 - gameState.attemptsOnCurrentProblem} attempts left!',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange.shade700,
                  ),
                ),
              ],
            ],
          ],
        ),
        actions: [
          if (!isCorrect && gameState.canAttemptAgain)
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _resetCurrentProblem();
              },
              child: const Text('Try Again'),
            ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _nextProblem();
            },
            child: Text(isCorrect ? 'Next Level' : 'Continue'),
          ),
        ],
      ),
    );
  }

  String _getErrorMessage() {
    switch (jumpResult) {
      case JumpResult.wrongJumps:
        if (gameState.selectedNumJumps! < gameState.currentProblem!.numJumps) {
          return "You didn't jump enough times! The character fell short.";
        } else {
          return "You jumped too many times! The character overshot the target.";
        }
      case JumpResult.wrongSize:
        if (gameState.selectedJumpSize! < gameState.currentProblem!.jumpSize) {
          return "Your jumps were too small! The character landed between platforms.";
        } else {
          return "Your jumps were too big! The character overshot the platforms.";
        }
      case JumpResult.bothWrong:
        return "Both the number and size of jumps were incorrect. Look at the platform numbers carefully!";
      default:
        return "Try again!";
    }
  }

  void _resetCurrentProblem() {
    setState(() {
      gameState.selectedNumJumps = null;
      gameState.selectedJumpSize = null;
      gameState.hasJumped = false;
      jumpResult = null;
      currentJumpIndex = 0;
    });
  }

  void _nextProblem() {
    setState(() {
      characterType = AnimalType.random();
      gameState.generateNewProblem();
      gameState.selectedNumJumps = null;
      gameState.selectedJumpSize = null;
      gameState.hasJumped = false;
      jumpResult = null;
      currentJumpIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final problem = gameState.currentProblem;
    if (problem == null) return const Scaffold();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Jetpack Math'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Level ${gameState.currentLevel} • ${gameState.difficulty.name.toUpperCase()}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Game board
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.lightBlue.shade200,
                    Colors.lightBlue.shade50,
                  ],
                ),
              ),
              child: Stack(
                children: [
                  // Background
                  CustomPaint(
                    size: Size.infinite,
                    painter: GameBoardPainter(
                      backgroundType: gameState.backgroundType,
                      platforms: problem.platforms,
                    ),
                  ),
                  
                  // Platforms
                  _buildPlatforms(problem.platforms),
                  
                  // Character
                  _buildCharacter(problem.platforms),
                ],
              ),
            ),
          ),
          
          // Control panel
          JetpackControlPanel(
            availableNumbers: gameState.availableNumbers,
            selectedNumJumps: gameState.selectedNumJumps,
            selectedJumpSize: gameState.selectedJumpSize,
            onNumberTap: _onNumberTap,
            onClearJumps: _clearJumps,
            onClearSize: _clearSize,
            onJumpPressed: _performJump,
            canJump: gameState.selectedNumJumps != null &&
                gameState.selectedJumpSize != null &&
                !isAnimating &&
                !gameState.hasJumped,
          ),
        ],
      ),
    );
  }

  Widget _buildPlatforms(List<int> platforms) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final platformWidth = 80.0;
        final spacing = (constraints.maxWidth - platformWidth) / (platforms.length + 1);
        
        return Stack(
          children: List.generate(platforms.length, (index) {
            final xPos = spacing * (index + 1);
            final yPos = constraints.maxHeight - 100.0 - (index * 15);
            
            final shouldHighlight = gameState.hasJumped &&
                gameState.selectedJumpSize != null &&
                currentJumpIndex >= index &&
                (index + 1) * gameState.selectedJumpSize! == platforms[index];
            
            return Positioned(
              left: xPos - platformWidth / 2,
              top: yPos,
              child: PlatformWidget(
                number: platforms[index],
                isHighlighted: shouldHighlight,
              ),
            );
          }),
        );
      },
    );
  }

  Widget _buildCharacter(List<int> platforms) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final platformWidth = 80.0;
        final spacing = (constraints.maxWidth - platformWidth) / (platforms.length + 1);
        
        double xPos;
        double yPos;
        
        if (!gameState.hasJumped) {
          // Starting position
          xPos = 40;
          yPos = constraints.maxHeight - 200;
        } else {
          // Calculate position based on current jump
          final targetIndex = currentJumpIndex;
          final baseX = spacing * (targetIndex + 1);
          final baseY = constraints.maxHeight - 160.0 - (targetIndex * 15);
          
          // Animate the jump
          final jumpProgress = _jumpAnimation.value;
          final jumpHeight = 60.0;
          
          xPos = baseX;
          yPos = baseY - (jumpHeight * (1 - (jumpProgress - 0.5).abs() * 2));
        }
        
        return Positioned(
          left: xPos - 30,
          top: yPos,
          child: Column(
            children: [
              AnimalCharacter(
                type: characterType,
                size: 60,
              ),
              const SizedBox(height: 4),
              const JetpackWidget(size: 40),
            ],
          ),
        );
      },
    );
  }
}

enum JumpResult {
  perfect,
  wrongJumps,
  wrongSize,
  bothWrong,
}
