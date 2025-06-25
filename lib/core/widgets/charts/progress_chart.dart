import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

class ProgressChart extends StatelessWidget {
  final List<double> values;
  final List<String> labels;
  final double maxValue;
  final String? title;
  final String? subtitle;

  const ProgressChart({
    super.key,
    required this.values,
    required this.labels,
    required this.maxValue,
    this.title,
    this.subtitle,
  }) : assert(values.length == labels.length);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null || subtitle != null) ...[
              if (title != null)
                Text(
                  title!,
                  style: AppTextStyles.headlineMedium,
                ),
              if (subtitle != null) ...[
                const SizedBox(height: 4),
                Text(
                  subtitle!,
                  style: AppTextStyles.bodySmall,
                ),
              ],
              const SizedBox(height: 24),
            ],
            SizedBox(
              height: 200,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Y Axis Labels
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        maxValue.toStringAsFixed(0),
                        style: AppTextStyles.labelMedium,
                      ),
                      Text(
                        (maxValue / 2).toStringAsFixed(0),
                        style: AppTextStyles.labelMedium,
                      ),
                      Text(
                        '0',
                        style: AppTextStyles.labelMedium,
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  // Chart
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: List.generate(
                        values.length,
                        (index) => _buildBar(
                          value: values[index],
                          label: labels[index],
                          maxValue: maxValue,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBar({
    required double value,
    required String label,
    required double maxValue,
  }) {
    final double percentage = value / maxValue;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 24,
          height: 160 * percentage,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: AppTextStyles.labelMedium,
        ),
      ],
    );
  }
}
