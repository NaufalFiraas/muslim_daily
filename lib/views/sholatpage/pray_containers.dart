import 'package:flutter/material.dart';
import 'package:muslim_daily/blocs/sholatpage_blocs/reminder_icon/reminder_icon_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PrayContainers extends StatefulWidget {
  final Map<String, dynamic> sholatTime;
  final int index;

  const PrayContainers(this.sholatTime, this.index, {Key? key})
      : super(key: key);

  @override
  State<PrayContainers> createState() => _PrayContainersState();
}

class _PrayContainersState extends State<PrayContainers> {
  late List<String> prays;
  late List<dynamic> times;
  late int i;

  @override
  void initState() {
    super.initState();
    prays = widget.sholatTime.keys.toList();
    times = widget.sholatTime.values.toList();
    i = widget.index;
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
      child: BlocProvider(
        create: (context) => ReminderIconCubit(),
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
                        ReminderIconCubit reminderCubit =
                            context.watch<ReminderIconCubit>();
                        return IconButton(
                          onPressed: () {
                            reminderCubit
                                .setReminder(!reminderCubit.state.isReminderOn);
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
    );
  }
}
