import 'package:flutter/material.dart';
import 'package:tandrustito/views/home.dart';

class GeneralButton extends StatelessWidget {
  const GeneralButton({
    Key? key,
    required this.text,
    this.fontSize,
    this.txtColor,
    required this.onTap,
    this.color,
    this.borderWidth,
    this.icon,
    this.iconColor,
    this.iconSize,
    this.padding,
    this.width = 374,
    this.textHeight,
    this.radius = 15,
    this.border = false,
  }) : super(key: key);
  final bool? border;
  final String text;
  final String? icon;
  final VoidCallback onTap;
  final Color? color;
  final Color? iconColor;
  final Color? txtColor;
  final double? fontSize;
  final double? iconSize;
  final double? width;
  final double? radius;
  final EdgeInsets? padding;
  final double? borderWidth;
  final double? textHeight;

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ButtonStyle(
        // shadowColor: MaterialStateProperty.all<Color>(
        //     context.buttonColor ?? AppColor.buttonColor),
        backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius ?? 45.0),
                side: border == true
                    ? const BorderSide(color: primaryColor)
                    : BorderSide.none)),
        padding: MaterialStateProperty.all<EdgeInsets>(padding ??
            const EdgeInsets.symmetric(vertical: 12, horizontal: 15)));

    return SizedBox(
        width: width,
        child: ElevatedButton(
            onPressed: onTap,
            style: style,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(text,
                    maxLines: 1,
                    style: TextStyle(
                        height: textHeight,
                        color: txtColor,
                        fontSize: fontSize ?? 18),
                    overflow: TextOverflow.ellipsis),
              ],
            )));
  }
}
