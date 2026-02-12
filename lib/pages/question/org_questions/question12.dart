import 'package:flutter/material.dart';
import 'package:firstproduction_pro/backend/backend.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './question_scaffold.dart';
import '../../new_pages/normal_user_dashboard_page.dart';
import '../../new_pages/organisation_user_dashboard_page.dart';

class Question12WorkLifeImpact extends StatefulWidget {
  const Question12WorkLifeImpact({super.key});

  @override
  State<Question12WorkLifeImpact> createState() => _Question12WorkLifeImpactState();
}

class _Question12WorkLifeImpactState extends State<Question12WorkLifeImpact> {
  final TextEditingController textController = TextEditingController();
  bool isLoading = false;

  Future<void> _handleContinue({bool skipped = false}) async {
    setState(() => isLoading = true);

    late bool success;
    
    if (skipped) {
      // User skipped - store empty string or null
      success = await sendresponse(
        questionIds: [112],
        answers: [[0]], // 0 indicates skipped
        freeTextAnswers: [""], // Empty text
      );
      print("📝 Question 112 - SKIPPED");
    } else {
      // User wrote something - store the text
      final text = textController.text.trim();
      success = await sendresponse(
        questionIds: [112],
        answers: [[1]], // 1 indicates answered
        freeTextAnswers: [text],
      );
      print("📝 Question 112 - ANSWERED: $text");
    }

    if (!mounted) return;

    if (success) {
      // Get user type from SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final userType = prefs.getString('userType') ?? 'normal';
      
      print("✅ Survey completed! User type: $userType");
      
      if (!mounted) return;

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            userType == 'organisation' 
              ? 'Thank you for completing the workplace assessment!' 
              : 'Thank you for completing the survey!'
          ),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
        ),
      );

      // Navigate to appropriate dashboard
      if (userType == 'organisation') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const OrganisationUserDashboardPage(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const NormalUserDashboardPage(),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to save response! Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
      setState(() => isLoading = false);
    }
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool hasText = textController.text.trim().isNotEmpty;
    
    return QuestionScaffold(
      questionNumber: 12,
      totalQuestions: 12,
      title: "Is there anything about your work life that you feel affects your mood or wellbeing?",
      child: Column(
        children: [
          const SizedBox(height: 24),
          
          // Large text input field
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: hasText ? Colors.black : Colors.grey[300]!,
                width: hasText ? 1.5 : 1,
              ),
            ),
            child: TextField(
              controller: textController,
              maxLines: null,
              expands: true,
              textAlignVertical: TextAlignVertical.top,
              decoration: InputDecoration(
                hintText: "Type here...",
                hintStyle: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 15,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(16),
              ),
              style: const TextStyle(
                fontSize: 15,
                height: 1.5,
              ),
              onChanged: (value) => setState(() {}),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Skip button and privacy note row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Privacy note with lock
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.lock_outline,
                      size: 16,
                      color: Colors.grey[500],
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "Your response is private and will not be shared.",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Skip button
              TextButton(
                onPressed: isLoading ? null : () => _handleContinue(skipped: true),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.grey[600],
                ),
                child: const Text(
                  'Skip',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      onContinue: hasText && !isLoading 
        ? () => _handleContinue(skipped: false)
        : null,
    );
  }
}