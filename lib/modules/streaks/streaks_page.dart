import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import '../../admin/app_write/add_post_appwrite.dart';

// Controller to manage streaks data
class StreakController extends GetxController {
  var streakDays = 2.obs;
  var goalDays = 3.obs;
  var dailyStreak = 2.obs;
  var percentageChange = 100.obs;

  var selectedPeriod = '1 Day'.obs;
  var chartData = [
    const FlSpot(0, 2),
    const FlSpot(1, 2),
    const FlSpot(2, 3),
    const FlSpot(3, 2),
  ].obs;

  void updatePeriod(String period) {
    selectedPeriod.value = period;

    // Update chart data based on the selected period
    if (period == '1 Day') {
      chartData.value = [
        const FlSpot(0, 2),
        const FlSpot(1, 3),
        const FlSpot(2, 1),
        const FlSpot(3, 2),
      ];
    } else if (period == '1 Week') {
      chartData.value = [
        const FlSpot(0, 2),
        const FlSpot(1, 2),
        const FlSpot(2, 4),
        const FlSpot(3, 3),
      ];
    } else if (period == '1 Month') {
      chartData.value = [
        const FlSpot(0, 2),
        const FlSpot(1, 3),
        const FlSpot(2, 4),
        const FlSpot(3, 5),
      ];
    }
  }
}

class StreaksPage extends StatelessWidget {
  const StreaksPage({super.key});

  @override
  Widget build(BuildContext context) {
    final streakController = Get.put(StreakController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Streaks'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Today's Goal: 3 streak days",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(16),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.pink.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Streak Days',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${streakController.streakDays.value}',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Daily Streak',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Obx(
                () => Text(
                  '${streakController.dailyStreak.value}',
                  style: const TextStyle(
                      fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ),
              RichText(
                text: const TextSpan(
                  style: TextStyle(fontSize: 14, color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Last 30 Days ', // Regular text
                      style: TextStyle(color: Colors.black),
                    ),
                    TextSpan(
                      text: '+100%', // Green text
                      style: TextStyle(color: Colors.green),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Line Chart
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: Obx(
                    () => LineChart(
                      LineChartData(
                        gridData: const FlGridData(show: false),
                        titlesData: FlTitlesData(
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                if (value == 0) return const Text('1 Day');
                                if (value == 1) return const Text('2 weeks');
                                if (value == 2) return const Text('3 months');
                                return const Text('');
                              },
                              reservedSize: 30,
                            ),
                          ),
                          leftTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          rightTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          topTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                        ),
                        borderData: FlBorderData(
                            show: true,
                            border: Border.all(color: Colors.pink.shade100)),
                        lineBarsData: [
                          LineChartBarData(
                            spots: streakController.chartData,
                            isCurved: true,
                            belowBarData: BarAreaData(show: false),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                "Keep it up! You're on a roll.",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Action when button is pressed
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddPostScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink.shade50,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Get Started'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
