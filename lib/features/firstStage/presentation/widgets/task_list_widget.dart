import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/features/firstStage/presentation/provider/provider.dart';
import 'package:todo_list/features/firstStage/presentation/widgets/task_widget.dart';

class TaskListWidget extends StatefulWidget {
  const TaskListWidget({super.key});

  @override
  State<TaskListWidget> createState() => _TaskListWidgetState();
}

class _TaskListWidgetState extends State<TaskListWidget> {
  @override
  Widget build(BuildContext context) {
    ProviderTask provider = Provider.of<ProviderTask>(context);
    List allTask = provider.showedAllTasks
        ? provider.listAllTasks
        : provider.listUncomletedTasks;

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: allTask.length,
      itemBuilder: (context, index) {
        return ClipRect(
          child: Dismissible(
            confirmDismiss: (direction) =>
                markTaskAsCompleted(direction, provider, index, allTask),
            resizeDuration: const Duration(seconds: 1),
            key: ValueKey(allTask[index]),
            direction: DismissDirection.horizontal,
            onDismissed: (direction) => deleteTask(direction, provider, index),
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
            child: TaskWidget(
              allTask: allTask,
              provider: provider,
              index: index,
            ),
          ),
        );
      },
    );
  }

  void deleteTask(
      DismissDirection direction, ProviderTask provider, int index) {
    if (direction == DismissDirection.endToStart) {
      if (provider.showedAllTasks) {
        provider.deleteTaskfromlistAllTasks(index);
      } else {
        provider.deleteTaskfromlistAllTasks(index);
        provider.deleteTaskfromlistUncompletedTasks(index);
      }

      provider.countAllCompletedTasks();
    }
  }

  Future<bool?> markTaskAsCompleted(DismissDirection direction,
      ProviderTask provider, int index, List<dynamic> allTask) {
    if (direction == DismissDirection.startToEnd) {
      provider.changeValue(true, index);
      allTask[index][1] = true;
      provider.countAllCompletedTasks();
      provider.getUncompletedTasks();
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }
}
