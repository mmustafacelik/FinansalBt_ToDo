class Task {
  final int? id;
  final String? title;

  Task({
    this.id,
    this.title
  });

  // Convert a Task into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
    };
  }
}