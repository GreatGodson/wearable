import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/framework/theme/spacings/spacings.dart';

class TextFieldComponent extends StatefulWidget {
  final String? hint;
  final ValueChanged<String>? onChanged;
  final bool headerLess;
  final TextEditingController? textEditingController;
  final int lines;
  final int minLines;
  final bool readOnly;
  final bool obscureText;
  final Widget? prefix;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final Widget? suffix;
  final TextInputAction textInputAction;
  final Border? border;
  final Color? backgroundColor;
  final String? prefixText;
  final String? headerText;
  final String? Function(String?)? validator;
  final String? header;
  final String? initialValue;
  final EdgeInsets? contentPadding;
  final VoidCallback? onTap;

  const TextFieldComponent({
    super.key,
    this.hint,
    this.onChanged,
    this.headerText = '',
    this.headerLess = true,
    this.textEditingController,
    this.lines = 1,
    this.minLines = 1,
    this.readOnly = false,
    this.obscureText = false,
    this.prefix,
    this.keyboardType,
    this.inputFormatters,
    this.focusNode,
    this.suffix,
    this.textInputAction = TextInputAction.done,
    this.border,
    this.backgroundColor,
    this.prefixText,
    this.validator,
    this.header,
    this.initialValue,
    this.contentPadding,
    this.onTap,
  });

  @override
  State<TextFieldComponent> createState() => _TextFieldComponentState();
}

class _TextFieldComponentState extends State<TextFieldComponent> {
  @override
  void initState() {
    _node = widget.focusNode ?? FocusNode();
    super.initState();
  }

  FocusNode? _node;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Consumer(
          builder: (context, ref, child) {
            if (widget.header != null) {
              return Column(
                children: [
                  Text(
                    widget.header!,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: Spacings.spacing12,
                      color: Color(0xff14141E),
                    ),
                  ),
                  const SizedBox(
                    height: Spacings.spacing8,
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
        TextFormField(
          onTap: widget.onTap,
          initialValue: widget.initialValue,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: widget.validator,
          focusNode: _node,
          cursorColor: Colors.black,
          readOnly: widget.readOnly,
          onChanged: widget.onChanged,
          textInputAction: widget.textInputAction,
          obscureText: widget.obscureText,
          keyboardType: widget.keyboardType,
          controller: widget.textEditingController,
          inputFormatters: widget.inputFormatters,
          maxLines: widget.obscureText ? 1 : (widget.lines),
          minLines: widget.obscureText ? 1 : (widget.minLines),
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            color: Color(0xff14141E),
            fontSize: Spacings.spacing14,
          ),
          decoration: InputDecoration(
            contentPadding: widget.contentPadding,
            prefixText: widget.prefixText,
            prefixIcon: widget.prefix,
            filled: true,
            fillColor: Colors.white,
            prefixStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black,
              fontSize: Spacings.spacing14,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                Spacings.spacing8,
              ),
              borderSide: const BorderSide(
                color: Color(0xffE0E0E0),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                Spacings.spacing8,
              ),
              borderSide: const BorderSide(
                color: Color(0xff9A1A87),
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                Spacings.spacing8,
              ),
              borderSide: const BorderSide(
                color: Colors.red,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                Spacings.spacing8,
              ),
              borderSide: const BorderSide(
                color: Colors.red,
              ),
            ),
            border: InputBorder.none,
            suffixIcon: widget.suffix,
            hintText: widget.hint,
            errorStyle: const TextStyle(
              fontFamily: '',
              fontWeight: FontWeight.w400,
            ),
            hintStyle: const TextStyle(
              color: Color(0xffBDBDBD),
              fontWeight: FontWeight.w400,
              fontSize: Spacings.spacing12,
            ),
          ),
        ),
      ],
    );
  }
}
