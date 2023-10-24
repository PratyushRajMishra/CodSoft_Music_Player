class UserModel {
  String? uid;
  String? firstname;
  String? lastname;
  String? about;
  String? mobile;
  String? email;
  String? profilepic;


  UserModel({
    this.uid,
    this.firstname,
    this.lastname,
    this.email,
    this.profilepic,
    this.mobile,
    this.about,});


  UserModel.fromMap(Map<String, dynamic> map) {
    uid = map["uid"];
    firstname = map["firstname"];
    lastname = map["lastname"];
    email = map["email"];
    profilepic = map["profilepic"];
    about = map["about"];
    mobile = map["mobile"];

  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "firstname": firstname,
      "lastname": lastname,
      "about": about,
      "mobile": mobile,
      "email": email,
      "profilepic": profilepic,
    };
  }
}