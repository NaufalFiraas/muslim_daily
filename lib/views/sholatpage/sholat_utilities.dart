import 'package:flutter/material.dart';
import 'package:muslim_daily/blocs/sholatpage_blocs/reminder_icon/reminder_icon_cubit.dart';
import 'package:muslim_daily/data/models/sholatpage_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SholatUtilities {
  static List<Container> buildPraysContainers(
      SholatpageModel sholatModel, BuildContext context) {
    List<String> prays = sholatModel.sholatTime.keys.toList();
    List<dynamic> times = sholatModel.sholatTime.values.toList();

    return List.generate(
      sholatModel.sholatTime.length,
      (index) {
        return Container(
          padding: prays[index] != 'Imsak' && prays[index] != 'Syuruk'
              ? const EdgeInsets.fromLTRB(15, 2, 15, 2)
              : const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(index == 0 ? 15 : 0),
              bottom: Radius.circular(
                  index == sholatModel.sholatTime.length - 1 ? 15 : 0),
            ),
            color: index % 2 != 0 ? Colors.white : Colors.transparent,
          ),
          child: BlocProvider(
            create: (context) => ReminderIconCubit(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  prays[index],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Roboto',
                  ),
                ),
                Row(
                  children: [
                    (prays[index] != 'Imsak' && prays[index] != 'Syuruk')
                        ? Builder(builder: (context) {
                            ReminderIconCubit reminderCubit =
                                context.watch<ReminderIconCubit>();
                            return IconButton(
                              onPressed: () {
                                reminderCubit.setReminder(
                                    !reminderCubit.state.isReminderOn);
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
                      times[index],
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
      },
    );
  }

  static BoxShadow sholatBoxShadow = const BoxShadow(
    spreadRadius: 1,
    blurRadius: 3,
    offset: Offset(0, 1),
    color: Color(0x10000000),
  );

  static TextStyle textStyling({required double size, Color? color}) {
    return TextStyle(
      color: color,
      fontSize: size,
      fontWeight: FontWeight.w500,
      fontFamily: 'Roboto',
    );
  }
}
