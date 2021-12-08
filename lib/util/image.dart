import 'package:flutter_router_demo/module/game/model/team.dart';

bool international = true;

class ImageUtil {
  const ImageUtil._();

  static String getStory(String image) {
    return "https://qa-nbaimageproxy.neulion.com/nba_d/thumbs/categories/$image";
  }

  static String getTeamLogo(String team, {bool darkMod = false, int width = 120, int height = 120}) {
    String teamId = TeamManager.getInstance().getTeam(team)?.teamId ?? team;
    String location = international ? "global" : "primary";
    String mode = darkMod ? "L" : "D";
    return "https://cdn-qa.nba.com/logos/nba/$teamId/$location/$mode/${width}x$height/logo.png";
  }
}
