class GlobalIncidence {
  int dailyConfirmed;
  int dailyDeads;
  int dailyRecovered;
  int totalConfirmed;
  int totalDeads;
  int totalRecovered;

  GlobalIncidence({
    this.dailyConfirmed,
    this.dailyDeads,
    this.dailyRecovered,
    this.totalConfirmed,
    this.totalDeads,
    this.totalRecovered
  });

  GlobalIncidence.fromJsonMap(Map<String, dynamic> json) {
    this.dailyConfirmed = json['nous_casos_diaris_confirmats'];
    this.dailyDeads = json['defuncions_di_ries'];
    this.dailyRecovered = json['altes_di_ries'];
    this.totalConfirmed = json['total_de_casos_confirmats'];
    this.totalDeads = json['total_de_defuncions'];
    this.totalRecovered = json['total_d_altes'];
  }
}