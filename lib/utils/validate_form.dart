mixin ValidateForm {
  final RegExp emailRegex = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  final RegExp phoneNumberRegex = RegExp(r'^(0)[0-9]{9}$');
  String? phoneNumberValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Không được để trống';
    } else if (!phoneNumberRegex.hasMatch(value)) {
      return 'Số điện thoại này không đúng';
    }
    return null;
  }

  String? requiredValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Không được để trống';
    } else if (value is String) {
      return value.trim().isEmpty ? 'Không được để trống' : null;
    }
    return null;
  }

  String? emailValidator(String? value) {
    return (value == null ||
            value.toString().isEmpty ||
            emailRegex.hasMatch(value.toString()))
        ? null
        : 'Email không khả dụng';
  }
}
