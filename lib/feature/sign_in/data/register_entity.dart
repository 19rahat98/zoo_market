class RegisterEntity {
  Data? data;
  Tokens? tokens;
  bool? status;

  RegisterEntity({
    this.data,
    this.tokens,
    this.status,
  });

  RegisterEntity.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    tokens = json['tokens'] != null ? Tokens.fromJson(json['tokens']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (tokens != null) {
      data['tokens'] = tokens!.toJson();
    }
    data['status'] = status;
    return data;
  }
}

class Data {
  int? id;
  String? email;
  String? name;
  String? type;
  String? provider;
  bool? isFill;

  Data({
    this.id,
    this.email,
    this.name,
    this.type,
    this.provider,
    this.isFill,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    type = json['type'];
    provider = json['provider'];
    isFill = json['is_fill'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['name'] = name;
    data['type'] = type;
    data['provider'] = provider;
    data['is_fill'] = isFill;
    return data;
  }
}

class Tokens {
  String? access;
  String? refresh;

  Tokens({this.access, this.refresh});

  Tokens.fromJson(Map<String, dynamic> json) {
    access = json['access'];
    refresh = json['refresh'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access'] = access;
    data['refresh'] = refresh;
    return data;
  }
}
