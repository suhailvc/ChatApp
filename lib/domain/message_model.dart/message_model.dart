class MessageModel {
  String? messageId;
  String? fromId;
  String? userId;
  String? time;
  String? message;

  MessageModel(
      {this.userId, this.fromId, this.messageId, this.message, this.time});

  MessageModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    fromId = json['fromId'];
    messageId = json['messageId'];
    message = json['message'];

    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['userId'] = userId;
    data['messageId'] = messageId;
    data['message'] = message;

    data['time'] = time;
    return data;
  }
}
