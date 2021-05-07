class User {
  String id;
  String name;
  String email;
  String emailVerifiedAt;
  String createdAt;
  String updatedAt;
  String username;
  String phoneNumber;
  String avatar;

  User(
      {String id,
      String name,
      String email,
      String emailVerifiedAt,
      String createdAt,
      String updatedAt,
      String username,
      String phoneNumber,
      String avatar}) {
    this.id = id;
    this.name = name;
    this.email = email;
    this.emailVerifiedAt = emailVerifiedAt;
    this.createdAt = createdAt;
    this.updatedAt = updatedAt;
    this.username = username;
    this.phoneNumber = phoneNumber;
    this.avatar = avatar;
  }

  User.fromJson(Map<String, dynamic> json) {
    print("1111");
    id = json['id'].toString();
    print(json['id'].toString());
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    username = json['username'];
    phoneNumber = json['phone_number'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['username'] = this.username;
    data['phone_number'] = this.phoneNumber;
    data['avatar'] = this.avatar;
    return data;
  }
}
