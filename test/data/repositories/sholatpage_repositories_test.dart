import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
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
      when(() => fakeProvider.getCityCode('Malang', http.Client())).thenThrow(Exception());
      expect(await sholatpageRepositories.getSholatData(), equals(null));
    });

    test('Failed get sholat time case: ', () async {
      when(() => fakeProvider.getSholatTimes('0', date, http.Client())).thenThrow(Exception());
      expect(await sholatpageRepositories.getSholatData(), equals(null));
    });

    test('Success get sholatData: ', () async {

    });
  });
}