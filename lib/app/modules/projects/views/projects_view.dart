import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:vloo/app/data/utils/strings.dart';

import '../controllers/projects_controller.dart';

class ProjectsView extends GetView<ProjectsController> {
  const ProjectsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: const Text('ProjectsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          Strings.projectViewWorking,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
