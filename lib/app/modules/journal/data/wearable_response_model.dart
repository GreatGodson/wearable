class WearableResponseDto {
  final int steps;
  final int heartRate;
  final DateTime lastUpdated;

  WearableResponseDto({
    required this.steps,
    required this.heartRate,
    required this.lastUpdated,
  });

  factory WearableResponseDto.fromJson(Map<String, dynamic> json) => WearableResponseDto(
    steps: json["steps"],
    heartRate: json["heartRate"],
    lastUpdated: DateTime.parse(json["lastUpdated"]),
  );

  Map<String, dynamic> toJson() => {
    "steps": steps,
    "heartRate": heartRate,
    "lastUpdated": lastUpdated.toIso8601String(),
  };
}
