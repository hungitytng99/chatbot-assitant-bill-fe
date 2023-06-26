enum ChatEventType {
  text,
  recommend,
  select,
}

extension ChatEventTypeExtension on ChatEventType {
  String get getString {
    switch (this) {
      case ChatEventType.text:
        return 'text';
      case ChatEventType.recommend:
        return 'recommend';
      case ChatEventType.select:
        return 'select';
    }
  }
}
