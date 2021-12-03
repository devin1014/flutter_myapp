const weekDays = ["Mon", "Tue", "Wen", "Thu", "Fri", "Sat", "Sun"];

String parseDate(String date) {
  final dateTime = DateTime.parse(date);
  return "${dateTime.hour}:${dateTime.minute}\n${weekDays[dateTime.weekday]}, ${dateTime.month}/${dateTime.day}";
}
