import 'package:flutter/material.dart';
import 'package:wearable/app/shared/helpers/date_converter.dart';

import '../../../../../core/framework/local/storage_service.dart';
import '../../../../../core/framework/navigator/navigator.dart';
import '../../../../../core/framework/theme/spacings/spacings.dart';
import '../pages/add_journal_page.dart';

class JournalFragment extends StatefulWidget {
  const JournalFragment({super.key});

  @override
  State<JournalFragment> createState() => _JournalFragmentState();
}

class _JournalFragmentState extends State<JournalFragment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () async {
            await navigator.push(
              page: const AddJournalPage(),
            );
            setState(() {});
          }),
      appBar: AppBar(
        title: const Text("Journals"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: Spacings.spacing24,
            horizontal: Spacings.spacing24,
          ),
          child: Column(
            children: [
              Expanded(
                child: FutureBuilder<List<JournalDto>>(
                  future: JournalService.getJournalList(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final data = snapshot.data ?? [];
                      return SingleChildScrollView(
                        child: Column(
                          children: List.generate(data.length, (index) {
                            final entry = data[index].entry;
                            final mood = data[index].mood;
                            final date = convertDateFormat(data[index].date);
                            return Container(
                              margin: const EdgeInsets.only(
                                  bottom: Spacings.spacing16),
                              padding: const EdgeInsets.all(Spacings.spacing12),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    Spacings.spacing12,
                                  ),
                                  color: Colors.purple.withOpacity(0.1)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(entry),
                                      Text(date),
                                    ],
                                  ),
                                  Column(
                                    children: [Text(mood)],
                                  )
                                ],
                              ),
                            );
                          }),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
