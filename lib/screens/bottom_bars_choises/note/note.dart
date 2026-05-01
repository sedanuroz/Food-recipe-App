import 'package:flutter/material.dart';

class Note {
  int id;
  String content;
  TextEditingController? controller; // controller nullable olmalı

  Note({
    required this.id,
    required this.content,
    this.controller, // controller opsiyonel
  });

  // Veritabanına kaydedilmek üzere Map'e dönüştürme
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
    };
  }

  // Veritabanından alınan Map'ten Note nesnesine dönüştürme
  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      content: map['content'],
    );
  }
}
