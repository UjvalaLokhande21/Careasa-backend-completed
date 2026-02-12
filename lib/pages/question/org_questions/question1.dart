import 'package:flutter/material.dart';
import 'package:firstproduction_pro/backend/backend.dart';
import './question_scaffold.dart';
import './question2.dart';

class Question1WorkExperience extends StatefulWidget {
  const Question1WorkExperience({super.key});

  @override
  State<Question1WorkExperience> createState() => _Question1WorkExperienceState();
}

class _Question1WorkExperienceState extends State<Question1WorkExperience> {
  String? selectedOption;
  bool isLoading = false;

  final Map<String, int> answerMap = {
    'Drained': 1,
    'Low': 2,
    'Neutral': 3,
    'Good': 4,
    'Energizing': 5,
  };

  Future<void> _handleContinue() async {
    if (selectedOption == null) return;
    
    setState(() => isLoading = true);

    final success = await sendresponse(
      questionIds: [101], // Question ID
      answers: [[answerMap[selectedOption]!]],
    );

    if (!mounted) return;

    if (success) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Question2EmojiRating(),
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
      questionNumber: 1, // ✅ FIXED: 1 of 12
      totalQuestions: 12,
      title: "Over the past week, how would you describe your overall work experience?",
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