import 'dart:convert';

OnboardingDto onboardingDtoFromJson(String str) =>
    OnboardingDto.fromJson(json.decode(str));

String onboardingDtoToJson(OnboardingDto data) => json.encode(data.toJson());

class OnboardingDto {
  final List<Message> message;

  OnboardingDto({
    required this.message,
  });

  factory OnboardingDto.fromJson(Map<String, dynamic> json) => OnboardingDto(
        message:
            List<Message>.from(json["message"].map((x) => Message.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": List<dynamic>.from(message.map((x) => x.toJson())),
      };
}

class Message {
  final String title;
  final String message;
  final String lottie;

  Message({
    required this.title,
    required this.message,
    required this.lottie,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        title: json["title"],
        message: json["message"],
        lottie: json["lottie"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "message": message,
        "lottie": lottie,
      };
}
