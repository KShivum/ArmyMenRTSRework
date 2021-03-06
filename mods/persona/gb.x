NORK       ?     ?~                                  ///////////////////////////////////////////////////////////////////////////////
//
// Pandemic Studios
//
// AI Personality Configuration - Great Battles
//

// Don't load this for Multi
Random(0);

// Add files to the AI configuration stream
Files("AI")
{
  Add("personality_gb_scripts.cfg");
  Add("personality_gb_placement.cfg");
  Add("personality_gb_orderers_units.cfg");
  Add("personality_gb_orderers_buildings.cfg");
  Add("personality_gb_bases.cfg");
}

StartActionAll()
{
  // Create the base
  AddBase("base", "personality.gb.army");

  // Add all units currently on the team
  AssignBaseConstructors("base");
  AssignBaseUnits("base");

  // Start up the scripts
  ExecuteScript("offense.land", "personality.gb.offense.land")
  {
    Op("%.danger", "=", 0.5);
    Op("%.base", "=", "base");
  }
  ExecuteScript("offense.advland", "personality.gb.offense.advland")
  {
    Op("%.danger", "=", 0.5);
    Op("%.base", "=", "base");
  }
  ExecuteScript("offense.vehicles", "personality.gb.offense.vehicles")
  {
    Op("%.danger", "=", 0.3);
    Op("%.base", "=", "base");
  }

  ExecuteScript("offense.air", "personality.gb.offense.air")
  {
    Op("%.danger", "=", 0.5);
    Op("%.base", "=", "base");
  }
  ExecuteScript("defense.land", "personality.gb.defense.land")
  {
    Op("%.base", "=", "base");
  }
}
///////////////////////////////////////////////////////////////////////////////
//
// Pandemic Studios
//
// AI Personality Configuration (Bases)
//

Strategic()
{
  CreateBase("personality.gb.army")
  {
    InitialState("initial");

    State("initial")
    {
      Orderers()
      {

         Add("personality.gb.bulldozer", 1, 10, 0);

        // Then build an HQ...
        Add("personality.gb.hq1", 1, 20, 0);
        // ...and a resource depot
        Add("personality.gb.resourcedepot.permanent", 1, 30, 0);
        //Add("personality.gb.dumptruck", 1, 30, 0);
        // ...and a barracks.
        Add("personality.gb.barracks1", 1, 40, 0);

        // now, get some rudimentary base defense and upgrade
        Add("personality.gb.defense.infantry", 1, 50, 0);
//        Add("personality.gb.hq2", 1, 50, 0);
        // build a garage
//        Add("personality.gb.barracks2", 1, 60, 0);

//        Add("personality.gb.garage1", 1, 70, 0);

        Add("personality.gb.offense.infantry", 1, 80, 0);
        // start cranking out some defensive vehicles and a barracks upgrade
        Add("personality.gb.defense.vehicles", 1, 80, 0);
        // Now that we've got a barracks2, lets crank out an attack force
        Add("personality.gb.offense.advinfantry", 1, 80, 0);
        // vehicles are used in attacks too, y'know!
        Add("personality.gb.offense.vehicles", 1, 80, 0);

       // upgrade
//        Add("personality.gb.hq3", 1, 80, 0);
//        Add("personality.gb.garage2", 1, 80, 0);

        // upgrade the garage and start reaching out for resource
        //Add("personality.gb.resourcedepot.roaming", 100, 100, 0);
        // go hammer and tongs cranking out units
        Add("personality.gb.offense.air", 1, 100, 0);
        // and the final touches...
        Add("personality.gb.baserepair", 1, 100, 0);
//        Add("personality.gb.aagun", 1, 200, 0);

      }
    }

    // here until I figure out what to do with them.
    // should provide base defense
    State("underattack")
    {
      Orderers()
      {
        // Bulldozer
        Add("personality.gb.bulldozer", 1, 10, 0);
        Add("personality.gb.guardtower", 1, 50, 0);
        Add("personality.gb.pillbox", 1, 120, 0);
      }
    }

  }
}
///////////////////////////////////////////////////////////////////////////////
//
// Pandemic Studios
//
// AI Personality Configuration (Orderers)
//

Strategic()
{
  // Headquarters
  CreateBase::Orderer("personality.gb.hq1")
  {
    Manifest("BaseLevel")
    {
      Placement("personality.gb.buildings");
      Types()
      {
        Add("army.building.hq1");
      }
    }
  }

  CreateBase::Orderer("personality.gb.hq2")
  {
    Manifest("BaseLevel")
    {
      Placement("personality.gb.buildings");
      Types()
      {
        Add("army.building.hq2");
      }
    }
  }

  CreateBase::Orderer("personality.gb.hq3")
  {
    Manifest("BaseLevel")
    {
      Placement("personality.gb.buildings");
      Types()
      {
        Add("army.building.hq3");
      }
    }
  }

  // Barracks
  CreateBase::Orderer("personality.gb.barracks1")
  {
    Manifest("BaseLevel")
    {
      Placement("personality.gb.barracks");
      Types()
      {
        Add("army.building.barracks1");
      }
      NoPrereqStall(1);
    }
  }

  CreateBase::Orderer("personality.gb.barracks2")
  {
    Manifest("BaseLevel")
    {
      Placement("personality.gb.buildings");
      Types()
      {
        Add("army.building.barracks2");
      }
    }
  }

  // Garage
  CreateBase::Orderer("personality.gb.garage1")
  {
    Manifest("BaseLevel")
    {
      Placement("personality.gb.garage");
      Types()
      {
        Add("army.building.garage1");
      }
    }
  }

  CreateBase::Orderer("personality.gb.garage2")
  {
    Manifest("BaseLevel")
    {
      Placement("personality.gb.buildings");
      Types()
      {
        Add("army.building.garage2");
      }
    }
  }

  // Resource depot
  CreateBase::Orderer("personality.gb.resourcedepot.permanent")
  {
    Manifest("Resource")
    {
      Placement("personality.gb.buildings");
      Types()
      {
        Add("army.building.resourcedepot");
      }
      FirstResource(0);
      LastResource(0);
    }
  }

  // Resource depot
  CreateBase::Orderer("personality.gb.resourcedepot.roaming")
  {
    Manifest("Resource")
    {
      Placement("personality.gb.buildings");
      Types()
      {
        Add("army.building.resourcedepot");
        Add("army.building.guardtower");
      }
      DangerRatio(0.05);
      FirstResource(1);
      Manage(2);
      Recycle(1);
    }
  }

  // Guard towers
  CreateBase::Orderer("personality.gb.guardtower")
  {
    Manifest("OrdererLevel")
    {
      Placement("personality.gb.defenses.front");
      Types()
      {
        Add("army.building.guardtower");
      }
    }
  }


  // Pill boxes
  CreateBase::Orderer("personality.gb.pillbox")
  {
    Manifest("OrdererLevel")
    {
      Placement("personality.gb.defenses.front");
      Types()
      {
        Add("army.building.pillbox");
      }
    }
  }

  // Anti-Air Guns
  CreateBase::Orderer("personality.gb.aagun")
  {
    Manifest("OrdererLevel")
    {
      Placement("personality.gb.buildings");
      Types()
      {
        Add("army.building.aagun");
      }
    }
  }

}
///////////////////////////////////////////////////////////////////////////////
//
// Pandemic Studios
//
// AI Personality Configuration (Orderers)
//

Strategic()
{
  // Bulldozer
  CreateBase::Orderer("personality.gb.bulldozer")
  {
    Manifest("Level")
    {
      Types()
      {
        Add("army.unit.bulldozer");
      }
    }
  }

  // Dumptruck
  CreateBase::Orderer("personality.gb.dumptruck")
  {
    Manifest("Level")
    {
      Types()
      {
        Add("army.unit.dumptruck", 1);
      }
    }
  }

  // Offense infantry
  CreateBase::Orderer("personality.gb.offense.infantry")
  {
    Manifest("Level")
    {
      Script("offense.land");
      Types()
      {
        Add("army.unit.grunt", 3);
        Add("army.unit.grenadier", 3);
      }
      CanBuild(1);
      Random(1);
      //NoBeyondWeighting(1);
    }
  }

  // Offense infantry
  CreateBase::Orderer("personality.gb.offense.advinfantry")
  {
    Manifest("Level")
    {
      Script("offense.advland");
      Types()
      {
        Add("army.unit.machinegunner", 3);
        Add("army.unit.sniper", 2);
        Add("army.unit.mortar", 2);
        Add("army.unit.bazooka", 3);
      }
      CanBuild(1);
      Random(1);
      //NoBeyondWeighting(1);
    }
  }


  // Offense vehicles
  CreateBase::Orderer("personality.gb.offense.vehicles")
  {
    Manifest("Level")
    {
      Script("offense.vehicles");
      Types()
      {
        Add("army.unit.halftrack", 2);
        Add("army.unit.tank", 1);
        //Add("army.unit.dumdum",1);
      }
      CanBuild(1);
      Random(1);
      //NoBeyondWeighting(1);
    }
  }

   // Offense air
  CreateBase::Orderer("personality.gb.offense.air")
  {
    Manifest("Level")
    {
      Script("offense.air");
      Types()
      {
        Add("army.unit.chopper",2);
      }
      CanBuild(1);
      Random(1);
    }
  }

  // Defense infantry
  CreateBase::Orderer("personality.gb.defense.infantry")
  {
    Manifest("Level")
    {
      Script("defense.land");
      Types()
      {
        Add("army.unit.grunt",2);
        Add("army.unit.grenadier",2);
      }
      CanBuild(1);
      Random(1);
      //NoBeyondWeighting(1);
    }
  }

  // Defense vehicles
  CreateBase::Orderer("personality.gb.defense.vehicles")
  {
    Manifest("Level")
    {
      Script("defense.land");
      Types()
      {
        Add("army.unit.halftrack", 1);
        Add("army.unit.tank", 1);
        Add("army.unit.medicjeep", 1);
      }
      CanBuild(1);
      Random(1);
      //NoBeyondWeighting(1);
    }
  }

  // Base repair
  CreateBase::Orderer("personality.gb.baserepair")
  {
    Manifest("Level")
    {
      Types()
      {
        Add("army.unit.medicjeep");
      }
      CanBuild(1);
      Random(1);
    }
  }
}
///////////////////////////////////////////////////////////////////////////////
//
// Pandemic Studios
//
// AI Personality Configuration (Placement)
//

Strategic()
{
  // General buildings
  CreatePlacement("personality.gb.buildings")
  {
    Rule("Distance", 1.0)
    {
      Distance(0);
    }
  }

  // Barracks
  CreatePlacement("personality.gb.barracks")
  {
    Rule("Angle", 1.0)
    {
      Angle(90);
    }
    Rule("Distance", 30.0)
    {
      Distance(50);
    }
  }

  // Garage
  CreatePlacement("personality.gb.garage")
  {
    Rule("Angle", 1.0)
    {
      Angle(270);
    }
    Rule("Distance", 30.0)
    {
      Distance(50);
    }
  }

  // Static defenses
  CreatePlacement("personality.gb.defenses.front")
  {
    Rule("Angle", 1.0)
    {
      Angle(0);
    }
    Rule("Distance", 10.0)
    {
      Distance(120);
    }
  }

  CreatePlacement("personality.gb.defenses.left")
  {
    Rule("Angle", 1.0)
    {
      Angle(70);
    }
    Rule("Distance", 10.0)
    {
      Distance(120);
    }
  }

  CreatePlacement("personality.gb.defenses.right")
  {
    Rule("Angle", 1.0)
    {
      Angle(290);
    }
    Rule("Distance", 10.0)
    {
      Distance(120);
    }
  }
}
///////////////////////////////////////////////////////////////////////////////
//
// Pandemic Studios
//
// AI Personality Configuration (Scripts)
//

Strategic()
{
  // Land offense script
  CreateScript("personality.gb.offense.land")
  {
    InitialState("Start");

    CreateVarFloat("%.danger", 0.2);
    CreateVarInteger("%.cluster.target");
    CreateVarString("%.base");

    State("Start")
    {
      Conditions()
      {
        Condition("ObjectiveCondition")
        {
          Condition("Timer")
          {
            Time(200);
          }
          Transition()
          {
            GoToState("Wait");
          }
        }
      }
    }

    State("Find")
    {
      Action("ApplyRule")
      {
        Rule("FindUndefendedCluster");
        Var("%.cluster.target");
        DangerRatio("%.danger");
      }
      Conditions()
      {
        Condition("HitPoints")
        {
          Operator("<");
          Percentage(80%);
          Transition()
          {
            GoToState("HeavyFire");
          }
        }
        Status("Completed")
        {
          GoToState("Move");
        }
        Status("Failed")
        {
          GoToState("DefendBase");
        }
      }
    }

    State("Move")
    {
      Action("Move")
      {
        Attack(1);
        Location()
        {
          Base("VarCluster", "%.cluster.target");
        }
      }
      Conditions()
      {
        Condition("HitPoints")
        {
          Operator("<");
          Percentage(90%);
          Transition()
          {
            GoToState("HeavyFire");
          }
        }
        Condition("ObjectiveCondition")
        {
          Condition("Timer")
          {
            Time(30);
          }
          Transition()
          {
            GoToState("Wait");
          }
        }
        Status("Completed")
        {
          GoToState("Wait");
        }
      }
    }

    State("Run")
    {
      Action("Move")
      {
        Attack(0);
        Location()
        {
          Base("VarCluster", "%.cluster.target");
        }
      }
      Conditions()
      {
        Condition("ObjectiveCondition")
        {
          Condition("Timer")
          {
            Time(30);
          }
          Transition()
          {
            GoToState("Wait");
          }
        }
        Status("Completed")
        {
          GoToState("Wait");
        }
      }
    }

    State("HeavyFire")
    {
      Conditions()
      {
        Condition("Threat")
        {
          Amount(10%);
          Operator(">");
          Transition()
          {
            GoToState("SeekShelter");
          }
        }
        Condition("ObjectiveCondition")
        {
          Condition("Timer")
          {
            Time(30);
          }
          Transition()
          {
            GoToState("Wait");
          }
        }
      }
    }

    State("SeekShelter")
    {
      Action("ApplyRule")
      {
        Rule("FindShelteredCluster");
        Var("%.cluster.target");
        MaxDistance(150);
      }
      Conditions()
      {
        Status("Completed")
        {
          GoToState("Run");
        }
        Status("Failed")
        {
          //GoToState("ReturnToBase");
          GoToState("Find");
        }
      }
    }

    State("DefendBase")
    {
      Action("ApplyRule")
      {
        Rule("FindProtectBase");
        ArmourClass("structure");
        Var("%.cluster.target");
        Base("%.base");
      }
      Conditions()
      {
        Status("Completed")
        {
          GoToState("Move");
        }
        Status("Failed")
        {
          GoToState("ReturnToBase");
        }
      }
    }

    State("ReturnToBase")
    {
      Action("Move")
      {
        Attack(0);
        Location()
        {
          Base("Base", "%.base");
        }
      }
      Conditions()
      {
        Condition("ObjectiveCondition")
        {
          Condition("Timer")
          {
            Time(30);
          }
          Transition()
          {
            GotoState("Wait");
          }
        }
        Status("Completed")
        {
          GoToState("Wait");
        }
      }
    }

    State("Wait")
    {
      Conditions()
      {
        Condition("HitPoints")
        {
          Operator("<");
          Percentage(90%);
          Transition()
          {
            GoToState("HeavyFire");
          }
        }
        Condition("And")
        {
          Condition("ObjectiveCondition")
          {
            Condition("Timer")
            {
              Time(10);
            }
          }
          Condition("Count")
          {
            Amount(5);
            Operator(">");
          }
          Transition()
          {
            GoToState("Find");
          }
        }
      }
    }
  }

/////////////////////////////////////////////////////////////////
// Adv Land
//
  CreateScript("personality.gb.offense.advland")
  {
    InitialState("Start");

    CreateVarFloat("%.danger", 0.2);
    CreateVarInteger("%.cluster.target");
    CreateVarString("%.base");

    State("Start")
    {
      Conditions()
      {
        Condition("ObjectiveCondition")
        {
          Condition("Timer")
          {
            Time(600);
          }
          Transition()
          {
            GoToState("Wait");
          }
        }
      }
    }

    State("Find")
    {
      Action("ApplyRule")
      {
        Rule("FindUndefendedCluster");
        Var("%.cluster.target");
        DangerRatio("%.danger");
      }
      Conditions()
      {
        Condition("HitPoints")
        {
          Operator("<");
          Percentage(80%);
          Transition()
          {
            GoToState("HeavyFire");
          }
        }
        Status("Completed")
        {
          GoToState("Move");
        }
        Status("Failed")
        {
          GoToState("DefendBase");
        }
      }
    }

    State("Move")
    {
      Action("Move")
      {
        Attack(1);
        Location()
        {
          Base("VarCluster", "%.cluster.target");
        }
      }
      Conditions()
      {
        Condition("HitPoints")
        {
          Operator("<");
          Percentage(90%);
          Transition()
          {
            GoToState("HeavyFire");
          }
        }
        Condition("ObjectiveCondition")
        {
          Condition("Timer")
          {
            Time(30);
          }
          Transition()
          {
            GoToState("Wait");
          }
        }
        Status("Completed")
        {
          GoToState("Wait");
        }
      }
    }

    State("Run")
    {
      Action("Move")
      {
        Attack(0);
        Location()
        {
          Base("VarCluster", "%.cluster.target");
        }
      }
      Conditions()
      {
        Condition("ObjectiveCondition")
        {
          Condition("Timer")
          {
            Time(30);
          }
          Transition()
          {
            GoToState("Wait");
          }
        }
        Status("Completed")
        {
          GoToState("Wait");
        }
      }
    }

    State("HeavyFire")
    {
      Conditions()
      {
        Condition("Threat")
        {
          Amount(10%);
          Operator(">");
          Transition()
          {
            GoToState("SeekShelter");
          }
        }
        Condition("ObjectiveCondition")
        {
          Condition("Timer")
          {
            Time(30);
          }
          Transition()
          {
            GoToState("Wait");
          }
        }
      }
    }

    State("SeekShelter")
    {
      Action("ApplyRule")
      {
        Rule("FindShelteredCluster");
        Var("%.cluster.target");
        MaxDistance(150);
      }
      Conditions()
      {
        Status("Completed")
        {
          GoToState("Run");
        }
        Status("Failed")
        {
          //GoToState("ReturnToBase");
          GoToState("Find");
        }
      }
    }

    State("DefendBase")
    {
      Action("ApplyRule")
      {
        Rule("FindProtectBase");
        ArmourClass("structure");
        Var("%.cluster.target");
        Base("%.base");
      }
      Conditions()
      {
        Status("Completed")
        {
          GoToState("Move");
        }
        Status("Failed")
        {
          GoToState("ReturnToBase");
        }
      }
    }

    State("ReturnToBase")
    {
      Action("Move")
      {
        Attack(0);
        Location()
        {
          Base("Base", "%.base");
        }
      }
      Conditions()
      {
        Condition("ObjectiveCondition")
        {
          Condition("Timer")
          {
            Time(30);
          }
          Transition()
          {
            GotoState("Wait");
          }
        }
        Status("Completed")
        {
          GoToState("Wait");
        }
      }
    }

    State("Wait")
    {
      Conditions()
      {
        Condition("HitPoints")
        {
          Operator("<");
          Percentage(90%);
          Transition()
          {
            GoToState("HeavyFire");
          }
        }
        Condition("And")
        {
          Condition("ObjectiveCondition")
          {
            Condition("Timer")
            {
              Time(10);
            }
          }
          Condition("Count")
          {
            Amount(5);
            Operator(">");
          }
          Transition()
          {
            GoToState("Find");
          }
        }
      }
    }
  }


/////////////////////////////////////////////////////////////////
// Adv Land
//
  CreateScript("personality.gb.offense.vehicles")
  {
    InitialState("Start");

    CreateVarFloat("%.danger", 0.2);
    CreateVarInteger("%.cluster.target");
    CreateVarString("%.base");

    State("Start")
    {
      Conditions()
      {
        Condition("ObjectiveCondition")
        {
          Condition("Timer")
          {
            Time(700);
          }
          Transition()
          {
            GoToState("Wait");
          }
        }
      }
    }

    State("Find")
    {
      Action("ApplyRule")
      {
        Rule("FindUndefendedCluster");
        Var("%.cluster.target");
        DangerRatio("%.danger");
      }
      Conditions()
      {
        Condition("HitPoints")
        {
          Operator("<");
          Percentage(80%);
          Transition()
          {
            GoToState("HeavyFire");
          }
        }
        Status("Completed")
        {
          GoToState("Move");
        }
        Status("Failed")
        {
          GoToState("DefendBase");
        }
      }
    }

    State("Move")
    {
      Action("Move")
      {
        Attack(1);
        Location()
        {
          Base("VarCluster", "%.cluster.target");
        }
      }
      Conditions()
      {
        Condition("HitPoints")
        {
          Operator("<");
          Percentage(90%);
          Transition()
          {
            GoToState("HeavyFire");
          }
        }
        Condition("ObjectiveCondition")
        {
          Condition("Timer")
          {
            Time(30);
          }
          Transition()
          {
            GoToState("Wait");
          }
        }
        Status("Completed")
        {
          GoToState("Wait");
        }
      }
    }

    State("Run")
    {
      Action("Move")
      {
        Attack(0);
        Location()
        {
          Base("VarCluster", "%.cluster.target");
        }
      }
      Conditions()
      {
        Condition("ObjectiveCondition")
        {
          Condition("Timer")
          {
            Time(30);
          }
          Transition()
          {
            GoToState("Wait");
          }
        }
        Status("Completed")
        {
          GoToState("Wait");
        }
      }
    }

    State("HeavyFire")
    {
      Conditions()
      {
        Condition("Threat")
        {
          Amount(10%);
          Operator(">");
          Transition()
          {
            GoToState("SeekShelter");
          }
        }
        Condition("ObjectiveCondition")
        {
          Condition("Timer")
          {
            Time(30);
          }
          Transition()
          {
            GoToState("Wait");
          }
        }
      }
    }

    State("SeekShelter")
    {
      Action("ApplyRule")
      {
        Rule("FindShelteredCluster");
        Var("%.cluster.target");
        MaxDistance(150);
      }
      Conditions()
      {
        Status("Completed")
        {
          GoToState("Run");
        }
        Status("Failed")
        {
          //GoToState("ReturnToBase");
          GoToState("Find");
        }
      }
    }

    State("DefendBase")
    {
      Action("ApplyRule")
      {
        Rule("FindProtectBase");
        ArmourClass("structure");
        Var("%.cluster.target");
        Base("%.base");
      }
      Conditions()
      {
        Status("Completed")
        {
          GoToState("Move");
        }
        Status("Failed")
        {
          GoToState("ReturnToBase");
        }
      }
    }

    State("ReturnToBase")
    {
      Action("Move")
      {
        Attack(0);
        Location()
        {
          Base("Base", "%.base");
        }
      }
      Conditions()
      {
        Condition("ObjectiveCondition")
        {
          Condition("Timer")
          {
            Time(30);
          }
          Transition()
          {
            GotoState("Wait");
          }
        }
        Status("Completed")
        {
          GoToState("Wait");
        }
      }
    }

    State("Wait")
    {
      Conditions()
      {
        Condition("HitPoints")
        {
          Operator("<");
          Percentage(90%);
          Transition()
          {
            GoToState("HeavyFire");
          }
        }
        Condition("And")
        {
          Condition("ObjectiveCondition")
          {
            Condition("Timer")
            {
              Time(10);
            }
          }
          Condition("Count")
          {
            Amount(5);
            Operator(">");
          }
          Transition()
          {
            GoToState("Find");
          }
        }
      }
    }
  }



  // Air offense script
  CreateScript("personality.gb.offense.air")
  {
    InitialState("Start");

    CreateVarInteger("%.cluster.target");
    CreateVarFloat("%.danger", 0.2);
    CreateVarString("%.base");

    State("Start")
    {
      Conditions()
      {
        Condition("ObjectiveCondition")
        {
          Condition("Timer")
          {
            Time(800);
          }
          Transition()
          {
            GoToState("Wait");
          }
        }
      }
    }

    State("Find")
    {
      Action("ApplyRule")
      {
        Rule("FindUndefendedCluster");
        Var("%.cluster.target");
        DangerRatio("%.danger");
      }
      Conditions()
      {
        Condition("HitPoints")
        {
          Operator("<");
          Percentage(80%);
          Transition()
          {
            GoToState("HeavyFire");
          }
        }

        Status("Completed")
        {
          GoToState("Move");
        }
        Status("Failed")
        {
          GoToState("DefendBase");
        }
      }
    }

    State("Move")
    {
      Action("Move")
      {
        Attack(1);
        Location()
        {
          Base("VarCluster", "%.cluster.target");
        }
      }
      Conditions()
      {
        Condition("HitPoints")
        {
          Operator("<");
          Percentage(90%);
          Transition()
          {
            GoToState("HeavyFire");
          }
        }
        Condition("ObjectiveCondition")
        {
          Condition("Timer")
          {
            Time(30);
          }
          Transition()
          {
            GoToState("Wait");
          }
        }
        Status("Completed")
        {
          GoToState("Wait");
        }
      }
    }

    State("Run")
    {
      Action("Move")
      {
        Attack(0);
        Location()
        {
          Base("VarCluster", "%.cluster.target");
        }
      }
      Conditions()
      {
        Condition("ObjectiveCondition")
        {
          Condition("Timer")
          {
            Time(30);
          }
          Transition()
          {
            GoToState("Wait");
          }
        }
        Status("Completed")
        {
          GoToState("Wait");
        }
      }
    }

    State("HeavyFire")
    {
      Conditions()
      {
        Condition("Threat")
        {
          Amount(20%);
          Operator(">");
          Transition()
          {
            GoToState("SeekShelter");
          }
        }
        Condition("ObjectiveCondition")
        {
          Condition("Timer")
          {
            Time(30);
          }
          Transition()
          {
            GoToState("Wait");
          }
        }
      }
    }

    State("SeekShelter")
    {
      Action("ApplyRule")
      {
        Rule("FindShelteredCluster");
        Var("%.cluster.target");
        MaxDistance(150);
      }
      Conditions()
      {
        Status("Completed")
        {
          GoToState("Run");
        }
        Status("Failed")
        {
          GoToState("ReturnToBase");
        }
      }
    }

    State("DefendBase")
    {
      Action("ApplyRule")
      {
        Rule("FindProtectBase");
        ArmourClass("structure");
        Var("%.cluster.target");
        Base("%.base");
      }
      Conditions()
      {
        Status("Completed")
        {
          GoToState("Move");
        }
        Status("Failed")
        {
          GoToState("ReturnToBase");
        }
      }
    }

    State("ReturnToBase")
    {
      Action("Move")
      {
        Attack(0);
        Location()
        {
          Base("Base", "%.base");
        }
      }
      Conditions()
      {
        Condition("ObjectiveCondition")
        {
          Condition("Timer")
          {
            Time(30);
          }
          Transition()
          {
            GotoState("Wait");
          }
        }
        Status("Completed")
        {
          GoToState("Wait");
        }
      }
    }

    State("Wait")
    {
      Conditions()
      {
        Condition("HitPoints")
        {
          Operator("<");
          Percentage(90%);
          Transition()
          {
            GoToState("HeavyFire");
          }
        }
        Condition("And")
        {
          Condition("ObjectiveCondition")
          {
            Condition("Timer")
            {
              Time(10);
            }
          }
          Condition("Count")
          {
            Amount(5);
            Operator(">");
          }
          Transition()
          {
            GoToState("Find");
          }
        }
      }
    }
  }

  // Land defense script
  CreateScript("personality.gb.defense.land")
  {
    InitialState("Find");
    CreateVarInteger("%.cluster");
    CreateVarString("%.base");
    State("Find")
    {
      Action("ApplyRule")
      {
        Rule("FindProtectBase");
        ArmourClass("structure");
        Var("%.cluster");
        Base("%.base");
      }
      Conditions()
      {
        Condition("Count")
        {
          Amount(0);
          Operator("==");
          Transition()
          {
            GoToState("Wait");
          }
        }
        Status("Completed")
        {
          GoToState("Move");
        }
        Status("Failed")
        {
          GoToState("Wait");
        }
      }
    }

    State("Move")
    {
      Action("Move")
      {
        Attack(1);
        Location()
        {
          Base("VarCluster", "%.cluster");
        }
      }
      Conditions()
      {
        Condition("ObjectiveCondition")
        {
          Condition("Timer")
          {
            Time(10);
          }
          Transition()
          {
            GoToState("Find");
          }
        }
      }
    }
    State("Wait")
    {
      Conditions()
      {
        Condition("Count")
        {
          Amount(5);
          Operator(">");
          Transition()
          {
            GoToState("Find");
          }
        }
      }
    }
  }
}
}
    mod.cfg8   `      personality_gb_bases.cfg?  		      %personality_gb_orderers_buildings.cfg?  ?      !personality_gb_orderers_units.cfg,  S      personality_gb_placement.cfg&  ?      personality_gb_scripts.cfg{+  S  