class User {
  String id;
  String email;
  String username;
  User({this.email, this.username, this.id});

  User.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        username = json['username'],
        email = json['email'];
}
