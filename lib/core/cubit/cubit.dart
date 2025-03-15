import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/core/cubit/states.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../features/models/postModel.dart';
import '../../features/screens/subscreens/busniess.dart';
import '../../features/screens/subscreens/science.dart';
import '../../features/screens/subscreens/sports.dart';
import '../repositry/sharedData/netwokData/NewsApi.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);
  int index1 = 0;
  List<Widget> layouts = [Sports(), Business(), Science()];

  List<String> Titles = ["Sports", "Business", "Science"];

  void ChangeScreen(index) {
    index1 = index;
    emit(ChangeScreenState());
  }

  PostModel model = PostModel();
  List<Articles> sports = [];
  List<Articles> business = [];
  List<Articles> science = [];

  void GetSportsNews() {
    emit(NewsInitialSports());
    DioHelper.getData(
      url: "v2/top-headlines",
      query: {
        "category": "sports",
        "apiKey": "832d153146f241cdabf83ce2d661eefe",
      },
    ).then((onValue) {
      model = PostModel.fromJson(onValue.data);
      sports = model.articles!;
      print(model.totalResults);
      emit(GetSportsSuc());
    });
  }

  void GetBuisnessNews() {
    emit(NewsInitialBusiness());
    DioHelper.getData(
      url: "v2/top-headlines",
      query: {
        "category": "business",
        "apiKey": "832d153146f241cdabf83ce2d661eefe",
      },
    ).then((onValue) {
      model = PostModel.fromJson(onValue.data);
      business = model.articles!;
      print(model.totalResults);
      emit(GetBusinessSuc());
    });
  }

  void GetScienceNews() {
    emit(NewsInitialScience());
    DioHelper.getData(
      url: "v2/top-headlines",
      query: {
        "category": "sports",
        "apiKey": "832d153146f241cdabf83ce2d661eefe",
      },
    ).then((onValue) {
      model = PostModel.fromJson(onValue.data);
      science = model.articles!;
      print(model.totalResults);
      emit(GetScienceSuc());
    });
  }

  List<Articles> SearchLis = [];

  void GetSearchNews({required search}) {
    emit(NewsInitialState());
    DioHelper.getData(
      url: "v2/everything",
      query: {"q": "${search}", "apiKey": "832d153146f241cdabf83ce2d661eefe"},
    ).then((onValue) {
      model = PostModel.fromJson(onValue.data);
      SearchLis = model.articles!;
      print(model.totalResults);
      emit(GetSportsSuc());
    });
  }

  void refresh() {
    if (index1 == 0) {
      sports = [];
      GetSportsNews();
    } else if (index1 == 1) {
      business = [];
      GetBuisnessNews();
    } else {
      science = [];
      GetScienceNews();
    }
    emit(RefreshDone());
  }

  void openURL(url1) async {
    final Uri url = Uri.parse(url1);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
      emit(LaunchSucc());
    } else {
      throw 'Could not launch $url';
    }
  }
}
