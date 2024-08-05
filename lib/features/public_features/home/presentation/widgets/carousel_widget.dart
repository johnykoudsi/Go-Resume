
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smart_recruitment_core/utility/theme/app_borders.dart';
import 'package:smart_recruitment_flutter_user/generated/assets.dart';

import '../../../ads/domain/entities/ad_entity.dart';

class CarouselSliderWidget extends StatelessWidget {
  final List<Ad> ads;
  const CarouselSliderWidget({super.key,  required this.ads});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: CarouselSlider.builder(
        itemCount: ads.length,
        itemBuilder:
            (BuildContext context, int index, int realIndex) {
          return Padding(
            padding: const EdgeInsets.only(
                top: 18,
                left: 5,
                right: 5,
                bottom: 18,
            ),
            child: Material(
              borderRadius: AppBorders.k9BorderRadius,
              elevation: 3,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: AppBorders.k9BorderRadius,
                  image: DecorationImage(
                    alignment: Alignment.center,
                    image: Image.network(ads[index].image)
                        .image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          );
        },
        options:
        CarouselOptions(viewportFraction: 0.9, autoPlay: true),
      ),
    );
  }
}
