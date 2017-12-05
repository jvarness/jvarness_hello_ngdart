import 'dart:async';
import 'package:angular/angular.dart';
import 'hero.dart';
import 'hero_service.dart';
import 'package:angular_router/angular_router.dart';

@Component(
  selector: 'my-heroes',
  templateUrl: 'heroes_component.html',
  styleUrls: const ['heroes_component.css'],
  directives: const [CORE_DIRECTIVES],
  pipes: const [COMMON_PIPES]
)
class HeroesComponent implements OnInit {
  final HeroService _heroService;
  final Router _router;
  List<Hero> heroes;
  Hero selectedHero;

  HeroesComponent(this._heroService, this._router);

  @override
  ngOnInit() => _getHeroes();

  Future<Null> _getHeroes() async => heroes = await _heroService.getHeroes();

  void onSelect(Hero hero) => selectedHero = hero;

  Future<Null> goToDetail() async => _router.navigate([
    'HeroDetail',
    { 'id': selectedHero.id.toString() }
  ]);

  Future<Null> add(String name) async {
    name = name.trim();
    if (name.isEmpty) return;
    heroes.add(await _heroService.create(name));
    selectedHero = null;
  }

  Future<Null> delete(Hero hero) async {
    await _heroService.delete(hero.id);
    heroes.remove(hero);
    if (selectedHero == hero) selectedHero = null;
  }
}