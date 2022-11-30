import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:untitled1/modules/cubit/app%20cubit/states.dart';
import 'package:untitled1/modules/todo%20app/archived%20tasks.dart';
import 'package:untitled1/modules/todo%20app/done%20tasks.dart';
import 'package:untitled1/modules/todo%20app/new%20tasks.dart';
import 'package:untitled1/shared/components/components.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialPage());
  List<Widget> items = [
    MaterialButton(
      onPressed: () {},
      child: smallText(color: Colors.blue, name: 'todo App'),
    ),
    MaterialButton(
      onPressed: () {},
      child: smallText(color: Colors.blue, name: 'new tasks '),
    ),
    MaterialButton(
      onPressed: () {},
      child: smallText(color: Colors.blue, name: 'archived tasks '),
    ),
    MaterialButton(
      onPressed: () {},
      child: smallText(color: Colors.blue, name: 'done tasks'),
    ),
  ];

  static AppCubit get(context) => BlocProvider.of(context);

  int index = 0;

  void currentIndex(int x) {
    this.index = x;
    emit(ChangeIndex());
  }

  Database? dataBase;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];

  List<Widget> screens = [
    NewTasks(),
    DoneTasks(),
    ArchivedTasks(),
  ];
  bool isSheetDown = false;
  IconData fabIcon = Icons.add;

  void tools({IconData? icon, bool? isSheet}) {
    fabIcon = icon!;
    isSheetDown = isSheet!;
    emit(AppChangeStates());
  }

  void createDB() {
    openDatabase(
      'myDataBase.db',
      version: 1,
      onCreate: (Database db, int version) {
        // When creating the db, create the table
        db.execute(
            'CREATE TABLE Task (id INTEGER PRIMARY KEY, time TEXT, date Text, title Text , status Text)');
      },
      onOpen: (database) {
        getDatabase(database);
      },
    ).then((value) {
      value = dataBase!;
      emit(CreateDatabaseState());
    });
  }

  insertDatabase({
    @required String? time,
    @required String? date,
    @required String? title,
  }) {
    dataBase?.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO Task (time , date , title , status ) VALUES ("$time","$date","$title","new")')
          .then((value) {
        getDatabase(dataBase!);
        emit(InsertToDatabaseState());
      }).catchError((error) {
        print('error founded $error');
      });
      return null!;
    });
  }

  void getDatabase(Database database) {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];
    database.rawQuery('SELECT * FROM Task').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new')
          newTasks.add(element);
        else if (element['status'] == 'done')
          doneTasks.add(element);
        else if (element['status'] == 'archived') archivedTasks.add(element);
      });
      emit(GetDataFromDatabaseState());
    });
  }

  void updateDatabase({String? status, int? id}) {
    // Update some record
    dataBase!.rawUpdate('UPDATE Task SET status = ? WHERE id = ? ',
        ['$status', id]).then((value) {
      getDatabase(dataBase!);
      emit(UpdateDatabaseStates());
    });
  }

  void deleteDatabase({int? id}) {
    dataBase!.rawDelete('DELETE FROM Task WHERE id = ? ', [id]).then((value) {
      getDatabase(dataBase!);
      emit(DeleteDatabaseState());
    });
  }
}
