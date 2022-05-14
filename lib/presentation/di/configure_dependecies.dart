import 'modules/client_module.dart';
import 'modules/cubit_module.dart';
import 'modules/i_register_interface.dart';
import 'modules/repository_module.dart';
import 'modules/use_case_module.dart';

Future<void> configureDependencies() async {
  final List<IRegisterInterface> modules = [
    ClientModule(),
    RepositoryModule(),
    UseCaseModule(),
    CubitModule(),
  ];

  for (final module in modules) {
    await module.registerDependencies();
  }
}
