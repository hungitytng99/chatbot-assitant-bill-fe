import 'package:ihz_bql/generated/l10n.dart';

enum VehicleRegisterType { MONTHLY_TICKET, YEAR_TICKET, OTHER }

extension VehicleRegisterTypeExtension on VehicleRegisterType? {
  static VehicleRegisterType getVehicleRegisterTypeExtension(String? type) {
    if (type == VehicleRegisterType.MONTHLY_TICKET.configType) {
      return VehicleRegisterType.MONTHLY_TICKET;
    } else if (type == VehicleRegisterType.YEAR_TICKET.configType) {
      return VehicleRegisterType.YEAR_TICKET;
    }
    return VehicleRegisterType.YEAR_TICKET;
  }

  static String getVehicleStringExtension(String? type) {
    if (type == VehicleRegisterType.MONTHLY_TICKET.configType) {
      return S.current.vehicleManagement_monthlyTicket;
    } else if (type == VehicleRegisterType.YEAR_TICKET.configType) {
      return S.current.vehicleManagement_yearlyTicket;
    }
    return S.current.vehicleManagement_monthlyTicket;
  }

  static String getVehicleRegisterTypeFromStringExtension(String? string) {
    if (string == S.current.vehicleManagement_monthlyTicket) {
      return VehicleRegisterType.MONTHLY_TICKET.configType;
    } else if (string == S.current.vehicleManagement_yearlyTicket) {
      return VehicleRegisterType.YEAR_TICKET.configType;
    }
    return VehicleRegisterType.MONTHLY_TICKET.configType;
  }

  String get registerType {
    switch (this) {
      case VehicleRegisterType.MONTHLY_TICKET:
        return S.current.vehicleManagement_monthlyTicket;
      case VehicleRegisterType.YEAR_TICKET:
        return S.current.vehicleManagement_yearlyTicket;
      default:
        return S.current.vehicleManagement_monthlyTicket;
    }
  }

  String get type {
    switch (this) {
      case VehicleRegisterType.MONTHLY_TICKET:
        return S.current.vehicleManagement_monthlyTicket;
      case VehicleRegisterType.YEAR_TICKET:
        return S.current.vehicleManagement_yearlyTicket;
      default:
        return S.current.vehicleManagement_monthlyTicket;
    }
  }

  String get configType {
    switch (this) {
      case VehicleRegisterType.MONTHLY_TICKET:
        return "monthly_ticket";
      case VehicleRegisterType.YEAR_TICKET:
        return "year_ticket";
      default:
        return "monthly_ticket";
    }
  }

  static List<String> get listRegisterTypes {
    return [
      S.current.vehicleManagement_monthlyTicket,
      S.current.vehicleManagement_yearlyTicket,
    ];
  }
}
