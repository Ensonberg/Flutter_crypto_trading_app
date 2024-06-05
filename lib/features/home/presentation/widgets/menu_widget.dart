import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MenuDialog extends StatefulWidget {
  const MenuDialog({Key? key}) : super(key: key);

  @override
  State<MenuDialog> createState() => _MenuDialogState();
}

class _MenuDialogState extends State<MenuDialog> {
  List<String> _tiles = ["Exchange", "Wallets", "Roqqu Hub", "Logout"];
  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
          side: BorderSide(
            color: Color(
              0xff373B3F,
            ),
          )),
      // insetPadding: EdgeInsets.zero,
      //backgroundColor: Color(0xff1C2127),
      child: SizedBox(
        height: 230.h,
        width: 214.w,
        child: ListView(
          children: _tiles
              .map((e) => ListTile(
                    onTap: () {},
                    title: Text(
                      e,
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.w500),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
