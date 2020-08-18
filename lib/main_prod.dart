import 'app.dart';
import 'common/Global.dart';
import 'common/Enum.dart';

void main() {
  Global.env = Env.PROD;
  Global.init(child: App());
}
