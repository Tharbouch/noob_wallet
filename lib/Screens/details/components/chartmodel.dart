class ChartModel {
  final DateTime date;
  final double open;
  final double high;
  final double low;
  final double close;

  ChartModel(
      {required this.date,
      required this.open,
      required this.high,
      required this.low,
      required this.close});

  factory ChartModel.fromJson(dynamic json) {
    return ChartModel(
      close: json[4] as double,
      open: json[1] as double,
      high: json[2] as double,
      low: json[3] as double,
      date: json[0] as DateTime,
    );
  }

  static List<ChartModel> chartdata(List data) {
    return data.map((items) {
      return ChartModel.fromJson(items);
    }).toList();
  }
}
