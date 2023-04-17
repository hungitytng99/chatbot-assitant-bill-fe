enum RequestStatus {
  create,
  processing,
  processed,
}

extension RequestStatusExtension on RequestStatus {
  String get exploitStatus {
    switch (this) {
      case RequestStatus.create:
        return 'new,assign';
      case RequestStatus.processing:
        return 'processing';
      case RequestStatus.processed:
        return 'done,customer_closed_ticket';
    }
  }
}