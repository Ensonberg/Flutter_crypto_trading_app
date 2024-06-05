import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:ravenpay_assessment/core/extensions/ui_extension.dart';

import '../../../../res.dart';

class CustomFormField extends StatefulWidget {
  final TextEditingController controller;
  final String title;
  final bool isDropdown;
  const CustomFormField(
      {Key? key,
      required this.controller,
      required this.title,
      this.isDropdown = false})
      : super(key: key);

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  String orderType = 'Good till cancelled';
  void formatInput(TextEditingController controller) {
    String text = controller.text.replaceAll(',', '').replaceAll('.', '');
    if (text.isEmpty) return;
    double value = double.parse(text) / 100;
    final formatter = NumberFormat('0.00');
    controller.value = TextEditingValue(
      text: formatter.format(value),
      selection: TextSelection.collapsed(offset: 4),
    );
    // setState(() {});
  }

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      formatInput(widget.controller);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 40.h,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
          color: context.colorScheme.background,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: Color(0xff373B3F))),
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          title: Row(
            //mainAxisAlignment: MainAxisAlignment.,
            children: [
              Text(
                widget.title,
                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                width: 4.w,
              ),
              SvgPicture.asset(Res.info)
            ],
          ),
          trailing: SizedBox(
            width: widget.isDropdown ? 180.w : 100.w,
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.,

              children: [
                if (!widget.isDropdown)
                  Flexible(
                      child: TextField(
                    controller: widget.controller,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d{0,2}')),
                    ],
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  )),
                if (widget.isDropdown)
                  Flexible(
                    child: DropdownButtonFormField<String>(
                      value: orderType,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                      dropdownColor: context.colorScheme.background,
                      icon: SvgPicture.asset(Res.down),
                      items: [
                        'Good till cancelled',
                        'Immediate or cancel',
                        'Fill or kill'
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,
                              style: TextStyle(color: Colors.white)),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          orderType = newValue!;
                        });
                      },
                    ),
                  ),
                if (!widget.isDropdown)
                  Text(
                    context.tr.usd,
                    style:
                        TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
