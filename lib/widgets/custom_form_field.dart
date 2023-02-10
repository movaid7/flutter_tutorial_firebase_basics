import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CustomFormField extends HookConsumerWidget {
  const CustomFormField({
    super.key,
    this.keyboardType = TextInputType.text,
    required this.labelText,
    this.maxLines = 1,
    this.isRequired = true,
    this.isPassword = false,
    this.isEmail = false,
    this.isEnabled = true,
    this.centerText = false,
    this.controller,
    this.validator,
    this.keyText,
    this.textInputAction,
    this.onChanged,
    this.fillColor,
    this.labelStyle,
    this.prefixText,
    this.suffixText,
  });

  final TextInputType keyboardType;
  final String labelText;
  final int maxLines;
  final bool isRequired;
  final bool isPassword;
  final bool isEmail;
  final bool isEnabled;
  final bool centerText;

  // nullables
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final String? keyText;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final Color? fillColor;
  final TextStyle? labelStyle;
  final String? prefixText;
  final String? suffixText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showPassword = useState(false);

    return TextFormField(
      enabled: isEnabled,
      cursorHeight: 16.0,
      textAlignVertical: TextAlignVertical.center,
      textAlign: centerText ? TextAlign.center : TextAlign.start,
      key: Key(keyText ?? labelText),
      style: isEnabled
          ? kFormFieldInputTextStyle
          : kFormFieldInputTextStyle.copyWith(color: Colors.black26),
      keyboardType: keyboardType,
      controller: controller,
      maxLines: maxLines,
      obscureText: isPassword ? !showPassword.value : false,
      validator: validator,
      textInputAction: textInputAction,
      onChanged: onChanged,

      // Decorations
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Colors.black12),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
        alignLabelWithHint: true,
        label: Text(labelText),
        labelStyle: labelStyle ?? kFormFieldLabelTextStyle,
        errorStyle: kFormFieldErrorTextStyle,
        filled: true,
        fillColor: fillColor ?? Colors.grey[200],
        prefixText: prefixText,
        suffixText: suffixText,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 18.0),

        // Suffix Icon
        suffixIcon: isPassword
            ? IconButton(
                splashRadius: 0.1,
                icon: Icon(
                  showPassword.value ? Icons.visibility : Icons.visibility_off,
                  color: Colors.black38,
                ),
                onPressed: () {
                  showPassword.value = !showPassword.value;
                },
              )
            : null,
      ),
    );
  }

  // String? pickValidator(String? value) {
  //   if (validator != null) {
  //     return defaultValidator(value);
  //   } else {
  //     return null;
  //   }
  // }
}

TextStyle kFormFieldLabelTextStyle = GoogleFonts.raleway(
  fontSize: 16,
  color: Colors.black45,
  fontWeight: FontWeight.w400,
);
TextStyle kFormFieldInputTextStyle = GoogleFonts.openSans(
  fontSize: 16,
  color: Colors.black87,
  fontWeight: FontWeight.w400,
  height: 1.2,
);

TextStyle kFormFieldErrorTextStyle = GoogleFonts.raleway(
  fontSize: 12,
  color: Colors.red,
  fontWeight: FontWeight.w600,
);

// String? defaultValidator(String? input) {
//   if (input == null || input.isEmpty) {
//     return 'Please enter a value';
//   }
//   return null;
// }
