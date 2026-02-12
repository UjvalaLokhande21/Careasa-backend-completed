import 'package:flutter/material.dart';
import 'package:firstproduction_pro/backend/backend.dart';
import './question_scaffold.dart';
import 'question5.dart';

class Question4FocusFrequency extends StatefulWidget {
  const Question4FocusFrequency({super.key});

  @override
  State<Question4FocusFrequency> createState() => _Question4FocusFrequencyState();
}

class _Question4FocusFrequencyState extends State<Question4FocusFrequency> {
  String? selectedOption;
  bool isLoading = false;

  final Map<String, int> answerMap = {
    "Rarely": 1,
    "Sometimes": 2,
    "Often": 3,
    "Almost always": 4,
  };

  Future<void> _handleContinue() async {
    if (selectedOption == null) return;
    
    setState(() => isLoading = true);

    final success = await sendresponse(
      questionIds: [104], // Question ID
      answers: [[answerMap[selectedOption]!]],
    );

    if (!mounted) return;

    if (success) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Question5WorkDrains(),
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
      questionNumber: 4, // ✅ FIXED: 4 of 12
      totalQuestions: 12,
      title: "How often do you feel focused and mentally present during work hours?",
      child: Column(
        children: [
          const SizedBox(height: 32),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: answerMap.keys.map((option) => _buildChip(option)).toList(),
          ),
        ],
      ),
      onContinue: selectedOption != null && !isLoading ? _handleContinue : null,
    );
  }

  Widget _buildChip(String text) {
    final isSelected = selectedOption == text;
    return GestureDetector(
      onTap: () => setState(() => selectedOption = text),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.grey[300] : Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 15,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}