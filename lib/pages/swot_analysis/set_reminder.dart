// screens/set_reminder.dart
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SetReminderScreen extends StatefulWidget {
  const SetReminderScreen({Key? key}) : super(key: key);

  @override
  State<SetReminderScreen> createState() => _SetReminderScreenState();
}

class _SetReminderScreenState extends State<SetReminderScreen> {
  int selectedHour = 6;
  int selectedMinute = 0;
  String selectedPeriod = 'am';

  bool reminderSoundEnabled = true;
  bool vibrationEnabled = true;
  bool snoozeEnabled = true;

  String selectedSound = 'Homecoming';
  String selectedVibration = 'Basic call';
  String selectedSnooze = '5 minutes, 3 times';

  final List<String> sounds = ['Homecoming', 'Spring', 'Ocean', 'Forest', 'Silent'];
  final List<String> vibrations = ['Basic call', 'Gentle', 'Persistent', 'None'];
  final List<String> snoozeOptions = [
    '5 minutes, 3 times',
    '10 minutes, 2 times',
    '15 minutes, 1 time',
    '30 minutes, 1 time'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
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
        title: Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: Center(
            child: Text(
              'Set reminder',
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        centerTitle: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0.5),
          child: Container(
            color: const Color.fromARGB(255, 255, 255, 255),
            height: 0.5,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // Time picker - FULL RANGE
            Container(
              height: 240,
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Hour picker - 1-12
                  Expanded(
                    child: CupertinoPicker(
                      scrollController: FixedExtentScrollController(
                        initialItem: selectedHour - 1,
                      ),
                      itemExtent: 60,
                      squeeze: 0.9,
                      useMagnifier: true,
                      magnification: 1.1,
                      onSelectedItemChanged: (index) {
                        setState(() {
                          selectedHour = index + 1;
                        });
                      },
                      selectionOverlay: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(color: Colors.grey.shade300),
                            bottom: BorderSide(color: Colors.grey.shade300),
                          ),
                        ),
                      ),
                      children: List.generate(12, (index) {
                        final hour = index + 1;
                        final isSelected = selectedHour == hour;
                        return Center(
                          child: Text(
                            hour.toString(),
                            style: TextStyle(
                              fontSize: isSelected ? 52 : 48,
                              fontWeight: isSelected ? FontWeight.w500 : FontWeight.w300,
                              color: isSelected ? const Color.fromARGB(255, 0, 0, 0) : Colors.grey.shade600,
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  // Colon
                  Text(
                    ':',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.w300,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  // Minute picker - 0-59
                  Expanded(
                    child: CupertinoPicker(
                      scrollController: FixedExtentScrollController(
                        initialItem: selectedMinute,
                      ),
                      itemExtent: 60,
                      squeeze: 0.9,
                      useMagnifier: true,
                      magnification: 1.1,
                      onSelectedItemChanged: (index) {
                        setState(() {
                          selectedMinute = index;
                        });
                      },
                      selectionOverlay: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(color: Colors.grey.shade300),
                            bottom: BorderSide(color: Colors.grey.shade300),
                          ),
                        ),
                      ),
                      children: List.generate(60, (index) {
                        final isSelected = selectedMinute == index;
                        return Center(
                          child: Text(
                            index.toString().padLeft(2, '0'),
                            style: TextStyle(
                              fontSize: isSelected ? 52 : 48,
                              fontWeight: isSelected ? FontWeight.w500 : FontWeight.w300,
                              color: isSelected ? const Color.fromARGB(255, 0, 0, 0) : Colors.grey.shade600,
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // AM/PM picker
                  SizedBox(
                    width: 80,
                    child: CupertinoPicker(
                      scrollController: FixedExtentScrollController(
                        initialItem: selectedPeriod == 'am' ? 0 : 1,
                      ),
                      itemExtent: 60,
                      squeeze: 0.9,
                      useMagnifier: true,
                      magnification: 1.1,
                      onSelectedItemChanged: (index) {
                        setState(() {
                          selectedPeriod = index == 0 ? 'am' : 'pm';
                        });
                      },
                      selectionOverlay: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(color: Colors.grey.shade300),
                            bottom: BorderSide(color: Colors.grey.shade300),
                          ),
                        ),
                      ),
                      children: [
                        Center(
                          child: Text(
                            'am',
                            style: TextStyle(
                              fontSize: selectedPeriod == 'am' ? 40 : 36,
                              fontWeight: selectedPeriod == 'am' ? FontWeight.w500 : FontWeight.w300,
                              color: selectedPeriod == 'am' ? const Color.fromARGB(255, 0, 0, 0) : Colors.grey.shade600,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            'pm',
                            style: TextStyle(
                              fontSize: selectedPeriod == 'pm' ? 40 : 36,
                              fontWeight: selectedPeriod == 'pm' ? FontWeight.w500 : FontWeight.w300,
                              color: selectedPeriod == 'pm' ? Colors.blue : Colors.grey.shade600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 80),
           
            _buildSettingItem(
              label: 'Reminder sound',
              sublabel: selectedSound,
              value: reminderSoundEnabled,
              options: sounds,
              onChanged: (value) {
                setState(() {
                  reminderSoundEnabled = value;
                });
              },
              onSublabelChanged: (newValue) {
                setState(() {
                  selectedSound = newValue;
                });
              },
            ),
            const SizedBox(height: 40),
            // Vibration - with dropdown
            _buildSettingItem(
              label: 'Vibration',
              sublabel: selectedVibration,
              value: vibrationEnabled,
              options: vibrations,
              onChanged: (value) {
                setState(() {
                  vibrationEnabled = value;
                });
              },
              onSublabelChanged: (newValue) {
                setState(() {
                  selectedVibration = newValue;
                });
              },
            ),
            const SizedBox(height: 40),
            // Snooze - with dropdown
            _buildSettingItem(
              label: 'Snooze',
              sublabel: selectedSnooze,
              value: snoozeEnabled,
              options: snoozeOptions,
              onChanged: (value) {
                setState(() {
                  snoozeEnabled = value;
                });
              },
              onSublabelChanged: (newValue) {
                setState(() {
                  selectedSnooze = newValue;
                });
              },
            ),
            const Spacer(),
            // Done button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  // Format the selected time
                  String formattedTime = '$selectedHour:${selectedMinute.toString().padLeft(2, '0')} $selectedPeriod';
                  print('Reminder set for: $formattedTime');
                  Navigator.pop(context, {
                    'hour': selectedHour,
                    'minute': selectedMinute,
                    'period': selectedPeriod,
                    'sound': selectedSound,
                    'vibration': selectedVibration,
                    'snooze': selectedSnooze,
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  'Done',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingItem({
    required String label,
    required String sublabel,
    required bool value,
    required List<String> options,
    required ValueChanged<bool> onChanged,
    required ValueChanged<String> onSublabelChanged,
  }) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              GestureDetector(
                onTap: () {
                  // Show dropdown options
                  _showOptionsDialog(context, label, options, onSublabelChanged);
                },
                child: Text(
                    sublabel,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.blue,
                      fontWeight: FontWeight.w400,
                    ),
                  ),

              ),
            ],
          ),
        ),
        CupertinoSwitch(
          value: value,
          onChanged: onChanged,
          activeColor: Colors.blue,
        ),
      ],
    );
  }

  void _showOptionsDialog(
    BuildContext context,
    String title,
    List<String> options,
    ValueChanged<String> onSelected,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select $title'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: options.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(options[index]),
                  onTap: () {
                    onSelected(options[index]);
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}