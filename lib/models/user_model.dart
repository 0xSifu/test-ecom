class User {
  User({
    required this.name,
    required this.email,
    required this.telp,
    required this.ktp,
    required this.dob,
    required this.gender,
    this.profilePictureUrl,
  });

  final String name;
  final String email;
  final String telp;
  final String ktp;
  final String dob;
  final String gender;
  final String? profilePictureUrl;

  User copyWith({
    String? name,
    String? email,
    String? telp,
    String? ktp,
    String? dob,
    String? gender,
    String? profilePictureUrl,
  }) {
    return User(
      name: name ?? this.name,
      email: email ?? this.email,
      telp: telp ?? this.telp,
      ktp: ktp ?? this.ktp,
      dob: dob ?? this.dob,
      gender: gender ?? this.gender,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
    );
  }
}
