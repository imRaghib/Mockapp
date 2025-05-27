class CreditLimit {
  final double approved;
  final double utilized;
  final double available;

  CreditLimit(
      {required this.approved,
      required this.utilized,
      required this.available});

  factory CreditLimit.fromJson(Map<String, dynamic> json) => CreditLimit(
        approved: json['approved'],
        utilized: json['utilized'],
        available: json['available'],
      );
}

class Floorplan {
  final int unitCount;
  final String status;
  final double utilized;
  final double permanentLimit;
  final double availableBalance;

  Floorplan({
    required this.unitCount,
    required this.status,
    required this.utilized,
    required this.permanentLimit,
    required this.availableBalance,
  });

  factory Floorplan.fromJson(Map<String, dynamic> json) => Floorplan(
        unitCount: json['unitCount'],
        status: json['status'],
        utilized: json['utilized'],
        permanentLimit: json['permanentLimit'],
        availableBalance: json['availableBalance'],
      );
}

class DashboardModel {
  final String title;
  final String dateTime;
  final CreditLimit creditLimits;
  final List<Floorplan> floorplans;

  DashboardModel({
    required this.title,
    required this.dateTime,
    required this.creditLimits,
    required this.floorplans,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) => DashboardModel(
        title: json['title'],
        dateTime: json['dateTime'],
        creditLimits: CreditLimit.fromJson(json['creditLimits']),
        floorplans: List<Floorplan>.from(
            json['floorplans'].map((x) => Floorplan.fromJson(x))),
      );
}
