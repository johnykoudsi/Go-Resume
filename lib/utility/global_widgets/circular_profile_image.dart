import 'package:flutter/material.dart';

import '../../generated/assets.dart';

class CircularProfileImage extends StatelessWidget {
  final double width;
  final double height;
  final Color borderColor;
  final String image;
  final bool isCompany;
  const CircularProfileImage({Key? key,this.width=50,this.height=50,required this.borderColor, required this.image, required this.isCompany}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth=MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: screenWidth * 0.005),
      ),
      child: ClipOval(
        child: FadeInImage(
          key: UniqueKey(),
          placeholder:  AssetImage(
            isCompany?
                Assets.jpgCompany:
              Assets.pngRandomUser
          ),
          image: NetworkImage(image),
          fit: BoxFit.cover,
          imageErrorBuilder: (context, error, stackTrace) {
            return Image.asset(
              isCompany?
              Assets.jpgCompany:
              Assets.pngRandomUser,
              fit: BoxFit.cover,
            );
          },
        ),
      ),
    );

  }
}
