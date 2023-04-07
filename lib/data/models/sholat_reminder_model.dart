class SholatReminderModel {
  final int id;
  final String title;
  final String body;
  final String payload;
  final int hour;
  final int minute;

  const SholatReminderModel({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
    required this.hour,
    required this.minute,
  });
}
