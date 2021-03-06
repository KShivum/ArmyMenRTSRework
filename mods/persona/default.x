NORK       ?     ?                                  ///////////////////////////////////////////////////////////////////////////////
//
// Pandemic Studios
//
// AI Personality Configuration
//

// Is this personality available for random selection
Random(1);

// Add files to the AI configuration stream
Files("AI")
{
  Add("personality_default_scripts.cfg");
  Add("personality_default_placement.cfg");
  Add("personality_default_orderers_units.cfg");
  Add("personality_default_orderers_buildings.cfg");
  Add("personality_default_bases.cfg");
}

StartActionAll()
{
  // Create the base
  AddBase("base", "personality.default.army");

  // Add all units currently on the team
  AssignBaseConstructors("base");
  AssignBaseUnits("base");

  // Start up the scripts
  ExecuteScript("offense.land", "personality.default.offense.land")
  {
    Op("%.danger", "=", 0.5);
    Op("%.base", "=", "base");
  }
  ExecuteScript("offense.advland", "personality.default.offense.advland")
  {
    Op("%.danger", "=", 0.5);
    Op("%.base", "=", "base");
  }
  ExecuteScript("offense.vehicles", "personality.default.offense.vehicles")
  {
    Op("%.danger", "=", 0.3);
    Op("%.base", "=", "base");
  }

  ExecuteScript("offense.air", "personality.default.offense.air")
  {
    Op("%.danger", "=", 0.5);
    Op("%.base", "=", "base");
  }
  ExecuteScript("defense.land", "personality.default.defense.land")
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
  CreateBase("personality.default.army")
  {
    InitialState("initial");

    State("initial")
    {
      Orderers()
      {

// resource, priority,
        // Bulldozer
        Add("personality.default.bulldozer", 1, 10, 0);
        // Then build an HQ...
        Add("personality.default.hq1", 1, 20, 0);
        // ...and a resource depot
        Add("personality.default.resourcedepot.permanent", 1, 30, 0);
        Add("personality.default.dumptruck", 1, 30, 0);
        // ...and a barracks.
        Add("personality.default.barracks1", 1, 40, 0);

        // now, get some rudimentary base defense and upgrade
        Add("personality.default.guardtower.left", 1, 50, 0);
        Add("personality.default.guardtower.right", 1, 50, 0);
        Add("personality.default.defense.infantry", 1, 50, 0);
        Add("personality.default.hq2", 1, 50, 0);
        // build a garage
        Add("personality.default.barracks2", 1, 60, 0);
        Add("personality.default.garage1", 1, 70, 0);

        Add("personality.default.offense.infantry", 1, 80, 0);
        // start cranking out some defensive vehicles and a barracks upgrade
        Add("personality.default.defense.vehicles", 1, 80, 0);
        // Now that we've got a barracks2, lets crank out an attack force
        Add("personality.default.offense.advinfantry", 1, 80, 0);
        // vehicles are used in attacks too, y'know!
        Add("personality.default.offense.vehicles", 1, 80, 0);

         // upgrade
        Add("personality.default.hq3", 1, 85, 0);
        Add("personality.default.garage2", 1, 85, 0);

        // upgrade the garage and start reaching out for resource
        Add("personality.default.resourcedepot.roaming", 100, 90, 0);
        // go hammer and tongs cranking out units
        Add("personality.default.offense.air", 1, 100, 0);
        Add("personality.default.pillbox.left", 1, 100, 0);
        Add("personality.default.pillbox.right", 1, 100, 0);
        // and the final touches...
        Add("personality.default.baserepair", 1, 100, 0);
        Add("personality.default.aagun.left", 1, 110, 0);
        Add("personality.default.aagun.right", 1, 110, 0);
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
  CreateBase::Orderer("personality.default.hq1")
  {
    Manifest("BaseLevel")
    {
      Placement("personality.default.buildings");
      Types()
      {
        Add("army.building.hq1");
      }
    }
  }

  CreateBase::Orderer("personality.default.hq2")
  {
    Manifest("BaseLevel")
    {
      Placement("personality.default.buildings");
      Types()
      {
        Add("army.building.hq2");
      }
    }
  }

  CreateBase::Orderer("personality.default.hq3")
  {
    Manifest("BaseLevel")
    {
      Placement("personality.default.buildings");
      Types()
      {
        Add("army.building.hq3");
      }
    }
  }

  // Barracks
  CreateBase::Orderer("personality.default.barracks1")
  {
    Manifest("BaseLevel")
    {
      Placement("personality.default.barracks");
      Types()
      {
        Add("army.building.barracks1",2);
      }
      NoPrereqStall(1);
    }
  }

  CreateBase::Orderer("personality.default.barracks2")
  {
    Manifest("BaseLevel")
    {
      Placement("personality.default.buildings");
      Types()
      {
        Add("army.building.barracks2");
      }
    }
  }

  // Garage
  CreateBase::Orderer("personality.default.garage1")
  {
    Manifest("BaseLevel")
    {
      Placement("personality.default.garage");
      Types()
      {
        Add("army.building.garage1");
      }
    }
  }

  CreateBase::Orderer("personality.default.garage2")
  {
    Manifest("BaseLevel")
    {
      Placement("personality.default.buildings");
      Types()
      {
        Add("army.building.garage2");
      }
    }
  }

  // Resource depot
  CreateBase::Orderer("personality.default.resourcedepot.permanent")
  {
    Manifest("Resource")
    {
      Placement("personality.default.buildings");
      Types()
      {
        Add("army.building.resourcedepot");
      }
      FirstResource(0);
      LastResource(0);
    }
  }

  // Resource depot
  CreateBase::Orderer("personality.default.resourcedepot.roaming")
  {
    Manifest("Resource")
    {
      Placement("personality.default.buildings");
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
  CreateBase::Orderer("personality.default.guardtower.front")
  {
    Manifest("OrdererLevel")
    {
      Placement("personality.default.defenses.front");
      Types()
      {
        Add("army.building.guardtower");
      }
    }
  }

  CreateBase::Orderer("personality.default.guardtower.left")
  {
    Manifest("OrdererLevel")
    {
      Placement("personality.default.defenses.left");
      Types()
      {
        Add("army.building.guardtower");
      }
    }
  }

  CreateBase::Orderer("personality.default.guardtower.right")
  {
    Manifest("OrdererLevel")
    {
      Placement("personality.default.defenses.right");
      Types()
      {
        Add("army.building.guardtower");
      }
    }
  }

  // Pill boxes
  CreateBase::Orderer("personality.default.pillbox.front")
  {
    Manifest("OrdererLevel")
    {
      Placement("personality.default.defenses.front");
      Types()
      {
        Add("army.building.pillbox");
      }
    }
  }

  CreateBase::Orderer("personality.default.pillbox.left")
  {
    Manifest("OrdererLevel")
    {
      Placement("personality.default.defenses.left");
      Types()
      {
        Add("army.building.pillbox");
      }
    }
  }

  CreateBase::Orderer("personality.default.pillbox.right")
  {
    Manifest("OrdererLevel")
    {
      Placement("personality.default.defenses.right");
      Types()
      {
        Add("army.building.pillbox");
      }
    }
  }

  // Anti-Air Guns
  CreateBase::Orderer("personality.default.aagun.front")
  {
    Manifest("OrdererLevel")
    {
      Placement("personality.default.defenses.front");
      Types()
      {
        Add("army.building.aagun");
      }
    }
  }

  CreateBase::Orderer("personality.default.aagun.left")
  {
    Manifest("OrdererLevel")
    {
      Placement("personality.default.defenses.left");
      Types()
      {
        Add("army.building.aagun");
      }
    }
  }

  CreateBase::Orderer("personality.default.aagun.right")
  {
    Manifest("OrdererLevel")
    {
      Placement("personality.default.defenses.right");
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
  CreateBase::Orderer("personality.default.bulldozer")
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
  CreateBase::Orderer("personality.default.dumptruck")
  {
    Manifest("Level")
    {
      Types()
      {
        Add("army.unit.dumptruck", 3);
      }
    }
  }

  // Offense infantry
  CreateBase::Orderer("personality.default.offense.infantry")
  {
    Manifest("Level")
    {
      Script("offense.land");
      Types()
      {
        Add("army.unit.grunt", 4);
        Add("army.unit.grenadier", 4);
      }
      CanBuild(1);
      Random(1);
      //NoBeyondWeighting(1);
    }
  }

  // Offense infantry
  CreateBase::Orderer("personality.default.offense.advinfantry")
  {
    Manifest("Level")
    {
      Script("offense.advland");
      Types()
      {
        Add("army.unit.machinegunner", 4);
        Add("army.unit.sniper", 2);
        Add("army.unit.mortar", 3);
        Add("army.unit.bazooka", 4);
      }
      CanBuild(1);
      Random(1);
      //NoBeyondWeighting(1);
    }
  }


  // Offense vehicles
  CreateBase::Orderer("personality.default.offense.vehicles")
  {
    Manifest("Level")
    {
      Script("offense.vehicles");
      Types()
      {
        Add("army.unit.halftrack", 3);
        Add("army.unit.tank", 2);
        //Add("army.unit.medicjeep", 2);
        Add("army.unit.dumdum",2);

      }
      CanBuild(1);
      Random(1);
      //NoBeyondWeighting(1);
    }
  }

   // Offense air
  CreateBase::Orderer("personality.default.offense.air")
  {
    Manifest("Level")
    {
      Script("offense.air");
      Types()
      {
        Add("army.unit.chopper",3);
      }
      CanBuild(1);
      Random(1);
    }
  }

  // Defense infantry
  CreateBase::Orderer("personality.default.defense.infantry")
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
  CreateBase::Orderer("personality.default.defense.vehicles")
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
  CreateBase::Orderer("personality.default.baserepair")
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
  CreatePlacement("personality.default.buildings")
  {
    Rule("Distance", 1.0)
    {
      Distance(0);
    }
  }

  // Barracks
  CreatePlacement("personality.default.barracks")
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
  CreatePlacement("personality.default.garage")
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
  CreatePlacement("personality.default.defenses.front")
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

  CreatePlacement("personality.default.defenses.left")
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

  CreatePlacement("personality.default.defenses.right")
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
  CreateScript("personality.default.offense.land")
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
  CreateScript("personality.default.offense.advland")
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
  CreateScript("personality.default.offense.vehicles")
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



  // Air offense script
  CreateScript("personality.default.offense.air")
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
  CreateScript("personality.default.defense.land")
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
    mod.cfg8   ?      personality_default_bases.cfg?  d	      *personality_default_orderers_buildings.cfg<  ?      &personality_default_orderers_units.cfg
"  ?      !personality_default_placement.cfg?-        personality_default_scripts.cfg?2  5S  