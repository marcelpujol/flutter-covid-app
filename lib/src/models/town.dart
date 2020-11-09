class Town {
  String code;
  String name;
  Zone zone;
  String logo;

  Town({
    this.code,
    this.name,
    this.zone,
    this.logo
  });

  Town.fromJsonMap(Map<String, dynamic> json) {
    this.code = json['ine'];
    this.name = json['municipi_nom'];
    this.zone = new Zone.fromJsonMap(json['grup_comarca']);
    this.logo = json['municipi_escut'];
  }
}

class Zone {
  String code;
  String name;

  Zone({
    this.code,
    this.name
  });

  factory Zone.fromJsonMap(Map<String, dynamic> json) {
    return Zone(
      code: json['comarca_codi'],
      name: json['comarca_nom']
    );
  }
}