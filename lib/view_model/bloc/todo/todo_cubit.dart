import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:todoappv2/model/todomodel/todo_model.dart';
import 'package:todoappv2/view_model/bloc/todo/todo_states.dart';
import 'package:todoappv2/view_model/data/local/shared_keys.dart';
import 'package:todoappv2/view_model/data/local/shared_preference.dart';
import 'package:todoappv2/view_model/data/network/dio_helper.dart';
import 'package:todoappv2/view_model/data/network/end_points.dart';

class TodoCubit extends Cubit<TodoCubitStates> {
  TodoCubit() :super(TodoinitState());

  static TodoCubit get(context) => BlocProvider.of<TodoCubit>(context);
  List<TodoModel> todoAppCubitModel = [];
  List<NewTodoModel>newTodoTaskList = [];
  int currentIndex = 0;

  void changeIndex(int index) {
    currentIndex = index;
    setDataFromModelToControllers();
  }

  void setDataFromModelToControllers() {
    titleController.text = newTodoModel?.data?.tasks?[currentIndex].title ?? "";
    descriptionController.text = newTodoModel?.data?.tasks?[currentIndex].description ?? "";
    startDateController.text = newTodoModel?.data?.tasks?[currentIndex].startDate ?? "";
    endDateController.text = newTodoModel?.data?.tasks?[currentIndex].endDate ?? "";
    statusController.text=newTodoModel?.data?.tasks?[currentIndex].status??"";
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController statusController=TextEditingController();

  Future<void> addTodoTask() async {
    TodoModel todoObject = TodoModel(
        title: titleController.text,
        description: descriptionController.text,
        firstDate: startDateController.text,
        lastDate: endDateController.text
    );
    todoAppCubitModel.add(todoObject);
    resetControllers();
    emit(AddedTaskState());
  }

  void resetControllers() {
    titleController.clear();
    descriptionController.clear();
    startDateController.clear();
    endDateController.clear();
    statusController.clear();
  }

  Future<void> editTask() async {
    setDataFromControllerToList();
    resetControllers();
    currentIndex = 0;
    emit(EditTodoState());
  }

  void setDataFromControllerToList() {
    todoAppCubitModel[currentIndex].title = titleController.text;
    todoAppCubitModel[currentIndex].description = descriptionController.text;
    todoAppCubitModel[currentIndex].firstDate = startDateController.text;
    todoAppCubitModel[currentIndex].lastDate = endDateController.text;
  }

  Future<void> deleteTask() async {
    todoAppCubitModel.removeAt(currentIndex);
    emit(RemoveTasksState());
  }

  NewTodoModel? newTodoModel;
  StatisticsModel? statistics;

  Future<void> getAllTasks() async {
    emit(GetAllTasksLoadingState());
    await DioHelper.get(
        endPoint: EndPoints.tasks, token: LocalData.get(key: SharedKeys.token,))
        .then((value) {
      print(value?.data);
      newTodoModel = NewTodoModel.fromJson(value?.data);
      if((newTodoModel?.data?.meta?.lastPage??0)==(newTodoModel?.data?.meta?.currentPage??0)){
        hasMoreTasks=false;
      };
      log(jsonEncode(value?.data));
      emit(GetAllTasksSuccessState());
    }).catchError((error) {
      if (error is DioException) {
        print(error.response?.data);
      }
      emit(GetAllTasksErrorState());
      throw error;
    });
  }
  Future<void> fetchNewTasks() async {
    isLoadingTasks=true;
    emit(GetMoreTasksLoadingState());
    await DioHelper.get(
        endPoint: EndPoints.tasks, token: LocalData.get(key: SharedKeys.token,),
     params: {
          'page':(newTodoModel?.data?.meta?.currentPage??0)+1
        }
    )
        .then((value) {
          isLoadingTasks=false;
      print(value?.data);
      NewTodoModel secondNewTodoModel = NewTodoModel.fromJson(value?.data);
      newTodoModel?.data?.meta=secondNewTodoModel.data?.meta;
      newTodoModel?.data?.tasks?.addAll(secondNewTodoModel.data?.tasks??[]);
      if((newTodoModel?.data?.meta?.lastPage??0)==(newTodoModel?.data?.meta?.currentPage??0)){
        hasMoreTasks=false;
      };
      log(jsonEncode(value?.data));
      emit(GetMoreTasksSuccessState());
    }).catchError((error) {
      isLoadingTasks=false;
      if (error is DioException) {
        print(error.response?.data);
      }
      emit(GetMoreTasksErrorState());
      throw error;
    });
  }
  ScrollController? sController=ScrollController();
  void initController(){
    sController=ScrollController();
  }
  void disposeController(){
    sController?.dispose();
  }
  void scrollListener(){
    sController?.addListener(() {
      if(sController!.position.atEdge && sController!.position.pixels!=0 && !isLoadingTasks && hasMoreTasks ){
        print('You Are At  Bottom');
        fetchNewTasks();
      }
    });
  }
bool isLoadingTasks=false;
  bool hasMoreTasks=true;
  Future<void> storeNewTask() async {
    emit(StoreNewTaskLoadingState());
    await DioHelper.post(endPoint: EndPoints.tasks, formData: FormData.fromMap(
     { "title":titleController.text,
       "description":descriptionController.text,
       "start_date":startDateController.text,
       "end_date":endDateController.text,
       "status":statusController.text
     }

    ), token: LocalData.get(key: SharedKeys.token)).then((value) {
      print(value?.data);
      getAllTasks();
      emit(StoreNewTaskSuccessState());
    }).catchError((error){
      if(error is DioException){
        print(error.response?.data);
      }
      emit(StoreNewTaskErrorState());
      throw error;
    });
  }
XFile? image;
  void takePhotoFromUser()async {
    emit(ImageLoadingState());
    var status= await Permission.storage.request();
    image= await ImagePicker().pickImage(source: ImageSource.gallery);
    if(image==null){
      emit(ImageErrorState());
      return;
    }
    emit(ImageSuccessState());
  }
  Future<void>showSingleTask()async{
    emit(ShowSingleTaskLoadingState());
    await DioHelper.get(endPoint: '${EndPoints.tasks}/50',token: LocalData.get(key: SharedKeys.token)).then((value){
      print(value?.data);
      emit(ShowSingleTaskSuccessState());
    }).catchError((error){
      if(error is DioException){
        print(error.response?.data);
      }
      emit(ShowSingleTaskErrorState());
      throw error;
    });
  }
  Future<void>updateTask()async{
    emit(UpdateTaskLoadingState());
    await DioHelper.put(endPoint: '${EndPoints.tasks}/${newTodoModel?.data?.tasks?[currentIndex].id}',token: LocalData.get(key: SharedKeys.token),body:
        { "title":titleController.text,
          "description":descriptionController.text,
          "start_date":startDateController.text,
          "end_date":endDateController.text,
          "status":statusController.text
        }
    ).then((value) {
      print(value?.data);
    emit(UpdateTaskSuccessState());
    getAllTasks();
    }).catchError((error){
      if(error is DioException){
        print(error.response?.data);
      }
      emit(UpdateTaskErrorState());
      throw error;
    });
  }
  Future<void>deleteTasks()async{
    emit(DeleteTaskLoadingState());
    await DioHelper.delete(endPoint: '${EndPoints.tasks}/${newTodoModel?.data?.tasks?[currentIndex].id}',token:LocalData.get(key: SharedKeys.token)).then((value){
      print(value?.data);
      emit(DeleteTaskSuccessState());
      getAllTasks();
    }).catchError((error){
      if(error is DioException){
        print(error.response?.data);
      }
      emit(DeleteTaskErrorState());
      throw error;
    });
  }
  Future<void>getStatistics()async{
    emit(GetStatisticsLoadingState());
    await DioHelper.get(endPoint:"${EndPoints.tasks}-${EndPoints.statistics}",token: LocalData.get(key: SharedKeys.token)).then((value){
      print(value?.data);
      statistics=StatisticsModel.fromJson(value?.data);
      log(jsonEncode(value?.data));
      emit(GetStatisticsSuccessState());
    }).catchError((error){
      if(error is DioException){
        print(error.response?.data);
        emit(GetStatisticsErrorState());
      }
    });
  }
  }
