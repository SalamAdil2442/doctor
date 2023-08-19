import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart' as intl;
import 'package:tandrustito/core/shared/imports.dart';
import 'package:tandrustito/core/shared/theme_lang_notifier.dart';
import 'package:tandrustito/views/home.dart';

class GeneralTextFiled extends StatefulWidget {
  final TextEditingController? controller;
  final TextInputType textInputType;
  final String? Function(String?)? validate;
  final Widget? prefixIcon;
  final Widget? subfixIcon;
  final EdgeInsetsGeometry? contentPadding;
  final String? hintText;
  final AutovalidateMode autovalidateMode;
  final int? maxLines;
  final double raduis;
  final bool readOnly;
  final bool viewBorder;
  final Color? fillColor;
  final List<TextInputFormatter> inputFormatters;
  final bool showLabel;
  final bool obscureText;
  final bool enable;
  final Function()? onTap;
  final Function(String?)? onChange;
  final FocusNode? focusNode;
  final void Function(String?)? onSubmit;
  const GeneralTextFiled(
      {Key? key,
      this.controller,
      this.inputFormatters = const [],
      this.showLabel = false,
      this.raduis = 10,
      this.viewBorder = false,
      this.enable = true,
      this.textInputType = TextInputType.text,
      this.onChange,
      this.fillColor,
      this.contentPadding,
      this.onSubmit,
      this.readOnly = false,
      this.obscureText = false,
      this.focusNode,
      this.autovalidateMode = AutovalidateMode.onUserInteraction,
      this.onTap,
      this.maxLines = 1,
      this.validate,
      this.subfixIcon,
      this.prefixIcon,
      this.hintText})
      : super(key: key);

  @override
  State<GeneralTextFiled> createState() => _GeneralTextFiledState();
}

class _GeneralTextFiledState extends State<GeneralTextFiled> {
  TextDirection textDirection = ThemeLangNotifier.instance.isEn == false
      ? TextDirection.rtl
      : TextDirection.ltr;
  change(String? str) {
    if (checkIsNull(str)) {
      textDirection = ThemeLangNotifier.instance.isEn == false
          ? TextDirection.rtl
          : TextDirection.ltr;
      setState(() {});
      return;
    }
    log("str $str ${isRTL(str ?? "")}");
    TextDirection temptextDirection =
        isRTL(str ?? "") ? TextDirection.rtl : TextDirection.ltr;
    if (textDirection != temptextDirection) {
      textDirection = temptextDirection;
      setState(() {});
    }
  }

  bool isRTL(String text) {
    return intl.Bidi.detectRtlDirectionality(text);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    log("textDirection $textDirection");

    return Theme(
        data: Theme.of(context).copyWith(platform: TargetPlatform.android),
        child: Row(children: [
          Expanded(
              child: TextFormField(
                  controller: widget.controller,
                  onChanged: (String? str) {
                    change(str);
                    widget.onChange?.call(str);
                  },
                  focusNode: widget.focusNode,
                  enabled: widget.enable,
                  onSaved: widget.onSubmit,
                  onFieldSubmitted: widget.onSubmit,
                  inputFormatters: widget.inputFormatters,
                  keyboardType: widget.textInputType,
                  maxLines: widget.maxLines,
                  textDirection: textDirection,
                  style: TextStyle(
                      height: 1.3,
                      color: theme.textTheme.bodyLarge?.color,
                      fontSize: 20),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: widget.validate,
                  readOnly: widget.readOnly,
                  obscureText: widget.obscureText,
                  onTap: widget.onTap,
                  decoration: InputDecoration(
                    filled: true,
                    suffixIcon: widget.subfixIcon,
                    prefixIcon: widget.prefixIcon,
                    contentPadding: widget.contentPadding ??
                        const EdgeInsets.fromLTRB(15, 5, 15, 5),
                    fillColor: widget.fillColor ?? openColor,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(widget.raduis),
                        borderSide: BorderSide(
                            color: widget.viewBorder == false
                                ? Colors.transparent
                                : primaryColor)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(widget.raduis),
                        borderSide: BorderSide(
                            color: widget.viewBorder == false
                                ? Colors.transparent
                                : Theme.of(context).primaryColor)),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(widget.raduis),
                        borderSide: BorderSide(
                            color: widget.viewBorder == false
                                ? Colors.transparent
                                : const Color(0XFFFB6340))),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(widget.raduis),
                        borderSide: BorderSide(
                            color: widget.viewBorder == false
                                ? Colors.transparent
                                : const Color(0XFFFB6340))),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(widget.raduis),
                        borderSide: BorderSide(
                            color: widget.viewBorder == false
                                ? Colors.transparent
                                : Colors.grey)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: widget.viewBorder == false
                              ? Colors.transparent
                              : primaryColor),
                      borderRadius: BorderRadius.circular(widget.raduis),
                    ),
                    labelText:
                        widget.showLabel == true ? '${widget.hintText}' : null,
                    labelStyle: const TextStyle(
                        fontFamily: '', fontSize: 15, color: primaryColor),
                    errorStyle: const TextStyle(
                        fontFamily: '', color: Color(0XFFFB6340)),
                    hintText:
                        widget.showLabel == false ? '${widget.hintText}' : null,
                    hintStyle:
                        const TextStyle(color: Colors.black45, fontSize: 16),
                  )))
        ]));
  }
}
