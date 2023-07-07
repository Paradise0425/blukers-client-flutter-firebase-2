import 'package:flutter/material.dart';
import 'package:blukers_client_app/utils/color_res.dart';

class CommonLoader extends StatelessWidget {
  const CommonLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.all(35),
          height: 110,
          width: 110,
          decoration: BoxDecoration(
              color: ColorRes.white, borderRadius: BorderRadius.circular(25)),
          child: const CircularProgressIndicator(
            backgroundColor: Color(0xffE2D3FE),
            color: ColorRes.containerColor,
          ),
        ),
      ),
    );
  }
}
