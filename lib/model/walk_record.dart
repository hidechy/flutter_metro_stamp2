class WalkRecord {
  WalkRecord({
    required this.date,
    required this.step,
    required this.distance,
    required this.timeplace,
    required this.temple,
    required this.mercari,
    required this.train,
    required this.spend,
  });

  factory WalkRecord.fromJson(Map<String, dynamic> json) => WalkRecord(
        date: DateTime.parse(json['date']),
        step: json['step'],
        distance: json['distance'],
        timeplace: json['timeplace'],
        temple: json['temple'],
        mercari: json['mercari'],
        train: json['train'],
        spend: json['spend'],
      );
  DateTime date;
  int step;
  int distance;
  String timeplace;
  String temple;
  String mercari;
  String train;
  String spend;

  Map<String, dynamic> toJson() => {
        'date':
            '${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}',
        'step': step,
        'distance': distance,
        'timeplace': timeplace,
        'temple': temple,
        'mercari': mercari,
        'train': train,
        'spend': spend,
      };
}
