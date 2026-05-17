import 'package:flutter/material.dart';
import '../models/card_model.dart';

class MemoryGameScreen extends StatefulWidget {
  const MemoryGameScreen({Key? key}) : super(key: key);

  @override
  State<MemoryGameScreen> createState() => _MemoryGameScreenState();
}

class _MemoryGameScreenState extends State<MemoryGameScreen> {
  late List<CardModel> cards;

  List<int> selectedIndices = [];
  List<int> matchedIndices = [];

  int errorCount = 0;
  final int maxErrors = 2; 
  String statusMessage = "";
  bool isProcessing = false; 

  @override
  void initState() {
    super.initState();
    _initGame();
  }

  void _initGame() {
    cards = [
      CardModel(color: "blue"),
      CardModel(color: "red"),
      CardModel(color: "blue"),
      CardModel(color: "red"),
    ];
    
    cards.shuffle(); 
    
    selectedIndices = [];
    matchedIndices = [];
    errorCount = 0;
    statusMessage = "";
    isProcessing = false;
  }

  void _onCardTap(int index) {
    if (isProcessing || errorCount >= maxErrors) return;
    if (selectedIndices.contains(index) || matchedIndices.contains(index)) return;

    setState(() {
      selectedIndices.add(index);
      statusMessage = ""; 
    });

    if (selectedIndices.length == 2) {
      _checkMatch();
    }
  }

  void _checkMatch() async {
    setState(() {
      isProcessing = true; 
    });

    int firstIndex = selectedIndices[0];
    int secondIndex = selectedIndices[1];

    if (cards[firstIndex].color == cards[secondIndex].color) {
      setState(() {
        matchedIndices.addAll([firstIndex, secondIndex]);
        statusMessage = "Успешно";
        selectedIndices.clear();
        isProcessing = false;
      });
    } else {
      setState(() {
        errorCount++;
        if (errorCount >= maxErrors) {
          statusMessage = "❌ У вас не осталось попыток";
        } else {
          statusMessage = "❌ Не совпадает! Осталась 1 попытка.";
        }
      });

      await Future.delayed(const Duration(seconds: 1));

      if (mounted) {
        setState(() {
          selectedIndices.clear();
          isProcessing = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isSuccess = statusMessage == "Успешно";
    bool isGameOver = errorCount >= maxErrors;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F7F4),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.grey.shade300, width: 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Найти пару 🎯",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Нажми на два прямоугольника одного цвета",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),

                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Text(
                    "Ошибок: $errorCount / $maxErrors",
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
                const SizedBox(height: 24),

                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.3, 
                  ),
                  itemCount: cards.length,
                  itemBuilder: (context, index) {
                    bool isRevealed = selectedIndices.contains(index) || 
                                      matchedIndices.contains(index);
                    CardModel card = cards[index];

                    return GestureDetector(
                      onTap: () => _onCardTap(index),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          color: isRevealed ? card.flutterColor : Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isRevealed ? Colors.transparent : Colors.grey.shade300,
                            width: 2,
                          ),
                          boxShadow: isRevealed
                              ? [
                                  BoxShadow(
                                    color: card.flutterColor.withOpacity(0.4),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  )
                                ]
                              : [],
                        ),
                        child: isRevealed
                            ? Center(
                                child: Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: RadialGradient(
                                      colors: [
                                        Colors.white.withOpacity(0.6),
                                        Colors.transparent,
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : null,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 24),

                if (statusMessage.isNotEmpty)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: isSuccess ? const Color(0xFFE8F5E9) : const Color(0xFFFFEBEB),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSuccess ? Colors.green.shade300 : Colors.red.shade200,
                      ),
                    ),
                    child: Text(
                      statusMessage,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isSuccess ? Colors.green.shade800 : const Color(0xFFC82C31),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),

                if (isGameOver || matchedIndices.length == cards.length) ...[
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () => setState(() => _initGame()),
                    child: const Text("Начать заново", style: TextStyle(fontSize: 16)),
                  )
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}