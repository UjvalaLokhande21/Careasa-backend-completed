import 'package:flutter/material.dart';
import 'package:firstproduction_pro/backend/backend.dart';
import './question_scaffold.dart';
import './question11.dart';

class Question10DailyFeelings extends StatefulWidget {
  const Question10DailyFeelings({super.key});

  @override
  State<Question10DailyFeelings> createState() => _Question10DailyFeelingsState();
}

class _Question10DailyFeelingsState extends State<Question10DailyFeelings> {
  final Set<String> selectedOptions = {};
  bool isLoading = false;

  final List<String> options = [
    "Mentally tired",
    "Stressed",
    "Calm",
    "Motivated",
    "Overwhelmed",
    "Focused",
  ];

  final Map<String, int> answerMap = {
    "Mentally tired": 1,
    "Stressed": 2,
    "Calm": 3,
    "Motivated": 4,
    "Overwhelmed": 5,
    "Focused": 6,
  };

  Future<void> _handleContinue() async {
    if (selectedOptions.length != 3) return;
    
    setState(() => isLoading = true);

    final List<int> answerIds = selectedOptions
        .map((option) => answerMap[option]!)
        .toList();

    final success = await sendresponse(
      questionIds: [110],
      answers: [answerIds],
    );

    if (!mounted) return;

    if (success) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Question11WorkingHours()),
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
    final int remaining = 3 - selectedOptions.length;
    
    return QuestionScaffold(
      questionNumber: 10,
      totalQuestions: 12,
      title: "During your workday, how often do you feel the following?",
      subtitle: "Select 3 options that apply to your day.",
      child: Column(
        children: [
          const SizedBox(height: 16),
          
          // Selection counter
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: selectedOptions.length == 3 
                ? Colors.green[50] 
                : Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(
                  selectedOptions.length == 3 
                    ? Icons.check_circle 
                    : Icons.info_outline,
                  size: 18,
                  color: selectedOptions.length == 3 
                    ? Colors.green[700] 
                    : Colors.grey[600],
                ),
                const SizedBox(width: 8),
                Text(
                  selectedOptions.length == 3
                      ? "✓ 3 feelings selected. Tap Continue."
                      : "Select $remaining more ${remaining == 1 ? 'feeling' : 'feelings'}.",
                  style: TextStyle(
                    color: selectedOptions.length == 3 
                      ? Colors.green[700] 
                      : Colors.grey[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Options
          ...options.map((option) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _buildOption(option),
          )).toList(),
        ],
      ),
      onContinue: selectedOptions.length == 3 && !isLoading 
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
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.grey[400] : Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            color: isSelected ? Colors.white : Colors.black87,
          ),
        ),
      ),
    );
  }
}