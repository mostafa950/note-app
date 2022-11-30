import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/modules/cubit/news%20app%20cubit/news%20states.dart';
import 'package:untitled1/modules/news%20app/business%20screen/business%20screen.dart';
import 'package:untitled1/modules/news%20app/science%20screen/science%20screen.dart';
import 'package:untitled1/modules/news%20app/sports%20screen/sports screen.dart';
import 'package:untitled1/shared/network/local.dart';
import 'package:untitled1/shared/network/remote.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(InitialStates());

  static NewsCubit get(context) => BlocProvider.of(context);

  var currentIndex = 0;
  void changeIndex(int? index) {
    currentIndex = index!;
    emit(ChangeCurrentPageState());
  }

  List<Widget> screens = [
    BusinessScreen(),
    ScienceScreen(),
    SportsScreen(),
  ];

  List<dynamic> business = [];
  List<dynamic> sports = [];
  List<dynamic> science = [];
  List<dynamic> search = [];

  bool isDark = false;

  void changeMode({bool? sharedMode}) {
    if (sharedMode != null) {
      isDark = sharedMode;
      emit(ChangeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.putData(key: "isDark", value: isDark).then((value) {
        emit(ChangeModeState());
      });
    }
  }

  void getBusiness() {
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        "country": 'eg',
        'category': 'business',
        'apiKey': '8c950dd24e41479cb424553fa573b7de',
      },
    ).then((value) {
      business = value.data['articles'];
      print(business[0]);
      emit(GetBusinessDataStates());
    }).catchError((error) {
      print(error.toString());
      emit(GetErrorBusinessDataStates());
    });
  }

  void getSports() {
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        "country": 'eg',
        'category': 'sports',
        'apiKey': '8c950dd24e41479cb424553fa573b7de',
      },
    ).then((value) {
      sports = value.data['articles'];
      print(sports[2]);
      emit(GetSportsDataStates());
    }).catchError((error) {
      print(error.toString());
      emit(GetErrorSportsDataStates());
    });
  }

  void getScience() {
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        "country": 'eg',
        'category': 'science',
        'apiKey': '8c950dd24e41479cb424553fa573b7de',
      },
    ).then((value) {
      science = value.data['articles'];
      print(science[0]);
      emit(GetScienceDataStates());
    }).catchError((error) {
      print(error.toString());
      emit(GetErrorScienceDataStates());
    });
  }

  void getSearch(String? value) {
    DioHelper.getData(
      url: 'v2/everything',
      query: {
        "q": value,
        'apiKey': '8c950dd24e41479cb424553fa573b7de',
      },
    ).then((value) {
      search = value.data['articles'];
      print(search[0]);
      emit(GetSearchDataStates());
    }).catchError((error) {
      print(error.toString());
      emit(GetErrorSearchDataStates());
    });
  }


}
