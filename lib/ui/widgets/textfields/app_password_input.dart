import 'package:flutter/material.dart';
import 'package:ihz_bql/generated/l10n.dart';
import 'package:ihz_bql/ui/widgets/textfields/app_label_text_field.dart';
import 'package:ihz_bql/utils/validator_utils.dart';

class ObscureTextController extends ValueNotifier<bool> {
  ObscureTextController({bool obscureText = true}) : super(obscureText);

  bool get date => value;

  set date(bool obscureText) {
    value = obscureText;
  }
}

class AppPasswordInput extends StatelessWidget {
  final String? labelText;
  final ObscureTextController obscureTextController;
  final TextEditingController textEditingController;
  final ValueChanged<String>? onChanged;
  final FormFieldSetter<String>? onSaved;
  final FocusNode? passwordFocusNode;
  final bool isRequire;

  const AppPasswordInput({
    Key? key,
    this.labelText,
    required this.obscureTextController,
    required this.textEditingController,
    this.onChanged,
    this.onSaved,
    this.isRequire = false,
    this.passwordFocusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            ValueListenableBuilder(
              valueListenable: obscureTextController,
              child: Container(),
              builder: (context, bool obscureText, child) {
                return AppLabelTextField(
                  labelText: labelText ?? S.of(context).common_password,
                  controller: textEditingController,
                  onChanged: onChanged,
                  isRequire: isRequire,
                  keyboardType: TextInputType.emailAddress,
                  validator: (text){
                    if (ValidatorUtils.validatePassword(text ?? "")) {
                      return "";
                    } else if (text!.isEmpty) {
                      return '';
                    } else {
                      return S.current.common_validatorNumberCharacter;
                    }
                  },
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
