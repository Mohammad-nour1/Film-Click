class Video {
  final String type;
  final String key;

  Video({required this.type, required this.key});

  factory Video.fromMap(Map<String, dynamic> map) {
    return Video(
      type: map['type'] ?? '', // Adjust according to actual response
      key: map['key'] ?? '',   // Adjust according to actual response
    );
  }
}
