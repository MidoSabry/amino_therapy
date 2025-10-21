import 'package:flutter/material.dart';

import '../data/constants/app_colors.dart';
import 'text/p_text.dart';


class NumOfCharsWidget extends StatefulWidget {
  final TextEditingController controller;
  final int totalNum;
  const NumOfCharsWidget({
    super.key,
    required this.totalNum,
    required this.controller,
  });

  @override
  State<NumOfCharsWidget> createState() => NumOfCharsWidgettate();
}

class NumOfCharsWidgettate extends State<NumOfCharsWidget> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            PText(title: '${widget.totalNum}', fontWeight: FontWeight.w600),
            PText(
              title: ' / ${widget.controller.text.characters.length}',
              fontWeight: FontWeight.w600,
              fontColor: AppColors.neutralColor50,
            ),
          ],
        ),
      ),
    );
  }
}
