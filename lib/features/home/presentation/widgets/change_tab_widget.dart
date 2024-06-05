import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChangeTabWidget extends ConsumerStatefulWidget {
  final String title;
  final bool isCurrent;
  final double width;
  final VoidCallback onTap;
  const ChangeTabWidget(
      {super.key,
      required this.title,
      this.width = 102,
      required this.isCurrent,
      required this.onTap});

  @override
  ConsumerState createState() => _ChangeTabWidgetState();
}

class _ChangeTabWidgetState extends ConsumerState<ChangeTabWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: 34.h,
        width: widget.width.w,
        decoration: BoxDecoration(
            color: widget.isCurrent ? const Color(0xff262932) : null,
            borderRadius: BorderRadius.circular(8.r)),
        child: Center(
          child: Text(
            widget.title,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14.sp,
              //  color:
            ),
          ),
        ),
      ),
    );
  }
}
