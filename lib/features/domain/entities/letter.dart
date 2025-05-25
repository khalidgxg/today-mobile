class Letter {
  final String title;
  final String body;
  // Add other properties as needed, e.g., id, image, etc.

  Letter({
    required this.title,
    required this.body,
  });

  // Add factory constructor for creating an Item from JSON if needed
  factory Letter.fromJson(Map<String, dynamic> json) {
    return Letter(
      title: json['id']?.toString() ?? '', // Convert id to String and provide a default
      body: json['body'] ?? '',   // Provide a default empty string if body is null
      // Initialize other properties here
    );
  }
} 