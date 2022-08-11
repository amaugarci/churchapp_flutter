import 'package:flutter/material.dart';

typedef Null ValueChangeCallback(String value);
typedef Null OnSavedChangeCallback(String value);

class ZTextFormField extends StatefulWidget {
  final AutovalidateMode? autovalidateMode;
  final Color? containerColor;
  final GestureTapCallback? onTap;
  final String? initialValue;
  final String labelText;
  final String? Function(String?)? validator;
  final TextCapitalization? textCapitalization;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final ValueChangeCallback onSaved;
  final ValueChangeCallback? onValueChanged;
  final EdgeInsets? margin;
  final Widget? suffix;
  final bool isDarkMode;
  final bool isEnabled;
  final bool? obscureText;
  final bool readyOnly;
  final int? maxLength;
  final int? maxLines;
  final Widget? prefix;
  final bool autocorrect;

  ZTextFormField({
    Key? key,
    required this.labelText,
    this.controller,
    this.onValueChanged,
    this.isEnabled = true,
    required this.onSaved,
    this.keyboardType,
    this.textCapitalization,
    this.validator,
    this.containerColor,
    this.initialValue,
    this.obscureText,
    this.maxLength,
    this.maxLines,
    this.readyOnly = false,
    this.onTap,
    this.suffix,
    this.isDarkMode = false,
    this.autovalidateMode,
    this.prefix,
    this.margin,
    this.autocorrect = false,
  }) : super(key: key);

  @override
  _ZTextFormFieldState createState() => _ZTextFormFieldState();
}

class _ZTextFormFieldState extends State<ZTextFormField> {
  TextEditingController? valueController;
  FocusNode _focus = new FocusNode();
  BorderRadius borderRadius = BorderRadius.circular(10);
  Color disabledBorderColor = Color(0xFFE6E7EA);
  Color enabledBorderColor = Color(0xFFE8EBF7);
  Color errorBorderColor = Color(0xFFE20000);
  Color focusedBorderColor = Color(0xFF5A7EFF);
  Color focusedErrorBorderColor = Color(0xFF5C00E4);
  @override
  void initState() {
    super.initState();
    valueController = widget.controller ?? TextEditingController.fromValue(TextEditingValue(text: widget.initialValue ?? ""));
    valueController?.addListener(() {
      if (widget.onValueChanged != null) widget.onValueChanged!(valueController?.text ?? '');
    });
    _focus.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin ?? EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            autocorrect: widget.autocorrect,
            autovalidateMode: widget.autovalidateMode ?? AutovalidateMode.disabled,
            maxLength: widget.maxLength ?? null,
            maxLines: widget.maxLines ?? 1,
            enabled: widget.isEnabled,
            readOnly: widget.readyOnly,
            focusNode: _focus,
            onTap: () {
              if (widget.onTap != null) widget.onTap!();
            },
            onSaved: (String? value) {
              widget.onSaved(value ?? '');
            },
            style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w500, height: 1.45),
            keyboardType: widget.keyboardType ?? TextInputType.text,
            textCapitalization: widget.textCapitalization ?? TextCapitalization.none,
            obscureText: widget.obscureText ?? false,
            controller: valueController,
            validator: widget.validator ??
                (String? value) {
                  if (value != null && value.isEmpty) return 'This field is required';
                  return null;
                },
            decoration: InputDecoration(
                labelText: '${widget.labelText}',
                prefixIcon: widget.prefix ?? null,
                prefixStyle: TextStyle(color: Theme.of(context).textTheme.caption!.color),
                fillColor: Colors.grey.shade100,
                suffixStyle: TextStyle(color: Theme.of(context).textTheme.caption!.color),
                labelStyle: TextStyle(color: Theme.of(context).textTheme.caption!.color),
                contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: enabledBorderColor, width: 1), borderRadius: borderRadius),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: focusedBorderColor, width: 1), borderRadius: borderRadius),
                errorBorder: OutlineInputBorder(borderSide: BorderSide(color: errorBorderColor, width: 1), borderRadius: borderRadius),
                focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: focusedErrorBorderColor, width: 1), borderRadius: borderRadius),
                disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: disabledBorderColor, width: 1), borderRadius: borderRadius),
                isDense: true),
          ),
        ],
      ),
    );
  }
}
