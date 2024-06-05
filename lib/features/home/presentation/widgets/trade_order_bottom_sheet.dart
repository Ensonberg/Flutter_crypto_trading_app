import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ravenpay_assessment/core/extensions/ui_extension.dart';
import 'package:ravenpay_assessment/res.dart';

import 'custom_form_field.dart';

class TradeOrderBottomSheet extends StatefulWidget {
  const TradeOrderBottomSheet({Key? key}) : super(key: key);

  @override
  State<TradeOrderBottomSheet> createState() => _TradeOrderBottomSheetState();
}

class _TradeOrderBottomSheetState extends State<TradeOrderBottomSheet> {
  bool isBuy = true;
  TextEditingController limitPriceController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  String selectedCurrency = "USD";
  bool postOnly = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 604.h,
      decoration: BoxDecoration(
          color: Color(0xff20252B),
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(16.r), topLeft: Radius.circular(16.r))),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.h,
              ),
              Container(
                decoration: BoxDecoration(
                  color: context.colorScheme.onBackground,
                  borderRadius: BorderRadius.circular(
                    10.r,
                  ),
                ),
                height: 32.h,
                child: Row(
                  children: [
                    Flexible(
                      child: GestureDetector(
                        onTap: () {
                          isBuy = true;
                          setState(() {});
                        },
                        child: Container(
                          height: 28.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                8.r,
                              ),
                              border: isBuy
                                  ? Border.all(
                                      color: context.colorScheme.primary,
                                      width: 1)
                                  : null),
                          child: Center(
                            child: Text(
                              context.tr.buy,
                              style: TextStyle(
                                  fontSize: 12.sp, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: GestureDetector(
                        onTap: () {
                          isBuy = false;
                          setState(() {});
                        },
                        child: Container(
                          height: 28.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                8.r,
                              ),
                              border: !isBuy
                                  ? Border.all(
                                      color: context.colorScheme.primary,
                                      width: 1)
                                  : null),
                          child: Center(
                            child: Text(
                              context.tr.sell,
                              style: TextStyle(
                                  fontSize: 12.sp, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 28.h,
                    decoration: BoxDecoration(
                        color: Color(0xff353945),
                        borderRadius: BorderRadius.circular(100)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16).w,
                      child: Center(
                        child: Text(
                          context.tr.limit,
                          style: TextStyle(
                              fontSize: 12.sp, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    context.tr.market,
                    style:
                        TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    context.tr.stop_limit,
                    style:
                        TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              CustomFormField(
                controller: limitPriceController,
                isDropdown: false,
                title: context.tr.limit_price,
              ),
              SizedBox(height: 16.h),
              CustomFormField(
                controller: amountController,
                isDropdown: false,
                title: context.tr.amount,
              ),
              SizedBox(height: 16.h),
              CustomFormField(
                controller: amountController,
                isDropdown: true,
                title: context.tr.type,
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Checkbox(
                    value: postOnly,
                    onChanged: (bool? newValue) {
                      setState(() {
                        postOnly = newValue!;
                      });
                    },
                    checkColor: Colors.white,
                    activeColor: Colors.blue,
                  ),
                  Text('Post Only', style: TextStyle(color: Colors.white)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    context.tr.total,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12.sp,
                        color: Color(0xffA7B1BC)),
                  ),
                  Text(
                    "0.00",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12.sp,
                        color: Color(0xffA7B1BC)),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              RawMaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                onPressed: () {},
                child: Container(
                  height: 32.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF483BEB),
                        Color(0xFF7847E1),
                        Color(0xFFDD568D),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      context.tr.buy_btc,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Container(
                height: 1.h,
                // width: 321.w,
                color: const Color(0xff394047),
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    context.tr.total_balance,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12.sp,
                        color: Color(0xffA7B1BC)),
                  ),
                  SizedBox(
                    width: 60.w,
                    child: DropdownButtonFormField<String>(
                      value: selectedCurrency,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                      dropdownColor: context.colorScheme.background,
                      icon: SvgPicture.asset(Res.down),
                      items: ['USD', 'NGN', 'CAD'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,
                              style: TextStyle(color: Colors.white)),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedCurrency = newValue!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "0.00",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14.sp,
                        color: Colors.white),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    context.tr.open_orders,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12.sp,
                        color: Color(0xffA7B1BC)),
                  ),
                  Text(
                    context.tr.available,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12.sp,
                        color: Color(0xffA7B1BC)),
                  ),
                ],
              ),
              // SizedBox(height: 8.h),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "0.00",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14.sp,
                          color: Colors.white),
                    ),
                    Text(
                      "0.00",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14.sp,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              Container(
                height: 32.h,
                width: 80.w,
                decoration: BoxDecoration(
                    color: Color(0xff2764FF),
                    borderRadius: BorderRadius.circular(8.r)),
                child: Center(
                    child: Text(context.tr.deposit,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w700))),
              ),
              SizedBox(height: 50.h),
            ],
          ),
        ),
      ),
    );
  }
}
