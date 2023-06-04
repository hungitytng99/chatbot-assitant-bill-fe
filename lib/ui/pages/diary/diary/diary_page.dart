import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ihz_bql/common/app_colors.dart';
import 'package:ihz_bql/common/app_text_styles.dart';
import 'package:ihz_bql/ui/pages/diary/diary/diary_cubit.dart';
import 'package:ihz_bql/utils/datetime_formatter.dart';
import 'package:table_calendar/table_calendar.dart';
import './diary_calendar_utils.dart';
import 'package:intl/intl.dart';

class DiaryPage extends StatefulWidget {
  DiaryPage({
    Key? key,
  }) : super(key: key);
  @override
  _DiaryPageState createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay = DateTime.now();
  CalendarStyle calendarStyle = CalendarStyle(
    selectedDecoration: BoxDecoration(
      color: AppColors.main,
      shape: BoxShape.circle,
    ),
    todayDecoration: const BoxDecoration(
      color: Color(0xFFf8bd7f),
      shape: BoxShape.circle,
    ),
    markerDecoration: const BoxDecoration(
      color: Color(0xFFf8bd7f),
    ),
  );
  late DiaryCubit _diaryCubit;

  @override
  void initState() {
    _diaryCubit = BlocProvider.of<DiaryCubit>(context);
    _diaryCubit.getMonthlyHistoryPractices(
      startDate: getStringFromDateTime(dateTime: firstDayOfMonth),
      endDate: getStringFromDateTime(dateTime: lastDayOfMonth),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: TableCalendar(
              firstDay: kFirstDay,
              lastDay: kLastDay,
              calendarStyle: calendarStyle,
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(_selectedDay, selectedDay)) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                }
              },
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
              ),
              daysOfWeekStyle: DaysOfWeekStyle(
                weekendStyle: AppTextStyle.primaryS16,
              ),
              onPageChanged: (focusedDay) {
                // No need to call `setState()` here
                _focusedDay = focusedDay;
              },
              calendarBuilders:
                  CalendarBuilders(markerBuilder: (context, day, events) {
                print(getStringFromDateTime(dateTime: day));
                return BlocBuilder<DiaryCubit, DiaryState>(
                  bloc: _diaryCubit,
                  buildWhen: (prev, current) {
                    return (prev.getMonthlyHistoryPracticesStatus !=
                        current.getMonthlyHistoryPracticesStatus);
                  },
                  builder: (context, state) {
                    return (state.monthlyHistoryPractices?.practiceDate ?? [])
                            .contains(getStringFromDateTime(dateTime: day))
                        ? Container(
                            width: 10,
                            height: 10,
                            margin: const EdgeInsets.only(bottom: 3),
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                                color: Colors.lightBlue,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                          )
                        : Container();
                  },
                );
              })),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                for (int i = 0; i < 100; i++) ...{
                  const Text('Tooi la ai'),
                },
              ],
            ),
          ),
        ),
      ],
    );
  }
}
