const weekDays = ["Mon", "Tue", "Wen", "Thu", "Fri", "Sat", "Sun"];

String getWeekDay(int day) => weekDays[day % weekDays.length];

String parseDate(String date) {
  final dateTime = DateTime.parse(date);
  return "${dateTime.hour}:${dateTime.minute}\n${weekDays[dateTime.weekday]}, ${dateTime.month}/${dateTime.day}";
}
