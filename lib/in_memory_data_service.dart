import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:angular/angular.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'src/hero.dart';

@Injectable()
class InMemoryDataService extends MockClient {
  static final _initialHeroes = [
    {'id': 11, 'name': 'George Washington'},
    {'id': 12, 'name': 'Mr Pants'},
    {'id': 13, 'name': 'Star Boy'},
    {'id': 14, 'name': 'Captain of Outer Space'},
    {'id': 15, 'name': 'Annie Oakley'},
    {'id': 16, 'name': 'Pablo Picasso'},
  ];
  static List<Hero> _heroesDb;
  static int _nextId;
  static Future<Response> _handler(Request request) async {
    if (_heroesDb == null) resetDb();
    var data;
    switch (request.method) {
      case 'GET':
        final id =
            int.parse(request.url.pathSegments.last, onError: (_) => null);
        if (id != null) {
          data = _heroesDb
              .firstWhere((hero) => hero.id == id); // throws if no match
        } else {
          String prefix = request.url.queryParameters['name'] ?? '';
          final regExp = new RegExp(prefix, caseSensitive: false);
          data = _heroesDb.where((hero) => hero.name.contains(regExp)).toList();
        }
        break;
      case 'POST':
        var name = JSON.decode(request.body)['name'];
        var newHero = new Hero(_nextId++, name);
        _heroesDb.add(newHero);
        data = newHero;
        break;
      case 'PUT':
        var heroChanges = new Hero.fromJson(JSON.decode(request.body));
        var targetHero = _heroesDb.firstWhere((h) => h.id == heroChanges.id);
        targetHero.name = heroChanges.name;
        data = targetHero;
        break;
      case 'DELETE':
        var id = int.parse(request.url.pathSegments.last);
        _heroesDb.removeWhere((hero) => hero.id == id);
        // No data, so leave it as null.
        break;
      default:
        throw 'Unimplemented HTTP method ${request.method}';
    }
    return new Response(JSON.encode({'data': data}), 200,
        headers: {'content-type': 'application/json'});
  }
  static resetDb() {
    _heroesDb = _initialHeroes.map((json) => new Hero.fromJson(json)).toList();
    _nextId = _heroesDb.map((hero) => hero.id).fold(0, max) + 1;
  }
  static String lookUpName(int id) =>
      _heroesDb.firstWhere((hero) => hero.id == id, orElse: null)?.name;
  InMemoryDataService() : super(_handler);
}
