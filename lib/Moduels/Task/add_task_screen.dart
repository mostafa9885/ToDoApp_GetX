
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todowithgetx/Models/task_model.dart';
import 'package:todowithgetx/Shared/Colors%20and%20Icons/colors_icons.dart';
import 'package:todowithgetx/Shared/Controllers/task_controller.dart';
import 'package:todowithgetx/Shared/Style/Icon%20Broken/icon_broken.dart';
import 'package:todowithgetx/Shared/Style/Theme/theme_class.dart';
import 'package:todowithgetx/Shared/Notification/notification_services.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}


final TaskController _taskController = Get.put(TaskController());
var titleController = TextEditingController();
var noteController = TextEditingController();
var dateController = TextEditingController();
var startTimeController = TextEditingController();
var endTimeController = TextEditingController();
DateTime _selectedDate = DateTime.now();
String startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
String endTime = DateFormat('hh:mm a').format(DateTime.now().add(Duration(minutes: 15))).toString();
int _selectedRemind = 0;
List<int> remindList = [0, 5,10,15,20];
String _selectedRepeat = 'None';
List<String> repeatList = ['None', 'Daily', 'Weekly', 'Monthly'];
int _selectedColor = 0;

class _AddTaskScreenState extends State<AddTaskScreen> {
  late NotificationHelper notificationHelper;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: ()
          {
            Get.back();
          },
          icon: Icon(IconBroken.arrowLeft2),
        ),
        title: Text(
            'Add Task',
        ),
        titleSpacing: 0,
        actions:
        [
          const SizedBox(
            width: 7,
          ),
          IconButton(
            onPressed: ()
            {
              ThemeServices().switchThemeMode();
            },
            icon: Get.isDarkMode ? Icon(Icons.wb_sunny_rounded) : Icon(Icons.brightness_2),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children:
            [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                [
                  Text(
                      'Title',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w600,
                      ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Enter title here',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10.0))
                      ),
                    ),
                    controller: titleController,
                    keyboardType: TextInputType.text
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                [
                  Text(
                    'Note',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Enter note here',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10.0))
                      ),
                    ),
                    controller: noteController,
                    keyboardType: TextInputType.text,
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                [
                  Text(
                    'Date',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText:  '${DateFormat.yMd().format(_selectedDate)}',
                        hintStyle: TextStyle(
                          color: Get.isDarkMode ? Colors.white : Colors.black.withOpacity(1),
                          fontFamily: 'Quicksand',
                        ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10.0))
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(IconBroken.calendar),
                        onPressed: ()
                        {

                          _getDateFunction();
                          // showDatePicker(
                          //     context: context,
                          //     initialDate: DateTime.now(),
                          //     firstDate: DateTime(1998),
                          //     lastDate: DateTime(3000),
                          // ).then((value)
                          // {
                          //   dateController.text = DateFormat.yMd().format(value!);
                          // });
                        },
                      )
                    ),
                    controller: dateController,
                    keyboardType: TextInputType.text,
                    readOnly: true,
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: 
                      [
                        Text(
                          'Start Time',
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              hintText: '${startTime}',
                              hintStyle: TextStyle(
                                color: Get.isDarkMode ? Colors.white : Colors.black.withOpacity(1),
                                fontFamily: 'Quicksand',
                              ),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(10.0))
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(IconAPP.accessTimeRounded),
                                onPressed: ()
                                {
                                  _getTimeFunction(context: context, isStartTime: true);
                                  // showTimePicker(
                                  //   context: context,
                                  //   initialTime: TimeOfDay.now(),
                                  // ).then((value)
                                  // {
                                  //   startTimeController.text = value!.format(context).toString();
                                  // });
                                },
                              )
                          ),
                          readOnly: true,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                      width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                      [
                        Text(
                          'End Time',
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              hintText: '${endTime}',
                              hintStyle: TextStyle(
                                color: Get.isDarkMode ? Colors.white : Colors.black.withOpacity(1),
                                fontFamily: 'Quicksand',
                              ),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(10.0))
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(IconAPP.accessTimeRounded),
                                onPressed: ()
                                {
                                  _getTimeFunction(context: context, isStartTime: false);
                                  // showTimePicker(
                                  //     context: context,
                                  //     initialTime: TimeOfDay.now(),
                                  // ).then((value)
                                  // {
                                  //   endTimeController.text = value!.format(context).toString();
                                  // });
                                },
                              )
                          ),
                          readOnly: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                [
                  Text(
                    'Remind',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: '$_selectedRemind minutes early',
                      hintStyle: TextStyle(
                          color: Get.isDarkMode ? Colors.white : Colors.black.withOpacity(1),
                          fontFamily: 'Quicksand',
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                          ),
                          borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                          ),
                      ),
                      suffixIcon: DropdownButton(
                        dropdownColor: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(10),
                        items: remindList
                            .map<DropdownMenuItem<String>>(
                              (int value) => DropdownMenuItem<String>(
                            child: Text('${value}'),
                            value: value.toString(),
                          ),
                        ).toList(),
                        icon: Icon(IconBroken.arrowDown_2),
                        underline: Container(height: 0),
                        onChanged: (String? newValue)
                        {
                          setState(() {
                            _selectedRemind = int.parse(newValue!);
                          });
                        },
                      ),
                    ),
                    keyboardType: TextInputType.text,
                    readOnly: true,
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                [
                  Text(
                    'Repeat',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: '${_selectedRepeat}',
                      hintStyle: TextStyle(
                        color: Get.isDarkMode ? Colors.white : Colors.black.withOpacity(1),
                        fontFamily: 'Quicksand',
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      suffixIcon: DropdownButton(
                        dropdownColor: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(10),
                        items: repeatList
                            .map<DropdownMenuItem<String>>(
                              (String value) => DropdownMenuItem(
                            child: Text('$value'),
                          value: value,
                          ),
                        ).toList(),
                        underline: Container(height: 0),
                        icon: Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: Icon(IconBroken.arrowDown_2),
                        ),
                        onChanged: (value)
                        {
                          setState(() {
                            _selectedRepeat = value.toString();
                          });
                        },
                      ),
                    ),
                    keyboardType: TextInputType.text,
                    readOnly: true,
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children:
                [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children:
                    [
                      Text(
                          'Color',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 17
                          ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: List.generate(
                            4,
                            (index) => InkWell(
                              highlightColor: Theme.of(context).scaffoldBackgroundColor,
                              overlayColor:MaterialStateProperty.all(Theme.of(context).scaffoldBackgroundColor),
                              onTap: ()
                              {
                                setState(() {
                                  _selectedColor = index;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: CircleAvatar(
                                  child: _selectedColor == index
                                      ?
                                      Icon(
                                        Icons.done,
                                        size: 18,
                                        color: Colors.white,
                                      )
                                      :
                                      null,
                                      radius: 16,
                                      backgroundColor: index == 0
                                      ?
                                      Colors.blue
                                      :
                                      index == 1
                                          ?
                                          Colors.redAccent
                                          :
                                          index == 2
                                              ?
                                              Colors.orangeAccent
                                              :
                                              Colors.grey,
                                ),
                              ),
                            ),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: InkWell(
                      onTap: ()
                      {
                        _validatorData();
                        _taskController.getTasks();
                        clearTextField();
                      },
                      highlightColor: Theme.of(context).scaffoldBackgroundColor,
                      overlayColor:MaterialStateProperty.all(Theme.of(context).scaffoldBackgroundColor),
                      child: Container(
                        alignment: Alignment.center,
                        width: 100,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Color(0xFF674EDB),
                            borderRadius: BorderRadius.circular(10),
                        ),
                        child:Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 2.0,
                            horizontal: 4,
                          ),
                          child: Text(
                            'Create Task',
                            style: TextStyle(
                              color: ColorApp.whiteColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


  void clearTextField()
  {
    titleController.clear();
    noteController.clear();
  }

  _getDateFunction() async
  {
    DateTime? _datePicker = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1998),
      lastDate: DateTime(3000),
    );
    if(_datePicker != null)
    {
      setState(() {
        _selectedDate = _datePicker;
      });
    }
    else
    {
      print('It\'s null');
    }
  }


  _getTimeFunction({required BuildContext context ,required bool isStartTime}) async
  {
    TimeOfDay? _timePicker = await showTimePicker(
      context: context,
      initialTime: isStartTime
          ?
          TimeOfDay.fromDateTime(DateTime.now())
          :
          TimeOfDay.fromDateTime(DateTime.now().add(const Duration(minutes: 15))),
    );
    String _formattedTime = _timePicker!.format(context);

    if(isStartTime)
    {
      setState(() {
        startTime = _formattedTime;
      });
    }
    else if (!isStartTime)
    {
      setState(() {
        endTime = _formattedTime;
      });
    }
    else
    {
      print('It\'s null');
    }

  }

}


 _validatorData()
 {
   if(titleController.text.isNotEmpty && noteController.text.isNotEmpty)
   {
     _addTaskToDb();
     Get.back();
   }
   else if(titleController.text.isEmpty || noteController.text.isEmpty)
   {
     Get.snackbar(
         'REQUIRED',
         'Title & Note Field is Required',
       colorText: Colors.white,
       backgroundColor: Colors.amber.withOpacity(0.2),
       icon: Icon(Icons.error, color: Colors.white,),
       snackPosition: SnackPosition.TOP,
       padding: EdgeInsets.all(10),
       duration: Duration(seconds: 4)
     );
   }
   else
   {
     print('Something bad happened');
   }
 }

 _addTaskToDb() async
 {
   int value = await _taskController.addTask(
     Task(
       title: titleController.text,
       note: noteController.text,
       isCompleted: 0,
       startTime:  startTime/*isstartTime? startTimeController.text : startTime.toString()*/,
       endTime: endTime/*isendTime? endTimeController.text : endTime.toString()*/,
       color: _selectedColor,
       date: DateFormat.yMd().format(_selectedDate),
       remind: _selectedRemind,
       repeat: _selectedRepeat,
     ),
   );
   print('$value');
 }

