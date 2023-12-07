import 'package:flutter/material.dart';
import 'package:lan_viz/theme.dart';

class StandardInputField extends StatefulWidget {
  const StandardInputField({
    this.onSubmitted,
    this.onChanged,
    this.placeholder,
    this.keyboardType,
    this.isInputValid,
    this.fontSize,
    super.key,
  });

  final Function(String)? onSubmitted;
  final Function(String)? onChanged;
  final bool? isInputValid;
  final double? fontSize;
  final String? placeholder;
  final TextInputType? keyboardType;

  @override
  State<StandardInputField> createState() => _StandardInputFieldState();
}

class _StandardInputFieldState extends State<StandardInputField> {

  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const borderRadius = 4.0;

    var focusedBorder = OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(borderRadius)),
        borderSide: BorderSide(width: 1.5, color: primary[3])
    );

    var enabledBorder = OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(borderRadius)),
        borderSide: BorderSide(width: 1, color: neutral[3])
    );

    if(widget.isInputValid != null) {
      if(widget.isInputValid! == false) {
        focusedBorder = focusedBorder.copyWith(borderSide: BorderSide(width: 1.5, color: error[4]));
        enabledBorder = enabledBorder.copyWith(borderSide: BorderSide(width: 1, color: error[3]));
      }
    }

    return TextField(
      controller: _textController,
      onSubmitted: widget.onSubmitted,
      onChanged: widget.onChanged,
      keyboardType: widget.keyboardType,
      style: TextStyle(color: neutral[4], fontSize: widget.fontSize ?? 14.0),
      maxLines: 1,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(16.0),
        suffixIcon: _textController.text.isEmpty
            ? null
            : IconButton(
          onPressed: () {
            setState(() {_textController.text = '';});
            if(widget.onChanged != null) {
              widget.onChanged!('');
            }
          },
          icon: const Icon(Icons.clear, size: 14),
          splashRadius: 10,
        ),
        isDense: true,
        hintText: widget.placeholder,
        hintStyle: TextStyle(color: neutral[2]),
        focusedBorder: focusedBorder,
        enabledBorder: enabledBorder,
      ),
    );
  }
}
