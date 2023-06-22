import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/common/colors.dart';
import 'package:todo_list/common/fonts_size.dart';
import 'package:todo_list/features/firstStage/presentation/provider/provider.dart';
import 'package:todo_list/features/firstStage/presentation/widgets/dropdown_button_widget.dart';
import 'package:todo_list/generated/locale_keys.g.dart';

class TaskEditPage extends StatefulWidget {
  final int index;
  final bool edited;
  final bool showedalltasks;
  final String? textTitlefromAllTask;
  final String? textTitlefromUncompletedTask;

  const TaskEditPage(
      {super.key,
      this.edited = false,
      this.showedalltasks = true,
      this.textTitlefromAllTask,
      this.textTitlefromUncompletedTask,
      this.index = 0});

  @override
  State<TaskEditPage> createState() => _TaskEditPageState();
}

class _TaskEditPageState extends State<TaskEditPage> {
  TextEditingController _textcontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.edited) {
      String? textTask = '';
      if (widget.showedalltasks) {
        textTask = widget.textTitlefromAllTask;
      } else {
        textTask = widget.textTitlefromUncompletedTask;
      }
      _textcontroller = TextEditingController(text: textTask);
    }
  }

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
                padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        provider.changeEditor(false);
                        Navigator.of(context).pop();
                      },
                      child: Image.asset(
                        'assets/icons/close.png',
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (provider.isEdited) {
                          provider.editTask(
                              widget.index,
                              _textcontroller.text,
                              false,
                              provider.priority,
                              provider.switcher
                                  ? '${provider.selectedDay}'
                                  : '');
                        } else {
                          provider.createTask(
                              _textcontroller.text,
                              false,
                              provider.priority,
                              provider.switcher
                                  ? '${provider.selectedDay}'
                                  : '');
                        }

                        afterCreatingOrDeleting(provider);
                        Navigator.of(context).pop();
                      },
                      child:  Text(
                        LocaleKeys.save.tr(),
                        style: const TextStyle(
                            fontSize: 14,
                            height: 24 / 14,
                            fontWeight: FontWeight.w500,
                            color: AppColorsLightTheme.blue),
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
                              style: const TextStyle(
                                  fontSize: AppTextSizes.body,
                                  height: AppHeights.body,
                                  color: AppColorsLightTheme.primary),
                              textCapitalization: TextCapitalization.sentences,
                              textInputAction: TextInputAction.done,
                              decoration:  InputDecoration(
                                contentPadding: const EdgeInsets.all(16),
                                hintText: LocaleKeys.whatToDO.tr(),
                                hintStyle: const TextStyle(
                                    color: AppColorsLightTheme.tertiary,
                                    fontSize: AppTextSizes.body,
                                    height: AppHeights.body),
                                border: InputBorder.none,
                              ),
                              controller: _textcontroller,
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
                             Text(
                              LocaleKeys.importance.tr(),
                              style: const TextStyle(
                                  fontSize: AppTextSizes.body,
                                  height: AppHeights.body,
                                  color: AppColorsLightTheme.primary),
                            ),
                            DropButtonWidget(provider: provider),
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
                              ? Text(
                                  provider.selectedDay!,
                                  style: const TextStyle(
                                      fontSize: AppTextSizes.subhead,
                                      fontWeight: FontWeight.w400,
                                      height: AppHeights.subhead,
                                      color: AppColorsLightTheme.blue),
                                )
                              : const Text(''),
                          title:  Text(
                            LocaleKeys.complited.tr(),
                            style: const TextStyle(
                                fontSize: AppTextSizes.body,
                                height: AppHeights.body,
                                color: AppColorsLightTheme.primary),
                          ),
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
                              absorbing: !provider.isEdited ? true : false,
                              child: InkWell(
                                onTap: () => provider
                                    .deleteTaskfromlistAllTasks(widget.index),
                                child: Image.asset(
                                  'assets/icons/delete.png',
                                  color: !provider.isEdited
                                      ? AppColorsLightTheme.disable
                                      : Colors.red,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            AbsorbPointer(
                              absorbing: !provider.isEdited ? true : false,
                              child: InkWell(
                                onTap: () {
                                  provider
                                      .deleteTaskfromlistAllTasks(widget.index);
                                  afterCreatingOrDeleting(provider);
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  LocaleKeys.delete.tr(),
                                  style: TextStyle(
                                      color: !provider.isEdited
                                          ? AppColorsLightTheme.disable
                                          : AppColorsLightTheme.red,
                                      fontSize: AppTextSizes.body,
                                      height: AppHeights.body),
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

  void afterCreatingOrDeleting(ProviderTask provider) {
    provider.changeSwitcher(false);
    provider.changePriority(0);
    provider.countAllCompletedTasks();
    provider.getUncompletedTasks();
    provider.changeEditor(false);
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
