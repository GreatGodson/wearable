String formatDateString(String inputDate, {bool shortenMonth = false}) {
  final parts = inputDate.split("-");
  final year = parts[0];
  final month = _getMonthName(int.parse(parts[1]), shortenMonth: shortenMonth);
  final day = parts[2].split("T")[0];

  return "$day $month $year";
}

String _getMonthName(int monthNumber, {bool shortenMonth = false}) {
  switch (monthNumber) {
    case 1:
      return shortenMonth ? "Jan." : "January";
    case 2:
      return shortenMonth ? "Feb." : "February";
    case 3:
      return shortenMonth ? "Mar." : "March";
    case 4:
      return shortenMonth ? "Apr." : "April";
    case 5:
      return "May";
    case 6:
      return shortenMonth ? "Jun." : "June";
    case 7:
      return shortenMonth ? "Jul." : "July";
    case 8:
      return shortenMonth ? "Aug." : "August";
    case 9:
      return shortenMonth ? "Sep." : "September";
    case 10:
      return shortenMonth ? "Oct." : "October";
    case 11:
      return shortenMonth ? "Nov." : "November";
    case 12:
      return shortenMonth ? "Dec." : "December";
    default:
      return "";
  }
}

String convertDateFormat(String inputDate) {
  final parts = inputDate.split(" ")[0].split("-");
  final year = parts[0];
  final month = parts[1];
  final day = parts[2];

  return "$day-$month-$year";
}
