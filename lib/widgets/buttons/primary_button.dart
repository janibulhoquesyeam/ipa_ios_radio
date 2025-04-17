import 'package:dynamic_languages/dynamic_languages.dart';

import '../../../utils/basic_screen_imports.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.borderColor,
    this.borderWidth = 0,
    this.height,
    this.radius,
    this.buttonColor,
    this.buttonTextColor,
    this.shape,
    this.icon,
    this.fontSize,
    this.isExpanded = false,
    this.flex = 1,
    this.fontWeight,
    this.elevation,
  });

  final String title;
  final VoidCallback onPressed;
  final Color? borderColor;
  final double borderWidth;
  final double? height;
  final double? radius;
  final double? elevation;
  final int flex;
  final Color? buttonColor;
  final Color? buttonTextColor;
  final OutlinedBorder? shape;
  final Widget? icon;
  final bool isExpanded;
  final double? fontSize;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return isExpanded
        ? Expanded(
            flex: flex,
            child: _buildButton(context),
          )
        : _buildButton(context);
  }

  Widget _buildButton(BuildContext context) {
    return SizedBox(
      height: height ?? Dimensions.buttonHeight * 0.78,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: elevation,
          shape: shape ??
              RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(radius ?? Dimensions.radius * 0.7)),
          backgroundColor: buttonColor ?? Theme.of(context).primaryColor,
          side: BorderSide(
            width: borderWidth,
            color: borderColor ?? Theme.of(context).primaryColor,
          ),
        ),
        child: Row(
          mainAxisAlignment: mainCenter,
          children: [
            if (icon != null) icon!,
            Text(
              DynamicLanguage.isLoading ? "": DynamicLanguage.key(title),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: CustomStyle.darkHeading4TextStyle.copyWith(
                fontSize: fontSize ?? Dimensions.headingTextSize4,
                fontWeight: fontWeight ?? FontWeight.w600,
                color: buttonTextColor ??
                    (Get.isDarkMode
                        ? CustomColor.blackColor
                        : CustomColor.whiteColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}