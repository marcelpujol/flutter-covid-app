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
    this.dailyConfirmed = int.parse(json['nous_casos_diaris_confirmats']);
    this.dailyDeads = int.parse(json['defuncions_di_ries']);
    this.dailyRecovered = int.parse(json['altes_di_ries']);
    this.totalConfirmed = int.parse(json['total_de_casos_confirmats']);
    this.totalDeads = int.parse(json['total_de_defuncions']);
    this.totalRecovered = int.parse(json['total_d_altes']);
  }
}