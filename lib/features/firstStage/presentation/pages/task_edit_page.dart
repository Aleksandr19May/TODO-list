import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/common/colors.dart';
import 'package:todo_list/features/firstStage/presentation/provider/provider.dart';

class TaskEditPage extends StatefulWidget {
 final int listIndex;
   const TaskEditPage({super.key,this.listIndex=0 } );

  @override
  State<TaskEditPage> createState() => _TaskEditPageState();
}

class _TaskEditPageState extends State<TaskEditPage> {

  
  final TextEditingController _textcontroller = TextEditingController( );

  @override
  void dispose() {
    _textcontroller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ProviderTask provider = Provider.of<ProviderTask>(context);
    double widthScreen = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              pinned: true,
              expandedHeight: 40,
              leadingWidth: widthScreen,
              leading: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: Image.asset(
                        'assets/icons/close.png',
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        provider.createTask(
                            _textcontroller.text,
                            false,
                            provider.priority,
                            provider.switcher ? '${provider.selectedDay}' : '');
                        provider.changeSwitcher(false);
                        provider.changePriority(0);

                        provider.getUncompletedTasks();
                        provider.changeEditor(false);
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Сохранить',
                        style: TextStyle(
                            fontSize: 16, color: AppColorsLightTheme.blue),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16, top: 23),
                        child: Card(
                          margin: EdgeInsets.zero,
                          semanticContainer: false,
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                          ),
                          elevation: 4,
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                                minHeight: 104, maxHeight: 1000),
                            child: TextField(
                              textInputAction: TextInputAction.done,
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(16),
                                hintText: 'Что надо сделать...',
                                border: InputBorder.none,
                              ),
                              controller:   !provider.isEdited  ? _textcontroller :   TextEditingController(text: provider.showedAllTasks 
          ? provider.listAllTasks[widget.listIndex][0] ?? ''
          : provider.listUncomletedTasks[widget.listIndex][0]?? '' ),


 
                              maxLines: null,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 28,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: SizedBox(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Важность'),
                            DropdownButton<int>(
                                underline: const Divider(
                                  color: Colors.transparent,
                                ),
                                value: provider.priority,
                                iconSize: 0,
                                elevation: 8,
                                alignment: Alignment.topLeft,
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
                                ]),
                          ],
                        )),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Divider(
                          height: 0.5,
                          thickness: 1,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 8),
                        child: ListTile(
                          minLeadingWidth: widthScreen,
                          contentPadding: EdgeInsets.zero,
                          subtitle: provider.switcher
                              ? Text(provider.selectedDay!)
                              : const Text(''),
                          title: const Text('Сделать до'),
                          trailing: Switch(
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            value: provider.switcher,
                            onChanged: (value) async {
                              provider.changeSwitcher(value);
                              if (provider.switcher) {
                                await selectTaskDate(context, provider);
                              }
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      const Divider(
                        height: 0.5,
                        thickness: 1,
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 21.0),
                        child: Row(
                          children: [
                            AbsorbPointer(
                              absorbing: provider.isnewTask ? true : false,
                              child: InkWell(
                                onTap: () => {},
                                child: Image.asset(
                                  'assets/icons/delete.png',
                                  color: provider.isnewTask
                                      ? AppColorsLightTheme.disable
                                      : Colors.red,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            AbsorbPointer(
                              absorbing: provider.isnewTask ? true : false,
                              child: InkWell(
                                onTap: () => {},
                                child: Text(
                                  'Удалить',
                                  style: TextStyle(
                                      color: provider.isnewTask
                                          ? AppColorsLightTheme.disable
                                          : Colors.red),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      )
                    ],
                  );
                },
                childCount: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> selectTaskDate(
      BuildContext context, ProviderTask provider) async {
    await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
      locale: const Locale('ru'),
    ).then((value) {
      provider.changeDate(value);
    });
  }
}
