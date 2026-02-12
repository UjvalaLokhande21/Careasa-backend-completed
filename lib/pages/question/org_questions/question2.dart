import 'package:flutter/material.dart';
import 'package:firstproduction_pro/backend/backend.dart';
import './question_scaffold.dart';
import './question3.dart';

class Question2EmojiRating extends StatefulWidget {
  const Question2EmojiRating({super.key});

  @override
  State<Question2EmojiRating> createState() => _Question2EmojiRatingState();
}

class _Question2EmojiRatingState extends State<Question2EmojiRating> {
  double sliderValue = 3; // Start at middle (3)
  bool isLoading = false;

  final List<Map<String, dynamic>> emojis = [
    {"emoji": "😢", "value": 1, "label": "Very\nlow"},
    {"emoji": "😕", "value": 2, "label": "2"},
    {"emoji": "😐", "value": 3, "label": "3"},
    {"emoji": "🙂", "value": 4, "label": "4"},
    {"emoji": "🤩", "value": 5, "label": "Very\nhappy"},
  ];

  int get selectedRating => sliderValue.round();

  Future<void> _handleContinue() async {
    setState(() => isLoading = true);

    final success = await sendresponse(
      questionIds: [102],
      answers: [[selectedRating]],
    );

    if (!mounted) return;

    if (success) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Question3WorkImpact()),
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
      questionNumber: 2,
      totalQuestions: 9,
      title: "How do you usually feel during a typical workday?",
      child: Column(
        children: [
          const SizedBox(height: 32),
          
          // Emoji Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: emojis.map((emoji) {
              final isSelected = emoji["value"] == selectedRating;
              return Column(
                children: [
                  Text(
                    emoji["emoji"],
                    style: TextStyle(
                      fontSize: isSelected ? 48 : 40,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    emoji["label"],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      height: 1.2,
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
          
          const SizedBox(height: 32),
          
          // SLIDER - This is what was missing!
          SliderTheme(
            data: SliderThemeData(
              activeTrackColor: Colors.grey[400],
              inactiveTrackColor: Colors.grey[200],
              thumbColor: Colors.black,
              overlayColor: Colors.black.withOpacity(0.1),
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
              trackHeight: 4,
            ),
            child: Slider(
              value: sliderValue,
              min: 1,
              max: 5,
              divisions: 4,
              onChanged: (value) {
                setState(() {
                  sliderValue = value;
                });
              },
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Labels below slider
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Very low",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  "Very happy",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      onContinue: !isLoading ? _handleContinue : null,
    );
  }
}