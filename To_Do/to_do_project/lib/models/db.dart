abstract class DatabaseModel {
  final int? id;
  DatabaseModel({
    this.id
  });
  Map<String, dynamic> toMap();
}