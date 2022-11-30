import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/modules/cubit/news%20app%20cubit/news%20cubit.dart';
import 'package:untitled1/modules/cubit/news%20app%20cubit/news%20states.dart';
import 'package:untitled1/shared/components/components.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var items = NewsCubit.get(context).business;
        if (items.length == 0) {
          return Center(child: CircularProgressIndicator());
        } else
          return listOfGetInfo(items);
      },
    );
  }
}
