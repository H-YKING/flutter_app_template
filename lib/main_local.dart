import 'common/Enum.dart';
import 'app.dart';
import 'common/Global.dart';

void main() {
  Global.env = Env.LOCAL;
  Global.init(child: App());
}
