

class Task
{
  int? id;
  int? color;
  int? remind;
  int? isCompleted;
  String? title;
  String? note;
  String? date;
  String? startTime;
  String? endTime;
  String? repeat;

  Task({
    this.id,
    this.color,
    this.remind,
    this.isCompleted,
    this.title,
    this.note,
    this.date,
    this.startTime,
    this.endTime,
    this.repeat,
});


  Map<String, dynamic> toJson()
  {
    return
      {
        'id' : id,
        'color' : color,
        'remind' : remind,
        'isCompleted' : isCompleted,
        'title' : title,
        'note' : note,
        'date' : date,
        'startTime' : startTime,
        'endTime' : endTime,
        'repeat' : repeat,
      };
  }


  Task.fromJson(Map<String, dynamic>json)
  {
    id = json['id'];
    color = json['color'];
    remind = json['remind'];
    isCompleted = json['isCompleted'];
    title = json['title'];
    note = json['note'];
    date = json['date'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    repeat = json['repeat'];
  }

}