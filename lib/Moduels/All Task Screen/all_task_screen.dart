

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todowithgetx/Models/task_model.dart';
import 'package:todowithgetx/Moduels/Home%20Screen/task_title.dart';
import 'package:todowithgetx/Shared/Controllers/task_controller.dart';
import 'package:todowithgetx/Shared/Notification/notification_services.dart';
import 'package:todowithgetx/Shared/Style/Icon%20Broken/icon_broken.dart';
import 'package:todowithgetx/Shared/Style/Theme/theme_class.dart';

class AllTaskScreen extends StatefulWidget {


  @override
  State<AllTaskScreen> createState() => _AllTaskScreenState();
}

class _AllTaskScreenState extends State<AllTaskScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notificationHelper = NotificationHelper();
    notificationHelper.initializeNotification();
    _taskController.getTasks();
  }

  final TaskController _taskController = Get.put(TaskController());

  DateTime _selectedDate = DateTime.now();

  late NotificationHelper notificationHelper;

  @override
  Widget build(BuildContext context) {

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions:
        [
          InkWell(
            onTap:()
            {
              alertDialogBuild(context);
            },
            child: Icon(
              IconBroken.delete,
              color: Get.isDarkMode ? Colors.white : Colors.white,
            ),
          ),
          const SizedBox(
            width: 14,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children:
          [
            _showTask(screenHeight),
          ],
        ),
      ),
    );
  }

  _showTask(double screen)
  {
    return Expanded(
      child: Obx(()
      {
        if(_taskController.taskList.isEmpty)
        {
          return Center(
            child: Column(
              children:
              [
                Text('Empty'),
              ],
            ),
          );
        }
        else
        {
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index)
            {
              var task =  _taskController.taskList[index];


              var hour = task.startTime.toString().split(':')[0];
              var minute = task.endTime.toString().split(':')[1];
              debugPrint('My Time is ' + hour);
              debugPrint('My minute is ' + minute);

              var date = DateFormat.jm().parse(task.startTime);
              var myTime = DateFormat('HH:mm').format(date);

              notificationHelper.scheduledNotification(
                int.parse(myTime.toString().split(':')[0]),
                int.parse(myTime.toString().split(':')[1]),
                task,
              );
              return AnimationConfiguration.staggeredList(
                duration: const Duration(milliseconds: 500),
                position: index,
                child: SlideAnimation(
                  horizontalOffset: 400,
                  child: FadeInAnimation(
                    child: InkWell(
                      onTap: ()
                      {
                        _showBottomSheet(
                          context,
                          task,
                        );
                      },
                      child: TaskTitle(
                        task: task,
                        isAllTask: true,
                      ),
                    ),
                  ),
                ),
              );
            },
            itemCount: _taskController.taskList.length,
          );
        }
      }
      ),
    );
  }

  _showBottomSheet(context ,Task task)
  {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          )),
      context: context,
      builder: (_) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            task.isCompleted == 1
                ? Column(
              children:
              [
                InkWell(
                  highlightColor: Theme.of(context).scaffoldBackgroundColor,
                  onTap: ()
                  {
                    _taskController.deleteTasks(task);
                    notificationHelper.cancelNotification(task);
                    Get.back();
                  },
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.redAccent,
                        child: Icon(
                          Icons.clear,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        'Delete Task',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Quicksand'
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10),
                InkWell(
                  highlightColor: Theme.of(context).scaffoldBackgroundColor,
                  onTap: ()
                  {
                    _taskController.updateIsNotCompleteTasks(task.id!);
                    Get.back();
                  },
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.blueGrey,
                        child: Icon(
                          Icons.repeat,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        'Convert to ToDo',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Quicksand'
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )
                : Column(
              children: [
                InkWell(
                  onTap: ()
                  {
                    _taskController.updateIsCompleteTasks(task.id!);
                    Get.back();
                    Get.snackbar(
                        'Completed Task',
                        '${task.title}',
                        duration: Duration(seconds: 4),
                        backgroundColor: Colors.green.withOpacity(0.22),
                        icon: Icon(IconBroken.infoCircle)
                    );
                  },
                  highlightColor: Theme.of(context).scaffoldBackgroundColor,
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.green,
                        child: Icon(
                          Icons.done,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        'Task Complete',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Quicksand',
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10),
                InkWell(
                  onTap: ()
                  {
                    _taskController.deleteTasks(task);
                    notificationHelper.cancelNotification(task);
                    Get.back();
                  },
                  highlightColor: Theme.of(context).scaffoldBackgroundColor,
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.redAccent,
                        child: Icon(
                          Icons.clear,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        'Delete Task',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Quicksand'
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

  }

  void alertDialogBuild(BuildContext context)
  {
    final AlertDialog alert =  AlertDialog(
      title: Text('Delete Task'),
      content: Container(
        height: 100,
        child: Column(
          children:
          [
            Text(
              'Are you sure to delete all tasks?',
            ),
            Spacer(),
            Row(
              children:
              [
                Expanded(
                  child: ElevatedButton(
                    child: Text('Delete'),
                    onPressed: ()
                    {
                      notificationHelper.cancelAllNotification();
                      _taskController.deleteAllTasks();

                      Get.back();
                      Get.snackbar(
                          'Warning',
                          'You\'r Delete All Task',
                          duration: Duration(seconds: 4),
                          backgroundColor: Colors.amber.withOpacity(0.22),
                          icon: Icon(IconBroken.infoCircle)
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor:MaterialStateProperty.all(Colors.red),
                    ),
                  ),
                ),
                const SizedBox(width: 15,),
                Expanded(
                  child: ElevatedButton(
                    child: Text('Cancel'),
                    onPressed: ()
                    {
                      Get.back();
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
    showDialog(context: context, builder: (ctx){return alert;}, barrierDismissible: false);
  }
}
