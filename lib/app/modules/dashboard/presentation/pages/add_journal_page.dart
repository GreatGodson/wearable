import 'package:flutter/material.dart';
import 'package:wearable/app/shared/presentation/components/button_component.dart';
import 'package:wearable/app/shared/presentation/components/text_field_component.dart';
import 'package:wearable/core/framework/local/storage_service.dart';
import 'package:wearable/core/framework/navigator/navigator.dart';
import 'package:wearable/core/framework/theme/spacings/spacings.dart';

import '../../../../shared/helpers/show_alert.dart';
import '../../../onboarding/domain/service/onboarding_service.dart';
import '../../domain/service/dashboard_service.dart';

class AddJournalPage extends StatefulWidget {
  const AddJournalPage({super.key});

  @override
  State<AddJournalPage> createState() => _AddJournalPageState();
}

class _AddJournalPageState extends State<AddJournalPage> {
  String _selectedEmoji = "";
  String entry = "";

  final List<String> _emojis = [
    "😀",
    "😁",
    "😂",
    "🤣",
    "🥳",
    "🤩",
    "😍",
    "😃",
    "😄",
    "😊",
    "🥰",
    "😘",
    "😗",
    "😙",
    "😚",
    "😋",
    "😎",
    "😜",
    "😝",
    "😛",
    "😉",
    "🤭",
    "🤔",
    "🤨",
    "🧐",
    "🙂",
    "🙃",
    "😌",
    "😐",
    "😑",
    "😶",
    "😒",
    "🙄",
    "😏",
    "😔",
    "😕",
    "😢",
    "😭",
    "😴",
    "😪",
    "🥱",
    "😫",
    "😓",
    "😐",
    "😑",
    "😶",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Spacings.spacing24,
          ),
          child: Column(
            children: [
              const SizedBox(
                height: Spacings.spacing24,
              ),
              const Row(
                children: [
                  Text("Journal Entry"),
                ],
              ),
              const SizedBox(
                height: Spacings.spacing10,
              ),
              TextFieldComponent(
                onChanged: (val) {
                  entry = val;
                },
                hint: "Journal Entry",
              ),
              const SizedBox(
                height: Spacings.spacing24,
              ),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(16.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 6, // Number of emojis per row
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: _emojis.length,
                  itemBuilder: (context, index) {
                    final emoji = _emojis[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedEmoji = emoji;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: _selectedEmoji == emoji
                              ? Colors.teal.withOpacity(0.2)
                              : Colors.grey.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: _selectedEmoji == emoji
                                ? Colors.teal
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            emoji,
                            style: const TextStyle(fontSize: 28),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: Spacings.spacing24,
              ),
              ButtonComponent(
                text: "Save",
                onPressed: () async {
                  JournalService.addJournal(
                    JournalDto(
                      date: DateTime.now().toString(),
                      entry: entry,
                      mood: _selectedEmoji,
                    ),
                  );
                  final data = await OnboardingService.loadOnboarding();
                  final wearData = await DashboardService.wearableData();
                  showDialogComponent(() {
                    navigator.popUntil();
                  }, data.message[2].title, "Step Count: ${wearData.steps}");
                },
                expanded: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
