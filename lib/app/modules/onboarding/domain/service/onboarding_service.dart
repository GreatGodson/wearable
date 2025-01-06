import 'dart:convert';

import 'package:flutter/services.dart';

import '../../../../shared/constants/assets.dart';
import '../../data/models/response/onboarding_model.dart';

class OnboardingService {
  static Future<OnboardingDto> loadOnboarding() async {
    final data = await rootBundle.loadString(JsonPaths.motivationalMessages);
    final body = jsonDecode(data);
    return OnboardingDto.fromJson(Map.from(body));
  }
}
