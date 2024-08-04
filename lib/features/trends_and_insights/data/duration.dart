

List<String> trendRange = [
  "Day",
  "Week",
  "Month",
  "Year",
];

enum InsightRange {
  day,
  week,
  month,
  year,
}

extension MyDuration on InsightRange {
  String get name {
    switch (this) {
      case InsightRange.day:
        return 'Day';
      case InsightRange.week:
        return 'Week';
      case InsightRange.month:
        return 'Month';
      case InsightRange.year:
        return 'Year';
      default:
        return '';
    }
  }
}

extension DurationEnum on String {
  InsightRange get insightRange {
    switch (this) {
      case 'Day':
        return InsightRange.day;
      case 'Week':
        return InsightRange.week;
      case 'Month':
        return InsightRange.month;
      case 'Year':
        return InsightRange.year;
      default:
        return InsightRange.day;
    }
  }
}
