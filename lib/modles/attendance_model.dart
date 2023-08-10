class Attendance{
  String? lessonDate;
  String? sessionType;
  bool? isAttend = false;
  int? v;
  Attendance({required this.lessonDate,this.isAttend,this.sessionType});
  Attendance.fromJson( dynamic json){
    isAttend= json['Is Attend'];
    sessionType= json['Session Type'];
    lessonDate= json['Lesson Date'];
    v = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Is Attend']=isAttend;
    map['Session Type']= sessionType;
    map["Lesson Date"]= lessonDate;
    map['__v'] = v;
    return map;
  }
}