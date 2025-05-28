class DashboardModel {
  final String title;
  final Labels labels;
  final CreditLimits creditLimits;
  final List<Floorplan> floorplans;

  DashboardModel({
    required this.title,
    required this.labels,
    required this.creditLimits,
    required this.floorplans,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      title: json['title'],
      labels: Labels.fromJson(json['labels']),
      creditLimits: CreditLimits.fromJson(json['creditLimits']),
      floorplans: List<Floorplan>.from(
        json['floorplans'].map((fp) => Floorplan.fromJson(fp)),
      ),
    );
  }
}

class Labels {
  final String approvedLimit;
  final String utilizedLimit;
  final String availableLimit;
  final String floorplanUnits;
  final String permanentLimit;
  final String availableBalance;
  final String utilized;

  Labels({
    required this.approvedLimit,
    required this.utilizedLimit,
    required this.availableLimit,
    required this.floorplanUnits,
    required this.permanentLimit,
    required this.availableBalance,
    required this.utilized,
  });

  factory Labels.fromJson(Map<String, dynamic> json) {
    return Labels(
      approvedLimit: json['approvedLimit'],
      utilizedLimit: json['utilizedLimit'],
      availableLimit: json['availableLimit'],
      floorplanUnits: json['floorplanUnits'],
      permanentLimit: json['permanentLimit'],
      availableBalance: json['availableBalance'],
      utilized: json['utilized'],
    );
  }
}

class CreditLimits {
  final String title;
  final double approvedLimit;
  final double availableLimit;
  final double utilizedLimit;

  CreditLimits({
    required this.title,
    required this.approvedLimit,
    required this.availableLimit,
    required this.utilizedLimit,
  });

  factory CreditLimits.fromJson(Map<String, dynamic> json) {
    return CreditLimits(
      title: json['title'],
      approvedLimit: (json['approvedLimit'] as num).toDouble(),
      availableLimit: (json['availableLimit'] as num).toDouble(),
      utilizedLimit: (json['utilizedLimit'] as num).toDouble(),
    );
  }
}

class Floorplan {
  final int unitCount;
  final String status;
  final double permanentLimit;
  final double availableBalance;
  final double utilized;

  Floorplan({
    required this.unitCount,
    required this.status,
    required this.permanentLimit,
    required this.availableBalance,
    required this.utilized,
  });

  factory Floorplan.fromJson(Map<String, dynamic> json) {
    return Floorplan(
      unitCount: json['unitCount'],
      status: json['status'],
      permanentLimit: (json['permanentLimit'] as num).toDouble(),
      availableBalance: (json['availableBalance'] as num).toDouble(),
      utilized: (json['utilized'] as num).toDouble(),
    );
  }
}
