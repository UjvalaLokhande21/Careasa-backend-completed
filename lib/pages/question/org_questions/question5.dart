import 'package:flutter/material.dart';
import 'package:firstproduction_pro/backend/backend.dart';
import './question_scaffold.dart';
import './question6.dart';

class Question5WorkDrains extends StatefulWidget {
  const Question5WorkDrains({super.key});

  @override
  State<Question5WorkDrains> createState() => _Question5WorkDrainsState();
}

class _Question5WorkDrainsState extends State<Question5WorkDrains> {
  String? selectedOption;
  bool isLoading = false;

  final Map<String, int> answerMap = {
    "Meetings": 1,
    "Deadlines": 2,
    "Communication": 3,
    "Lack of clarity": 4,
    "Long hours": 5,
    "Context switching": 6,
  };

  Future<void> _handleContinue() async {
    if (selectedOption == null) return;
    
    setState(() => isLoading = true);

    final success = await sendresponse(
      questionIds: [105], // Question ID
      answers: [[answerMap[selectedOption]!]],
    );

    if (!mounted) return;

    if (success) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Question6Support(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to save response!')),
      );
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return QuestionScaffold(
      questionNumber: 5, // ✅ FIXED: 5 of 12
      totalQuestions: 12,
      title: "Which part of your work drains you the most lately?",
      child: Column(
        children: [
          const SizedBox(height: 32),
          ...answerMap.keys.map((option) => _buildOption(option)).toList(),
        ],
      ),
      onContinue: selectedOption != null && !isLoading ? _handleContinue : null,
    );
  }

  Widget _buildOption(String text) {
    final isSelected = selectedOption == text;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: () => setState(() => selectedOption = text),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: isSelected ? Colors.grey[300] : Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}