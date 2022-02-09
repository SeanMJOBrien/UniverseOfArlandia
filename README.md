You can email me at qlippoth@speakeasy.net

# UniverseOfArlandia
The Module: (Universe of Arlandia by TheRack)
Check out the currently live website at http://qlippoth.dyndns.org
(click right sidebar for maps of other worlds (which I haven't explored yet, so might not be much to see)
- Web map of explored areas of one world: http://qlippoth.dyndns.org/galaxy.php?planet=Arland
- Hak files required for Linux server (ALL lowercase! You can also use these for the client side):
     http://142.47.99.185/uoa/UOAlowercaseHaks4Linux.7z

THIS IS NOW STATIC! - old website: http://142.47.88.45/

A more stable server is running as Universe of Arlandia.
You'll need the haks first, and the password to play is "us".

In 2011 TheRack had abandoned this module and bequeathed to me (he's alive, I assume,
the server died frmo lack of players) his module and said to do as I please with it. He
was moving on to a more fantasy based endeavor. I have simply updated it for NWNXEE.

Universe of Arlandia is a module of randomly generated worlds, which can be travelled
between using spaceships (Spelljammer turn based combat not yet integreted). Players can
build seaships, airships, and spaceships for travel. Not that the worlds aren't always
(random, remember) large enough to have oceans or seas, so the worlds need to be larger,
and maybe take into account how much is ocean. To do this the MySQL storage of the world
needs to be rewritten.

The module is designed for a variety of levels, but is fairly generic in the way spawns
are handled. This can easily be spiced up by adding new creatures and conditions. Now
they are simply a homogenous group of varying levels of the same monster type.

I'd like to add more mission types. Currently they are fetch, gather, or kill in the 
most direct and bland way. "Find me 5 iron ingots and bring them to x, y coordinates for
a reward."The server restarts every 8 realtime hours, and on start it generates these
missions in random locations. There is no reason not to create all kinds of single or
multi-area quests that have a variety of subjects and types.

Currently these missions are also only good while the server runs, and are reset on
server restart every 8 realtime hours. More complex quests could carry over, or a whole
campaign could be tracked in the DB.

I'm hoping to add to the DM tools to allow the DM to craft the world more easily. There
are features for the DM to do some of this, but I do not fully understand them or how
they are used.

Issues:
- Placeables are used for arriving Airships and Spaceships. They can be more varried (as
well as the above and below deck areas for commercial travel), and perhaps be made static
with NWNXEE, though there appears to be limitations as to removing them when they leave.
- Ships of all types are limited to the owner PC. Party PCs should be made cutscene 
invisible and forced to follow the "ship" (polymorphed PC). OR, failing that, an area
above and/or bellow decks where they can wait and RP (this is done for commercial travel).
Party speach can be used between the owner and the rest of the party for this purpose in
both cases.
- NWNEE offers copyArea(), which should be used to copy temlate areas. Currently there are
simply 7 forest "template" areas that are used over and over, and once you need an 8th for
another PC they are stuck until one is vacated. This looks like it would be fairly simple
(for someone more skilled).
- Troops. Henchmen are available at Taverns, they are static 3rd lebel fighters. When you
return to the server they appear again, same as the day you hired them. TROOPS on the other
hand can be equipped as you please and can be trained (you must build a Barracks in your
own Domain (area for which you clear and purchase a deed) at several levels.
The issue is that some options break the storage in the DB, confusing players. I think
this is a simple logic issue, as if you do not use advanced features, like commanding one
to wait here or guard this area everything works fine.
Frankly my current thoughts are to remove them in their current form and make more varied
versions. As well, have more content in which they are not needed due to allied NPCs.

The Gist:

This is a persistent world module for Neverwinter Nights 1. It does need a NWNXEE
server and MySQL service. MySQL is used to run the world altogether, and isn't optional.
I've done my best to work out all of the kinks, moving it from the old NWNX to NWNXEE.
I plan to do more in the future, but my time is very limited, and my skills even moreso.

Apache is not required, but the web map and some other info is only available through
Apache and PHP 7.

The original author (Entirely by TheRack) released it to me years ago to do wiht as
I please, and it has been a fun learning exercise, but real life (Covid) and work leave
me no time to fool around with it any longer.

The project has the files and scripts to build the module. Start a new module, open
the temp0 folder in modules, and copy the files fomr the repo/src into temp0 and do a
full build (all check boxes).

The Hak files will be linked in this readme soon. Most can be downloaded from the
NeverwinterVault.org community website, but I will include links from my own server
to be sure they are available and easy to find.

The website will also be included, this offers a realtime map of the explored areas
of each world as well as crafting info.
