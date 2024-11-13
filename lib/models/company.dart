class Company {
  final String name;
  final String catchPhrase;
  String? bs;

  Company({
    required this.name,
    required this.catchPhrase,
    this.bs, // optional field
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      name: json['name'],
      catchPhrase: json['catchPhrase'],
      bs: json['bs'], // optional field
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'catchPhrase': catchPhrase,
      'bs': bs, // optional field
    };
  }
}