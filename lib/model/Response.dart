class Response {
  String message;
  bool success;
  dynamic value;
  int statusCode;

  Response({this.message, this.success, this.value, this.statusCode});

  set valueModel(dynamic model) => this.value = model;
  dynamic get valueModel => this.value;

  Response.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    success = json['success'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['succeeded'] = this.success;
    data['value'] = this.value != null ? this.value : null;
    data['statusCode'] = this.statusCode;
    return data;
  }
}
