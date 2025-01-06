import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../fragment/dashboard_fragment.dart';
import '../fragment/journal_fragment.dart';

class DashboardPage extends ConsumerWidget {
  DashboardPage({super.key});

  final _selectedIndexProvider = StateProvider.autoDispose((ref) => 0);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndexState = ref.watch(_selectedIndexProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: selectedIndexState,
        children: [
          DashboardFragment(),
          const JournalFragment(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndexState,
        onTap: (index) {
          // setState(() {});
          ref.read(_selectedIndexProvider.notifier).state = index;
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit_note_outlined),
            label: 'Journal',
          ),
        ],
      ),
    );
  }
}
