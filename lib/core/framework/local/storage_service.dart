import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wearable/core/framework/local/storage_keys.dart';

class AppPreferences {
  static late FlutterSecureStorage _secureStorage;

  static String? _journals;

  factory AppPreferences() => AppPreferences._internal();

  AppPreferences._internal();

  static Future<void> init() async {
    _secureStorage = const FlutterSecureStorage();
    _journals = await _secureStorage.read(key: PrefsConstants.journals);
  }

  static Future<void> clear() async {
    await _secureStorage.deleteAll();
  }

  static Future<void> clearKey(String key) async {
    await _secureStorage.delete(key: key);
  }

  static String get journals => _journals ?? "";

  static Future<void> addJournal(String value) async {
    _journals = value;
    await _secureStorage.write(key: PrefsConstants.journals, value: value);
  }
}

class JournalDto {
  JournalDto({
    required this.date,
    required this.entry,
    required this.mood,
  });

  final String entry;
  final String mood;
  final String date;

  // Convert JournalDto to JSON
  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'entry': entry,
      'mood': mood,
    };
  }

  // Create JournalDto from JSON
  factory JournalDto.fromJson(Map<String, dynamic> json) {
    return JournalDto(
      date: json['date'],
      entry: json['entry'],
      mood: json['mood'],
    );
  }
}

class JournalService {
  // Save the list of JournalDto
  static Future<void> saveJournalList(List<JournalDto> journalList) async {
    final jsonList = journalList.map((journal) => journal.toJson()).toList();
    final jsonString = jsonEncode(jsonList);
    await AppPreferences.addJournal(jsonString);
  }

  // Retrieve the list of JournalDto
  static Future<List<JournalDto>> getJournalList() async {
    final jsonString = AppPreferences.journals;

    if (jsonString.isEmpty) {
      return [];
    }

    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((json) => JournalDto.fromJson(json)).toList();
  }

  // Add a single JournalDto to the list
  static Future<void> addJournal(JournalDto newJournal) async {
    final currentList = await getJournalList();
    currentList.add(newJournal);
    await saveJournalList(currentList);
  }
}
