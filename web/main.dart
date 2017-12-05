import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:jvarness_hello_ngdart/app_component.dart';
import 'package:http/http.dart';
import 'package:jvarness_hello_ngdart/in_memory_data_service.dart';

void main() {
  bootstrap(AppComponent, [
    ROUTER_PROVIDERS,
    provide(LocationStrategy, useClass: HashLocationStrategy),
    provide(Client, useClass: InMemoryDataService)
  ]);
}
