class DataItems {
  final String id;
  final String name;
  final bool completed;

  DataItems({required this.id, required this.name, this.completed = false});

  // Chuyển object thành map
  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'completed': completed};

  // Tạo object từ map
  factory DataItems.fromJson(Map<String, dynamic> json) {
    return DataItems(
      id: json['id'],
      name: json['name'],
      completed: json['completed'] ?? false,
    );
  }
}
