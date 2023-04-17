class ValidatorUtils {
  ValidatorUtils._();

  static String? validateEmptyField(String? value) {
    print(value);
    if (value == null || value.trim().isEmpty) {
      return "Thông tin bị thiếu. Vui lòng cập nhật";
    } else {
      return null;
    }
  }

  static bool validateEmail(String email) => RegExp(
          r"^(([^<>()[\]\\.,;:\s@\']+(\.[^<>()[\]\\.,;:\s@\']+)*)|(\'.+\'))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$")
      .hasMatch(email);

  static bool validatePhone(String phone) =>
      RegExp(r"^(03|05|07|08|09|01)+([0-9]{8})$").hasMatch(phone);

  static bool validateVietnamesePhone(String phone) =>
      RegExp(r"^(((\+84|84|0){1})(3|5|7|8|9|1[2|6|8|9]))+([0-9]{8})$")
          .hasMatch(phone);

  // TODO: Change this
  static bool validateIdentityCode(String identityCode) {
    return RegExp(r"^\+?[0-9]{6,12}$").hasMatch(identityCode);
  }

  // TODO: Change this
  /// Ít nhất 8 kí tự.
  /// Ít nhất 1 letter và 1 số
  static bool validatePassword(String password) {
    return RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$')
        .hasMatch(password);
  }

  static bool validate0to9Character(String string) {
    return RegExp(r"^(?=.*?[0-9])$").hasMatch(string);
  }

  static bool isEmptyOrNull(String text) {
    if (text == null) {
      return true;
    }
    return text.isEmpty;
  }

  static String? getLinkFromText(String text) => RegExp(
          r'https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&\/=]*)')
      .stringMatch(text);

  static bool validatorOnlyText(String string) {
    return RegExp(
            r"^[a-zA-Z_ÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚĂĐĨŨƠàáâãèéêìíòóôõùúăđĩũơƯĂẠẢẤẦẨẪẬẮẰẲẴẶẸẺẼỀỀỂưăạảấầẩẫậắằẳẵặẹẻẽếềểỄỆỈỊỌỎỐỒỔỖỘỚỜỞỠỢỤỦỨỪễệỉịọỏốồổỗộớờởỡợụủứừỬỮỰỲỴÝỶỸửữựỳỵýỷỹ ]{1,256}$")
        .hasMatch(string.trim());
  }
}
