import 'package:flutter/material.dart';
import 'package:firstproduction_pro/backend/backend.dart';
import './question_scaffold.dart';
import './question12.dart';

class Question11WorkingHours extends StatefulWidget {
  const Question11WorkingHours({super.key});

  @override
  State<Question11WorkingHours> createState() => _Question11WorkingHoursState();
}

class _Question11WorkingHoursState extends State<Question11WorkingHours> {
  String? selectedOption;
  bool isLoading = false;

  final List<String> options = [
    "<6",
    "6-7",
    "8",
    "9-10",
    "10+",
  ];

  final Map<String, int> answerMap = {
    "<6": 1,
    "6-7": 2,
    "8": 3,
    "9-10": 4,
    "10+": 5,
  };

  Future<void> _handleContinue() async {
    if (selectedOption == null) return;
    
    setState(() => isLoading = true);

    final success = await sendresponse(
      questionIds: [111],
      answers: [[answerMap[selectedOption]!]],
    );

    if (!mounted) return;

    if (success) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Question12WorkLifeImpact()),
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
      questionNumber: 11,
      totalQuestions: 12,
      title: "How many hours do you work in a typical workday?",
      child: Column(
        children: [
          const SizedBox(height: 48),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: options.map((option) => _buildChip(option)).toList(),
          ),
        ],
      ),
      onContinue: selectedOption != null && !isLoading 
        ? _handleContinue 
        : null,
    );
  }

  Widget _buildChip(String text) {
    final isSelected = selectedOption == text;
    return GestureDetector(
      onTap: () => setState(() => selectedOption = text),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isSelected ? Colors.black : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            color: isSelected ? Colors.black : Colors.grey[700],
          ),
        ),
      ),
    );
  }
}