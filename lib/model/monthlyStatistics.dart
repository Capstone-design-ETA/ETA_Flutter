class MonthlyStatistics{
  final String yearMonth;
  final int averageStep;
  final int visitedLoc;
  final List<String> mostCaller;

  const MonthlyStatistics({
    required this.yearMonth,
    required this.averageStep,
    required this.visitedLoc,
    required this.mostCaller
  });
}