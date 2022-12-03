CREATE TABLE track
(
    tck_id     integer
        constraint track_pk
            primary key,
    tck_name   text not null,
    tck_artist text not null
);

CREATE TABLE "effect"
(
    eff_id     integer
        constraint effect_pk
            primary key,
    eff_name   text not null,
    eff_param1 text not null,
    eff_param2 text not null,
    eff_param3 text not null
);

CREATE UNIQUE INDEX effect_name_uindex
    on effect (eff_name);

create table setting
(
    set_id     integer
        constraint setting_pk
            primary key,
    set_gain   real    not null,
    set_volume   real    not null,
    set_voice   text    not null,
    set_bass   real    not null,
    set_middle real    not null,
    set_treble real    not null,
    set_param1 real    not null,
    set_param2 real    not null,
    set_param3 real    not null,
    set_effect integer not null
        references effect
            on delete cascade,
    set_track  integer not null
        references track
            on delete cascade
);


