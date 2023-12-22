class TodoModel{
  String? title;
  String? description;
  String? firstDate;
  String? lastDate;
  TodoModel({this.title,this.description,this.firstDate,this.lastDate});
}
class NewTodoModel {
  Data? data;
  String? message;
  int? status;

  NewTodoModel({this.data, this.message, this.status});

  NewTodoModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    data['status'] = status;
    return data;
  }
}

class Data {
  List<Tasks>? tasks;
  Meta? meta;

  Data({this.tasks, this.meta});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['tasks'] != null) {
      tasks = <Tasks>[];
      json['tasks'].forEach((v) {
        tasks!.add( Tasks.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (tasks != null) {
      data['tasks'] = tasks!.map((v) => v.toJson()).toList();
    }
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    return data;
  }
}

class Tasks {
  int? id;
  String? title;
  String? description;
  String? image;
  String? startDate;
  String? endDate;
  String? status;

  Tasks(
      {this.id,
        this.title,
        this.description,
        this.image,
        this.startDate,
        this.endDate,
        this.status});

  Tasks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['image'] = image;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['status'] = status;
    return data;
  }
}

class Meta {
  int? total;
  int? perPage;
  int? currentPage;
  int? lastPage;

  Meta({this.total, this.perPage, this.currentPage, this.lastPage});

  Meta.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    perPage = json['per_page'];
    currentPage = json['current_page'];
    lastPage = json['last_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['total'] = total;
    data['per_page'] = perPage;
    data['current_page'] = currentPage;
    data['last_page'] = lastPage;
    return data;
  }
}

class StatisticsModel {
  Statistics? data;
  String? message;
  int? status;

  StatisticsModel({this.data, this.message, this.status});

  StatisticsModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ?  Statistics.fromJson(json['data']) : null;
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}

class Statistics {
  int?  New;
  int? outdated;
  int? doing;
  int? compeleted;


  Statistics({this.New, this.outdated, this.doing, this.compeleted,});

Statistics.fromJson(Map<String, dynamic> json) {
  New= json['new'];
outdated = json['outdated'];
doing = json['doing'];
compeleted = json['compeleted'];
}

Map<String, dynamic> toJson() {
final Map<String, dynamic> data = new Map<String, dynamic>();
data['new'] = this.New;
data['outdated'] = this.outdated;
data['doing'] = this.doing;
data['compeleted'] = this.compeleted;
return data;
}
}
