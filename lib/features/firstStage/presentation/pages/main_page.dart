import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/features/firstStage/presentation/pages/task_edit_page.dart';
import 'package:todo_list/features/firstStage/presentation/provider/provider.dart';
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

class SliverAppBarExample extends StatefulWidget {
  const SliverAppBarExample({super.key});

  @override
  State<SliverAppBarExample> createState() => _SliverAppBarExampleState();
}

late DateTime selectedDate;

class _SliverAppBarExampleState extends State<SliverAppBarExample> {

  @override
  Widget build(BuildContext context) {
      ProviderTask provider = Provider.of<ProviderTask>(context);
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              expandedHeight: 144,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsets.only(left: 80),
                title: Text(
                  'Мои дела',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
                child: Padding(
                  padding: const EdgeInsets.only(left: 80, right: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Text('Выполнено - ${provider.completedTasks}'),
                      InkWell(
                        onTap: () {
                          provider.changedshow();
                          if (!provider.showedAllTasks) {
                           
                          provider.getUncompletedTasks();
                          
                          }
                          
                          print("все таски ${provider.listAllTasks}");
                          print("невыполненные таски ${provider.listUncomletedTasks}");
                        },
                        child: Image.asset( provider.showedAllTasks ? 'assets/icons/visibility_off.png' :
                          'assets/icons/visibility.png',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        left: 8, right: 8, top: 18, bottom: 30),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return const TaskEditPage();
        })),
        child: const Icon(Icons.add),
      ),
    );
  }
}
