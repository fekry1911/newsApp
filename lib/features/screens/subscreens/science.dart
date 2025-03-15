import 'package:auto_size_text/auto_size_text.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../core/cubit/cubit.dart';
import '../../../core/cubit/states.dart';
import '../webView.dart';
import '../../modules/cardModel.dart';

class Science extends StatelessWidget {
  const Science({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<NewsCubit, NewsStates>(
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.science.isNotEmpty,
          builder: (context) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => WebViewScreen(
                          url: cubit.science[index].url!,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height*.15,
                    child: CardDesign(
                      urlToImage:
                      cubit.science[index].urlToImage ??
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQJ7oka1Shx4WugBk4022ecxU6_3yZg6QLYLw&s",
                      title: cubit.science[index].source?.name!,
                      description:
                      cubit.science[index].description ?? "unknown",
                    ),
                  ),
                );
              },
              itemCount: cubit.model.articles!.length,
            );
          },
          fallback: (context) {
            return Center(
              child: LoadingAnimationWidget.twistingDots(
                leftDotColor: const Color(0xFF1A1A3F),
                rightDotColor: const Color(0xFFEA3799),
                size: 50,
              ),
            );
          },
        );
      },

      listener: (context, state) {},
    );
  }
}
