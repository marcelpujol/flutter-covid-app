class GlobalIncidence {
  DateTime date;
  int dailyConfirmed;
  int dailyDeads;
  int dailyRecovered;
  int totalConfirmed;
  int totalDeads;

  GlobalIncidence({
    this.date,
    this.dailyConfirmed,
    this.dailyDeads,
    this.dailyRecovered,
    this.totalConfirmed,
    this.totalDeads
  });

  GlobalIncidence.fromJsonMap(Map<String, dynamic> json) {
    this.date = json['data'] != null 
    ? DateTime.parse(json['data']) 
    : DateTime.now();
    this.dailyConfirmed = json['nous_casos_diaris_confirmats'] != null 
      ? int.parse(json['nous_casos_diaris_confirmats']) 
      : int.parse('0');
    this.dailyDeads = json['defuncions_di_ries'] != null
      ? int.parse(json['defuncions_di_ries']) 
      : int.parse('0');
    this.dailyRecovered = json['altes_di_ries'] != null
      ? int.parse(json['altes_di_ries']) 
      : int.parse('0');
    this.totalConfirmed = json['total_de_casos_confirmats'] != null
      ? int.parse(json['total_de_casos_confirmats']) 
      : int.parse('0');
    this.totalDeads = json['total_de_defuncions'] != null
      ? int.parse(json['total_de_defuncions']) 
      : int.parse('0');
  }
}