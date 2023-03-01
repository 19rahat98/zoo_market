class UserDataEntity {
  int? id;
  String? email;
  bool? isSuperuser;
  bool? isActive;
  bool? isStaff;
  String? phoneNumber;
  bool? phoneVerified;
  String? firstName;
  String? lastName;
  String? gender;
  String? dateOfBirth;
  bool? addPetStatus;
  String? reasonForBlocking;
  dynamic loyaltyLevel;
  bool? isFill;
  bool? blocked;

  UserDataEntity({
    this.id,
    this.email,
    this.isSuperuser,
    this.isActive,
    this.isStaff,
    this.phoneNumber,
    this.phoneVerified,
    this.firstName,
    this.lastName,
    this.gender,
    this.dateOfBirth,
    this.addPetStatus,
    this.reasonForBlocking,
    this.loyaltyLevel,
    this.isFill,
    this.blocked,
  });

  UserDataEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    isSuperuser = json['is_superuser'];
    isActive = json['is_active'];
    isStaff = json['is_staff'];
    phoneNumber = json['phone_number'];
    phoneVerified = json['phone_verified'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    gender = json['gender'];
    dateOfBirth = json['date_of_birth'];
    addPetStatus = json['add_pet_status'];
    reasonForBlocking = json['reason_for_blocking'];
    loyaltyLevel = json['loyalty_level'];
    isFill = json['is_fill'];
    blocked = json['blocked'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['is_superuser'] = isSuperuser;
    data['is_active'] = isActive;
    data['is_staff'] = isStaff;
    data['phone_number'] = phoneNumber;
    data['phone_verified'] = phoneVerified;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['gender'] = gender;
    data['date_of_birth'] = dateOfBirth;
    data['add_pet_status'] = addPetStatus;
    data['reason_for_blocking'] = reasonForBlocking;
    data['loyalty_level'] = loyaltyLevel;
    data['is_fill'] = isFill;
    data['blocked'] = blocked;
    return data;
  }
}
