import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/common/button.dart';
import 'package:my_app/extension/localization_extension.dart';
import 'package:my_app/extension/media_query_extension.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';

import '../../../config/image_string.dart';

class RateAppScreen extends StatelessWidget {
  const RateAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Column(
              children: [
                SizedBox(
                  height: context.height * 0.03,
                ),
                Image.asset(
                  ImageString.rateImage,
                  width: double.infinity,
                  height: context.height * 0.20,
                ),
                SizedBox(
                  height: context.height * 0.05,
                ),
                Column(
                  children: [
                    Center(
                      child: Text(
                        context.localizations!.your_opinion_matters,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: context.height * 0.01,
                    ),
                    Text(
                     context.localizations!.rate_subtitle,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.5,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: context.height * 0.03,
                    ),
                    RatingBar(
                      filledIcon: Icons.star_rounded,
                      emptyIcon: Icons.star_outline_rounded,
                      halfFilledIcon: Icons.star_half_rounded,
                      isHalfAllowed: true,
                      halfFilledColor: Colors.yellow,
                      onRatingChanged: (value) => debugPrint('$value'),
                      initialRating: 1,
                      maxRating: 5,
                      alignment: Alignment.center,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    TextField(
                      onTapOutside: (_) {
                        FocusScope.of(context).unfocus();
                      },
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.black),
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: context.localizations!.message,
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.black),
                        border: const OutlineInputBorder(),
                        focusedBorder: const OutlineInputBorder(),
                        errorBorder: const OutlineInputBorder(),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(12.0),
        child: Button(
          showRadius: true,
          title: context.localizations!.submit,
          onTap: () {},
        ),
      ),
    );
  }
}
