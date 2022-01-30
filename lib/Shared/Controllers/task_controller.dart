

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:todowithgetx/Models/task_model.dart';
import 'package:todowithgetx/Shared/DataBase/database_creat.dart';

class TaskController extends GetxController
{
  final taskList = [].obs;

  addTask(Task? task)
  {
    return DataBaseHelper.insertDatabase(task);
  }

  Future<void> getTasks() async
  {
    final List<Map<String, dynamic>> tasks = await DataBaseHelper.queryDatabase();
    taskList.assignAll(tasks.map((data) => Task.fromJson(data)).toList());
  }

  void deleteTasks(Task task) async
  {
    await DataBaseHelper.deleteDatabase(task);
    getTasks();
  }

  void deleteAllTasks() async
  {
    await DataBaseHelper.deleteAllDatabase();
    getTasks();
  }

  void updateIsCompleteTasks(int id) async
  {
    await DataBaseHelper.updateDatabase(id);
    getTasks();
  }

  void updateIsNotCompleteTasks(int id) async
  {
    await DataBaseHelper.updateDatabaseTodo(id);
    getTasks();
  }

}