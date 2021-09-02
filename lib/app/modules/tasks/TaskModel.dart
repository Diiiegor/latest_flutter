import 'dart:convert';

TaskModel taskModelFromJson(String str) => TaskModel.fromJson(json.decode(str));

String taskModelToJson(TaskModel data) => json.encode(data.toJson());

List<TaskModel> taskFromJsonList(List<Map<String, dynamic>> list) {
  return list.map((item) => TaskModel.fromJson(item)).toList();
}

class TaskModel {
  TaskModel({
    this.id,
    required this.description,
    required this.done,
  });

  int? id;
  String description;
  int done;

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        id: json["id"],
        description: json["description"],
        done: json["done"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "done": done,
      };
}
