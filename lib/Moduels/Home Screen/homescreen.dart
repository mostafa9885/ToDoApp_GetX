
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todowithgetx/Models/task_model.dart';
import 'package:todowithgetx/Moduels/All%20Task%20Screen/all_task_screen.dart';
import 'package:todowithgetx/Moduels/Task/add_task_screen.dart';
import 'package:todowithgetx/Moduels/Home%20Screen/task_title.dart';
import 'package:todowithgetx/Shared/Colors%20and%20Icons/colors_icons.dart';
import 'package:todowithgetx/Shared/Controllers/task_controller.dart';
import 'package:todowithgetx/Shared/Style/Icon%20Broken/icon_broken.dart';
import 'package:todowithgetx/Shared/Style/Theme/theme_class.dart';
import 'package:todowithgetx/Shared/Notification/notification_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}



final TaskController _taskController = Get.put(TaskController());
DateTime _selectedDate = DateTime.now();

class _HomeScreenState extends State<HomeScreen> {
  late NotificationHelper notificationHelper;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notificationHelper = NotificationHelper();
    notificationHelper.initializeNotification();
    _taskController.getTasks();
  }

  @override
  Widget build(BuildContext context) {

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    var _dateTimeController = DatePickerController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions:
        [
          const SizedBox(
            width: 7,
          ),
          IconButton(
            onPressed: () {
              ThemeServices().switchThemeMode();
              // notificationHelper.displayNotification(
              //     title: 'Change Theme', body: 'You are Change Theme app');
            },
            icon: Get.isDarkMode
                ? Icon(Icons.wb_sunny_rounded)
                : Icon(Icons.brightness_2),
          ),
          InkWell(
            onTap:()
            {
              final AlertDialog alert =  AlertDialog(
                content: Container(
                  height: 100,
                  child: Column(
                    children:
                    [
                      Text('Number Of Task: ${_taskController.taskList.length}'),
                      Spacer(),
                      Row(
                        children:
                        [
                          Expanded(
                            child: ElevatedButton(
                              child: Text('Show Tasks'),
                              onPressed: ()
                              {

                                Get.back();
                                Get.to(AllTaskScreen());

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
            },
            child: Icon(
              IconBroken.infoCircle,
              color: Get.isDarkMode ? Colors.white : Colors.white,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${DateFormat.yMMMMd().format(_selectedDate)}',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Today',
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                Spacer(),
                InkWell(
                  highlightColor: Theme.of(context).scaffoldBackgroundColor,
                  onTap: () {
                    Get.to(AddTaskScreen());
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 110,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.lightBlue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            IconBroken.paperPlus,
                            color: ColorApp.whiteColor,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            'Add Task',
                            style: TextStyle(
                              color: ColorApp.whiteColor,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: DatePicker(
                DateTime.now(),
                controller: _dateTimeController,
                selectionColor: Colors.blue,
                width: 72,
                height: 100,
                initialSelectedDate: DateTime.now(),
                monthTextStyle: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
                dateTextStyle: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
                dayTextStyle: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
                selectedTextColor: ColorApp.whiteColor,
                onDateChange: (newDate) {
                  setState(() {
                    _selectedDate = newDate;
                  });
                },
              ),
            ),
            const SizedBox(height: 5),

            _showTask(screenHeight),
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
                ListIsEmpty(screen),
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


              if(
              task.repeat == 'Daily' || task.date == DateFormat.yMd().format(_selectedDate)
              ||
              (task.repeat == 'Weekly' && _selectedDate.difference(DateFormat.yMd().parse(task.date)).inDays % 7 ==0)
              ||
              (task.repeat == 'Monthly' && DateFormat.yMd().parse(task.date).day == _selectedDate.day)
              )
              {
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
                          isAllTask: false,
                        ),
                      ),
                    ),
                  ),
                );
              }
              else
              {
                return Container();
              }

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
                        icon: Icon(IconBroken.infoCircle, color: Colors.white,),
                        colorText: Colors.white,
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

}




Widget ListIsEmpty(double screen) => Container(

  child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: screen * 0.19,
          ),

          Icon(IconBroken.infoCircle, size: 50,),
          SizedBox(
            height: 8,
          ),
          Text(
            'You don\'t have any tasks !',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: 'Quicksand'),
          ),
          Text(
            'Enter Any Task.',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              fontFamily: 'Quicksand',
              height: 1.7
            ),
          ),
        ],
      ),
);

