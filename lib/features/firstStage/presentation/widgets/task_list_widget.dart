import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/features/firstStage/presentation/provider/provider.dart';

class TaskListWidget extends StatefulWidget {
  const TaskListWidget({super.key});

  @override
  State<TaskListWidget> createState() => _TaskListWidgetState();
}

class _TaskListWidgetState extends State<TaskListWidget> {
  @override
  Widget build(BuildContext context) {
    ProviderTask provider = Provider.of<ProviderTask>(context);
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: provider.listAllTask.length,
      itemBuilder: (context, index) {
        List allTask = provider.listAllTask;

        return ClipRect(
          child: Dismissible(
            confirmDismiss: (direction) =>
                direction == DismissDirection.startToEnd
                    ? Future.value(false)
                    : Future.value(true),
            onUpdate: (details) {},
            resizeDuration: const Duration(seconds: 1),
            key: ValueKey(allTask[index]),
            direction: DismissDirection.horizontal,
            onDismissed: (direction) {
              if (direction == DismissDirection.endToStart) {
                provider.deleteTask(index);
                provider.countAllCompletedTasks();
              }
            },
            secondaryBackground: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 16.0),
              child: Image.asset(
                'assets/icons/delete.png',
                color: Colors.white,
              ),
            ),
            background: Container(
              color: Colors.green,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 16.0),
              child: Image.asset(
                'assets/icons/check.png',
                color: Colors.white,
              ),
            ),
            child: ListTile(
              leading: Checkbox(
                checkColor: Colors.white,
                fillColor: MaterialStateProperty.resolveWith(
                    (Set<MaterialState> states) {
                  if (states.contains(MaterialState.selected)) {
                    return Colors.green;
                  }
                  final DateTime taskDay =
                      DateFormat('dd MMMM yyyy', 'ru').parse(allTask[index][3]);
                  if (taskDay.isBefore(provider.currentDate)) {
                    return Colors.red;
                  } else {
                    return Colors.green;
                  }
                }),
                value: allTask[index][1],
                onChanged: (bool? value) {
                  provider.changeValue(value!, index);
                  allTask[index][1] = value;
                  provider.countAllCompletedTasks();
                },
              ),
              enabled: false,
              title: Padding(
                padding: const EdgeInsets.only(top: 15),
                child: RichText(
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
                        style: TextStyle(decoration: allTask[index][1] ?TextDecoration.lineThrough : TextDecoration.none, color: Colors.black ),
                        
                      ),
                    ],
                  ),
                ),
              ),
              subtitle: Text(allTask[index][3] ?? ""),
              trailing: Image.asset(
                'assets/icons/info_outline.png',
                color: const Color.fromRGBO(0, 0, 0, 0.3),
              ),
            ),
          ),
        );
      },
    );
  }
}
