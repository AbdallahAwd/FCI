import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medtient/models/message.dart';
import 'package:medtient/modules/chats/view_image.dart';
import 'package:medtient/shared/compnents/component.dart';
import 'package:medtient/shared/cubits/home/home_cubit.dart';
import 'package:medtient/shared/cubits/home/home_states.dart';

//add send file
// url-text identification
//image ui edit
class Chats extends StatelessWidget {
  ScrollController controller = ScrollController();
  var textController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var txtController = TextEditingController();
  bool isShow = false;
  @override
  Widget build(BuildContext context) {
    var model = HomeCubit.get(context).userDataModel2;
    return Builder(builder: (context) {
      HomeCubit.get(context).getMessage();
      return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {
          if (state is UploadProfileImageLoading) {
            toast(text: 'Uploading ◎');
          }
          if(state is OpenFileLoadingState)
            {
              toast(text: 'Loading');
            }
          if(state is OpenFileSuccessState)
            {
              toast(text: 'Opening');
            }
          if (state is UploadFileLoading)
            {
              toast(text: 'Uploading ◎◎◎');
            }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Form(
              key: formKey,
              child: Scrollbar(
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (HomeCubit.get(context).messages.isNotEmpty)
                          Expanded(
                            child: ListView.separated(
                              shrinkWrap: true,
                              reverse: true,
                              controller: controller,
                              itemBuilder: (context, index) {
                                var message = HomeCubit.get(context).messages[index];
                                if (model.uid == message.senderId) {
                                  return myMessage(context, message, state, index);
                                } else {
                                  return othersMessage(
                                      context, message, state, index);
                                }
                              },
                              separatorBuilder: (context, index) => const SizedBox(
                                height: 20.0,
                              ),
                              itemCount: HomeCubit.get(context).messages.length,
                            ),
                          )
                        else
                          Expanded(
                            child: Center(
                              child: SingleChildScrollView(
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.info_outline,
                                        color: Colors.grey[300],
                                        size: 130,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'No Text Here',
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption
                                            .copyWith(
                                                fontFamily: 'Cairo', fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        if (HomeCubit.get(context).image != null)
                          onGetPhoto(HomeCubit.get(context).image, context),
                        if (HomeCubit.get(context).file != null)
                          onGetFile(HomeCubit.get(context).image, context),
                        Row(
                          children: [
                            SizedBox(
                              width: 320.0,
                              height: 50.0,
                              child: TextFormField(
                                maxLines: 20,
                                controller: textController,
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'write something';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.message_outlined),
                                  hintText: 'Message',
                                  suffixIcon: IconButton(
                                    icon: const Icon(Icons.attach_file),
                                    onPressed: () {
                                      buttonSheetPicker(context: context,
                                        onFileTab: ()
                                        {
                                          HomeCubit.get(context).getFileLocally();
                                          Navigator.pop(context);
                                        },
                                        onImageTab: ()
                                        {
                                          HomeCubit.get(context).getImage();
                                          Navigator.pop(context);
                                        }
                                      );
                                    },
                                  ),
                                ),
                                onTap: onTabMethod,
                              ),
                            ),
                            if (HomeCubit.get(context).image == null && HomeCubit.get(context).file == null)
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.teal,
                                  borderRadius: BorderRadius.circular(60.0),
                                ),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.send,
                                    color: Colors.white,
                                  ),
                                  onPressed: () async {
                                    if (formKey.currentState.validate()) {
                                      HomeCubit.get(context)
                                          .sendMessage(text: textController.text);
                                    }
                                    textController.clear();
                                    onTabMethod();
                                  },
                                ),
                              ),
                          ],
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                                bottom: MediaQuery.of(context).viewInsets.bottom)),
                      ],
                    ),

                    Positioned(
                      bottom: 40.0,
                      right: 10.0,
                      child: IconButton(icon:  Icon(Icons.arrow_downward ,color: Colors.grey,),onPressed: ()
                      {
                            onTabMethod();

                      },),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }
double hight = 100;
double width = 200;
  Widget myMessage(context, Message message, state, index) => GestureDetector(
        onLongPress: () {
          HapticFeedback.lightImpact();
          buttonSheet(context, index);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(message.profileImage),
            ),
            const SizedBox(
              width: 5,
            ),
            Container(
              width:widthVar(width,message),
              height: heightVar(hight,message),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                  topLeft: Radius.circular(10.0),
                ),
                color: Colors.teal[200],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      message.name,
                      style: Theme.of(context).textTheme.caption.copyWith(
                          color: Colors.indigo, fontFamily: 'Cairo' ,height: 0.7),
                    ),
                    Text(
                      HomeCubit.get(context).messages[index].text,
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                            fontFamily: 'Cairo',
                          ),
                    ),
                    if (HomeCubit.get(context).messages[index].image != null)
                      InkWell(
                          onTap: () {
                            navigateTo(
                                context,
                                ViewImage(
                                    HomeCubit.get(context)
                                        .messages[index]
                                        .image,
                                    text: HomeCubit.get(context)
                                        .messages[index]
                                        .text));
                          },
                          child: Image(
                            image: NetworkImage(
                                HomeCubit.get(context).messages[index].image),
                            height: 300.0,
                            width: 300.0,
                            fit: BoxFit.cover,
                          )),
                    if (HomeCubit.get(context).messages[index].fileUrl != null)
                      InkWell(
                        onTap: () async {},
                        child: Row(
                          children: [
                            const Icon(
                              FontAwesomeIcons.file,
                              color: Colors.red,
                              size: 25,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: Text(
                              HomeCubit.get(context).messages[index].fileName,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                    fontFamily: 'Cairo',
                                    fontSize: 18.0,
                                  ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            )),
                            // IconButton(
                            //     onPressed: () async
                            //     {
                            //       var file = HomeCubit.get(context).file;
                            //      if( file != null)
                            //      {
                            //       await OpenFile.open(file.path);
                            //      }
                            //     },
                            //     icon: const Icon(Icons.open_in_full))
                          ],
                        ),
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          message.dateTime,
                          style: Theme.of(context)
                              .textTheme
                              .caption
                              .copyWith(fontFamily: 'Cairo', fontSize: 10.0 , height: 0.5),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        state is SendMessageLoading
                            ? const Icon(
                                Icons.watch_later_outlined,
                                size: 10,
                              )
                            : const Icon(
                                Icons.done_all,
                                size: 10,
                              ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );

  Widget othersMessage(context, Message message, state, index) => Row(
    mainAxisAlignment: MainAxisAlignment.end,
    crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: widthVar(width , message),
            height: heightVar(hight, message),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10.0),
                topLeft: Radius.circular(10.0),
                bottomLeft: Radius.circular(10.0),
              ),
              color: Colors.grey[300],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    message.name,
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        .copyWith(color: Colors.indigo, fontFamily: 'Cairo' ,height: 0.7),
                  ),
                  SelectableText(
                    message.text,
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                          fontFamily: 'Cairo',
                        ),
                  ),
                  if (HomeCubit.get(context).messages[index].image != null)
                    InkWell(
                        onTap: () {
                          navigateTo(
                              context,
                              ViewImage(HomeCubit.get(context).messages[index].image, text:HomeCubit.get(context).messages[index].text));
                        },
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Image(
                              image: NetworkImage(HomeCubit.get(context)
                                  .messages[index]
                                  .image),
                              height: 300.0,
                              width: 300.0,
                              fit: BoxFit.cover,
                            ))),
                  if (HomeCubit.get(context).messages[index].fileUrl != null)
                    InkWell(
                      onTap: () async
                      {

                      },
                      child: Row(
                        children: [
                          const Icon(
                            FontAwesomeIcons.file,
                            color: Colors.red,
                            size: 25,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: Text(
                                HomeCubit.get(context).messages[index].fileName,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(
                                  fontFamily: 'Cairo',
                                  fontSize: 18.0,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              )),
                          IconButton(
                              onPressed: () async {
                                final String url = HomeCubit.get(context).messages[index].fileUrl;
                                final String fileName = HomeCubit.get(context).messages[index].fileName;
                                HomeCubit.get(context).openFile(url, fileName);
                              },
                              icon: const Icon(Icons.download))
                        ],
                      ),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        message.dateTime,
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            .copyWith(fontFamily: 'Cairo', fontSize: 10.0,height: 0.5),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(message.profileImage),
          ),
        ],
      );

  Widget onGetPhoto(File file, context) {
    return Container(
      height: 300.0,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        image: DecorationImage(
          image: FileImage(file),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ElevatedButton(
              onPressed: () {
                HomeCubit.get(context).sendImage(
                  text: textController.text,
                );
                textController.clear();
                HomeCubit.get(context).cancelImage();
              },
              child: const Text('Send')),
          const Spacer(),
          ElevatedButton(
              onPressed: () {
                HomeCubit.get(context).cancelImage();
              },
              child: const Text('Cancel')),
        ],
      ),
    );
  }

  Widget onGetFile(File file, context) {
    return SizedBox(
      height: 110.0,
      width: double.infinity,
      child: Column(
        children: [
          const Icon(
            FontAwesomeIcons.file,
            color: Colors.red,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            HomeCubit.get(context).fileName,
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(fontFamily: 'Cairo'),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                  onPressed: () {
                    HomeCubit.get(context).sendFile(
                      text: textController.text,
                    );
                    textController.clear();
                    HomeCubit.get(context).cancelImage();
                  },
                  child: const Text('Send')),
              const Spacer(),
              TextButton(
                  onPressed: () {
                    HomeCubit.get(context).cancelImage();
                  },
                  child: const Text('Cancel')),
            ],
          ),
        ],
      ),
    );
  }

  buttonSheet(context, index) => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              onTap: () {
                HomeCubit.get(context)
                    .deleteMessage(HomeCubit.get(context).messageId[index]);
                Navigator.pop(context);
              },
              leading: const Icon(Icons.delete_outline),
              title: Text(
                'Delete',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ],
        ),
      );

  onTabMethod() {
    controller.animateTo(controller.position.minScrollExtent,
        duration: const Duration(milliseconds: 1000), curve: Curves.easeOut);
  }

  double heightVar(double hight ,Message message)
  {
    if(message.image != null)
      {
      return hight = 360.0;
      }
  }
  double widthVar(double width ,Message message)
  {
    if(message.image != null)
      {
      return width = 250.0;
      }
    else
      {
        return width = 200.0;
      }
  }
}
