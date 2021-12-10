import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medtient/additions/file_image_inrecative.dart';
import 'package:medtient/models/get_subjects.dart';
import 'package:medtient/modules/chats/view_image.dart';
import 'package:medtient/modules/subjects/sheet.dart';
import 'package:medtient/shared/compnents/component.dart';
import 'package:medtient/shared/cubits/home/home_cubit.dart';
import 'package:medtient/shared/cubits/subjects/subjects.dart';
import 'package:medtient/shared/cubits/subjects/subjects_states.dart';

class Shares extends StatelessWidget {
  final int index;
  var noteController = TextEditingController();

  Shares(this.index);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      if(index == 0) SubCubit.get(context).getShareImage('orImages');
      if(index == 0) SubCubit.get(context).getShareFiles('orFiles');
      if(index == 1) SubCubit.get(context).getShareImage('multiImages');
      if(index == 1) SubCubit.get(context).getShareFiles('multiFiles');
      if(index == 2) SubCubit.get(context).getShareImage('oopImages');
      if(index == 2) SubCubit.get(context).getShareFiles('oopFiles');
      if(index == 3) SubCubit.get(context).getShareImage('webDevImages');
      if(index == 3) SubCubit.get(context).getShareFiles('webDevFiles');
      if(index == 4) SubCubit.get(context).getShareImage('dsImages');
      if(index == 4) SubCubit.get(context).getShareFiles('dsFiles');
      if(index == 5) SubCubit.get(context).getShareImage('sysAImages');
      if(index == 5) SubCubit.get(context).getShareFiles('sysAFiles');
      return BlocConsumer<SubCubit, SubStates>(
        listener: (BuildContext context, state) {
          if (state is GetImageProductSuccess || state is GetFileSuccess) {
            showAlertDialog(
              context,
            );
          }
          if (state is AddShareSuccess) {
            SubCubit.get(context).image = null;
            SubCubit.get(context).file = null;
            noteController.clear();
          }
          if (state is UploadingImage) {
            Navigator.pop(context);
            toast(text: 'Uploading');
          }
          if (state is OpenFileLoadingState)
          {
            toast(text: 'loading');
          }
        },
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
              title: Row(
                children: [
                  Text(
                    'Shares',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(fontSize: 20),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Icon(
                    FontAwesomeIcons.shareAlt,
                    color: Colors.black,
                    size: 18,
                  )
                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: (MediaQuery.of(context).size.width - 100) / 2,
                          height: 1,
                          color: Colors.black,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Images',
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                            fontFamily: 'Cairo',
                            height: 1,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: (MediaQuery.of(context).size.width - 100) / 2,
                          height: 1,
                          color: Colors.black,
                        ),
                      ],
                    ),

                    if(index == 0) //gridview image
                      imageList(context, SubCubit.get(context).orSharesImage),
                    if(index == 1) //gridview image
                      imageList(context, SubCubit.get(context).multiSharesImage),
                    if(index == 2) //gridview image
                      imageList(context, SubCubit.get(context).oopSharesImage),
                    if(index == 3) //gridview image
                      imageList(context, SubCubit.get(context).webDevSharesImage),
                    if(index == 4) //gridview image
                      imageList(context, SubCubit.get(context).dsSharesImage),
                    if(index == 5) //gridview image
                      imageList(context, SubCubit.get(context).sysASharesImage),


                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        Container(
                          width: (MediaQuery.of(context).size.width - 90) / 2,
                          height: 1,
                          color: Colors.black,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Files',
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                            fontFamily: 'Cairo',
                            height: 1,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: (MediaQuery.of(context).size.width - 90) / 2,
                          height: 1,
                          color: Colors.black,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    if(index == 0) //list files
                      fileList(context, SubCubit.get(context).orShareFiles),
                    if(index == 1) //list files
                      fileList(context, SubCubit.get(context).multiShareFiles),
                    if(index == 2) //list files
                      fileList(context, SubCubit.get(context).oopShareFiles),
                    if(index == 3) //list files
                      fileList(context, SubCubit.get(context).webDevShareFiles),
                    if(index == 4) //list files
                      fileList(context, SubCubit.get(context).dsShareFiles),
                    if(index == 5) //list files
                      fileList(context, SubCubit.get(context).sysAShareFiles),

                  ],
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                showAlertDialog(
                  context,
                );
              },
              child: const FaIcon(FontAwesomeIcons.shareAlt),
            ),
          );
        },
      );
    });
  }

  Widget shareBuilderImage(context, GetSubjects subjects) => InkWell(
        onTap: () {
          navigateTo(
              context,
              ViewImage(
                subjects.url,
                text: subjects.name,
              ));
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(15.0),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 10,
              ),
              Image(
                image: NetworkImage(subjects.url),
                width: double.infinity,
                height: 150.0,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                subjects.name,
                style:
                    Theme.of(context).textTheme.caption.copyWith(height: 0.78),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
        ),
      );

  Widget shareBuilderFile(context, GetSubjects subjects) => InkWell(
    onTap: ()
    {
      SubCubit.get(context).emit(OpenFileLoadingState());
      HomeCubit.get(context).openFile(subjects.url, subjects.name);
    },
    child: Row(
          children: [
            const Icon(
              FontAwesomeIcons.filePdf,
              color: Colors.red,
              size: 50,
            ),
            const SizedBox(
              width: 12,
            ),
            Text(
              subjects.name,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(fontFamily: 'Cairo' ,fontSize: 20),
            ),
            // IconButton(
            //     onPressed: () {
            //     },
            //     icon: const Icon(Icons.open_in_full)),
          ],
        ),
  );

  showAlertDialog(
    BuildContext context,)
  {
    // set up the button
    Widget addButton = TextButton(
      child: const Text("Add"),
      onPressed: () {
        if (SubCubit.get(context).image != null) {
          if(index == 0) SubCubit.get(context).uploadImage(name: noteController.text , collectionNameImage: 'orImages');
          if(index == 1) SubCubit.get(context).uploadImage(name: noteController.text , collectionNameImage: 'multiImages');
          if(index == 2) SubCubit.get(context).uploadImage(name: noteController.text , collectionNameImage: 'oopImages');
          if(index == 3) SubCubit.get(context).uploadImage(name: noteController.text , collectionNameImage: 'webDevImages');
          if(index == 4) SubCubit.get(context).uploadImage(name: noteController.text , collectionNameImage: 'dsImages');
          if(index == 5) SubCubit.get(context).uploadImage(name: noteController.text , collectionNameImage: 'sysAImages');
        }

        if (SubCubit.get(context).file != null) {
          if(index == 0) SubCubit.get(context).uploadFile('orFiles');
          if(index == 1) SubCubit.get(context).uploadFile('multiFiles');
          if(index == 2) SubCubit.get(context).uploadFile('oopFiles');
          if(index == 3) SubCubit.get(context).uploadFile('webDevFiles');
          if(index == 4) SubCubit.get(context).uploadFile('dsFiles');
          if(index == 5) SubCubit.get(context).uploadFile('sysAFiles');
        }
      },
    );
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
        SubCubit.get(context).image = null;
        SubCubit.get(context).file = null;
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text("Share"),
          SizedBox(
            width: 5,
          ),
          Icon(FontAwesomeIcons.shareAlt)
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (SubCubit.get(context).file == null)
            InkWell(
              onTap: () async {
                SubCubit.get(context).getImage();
                Navigator.pop(context);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.photo,
                                color: Colors.teal,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Add an Image',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(
                                        fontFamily: 'Cairo',
                                        color: Colors.teal),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          const SizedBox(
            height: 20.0,
          ),
          if (SubCubit.get(context).image != null)
            TextFormField(
              controller: noteController,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.note_add_outlined),
                  hintText: 'Note with it?'),
            ),
          if (SubCubit.get(context).image != null)
            InkWell(
              onTap: () {
                navigateTo(
                    context,
                    AddImageViewer(
                      fileImage: SubCubit.get(context).image,
                    ));
              },
              child: Container(
                height: 250.0,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image: FileImage(SubCubit.get(context).image),
                      fit: BoxFit.cover,
                    )),
              ),
            ),
          if (SubCubit.get(context).image == null &&
              SubCubit.get(context).file == null)
            SizedBox(
              height: 20.0,
              child: Text(
                'OR',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(fontFamily: 'Cairo', color: Colors.teal),
              ),
            ),
          if (SubCubit.get(context).image == null &&
              SubCubit.get(context).file == null)
            const SizedBox(
              height: 20.0,
            ),
          if (SubCubit.get(context).image == null)
            InkWell(
              onTap: () {
                SubCubit.get(context).getFileLocally();
                Navigator.pop(context);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Icon(
                                FontAwesomeIcons.solidFileAlt,
                                color: Colors.teal,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Add an File',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(
                                        fontFamily: 'Cairo',
                                        color: Colors.teal),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          if (SubCubit.get(context).file != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Icon(
                    FontAwesomeIcons.solidFilePdf,
                    color: Colors.red,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    SubCubit.get(context).fileName,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(fontFamily: 'Cairo', color: Colors.black),
                  ),
                ],
              ),
            ),
        ],
      ),
      actions: [
        addButton,
        cancelButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  Widget imageList(context , List<GetSubjects> list) => SizedBox(
    height: 400,
    child: Scrollbar(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ConditionalBuilder(
          condition: list.isNotEmpty,
          builder: (BuildContext context) => GridView.builder(
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 10,
                  // childAspectRatio: 0.9,
                  mainAxisExtent: 190),
              itemCount: list.length,
              itemBuilder: (context, index) =>
                  shareBuilderImage(context,
                      list[index])),
          fallback: (context) => emptyBuilder(context),

        ),
      ),
    ),
  );
  Widget fileList(context , List<GetSubjects> list) => SizedBox(
    height: MediaQuery.of(context).size.height-500,
    child: Scrollbar(
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ConditionalBuilder(
            condition: list.isNotEmpty,
            builder: (BuildContext context)  => ListView.separated(
                itemBuilder: (context , index) => shareBuilderFile(context,list[index]),
                separatorBuilder: (context , index) =>Column(
                  children: const [
                    SizedBox(height: 10,),
                    Divider(height: 1,color: Colors.grey,),
                    SizedBox(height: 6,)
                  ],
                ),
                itemCount: list.length),
            fallback: (context) => emptyBuilder(context),
          )),
    ),
  );
}
