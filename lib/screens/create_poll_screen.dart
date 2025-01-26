import 'package:flutter/material.dart';

import '../components/AppBar.dart';
import '../components/app_dialog.dart';
import '../components/button.dart';
import '../components/button_outline.dart';
import '../components/text_field.dart';
import '../models/poll.dart';
import '../services/firebase_service.dart';
import '../utils/constants/colors.dart';
import '../utils/constants/sizes.dart';

class CreatePollScreen extends StatefulWidget {
  const CreatePollScreen({Key? key}) : super(key: key);

  @override
  State<CreatePollScreen> createState() => _CreatePollScreenState();
}

class _CreatePollScreenState extends State<CreatePollScreen> {
  final FirebaseService firebase = FirebaseService();
  late String? userId;

  final questionTextController = TextEditingController();
  final List<TextEditingController> _optionControllers = [];
  final List<AppTextField> _optionTextFields = [];

  bool _isAnonymous = false;

  void _addOptions() {
    setState(() {
      TextEditingController newController = TextEditingController();
      _optionControllers.add(newController);
      _optionTextFields.add(
        AppTextField(
          textEditingController: newController,
          labelText: 'Option ${_optionTextFields.length + 1}',
          obscureText: false,
        ),
      );
    });
  }

  void _postPoll() {
    final String question = questionTextController.text;
    final List<String> options = _optionControllers.map((controller) => controller.text).toList();

    if (question.isEmpty || options.any((option) => option.isEmpty)) {
      AppDialog.showToast(context: context, message: "Field's can't be empty.");
    } else {
      final poll = Poll(question: question, options: options, user: userId!);
      final pollMapData = poll.toMap();

      try {
        firebase.addData("Polls", pollMapData, "");
        AppDialog.showToast(context: context, message: "Poll uploaded.");
        Navigator.pop(context);
      } catch (e) {
        AppDialog.showToast(context: context, message: "Error uploading Poll. Please try again.");
      }
    }
  }

  @override
  void initState() {
    userId = FirebaseService.getUserId();
    _addOptions();
    _addOptions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      appBar: const CustomAppBar(
        title: 'Create Poll',
        enableBackButton: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Create your poll with multiple options.",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Enter Your Question",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(
              height: 10,
            ),
            AppTextField(
              textEditingController: questionTextController,
              labelText: "",
              obscureText: false,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Enter Options",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  //color: AppColors.white, // Background color
                  borderRadius: BorderRadius.all(Radius.circular(AppSizes.borderRadius)),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: _optionTextFields.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: _optionTextFields[index],
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                const Text(
                  'Anonymous',
                  style: TextStyle(
                    fontSize: 18.0, // Adjust the font size here
                    fontWeight: FontWeight.normal, // Add optional styling
                  ),
                ),
                const Spacer(),
                Switch(
                  value: _isAnonymous,
                  onChanged: (value) {
                    setState(() {
                      _isAnonymous = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: AppButtonOutline(
                    onTap: _addOptions,
                    text: "Add Option",
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: AppButton(
                    onTap: _postPoll,
                    text: "Post Poll",
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
