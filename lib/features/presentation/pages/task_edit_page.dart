import 'package:flutter/material.dart';

class TaskEditPage extends StatefulWidget {
  const TaskEditPage({super.key});

  @override
  State<TaskEditPage> createState() => _TaskEditPageState();
}

class _TaskEditPageState extends State<TaskEditPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:16),
          child: Column(
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: Image.asset(
                          'assets/icons/close.png',
                        ),
                  ),
                 
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(onPressed: () {}, child: const Text('Сохранить'))),
                  ),
                ],
              ),
              const Card(child: TextField()),
              const SizedBox(
                height: 20,
              ),
              const Text('Важность'),
              TextButton(onPressed: () {}, child: const Text('')),
              const Divider(),
              Row(
                children: [
                  const Text('data'),
                  Switch(
                    value: true,
                    onChanged: (value) {},
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              const Divider(),
               Row(
                children: [
                  Image.asset(
                          'assets/icons/delete.png', color: Colors.red,
                        ),
                        SizedBox(width: 10,),
                      TextButton(onPressed: () {}, child: const Text('Удалить',style: TextStyle(color: Colors.red),)),  
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
