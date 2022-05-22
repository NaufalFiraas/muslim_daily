import 'package:flutter/material.dart';
import 'package:muslim_daily/blocs/sholatpage_blocs/reminder_icon/reminder_icon_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muslim_daily/blocs/sholatpage_blocs/sholat_reminder/sholat_reminder_cubit.dart';
import 'package:muslim_daily/data/models/sholat_reminder_model.dart';
import 'package:muslim_daily/views/quranpage/quran_page.dart';

import '../../data/repositories/sholat_reminder_repositories.dart';

class PrayContainers extends StatefulWidget {
  final Map<String, dynamic> sholatTime;
  final int index;
  final SholatReminderRepositories sholatReminderRepo;

  const PrayContainers(this.sholatTime, this.index, this.sholatReminderRepo,
      {Key? key})
      : super(key: key);

  @override
  State<PrayContainers> createState() => _PrayContainersState();
}

class _PrayContainersState extends State<PrayContainers> {
  late List<String> prays;
  late List<dynamic> times;
  late int i;
  late SholatReminderRepositories sholatReminderRepo;

  @override
  void initState() {
    super.initState();
    prays = widget.sholatTime.keys.toList();
    times = widget.sholatTime.values.toList();
    i = widget.index;
    sholatReminderRepo = widget.sholatReminderRepo;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: prays[i] != 'Imsak' && prays[i] != 'Syuruk'
          ? const EdgeInsets.fromLTRB(15, 2, 15, 2)
          : const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(i == 0 ? 15 : 0),
          bottom: Radius.circular(i == widget.sholatTime.length - 1 ? 15 : 0),
        ),
        color: i % 2 != 0 ? Colors.white : Colors.transparent,
      ),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ReminderIconCubit(),
          ),
          BlocProvider(
            create: (context) => SholatReminderCubit(sholatReminderRepo),
          ),
        ],
        child: BlocListener<SholatReminderCubit, SholatReminderState>(
          listener: (context, state) {
            if (state is SholatReminderOnNotif) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const QuranPage();
                  },
                ),
              );
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                prays[i],
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Roboto',
                ),
              ),
              Row(
                children: [
                  (prays[i] != 'Imsak' && prays[i] != 'Syuruk')
                      ? Builder(builder: (context) {
                          SholatReminderCubit sholatReminder =
                              context.read<SholatReminderCubit>();
                          ReminderIconCubit reminderCubit =
                              context.watch<ReminderIconCubit>();
                          if (reminderCubit.state.isReminderOn) {
                            _notifMethod(
                              reminderCubit,
                              sholatReminder,
                              prays[i],
                              times[i],
                            );
                          }

                          return IconButton(
                            onPressed: () {
                              reminderCubit.setReminder(
                                  !reminderCubit.state.isReminderOn);
                              _notifMethod(
                                reminderCubit,
                                sholatReminder,
                                prays[i],
                                times[i],
                              );
                            },
                            icon: Icon(
                              reminderCubit.state.isReminderOn
                                  ? Icons.volume_up
                                  : Icons.volume_off,
                            ),
                          );
                        })
                      : const SizedBox(),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    times[i],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _notifMethod(ReminderIconCubit reminderCubit,
      SholatReminderCubit sholatReminder, String pray, dynamic time) {
    if (reminderCubit.state.isReminderOn) {
      time as String;
      List<String> splitTime = time.split(':');

      sholatReminder.setReminder(
        SholatReminderModel(
          id: i,
          title: pray,
          body: 'Sholat $pray',
          payload: 'Masuk Waktu $pray',
          hour: int.parse(splitTime[0]),
          minute: int.parse(splitTime[1]),
        ),
      );
    } else {
      sholatReminder.cancelReminder(i);
    }
  }
}
