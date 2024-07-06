class Tasklist {
  int? id;
  String? task_id;
  String? task_status;
  int? field_engineer_id;
  String? site_id;
  String? task_description;
  String? maintenance_type;
  DateTime? created_at;
  DateTime? updated_at;

  Tasklist({
    this.id,
    this.task_id,
    this.task_status,
    this.field_engineer_id,
    this.site_id,
    this.task_description,
    this.maintenance_type,
    this.created_at,
    this.updated_at,
  });

  factory Tasklist.fromJson(Map<String, dynamic> json) {
    return Tasklist(
      id: json['id'],
      task_id: json['task_id'],
      task_status: json['task_status'],
      field_engineer_id: json['field_engineer_id'],
      site_id: json['site_id'],
      task_description: json['task_description'],
      maintenance_type: json['maintenance_type'],
      created_at: DateTime.parse(json['created_at']),
      updated_at: DateTime.parse(json['updated_at']),
    );
  }
}
