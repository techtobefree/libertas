import 'package:intl/intl.dart';

String formatDate(String dateString) {
  DateTime parsedDate = DateTime.parse(dateString);
  DateFormat formatter = DateFormat('MMM dd, yyyy');
  return formatter.format(parsedDate);
}

String formatDateTime(String dateTimeString) {
  try {
    DateTime parsedDate = DateTime.parse(dateTimeString);
    DateFormat formatter = DateFormat('MMM dd, yyyy hh:mm a');
    return formatter.format(parsedDate);
  } catch (exp) {
    return dateTimeString;
  }
}
