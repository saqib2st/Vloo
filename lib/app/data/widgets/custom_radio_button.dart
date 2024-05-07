import 'package:flutter/material.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/text.dart';

class CustomRadioRow extends StatelessWidget {
  final String title;
  final bool isSelected;
  final Function() onChanged;

  const CustomRadioRow({
    Key? key,
    required this.title,
    required this.isSelected,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onChanged,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColor.appLightBlue,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(25.0),
        ),
        padding: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            children: [
              Container(
                width: 24.0,
                height: 24.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? AppColor.appLightBlue : Colors.transparent,
                  border: Border.all(
                    color: Colors.grey,
                    width: 2.0,
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  title,
                  style: CustomTextStyle.font14R,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
