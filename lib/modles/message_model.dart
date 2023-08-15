class Message {
  static const String COLLECTION_NAME = 'Messages';

  String messageId;
  String messageContent;
  String teacherIdOfMessage;
  String groupIdOfMessage;
  String stageIdOfMessage;
  int v;

  Message(
      {this.messageId = "",
        required this.messageContent,
        required this.teacherIdOfMessage ,
        required this.groupIdOfMessage ,
        required this.stageIdOfMessage,
        required this.v
        });

  Message.fromJson(Map<String, dynamic> json)
      : this(
    stageIdOfMessage:json['stageIdOfMessage'],
    messageId: json['messageId'],
    messageContent: json['messageContent'],
    teacherIdOfMessage : json['teacherIdOfMessage'],
    groupIdOfMessage : json['groupIdOfMessage'],
      v : json['__v']
  );

  Map<String, dynamic> toJson() {
    return {
      "stageIdOfMessage":stageIdOfMessage,
      "messageId": messageId,
      "messageContent": messageContent,
      'teacherIdOfMessage':teacherIdOfMessage,
      'groupIdOfMessage':groupIdOfMessage,
      '__v':v,
    };
  }
}