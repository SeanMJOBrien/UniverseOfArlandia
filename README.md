# UniverseOfArlandia
The Module:

Universe of Arlandia is a module of randomly generated worlds, which can be travelled
between using spaceships (Spelljammer turn based combat not yet integreted). Players can
build seaships, airships, and spaceships for travel. Not that the worlds aren't always
(random, remember) large enough to have oceans or seas, so the worlds need to be larger,
and maybe take into account how much is ocean. To do this the MySQL storage of the world
needs to be rewritten.
The module is designed for a variety of levels, but is fairly generic in the way spawns
are handled. This can easily be spiced up by adding new creatures and conditions.
I'd like to add more mission types. Currently they are fetch, gather, or kill in the 
most direct and bland way. "Find me 5 iron ingots and bring them to x, y coordinates for
a reward."The server restarts every 8 realtime hours, and on start it generates these
missions in random locations. There is no reason not to create all kinds of single or
multi-area quests that have a variety of subjects and types.
Currently these missions are also only good while the srever runs, and are reset on
server restart every 8 realtime hours. More complex quests could carry over, or a whole
campaign could be tracked in the DB.
I'm hoping to add to the DM tools to allow the DM to craft the world more easily. There
are features for the DM to do some of this, but I do not fully understand them or how
they are used.

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

