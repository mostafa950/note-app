import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/modules/cubit/news%20app%20cubit/news%20cubit.dart';
import 'package:untitled1/modules/cubit/news%20app%20cubit/news%20states.dart';
import 'package:untitled1/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        NewsCubit cubit = NewsCubit.get(context);
        var items = NewsCubit.get(context).search;
        TextEditingController controllerSearch = TextEditingController();
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  obscureText: false,
                  validator: (value) {},
                  controller: controllerSearch,
                  decoration: InputDecoration(
                    labelText: "search",
                    border: OutlineInputBorder(),
                    fillColor: Colors.grey,
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (value) {
                    NewsCubit.get(context).getSearch(value);
                  },
                ),
              ),
              Expanded(
                child: listOfGetInfo(items),
              ),
            ],
          ),
        );
      },
    );
  }
}
