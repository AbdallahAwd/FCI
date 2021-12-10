import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medtient/models/get_subjects.dart';
import 'package:medtient/modules/webview.dart';
import 'package:medtient/shared/compnents/component.dart';
import 'package:medtient/shared/cubits/subjects/subjects.dart';
import 'package:medtient/shared/cubits/subjects/subjects_states.dart';
import 'package:url_launcher/url_launcher.dart';

class sheets extends StatelessWidget {
  final int indx;

  const sheets(this.indx);
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if(indx == 0) SubCubit.get(context).getSheets('OR');
        if(indx == 1) SubCubit.get(context).getSheets('MultiMedia');
        if(indx == 2) SubCubit.get(context).getSheets('OOP');
        if(indx == 3) SubCubit.get(context).getSheets('WebDev');
        if(indx == 4) SubCubit.get(context).getSheets('DS');
        if(indx == 5) SubCubit.get(context).getSheets('SysA');
        return BlocConsumer<SubCubit,SubStates>(
          listener: (BuildContext context, state) {  },
          builder: (BuildContext context, state) {
            return Scaffold(
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
                  'Sheets',
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
                          if(indx == 0)
                            SizedBox(
                            height: MediaQuery.of(context).size.height-100,
                            child: ConditionalBuilder(
                              condition: SubCubit.get(context).orSheet.isNotEmpty,
                              builder: (BuildContext context) {
                                return GridView.builder(
                                  // shrinkWrap: true,
                                    physics: const BouncingScrollPhysics(),
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 15,
                                      crossAxisSpacing: 10,
                                      childAspectRatio: 1.1,
                                    ),
                                    itemCount: SubCubit.get(context).orSheet.length,
                                    itemBuilder: (context , index) => sheetBuilder(context,index,SubCubit.get(context).orSheet[index]) );
                              },
                              fallback: (context) => emptyBuilder(context),

                            ),
                          ),
                          if(indx == 1)
                            SizedBox(
                              height: MediaQuery.of(context).size.height-100,
                              child: ConditionalBuilder(
                                condition: SubCubit.get(context).multiSheet.isNotEmpty,
                                builder: (BuildContext context) {
                                  return GridView.builder(
                                    // shrinkWrap: true,
                                      physics: const BouncingScrollPhysics(),
                                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 15,
                                        crossAxisSpacing: 10,
                                        childAspectRatio: 1.1,
                                      ),
                                      itemCount: SubCubit.get(context).multiSheet.length,
                                      itemBuilder: (context , index) => sheetBuilder(context,index,SubCubit.get(context).multiSheet[index]) );
                                },
                                fallback: (context) => emptyBuilder(context),

                              ),
                            ),
                          if(indx == 2)
                            SizedBox(
                              height: MediaQuery.of(context).size.height-100,
                              child: ConditionalBuilder(
                                condition: SubCubit.get(context).oopSheet.isNotEmpty,
                                builder: (BuildContext context) {
                                  return GridView.builder(
                                    // shrinkWrap: true,
                                      physics: const BouncingScrollPhysics(),
                                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 15,
                                        crossAxisSpacing: 10,
                                        childAspectRatio: 1.1,
                                      ),
                                      itemCount: SubCubit.get(context).oopSheet.length,
                                      itemBuilder: (context , index) => sheetBuilder(context,index,SubCubit.get(context).oopSheet[index]) );
                                },
                                fallback: (context) => emptyBuilder(context),

                              ),
                            ),
                          if(indx == 3)
                            SizedBox(
                              height: MediaQuery.of(context).size.height-100,
                              child: ConditionalBuilder(
                                condition: SubCubit.get(context).webDevSheet.isNotEmpty,
                                builder: (BuildContext context) {
                                  return GridView.builder(
                                    // shrinkWrap: true,
                                      physics: const BouncingScrollPhysics(),
                                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 15,
                                        crossAxisSpacing: 10,
                                        childAspectRatio: 1.1,
                                      ),
                                      itemCount: SubCubit.get(context).webDevSheet.length,
                                      itemBuilder: (context , index) => sheetBuilder(context,index,SubCubit.get(context).webDevSheet[index]) );
                                },
                                fallback: (context) => emptyBuilder(context),

                              ),
                            ),
                          if(indx == 4)
                            SizedBox(
                              height: MediaQuery.of(context).size.height-100,
                              child: ConditionalBuilder(
                                condition: SubCubit.get(context).DSSheet.isNotEmpty,
                                builder: (BuildContext context) {
                                  return GridView.builder(
                                    // shrinkWrap: true,
                                      physics: const BouncingScrollPhysics(),
                                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 15,
                                        crossAxisSpacing: 10,
                                        childAspectRatio: 1.1,
                                      ),
                                      itemCount: SubCubit.get(context).DSSheet.length,
                                      itemBuilder: (context , index) => sheetBuilder(context,index,SubCubit.get(context).DSSheet[index]) );
                                },
                                fallback: (context) => emptyBuilder(context),

                              ),
                            ),
                          if(indx == 5)
                            SizedBox(
                              height: MediaQuery.of(context).size.height-100,
                              child: ConditionalBuilder(
                                condition: SubCubit.get(context).sysASheet.isNotEmpty,
                                builder: (BuildContext context) {
                                  return GridView.builder(
                                    // shrinkWrap: true,
                                      physics: const BouncingScrollPhysics(),
                                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 15,
                                        crossAxisSpacing: 10,
                                        childAspectRatio: 1.1,
                                      ),
                                      itemCount: SubCubit.get(context).sysASheet.length,
                                      itemBuilder: (context , index) => sheetBuilder(context,index,SubCubit.get(context).sysASheet[index]) );
                                },
                                fallback: (context) => emptyBuilder(context),

                              ),
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

  Widget sheetBuilder(context , index , GetSubjects subjects) {
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
                FontAwesomeIcons.filePdf,
                color: Colors.red,
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
Widget emptyBuilder(context) => SizedBox(
  width: double.infinity,
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Icon(Icons.info_outline , size: 50,),
      const SizedBox(height: 10,),
      Text('Nothing Here' , style: Theme.of(context).textTheme.bodyText1.copyWith(fontFamily: 'Cairo'),)
    ],
  ),
);