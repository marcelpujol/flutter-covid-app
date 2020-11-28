class PreventionInfo {
  String title;
  String description;
  String iconPath;
  String content;

  PreventionInfo({
    this.title,
    this.description,
    this.iconPath,
    this.content
  });

  PreventionInfo.fromJsonMap(Map<String, dynamic> json) {
    this.title = json['title'];
    this.description = json['description'];
    this.iconPath = json['icon'];
    this.content = json['content'];
  }
}