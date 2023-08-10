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
    stageIdOfMessage:json['Stage Id Of Message'],
    messageId: json['Message Id'],
    messageContent: json['Message Content'],
    teacherIdOfMessage : json['Teacher Id Of Message'],
    groupIdOfMessage : json['Group Id Of Message'],
      v : json['__v']
  );

  Map<String, dynamic> toJson() {
    return {
      "Stage Id Of Message":stageIdOfMessage,
      "Message Id": messageId,
      "Message Content": messageContent,
      'Teacher Id Of Message':teacherIdOfMessage,
      'Group Id Of Message':groupIdOfMessage,
      '__v':v,
    };
  }
}