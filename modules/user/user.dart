import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medtient/modules/chats/view_image.dart';
import 'package:medtient/shared/compnents/component.dart';
import 'package:medtient/shared/cubits/home/home_cubit.dart';
import 'package:medtient/shared/cubits/home/home_states.dart';

class Users extends StatelessWidget {
  static var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  static var nameController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var model = HomeCubit.get(context).userDataModel2;

    ImageProvider image()
    {
      bool isChoose = HomeCubit.get(context).profileImage != null;
      if(isChoose)
        {
          return FileImage(HomeCubit.get(context).profileImage);
        }
      else
        {
          return NetworkImage(model.image??'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png');
        }

    }
    nameController.text = model.name;
    emailController.text = model.email;
    phoneController.text = model.phone;
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is ResetDataSuccess)
          {
            toast(text: 'Send an Email to you email');
          }
        if(state is UpdateDataSuccessState)
          {
            snackBar(context, text: 'Updated');
          }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 80.0,
                        backgroundImage: image(),
                      ),
                      Positioned(
                        bottom: 4.0,
                          right: 12,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.circular(40.0)

                            ),
                            child: IconButton(
                                onPressed: ()
                                {
                                  HomeCubit.get(context).getProfileImage();
                                },
                                color: Colors.white,
                                icon: const Icon(Icons.add_a_photo_rounded)),
                          )),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Row(
                  children: [
                    const Icon(Icons.person , size: 30,),
                    const SizedBox(width: 10,),
                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('name :' , style: Theme.of(context).textTheme.caption,),
                        const SizedBox(height: 4,),
                        Text(nameController.text , style: Theme.of(context).textTheme.bodyText1,),
                      ],
                    )),
                    IconButton(onPressed: ()
                    {
                      defaultBottomSheet(
                        elevatedButtonText: 'save',
                        firstText: 'Enter your name',
                        textController: nameController,
                        textMaxLength: 20,
                        textIcon: Icons.person,
                        context: context,
                        savePressed: ()
                        {
                          HomeCubit.get(context).updateData(name: nameController.text, phone: phoneController.text , image: model.image??'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png');
                          Navigator.pop(context);
                        },
                      );
                    }, icon: const Icon(Icons.edit , color: Colors.teal,)),
                  ],
                ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35.0),
                    child: Text('This is not Your username or pin. This username will be visible to your collage friends' , style: Theme.of(context).textTheme.caption,),
                  ),
                  const Divider(color: Colors.teal,indent: 35),
                  const SizedBox(height: 10,),
                  Row(
                  children: [
                    const Icon(Icons.email , size: 30,),
                    const SizedBox(width: 10,),
                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Email :' , style: Theme.of(context).textTheme.caption,),
                        const SizedBox(height: 4,),
                        Text(emailController.text , style: Theme.of(context).textTheme.bodyText1,),
                      ],
                    )),
                  ],
                ),
                  const SizedBox(height: 10,),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35.0),
                    child: Text('This is  your email. This email will not be visible to your collage friends' , style: Theme.of(context).textTheme.caption,),
                  ),
                  const Divider(color: Colors.teal,indent: 35,),
                  Row(
                    children: [
                      const Icon(Icons.phone , size: 30,),
                      const SizedBox(width: 10,),
                      Expanded(child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('phone :' , style: Theme.of(context).textTheme.caption,),
                          const SizedBox(height: 4,),
                          Text(phoneController.text , style: Theme.of(context).textTheme.bodyText1,),
                        ],
                      )),
                      IconButton(onPressed: ()
                      {
                        defaultBottomSheet(
                          firstText: 'Enter your phone',
                          formKey: formKey,
                          keyboardType: TextInputType.number,
                          textController: phoneController,
                          textIcon: Icons.phone,
                          validate: (String value)
                          {
                            if(value.length != 11)
                              {
                                return 'This is invalid number';
                              }
                            return null;
                          },
                          context: context,
                          elevatedButtonText: 'save',
                          textMaxLength: 11,
                          savePressed: ()
                          {
                            if(formKey.currentState.validate())
                            {
                              HomeCubit.get(context).updateData(name: nameController.text, phone: phoneController.text , image: model.image??'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png');
                              Navigator.pop(context);
                            }
                          },
                        );
                      }, icon: const Icon(Icons.edit , color: Colors.teal,)),
                    ],
                  ),
                  Text('This phone will not be visible to your collage friends', style: Theme.of(context).textTheme.caption,),
                  const SizedBox(height: 30,),
                  state is GetImageProductSuccessState ? defaultOutLineButton(onPress: ()
                  {
                    HomeCubit.get(context).updateImage(phone: phoneController.text, name: nameController.text);
                  }, text: 'Update Image',
                  width: 50.0,
                    textColor: Colors.teal,
                    borderColor: Colors.teal,
                    icon: Icons.update,
                  ) : const SizedBox(height: 5,),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  // showBottomSheet(context)
  // {
  //   showModalBottomSheet(context: context, isScrollControlled: true,builder: (context)
  //   => Container(
  //     padding: EdgeInsets.only(
  //         bottom: MediaQuery.of(context).viewInsets.bottom),
  //     child: Padding(
  //       padding: const EdgeInsets.all(15.0),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           Text('Enter your name :',style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 20.0),),
  //          const SizedBox(height: 20,),
  //          TextFormField(
  //            controller: nameController,
  //            maxLength: 20,
  //            decoration:const InputDecoration(
  //              prefixIcon: Icon(Icons.person)
  //            ),
  //          ),
  //           Row(
  //             children: [
  //               ElevatedButton(onPressed: ()
  //               {
  //
  //               }, child: Text('save')),
  //               SizedBox(width: 10,),
  //               ElevatedButton(onPressed: ()
  //               {
  //                 Navigator.pop(context);
  //               }, child: Text('cancel')),
  //             ],
  //           ),
  //         ],
  //       ),
  //     ),
  //   ),
  //   );
  // }

}
