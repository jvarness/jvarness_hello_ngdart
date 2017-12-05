import 'dart:async';
import 'dart:convert';
import 'hero.dart';
import 'package:angular/angular.dart';
import 'package:http/http.dart';

@Injectable()
class HeroService {
  static const _heroesUrl = 'api/heroes';
  static final _headers = { 'Content-Type': 'application/json' };
  
  final Client _http;

  HeroService(this._http);

  Future<List<Hero>> getHeroes() async {
    try {
      final response = await _http.get(_heroesUrl);
      final heroes = _extractData(response)
        .map((value) => new Hero.fromJson(value))
        .toList();
      return heroes;
    } catch (e) {
      throw _handleError(e);
    }
  }

  dynamic _extractData(Response resp) => JSON.decode(resp.body)['data'];

  Exception _handleError(dynamic e) {
    print(e);
    return new Exception('Server error; cause $e');
  }

  Future<Hero> getHero(id) async {
     try {
       final response = await _http.get('$_heroesUrl/$id');
       return new Hero.fromJson(_extractData(response));
     } catch (e) {
       throw _handleError(e);
     }
  }

  Future<Hero> update(Hero hero) async {
    try {
      final url = '$_heroesUrl/${hero.id}';
      final response = await _http.put(url, headers: _headers, body: JSON.encode(hero));

      return new Hero.fromJson(_extractData(response));
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<Hero> create(String name) async {
    try {
      final response = await _http.post(_heroesUrl, headers: _headers, body: JSON.encode({"name" : name}));

      return new Hero.fromJson(_extractData(response));
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<Null> delete(int id) async {
    try {
      await _http.delete('$_heroesUrl/${id}', headers: _headers);
    } catch (e) {
      throw _handleError(e);
    }
  }
}