import 'package:flutter/material.dart';

class CategorySelector extends StatelessWidget {
  final List<String> categories;
  final int? selectedIndex;
  final ValueChanged<int?> onCategorySelected;

  const CategorySelector({
    super.key,
    required this.categories,
    required this.selectedIndex,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final isSelected = selectedIndex == index;
          return Padding(
            padding: EdgeInsets.only(
              right: index == categories.length - 1 ? 0 : 5.0,
            ),
            child: GestureDetector(
              onTap: () {
                if (isSelected) {
                  onCategorySelected(null);
                } else {
                  onCategorySelected(index);
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  color: isSelected
                      ? Colors.grey.withOpacity(0.3)
                      : Colors.transparent,
                ),
                padding:
                const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                child: Center(
                  child: Text(
                    categories[index],
                    style: TextStyle(
                      fontWeight:
                      isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
