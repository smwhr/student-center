INCLUDE includes/functions.ink

LIST Items = Sunglasses, PieceOfBuilding, Ball
VAR Inventory = ()

LIST Knowledges = Goose, Wet, NoSuzy, NiceStudents, DogFollow

* – Come on we're late !
    -> bus

=== bus
Suzy is your best friend from high school. She gestures outside of the bus towards the student center and a group of first year students just like you, that are waiting for the welcoming tour. #didascalie

* – Just a sec, let me check my seat
    You sunglasses fell on the floor. #didascalie
    -> pick_up(Sunglasses) -> 
    – You took your time!
    * * – Yeah but at least I have style!
        – Sure. But 
    * * – Prefer I get a headache?
        – No but 
    - - -> bus_late
* – Take the lead, I'm behind you! 
    -> join_group
* – Is this tour, like, mandatory?
    – No, but what do you want to do instead? Lose yourself? I know your sense of direction. Come 
    -> bus_late
    
= bus_late
<> now, hurry please.
-> join_group

= join_group

-  You rush toward the group that's already moving slowly west. #didascalie
{bus_late: 
    <> In the distance you indistinctly hear the guide say something about a goose. #didascalie
 - else: 
    You join them just as the guide is ending its sentence : #didascalie
    – ... and beware of the Robot Goose, if you cross its path, the safe word is "Oink Plok"
    ~ Knowledges += Goose
}

-> admin_building

=== admin_building
You reach the Admin building. It was designed by a famous architect (but not so famous that you've heard her name before). As such, it is pretty visually undescriptible except for the fact it makes you salivate. #didascalie

*(suzy) – (to Suzy) That lady had a thing for food!
*(guide) – (to guide) Excuse me, is this building edible?
*(internal) – (internally) I am hungry now...

- 
{suzy: You probably did not want to say that as loud as you did and}
{guide: The guide looks at you, winks and while}
 <> the group of other students laugh heartily at your incongruous comment
{guide: 
    <> he tears a piece of wall and gives it to you. Who's laughing now?
    -> pick_up(PieceOfBuilding) -> 
    -> tasting_session ->
    -else: <>.
} #didascalie


- The guide resumes the tour. #didascalie
– This building was entirely conceived in the Science Lab we will visit in a short while. <> 
{guide: I wanted to keep the surprise of its special nature but our friend spoiled it for us! | Take a good look at it, it's not what it looks like, you're in for a surprise!}

-> admin_building_wait

=== admin_building_wait
The students disperse to look around the Admin building. Some sit on the grass along the pond nearby. Suzy gets closer. #didascalie

– I really need to go to the bathroom
* – Ok, I'll wait for you here 
    – You better
    Suzy leaves you alone.
        -> sociabilize
* – Are you asking me to hold the door?
  – Why do you make it sound like we're in high school? But yes please.
  * * – Ok let's go
    -> admin_building_bathroom
  * * – I'd reather stay here.
    -> sociabilize
* – Can't you go behing a bush ? 
    – You're kidding me ? And why not right here in front of everyone else?
    * * – I did not think of [that] it but now that you suggest it...
        Suzy, angry, leaves without a word. #didascalie
            -> sociabilize
    * * – Sorry[], that was a dumb idea, need help?
        – Yes please.
            -> admin_building_bathroom

-
-> DONE

=== admin_building_bathroom
You enter the building behind Suzy. She runs in the tangled corridors. You'll never be able to backtrace the path to the door. She enters a stall. #didascalie
– Did you notice?

* – Notice what? [] You were running the whole time
* – That this building is a maze?
* – How long are we staying inside?

-
– We saw no one. And those posters warning about the Robotic Goose.

* – Can we go now, we will lose the group!
– Yup, I'm done. Let's go.
-> science_labs


=== sociabilize

{admin_building.suzy or admin_building.guide: 
    People found you funny earlier so they approach you. #didascalie
    {Knowledges hasnt Goose: 
        You learn about the inactivation code for the Goose: "Oink Plok" #didascalie
        ~ Knowledges += Goose
    - else: 
        They seem to really like you. #didascalie
        Students will be helpful in the future. # infotext
        ~ Knowledges += NiceStudents
    }
    - else : People are discussing and each time you try to speak to a group they ignore you. #didascalie
}
-> group_leaves

= group_leaves
Group leaves.
* [Follow them]
    Suzy will find her way. She always does. You follow the group along the path around the pond. #didascalie
    ~ Knowledges += NoSuzy
    -> hit_by_ball ->
* [Wait for Suzy]
    You wait a few more minutes for Suzy. #didascalie

-
-> science_labs

-> DONE

=== hit_by_ball
{hit_by_ball > 1: ->->}
The path takes a sharp edge and as you turn, <>

{Inventory ^ Sunglasses : 
    the sun suddenly emerges from behind a tall tree. Thanks to your sunglasses, you're able to catch a ball zooming towards you at high speed. #didascalie
    -> pick_up(Ball)->
- else: 
    you're at the same time blinded by the sun and hit by something you didn't see coming your way. You lose your balance and fall into the pond. #didascalie
    ~ Knowledges += Wet
    You are now soaking wet #infotext
 }
 
 {Knowledges has NiceStudents and Knowledges has Wet:
    A student nearby saw you fall in the water and rushes to give you a towel. #didascalie
    ~ Knowledges -= Wet
    You are now dry #infotext
 }
 ->->

=== science_labs
You catch up with the group in front of the Science Labs. # didascalie
You guide is  {admin_building.guide: explaining something you already know | revealing the secret promised earlier} : #didascalie
– This is where we created the first edible building in the world, our very own Admin Building!

{Inventory hasnt PieceOfBuilding:
Everyone already has a piece of it, but as you were the last here, he hands you one now. #didascalie
-> pick_up(PieceOfBuilding) ->
    - else:
    – Our friend already has one here
}
-> tasting_session ->

– Our tour is now done for today. You can roam freely. If you need me, I'll be next to the Admin Building if you want to taste a piece of it.
{Knowledges has NoSuzy:
    Suzy joins you back at that very moment. #didascalie
    – Did I miss anything?
}
-

-> end_of_tour

=== tasting_session
{tasting_session > 1:
    ->->
}
The guide looks at you intently. #didascalie
– Taste it!
* – Ok, let's give it a try
    -> taste
* – Hmm maybe later
    – Afraid to eat it?
    * * – I am not that hungry, maybe later
        -> decline
    * * – If you insist...
        -> taste
    * * {Knowledges hasnt NoSuzy} – Suzy, wanna try?
        -> suzy

= taste
->drop(PieceOfBuilding, "take a bite of") ->
– How do you like it ? asks the guide
* – It reminds me of Christmas
  – Indeed, it's made to taste like goose!
* – Taste like chicken 
  – Goose actually.
-
    -> done
= decline
Everyone look a little sad that you did not try. #didascalie
    -> done
= suzy
->drop(PieceOfBuilding, "give") ->
    She takes a bite. #didascalie
    – Not bad! Taste like chicken...
    – Goose, actually! corrects the guide.
    -> done
= done
-
->->


=== end_of_tour
-> free_science_labs


=== dog
{Knowledges has DogFollow:
    {~Behind you|Still following you|While you look around}, the dog {~licks its paws|chases its tail|sits calmy|raises its ear|scratches its back|licks its belly}. #didascalie
}
->->

=== free_science_labs
You are near the science labs. #didascalie
-> dog ->

{Knowledges has DogFollow: -> goose_release}
Nothing to do here. #infotext
+ Get back to the entrance
    -> free_hub

=== free_hub
You are in front of the Student Center. The place looks under heavy construction. #didascalie.
The bus you took to came here departed a long time ago. #didascalie

-> dog ->

+ [Reach the science labs]
    You walk east to the cluster of science labs. #didascalie
    -> free_science_labs
+ [Reach the parking lot]
    You follow a trail through a narrow strip of trees and shrubs that leads north to a parking lot. #didascalie
    -> free_parking
+ [Reach the Admin Building]
    You follow a path that winds, east, around a pond to the Admin Building. #didascalie
    -> free_admin_building
-> DONE


=== free_admin_building
-> hit_by_ball ->
{Inventory hasnt Ball: 
    You see a ball on the path. #didascalie
    -> pick_up(Ball)->
}
The guide is waiting here.
-> dog ->
-(opts)
+{Inventory hasnt PieceOfBuilding} [Ask the guide another piece of building]
    – Can I get another piece of building?
    The guide tears a chunk of the building and hands it to you. #didascalie
    – Sure, here is some more.
    * * – Are you sure[?] it won't impact the integrity of the building?
        – Don't worry, it'll grow back.
    * * ->
    - -
    -> pick_up(PieceOfBuilding) -> opts
+ [Get back to the entrance]
    -> free_hub


=== free_parking
The parking lot is empty of cars. #didascalie
-> dog ->
{Knowledges hasnt DogFollow: 
    A dog is here. #didascalie
}
-(opts)
+{Inventory has PieceOfBuilding and Knowledges hasnt DogFollow} [Give some building to the dog]
    – Come here little doggy, do you want some good food?
    -> drop(PieceOfBuilding, "throw") ->
    You give him the little piece of edible building. He looks really happy. #didascalie
    The dog is now following you everywhere. #infotext
    ~ Knowledges += DogFollow
    -> opts
+ [Get back to the entrance]
    -> free_hub
    
-
-> DONE

=== goose_release
The presence of the dog seems to have activated some kind of security device. A small door opens on the side of the building. And {Knowledges has Goose: the|a} Robotic Goose comes chasing you.

+ {Knowledges has Goose} – "Couac Poink"
    -> goose_release_wrong
+ {Knowledges has Goose} – "Oink Plok"
    -> goose_release_win
+ – Run !
    -> goose_release_tie
+ {CHOICE_COUNT() < 3 and Inventory has Ball}[Toss the ball]
    -> drop(Ball, "toss") ->
    -> goose_release_wrong


=== goose_release_win
The Robotic Goose instantly shuts down. #didascalie
You win (Ending 1 out of 8) # infotext
-> DONE

=== goose_release_wrong
The Robotic Goose does not like that and shoots lasers at your eyes.
{Inventory has Sunglasses: 
    <> But your sunglasses stops the deathly ray and buys you a few more seconds that allow you to flea. #didascalie
    -> goose_release_tie
 - else:
 You are instantly blinded, you stumble, hit your head and lose consciousness. At least you did not suffer. # didascalie
 You lose (Ending 2 out of 8) # infotext
}
-> DONE

=== goose_release_tie
{Knowledges has NiceStudents:
    As you run for your life, students all around come to your help. Sensing that it is outnumbered the Robotic Goose gets backs to its den. #didascalie
    You win (Ending 3 out of 8) # infotext
    -> DONE
}
The Robotic Goose is faster than you. It tackles you and Suzy to the ground and starts smelling you.
{Inventory has PieceOfBuilding:
    Unfortunately, the edible piece of building you have in your pocket smells exactly like if you commited goose-murder. The Robotic Goose gets really angry and eats you alive as revenge. #didascalie
    You lose (Ending 4 out of 8) # infotext
}
{tasting_session.suzy:
    Suzy lets out a cry of surprise. #didascalie
    – What the hell ?!
    The Robotic Goose instantly smells her breath. A breath that betrays she had some goose earlier. It jumps on her and eats her alive. You manage to escape. #didascalie
    You win (or did you really ?) (Ending 5 out of 8) # infotext
    -> DONE
}
{tasting_session.taste:
    * – What the hell ?!
    The Robotic Goose instantly smells your breath. A breath that betrays you has some goose earlier. It jumps on you and eats you alive. Suzy manages to escape. #didascalie
    You lose (Ending 6 out of 8) # infotext
    -> DONE
}
{Inventory has Ball:
    The Robotic Goose finds a ball in your pocket. The ball distracts it long enough for you to run away. #didascalie
    You win (Ending 7 out of 8) # infotext
    -> DONE
}
The Robotic Goose sees nothing wrong with you. But its attention is drawn to the dog. Is this goose that it smells on its breath ? You don't stay long enough to see the end of the fight between them as you run away from the danger. #didascalie
    You win (or did you really ?) (Ending 8 out of 8) # infotext

-> DONE

