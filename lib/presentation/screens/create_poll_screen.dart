import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:votez/presentation/blocs/poll/poll_bloc.dart';
import 'package:votez/presentation/blocs/poll/poll_state.dart';

import '../../core/di/dependency_injection.dart';
import '../../core/widgets/app_dialog.dart';
import '../../core/widgets/app_button.dart';
import '../../core/widgets/appbar.dart';
import '../../core/widgets/button_outline.dart';
import '../../core/widgets/text_field.dart';
import '../../models/poll.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/sizes.dart';
import '../blocs/poll/poll_event.dart';

class CreatePollScreen extends StatefulWidget {
  const CreatePollScreen({Key? key}) : super(key: key);

  @override
  State<CreatePollScreen> createState() => _CreatePollScreenState();
}

class _CreatePollScreenState extends State<CreatePollScreen> {
  late final PollBloc _bloc = injection<PollBloc>();

  late String? userId;

  final List<String> _categories = ["Food", "Technology", "Fashion", "Science", "Sports", "Life", "Other"];
  int? _selectedCategoryIndex;

  final questionTextController = TextEditingController();

  final List<TextEditingController> _optionControllers = [];
  final List<AppTextField> _optionTextFields = [];

  @override
  void initState() {
    _bloc.add(GeUserIdEvent());
    _addOptions();
    _addOptions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: AppColors.primaryBackground,
      appBar: const CustomAppBar(
        title: 'Create Poll',
        enableBackButton: true,
      ),
      body: BlocProvider(
        create: (_) => _bloc,
        child: BlocListener<PollBloc, PollState>(
          listener: (context, state) {
            if (state is GetUserIdSuccessState) {
              userId = state.userId;
            } else if (state is GetUserIdFailedState) {
              AppDialog.showErrorDialog(context: context, message: state.error);
            }
            if (state is CreatePollSuccessState) {
              AppDialog.hideDialog(context);
              AppDialog.showToast(context: context, message: "Poll uploaded.");
              Navigator.pop(context);
            } else if (state is CreatePollEventFailedState) {
              AppDialog.showErrorDialog(context: context, message: state.error);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Create your poll with multiple options.",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Enter your question",
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
                  "Select the category",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 38,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: _categories.length,
                    itemBuilder: (context, index) {
                      final isSelected = _selectedCategoryIndex == index;
                      return Padding(
                        padding: EdgeInsets.only(right: index == _categories.length - 1 ? 0 : 5.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedCategoryIndex = index;
                              print("Selected: ${_categories[index]}");
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                              color: isSelected ? Colors.grey.withOpacity(0.3) : Colors.transparent,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                              child: Center(
                                child: Text(
                                  _categories[index],
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Enter options",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
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
        ),
      ),
    );
  }

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
    } else if (_selectedCategoryIndex == null) {
      AppDialog.showToast(context: context, message: "Select the category.");
    } else {
      AppDialog.showLoading(context: context);
      _bloc.add(
        CreatePollEvent(
          question: question,
          options: options,
          user: userId!,
        ),
      );
    }
  }
}
