class Album {
  final String role, name, association_name, phone;

//  final String title;

  Album(
      {required this.role,
      required this.name,
      required this.association_name,
      required this.phone
      // required this.title,
      });

  factory Album.fromJson(Map<String, dynamic> json) {
    print("json data $json");
    return Album(
        name: json['name'] as String,
        role: json['role'] as String,
        association_name: json['community_name'] as String,
        phone: json['phone'] as String
        // title: json['title'] as String,
        );
  }
}
