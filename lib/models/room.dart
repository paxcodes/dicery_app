class Room {
  final String code;
  final String owner;
  final bool isAvailable;

  Room.fromJson(Map<String, dynamic> json)
      : code = json['code'],
        owner = json['owner'],
        isAvailable = json['isAvailable'];

  Map<String, dynamic> toJson() =>
      {'code': code, 'owner': owner, 'isAvailable': isAvailable};
}
