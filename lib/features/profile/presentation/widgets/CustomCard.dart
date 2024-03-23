import 'package:flutter/material.dart';
import 'Skill.dart';
import 'job.dart';

class CustomCard extends StatelessWidget {
  final List<Job>? jobs;
  final List<Skill>? skills;
  final String title;
  final String operation;

  const CustomCard({
    Key? key,
     this.jobs,
     this.skills,
    required this.title,
    required this.operation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: screenWidth*0.02),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenSize.width * 0.04,
            vertical: screenSize.height * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    operation,
                    style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: screenSize.height * 0.02),
              jobs != null ?
              Column(
                children: jobs!.map((job) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: screenHeight*0.01),
                    child: Job(
                      role: job.role,
                      startDate: job.startDate,
                      endDate: job.endDate,
                      company: job.company,
                      description: job.description,
                    ),
                  );
                }).toList(),
              )
              : skills != null ?
              Column(
                children: skills!.map((skill) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: screenHeight*0.01),
                    child: Skill(skillName: skill.skillName, imagePath: skill.imagePath,description: skill.description,

                    ),
                  );
                }).toList(),
              ): const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
