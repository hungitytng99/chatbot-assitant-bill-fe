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

class AppPasswordInput extends StatefulWidget {
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
  State<StatefulWidget> createState() {
    return _AppPasswordInputState();
  }
}

class _AppPasswordInputState extends State<AppPasswordInput> {
  bool _obscuredText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            ValueListenableBuilder(
              valueListenable: widget.obscureTextController,
              child: Container(),
              builder: (context, bool obscureText, child) {
                return AppLabelTextField(
                  labelText: widget.labelText ?? S.of(context).common_password,
                  controller: widget.textEditingController,
                  onChanged: widget.onChanged,
                  isRequire: widget.isRequire,
                  keyboardType: TextInputType.emailAddress,
                  validator: (text) {
                    if (ValidatorUtils.validatePassword(text ?? "")) {
                      return "";
                    } else if (text!.isEmpty) {
                      return '';
                    } else {
                      return S.current.common_validatorNumberCharacter;
                    }
                  },
                  obscureText: _obscuredText,
                  suffixIcon: GestureDetector(
                    onTap: _toggle,
                    child: Container(
                      height: 34,
                      width: 38,
                      alignment: Alignment.centerRight,
                      child: _obscuredText
                          ? Image.asset(
                              'assets/images/ic_eye_close.png',
                              fit: BoxFit.fitWidth,
                              width: 18,
                              height: 24,
                            )
                          : Image.asset(
                              'assets/images/ic_eye_open.png',
                              fit: BoxFit.fitWidth,
                              width: 18,
                              height: 24,
                            ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  _toggle() {
    setState(() {
      _obscuredText = !_obscuredText;
    });
  }
}
