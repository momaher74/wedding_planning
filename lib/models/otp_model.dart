class OTPModel {
  final String phoneNumber;
  final String? code;
  final bool isVerified;

  OTPModel({
    required this.phoneNumber,
    this.code,
    this.isVerified = false,
  });

  OTPModel copyWith({
    String? phoneNumber,
    String? code,
    bool? isVerified,
  }) {
    return OTPModel(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      code: code ?? this.code,
      isVerified: isVerified ?? this.isVerified,
    );
  }

  bool get isValidCode => code != null && code!.length == 6;

  Map<String, dynamic> toJson() {
    return {
      'phoneNumber': phoneNumber,
      'code': code,
      'isVerified': isVerified,
    };
  }

  factory OTPModel.fromJson(Map<String, dynamic> json) {
    return OTPModel(
      phoneNumber: json['phoneNumber'],
      code: json['code'],
      isVerified: json['isVerified'] ?? false,
    );
  }
}

