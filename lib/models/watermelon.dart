
class Watermelon {
  final String name;
  final String size;
  final String juicyness;
  final String symmetry;
  final String freshness;

  Watermelon({required this.name, required this.size,  required this.juicyness,  required this.symmetry,  required this.freshness});

  factory Watermelon.fromJson(Map<String, dynamic> json) {
    return Watermelon(
      name: json['name'],
      size: json['size'],
      juicyness: json['juicyness'],
      symmetry: json['symmetry'],
      freshness: json['freshness'],
  );
  }
}
