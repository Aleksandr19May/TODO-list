
import 'package:flutter/material.dart';
import 'package:todo_list/common/colors.dart';
import 'package:todo_list/common/fonts_size.dart';
import 'package:todo_list/features/firstStage/presentation/provider/provider.dart';

class DropButtonWidget extends StatelessWidget {
  const DropButtonWidget({
    super.key,
    required this.provider,
  });

  final ProviderTask provider;

  @override
  Widget build(BuildContext context) {
    TextStyle style =  TextStyle(fontSize: AppTextSizes.body,height: AppHeights.body, color: AppColorsLightTheme.primary);
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
        items:  [
          DropdownMenuItem(
            value: 0,
            child: Text('Нет',style: style,),
          ),
          DropdownMenuItem(
            value: 1,
            child: Text('Низкий', ),
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