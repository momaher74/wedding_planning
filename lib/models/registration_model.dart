class RegistrationModel {
  final String? fullName;
  final String? email;
  final String? phoneNumber;

  RegistrationModel({
    this.fullName,
    this.email,
    this.phoneNumber,
  });

  RegistrationModel copyWith({
    String? fullName,
    String? email,
    String? phoneNumber,
  }) {
    return RegistrationModel(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  bool get isValid {
    return fullName != null &&
        fullName!.isNotEmpty &&
        email != null &&
        email!.isNotEmpty &&
        phoneNumber != null &&
        phoneNumber!.isNotEmpty;
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
    };
  }

  factory RegistrationModel.fromJson(Map<String, dynamic> json) {
    return RegistrationModel(
      fullName: json['fullName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
    );
  }
}

