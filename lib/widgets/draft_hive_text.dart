import 'package:example_hive/constants/app_constants.dart';
import 'package:example_hive/services/hive_service.dart';
import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';

class DraftHiveText extends StatelessWidget {
  const DraftHiveText({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: HiveService.getNameListenable(),
      builder: (context, Box box, _) {
        return Text(
          box.get(AppConstants.kNameKey, defaultValue: ''),
          style: Theme.of(context).textTheme.bodyLarge,
        );
      },
    );
  }
}
