
import 'package:flutter/material.dart';
import 'package:todo_app/localization/language_data.dart';
import 'package:todo_app/localization/local_constant.dart';
import 'package:todo_app/theme/theme_const.dart';
import 'package:todo_app/widgets/app_textview.dart';

class AppLanguageDropDown extends StatefulWidget {
  const AppLanguageDropDown({super.key, required String value, required List<String> items, required Null Function(dynamic value) onValueChange});

  @override
  State<AppLanguageDropDown> createState() => _AppLanguageDropDownState();
}

class _AppLanguageDropDownState extends State<AppLanguageDropDown> {
  LanguageData? dropdownValue ;

  @override
  void initState() {
    LanguageData.getSelectedLanguageData().then((value) => {
      setState((){
          dropdownValue = value;
      })
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primaryColor,width: 1.0), // Border color

        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primaryColor,width: 1.0), // Border color

        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primaryColor,width: 1.0), // Border color

        ),

        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<LanguageData>(
          value: dropdownValue,
          isDense: true,
          onChanged: (newValue) {
            setState(() {
              dropdownValue = newValue!;
              changeLanguage(context, newValue.languageCode);
            });
          },
          style: Theme.of(context).textTheme.labelSmall!.copyWith(
            color: Theme.of(context).colorScheme.primaryColor
          ),
          iconEnabledColor: Theme.of(context).colorScheme.primaryColor,
          items:
          LanguageData.languageList().map((LanguageData value) {
            return DropdownMenuItem<LanguageData>(
              value: value,
              child: AppTextView( text: value.name, textStyle: Theme.of(context).textTheme.labelSmall!.copyWith(
                  color: Theme.of(context).colorScheme.primaryColor
              ), fontSize: 10,),
            );
          }).toList(),
        ),
      ),
    );
  }
}