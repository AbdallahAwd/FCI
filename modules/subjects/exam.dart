import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medtient/models/get_subjects.dart';
import 'package:medtient/modules/webview.dart';
import 'package:medtient/shared/compnents/component.dart';
import 'package:medtient/shared/cubits/subjects/subjects.dart';
import 'package:medtient/shared/cubits/subjects/subjects_states.dart';
import 'package:url_launcher/url_launcher.dart';

class Exam extends StatelessWidget {
  final int index;

  Exam(this.index);
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if(index == 0) SubCubit.get(context).getExam('OR');
        if(index == 1) SubCubit.get(context).getExam('MultiMedia');
        if(index == 2) SubCubit.get(context).getExam('OOP');
        if(index == 3) SubCubit.get(context).getExam('WebDev');
        if(index == 4) SubCubit.get(context).getExam('DS');
        if(index == 5) SubCubit.get(context).getExam('SysA');
        return BlocConsumer<SubCubit,SubStates>(
          listener: (BuildContext context, state) {  },
          builder: (BuildContext context, state) {
            return  Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  ),
                ),
                title: Text(
                  'Exams',
                  style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 20),
                ),
              ),
              body: Scrollbar(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          if(index == 0)
                            SizedBox(
                              height: MediaQuery.of(context).size.height-100,
                              child: GridView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 15,
                                    crossAxisSpacing: 10,
                                    childAspectRatio: 1.1,
                                  ),
                                  itemCount: SubCubit.get(context).orExam.length,
                                  itemBuilder: (context , index) => examBuilder(context,index,SubCubit.get(context).orExam[index]) ),
                            ),
                          if(index == 1)
                            SizedBox(
                              height: MediaQuery.of(context).size.height-100,
                              child: GridView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 15,
                                    crossAxisSpacing: 10,
                                    childAspectRatio: 1.1,
                                  ),
                                  itemCount: SubCubit.get(context).multiExam.length,
                                  itemBuilder: (context , index) => examBuilder(context,index,SubCubit.get(context).multiExam[index]) ),
                            ),
                          if(index == 2)
                            SizedBox(
                              height: MediaQuery.of(context).size.height-100,
                              child: GridView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 15,
                                    crossAxisSpacing: 10,
                                    childAspectRatio: 1.1,
                                  ),
                                  itemCount: SubCubit.get(context).oopExam.length,
                                  itemBuilder: (context , index) => examBuilder(context,index,SubCubit.get(context).oopExam[index]) ),
                            ),
                          if(index == 3)
                            SizedBox(
                              height: MediaQuery.of(context).size.height-100,
                              child: GridView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 15,
                                    crossAxisSpacing: 10,
                                    childAspectRatio: 1.1,
                                  ),
                                  itemCount: SubCubit.get(context).webDevExam.length,
                                  itemBuilder: (context , index) => examBuilder(context,index,SubCubit.get(context).webDevExam[index]) ),
                            ),
                          if(index == 4)
                            SizedBox(
                              height: MediaQuery.of(context).size.height-100,
                              child: GridView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 15,
                                    crossAxisSpacing: 10,
                                    childAspectRatio: 1.1,
                                  ),
                                  itemCount: SubCubit.get(context).DSExam.length,
                                  itemBuilder: (context , index) => examBuilder(context,index,SubCubit.get(context).DSExam[index]) ),
                            ),
                          if(index == 5)
                            SizedBox(
                              height: MediaQuery.of(context).size.height-100,
                              child: GridView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 15,
                                    crossAxisSpacing: 10,
                                    childAspectRatio: 1.1,
                                  ),
                                  itemCount: SubCubit.get(context).sysAExam.length,
                                  itemBuilder: (context , index) => examBuilder(context,index,SubCubit.get(context).sysAExam[index]) ),
                            ),
                        ],
                      ),
                    )
                ),
              ),
            );
          },

        );
      }
    );
  }
  Widget examBuilder(context , index , GetSubjects subjects) {
    return InkWell(
      onTap: () async
      {
        if(await canLaunch(subjects.url))
        {
          await launch(subjects.url);
        }
        else
        {
          navigateTo(context, WebViewScreen(subjects.url));
          throw'Error';
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                FontAwesomeIcons.fileContract,
                color: Colors.black,
                size: 65,
              ),
              const SizedBox(
                height: 12.0,
              ),
              Text(
                subjects.name,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(fontSize: 20.0, fontFamily: 'Cairo'),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              )
            ],
          ),
        ),
      ),
    );
  }
}
