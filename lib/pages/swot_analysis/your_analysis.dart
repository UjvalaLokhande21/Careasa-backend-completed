// screens/your_analysis.dart
import 'package:flutter/material.dart';
import 'todays_tasks.dart';

class YourAnalysisScreen extends StatefulWidget {
  const YourAnalysisScreen({Key? key}) : super(key: key);

  @override
  State<YourAnalysisScreen> createState() => _YourAnalysisScreenState();
}

class _YourAnalysisScreenState extends State<YourAnalysisScreen> {
  int _currentPage = 0;
  late PageController _pageController;

  final List<Map<String, dynamic>> _analysisPages = [
    {
      'strength': ['Resilience', 'Mindfulness', 'Consistency'],
    },
    {
      'strength': ['Resilience', 'Mindfulness', 'Consistency'],
      'weakness': ['Procrastination', 'Overthinking', 'Inconsistency'],
    },
    {
      'strength': ['Resilience', 'Mindfulness', 'Consistency'],
      'weakness': ['Procrastination', 'Overthinking', 'Inconsistency'],
      'opportunity': ['Therapy', 'Community', 'Journaling'],
    },
    {
      'strength': ['Resilience', 'Mindfulness', 'Consistency'],
      'weakness': ['Procrastination', 'Overthinking', 'Inconsistency'],
      'opportunity': ['Therapy', 'Community', 'Journaling'],
      'threats': ['Burnout', 'Stress', 'Distraction'],
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _analysisPages.length - 1) {
      setState(() {
        _currentPage++;
      });
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const TodaysTaskScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 64,
        leading: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: const Padding(
          padding: EdgeInsets.only(top: 28.0),
          child: Text(
            'Your Analysis',
            style: TextStyle(
              color: Colors.black,
              fontSize: 32,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.5,
            ),
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0.5),
          child: Container(
            color: const Color.fromARGB(255, 255, 255, 255),
            height: 0.5,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _analysisPages.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (_analysisPages[index].containsKey('strength'))
                          _buildSection(
                            title: 'Strength',
                            items: _analysisPages[index]['strength']!,
                          ),
                        if (_analysisPages[index].containsKey('strength'))
                          const SizedBox(height: 16),
                        if (_analysisPages[index].containsKey('weakness'))
                          _buildSection(
                            title: 'Weakness',
                            items: _analysisPages[index]['weakness']!,
                          ),
                        if (_analysisPages[index].containsKey('weakness'))
                          const SizedBox(height: 16),
                        if (_analysisPages[index].containsKey('opportunity'))
                          _buildSection(
                            title: 'Opportunity',
                            items: _analysisPages[index]['opportunity']!,
                          ),
                        if (_analysisPages[index].containsKey('opportunity'))
                          const SizedBox(height: 16),
                        if (_analysisPages[index].containsKey('threats'))
                          _buildSection(
                            title: 'Threats',
                            items: _analysisPages[index]['threats']!,
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // Continue Button - Exactly as in image
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
            child: SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: _nextPage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD6D6D6),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(26),
                  ),
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<String> items,
  }) {
    // Determine background color based on section
    Color backgroundColor;
    switch (title.toLowerCase()) {
      case 'strength':
        backgroundColor = const Color(0xFFF0F7ED); // Light green
        break;
      case 'weakness':
        backgroundColor = const Color(0xFFF5F5F5); // Light gray
        break;
      case 'opportunity':
        backgroundColor = const Color(0xFFFFF8E1); // Light yellow
        break;
      case 'threats':
        backgroundColor = const Color(0xFFFFEBEE); // Light pink
        break;
      default:
        backgroundColor = Colors.grey.shade50;
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 12),
          ...items.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '• ',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black87,
                        height: 1.5,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black87,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}