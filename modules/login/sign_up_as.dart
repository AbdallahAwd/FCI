import 'package:flutter/material.dart';
import 'package:medtient/modules/login/sign_up.dart';
import 'package:medtient/shared/compnents/component.dart';
import 'package:medtient/shared/cubits/home/home_cubit.dart';
import 'package:medtient/shared/cubits/login/login_cubit.dart';

class SignUpAs extends StatefulWidget {

  SignUpAs({Key key}) : super(key: key);

  @override
  State<SignUpAs> createState() => _SignUpAsState();
}

class _SignUpAsState extends State<SignUpAs> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '- What grade are you in?',
              style: Theme
                  .of(context)
                  .textTheme
                  .headline6.copyWith(
                fontFamily: 'Cairo'
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Radio(
                    value: '1',
                    toggleable: true,
                    groupValue: LogInCubit
                        .get(context)
                        .radioValues,
                    onChanged: (value) {
                      setState(() {
                        LogInCubit
                            .get(context)
                            .radioValues = value;
                      });
                      // LogInCubit.get(context).isChoose(value);
                    }),
                Text('1st' , style: Theme.of(context).textTheme.headline6.copyWith(fontFamily: 'Cairo'),),
              ],
            ),
            Row(
              children: [
                Radio(
                    value: '2',
                    groupValue: LogInCubit
                        .get(context)
                        .radioValues,
                    onChanged: (value) {
                      setState(() {
                        LogInCubit
                            .get(context)
                            .radioValues = value;
                      });
                    }),
                Text('2nd',style: Theme.of(context).textTheme.headline6.copyWith(fontFamily: 'Cairo')),
              ],
            ),
            Row(
              children: [
                Radio(
                    value: '3',
                    groupValue: LogInCubit
                        .get(context)
                        .radioValues,
                    onChanged: (value) {
                      setState(() {
                        LogInCubit
                            .get(context)
                            .radioValues = value;
                      });
                    }
                ),
                Text('3rd',style: Theme.of(context).textTheme.headline6.copyWith(fontFamily: 'Cairo'))
              ],
            ),
            Row(
              children: [
                Radio(
                    value: '4',
                    groupValue: LogInCubit.get(context).radioValues,
                    onChanged:(value)
                    {
                      setState(() {
                        LogInCubit.get(context).radioValues = value;
                      });
                    }
                ),
                Text('4th',style: Theme.of(context).textTheme.headline6.copyWith(fontFamily: 'Cairo'))
              ],
            ),
            const SizedBox(height: 20,),
            if(LogInCubit
                .get(context)
                .radioValues == '2' || LogInCubit
                .get(context)
                .radioValues == '3'||LogInCubit
                .get(context)
                .radioValues == '4')
              Text(
                '- Do you  have any failed courses?',
                style: Theme
                    .of(context)
                    .textTheme
                    .headline6.copyWith(
                  fontFamily: 'Cairo'
                ),
              ),
            const SizedBox(
              height: 20,
            ),
            if(LogInCubit
                .get(context)
                .radioValues == '2' || LogInCubit
                .get(context)
                .radioValues == '3'||LogInCubit
                .get(context)
                .radioValues == '4')
              defaultTextFormFeild(
                  controller: LogInCubit.get(context).disController,
                  pre: Icons.subject,
                  HintText: "Write lost course",
                  KeyType: TextInputType.text
              ),
            if(LogInCubit
                .get(context)
                .radioValues == '3'||LogInCubit
                .get(context)
                .radioValues == '4')
              drop(context),
          ],
        ),
      ),
      persistentFooterButtons: [
        if (LogInCubit
            .get(context)
            .radioValues != null)
          defaultOutLineButton(
              onPress: () {
                navigateTo(context, SignUp());
              },
              text: 'Next',
              textColor: Colors.teal,
              icon: Icons.arrow_right_alt_sharp,
              borderColor: Colors.teal,
              width: 110.0,
              height: 45.0)
      ],
    );
  }
  Widget drop (context) => Container(
    width: double.infinity,
    child: DropdownButton<String>(
      style: Theme.of(context).textTheme.bodyText1.copyWith(fontFamily: 'Cairo'),
      value: LogInCubit.get(context).dropdownValue,
      onChanged: (String newValue)
      {
        LogInCubit.get(context).saveDrop(newValue);
      },
      hint: Text('Section' , style: Theme.of(context).textTheme.bodyText1.copyWith(fontFamily: 'Cairo' , fontSize: 20),textAlign: TextAlign.center,),
      items: <String>['CS', 'IT' , 'IS' , 'SE','BI',]
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    ),
  );
}
