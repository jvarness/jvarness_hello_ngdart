import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:jvarness_hello_ngdart/app_component.dart';

void main() {
  bootstrap(AppComponent, [
    ROUTER_PROVIDERS,
    provide(LocationStrategy, useClass: HashLocationStrategy)
  ]);
}
