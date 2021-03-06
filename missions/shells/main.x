NORK       F     ?                                  WorldInfo()
{
  CellMapX(8);
  CellMapZ(8);
}

DefineTeams()
{
  CreateTeam("A", 0)
  {
    Color(0, 0, 0);

    Relations()
    {
      With("A", "Ally");
    }

    DefaultClient(1);
    AvailablePlay(1);
    HasStats(1);
    PermanentRadar(1);
    RequireAI(0);
    Side("army");
    SideFixed(1);

    Objectives()
    {
      ReaperId(1);
    }

    StartPoint(0.100000, 0.100000);
    StartYaw(0.000000);
    Personality("None");
    PainCurrentCluster(0);
    UniqueScriptId(0);
    Storage();
  }
}

World("shell");#include "if_shell.cfg"CreateObject("cineractive_introcamera", 1)
{
  ObjectiveObj()
  {
    Condition();
  }
}CreateObjectType("cineractive_introcamera", "Objective")
{
  Condition("TRUE");

  Action()
  {
    Cineractive()
    {
      At(0)
      {
        Fade()
        {
          Time(0, 0.0, 0.2);
          Direction("up");
        }
      }
    }
  }
}    game.cfg8   2      if_game.cfgj         objects.cfg?  ^       	types.cfg?    