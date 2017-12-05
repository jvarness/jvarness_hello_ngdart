import 'dart:async';
import 'hero.dart';
import 'mock_heroes.dart';
import 'package:angular/angular.dart';

@Injectable()
class HeroService {
  Future<List<Hero>> getHeroes() async => mockHeroes;
}