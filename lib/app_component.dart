import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'src/dashboard_component.dart';
import 'src/hero_detail_component.dart';
import 'src/hero_service.dart';
import 'src/heroes_component.dart';

@Component(
    selector: 'app-component',
    templateUrl: 'app_component.html',
    styleUrls: const ['app_component.css'],
    directives: const [ROUTER_DIRECTIVES],
    providers: const [HeroService]
  )
@RouteConfig(
  const [
    const Route(path: '/heroes', name: 'Heroes', component: HeroesComponent),
    const Route(path: '/dashboard', name: 'Dashboard', component: DashboardComponent),
    const Route(path: '/detail/:id', name: 'HeroDetail', component: HeroDetailComponent),
    const Redirect(path: '/', redirectTo: const ['Dashboard'])
  ]
)
class AppComponent {
  final title = 'Tour of Heroes';
}
