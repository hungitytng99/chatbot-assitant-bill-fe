enum ChatActorType {
  user,
  bot,
  system,
}

extension ChatActorTypeExtension on ChatActorType {
  String get getActor {
    switch (this) {
      case ChatActorType.user:
        return 'user';
      case ChatActorType.bot:
        return 'bot';
      case ChatActorType.system:
        return 'system';
    }
  }
}
