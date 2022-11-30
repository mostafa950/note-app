import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:untitled1/modules/cubit/app%20cubit/app%20cubit.dart';
import 'package:untitled1/modules/cubit/app%20cubit/states.dart';
import 'package:untitled1/shared/components/components.dart';

class ToDoLayout extends StatefulWidget {
  @override
  State<ToDoLayout> createState() => _ToDoLayoutState();
}

class _ToDoLayoutState extends State<ToDoLayout> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController controllerTime = TextEditingController();
  TextEditingController controllerDate = TextEditingController();
  TextEditingController controllerTitle = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..createDB(),
      child: BlocConsumer<AppCubit, AppStates>(listener: (context, state) {
        if (state is InsertToDatabaseState) {
          Navigator.pop(context);
        }
      }, builder: (context, state) {
        AppCubit cubit = BlocProvider.of(context);
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: words(
              color: Colors.white,
              name: 'toDo App',
            ),
            elevation: 30,
            shadowColor: Colors.black54,
            backgroundColor: Colors.black,
            bottomOpacity: 20,
            toolbarHeight: 50,
            systemOverlayStyle: SystemUiOverlayStyle.light,
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
          ),
          drawer: Container(
            width: 180,
            height: 800,
            color: Colors.black54,
            margin: EdgeInsetsDirectional.only(
              top: 89,
            ),
            padding: EdgeInsetsDirectional.only(
              start: 10,
            ),
            child: ListView.separated(
              padding: EdgeInsetsDirectional.all(0),
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => cubit.items[index],
              separatorBuilder: (context, index) => Container(
                width: 180,
                height: 1,
                color: Colors.black,
              ),
              itemCount: cubit.items.length,
            ),
          ),
          drawerEnableOpenDragGesture: true,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.index,
            elevation: 20,
            selectedItemColor: Colors.orange,
            onTap: (index) {
              cubit.currentIndex(index);
            },
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.ten_k_outlined,
                  ),
                  label: 'tasks'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.ten_k_outlined,
                  ),
                  label: 'done tasks'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.ten_k_outlined,
                  ),
                  label: 'archived tasks'),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              if (cubit.isSheetDown) {
                if (formKey.currentState!.validate()) {
                  cubit
                      .insertDatabase(
                    date: controllerDate.text,
                    time: controllerTime.text,
                    title: controllerTitle.text,
                  )
                      .then((value) {
                    cubit.fabIcon = Icons.edit;
                    controllerTitle.text = '';
                    controllerDate.text = '';
                    controllerTime.text = '';
                  });
                }
              } else {
                scaffoldKey.currentState!
                    .showBottomSheet(
                      (context) => Container(
                        color: Colors.grey[200],
                        padding: EdgeInsetsDirectional.all(10),
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              defaultTextFormedFailed(
                                name: 'title tasks',
                                icon: Icons.title,
                                type: TextInputType.text,
                                controller: controllerTitle,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: controllerTime,
                                onTap: () {
                                  showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  ).then((value) {
                                    controllerTime.text =
                                        value!.format(context);
                                  });
                                },
                                keyboardType: TextInputType.datetime,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'this is required';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.access_time_rounded,
                                  ),
                                  labelText: 'time',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              defaultTextFormedFailed(
                                  name: 'date',
                                  icon: Icons.access_time_rounded,
                                  type: TextInputType.datetime,
                                  controller: controllerDate,
                                  onTap: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.parse('2022-12-03'),
                                    ).then((value) {
                                      controllerDate.text =
                                          DateFormat.yMMMd().format(value!);
                                    });
                                  }),
                            ],
                          ),
                        ),
                      ),
                    )
                    .closed
                    .then((value) {
                  cubit.tools(icon: Icons.edit, isSheet: false);
                });
                cubit.tools(icon: Icons.add, isSheet: true);
              }
            },
            child: Icon(
              cubit.fabIcon,
              color: Colors.black,
            ),
          ),
          body: cubit.screens[cubit.index],
        );
      }),
    );
  }
}
