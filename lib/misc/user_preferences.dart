
import '../domini/user.dart';

class UserPreferences {
  static const myUser = User(
    imagePath: 'https://avatars.githubusercontent.com/u/75260498?v=4&auto=format&fit=crop&w=5&q=80', //TODO: qué me pasa domain para la foto??
    name: 'Alexandru Dumitru',
    email: 'victorasenj@gmail.com',
    about:
    'Se deberían añadir otros campos... como coches, logros, kilómetros si se puede, etc. (historial)',
    isDarkMode: false,
  );
}