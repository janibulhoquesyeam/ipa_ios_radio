import 'package:dynamic_languages/dynamic_languages.dart';
import 'package:flutter/services.dart';
import '../../../utils/basic_screen_imports.dart';
import '../others/custom_image_widget.dart';

enum BSS {
  enabledBorder,
  b,
  disableBorder,
  focusedBorder,
  errorBorder,
  focusedErrorBorder
}

enum BorderStyle {
  outline,
  underline,
  none,
}

class PrimaryInputWidget extends StatefulWidget {
  final String hintText, label, phoneCode;
  final String? optionalLabel;
  final String? prefixIconPath;
  final String? suffixIconPath;
  final int maxLines;
  final bool isValidator;
  final bool isPasswordField;
  final bool autoFocus;
  final bool readOnly;
  final bool isFilled;
  final bool showBorderSide;
  final bool validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double? padding;
  final double? radius;
  final double borderWidth;
  final Color? fillColor;
  final Color? shadowColor;
  final Color? suffixIconColor;
  final Decoration? customShapeDecoration;
  final EdgeInsetsGeometry? customPadding;
  final TextEditingController controller;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? inputFormatters;
  final AlignmentGeometry? alignment;
  final BorderStyle borderStyle;

  const PrimaryInputWidget({
    super.key,
    required this.controller,
    required this.hintText,
    this.prefixIconPath = "",
    this.suffixIconPath = "",
    this.phoneCode = "",
    this.isValidator = true,
    this.isPasswordField = false,
    this.isFilled = false,
    this.validator = false,
    this.autoFocus = false,
    this.readOnly = false,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines = 1,
    this.borderWidth = 2,
    this.radius,
    this.customPadding,
    this.padding,
    required this.label,
    this.textInputType,
    this.inputFormatters,
    this.alignment,
    this.shadowColor,
    this.borderStyle = BorderStyle.underline,
    this.fillColor,
    this.showBorderSide = false,
    this.customShapeDecoration,
    this.optionalLabel,
    this.suffixIconColor,
  });

  @override
  State<PrimaryInputWidget> createState() => _PrimaryInputWidgetState();
}

class _PrimaryInputWidgetState extends State<PrimaryInputWidget> {
  FocusNode? focusNode;
  bool isVisibility = true;

  @override
  Widget build(BuildContext context) {
    return widget.alignment != null
        ? Align(
            alignment: widget.alignment ?? Alignment.center,
            child: _buildTextFormFieldWidget(context),
          )
        : _buildTextFormFieldWidget(context);
  }

  @override
  void dispose() {
    focusNode!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
  }

  _buildDecoration() {
    return InputDecoration(
      hintText: DynamicLanguage.isLoading ? "": DynamicLanguage.key(widget.hintText),
      hintStyle: CustomStyle.lightHeading4TextStyle.copyWith(
        fontSize: Dimensions.headingTextSize3,
        fontWeight: FontWeight.w500,
        color: CustomColor.primaryLightTextColor.withOpacity(0.20),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
            color: CustomColor.blackColor.withOpacity(0.20), width: 1.5),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: CustomColor.blackColor, width: 1.5),
      ),
      prefixIcon: _setPrefixIcon(),
      suffixIcon: _setSuffixIcon(),
      fillColor: _setFillColor(context),
      filled: _setFilled(),
      isDense: true,
      contentPadding: _setPadding(),
    );
  }

  _buildTextFormFieldWidget(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(),
        TextFormField(
          readOnly: widget.readOnly,
          controller: widget.controller,
          focusNode: focusNode,
          autofocus: widget.autoFocus,
          style: _setFontStyle(),
          inputFormatters: widget.inputFormatters,
          obscureText: widget.isPasswordField ? isVisibility : false,
          textInputAction: TextInputAction.next,
          keyboardType: widget.textInputType,
          maxLines: widget.maxLines,
          decoration: _buildDecoration(),
          validator: _setValidator(),
          cursorColor: CustomColor.blackColor,
          onTap: () {
            setState(() {
              focusNode!.requestFocus();
            });
          },
          onFieldSubmitted: (value) {
            setState(() {
              focusNode!.unfocus();
            });
          },
          onEditingComplete: () {
            setState(() {
              focusNode!.unfocus();
            });
          },
          onTapOutside: (value) {
            setState(() {
              focusNode!.unfocus();
            });
          },
        ),
      ],
    );
  }

  _buildTitle() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              DynamicLanguage.isLoading
                  ? ""
                  : DynamicLanguage.key(widget.label),
              style: CustomStyle.lightHeading4TextStyle.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: Dimensions.headingTextSize5,
                color: CustomColor.primaryLightTextColor,
              ),
            ),
            Text(
              DynamicLanguage.isLoading
                  ? ""
                  : DynamicLanguage.key(widget.optionalLabel ?? ""),
              style: CustomStyle.lightHeading4TextStyle.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: Dimensions.headingTextSize4,
                color: CustomColor.primaryLightColor.withOpacity(.8),
              ),
            ),
          ],
        ),
        //verticalSpace(Dimensions.marginBetweenInputTitleAndBox),
      ],
    );
  }

  _setFillColor(BuildContext context) {
    return widget.fillColor ?? Theme.of(context).primaryColor;
  }

  _setFilled() {
    return widget.isFilled;
  }

  _setFontStyle() {
    return CustomStyle.darkHeading3TextStyle.copyWith(
        color: focusNode!.hasFocus
            ? CustomColor.blackColor
            : CustomColor.blackColor);
  }

  _setPadding() {
    return widget.customPadding ??
        (widget.padding == null
            ? EdgeInsets.symmetric(
                vertical: Dimensions.heightSize,
              )
            : EdgeInsets.all(widget.padding!));
  }

  _setPrefixIcon() {
    return widget.prefixIcon ??
        (widget.prefixIconPath != ''
            ? Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingHorizontalSize * 0.4),
                child: Row(
                  mainAxisSize: mainMin,
                  children: [
                    CustomImageWidget(
                      path: widget.prefixIconPath!,
                      color: focusNode!.hasFocus
                          ? Theme.of(context).primaryColor
                          : Get.isDarkMode
                              ? CustomColor.primaryDarkTextColor
                                  .withOpacity(0.50)
                              : CustomColor.primaryLightTextColor
                                  .withOpacity(0.50),
                    ),
                    Visibility(
                      visible: widget.phoneCode != '',
                      child: Row(
                        children: [
                          Text(
                            widget.phoneCode,
                            style: TextStyle(
                              fontSize: Dimensions.headingTextSize3,
                              fontWeight: FontWeight.w500,
                              color: focusNode!.hasFocus
                                  ? Theme.of(context).primaryColor
                                  : CustomColor.primaryLightTextColor
                                      .withOpacity(0.2),
                            ),
                          ).marginOnly(
                            left: Dimensions.marginSizeHorizontal * 0.3,
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              left: Dimensions.marginSizeHorizontal * 0.3,
                            ),
                            height: Dimensions.heightSize * 1.5,
                            width: 1,
                            color: focusNode!.hasFocus
                                ? Theme.of(context).primaryColor
                                : CustomColor.primaryLightTextColor
                                    .withOpacity(0.2),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            : null);
  }

  _setSuffixIcon() {
    return widget.isPasswordField
        ? IconButton(
            icon: Icon(
              isVisibility
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: focusNode!.hasFocus
                  ? CustomColor.primaryLightTextColor
                  : CustomColor.primaryLightTextColor.withOpacity(0.20),
              size: Dimensions.iconSizeDefault * 1.2,
            ),
            onPressed: () {
              setState(() {
                isVisibility = !isVisibility;
              });
            },
          )
        : Padding(
            padding: EdgeInsets.only(
              left: Dimensions.paddingHorizontalSize * .4,
              right: Dimensions.paddingHorizontalSize * .4,
              top: Dimensions.paddingVerticalSize * .6,
              bottom: Dimensions.paddingVerticalSize * .4,
            ),
            child: CustomImageWidget(
              path: widget.suffixIconPath!,
              color: focusNode!.hasFocus
                  ? widget.suffixIconColor ?? CustomColor.primaryLightTextColor
                  : widget.suffixIconColor ??
                      CustomColor.primaryLightTextColor.withOpacity(0.20),
            ),
          );
  }

  _setValidator() {
    return widget.isValidator == false
        ? null
        : (String? value) {
            if (value!.isEmpty) {
              return Strings.pleaseFillOutTheField;
            } else {
              return null;
            }
          };
  }
}
