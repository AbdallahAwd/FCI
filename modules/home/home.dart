import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medtient/models/get_stack_data.dart';
import 'package:medtient/modules/subjects/sub.dart';
import 'package:medtient/shared/compnents/component.dart';
import 'package:medtient/shared/cubits/home/home_cubit.dart';
import 'package:medtient/shared/cubits/home/home_states.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => buildStack(
                        HomeCubit.get(context).stackItems[index], context , index),
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                        ),
                    itemCount: HomeCubit.get(context).stackItems.length),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget buildStack(GetStack getStack, context , index) {
  return GestureDetector(
    onTap: ()
    {
      HapticFeedback.vibrate();
      navigateTo(context, SubScreen(index));
    },
    child: Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          width: double.infinity,
          height: 180,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: NetworkImage(getStack.image),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: 180,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(getStack.opacity),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        Text(
          getStack.text,
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(fontSize: 35, color: Colors.white, fontFamily: 'Cairo'),
        )
      ],
    ),
  );
}


