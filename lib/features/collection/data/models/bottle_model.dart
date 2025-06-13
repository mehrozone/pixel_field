class BottleModel {
  final int id;
  final String name;
  final String age;
  final String number;
  final String collection;
  final String status;
  final String image;
  final String bottleIndex;
  final Map<String, String> details;
  final Map<String, String> tastingNotes;
  final String history;
  final List<String> attachments;

  BottleModel({
    required this.id,
    required this.name,
    required this.age,
    required this.number,
    required this.collection,
    required this.status,
    required this.image,
    required this.bottleIndex,
    required this.details,
    required this.tastingNotes,
    required this.history,
    required this.attachments,
  });

  factory BottleModel.fromJson(Map<String, dynamic> json) {
    return BottleModel(
      id: json['id'],
      name: json['name'],
      age: json['age'],
      number: json['number'],
      collection: json['collection'],
      status: json['status'],
      image: json['image'],
      bottleIndex: json['bottleIndex'],
      details: Map<String, String>.from(json['details']),
      tastingNotes: Map<String, String>.from(json['tastingNotes']),
      history: json['history'],
      attachments: List<String>.from(json['attachments']),
    );
  }
}
