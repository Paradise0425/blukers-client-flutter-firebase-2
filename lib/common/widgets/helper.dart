import 'package:intl/intl.dart';

String getFormattedTime(DateTime time, {DateFormat? format}) {
  if (isToday(time)) {
    if (format != null) {
      return format.format(time);
    } else {
      return DateFormat("h:mm a").format(time);
    }
  } else if (isYesterday(time)) {
    return "Yesterday";
  } else if (isInWeek(time)) {
    return DateFormat("EEEE").format(time);
  } else if (isInMonth(time)) {
    return DateFormat("dd/MM").format(time);
  } else if (isInYear(time)) {
    return DateFormat("MMMM").format(time);
  } else {
    return time.year.toString();
  }
}

bool isToday(DateTime time) {
  DateTime now = DateTime.now();

  if (now.year == time.year && now.month == time.month && now.day == time.day) {
    return true;
  }
  return false;
}

bool isYesterday(DateTime time) {
  DateTime now = DateTime.now();

  if (now.year == time.year &&
      now.month == time.month &&
      ((now.day - 1) == time.day)) {
    return true;
  }
  return false;
}

bool isInWeek(DateTime time) {
  DateTime now = DateTime.now();

  if (now.year == time.year &&
      now.month == time.month &&
      ((now.day - 6) > time.day)) {
    return false;
  }
  return true;
}

bool isInMonth(DateTime time) {
  DateTime now = DateTime.now();

  if (now.year == time.year && now.month == time.month) {
    return true;
  }
  return false;
}

bool isInYear(DateTime time) {
  DateTime now = DateTime.now();

  if (now.year == time.year) {
    return true;
  }
  return false;
}

String getAlertString(DateTime time) {
  if (isToday(time)) {
    return "Today";
  } else if (isYesterday(time)) {
    return "Yesterday";
  }
  return DateFormat('dd MMMM yyyy').format(time);
}