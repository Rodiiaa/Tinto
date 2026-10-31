
import 'package:flutter/material.dart';

void main() {
  runApp(const HabitHelperApp());
}

const navy = Color(0xFF263D8C);
const purple = Color(0xFF6256FF);
const lavender = Color(0xFFDCDFFF);
const background = Color(0xFFF0EFE9);
const ink = Color(0xFF26345F);

class HabitHelperApp extends StatelessWidget {
  const HabitHelperApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tinto',
      theme: ThemeData(
        scaffoldBackgroundColor: background,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: navy),
        fontFamily: 'Arial',
      ),
      home: const HabitDashboard(),
    );
  }
}

class HabitDashboard extends StatefulWidget {
  const HabitDashboard({super.key});

  @override
  State<HabitDashboard> createState() => _HabitDashboardState();
}

class _HabitDashboardState extends State<HabitDashboard> {
  DateTime month = DateTime.now();
DateTime selectedDate = DateTime.now();

  final Map<int, List<IconData>> calendarHabits = {
  };

  final List<Habit> dailyHabits = [
    Habit('Medytacja', Icons.self_improvement, [1, 2, 3]),
    Habit('Sen min. 8 godzin', Icons.bedtime, [0, 2, 4]),
    Habit('Picie wody', Icons.water_drop, [0, 1, 2, 3, 4]),
  ];

  final List<Habit> plannedHabits = [
    Habit('Kwiatki', Icons.local_florist, [0, 2, 3]),
    Habit('Kurs językowy', Icons.menu_book, [1, 3, 5]),
  ];

  final List<Habit> flexibleHabits = [
  Habit('Basen', Icons.pool, [0, 1, 3], progress: '0/5'),
  Habit('Czytanie książek', Icons.auto_stories, [0, 2, 3, 4],
      progress: '0/5'),
];

  final List<String> weekdays = [
    'Pn', 'Wt', 'Śr', 'Czw', 'Pt', 'Sob', 'Nd'
  ];

  void changeMonth(int amount) {
    setState(() {
      month = DateTime(month.year, month.month + amount);
      selectedDate = DateTime(month.year, month.month, 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildNavigation(),
                  const SizedBox(height: 12),
                  if (constraints.maxWidth >= 650)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 7, child: buildCalendar()),
                        const SizedBox(width: 12),
                        Expanded(flex: 3, child: buildLegend()),
                      ],
                    )
                  else ...[
                    buildCalendar(),
                    const SizedBox(height: 12),
                    buildLegend(),
                  ],
                  const SizedBox(height: 30),
                  if (constraints.maxWidth >= 850)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: buildHabitColumn(
                          'Nawyki na każdy dzień', dailyHabits)),
                        const SizedBox(width: 14),
                        Expanded(child: buildHabitColumn(
                          'Zaplanowane nawyki', plannedHabits)),
                        const SizedBox(width: 14),
                        Expanded(child: buildHabitColumn(
                          'Nawyki elastyczne', flexibleHabits)),
                      ],
                    )
                  else
                    Column(
                      children: [
                        buildHabitColumn('Nawyki na każdy dzień', dailyHabits),
                        const SizedBox(height: 22),
                        buildHabitColumn('Zaplanowane nawyki', plannedHabits),
                        const SizedBox(height: 22),
                        buildHabitColumn('Nawyki elastyczne', flexibleHabits),
                      ],
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildNavigation() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 12,
        runSpacing: 12,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.insights, color: navy, size: 28),
              const SizedBox(width: 8),
              const Text(
                'Tinto',
                style: TextStyle(
                  color: ink,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Wrap(
            spacing: 4,
            runSpacing: 4,
            children: [
              navItem(Icons.home_outlined, 'Strona główna', true),
              navItem(Icons.track_changes, 'Nawyki', false),
              navItem(Icons.bar_chart, 'Statystyki', false),
              navItem(Icons.calendar_month, 'Kalendarz', false),
            ],
          ),
          const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.search, color: Colors.grey),
              SizedBox(width: 12),
              Icon(Icons.notifications_none, color: Colors.grey),
              SizedBox(width: 12),
              CircleAvatar(
                radius: 15,
                backgroundColor: navy,
                child: Icon(Icons.person, size: 19, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget navItem(IconData icon, String label, bool active) {
  return InkWell(
    borderRadius: BorderRadius.circular(9),
    onTap: () {
      if (label == 'Strona główna') {
        return;
      }

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EmptyPage(title: label),
        ),
      );
    },
    child: Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: active
            ? const Color(0xFFDAD9EA)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(9),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: ink),
          const SizedBox(width: 5),
          Text(
            label,
            style: const TextStyle(
              fontSize: 18,
              color: ink,
            ),
          ),
        ],
      ),
    ),
  );
}

  Widget buildCalendar() {
    final firstDay = DateTime(month.year, month.month, 1);
    final daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    final startOffset = firstDay.weekday - 1;
    final totalCells = ((startOffset + daysInMonth + 6) ~/ 7) * 7;
    final previousMonthDays =
        DateTime(month.year, month.month, 0).day;

    const monthNames = [
      'Styczeń', 'Luty', 'Marzec', 'Kwiecień',
      'Maj', 'Czerwiec', 'Lipiec', 'Sierpień',
      'Wrzesień', 'Październik', 'Listopad', 'Grudzień'
    ];

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFFEF8),
        border: Border.all(color: const Color(0xFFB8B9FA), width: 1.4),
        borderRadius: BorderRadius.circular(7),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            child: Row(
              children: [
                monthButton(Icons.chevron_left, () => changeMonth(-1)),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    '${monthNames[month.month - 1]} ${month.year}',
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: ink,
                    ),
                  ),
                ),
                monthButton(Icons.chevron_right, () => changeMonth(1)),
              ],
            ),
          ),
          Row(
            children: weekdays.map((day) {
              return Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Text(
                      day,
                      style: const TextStyle(fontSize: 20, color: ink),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: totalCells,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 2,
            ),
            itemBuilder: (context, index) {
              final dayNumber = index - startOffset + 1;
              final inMonth = dayNumber >= 1 && dayNumber <= daysInMonth;

              final date = inMonth
                  ? DateTime(month.year, month.month, dayNumber)
                  : dayNumber < 1
                      ? DateTime(month.year, month.month - 1,
                          previousMonthDays + dayNumber)
                      : DateTime(month.year, month.month + 1,
                          dayNumber - daysInMonth);

              final today = DateTime.now();

final isToday = date.year == today.year &&
    date.month == today.month &&
    date.day == today.day;

final isSelected = date.year == selectedDate.year &&
    date.month == selectedDate.month &&
    date.day == selectedDate.day;

              final icons = inMonth
                  ? (calendarHabits[dayNumber] ?? <IconData>[])
                  : <IconData>[];

              return InkWell(
                onTap: () => setState(() => selectedDate = date),
                child: Container(
                  decoration: BoxDecoration(
  color: isSelected
      ? lavender
      : isToday
          ? const Color(0xFFE8E9FF)
          : Colors.transparent,
  border: Border.all(
    color: isSelected
        ? purple
        : isToday
            ? navy
            : const Color(0xFFB8B9FA),
    width: isSelected ? 2 : isToday ? 1.5 : 0.65,
  ), //selected day decor is up
),
                  padding: const EdgeInsets.all(4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${date.day}',
                        style: TextStyle(
                          fontSize: 15,
                          color: inMonth ? ink : Colors.grey,
                          fontWeight: isSelected || isToday
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 3,
                            children: icons.map((icon) {
                              return Icon(
                                icon,
                                size: 19,
                                color: icon == Icons.bolt
                                    ? ink
                                    : const Color(0xFFD5D8FF),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget monthButton(IconData icon, VoidCallback onPressed) {
    return SizedBox(
      width: 25,
      height: 25,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.zero,
          side: const BorderSide(color: Color(0xFFB8B9FA)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        child: Icon(icon, size: 17, color: ink),
      ),
    );
  }

  Widget buildLegend() {
    final entries = [
      [Icons.track_changes, 'Trackable'],
      [Icons.favorite, 'Ból serca'],
      [Icons.bolt, 'Dużo energii'],
      [Icons.card_giftcard, 'Party'],
    ];

    return Container(
      constraints: const BoxConstraints(minHeight: 300),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFEF8),
        border: Border.all(color: const Color(0xFFB8B9FA), width: 1.4),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Legenda',
            style: TextStyle(
              color: ink,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ), // legenda stuff is up from here
          ),
          const SizedBox(height: 16),
          ...entries.map((entry) {
            final icon = entry[0] as IconData;
            final label = entry[1] as String;
            return Padding(
              padding: const EdgeInsets.only(bottom: 9),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 12,
                    backgroundColor: const Color(0xFFE5E5EC),
                    child: Icon(icon, size: 15, color: ink),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      label,
                      style: const TextStyle(fontSize: 20, color: ink),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget buildHabitColumn(String title, List<Habit> habits) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 16),
        ...habits.map((habit) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: HabitCard(habit: habit, weekdays: weekdays),
        )),
      ],
    );
  }
}

class Habit {
  final String name;
  final IconData icon;
  final List<int> activeDays;
  final String? progress;

  Habit(this.name, this.icon, this.activeDays, {this.progress});
}

class HabitCard extends StatefulWidget {
  final Habit habit;
  final List<String> weekdays;

  const HabitCard({
    super.key,
    required this.habit,
    required this.weekdays,
  });

  @override
  State<HabitCard> createState() => _HabitCardState();
}

class _HabitCardState extends State<HabitCard> {
  late List<bool> selected;

  @override
  void initState() {
    super.initState();
    selected = List.generate(
      7,
      (index) => widget.habit.activeDays.contains(index),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFEF8),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.025),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  widget.habit.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: ink,
                  ),
                ),
              ),
              if (widget.habit.progress != null)
  Text(
    '${selected.take(7).where((day) => day).length}/5',
    style: const TextStyle(
      fontWeight: FontWeight.bold,
      color: ink,
    ),
  ),
            ],
          ),
          const SizedBox(height: 10),
          LayoutBuilder(
            builder: (context, constraints) {

              return Row(
                children: List.generate(7, (index) {
                  final active = selected[index];
final todayIndex = DateTime.now().weekday - 1;
final isToday = index == todayIndex;

                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: index == 6 ? 0 : 4,
                      ),
                      child: SizedBox(
                        height: 35,
                        child: OutlinedButton(
                          onPressed: () {
                            setState(() {
                              selected[index] = !selected[index];
                            });
                          },
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.zero,
                           backgroundColor: active
    ? navy
    : isToday
        ? const Color(0xFFB8B8B8)
        : Colors.transparent,
                            foregroundColor:
                                active ? Colors.white : Colors.black54,
                            side: BorderSide(
                              color: isToday
    ? const Color(0xFF888888)
    : active
        ? navy
        : const Color(0xFF9999A5),
                            
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              widget.weekdays[index],
                              style: const TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              );
            },
          ),
        ],
      ),
    );
  }
}
// empty page thing below
class EmptyPage extends StatelessWidget {
  final String title;

  const EmptyPage({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: navy),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: ink,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: const SizedBox.expand(),
    );
  }
}
