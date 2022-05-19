import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class DynamicLinkUtils {
  ///Build a dynamic link firebase
  static Future<String> buildDynamicLink(String query) async {
    String url = "https://electrikedl.page.link";
    String releaseUrl = "https://github.com/Alexandru-D6/pes_electrike/releases";
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: url,
      link: Uri.parse('$url/$query'),
      androidParameters: AndroidParameters(
        packageName: "com.pes.electrike",
        fallbackUrl: Uri.parse(releaseUrl),
        minimumVersion: 0,
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
          description: "........................",
          imageUrl: Uri.parse("https://flutter.dev/images/flutter-logo-sharing.png"),
          title: "Electrike App"),
    );
    final ShortDynamicLink dynamicUrl = await FirebaseDynamicLinks.instance.buildShortLink(parameters);
    return dynamicUrl.shortUrl.toString();
  }
}