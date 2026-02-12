// screens/todays_tasks.dart
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'set_reminder.dart';

class TodaysTaskScreen extends StatefulWidget {
  const TodaysTaskScreen({Key? key}) : super(key: key);

  @override
  State<TodaysTaskScreen> createState() => _TodaysTaskScreenState();
}

class _TodaysTaskScreenState extends State<TodaysTaskScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();
    
    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 2 * math.pi,
    ).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 56,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0.5),
          child: Container(
            color: Colors.grey.shade200,
            height: 0.5,
          ),
        ),
      ),

      body: Padding(
        padding: EdgeInsets.only(top:3.0),
        child: Column(
             mainAxisAlignment: MainAxisAlignment.start,
          children: [
        
            
          
          const SizedBox(height: 20,)
          ,Column(
         
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
        
        
            const Text(
              "Today's Task",
              style: TextStyle(
                fontSize: 25,
                color: Color.fromARGB(255, 111, 110, 110),
                fontWeight: FontWeight.w800,
              ),
            ),
        
            const SizedBox(height: 80), 
        
          
            Center(
              child: Container(
                width: 350,
                padding: const EdgeInsets.fromLTRB(24, 32, 24, 32),
                decoration: BoxDecoration(
                  color: const Color(0xffF6F7F9),
                  borderRadius: BorderRadius.circular(24),
                      
                  /// Softer Premium Shadow
                  boxShadow: [
                // Border glow shadow
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 12,
                          spreadRadius: 1,
                          offset: Offset(0, 0),
                        ),
              
                        // Existing depth shadow
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 40,
                          offset: const Offset(0, 20),
                        ),
              
                        BoxShadow(
                          color: Colors.black.withOpacity(0.02),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                ),
                      
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                      /// ===== BREATHING CIRCLE =====
                      SizedBox(
                        width: 130,
                        height: 130,
                        child: Stack(
              alignment: Alignment.center,
              children: [
                CustomPaint(
                  size: const Size(160, 160),
                  painter: CirclePainter(),
                ),
                AnimatedBuilder(
                  animation: _rotationAnimation,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: _rotationAnimation.value,
                      child: CustomPaint(
                        size: const Size(160, 160),
                        painter: RotatingArcPainter(),
                      ),
                    );
                  },
                ),
                const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.air, size: 30, color: Colors.black54),
                    
                  ],
                ),
              ],
                        ),
                      ),
                      SizedBox(height: 8),
                    Text(
                      'Breathing Exercise',
                      style: TextStyle(
                        fontSize: 15,
                        color: const Color.fromARGB(255, 124, 124, 124),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '3 min',
                      style: TextStyle(color: Colors.grey,
                      fontSize: 12),
                    ),
                      const SizedBox(height: 23),
                      
                      const Text(
                        'Calm your mind with guided\n breathing.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
              fontSize: 16,
              color: Color(0xff8E8E93),
                        ),
                      ),
                      
                      const SizedBox(height: 32),
                      
                      /// START BUTTON
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff5FA8D3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
              ),
              child: const Text("Start Now",
              style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontSize: 17,
                fontWeight: FontWeight.bold
              ),),
                        ),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      /// REMINDER BUTTON
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: OutlinedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SetReminderScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.notifications_none),
              label: const Text("Set reminder",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 17
              ),),
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.white,
                side: BorderSide(color: const Color.fromARGB(255, 0, 0, 0)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
              ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        )
         
           
          ],
        ),
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 18;

    final backgroundPaint = Paint()
      ..color = Colors.grey.shade200
      ..color = Colors.grey.shade200
      ..strokeWidth = 50;


    canvas.drawCircle(center, radius, backgroundPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class RotatingArcPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 8;

    final progressPaint = Paint()
      ..color = const Color(0xff3A3A3A)
      ..strokeWidth = 14
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 4,
      (2 * math.pi) * 0.45,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}