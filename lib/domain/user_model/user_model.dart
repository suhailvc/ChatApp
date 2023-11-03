class UserDetails {
  String? name;
  String? email;
  String? password;
  String? imgpath;
  String? uid;
  String? pushToken;

  UserDetails(
      {this.name,
      this.email,
      this.password,
      this.imgpath,
      this.uid,
      this.pushToken});

  UserDetails.fromJson(Map<String, dynamic> json) {
    name = json['name'];

    email = json['email'];
    password = json['password'];
    imgpath = json['imgpath'];
    uid = json['uid'];

    pushToken = json['pushToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;

    data['email'] = email;
    data['password'] = password;
    data['imgpath'] = imgpath;
    data['uid'] = uid;

    data['pushToken'] = pushToken;
    return data;
  }
}
