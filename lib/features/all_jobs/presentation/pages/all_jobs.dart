import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import 'package:smart_recruitment_flutter_user/generated/assets.dart';
import 'package:smart_recruitment_flutter_user/utility/global_widgets/search_text_field.dart';

class AllJobsScreen extends StatefulWidget {
  const AllJobsScreen({super.key});

  @override
  State<AllJobsScreen> createState() => _AllJobsScreenState();
}

class _AllJobsScreenState extends State<AllJobsScreen> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("Jobs"),
        centerTitle: false,
        actions: [
          IconButton(
              onPressed: () {}, icon: SvgPicture.asset(Assets.svgNotification))
        ],
      ),
      body: Column(
        children: [
          SearchTextField(
            onClear: () {},
            onSend: (value) {},
            searchController: searchController,
            showSearchDeleteIcon: false,
          ),
        ],
      ),
    );
  }
}
