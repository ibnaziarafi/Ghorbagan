class TaskFirebase {
  final String id;
  final String name;
  final String uniqueName;
  final String tag;
  final String imagePath;





  TaskFirebase({
    required this.id,
    required this.name,
    required this.uniqueName,
    required this.tag,
    required this.imagePath,
  });
}


class TaskFull {

  final String name;
  final String unique_name;
  final List full;
  final String tag;
  final String imagePath;



  TaskFull({

    required this.name,
    required this.unique_name,
    required this.full,
    required this.tag,
    required this.imagePath,
  });
}

List<TaskFull> data6 = [

  TaskFull(name:"a", unique_name: "", full:["2022-05-21","2022-05-22","2022-05-23","2022-05-24"],tag: "water",imagePath: "https://balconygardenweb-lhnfx0beomqvnhspx.netdna-ssl.com/wp-content/uploads/2021/11/croton.jpg"),
  TaskFull(name:"b", unique_name: "", full:["2022-05-21","2022-05-22","2022-05-23","2022-05-24"],tag: "mist",imagePath: "https://balconygardenweb-lhnfx0beomqvnhspx.netdna-ssl.com/wp-content/uploads/2021/11/croton.jpg"),
  TaskFull(name:"c", unique_name: "", full:["2022-05-25","2022-05-26","2022-05-27","2022-05-28"],tag: "water",imagePath: "https://balconygardenweb-lhnfx0beomqvnhspx.netdna-ssl.com/wp-content/uploads/2021/11/croton.jpg"),
  TaskFull(name:"d", unique_name: "", full:["2022-05-29"],tag: "mist",imagePath: "https://balconygardenweb-lhnfx0beomqvnhspx.netdna-ssl.com/wp-content/uploads/2021/11/croton.jpg"),


];

class Taskpass {

  final String name;
  final String imagePath;


  Taskpass({

    required this.name,
    required this.imagePath,
  });
}

class Taskpass2 {

  final String name;
  final String unique_name;
  final String imagePath;
  final List<dynamic> list;
   var summer;
   var uid;


  Taskpass2({

    required this.name,
    required this.unique_name,
    required this.imagePath,
    required this.list,
    required this.summer,
    required this.uid,
  });
}