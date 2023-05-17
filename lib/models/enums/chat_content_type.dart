enum ChatContentType {
  text,
  question,
}

extension ChatContentTypeExtension on ChatContentType {
  String get getType {
    switch (this) {
      case ChatContentType.text:
        return 'text';
      case ChatContentType.question:
        return 'question';
    }
  }
}
