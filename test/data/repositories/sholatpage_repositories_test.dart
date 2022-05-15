import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:muslim_daily/data/models/sholatpage_model.dart';
import 'package:muslim_daily/data/providers/sholatpage_providers.dart';
import 'package:muslim_daily/data/repositories/sholatpage_repositories.dart';
import 'package:http/http.dart' as http;

class SholatpageProviderMock extends Mock implements SholatpageProvider {}

void main() {
  late SholatpageProvider fakeProvider;
  late DateTime date;
  late SholatpageRepositories sholatpageRepositories;

  setUp(() {
    fakeProvider = SholatpageProviderMock();
    date = DateTime.now();
    sholatpageRepositories = SholatpageRepositories(fakeProvider, date);
  });

  group('getSholatData tests: ', () {
    test('Failed get position case: ', () async {
      when(() => fakeProvider.determinePosition()).thenThrow(Exception());
      expect(await sholatpageRepositories.getSholatData(), equals(null));
    });

    test('Failed get city name case:', () async {
      when(() => fakeProvider.getPlacemarks(0, 0)).thenThrow(Exception());
      expect(await sholatpageRepositories.getSholatData(), equals(null));
    });

    test('Failed get city code case: ', () async {
      when(() => fakeProvider.getCityCode('Malang', http.Client()))
          .thenThrow(Exception());
      expect(await sholatpageRepositories.getSholatData(), equals(null));
    });

    test('Failed get sholat time case: ', () async {
      when(() => fakeProvider.getSholatTimes('0', date, http.Client()))
          .thenThrow(Exception());
      expect(await sholatpageRepositories.getSholatData(), equals(null));
    });

    test('Success get sholatData: ', () async {
      when(() => fakeProvider.determinePosition()).thenAnswer(
        (_) => Future.value({
          'latitude': 20.5,
          'longitude': 30.5,
        }),
      );
      when(() => fakeProvider.getPlacemarks(20.5, 30.5)).thenAnswer(
        (_) => Future.value('Kediri'),
      );
      when(() => fakeProvider.getCityCode('Kediri'))
          .thenAnswer((_) => Future.value('1609'));
      when(() => fakeProvider.getSholatTimes('1609', date))
          .thenAnswer(
        (_) => Future.value(
          {
            'tanggal': 'Rabu, 23/06/2021',
            'waktu': {
              'Imsak': '04:13',
              'Shubuh': '04:23',
              'Syuruk': '05:41',
              'Dhuhur': '11:38',
              'Ashar': '14:57',
              'Maghrib': '17:27',
              "Isya'": '18:42',
            },
          },
        ),
      );
      SholatpageModel? result = await sholatpageRepositories.getSholatData();
      expect(
        result,
        equals(
          const SholatpageModel(
            city: 'Kediri',
            date: 'Rabu, 23/06/2021',
            sholatTime: {
              'Imsak': '04:13',
              'Shubuh': '04:23',
              'Syuruk': '05:41',
              'Dhuhur': '11:38',
              'Ashar': '14:57',
              'Maghrib': '17:27',
              "Isya'": '18:42',
            },
          ),
        ),
      );
    });
  });
}
