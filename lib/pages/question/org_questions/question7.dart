import 'package:flutter/material.dart';
import 'package:firstproduction_pro/backend/backend.dart';
import './question_scaffold.dart';
import './question8.dart';

class Question7StressSources extends StatefulWidget {
  const Question7StressSources({super.key});

  @override
  State<Question7StressSources> createState() => _Question7StressSourcesState();
}

class _Question7StressSourcesState extends State<Question7StressSources> {
  final Set<String> selectedOptions = {};
  bool isLoading = false;

  final List<String> options = [
    "Workload & deadlines",
    "Long working hours",
    "Role clarity / expectations",
    "Team or workplace conflicts",
    "Management / leadership pressure",
    "Job security & career growth",
  ];

  final Map<String, int> answerMap = {
    "Workload & deadlines": 1,
    "Long working hours": 2,
    "Role clarity / expectations": 3,
    "Team or workplace conflicts": 4,
    "Management / leadership pressure": 5,
    "Job security & career growth": 6,
  };

  Future<void> _handleContinue() async {
    if (selectedOptions.length != 3) return;
    
    setState(() => isLoading = true);

    final List<int> answerIds = selectedOptions
        .map((option) => answerMap[option]!)
        .toList();

    final success = await sendresponse(
      questionIds: [107],
      answers: [answerIds],
    );

    if (!mounted) return;

    if (success) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Question8StressLocations()),
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
      questionNumber: 7,
      totalQuestions: 9,
      title: "What are your biggest sources of work-related stress right now?",
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
                      ? "✓ 3 options selected. Tap Continue."
                      : "Select $remaining more ${remaining == 1 ? 'option' : 'options'}.",
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