import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/modules/cubit/app%20cubit/app%20cubit.dart';
import 'package:untitled1/modules/cubit/app%20cubit/states.dart';
import 'package:untitled1/shared/components/components.dart';

class NewTasks extends StatelessWidget {
  const NewTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = AppCubit.get(context).newTasks;
        return itemBuilder(tasks);
      },
    );
  }
}
