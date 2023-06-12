

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/common/colors.dart';
import 'package:todo_list/features/presentation/provider/provider.dart';

class TaskEditPage extends StatefulWidget {
  const TaskEditPage({super.key});

  @override
  State<TaskEditPage> createState() => _TaskEditPageState();
}

class _TaskEditPageState extends State<TaskEditPage> {
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
                    const Text(
                      'Сохранить',
                      style: TextStyle(
                          fontSize: 16, color: AppColorsLightTheme.blue),
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
                      const Padding(
                        padding:
                            EdgeInsets.only(left: 16.0, right: 16, top: 23),
                        child: Card(
                          margin: EdgeInsets.zero,
                          semanticContainer: false,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                          ),
                          elevation: 4,
                          child: TextField(),
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
                            InkWell(onTap: () {}, child: const Text('Нет')),
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
                          subtitle:  Text(provider.day!),
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
                            Image.asset(
                              'assets/icons/delete.png',
                              color: Colors.red,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {},
                              child: InkWell(
                                onTap: () {},
                                child: const Text(
                                  'Удалить',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ),
                          ],
                        ),
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
