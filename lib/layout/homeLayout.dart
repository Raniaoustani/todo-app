import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';
import 'package:todoapp1/models/archived-tasks/archived_tasks_screen.dart';
import 'package:todoapp1/models/done/done-tasls-screen.dart';
import 'package:todoapp1/models/tasks/new-tasks-screen.dart';
import 'package:todoapp1/shared/components/components.dart';

class HomeLayout extends StatefulWidget {
  @override
  _HomeLayoutState createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  late Database database;
  var scaffoldkey = GlobalKey<ScaffoldState>();
  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;
  var controller = TextEditingController();
  int currentIndex = 0;
  var titleController = TextEditingController();
  List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen(),
  ];
  List<String> titles = ['New Tasks', 'Done Tasks', 'Archived Tasks'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    createDataBase();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: screens[currentIndex],
      appBar: AppBar(
        title: Text(titles[currentIndex]),
      ),
      floatingActionButton: FloatingActionButton (
        onPressed: (){
            if (isBottomSheetShown) {
            Navigator.pop(context);
            isBottomSheetShown = false;
            setState(() {
              fabIcon = Icons.add;
            });
          } else {
            scaffoldkey.currentState?.showBottomSheet(
              (context) => Column(
                children: [
                  defaultFormField(
                      controller: titleController,
                      type: TextInputType.text,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'title must not be empty';
                        }
                        return null;
                      },
                      label: 'Task Title',
                      prefix: Icons.title),
                ],
              ),
            );
            isBottomSheetShown = true;
            setState(() {
              fabIcon = Icons.edit;
            });
          }
        },
        child: Icon(fabIcon),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        elevation: 100.0,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_box_outlined),
            label: 'Done',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.archive_outlined),
            label: 'Archived',
          ),
        ],
      ),
    );
  }

  Future<String> getName() async {
    return ('Ahmad ali');
  }

  void createDataBase() async {
    database = await openDatabase('todo.db', version: 1,
        onCreate: (database, version) {
      print('Database created');
      database
          .execute(
              'CREATE TABLE tasks(id INEGER PRIMARY KEY,title TEXT,date TEXT,time TEXT,status TEXT)')
          .then((value) {
        print('table created');
      }).catchError((Error) {
        print('ERROR WHEN CREATING TABLE ${Error.toString()}');
      });
    }, onOpen: (database) {
      print('database opened');
    });
  }

  void insertDataBase()  {
     database.transaction((txn) {
      return txn
          .rawInsert(
              'INSERT INTO tasks(title,date,time,status)VALUES("first tasks","02222","891","new")')
          .then((value) {
        print('$value inserted successfully');
      }).catchError((error) {
        print('ERROR WHEN CREATING TABLE ${error.toString()}');
      });
    });
  }
}
