extension DateTimeRelativeLabel on DateTime {
  String relativeLabel({DateTime? now}) {
    final current = now ?? DateTime.now();
    final diff = current.difference(this);

    if (diff.inMinutes < 1) return '방금';
    if (diff.inHours < 1) return '${diff.inMinutes}분 전';
    if (diff.inHours < 24) return '${diff.inHours}시간 전';

    final days = DateTime(
      current.year,
      current.month,
      current.day,
    ).difference(DateTime(year, month, day)).inDays;
    if (days == 1) return '어제';
    if (days < 7) return '$days일 전';
    if (days < 28) return '${days ~/ 7}주 전';
    if (year == current.year) return '$month월 $day일';
    return '$year년 $month월 $day일';
  }
}
