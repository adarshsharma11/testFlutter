class NotificationList {
  List<Notifications> notifactions;

  NotificationList({this.notifactions});

  factory NotificationList.fromJson(List<dynamic> parseJson) {
    List<Notifications> notification = List<Notifications>();
    notification = parseJson.map((e) => Notifications.fromJson(e)).toList();
    return NotificationList(notifactions: notification);
  }
}

class Notifications {
  int id;
  String title;

  Notifications(this.id, this.title);

  Notifications.fromJson(Map<String, dynamic> json) {
    this.id = int.parse(json['id']);
    this.title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    return data;
  }
}
