import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
      horizontalTitleGap:0,
      leading: Checkbox(
        checkColor: Colors.white,
        fillColor:
            MaterialStateProperty.resolveWith((Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return Colors.green;
          }
          final DateTime taskDay = allTask[index][3] == ''
              ? provider.currentDate
              : DateFormat('dd MMMM yyyy', 'ru').parse(allTask[index][3]);
          if (taskDay.isBefore(provider.currentDate)) {
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
      title: Padding(
        padding: const EdgeInsets.only(top: 15),
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
                  decoration: allTask[index][1]
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
      subtitle: Text(allTask[index][3] ?? ""),
      trailing: InkWell(
        onTap: () {
          provider.changeEditor(true);
          provider.changePriority(provider.listAllTasks[index][2]);
          if (provider.listAllTasks[index][3] != '') {
            provider.changeSwitcher(true);
          }

          provider.selectedDay = provider.listAllTasks[index][3];

          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            final bool edited = provider.isEdited;
            final bool showedalltasks = provider.showedAllTasks;
            final String? textTitlefromAllTask =
                provider.listAllTasks[index][0];
            final String? textTitlefromUncompletedTask =
                provider.listUncomletedTasks.isNotEmpty
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
        },
        child: Image.asset(
          'assets/icons/info_outline.png',
          color: const Color.fromRGBO(0, 0, 0, 0.3),
        ),
      ),
    );
  }
}
