import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OTPTextField extends StatefulWidget {
  final int length;
  final void Function(String)? onChanged;
  final void Function(String)? onCompleted;
  final double boxSize;
  final TextStyle textStyle;
  final Color borderColor;
  final Color focusedBorderColor;
  final double borderWidth;

  const OTPTextField({
    super.key,
    required this.length,
    this.onChanged,
    this.onCompleted,
    this.boxSize = 50,
    this.textStyle = const TextStyle(fontSize: 20),
    this.borderColor = Colors.grey,
    this.focusedBorderColor = Colors.blue,
    this.borderWidth = 1.5,
  });

  @override
  State<OTPTextField> createState() => _OTPTextFieldState();
}

class _OTPTextFieldState extends State<OTPTextField> {
  late List<FocusNode> _focusNodes;
  late List<TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    _focusNodes = List.generate(widget.length, (_) => FocusNode());
    _controllers = List.generate(widget.length, (_) => TextEditingController());
  }

  @override
  void dispose() {
    for (final f in _focusNodes) f.dispose();
    for (final c in _controllers) c.dispose();
    super.dispose();
  }

  void _handleOtpChange(String value, int index) {
    if (value.isNotEmpty && index < widget.length - 1) {
      FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
    }

    final otp = _controllers.map((c) => c.text).join();

    if (widget.onChanged != null) widget.onChanged!(otp);

    if (otp.length == widget.length && widget.onCompleted != null) {
      widget.onCompleted!(otp);
    }
  }

  void _handleBackspace(int index) {
    if (_controllers[index].text.isEmpty && index > 0) {
      _controllers[index - 1].clear();
      FocusScope.of(context).requestFocus(_focusNodes[index - 1]);

      final otp = _controllers.map((c) => c.text).join();
      if (widget.onChanged != null) widget.onChanged!(otp);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(widget.length, (index) {
          return SizedBox(
            width: widget.boxSize * 1.5,
            height: widget.boxSize,
            child: RawKeyboardListener(
              focusNode: FocusNode(),
              onKey: (event) {
                if (event is RawKeyDownEvent &&
                    event.logicalKey == LogicalKeyboardKey.backspace) {
                  _handleBackspace(index);
                }
              },
              child: TextField(
                controller: _controllers[index],
                focusNode: _focusNodes[index],
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                maxLength: 1,
                style: widget.textStyle,
                decoration: InputDecoration(
                  counterText: '',
                  contentPadding: EdgeInsets.zero,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: widget.borderColor,
                      width: widget.borderWidth,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: widget.focusedBorderColor,
                      width: widget.borderWidth,
                    ),
                  ),
                ),
                onChanged: (value) => _handleOtpChange(value, index),
              ),
            ),
          );
        }),
      ),
    );
  }
}
