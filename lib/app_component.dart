import 'package:angular/angular.dart';
import 'src/hero.dart';
import 'src/hero_detail_component.dart';
import 'src/hero_service.dart';

@Component(
    selector: 'app-component',
    templateUrl: 'app_component.html',
    directives: const [CORE_DIRECTIVES, HeroDetailComponent],
    styleUrls: const ['app_component.css'],
    providers: const [HeroService]
  )
class AppComponent implements OnInit {
  final title = 'Tour of Heroes';
  List<Hero> heroes;
  Hero selectedHero;
  final HeroService _heroService;

  AppComponent(this._heroService);

  void ngOnInit() => getHeroes();

  Future<Null> getHeroes() async => heroes = await _heroService.getHeroes();

  void onSelect(Hero hero) => selectedHero = hero;
}
