import 'package:flutter/material.dart';

import 'package:todo_list/features/firstStage/presentation/pages/task_edit_page.dart';

import 'package:todo_list/features/firstStage/presentation/widgets/sliver_delegate.dart';

import 'package:todo_list/features/firstStage/presentation/widgets/task_list_widget.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    super.key,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
        decoration: const BoxDecoration(),
      )),
    );
  }
}

class SliverAppBarClass extends StatefulWidget {
  const SliverAppBarClass({super.key});

  @override
  State<SliverAppBarClass> createState() => _SliverAppBarClassState();
}

class _SliverAppBarClassState extends State<SliverAppBarClass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: CustomSliverPersistentHeaderDelegate(
                openHeight: 164,
                closedHeight: 84,
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        left: 8, right: 8, bottom: 30),
                    child: Card(
                      semanticContainer: false,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      elevation: 4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TaskListWidget(),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 72, bottom: 14, top: 14),
                            child: InkWell(
                                onTap: () => Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      return const TaskEditPage();
                                    })),
                                child: const Text('Новое')),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                childCount: 1,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 32),
        child: FloatingActionButton(
          onPressed: () =>
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return const TaskEditPage();
          })),
          child: const Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
