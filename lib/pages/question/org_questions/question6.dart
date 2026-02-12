import 'package:flutter/material.dart';
import 'package:firstproduction_pro/backend/backend.dart';
import './question_scaffold.dart';
import './question7.dart';

class Question6Support extends StatefulWidget {
  const Question6Support({super.key});

  @override
  State<Question6Support> createState() => _Question6SupportState();
}

class _Question6SupportState extends State<Question6Support> {
  final Set<String> selectedOptions = {}; // Store which options are selected
  bool isLoading = false;

  final Map<String, int> answerMap = {
    "By my team": 1,
    "By my manager": 2,
  };

  final List<Map<String, String>> options = [
    {"icon": "👤", "text": "By my team"},
    {"icon": "👔", "text": "By my manager"},
  ];

  Future<void> _handleContinue() async {
    if (selectedOptions.isEmpty) {
      // Don't proceed if nothing selected
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select at least one option'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }
    
    setState(() => isLoading = true);

    // Convert selected options to answer IDs
    final List<int> answerIds = selectedOptions
        .map((option) => answerMap[option]!)
        .toList();

    print("📝 Saving Question 106 - Selected: $selectedOptions → IDs: $answerIds");

    final success = await sendresponse(
      questionIds: [106],
      answers: [answerIds], // This sends as array like [1] or [2] or [1,2]
    );

    if (!mounted) return;

    if (success) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Question7StressSources()),
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
      questionNumber: 6,
      totalQuestions: 9,
      title: "How supported do you feel at work when you're having a difficult day?",
      subtitle: "Select all that apply.",
      child: Column(
        children: [
          const SizedBox(height: 32),
          
          // Selection indicator
          if (selectedOptions.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.check_circle, color: Colors.green[700], size: 16),
                  const SizedBox(width: 8),
                  Text(
                    "Selected: ${selectedOptions.join(' + ')}",
                    style: TextStyle(
                      color: Colors.green[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          
          const SizedBox(height: 24),
          
          // Two options side by side
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: options.map((option) => _buildIconOption(option)).toList(),
          ),
        ],
      ),
      onContinue: selectedOptions.isNotEmpty && !isLoading 
        ? _handleContinue 
        : null,
    );
  }

  Widget _buildIconOption(Map<String, String> option) {
    final String text = option["text"]!;
    final bool isSelected = selectedOptions.contains(text);
    
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            selectedOptions.remove(text);
          } else {
            selectedOptions.add(text);
          }
        });
      },
      child: Container(
        width: 150,
        padding: const EdgeInsets.symmetric(vertical: 24),
        decoration: BoxDecoration(
          color: isSelected ? Colors.grey[300] : Colors.grey[100],
          borderRadius: BorderRadius.circular(16),
          border: isSelected 
            ? Border.all(color: Colors.black, width: 2)
            : Border.all(color: Colors.transparent),
        ),
        child: Column(
          children: [
            Text(
              option["icon"]!,
              style: const TextStyle(fontSize: 48),
            ),
            const SizedBox(height: 12),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected ? Colors.black : Colors.grey[800],
              ),
            ),
            const SizedBox(height: 8),
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
                  size: 16,
                ),
              ),
          ],
        ),
      ),
    );
  }
}