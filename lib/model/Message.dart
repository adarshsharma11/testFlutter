class Message {
  String message;
  String title;

  Message({this.message, this.title});

  factory Message.fromJson(Map<String, dynamic> json) {
    Message message = Message();
    message.message = json['message'];
    message.title = json['title'];
    return message;
  }
}
