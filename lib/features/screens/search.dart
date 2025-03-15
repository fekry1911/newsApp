import 'package:auto_size_text/auto_size_text.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:newsapp/features/screens/webView.dart';
import '../../../core/cubit/cubit.dart';
import '../../../core/cubit/states.dart';
import '../modules/cardModel.dart';


class SearchScreen extends StatelessWidget {
   SearchScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<NewsCubit, NewsStates>(
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: TextFormField(
              onChanged: (text){
                cubit.GetSearchNews(search: text);
              },
              onFieldSubmitted: (text){
                cubit.GetSearchNews(search: text);
              },
              decoration: InputDecoration(
                hintText: "tap to search",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    4,
                  ), // Rounded border
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20), // Default border color
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    width: 1,
                  ), // Border when focused
                ),
                filled: true,
              ),
            ),
          ),
          body: ConditionalBuilder(
            condition: cubit.SearchLis.isEmpty,
            fallback: (context) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => WebViewScreen(
                            url: cubit.SearchLis[index].url!,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height*.15,
                      child: CardDesign(
                        urlToImage:
                        cubit.SearchLis[index].urlToImage ??
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQJ7oka1Shx4WugBk4022ecxU6_3yZg6QLYLw&s",
                        title: cubit.SearchLis[index].source?.name!,
                        description:
                        cubit.SearchLis[index].description ?? "unknown",
                      ),
                    ),
                  );
                },
                itemCount: cubit.SearchLis.length,
              );
            },
            builder: (context) {
              return Center(
                child: LoadingAnimationWidget.twistingDots(
                  leftDotColor: const Color(0xFF1A1A3F),
                  rightDotColor: const Color(0xFFEA3799),
                  size: 50,
                ),
              );
            },
          ),
        );
      },

      listener: (context, state) {},
    );
  }
}
