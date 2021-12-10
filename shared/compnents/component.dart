import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:medtient/shared/cubits/home/home_cubit.dart';

Widget defaultTextFormFeild({
  @required TextEditingController controller,
  @required IconData pre,
  @required String HintText,
  FormFieldValidator<String> validate,
  var onChange,
  IconData suff,
  var suffixWidget,
  bool isObscure = false,
  @required var KeyType,
  var suffPress,
  var submit,
  bool enable = true,
}) =>
    TextFormField(
      enabled: enable,
      keyboardType: KeyType,
      obscureText: isObscure,
      controller: controller,
      onChanged: onChange,
      maxLines: 1,
      onFieldSubmitted: submit,
      decoration: InputDecoration(
        prefixIcon: Icon(pre),
        suffix: suffixWidget,
        suffixIcon: IconButton(onPressed: suffPress, icon: Icon(suff)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        labelText: HintText,
      ),
      validator: validate,
    );

defaultButton({
  @required onPress,
  @required String text,
  double fontSize = 20,
  Color defaultFontColor = Colors.white,
  var buttonColor,
  var icon,
  var height = 50.0,
  IconColor = Colors.white,
  var width = double.infinity,
}) =>
    Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: MaterialButton(
        onPressed: onPress,
        color: buttonColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              Icon(
                icon,
                color: IconColor,
              ),
            const SizedBox(
              width: 10,
            ),
            Text(
              text.toUpperCase(),
              style: TextStyle(
                  color: defaultFontColor,
                  fontWeight: FontWeight.w700,
                  fontSize: fontSize),
            ),
          ],
        ),
      ),
    );

Widget defaultOutLineButton({
  @required onPress,
  width = double.infinity,
  height = 50.0,
  @required String text,
  double borderWidth = 1.0,
  borderColor = Colors.blue,
  textColor = Colors.white,
  textFontSize = 20.0,
  icon,
  iconColor,
}) =>
    OutlinedButton.icon(
      onPressed: onPress,
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: borderColor, width: borderWidth),
        minimumSize: Size(width, height),
      ),
      label: Text(
        text.toUpperCase(),
        style: TextStyle(color: textColor, fontSize: textFontSize),
      ),
      icon: Icon(
        icon,
        color: iconColor,
      ),
    );

snackBar(context, {@required text, color = Colors.green}) {
  var snackBar = SnackBar(
    content: Text(text),
    backgroundColor: color,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

navigateTo(context, screen) {
  return Navigator.push(
      context, MaterialPageRoute(builder: (context) => screen));
}

navigateAnd(context, screen) {
  return Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => screen), (route) => false);
}

Widget defaultButtonNavBar(context) => GNav(
      rippleColor: Colors.grey[800],
      // tab button ripple color when pressed
      hoverColor: Colors.grey[700],
      // tab button hover color
      haptic: true,
      // haptic feedback
      tabMargin: const EdgeInsets.all(5.0),
      tabBorderRadius: 15,
      tabActiveBorder: Border.all(color: Colors.black, width: 1),
      // tab button border
      tabBorder: Border.all(color: Colors.grey, width: 1),
      // tab button border
      tabShadow: [
        BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 8)
      ],
      // tab button shadow
      curve: Curves.easeOutExpo,
      // tab animation curves
      duration: const Duration(milliseconds: 900),
      // tab animation duration
      gap: 8,
      // the tab button gap between icon and text
      color: Colors.grey[800],
      // unselected icon color
      activeColor: Colors.teal,
      // selected icon and text color
      iconSize: 24,
      // tab button icon size
      tabBackgroundColor: Colors.purple.withOpacity(0.1),
      // selected tab background color
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      selectedIndex: HomeCubit.get(context).indexC,
      onTabChange: (index) {
        HomeCubit.get(context).onChanged(index);
      },
      // navigation bar padding
      tabs: HomeCubit.get(context).items,
    );

Widget buildStack({
  @required context,
  @required String text,
  @required String imageName,
  double height = 200.0,
  fit = BoxFit.cover,
}) {
  return Stack(
    alignment: AlignmentDirectional.center,
    children: [
      Container(
        width: double.infinity,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: NetworkImage(imageName),
            fit: fit,
          ),
        ),
      ),
      Container(
        width: double.infinity,
        height: height,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          borderRadius: BorderRadius.circular(45),
        ),
      ),
      Text(
        text,
        style: Theme.of(context)
            .textTheme
            .bodyText1
            .copyWith(fontSize: 35, color: Colors.white, fontFamily: 'Cairo'),
      )
    ],
  );
}

defaultBottomSheet({
  @required BuildContext context,
  @required textController,
  @required String firstText,
  @required IconData textIcon,
  @required savePressed,
  @required elevatedButtonText,
  validate,
  int textMaxLength,
  formKey,
  keyboardType,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => Form(
      key: formKey,
      child: Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                firstText,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(fontSize: 20.0),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                keyboardType: keyboardType,
                controller: textController,
                maxLength: textMaxLength,
                validator: validate,
                decoration: InputDecoration(prefixIcon: Icon(textIcon)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      onPressed: savePressed, child: Text(elevatedButtonText)),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('cancel')),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
Future toast({
 @required String text,
})
=> Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.green,
    textColor: Colors.white,
    fontSize: 16.0
);

buttonSheetPicker({
 @required BuildContext context,
 @required var onImageTab,
 @required var onFileTab,
}) => showModalBottomSheet(
  context: context,
  builder: (context) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  InkWell(
                    child: const CircleAvatar(
                      child: Icon(
                        Icons.image,
                        size: 50.0,
                        color: Colors.white,
                      ),
                      radius: 40.0,
                      backgroundColor: Colors.purple,
                    ),
                    onTap: onImageTab,
                  ),
                  Text(
                    'Image',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(fontFamily: 'Cairo'),
                  )
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  InkWell(
                    child: const CircleAvatar(
                      child: Icon(
                        Icons.insert_drive_file,
                        size: 50.0,
                        color: Colors.white,
                      ),
                      radius: 40.0,
                      backgroundColor: Colors.teal,
                    ),
                    onTap: onFileTab,
                  ),
                  Text(
                    'Import File',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(fontFamily: 'Cairo'),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  ),
);