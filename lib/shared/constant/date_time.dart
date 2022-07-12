DateTime strToDateTime(String time) {
  return DateTime.parse(time);
}

int residualHourTime(DateTime time) {
  return time.difference(DateTime.now()).inHours;
}
