class TriggerModel {
  String? trigerZoneName;
  String? trigerTitle;
  String? trigerAction;
  int? trigerActionButtonNumber;
  bool? trigerStateONOFF;
  String? trigerFromTimeHour;
  String? trigerFromTimeMint;
  String? trigerFromTimePeriod;
  String? trigerToTimeHour;
  String? trigerToTimeMint;
  String? trigerToTimePeriod;
  bool? trigerStatus;

  String? trigerId;
  DateTime? trigerCreatedDateTime;

  List? trigerDayName;
  int? trigerDayNumber;

  String? trigerMonthName;

  int? trigerHours;

  int? trigerMinutes;

  int? trigerSeconds;

  String? trigerRuleName;

  // geo
  String? zoneName;
  String? zoneRadious;
  String? locationName;
  String? locationLat;
  String? locationLong;
  bool? areaEntered;
  int? rulePopupWhenLounch;
  bool isTriggered;

  TriggerModel({
    this.trigerTitle,
    this.trigerAction,
    this.trigerStateONOFF,
    this.trigerFromTimeHour,
    this.trigerFromTimeMint,
    this.trigerFromTimePeriod,
    this.trigerToTimeHour,
    this.trigerToTimeMint,
    this.trigerToTimePeriod,
    this.trigerId,
    required this.trigerCreatedDateTime,
    this.trigerDayName,
    this.trigerDayNumber,
    this.trigerMonthName,
    this.trigerHours,
    this.trigerMinutes,
    this.trigerSeconds,
    this.zoneName,
    this.zoneRadious,
    this.locationName,
    this.locationLat,
    this.locationLong,
    this.areaEntered,
    this.trigerZoneName,
    this.trigerActionButtonNumber,
    this.trigerRuleName,
    this.trigerStatus,
    this.rulePopupWhenLounch,
   required this.isTriggered
  });

  Map<String, dynamic> toJson() {
    return {
      'trigerTitle': trigerTitle,
      'trigerAction': trigerAction,
      'trigerStateONOFF': trigerStateONOFF,
      "trigerFromTimeHour": trigerFromTimeHour,
      "trigerFromTimeMint": trigerFromTimeMint,
      "trigerFromTimePeriod": trigerFromTimePeriod,
      "trigerToTimeHour": trigerToTimeHour,
      "trigerToTimeMint": trigerToTimeMint,
      "trigerToTimePeriod": trigerToTimePeriod,
      'trigerId': trigerId,
      'trigerCreatedDateTime': trigerCreatedDateTime?.toIso8601String(),
      'trigerDayName': trigerDayName,
      'trigerDayNumber': trigerDayNumber,
      'trigerMonthName': trigerMonthName,
      'trigerHours': trigerHours,
      'trigerMinutes': trigerMinutes,
      'trigerSeconds': trigerSeconds,
      'zoneName': zoneName,
      'zoneRadious': zoneRadious,
      'locationName': locationName,
      'locationLat': locationLat,
      'locationLong': locationLong,
      'areaEntered': areaEntered,
      'trigerZoneName': trigerZoneName,
      'trigerActionButtonNumber': trigerActionButtonNumber,
      'trigerRuleName': trigerRuleName,
      'trigerStatus': trigerStatus,
      'rulePopupWhenLounch': rulePopupWhenLounch,
      'isTriggered': isTriggered,
    };
  }

  static TriggerModel fromJson(Map<String, dynamic> json) {
    return TriggerModel(
      trigerTitle: json['trigerTitle'],
      trigerAction: json['trigerAction'],
      trigerStateONOFF: json['trigerStateONOFF'],
      trigerId: json['trigerId'],
      trigerCreatedDateTime: json['trigerCreatedDateTime'] != null
          ? DateTime.parse(json['trigerCreatedDateTime'])
          : null,
      trigerDayName: json['trigerDayName'],
      trigerFromTimeHour: json['trigerFromTimeHour'],
      trigerFromTimeMint: json['trigerFromTimeMint'],
      trigerFromTimePeriod: json['trigerFromTimePeriod'],
      trigerToTimeHour: json['trigerToTimeHour'],
      trigerToTimeMint: json['trigerToTimeMint'],
      trigerToTimePeriod: json['trigerToTimePeriod'],
      trigerDayNumber: json['trigerDayNumber'],
      trigerMonthName: json['trigerMonthName'],
      trigerHours: json['trigerHours'],
      trigerMinutes: json['trigerMinutes'],
      trigerSeconds: json['trigerSeconds'],
      zoneName: json['zoneName'],
      zoneRadious: json['zoneRadious'],
      locationName: json['locationName'],
      locationLat: json['locationLat'],
      locationLong: json['locationLong'],
      areaEntered: json['areaEntered'],
      trigerZoneName: json['trigerZoneName'],
      trigerActionButtonNumber: json['trigerActionButtonNumber'],
      trigerRuleName: json['trigerRuleName'],
      trigerStatus: json['trigerStatus'],
      rulePopupWhenLounch: json['rulePopupWhenLounch'],
      isTriggered: json['isTriggered'],
    );
  }
}
