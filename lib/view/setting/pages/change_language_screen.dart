import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/common/button.dart';
import 'package:my_app/common/custom_appbar.dart';
import 'package:my_app/config/colors.dart';
import 'package:my_app/bloc/change_languages/change_language_bloc.dart';
import 'package:my_app/extension/localization_extension.dart';

class ChangeLanguageScreen extends StatefulWidget {
  const ChangeLanguageScreen({super.key});

  @override
  State<ChangeLanguageScreen> createState() => _ChangeLanguageScreenState();
}

class _ChangeLanguageScreenState extends State<ChangeLanguageScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ChangeLanguageBloc>().add(LoadSavedLanguage());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangeLanguageBloc, ChangeLanguageState>(
      builder: (context, state) {
        final selectedLanguages = state.selectedLanguageCode;
        return Theme(
          data: Theme.of(context).copyWith(
            dividerTheme: const DividerThemeData(
              color: Colors.transparent,
            ),
          ),
          child: Scaffold(
            appBar: CustomAppBar(
              title: context.localizations!.language,
            ),
            persistentFooterButtons: [
              BlocBuilder<ChangeLanguageBloc, ChangeLanguageState>(
                builder: (context, state) {
                  return Button(
                    loading: state.isLoading,
                    showRadius: true,
                    title: context.localizations!.change_language,
                    onTap: () {
                      if (state.selectedLanguageCode != null) {
                        context
                            .read<ChangeLanguageBloc>()
                            .add(ChangeLanguage(context: context));
                      }
                    },
                  );
                },
              )
            ],
            body: ListView(
              children: countryList.map((data) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: selectedLanguages == data["code"]
                                ? AppColors.buttonColor
                                : const Color(0xffC1C7D0),
                          ),
                          borderRadius: BorderRadius.circular(12.0)),
                      child: ListTile(
                        onTap: () {
                          context
                              .read<ChangeLanguageBloc>()
                              .add(ChangeLanguageCode(language: data["code"]));
                        },
                        leading: Container(
                          width: 40.w,
                          height: 40.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: CachedNetworkImage(
                              imageUrl: data["flag"],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        title: Text(data["title"]),
                      )),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  final List countryList = [
    {
      "title": "English (US)",
      "flag": "https://flagcdn.com/w320/um.png",
      "code": "en",
    },
    {
      "title": "Italy (IT)",
      "flag": "https://flagcdn.com/w320/it.png",
      "code": "it",
    },
  ];
}
