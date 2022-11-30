import 'package:circle_bottom_navigation_bar/circle_bottom_navigation_bar.dart';
import 'package:circle_bottom_navigation_bar/widgets/tab_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/modules/cubit/news%20app%20cubit/news%20cubit.dart';
import 'package:untitled1/modules/cubit/news%20app%20cubit/news%20states.dart';
import 'package:untitled1/modules/news%20app/business%20screen/business%20screen.dart';
import 'package:untitled1/modules/news%20app/search%20screen/search%20screen.dart';

class NewsLayout extends StatefulWidget {

  @override
  State<NewsLayout> createState() => _NewsLayoutState();
}

class _NewsLayoutState extends State<NewsLayout> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        NewsCubit cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'News App',
            ),
            actions: [
              InkWell(
                onTap: ()
                {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> SearchScreen(),),);
                },
                child: Icon(
                  Icons.search,
                ),
              ),
              SizedBox(width: 20,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: (){
                    cubit.changeMode();
                  },
                  child: Icon(
                    Icons.brightness_4_outlined,
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
           items:
           [
             BottomNavigationBarItem(icon: Icon(Icons.business,),label: 'business'),
             BottomNavigationBarItem(icon: Icon(Icons.science,),label: 'science'),
             BottomNavigationBarItem(icon: Icon(Icons.sports,),label: 'sports'),
           ],
            currentIndex: cubit.currentIndex,
            onTap: (value) {cubit.changeIndex(value);},
          ),
          body: cubit.screens[cubit.currentIndex],
        );
      },
    );
  }
}
