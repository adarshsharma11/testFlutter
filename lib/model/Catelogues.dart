class CateloguesList {
  List<Catelogue> catelogues;

  CateloguesList({this.catelogues});

  factory CateloguesList.fromJson(List<dynamic> parseJson) {
    List<Catelogue> catelogue = List<Catelogue>();
    catelogue = parseJson.map((e) => Catelogue.fromJson(e)).toList();
    return CateloguesList(catelogues: catelogue);
  }
}

class Catelogue {
  String name;
  String pdf_name;

  Catelogue(this.name, this.pdf_name);

  Catelogue.fromJson(Map<String, dynamic> json) {
    this.name = json['name'];
    this.pdf_name = json['pdf_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['pdf_name'] = this.pdf_name;
    return data;
  }
}
