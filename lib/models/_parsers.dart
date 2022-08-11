import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

DateTime? parseToDateTime(dynamic date) {
  if (date is DateTime) return date;
  if (date is Timestamp) return date.toDate();
  if (date is String) return DateTime.tryParse(date) ?? null;
  if (date is num) return DateTime.fromMillisecondsSinceEpoch(date.toInt());
  return null;
}

String? parseToDayString(dynamic date) {
  DateTime? dateTime = parseToDateTime(date);
  if (dateTime == null) return null;
  return DateFormat("d MMM, y").format(dateTime);
}

String? parseToDayUTCString(dynamic date) {
  DateTime? dateTime = parseToDateTime(date);
  if (dateTime == null) return null;
  dateTime = dateTime.toLocal();
  return DateFormat("d MMM, y").format(dateTime);
}

String? parseToDayTimeString(dynamic date) {
  DateTime? dateTime = parseToDateTime(date);
  if (dateTime == null) return null;
  return DateFormat("d MMM, y @ h:mm:ss a").format(dateTime);
}

String? parseToDayTimeUTCString(dynamic date) {
  DateTime? dateTime = parseToDateTime(date);
  if (dateTime == null) return null;
  dateTime = dateTime.toLocal();
  return DateFormat("d MMM, y @ h:mm:ss a").format(dateTime);
}
