import 'package:flutter/material.dart';
import 'package:login_ui_api_task/utils/design_colors.dart';

class DesignFormField extends StatelessWidget {
  const DesignFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.keyboardType,
    this.maxLines,
    this.minLines,
    this.enabled,
    this.readOnly = false,
  });
  final TextEditingController controller;
  final String hintText;
  final TextInputType? keyboardType;
  final int? maxLines;
  final int? minLines;
  final bool readOnly;
  final bool? enabled;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      enabled: enabled,
      controller: controller,
      validator: (val) {
        if (val == null || val.isEmpty) {
          return "Field Required";
        }
        return null;
      },
      onTapOutside: (event) {
        final currentFocus = FocusScope.of(context);
        if (currentFocus.focusedChild != null) {
          currentFocus.focusedChild!.unfocus();
        }
      },
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        isDense: true,
        fillColor: Colors.transparent,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        contentPadding: const EdgeInsets.all(16),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: DesignColor.prepPruple, width: 1),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: DesignColor.prepPruple, width: 1),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: DesignColor.prepPruple, width: 1.0),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.0),
        ),
      ),
      textCapitalization: TextCapitalization.sentences,
      keyboardType: keyboardType,
      maxLines: maxLines,
      minLines: minLines,
    );
  }
}
