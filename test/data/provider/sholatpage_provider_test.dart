import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:muslim_daily/data/providers/sholatpage_providers.dart';

class HttpMock extends Mock implements http.Client {}

void main() {
  late http.Client fakeClient;
  late SholatpageProvider sholatpageProvider;
  late Map<String, dynamic> cityCodeResponse;
  late Map<String, dynamic> sholatTimeResponse;
  late Uri cityCodeUrl;
  late String city;
  late Uri sholatTimeUrl;
  late DateTime time;
  late String dummyCityCode;

  setUp(() {
    time = DateTime.now();
    fakeClient = HttpMock();
    sholatpageProvider = SholatpageProvider();
    city = 'Malang';
    cityCodeUrl =
        Uri.parse('https://api.myquran.com/v1/sholat/kota/cari/$city');
    dummyCityCode = '1609';
    sholatTimeUrl = Uri.parse(
        'https://api.myquran.com/v1/sholat/jadwal/$dummyCityCode/${time.year}/${time.month}/${time.day}');
    cityCodeResponse = {
      'status': true,
      'data': [
        {
          'id': '1609',
          'lokasi': 'KAB. MALANG',
        },
        {
          'id': '1632',
          'lokasi': 'KOTA KEDIRI',
        },
      ],
    };

    sholatTimeResponse = {
      'status': true,
      'data': {
        'id': '1609',
        'lokasi': 'KAB. MALANG',
        'daerah': 'JAWA TIMUR',
        'koordinat': {
          'lat': -7.12345678,
          'lon': 112.9876543,
          'lintang': "7° 49' 9.74\" S",
          'bujur': "112° 02' 29.53\" E",
        },
        'jadwal': {
          'tanggal': 'Rabu, 23/06/2021',
          'imsak': '04:13',
          'subuh': '04:23',
          'terbit': '05:41',
          'dhuha': '06:10',
          'dzuhur': '11:38',
          'ashar': '14:57',
          'maghrib': '17:27',
          'isya': '18:42',
          'date': '2021-06-23',
        },
      },
    };
  });

  group('getCityCode tests: ', () {
    test('Success case: ', () async {
      when(() => fakeClient.get(cityCodeUrl)).thenAnswer((_) => Future.value(
            http.Response(json.encode(cityCodeResponse), 200),
          ));
      String cityCode = await sholatpageProvider.getCityCode(city, fakeClient);
      expect(cityCode, equals('1609'));
    });

    test('Failed case: ', () {
      when(() => fakeClient.get(cityCodeUrl)).thenAnswer((_) => Future.value(
            http.Response(json.encode(cityCodeResponse), 404),
          ));
      expect(sholatpageProvider.getCityCode(city, fakeClient), throwsException);
    });
  });

  group('getSholatTimes tests: ', () {
    test('Success case: ', () async {
      when(() => fakeClient.get(sholatTimeUrl)).thenAnswer((_) => Future.value(
            http.Response(json.encode(sholatTimeResponse), 200),
          ));
      Map<String, dynamic> result = await sholatpageProvider.getSholatTimes(
          dummyCityCode, time, fakeClient);
      expect(
        result,
        equals(
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
    });

    test('Failed case:', () {
      when(() => fakeClient.get(sholatTimeUrl)).thenAnswer((_) => Future.value(
            http.Response(json.encode(sholatTimeResponse), 404),
          ));
      expect(sholatpageProvider.getSholatTimes(dummyCityCode, time, fakeClient),
          throwsException);
    });
  });
}