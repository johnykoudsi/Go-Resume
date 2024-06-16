import 'package:flutter/material.dart';

class BackButtonCircular extends StatelessWidget {
  const BackButtonCircular({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.canPop) {
      return SafeArea(
        child: Container(
            decoration: const BoxDecoration(
                color: Colors.white, shape: BoxShape.circle),
            margin: const EdgeInsets.all(14),
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back))),
      );
    }
    return const SizedBox();
  }
}
