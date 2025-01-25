import 'package:flutter/material.dart';

import '../components/AppBar.dart';
import '../components/button.dart';
import '../components/button_outline.dart';
import '../components/text_field.dart';
import '../utils/constants/colors.dart';
import '../utils/constants/sizes.dart';

class CreatePollScreen extends StatefulWidget {
  const CreatePollScreen({Key? key}) : super(key: key);

  @override
  State<CreatePollScreen> createState() => _CreatePollScreenState();
}

class _CreatePollScreenState extends State<CreatePollScreen> {
  final emailTextController = TextEditingController();

  final List<TextEditingController> _optionControllers = [];
  final List<TextField> _optionTextFields = [];

  void _addOptions() {
    setState(() {
      TextEditingController newController = TextEditingController();
      _optionControllers.add(newController);
      _optionTextFields.add(
        TextField(
          controller: newController,
          decoration: InputDecoration(
            labelText: 'Option ${_optionTextFields.length + 1}',
            border: const OutlineInputBorder(),
          ),
        ),
      );
    });
  }

  @override
  void initState() {
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
          children: [
            Container(
              decoration: const BoxDecoration(
                color: AppColors.white, // Background color
                borderRadius: BorderRadius.all(Radius.circular(AppSizes.borderRadius)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: AppTextField(
                  textEditingController: emailTextController,
                  labelText: "Enter question",
                  obscureText: false,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.white, // Background color
                  borderRadius: BorderRadius.all(Radius.circular(AppSizes.borderRadius)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18),
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
                      AppButtonOutline(
                        onTap: _addOptions,
                        text: "Add Option",
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            AppButton(
              onTap: _addOptions,
              text: "Post Poll",
            ),
          ],
        ),
      ),
    );
  }
}
