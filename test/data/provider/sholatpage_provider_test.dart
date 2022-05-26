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
  late Map<String, dynamic> kiblatDirectionResponse;
  late Uri cityCodeUrl;
  late String city;
  late Uri sholatTimeUrl;
  late Uri kiblatDirectionUrl;
  late DateTime time;
  late String dummyCityCode;

  setUp(() {
    time = DateTime.now();
    fakeClient = HttpMock();
    sholatpageProvider = SholatpageProvider();
    city = 'Kota Malang';
    kiblatDirectionUrl =
        Uri.parse('https://time.siswadi.com/qibla/?address=malang');
    cityCodeUrl =
        Uri.parse('https://api.myquran.com/v1/sholat/kota/cari/malang');
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

    kiblatDirectionResponse = {
      "data": {
        "kabah": "294.20984823418&#176; (WNW)",
        "derajat": 294.20984823418496,
        "kompas": "WNW",
        "image":
            "https:\/\/kitaumroh.erpeel.com\/qibla\/kompas\/294.20984823418.png"
      },
      "location": {
        "latitude": "-7.9666204000",
        "longitude": "112.6326321000",
        "address": "Malang, Malang City, East Java, Indonesia"
      },
      "status": "OK",
      "request": [
        "2022-05-26 18:26:51 Asia\/Jakarta",
        "GET",
        null,
        "139.228.62.94:37820",
        null
      ]
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

  group('getKiblatDirection tests:', () {
    test('Success case', () async {
      when(() => fakeClient.get(kiblatDirectionUrl)).thenAnswer(
        (_) => Future.value(
          http.Response(json.encode(kiblatDirectionResponse), 200),
        ),
      );
      double kiblatDirection =
          await sholatpageProvider.getKiblatDirection(city, fakeClient);
      expect(kiblatDirection, 294.20984823418496);
    });

    test('Failed case:', () async {
      when(() => fakeClient.get(kiblatDirectionUrl)).thenAnswer(
        (_) => Future.value(
          http.Response(json.encode(kiblatDirectionResponse), 404),
        ),
      );
      expect(sholatpageProvider.getKiblatDirection(city, fakeClient),
          throwsException);
    });
  });
}
