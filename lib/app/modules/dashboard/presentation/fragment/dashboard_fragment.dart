import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../../core/framework/local/storage_service.dart';
import '../../../../../core/framework/theme/spacings/spacings.dart';
import '../../../journal/data/wearable_response_model.dart';
import '../../domain/service/dashboard_service.dart';

class DashboardFragment extends StatelessWidget {
  DashboardFragment({super.key});

  Map<int, String> moodDescriptions = {
    1: "😀 😁 😂 🤣 🥳 🤩 😍 - Excited/Joyful",
    2: "😃 😄 😊 🥰 😘 😗 😙 😚 - Happy/Content",
    3: "😋 😎 😜 😝 😛 😉 🤭 - Playful/Cheeky",
    4: "🤔 🤨 🧐 - Curious/Intrigued",
    5: "🙂 🙃 😌 - Neutral/Calm",
    6: "😐 😑 😶 - Tired/Meh",
    7: "😒 🙄 😏 - Annoyed/Frustrated",
    8: "😔 😕 😢 😭 - Sad/Downcast",
    9: "😴 😪 🥱 😫 😓 - Exhausted/Tired",
    10: "😐 😑 😶 - Dullest/Emotionless",
  };

  double mapMoodToDouble(String mood) {
    if ("😀😁😂🤣🥳🤩😍".contains(mood)) return 1;
    if ("😃😄😊🥰😘😗😙😚".contains(mood)) return 2;
    if ("😋😎😜😝😛😉🤭".contains(mood)) return 3;
    if ("🤔🤨🧐".contains(mood)) return 4;
    if ("🙂🙃😌".contains(mood)) return 5;
    if ("😐😑😶".contains(mood)) return 6;
    if ("😒🙄😏".contains(mood)) return 7;
    if ("😔😕😢😭".contains(mood)) return 8;
    if ("😴😪🥱😫😓".contains(mood)) return 9;
    return 10; // Default to "Dullest/Emotionless"
  }

  String selectMostPositiveMood(List<String> moods) {
    // Mood ranking from most positive (1) to dullest (10)
    const moodRankings = {
      "😀": 1,
      "😁": 1,
      "😂": 1,
      "🤣": 1,
      "🥳": 1,
      "🤩": 1,
      "😍": 1,
      "😃": 2,
      "😄": 2,
      "😊": 2,
      "🥰": 2,
      "😘": 2,
      "😗": 2,
      "😙": 2,
      "😚": 2,
      "😋": 3,
      "😎": 3,
      "😜": 3,
      "😝": 3,
      "😛": 3,
      "😉": 3,
      "🤭": 3,
      "🤔": 4,
      "🤨": 4,
      "🧐": 4,
      "🙂": 5,
      "🙃": 5,
      "😌": 5,
      "😐": 6,
      "😑": 6,
      "😶": 6,
      "😒": 7,
      "🙄": 7,
      "😏": 7,
      "😔": 8,
      "😕": 8,
      "😢": 8,
      "😭": 8,
      "😴": 9,
      "😪": 9,
      "🥱": 9,
      "😫": 9,
      "😓": 9,
    };

    String mostPositiveMood = moods.first;
    int smallestRank = moodRankings[mostPositiveMood] ?? 10;

    for (String mood in moods) {
      final rank = moodRankings[mood] ?? 10;
      if (rank < smallestRank) {
        smallestRank = rank;
        mostPositiveMood = mood;
      }
    }

    return mostPositiveMood;
  }

  Widget _buildMoodLegend() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: moodDescriptions.entries.map((entry) {
        return Row(
          children: [
            Text(
              '${entry.key}:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(entry.value, overflow: TextOverflow.ellipsis),
            ),
          ],
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
      ),
      body: FutureBuilder<(List<JournalDto>, WearableResponseDto)>(
        future: DashboardService.getDashboardData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final journalData = snapshot.data?.$1;
            final totalSteps = snapshot.data?.$2.steps;
            final recentEntries = journalData?.takeLast(7);
            final moodTrends = recentEntries!
                .map((entry) => mapMoodToDouble(entry.mood))
                .toList();

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Mood Trends",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    AspectRatio(
                      aspectRatio: 1.5,
                      child: LineChart(
                        LineChartData(
                          gridData: const FlGridData(show: true),
                          titlesData: FlTitlesData(
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  return Text(
                                    '${value.toInt() + 1}',
                                    style: const TextStyle(fontSize: 12),
                                  );
                                },
                              ),
                            ),
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  return Text(
                                    value.toInt().toString(),
                                    style: const TextStyle(fontSize: 10),
                                  );
                                },
                              ),
                            ),
                            rightTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            topTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                          ),
                          borderData: FlBorderData(show: true),
                          lineBarsData: [
                            LineChartBarData(
                              spots: List.generate(
                                moodTrends.length,
                                (index) =>
                                    FlSpot(index.toDouble(), moodTrends[index]),
                              ),
                              isCurved: true,
                              barWidth: 4,
                              belowBarData: BarAreaData(
                                show: true,
                                // colors: [Colors.blue.withOpacity(0.2)],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildMoodLegend(),
                    const SizedBox(height: 24),
                    const Text(
                      "Highlight",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Card(
                      color: Colors.lightGreen[100],
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: Spacings.spacing16,
                          horizontal: Spacings.spacing24,
                        ),
                        child: Text(
                          selectMostPositiveMood(
                              journalData!.map((e) => e.mood).toList()),
                          style: const TextStyle(
                              fontSize: Spacings.spacing24,
                              color: Colors.black87),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      "Health Metrics",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Card(
                      color: Colors.blue[100],
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Total Steps",
                              style: TextStyle(
                                  fontSize: 16, color: Colors.black87),
                            ),
                            Text(
                              totalSteps.toString(),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

extension on List<JournalDto> {
  List<JournalDto> takeLast(int count) {
    if (length <= count) return this;
    return sublist(length - count);
  }
}
