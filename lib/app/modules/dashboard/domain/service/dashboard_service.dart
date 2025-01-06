import 'dart:convert';

import 'package:flutter/services.dart';

import '../../../../../core/framework/local/storage_service.dart';
import '../../../../shared/constants/assets.dart';
import '../../../journal/data/wearable_response_model.dart';

class DashboardService {
  static Future<WearableResponseDto> wearableData() async {
    final data = await rootBundle.loadString(JsonPaths.wearableData);
    final body = jsonDecode(data);
    return WearableResponseDto.fromJson(Map.from(body));
  }

  static Future<(List<JournalDto>, WearableResponseDto)>
      getDashboardData() async {
    final journalData = await JournalService.getJournalList();
    final wearData = await wearableData();
    return (journalData, wearData);
  }
}
