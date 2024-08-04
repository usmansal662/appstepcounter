class HistoryModel {
  final DateTime dateTime;
  final double distance;
  final int steps;
  final double caloriesBurn;
  final int walkingSeconds;
  final int goalSteps;

  HistoryModel({
    required this.dateTime,
    required this.steps,
    required this.walkingSeconds,
    required this.distance,
    required this.caloriesBurn,
    required this.goalSteps,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) => HistoryModel(
        dateTime: DateTime.parse(json['dateTime']),
        steps: json['steps'],
        walkingSeconds: json['walkingSeconds'],
        distance: json['distance'],
        caloriesBurn: json['caloriesBurn'],
        goalSteps: json['goalSteps'],
      );

  Map<String, dynamic> toJson() => {
        'dateTime': dateTime.toString(),
        'steps': steps,
        'walkingSeconds': walkingSeconds,
        'distance': distance,
        'caloriesBurn': caloriesBurn,
        'goalSteps': goalSteps,
      };
}
