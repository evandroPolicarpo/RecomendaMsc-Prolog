% musica(Id, Titulo, Artista, Album, Genero)
% genero_similar(genero, genero_semelhante)
:- module(musicas_db, [musica/5, genero_similar/2]).

% --- Rock clássico ---
musica(bohemian_rhapsody,   'Bohemian Rhapsody',       'Queen',             'A Night at the Opera',        rock).
musica(hotel_california,    'Hotel California',         'Eagles',            'Hotel California',            rock).
musica(stairway_to_heaven,  'Stairway to Heaven',       'Led Zeppelin',      'Led Zeppelin IV',             rock).
musica(comfortably_numb,    'Comfortably Numb',         'Pink Floyd',        'The Wall',                    rock).
musica(wish_you_were_here,  'Wish You Were Here',       'Pink Floyd',        'Wish You Were Here',          rock).

% --- Hard rock ---
musica(back_in_black,       'Back in Black',            'AC/DC',             'Back in Black',               hard_rock).
musica(november_rain,       'November Rain',            "Guns N' Roses",     'Use Your Illusion I',         hard_rock).

% --- Metal ---
musica(enter_sandman,       'Enter Sandman',            'Metallica',         'Metallica',                   metal).
musica(master_of_puppets,   'Master of Puppets',        'Metallica',         'Master of Puppets',           metal).
musica(paranoid,            'Paranoid',                 'Black Sabbath',     'Paranoid',                    metal).

% --- Grunge ---
musica(teen_spirit,         'Smells Like Teen Spirit',  'Nirvana',           'Nevermind',                   grunge).
musica(black_pj,            'Black',                    'Pearl Jam',         'Ten',                         grunge).

% --- Alternative ---
musica(creep,               'Creep',                    'Radiohead',         'Pablo Honey',                 alternative).
musica(losing_my_religion,  'Losing My Religion',       'R.E.M.',            'Out of Time',                 alternative).
musica(one_u2,              'One',                      'U2',                'Achtung Baby',                alternative).

% --- Pop ---
musica(thriller,            'Thriller',                 'Michael Jackson',   'Thriller',                    pop).
musica(purple_rain,         'Purple Rain',              'Prince',            'Purple Rain',                 pop).
musica(take_on_me,          'Take On Me',               'a-ha',              'Hunting High and Low',        pop).
musica(like_a_prayer,       'Like a Prayer',            'Madonna',           'Like a Prayer',               pop).

% --- Soul ---
musica(superstition,        'Superstition',             'Stevie Wonder',     'Talking Book',                soul).
musica(respect,             'Respect',                  'Aretha Franklin',   'I Never Loved a Man',         soul).
musica(whats_going_on,      "What's Going On",          'Marvin Gaye',       "What's Going On",             soul).

% --- R&B ---
musica(will_always_love,    'I Will Always Love You',   'Whitney Houston',   'The Bodyguard',               rnb).
musica(no_scrubs,           'No Scrubs',                'TLC',               'FanMail',                     rnb).
musica(say_my_name,         'Say My Name',              "Destiny's Child",   "The Writing's on the Wall",   rnb).

% --- Hip-hop ---
musica(g_thang,             "Nuthin' But a G Thang",    'Dr. Dre',           'The Chronic',                 hip_hop).
musica(cream,               'C.R.E.A.M.',               'Wu-Tang Clan',      'Enter the Wu-Tang',           hip_hop).
musica(alright,             'Alright',                  'Kendrick Lamar',    'To Pimp a Butterfly',         hip_hop).
musica(humble,              'HUMBLE.',                  'Kendrick Lamar',    'DAMN.',                       hip_hop).
musica(gods_plan,           "God's Plan",               'Drake',             'Scorpion',                    hip_hop).

% --- Eletrônica ---
musica(blue_da_ba_dee,      'Blue (Da Ba Dee)',          'Eiffel 65',         'Europop',                     electronic).
musica(one_more_time,       'One More Time',             'Daft Punk',         'Discovery',                   electronic).
musica(levels,              'Levels',                   'Avicii',            'True',                        electronic).
musica(strobe,              'Strobe',                   'deadmau5',          '4x4=12',                      electronic).
musica(around_the_world,    'Around the World',          'Daft Punk',         'Homework',                    electronic).

% --- Soft rock ---
musica(dreams,              'Dreams',                   'Fleetwood Mac',     'Rumours',                     soft_rock).
musica(africa,              'Africa',                   'Toto',              'Toto IV',                     soft_rock).
musica(every_breath,        'Every Breath You Take',    'The Police',        'Synchronicity',               soft_rock).

% --- Folk ---
musica(fast_car,            'Fast Car',                 'Tracy Chapman',     'Tracy Chapman',               folk).
musica(sound_of_silence,    'The Sound of Silence',     'Simon & Garfunkel', 'Wednesday Morning',           folk).

% Afinidades
genero_similar(rock,        hard_rock).
genero_similar(rock,        soft_rock).
genero_similar(rock,        grunge).
genero_similar(rock,        alternative).
genero_similar(hard_rock,   metal).
genero_similar(grunge,      alternative).
genero_similar(soul,        rnb).
genero_similar(soul,        hip_hop).
genero_similar(rnb,         hip_hop).
genero_similar(rnb,         pop).
genero_similar(pop,         electronic).
genero_similar(folk,        soft_rock).
genero_similar(folk,        alternative).