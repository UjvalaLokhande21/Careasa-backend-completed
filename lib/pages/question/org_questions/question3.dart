import 'package:flutter/material.dart';
import 'package:firstproduction_pro/backend/backend.dart';
import './question_scaffold.dart';
import './question4.dart';

class Question3WorkImpact extends StatefulWidget {
  const Question3WorkImpact({super.key});

  @override
  State<Question3WorkImpact> createState() => _Question3WorkImpactState();
}

class _Question3WorkImpactState extends State<Question3WorkImpact> {
  String? selectedOption;
  bool isLoading = false;

  final Map<String, int> answerMap = {
    "It significantly lowers my mood": 1,
    "It sometimes affects my mood": 2,
    "It has little impact": 3,
    "It improves my mood": 4,
  };

  Future<void> _handleContinue() async {
    if (selectedOption == null) return;
    
    setState(() => isLoading = true);

    final success = await sendresponse(
      questionIds: [103], // Question ID
      answers: [[answerMap[selectedOption]!]],
    );

    if (!mounted) return;

    if (success) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Question4FocusFrequency(),
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
      questionNumber: 3, // ✅ FIXED: 3 of 12
      totalQuestions: 12,
      title: "When you think about your workday, how does it impact your mood?",
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
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          decoration: BoxDecoration(
            color: isSelected ? Colors.grey[300] : Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}