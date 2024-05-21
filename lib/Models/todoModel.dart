
import 'dart:convert';

class TodoModel {
    String title;
    String dec;
    String id;

    TodoModel({
        required this.title,
        required this.dec,
        required this.id,
    });

    factory TodoModel.fromRawJson(String str) => TodoModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
        title: json["todotitle"],
        dec: json["dec"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "todotitle": title,
        "dec": dec,
        "id": id,
    };
}