import 'dart:async';
import 'hero_service.dart';
import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'hero.dart';
import 'package:angular_router/angular_router.dart';

@Component(
  selector: 'hero-detail',
  templateUrl: "hero_detail_component.html",
  styleUrls: const ["hero_detail_component.css"],
  directives: const [CORE_DIRECTIVES, formDirectives]
)
class HeroDetailComponent implements OnInit {
  Hero hero;
  final HeroService _heroService;
  final RouteParams _routeParams;
  final Location _location;
  
  HeroDetailComponent(this._heroService, this._routeParams, this._location);

  @override
  Future<Null> ngOnInit() async {
    int id = int.parse(_routeParams.get('id') ?? '', onError: (_) => null);
    if (id != null) hero = await _heroService.getHero(id);
  }

  void goBack() => _location.back();
}