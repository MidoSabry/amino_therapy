
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../data/constants/app_colors.dart';
import '../../global/enums/global_enum.dart';
import '../../global/enums/request_status.dart';
import '../text/p_text.dart';

class StatusTabs extends StatefulWidget {
  final RequestStatus? selectedStatus;
  final List<RequestStatus> values;
  final ValueChanged<RequestStatus> onStatusChanged;

  const StatusTabs({
    super.key,
    this.selectedStatus,
    required this.values,
    required this.onStatusChanged,
  });

  @override
  State<StatusTabs> createState() => _StatusTabsState();
}

class _StatusTabsState extends State<StatusTabs> {
  late RequestStatus _selectedStatus;

  @override
  void initState() {
    super.initState();
    _selectedStatus = widget.selectedStatus ?? RequestStatus.all;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 5.5.h,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children:
              widget.values.map((status) {
                final isSelected = status == _selectedStatus;
                return Padding(
                  padding: EdgeInsets.only(
                    right: 1.w,
                    top: 1.h,
                    left: 1.w,
                  ), // spacing between items
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _selectedStatus = status;
                      });
                      widget.onStatusChanged(_selectedStatus);
                    },
                    child: Container(
                      height: 5.h,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ), // width becomes dynamic
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color:
                            isSelected
                                ? AppColors.primaryColor
                                : AppColors.grayColor100,
                        borderRadius: BorderRadius.circular(
                          8,
                        ), // optional better UI
                      ),
                      child: PText(
                        title: status.name.tr(),
                        fontColor:
                            isSelected ? AppColors.whiteColor : AppColors.black,
                        fontWeight: FontWeight.w400,
                        size: PSize.text14,
                      ),
                    ),
                  ),
                );
              }).toList(),
        ),
      ),
    );
  }
}
