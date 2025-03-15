import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/features/screens/search.dart';

import '../../core/cubit/cubit.dart';
import '../../core/cubit/states.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  TextEditingController text = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.Titles[cubit.index1]),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchScreen()),
                  );
                },
                icon: Icon(Icons.search),
              ),
            ],
          ),
          body: cubit.layouts[cubit.index1],
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.sports),
                label: "Sports",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.maps_home_work_outlined),
                label: "Buisness",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.science),
                label: "Science",
              ),
            ],
            currentIndex: cubit.index1,
            onTap: (index1) {
              cubit.ChangeScreen(index1);
            },
            showUnselectedLabels: false,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              cubit.refresh();
            },
            child: Icon(Icons.refresh),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
