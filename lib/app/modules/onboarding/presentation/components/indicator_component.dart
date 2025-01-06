import 'package:flutter/material.dart';

import '../../../../../core/framework/theme/spacings/spacings.dart';

class PageViewIndicatorsComponent extends StatelessWidget {
  final int _index;
  final int count;
  final MainAxisAlignment? mainAxisAlignment;

  const PageViewIndicatorsComponent({
    super.key,
    required int index,
    required this.count,
    this.mainAxisAlignment,
  }) : _index = index;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        count,
        (index) {
          final isSelected = index == _index;
          return AnimatedContainer(
            duration: const Duration(
              milliseconds: 200,
            ),
            curve: Curves.easeInOut,
            width: isSelected ? Spacings.spacing36 : Spacings.spacing10,
            height: Spacings.spacing10,
            margin: const EdgeInsets.symmetric(
              horizontal: Spacings.spacing4,
            ),
            decoration: BoxDecoration(
              color: isSelected ? Colors.purple : const Color(0xffEAEAEA),
              borderRadius: BorderRadius.circular(
                Spacings.spacing12,
              ),
            ),
          );
        },
      ),
    );
  }
}
