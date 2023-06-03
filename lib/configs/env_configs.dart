enum Environment {
  dev,
  stg,
  th,
  prod,
}

extension EnvironmentExt on Environment {
  String get envName {
    switch (this) {
      case Environment.dev:
        return 'LOCAL';
      case Environment.stg:
        return 'STAGING';
      case Environment.th:
        return 'TH';
      case Environment.prod:
        return 'PROD';
    }
  }

  String get baseUrl {
    switch (this) {
      case Environment.dev:
        return 'http://35.185.176.26:8088/';
      case Environment.stg:
        return 'http://35.185.176.26:8088/';
      case Environment.th:
        return 'http://35.185.176.26:8088/';
      case Environment.prod:
        return 'http://35.185.176.26:8088/';
    }
  }

  String get baseSocketUrl {
    switch (this) {
      case Environment.dev:
        return 'http://194.163.178.42:68/';
      //  return 'ws://dxg.newwave.vn:15674/ws';
      case Environment.stg:
        return 'wss://stagingwss.realagent.vn/ws';
      case Environment.th:
        return 'wss://th-wss.realagent.vn/ws';
      case Environment.prod:
        return 'wss://wss.realagent.vn/ws';
    }
  }

  String get baseSocketIOUrl {
    switch (this) {
      case Environment.dev:
        return 'http://194.163.178.42:68/';
      case Environment.stg:
        return 'wss://apistaging.realagent.vn/msx-property/socket.io/?EIO=3&transport=websocket';
      case Environment.th:
        return 'wss://th-api.realagent.vn/msx-property/socket.io/?EIO=3&transport=websocket';
      case Environment.prod:
        return 'wss://api.realagent.vn/msx-property/socket.io/?EIO=3&transport=websocket';
    }
  }
}
