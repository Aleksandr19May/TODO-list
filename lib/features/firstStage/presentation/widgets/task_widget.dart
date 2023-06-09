import 'package:flutter/material.dart';
import 'package:todo_list/common/colors.dart';
import 'package:todo_list/common/fonts_size.dart';
import 'package:todo_list/features/firstStage/presentation/pages/task_edit_page.dart';
import 'package:todo_list/features/firstStage/presentation/provider/provider.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({
    super.key,
    required this.allTask,
    required this.provider,
    required this.index,
  });
  final int index;
  final List allTask;
  final ProviderTask provider;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      isThreeLine: true,
      titleAlignment: ListTileTitleAlignment.top,
      horizontalTitleGap: 0,
      leading: Checkbox(
        checkColor: Colors.white,
        fillColor:
            MaterialStateProperty.resolveWith((Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return Colors.green;
          }

          if (allTask[index][2] == 2) {
            return Colors.red;
          } else {
            return Colors.green;
          }
        }),
        value: allTask[index][1],
        onChanged: (bool? value) {
          provider.changeValue(value, index);
          allTask[index][1] = value;
          provider.countAllCompletedTasks();
        },
      ),
      enabled: false,
      title: Baseline(
        baselineType: TextBaseline.alphabetic,
        baseline: 25,
        child: RichText(
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
          text: TextSpan(
            children: [
              WidgetSpan(
                child: allTask[index][2] == 2
                    ? Image.asset(
                        'assets/icons/sign.png',
                      )
                    : allTask[index][2] == 1
                        ? Image.asset('assets/icons/arrow_down.png')
                        : const Text(''),
              ),
              TextSpan(
                text: " ${allTask[index][0]}",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: AppTextSizes.body,
                  height: AppHeights.body,
                  decoration: allTask[index][1]
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                  color: allTask[index][1]
                      ? AppColorsLightTheme.tertiary
                      : AppColorsLightTheme.primary,
                ),
              ),
            ],
          ),
        ),
      ),
      subtitle: Text(
        allTask[index][3] ?? "",
        style: const TextStyle(
          fontSize: AppTextSizes.subhead,
        ),
      ),
      trailing: Padding(
        padding: const EdgeInsets.only(top: 14),
        child: InkWell(
          onTap: () {
            provider.changeEditor(true);
            provider.changePriority(provider.listAllTasks[index][2]);
            if (provider.listAllTasks[index][3] != '') {
              provider.changeSwitcher(true);
            }

            provider.selectedDay = provider.listAllTasks[index][3];
            Navigate(context);
          },
          child: Image.asset(
            'assets/icons/info_outline.png',
            color: const Color.fromRGBO(0, 0, 0, 0.3),
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  void Navigate(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      final bool edited = provider.isEdited;
      final bool showedalltasks = provider.showedAllTasks;
      final String? textTitlefromAllTask = provider.listAllTasks[index][0];
      final String? textTitlefromUncompletedTask = !provider.showedAllTasks
          ? provider.listUncomletedTasks[index][0] ?? ''
          : null;
      return TaskEditPage(
        index: index,
        edited: edited,
        showedalltasks: showedalltasks,
        textTitlefromAllTask: textTitlefromAllTask,
        textTitlefromUncompletedTask: textTitlefromUncompletedTask,
      );
    }));
  }
}
