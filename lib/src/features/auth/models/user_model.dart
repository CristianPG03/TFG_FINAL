class UserModel {
  final String id;
  final String name;
  final String email;
  final String password;
  final String biography;
  final String profileImage;
  final List followers;
  final List following;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.biography,
    required this.profileImage,
    required this.followers,
    required this.following
  });

  // Map<String, dynamic> toJson() => {
  //   "id": id,
  //   "name": name,
  //   "email": email,
  //   "password": password,
  //   "biography": biography,
  //   "profileImage": profileImage,
  //   "followers": followers,
  //   "following": following,
  // };

  factory UserModel.fromJson(Map<String, dynamic> json) =>
    UserModel(
      id: json["id"] ?? "",
      name: json["name"],
      email: json["email"],
      password: json["password"],
      biography: json["biography"],
      profileImage: json["profileImage"],
      followers: json["followers"],
      following: json["following"],
    );

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['biography'] = biography;
    data['profileImage'] = profileImage;
    data['followers'] = followers;
    data['following'] = following;

    return data;
  }
}