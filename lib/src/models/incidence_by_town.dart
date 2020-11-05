class IncidenceByTown {
  String data;
  String regionCode;
  String regionDescription;
  String townCode;
  String townDescription;
  String genderCode;
  String genderDescription;
  String testCovidResult;
  int totalCases;


  IncidenceByTown({
    this.data,
    this.regionCode,
    this.regionDescription,
    this.townCode,
    this.townDescription,
    this.genderCode,
    this.genderDescription,
    this.testCovidResult,
    this.totalCases
  });

  IncidenceByTown.fromJsonMap(Map<String, dynamic> json) {
    this.data = json['data'];
    this.regionCode = json['comarcacodi'];
    this.regionDescription = json['comarcadescripcio'];
    this.townCode = json['municipicodi'];
    this.townDescription = json['municipidescripcio'];
    this.genderCode = json['sexecodi'];
    this.genderDescription = json['sexedescripcio'];
    this.testCovidResult = json['resultatcoviddescripcio'];
    this.totalCases = int.parse(json['numcasos']);
  }
}