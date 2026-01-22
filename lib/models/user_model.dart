class UserModel {
  final String? id;
  final String? phoneNumber;
  final String? email;
  final String? name;
  final String? photoUrl;
  final String? provider; // 'phone', 'google', 'facebook'

  UserModel({
    this.id,
    this.phoneNumber,
    this.email,
    this.name,
    this.photoUrl,
    this.provider,
  });

  UserModel copyWith({
    String? id,
    String? phoneNumber,
    String? email,
    String? name,
    String? photoUrl,
    String? provider,
  }) {
    return UserModel(
      id: id ?? this.id,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      name: name ?? this.name,
      photoUrl: photoUrl ?? this.photoUrl,
      provider: provider ?? this.provider,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phoneNumber': phoneNumber,
      'email': email,
      'name': name,
      'photoUrl': photoUrl,
      'provider': provider,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      name: json['name'],
      photoUrl: json['photoUrl'],
      provider: json['provider'],
    );
  }
}

