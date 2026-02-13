import 'package:flutter/material.dart';
import 'package:olearis_tech_task/styles/app_colors.dart';

const gridPadding = 12.0;
const gridSpacing = 12.0;
const gridColumns = 2;
const tileAspectRatio = 4.0;

class TilesGrid extends StatelessWidget {
  const TilesGrid({required this.items, super.key});

  final List<String> items;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return GridView.count(
      crossAxisCount: gridColumns,
      childAspectRatio: tileAspectRatio,
      mainAxisSpacing: gridSpacing,
      crossAxisSpacing: gridSpacing,
      padding: const EdgeInsets.all(gridPadding),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: items.map((item) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: colors.border),
          ),
          alignment: Alignment.center,
          child: Text(
            item,
            style: const TextStyle(fontSize: 16),
          ),
        );
      }).toList(),
    );
  }
}
