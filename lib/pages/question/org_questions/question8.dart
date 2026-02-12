import 'package:flutter/material.dart';
import 'package:firstproduction_pro/backend/backend.dart';
import './question_scaffold.dart';
import './question9.dart';

class Question8StressLocations extends StatefulWidget {
  const Question8StressLocations({super.key});

  @override
  State<Question8StressLocations> createState() => _Question8StressLocationsState();
}

class _Question8StressLocationsState extends State<Question8StressLocations> {
  final Set<String> selectedOptions = {};
  bool isLoading = false;

  final List<String> options = [
    "At my workstation / desk",
    "During meetings",
    "While multitasking",
    "While working from home",
    "In team or social interactions",
  ];

  final Map<String, int> answerMap = {
    "At my workstation / desk": 1,
    "During meetings": 2,
    "While multitasking": 3,
    "While working from home": 4,
    "In team or social interactions": 5,
  };

  Future<void> _handleContinue() async {
    if (selectedOptions.length != 3) return;
    
    setState(() => isLoading = true);

    final List<int> answerIds = selectedOptions
        .map((option) => answerMap[option]!)
        .toList();

    final success = await sendresponse(
      questionIds: [108],
      answers: [answerIds],
    );

    if (!mounted) return;

    if (success) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Question9AppChallenges()),
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
      questionNumber: 8,
      totalQuestions: 9,
      title: "Where do you most often feel stressed at work or wish to take a mindful pause?",
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
                      ? "✓ 3 locations selected. Tap Continue."
                      : "Select $remaining more ${remaining == 1 ? 'location' : 'locations'}.",
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