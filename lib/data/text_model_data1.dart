class TaskF {
  final String id;
  final String name;




  TaskF({
    required this.id,
    required this.name,
  });
}


List<TaskF> data1 = [
  TaskF(id:"2022-05-21", name:'a'),
  TaskF(id:"2022-05-22", name:'b'),
  TaskF(id:"2022-05-21", name:'c'),
  TaskF(id:"2022-05-23", name:'d'),
  TaskF(id:"2022-05-23", name:'e'),
];

class Taskj {

  final String name;
  final List full;

  Taskj({

    required this.name,
    required this.full,
  });
}

List<Taskj> data4 = [

  Taskj(name:"a", full:["2022-05-21","2022-05-22","2022-05-23","2022-05-24"]),
  Taskj(name:"b", full:["2022-05-21","2022-05-22","2022-05-23","2022-05-24"]),
  Taskj(name:"c", full:["2022-05-25","2022-05-26","2022-05-27","2022-05-28"]),
  Taskj(name:"d", full:["2022-05-29"]),


];

class Taskk {

  final String name;
  final List full;

  Taskk({

    required this.name,
    required this.full,
  });
}

List<Taskk> data5 = [

  Taskk(name:"a", full:["2022-05-21","2022-05-22","2022-05-23","2022-05-24"]),
  Taskk(name:"b", full:["2022-05-21","2022-05-22","2022-05-23","2022-05-24"]),
  Taskk(name:"c", full:["2022-05-25","2022-05-26","2022-05-27","2022-05-28"]),
  Taskk(name:"d", full:["2022-05-29"]),


];