import 'package:flutter/material.dart';

class CanisterWidget extends StatelessWidget {
  final int number;
  final bool isSelected;

  const CanisterWidget({
    super.key,
    required this.number,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 70,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isSelected
              ? [Colors.amber.shade300, Colors.amber.shade600]
              : [Colors.blue.shade300, Colors.blue.shade600],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? Colors.amber.shade800 : Colors.blue.shade800,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Text(
          number.toString(),
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: [
              Shadow(
                color: Colors.black.withOpacity(0.5),
                offset: const Offset(1, 1),
                blurRadius: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DropSlot extends StatelessWidget {
  final String label;
  final int? value;
  final VoidCallback onClear;

  const DropSlot({
    super.key,
    required this.label,
    this.value,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: value != null ? onClear : null,
          child: Container(
            width: 60,
            height: 80,
            decoration: BoxDecoration(
              color: value != null
                  ? Colors.green.shade100
                  : Colors.white.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.white,
                width: 3,
                strokeAlign: BorderSide.strokeAlignOutside,
              ),
              boxShadow: value != null
                  ? [
                      BoxShadow(
                        color: Colors.green.withOpacity(0.5),
                        blurRadius: 8,
                        spreadRadius: 2,
                      ),
                    ]
                  : null,
            ),
            child: value != null
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          value.toString(),
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Icon(
                          Icons.close,
                          size: 16,
                          color: Colors.red,
                        ),
                      ],
                    ),
                  )
                : Center(
                    child: Icon(
                      Icons.add,
                      size: 32,
                      color: Colors.white.withOpacity(0.5),
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}

class JetpackControlPanel extends StatelessWidget {
  final List<int> availableNumbers;
  final int? selectedNumJumps;
  final int? selectedJumpSize;
  final Function(int) onNumberTap;
  final VoidCallback onClearJumps;
  final VoidCallback onClearSize;
  final VoidCallback onJumpPressed;
  final bool canJump;

  const JetpackControlPanel({
    super.key,
    required this.availableNumbers,
    required this.selectedNumJumps,
    required this.selectedJumpSize,
    required this.onNumberTap,
    required this.onClearJumps,
    required this.onClearSize,
    required this.onJumpPressed,
    required this.canJump,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.indigo.shade700,
            Colors.indigo.shade900,
          ],
        ),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Title
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.rocket_launch, color: Colors.white, size: 24),
              const SizedBox(width: 8),
              const Text(
                'Jetpack Controls',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Drop slots
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DropSlot(
                label: 'Number of\nJumps',
                value: selectedNumJumps,
                onClear: onClearJumps,
              ),
              const SizedBox(width: 16),
              const Text(
                '×',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 16),
              DropSlot(
                label: 'Size of\nJumps',
                value: selectedJumpSize,
                onClear: onClearSize,
              ),
            ],
          ),
          const SizedBox(height: 20),
          
          // Available canisters
          const Text(
            'Tap a canister to select:',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 90,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: availableNumbers.length,
              itemBuilder: (context, index) {
                final number = availableNumbers[index];
                final isSelected = number == selectedNumJumps || number == selectedJumpSize;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: GestureDetector(
                    onTap: () => onNumberTap(number),
                    child: CanisterWidget(
                      number: number,
                      isSelected: isSelected,
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          
          // Jump button
          ElevatedButton(
            onPressed: canJump ? onJumpPressed : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green.shade600,
              disabledBackgroundColor: Colors.grey.shade600,
              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 8,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.play_arrow,
                  size: 32,
                  color: canJump ? Colors.white : Colors.grey.shade400,
                ),
                const SizedBox(width: 8),
                Text(
                  'JUMP NOW!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: canJump ? Colors.white : Colors.grey.shade400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
