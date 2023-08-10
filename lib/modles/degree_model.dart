class Degree {
  String? typeDegree, degree, dateDegree,subjectType;
  bool? isSend = false;
  int? v;

  Degree(
      {required this.typeDegree,
      required this.degree,
      required this.dateDegree,
      required this.subjectType,
      this.isSend,
      });

  Degree.fromJson(dynamic json) {
    isSend = json['Is Send'];
    typeDegree = json['Degree Type'];
    subjectType = json['Subject Type'];
    degree = json['Degree'];
    dateDegree = json['Degree Date'];
    v = json['__v'];

  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Is Send'] = isSend;
    map["Degree Type"] = typeDegree;
    map["Subject Type"] = subjectType;
    map["Degree"] = degree;
    map["Degree Date"] = dateDegree;
    map['__v'] = v;

    return map;
  }
}
