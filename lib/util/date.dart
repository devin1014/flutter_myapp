/// weekday from 1-7.
const _weekDays = ["", "Mon", "Tue", "Wen", "Thu", "Fri", "Sat", "Sun"];

String getWeekDay(int day) => _weekDays[day % _weekDays.length];

String parseDate(String date) {
  final dateTime = DateTime.parse(date);
  return "${dateTime.hour}:${dateTime.minute}\n${_weekDays[dateTime.weekday]}, ${dateTime.month}/${dateTime.day}";
}
