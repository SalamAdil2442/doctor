import 'dart:convert';

class MessageModel {
  final String text;
  final String senderId;
  final DateTime date;
  MessageModel({
    required this.text,
    required this.senderId,
    required this.date,
  });
  
 

  MessageModel copyWith({
    String? text,
    String? senderId,
    DateTime? date,
  }) {
    return MessageModel(
      text: text ?? this.text,
      senderId: senderId ?? this.senderId,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'senderId': senderId,
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      text: map['text'] ?? '',
      senderId: map['senderId'] ?? '',
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) => MessageModel.fromMap(json.decode(source));

  @override
  String toString() => 'MessageModel(text: $text, senderId: $senderId, date: $date)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is MessageModel &&
      other.text == text &&
      other.senderId == senderId &&
      other.date == date;
  }

  @override
  int get hashCode => text.hashCode ^ senderId.hashCode ^ date.hashCode;
}
