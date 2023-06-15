
import 'package:flutter/material.dart';
import 'package:todo_list/common/colors.dart';
import 'package:todo_list/features/firstStage/presentation/provider/provider.dart';

class DropButtonWidget extends StatelessWidget {
  const DropButtonWidget({
    super.key,
    required this.provider,
  });

  final ProviderTask provider;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
    
        underline: const Divider(
          color: Colors.transparent,
        ),
        value: provider.priority,
        iconSize: 0,
        elevation: 8,
        alignment: Alignment.centerLeft,
        onChanged: (value) {
          provider.changePriority(value);
        },
        items: const [
          DropdownMenuItem(
            value: 0,
            child: Text('Нет'),
          ),
          DropdownMenuItem(
            value: 1,
            child: Text('Низкий'),
          ),
          DropdownMenuItem(
            value: 2,
            child: Text(
              '!! Высокий',
              style: TextStyle(
                  color: AppColorsLightTheme.red),
            ),
          ),
        ]);
  }
}