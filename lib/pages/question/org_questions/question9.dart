import 'package:flutter/material.dart';
import 'package:firstproduction_pro/backend/backend.dart';
import './question_scaffold.dart';
import './question10.dart';

class Question9AppChallenges extends StatefulWidget {
  const Question9AppChallenges({super.key});

  @override
  State<Question9AppChallenges> createState() => _Question9AppChallengesState();
}

class _Question9AppChallengesState extends State<Question9AppChallenges> {
  final Set<String> selectedOptions = {};
  bool isLoading = false;

  final List<String> options = [
    "Nothing, I'm ready",
    "Not sure how it helps my work",
    "Concern about privacy",
    "Lack of time",
  ];

  final Map<String, int> answerMap = {
    "Nothing, I'm ready": 1,
    "Not sure how it helps my work": 2,
    "Concern about privacy": 3,
    "Lack of time": 4,
  };

  Future<void> _handleContinue() async {
    if (selectedOptions.isEmpty) return;
    
    setState(() => isLoading = true);

    final List<int> answerIds = selectedOptions
        .map((option) => answerMap[option]!)
        .toList();

    final success = await sendresponse(
      questionIds: [109],
      answers: [answerIds],
    );

    if (!mounted) return;

    if (success) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Question10DailyFeelings()),
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
      questionNumber: 9,
      totalQuestions: 9,
      title: "What might make it challenging to use a workplace wellbeing app regularly?",
      subtitle: "Select 3 options that apply to your day.",
      child: Column(
        children: [
          const SizedBox(height: 24),
          
          // Options
          ...options.map((option) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _buildOption(option),
          )).toList(),
        ],
      ),
      onContinue: selectedOptions.isNotEmpty && !isLoading 
        ? _handleContinue 
        : null,
    );
  }

  Widget _buildOption(String text) {
    final isSelected = selectedOptions.contains(text);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            selectedOptions.remove(text);
          } else if (selectedOptions.length < 3) {
            selectedOptions.add(text);
          }
        });
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? Colors.black : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected ? Colors.black : Colors.grey[800],
                ),
              ),
            ),
            if (isSelected)
              Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 14,
                ),
              ),
          ],
        ),
      ),
    );
  }
}