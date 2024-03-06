class Program {
  final String id;
  final String name;
  final String description;
  final List<String> courseIds;

  Program({
    required this.id,
    required this.name,
    required this.description,
    required this.courseIds,
  });

  factory Program.fromJson(Map<String, dynamic> json) {
    return Program(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      courseIds: List<String>.from(json['courseIds'] ?? []),
    );
  }
}

class Course {
  final String id;
  final String name;
  final String description;
  final int price;
  final int duration;

  Course({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.duration,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      duration: json['duration'],
    );
  }
   // Add getter for courseIds if needed
  List<String> get courseIds => throw UnimplementedError('Course does not have courseIds property');
}
