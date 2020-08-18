import 'app.dart';
import 'common/Global.dart';
import 'common/Enum.dart';

void main() {
  Global.env = Env.STAGING;
  Global.init(child: App());
}
