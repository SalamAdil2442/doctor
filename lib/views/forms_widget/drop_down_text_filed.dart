import 'package:flutter/material.dart';
import 'package:tandrustito/views/home.dart';

class GeneralDropDownTextFiled<T> extends StatelessWidget {
  final TextInputType textInputType;
  final String? Function(T?)? validate;
  final Widget? prefixIcon;
  final Widget? subfixIcon;
  final List<T> list;
  final Function(T) getVal;
  final Function(T)? getLabel;
  final T? value;
  final double rad;
  final double height;
  final Color? labelColor;
  final bool? viewBorder;
  final Color? textColor;
  final Color? fillColor;
  final Color? borderColor;
  final String? hintText;
  final EdgeInsetsGeometry? contentPadding;
  final AutovalidateMode autovalidateMode;
  final int maxLines;
  final bool? isDense;
  final bool? readOnly;
  final bool showLabel;
  final Function()? onTap;
  final Function(T?)? onChange;
  const GeneralDropDownTextFiled(
      {Key? key,
      required this.list,
      required this.getVal,
      this.showLabel = true,
      this.viewBorder = false,
      this.height = 1,
      this.getLabel,
      this.readOnly = false,
      this.contentPadding,
      this.isDense,
      this.rad = 10,
      this.borderColor,
      this.textInputType = TextInputType.text,
      required this.onChange,
      this.autovalidateMode = AutovalidateMode.onUserInteraction,
      this.onTap,
      this.labelColor,
      this.fillColor,
      this.textColor,
      this.value,
      this.maxLines = 1,
      this.validate,
      this.subfixIcon,
      this.prefixIcon,
      this.hintText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Theme(
      data: Theme.of(context).copyWith(platform: TargetPlatform.android),
      child: Row(
        children: [
          Expanded(
            child: list.isNotEmpty || value == null
                ? DropdownButtonFormField<T>(
                    items: list.map((T category) {
                      return DropdownMenuItem(
                          value: category,
                          child: Text(
                              '${getLabel != null ? getLabel!(category) : getVal(category)}'));
                    }).toList(),
                    onChanged: onChange,
                    style: TextStyle(
                        height: height,
                        color: textColor ?? theme.textTheme.bodyLarge?.color,
                        fontSize: 17),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: validate,
                    value: value,
                    decoration: InputDecoration(
                      suffixIcon: subfixIcon,
                      prefixIcon: prefixIcon,
                      enabled: readOnly ?? true,
                      isDense: isDense,
                      contentPadding: contentPadding ??
                          const EdgeInsets.fromLTRB(15, 15, 15, 15),
                      fillColor: fillColor ?? openColor,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(rad),
                          borderSide: BorderSide(
                              color: viewBorder == false
                                  ? Colors.transparent
                                  : primaryColor)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(rad),
                          borderSide: BorderSide(
                              color: viewBorder == false
                                  ? Colors.transparent
                                  : const Color(0XFFFB6340))),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(rad),
                          borderSide: BorderSide(
                              color: viewBorder == false
                                  ? Colors.transparent
                                  : primaryColor)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(rad),
                          borderSide: BorderSide(
                              color: borderColor ?? const Color(0XFFFB6340))),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(rad),
                          borderSide: BorderSide(
                              color: viewBorder == false
                                  ? Colors.transparent
                                  : primaryColor)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: viewBorder == false
                                ? Colors.transparent
                                : primaryColor),
                        borderRadius: BorderRadius.circular(rad),
                      ),
                      labelText: showLabel == true ? hintText : null,
                      labelStyle: TextStyle(
                          fontFamily: '',
                          fontSize: 17,
                          color: labelColor ?? primaryColor),
                      errorStyle: const TextStyle(
                          fontFamily: '', color: Color(0XFFFB6340)),
                      hintText: showLabel == false ? '$hintText' : null,
                      hintStyle: TextStyle(
                          color: labelColor ?? primaryColor, fontSize: 17),
                    ),
                  )
                : Container(
                    child: Text('No items available'),
                  ),
          ),
        ],
      ),
    );
  }
}
