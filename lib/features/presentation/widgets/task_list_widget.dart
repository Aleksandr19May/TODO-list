import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/features/presentation/provider/provider.dart';

class TaskListWidget extends StatefulWidget {
  const TaskListWidget({super.key});

  @override
  State<TaskListWidget> createState() => _TaskListWidgetState();
}

final List<bool> checkedList = List.generate(15, (index) => false);

class _TaskListWidgetState extends State<TaskListWidget> {
  @override
  Widget build(BuildContext context) {
    ProviderTask provider = Provider.of<ProviderTask>(context);
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: checkedList.length,
      itemBuilder: (context, index) {
        return ClipRect(
          child: Dismissible(
            confirmDismiss: (direction) =>
                direction == DismissDirection.startToEnd
                    ? Future.value(false)
                    : Future.value(true),
            onUpdate: (details) {},
            resizeDuration: const Duration(seconds: 1),
            key: ValueKey(checkedList[index]),
            direction: DismissDirection.horizontal,
            onDismissed: (direction) {
              if (direction == DismissDirection.endToStart) {
                checkedList.removeAt(index);
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
            child: CheckboxListTile(
           
              checkColor: Colors.white,
              fillColor: const MaterialStatePropertyAll(Colors.green),
              title:  Text('Купить чfg-то',style: Theme.of(context).textTheme.titleMedium,),
              value: provider.checked,
              onChanged: (bool? value) {
                provider.changeValue(value!);
                provider.checked = value;
              },
              controlAffinity: ListTileControlAffinity.leading,
              secondary: Image.asset(
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
