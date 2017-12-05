import 'dart:async';
import 'hero.dart';
import 'hero_service.dart';
import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

@Component(
  selector: 'my-dashboard',
  templateUrl: 'dashboard_component.html',
  styleUrls: const ['dashboard_component.css'],
  directives: const [CORE_DIRECTIVES, ROUTER_DIRECTIVES]
)
class DashboardComponent implements OnInit {
  final HeroService _heroService;
  List<Hero> heroes;

  DashboardComponent(this._heroService);

  @override
  Future<Null> ngOnInit() async {
    heroes = (await _heroService.getHeroes()).take(4).toList();
  }
}