import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medtient/models/get_subjects.dart';
import 'package:medtient/modules/subjects/exam.dart';
import 'package:medtient/modules/subjects/shares.dart';
import 'package:medtient/modules/subjects/sheet.dart';
import 'package:medtient/modules/webview.dart';
import 'package:medtient/shared/compnents/component.dart';
import 'package:medtient/shared/cubits/home/home_cubit.dart';
import 'package:medtient/shared/cubits/subjects/subjects.dart';
import 'package:medtient/shared/cubits/subjects/subjects_states.dart';
import 'package:url_launcher/url_launcher.dart';

class SubScreen extends StatefulWidget {
  final int index;

  SubScreen(this.index,);

  @override
  State<SubScreen> createState() => _SubScreenState();
}

class _SubScreenState extends State<SubScreen> {

  @override
  Widget build(BuildContext context) {

    return Builder(builder: (context) {
      if(widget.index == 0) SubCubit.get(context).getSubjectLec('OR');
      if(widget.index == 1) SubCubit.get(context).getSubjectLec('MultiMedia');
      if(widget.index == 2) SubCubit.get(context).getSubjectLec('OOP');
      if(widget.index == 3) SubCubit.get(context).getSubjectLec('WebDev');
      if(widget.index == 4) SubCubit.get(context).getSubjectLec('DS');
      if(widget.index == 5) SubCubit.get(context).getSubjectLec('SysA');
      return BlocConsumer<SubCubit, SubStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                HomeCubit.get(context).stackItems[widget.index].text,
                style: Theme
                    .of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(fontSize: 20.0),
              ),
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  //sheet
                  InkWell(
                    onTap: ()
                    {
                      navigateTo(context, sheets(widget.index));
                    },
                    child: Row(
                      children: [
                        const Icon(
                          FontAwesomeIcons.file,
                          size: 40.0,
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        Expanded(
                          child: Text(
                            'Sheets',
                            style: Theme
                                .of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(fontSize: 16),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const Icon(Icons.arrow_forward_ios)
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  //exam
                  InkWell(
                    onTap: ()
                    {
                      navigateTo(context, Exam(widget.index));
                    },
                    child: Row(
                      children: [
                        const Icon(
                          FontAwesomeIcons.fileAlt,
                          size: 40.0,
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        Expanded(
                          child: Text(
                            'Exams',
                            style: Theme
                                .of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(fontSize: 16),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const Icon(Icons.arrow_forward_ios)
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  //Shares
                  InkWell(
                    onTap: ()
                    {
                      navigateTo(context, Shares(widget.index));
                    },
                    child: Row(
                      children: [
                        const Icon(
                          FontAwesomeIcons.share,
                          size: 40.0,
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        Expanded(
                          child: Text(
                            'Shares',
                            style: Theme
                                .of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(fontSize: 16),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const Icon(Icons.arrow_forward_ios)
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  const Divider(
                    height: 1,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Resources',
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyText1,
                  ),
                  if (widget.index == 0)
                    Scrollbar(
                      child: SizedBox(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height - 320,
                        child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) =>
                                resourcesBuilder(
                                    context,
                                    index,
                                    SubCubit
                                        .get(context)
                                        .or[index]),
                            separatorBuilder: (context, index) =>
                            const SizedBox(
                              height: 10,
                            ),
                            itemCount: SubCubit
                                .get(context)
                                .or
                                .length),
                      ),
                    ),
                  if (widget.index == 1)
                    Scrollbar(
                      child: SizedBox(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height - 320,
                        child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) =>
                                resourcesBuilder(
                                    context,
                                    index,
                                    SubCubit
                                        .get(context)
                                        .multi[index]),
                            separatorBuilder: (context, index) =>
                            const SizedBox(
                              height: 10,
                            ),
                            itemCount: SubCubit
                                .get(context)
                                .multi
                                .length),
                      ),
                    ),
                  if (widget.index == 2)
                    Scrollbar(
                      child: SizedBox(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height - 320,
                        child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) =>
                                resourcesBuilder(
                                    context,
                                    index,
                                    SubCubit
                                        .get(context)
                                        .oop[index]),
                            separatorBuilder: (context, index) =>
                            const SizedBox(
                              height: 10,
                            ),
                            itemCount: SubCubit
                                .get(context)
                                .oop
                                .length),
                      ),
                    ),
                  if (widget.index == 3)
                    Scrollbar(
                      child: SizedBox(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height - 320,
                        child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) =>
                                resourcesBuilder(
                                    context,
                                    index,
                                    SubCubit
                                        .get(context)
                                        .webDev[index]),
                            separatorBuilder: (context, index) =>
                            const SizedBox(
                              height: 10,
                            ),
                            itemCount: SubCubit
                                .get(context)
                                .webDev
                                .length),
                      ),
                    ),
                  if (widget.index == 4)
                    Scrollbar(
                      child: SizedBox(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height - 320,
                        child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) =>
                                resourcesBuilder(
                                    context,
                                    index,
                                    SubCubit
                                        .get(context)
                                        .ds[index]),
                            separatorBuilder: (context, index) =>
                            const SizedBox(
                              height: 10,
                            ),
                            itemCount: SubCubit
                                .get(context)
                                .ds
                                .length),
                      ),
                    ),
                  if (widget.index == 5)
                    Scrollbar(
                      child: SizedBox(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height - 320,
                        child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) =>
                                resourcesBuilder(
                                    context,
                                    index,
                                    SubCubit
                                        .get(context)
                                        .sysA[index]),
                            separatorBuilder: (context, index) =>
                            const SizedBox(
                              height: 10,
                            ),
                            itemCount: SubCubit
                                .get(context)
                                .sysA
                                .length),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
  Widget resourcesBuilder(context, index, GetSubjects subjects)
  {
    return InkWell(
      onTap: () async
      {
        if (await canLaunch(SubCubit
            .get(context)
            .or[index].url)) {
          await launch(SubCubit
              .get(context)
              .or[index].url);
        }
        else {
          navigateTo(context, WebViewScreen(SubCubit.get(context).or[index].url));
          throw'Can not launch ${SubCubit
              .get(context)
              .or[index].url}';
        }
        await SubCubit.get(context).delay(4000);
      },

      child: SizedBox(
        height: 70.0,
        child: Card(
          color:  Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                 Text((index + 1).toString() + '-'),

                  const Icon(
                  FontAwesomeIcons.fileVideo,
                  size: 45.0,
                ) ,
                const SizedBox(
                  width: 20.0,
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Text(
                        subjects.name,
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(fontSize: 16),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )

                      // Text(index.toString() ,),

                      // Text(
                      //   subjects.dateTime,
                      //   style: Theme.of(context)
                      //       .textTheme
                      //       .caption
                      //       .copyWith(fontSize: 10),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


