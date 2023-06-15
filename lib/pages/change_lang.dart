import 'dart:developer';

import 'package:aafia/data/models/languageModel.dart';
import 'package:aafia/utils/app_constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageSelectorPage extends StatefulWidget {
  @override
  _LanguageSelectorPageState createState() => _LanguageSelectorPageState();
}

class _LanguageSelectorPageState extends State<LanguageSelectorPage> {
  // final List<String> languagesList = ["English", "Spanish"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
        preferredSize: Size.fromHeight(120),
        child: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0,
title:Text( tr('change_lang' ,) ,style: TextStyle(color: Colors.white),),
leading: IconButton(onPressed: (){
  Get.back();
}, icon: Icon(Icons.arrow_back_ios,color: Colors.white,)),
centerTitle: true,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(18),
        ),
    ),
        ),
      ),

      body: _buildLanguagesList(),
    );
  }

  _buildLanguagesList() {
    return ListView.builder(
      itemCount: AppConstants.languages.length,
      itemBuilder: (context, index){
        return _buildLanguageItem(AppConstants.languages[index]);
      },
    );
  }

  _buildLanguageItem(LanguageModel language){
    return InkWell(
      onTap: () async{
        print(language);
    await    context.setLocale(Locale(language.languageCode!));
        // EasyLocalization.of(context)!.setLocale(Locale(language.languageCode!));
log(context.locale.toString());
// await context.setLocale(_newLocale); // change `easy_localization` locale
Get.updateLocale(Locale(language.languageCode!)); 
        Get.back();
      },
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Text(
            language.languageName!,
            style: TextStyle(
              fontSize: 24.0,
            ),
          ),
        ),
      ),
    );
  }
}