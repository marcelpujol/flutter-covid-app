class IncidenceByRegion {
  String name;
  String code;
  String date;
  String gender;
  String ageGroup;
  int pcr;
  int totalHospitalized;
  int totalCritical;
  int deads;

  IncidenceByRegion({
    this.name,
    this.code,
    this.date,
    this.gender,
    this.ageGroup,
    this.pcr,
    this.totalHospitalized,
    this.totalCritical,
    this.deads
  });

  IncidenceByRegion.fromJsonMap(Map<String, dynamic> json) {
    this.name = json['nom'];
    this.code = json['codi'];
    this.date = json['data'];
    this.gender = json['sexe'];
    this.ageGroup = json['grup_edat'];
    this.pcr = int.parse(json['pcr']);
    this.totalHospitalized = int.parse(json['ingressats_total']);
    this.totalCritical = int.parse(json['ingressats_critic']);
    this.deads = int.parse(json['exitus']);
  }
}