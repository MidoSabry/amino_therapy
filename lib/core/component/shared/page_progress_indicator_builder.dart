import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../global/enums/request_status.dart';
import 'request_card_item.dart';

class PageProgressIndicatorBuilder extends StatelessWidget {
  final RequestStatus status;
  const PageProgressIndicatorBuilder({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(10, (index) {
        return Skeletonizer(
          enabled: true,
          child: CustomRequestCard(
            title: '--------',
            status: status,
            fields: const {"type": '--------', "time": "-------------"},
          ),
        );
      }),
    );
  }
}
