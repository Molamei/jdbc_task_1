PGDMP          :                {           postgres    15.4    15.4                0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                       1262    5    postgres    DATABASE     �   CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United Kingdom.1252';
    DROP DATABASE postgres;
                postgres    false                       0    0    DATABASE postgres    COMMENT     N   COMMENT ON DATABASE postgres IS 'default administrative connection database';
                   postgres    false    3348                        3079    16384 	   adminpack 	   EXTENSION     A   CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;
    DROP EXTENSION adminpack;
                   false                       0    0    EXTENSION adminpack    COMMENT     M   COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';
                        false    2            �            1259    16452    players    TABLE     �   CREATE TABLE public.players (
    player_id integer NOT NULL,
    team_id integer,
    name character varying,
    "position" character varying
);
    DROP TABLE public.players;
       public         heap    postgres    false            �            1259    16451    Players_player_id_seq    SEQUENCE     �   CREATE SEQUENCE public."Players_player_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public."Players_player_id_seq";
       public          postgres    false    220                       0    0    Players_player_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public."Players_player_id_seq" OWNED BY public.players.player_id;
          public          postgres    false    219            �            1259    16399    leagues    TABLE     \   CREATE TABLE public.leagues (
    league_id integer NOT NULL,
    name character varying
);
    DROP TABLE public.leagues;
       public         heap    postgres    false            �            1259    16398    leagues_league_id_seq    SEQUENCE     �   CREATE SEQUENCE public.leagues_league_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.leagues_league_id_seq;
       public          postgres    false    216                       0    0    leagues_league_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.leagues_league_id_seq OWNED BY public.leagues.league_id;
          public          postgres    false    215            �            1259    16408    teams    TABLE     x   CREATE TABLE public.teams (
    league_id integer NOT NULL,
    team_id integer NOT NULL,
    name character varying
);
    DROP TABLE public.teams;
       public         heap    postgres    false            �            1259    16444    teams_team_id_seq    SEQUENCE     �   CREATE SEQUENCE public.teams_team_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.teams_team_id_seq;
       public          postgres    false    217                       0    0    teams_team_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.teams_team_id_seq OWNED BY public.teams.team_id;
          public          postgres    false    218            p           2604    16402    leagues league_id    DEFAULT     v   ALTER TABLE ONLY public.leagues ALTER COLUMN league_id SET DEFAULT nextval('public.leagues_league_id_seq'::regclass);
 @   ALTER TABLE public.leagues ALTER COLUMN league_id DROP DEFAULT;
       public          postgres    false    216    215    216            r           2604    16455    players player_id    DEFAULT     x   ALTER TABLE ONLY public.players ALTER COLUMN player_id SET DEFAULT nextval('public."Players_player_id_seq"'::regclass);
 @   ALTER TABLE public.players ALTER COLUMN player_id DROP DEFAULT;
       public          postgres    false    220    219    220            q           2604    16445    teams team_id    DEFAULT     n   ALTER TABLE ONLY public.teams ALTER COLUMN team_id SET DEFAULT nextval('public.teams_team_id_seq'::regclass);
 <   ALTER TABLE public.teams ALTER COLUMN team_id DROP DEFAULT;
       public          postgres    false    218    217            
          0    16399    leagues 
   TABLE DATA           2   COPY public.leagues (league_id, name) FROM stdin;
    public          postgres    false    216   �                 0    16452    players 
   TABLE DATA           G   COPY public.players (player_id, team_id, name, "position") FROM stdin;
    public          postgres    false    220   �                 0    16408    teams 
   TABLE DATA           9   COPY public.teams (league_id, team_id, name) FROM stdin;
    public          postgres    false    217   D                  0    0    Players_player_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public."Players_player_id_seq"', 17, true);
          public          postgres    false    219                       0    0    leagues_league_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.leagues_league_id_seq', 3, true);
          public          postgres    false    215                       0    0    teams_team_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.teams_team_id_seq', 6, true);
          public          postgres    false    218            x           2606    16459    players Players_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY public.players
    ADD CONSTRAINT "Players_pkey" PRIMARY KEY (player_id);
 @   ALTER TABLE ONLY public.players DROP CONSTRAINT "Players_pkey";
       public            postgres    false    220            t           2606    16406    leagues leagues_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.leagues
    ADD CONSTRAINT leagues_pkey PRIMARY KEY (league_id);
 >   ALTER TABLE ONLY public.leagues DROP CONSTRAINT leagues_pkey;
       public            postgres    false    216            v           2606    16450    teams team_id 
   CONSTRAINT     P   ALTER TABLE ONLY public.teams
    ADD CONSTRAINT team_id PRIMARY KEY (team_id);
 7   ALTER TABLE ONLY public.teams DROP CONSTRAINT team_id;
       public            postgres    false    217            y           2606    16412    teams league_id    FK CONSTRAINT     y   ALTER TABLE ONLY public.teams
    ADD CONSTRAINT league_id FOREIGN KEY (league_id) REFERENCES public.leagues(league_id);
 9   ALTER TABLE ONLY public.teams DROP CONSTRAINT league_id;
       public          postgres    false    216    217    3188            z           2606    16460    players team_id    FK CONSTRAINT     s   ALTER TABLE ONLY public.players
    ADD CONSTRAINT team_id FOREIGN KEY (team_id) REFERENCES public.teams(team_id);
 9   ALTER TABLE ONLY public.players DROP CONSTRAINT team_id;
       public          postgres    false    3190    217    220            
      x�3�(J��L-R�IML/M����� O$4         U   x�3�4�t.�,.�L��W��K�I����2J��V�&�x����������)
��9� Q#��Of~^j��ojqq&H,F��� CV1         )   x�3�4���,K-*����2�4�tJ,JN���K����� �n�     