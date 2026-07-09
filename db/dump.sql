--
-- PostgreSQL database dump
--

\restrict LFjJU5QZZO4Kg1YA31o0GYbbeOuWuuhiuVgUWPEUpzWtAG0obsZXQi9N7dIaxvb

-- Dumped from database version 18.4 (Debian 18.4-1.pgdg13+1)
-- Dumped by pg_dump version 18.4 (Debian 18.4-1.pgdg13+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: answers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.answers (
    id bigint NOT NULL,
    body text,
    consult_id integer NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.answers OWNER TO postgres;

--
-- Name: answers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.answers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.answers_id_seq OWNER TO postgres;

--
-- Name: answers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.answers_id_seq OWNED BY public.answers.id;


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.ar_internal_metadata OWNER TO postgres;

--
-- Name: availabilities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.availabilities (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    day_of_week integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    start_time time without time zone,
    end_time time without time zone,
    start_minute integer,
    end_minute integer,
    off boolean DEFAULT false NOT NULL
);


ALTER TABLE public.availabilities OWNER TO postgres;

--
-- Name: availabilities_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.availabilities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.availabilities_id_seq OWNER TO postgres;

--
-- Name: availabilities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.availabilities_id_seq OWNED BY public.availabilities.id;


--
-- Name: consult_assignments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.consult_assignments (
    id bigint NOT NULL,
    consult_id bigint NOT NULL,
    user_id bigint NOT NULL,
    assigned_at timestamp(6) without time zone NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.consult_assignments OWNER TO postgres;

--
-- Name: consult_assignments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.consult_assignments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.consult_assignments_id_seq OWNER TO postgres;

--
-- Name: consult_assignments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.consult_assignments_id_seq OWNED BY public.consult_assignments.id;


--
-- Name: consults; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.consults (
    id bigint NOT NULL,
    title character varying,
    body text,
    asked_by_id integer NOT NULL,
    assigned_to_id integer,
    consult_status integer,
    assigned_at timestamp(6) without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    consult_type character varying DEFAULT 'standard'::character varying NOT NULL,
    read_at timestamp(6) without time zone
);


ALTER TABLE public.consults OWNER TO postgres;

--
-- Name: consults_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.consults_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.consults_id_seq OWNER TO postgres;

--
-- Name: consults_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.consults_id_seq OWNED BY public.consults.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp(6) without time zone,
    remember_created_at timestamp(6) without time zone,
    name character varying,
    user_role character varying DEFAULT 'user'::character varying,
    daily_consult_limit integer,
    cooldown_minutes integer,
    available_start_time time without time zone,
    available_end_time time without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    time_zone character varying,
    can_accept_fbx_neo boolean DEFAULT false NOT NULL,
    can_receive_consults boolean DEFAULT false
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: answers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.answers ALTER COLUMN id SET DEFAULT nextval('public.answers_id_seq'::regclass);


--
-- Name: availabilities id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.availabilities ALTER COLUMN id SET DEFAULT nextval('public.availabilities_id_seq'::regclass);


--
-- Name: consult_assignments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.consult_assignments ALTER COLUMN id SET DEFAULT nextval('public.consult_assignments_id_seq'::regclass);


--
-- Name: consults id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.consults ALTER COLUMN id SET DEFAULT nextval('public.consults_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: answers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.answers (id, body, consult_id, user_id, created_at, updated_at) FROM stdin;
3	this is the answer	7	2	2025-10-03 21:11:44.0383	2025-10-03 21:11:44.0383
5	done	12	4	2025-10-10 00:40:29.125932	2025-10-10 00:40:29.125932
6	Im herre yes! Thanks, \r\n	13	2	2025-10-15 19:00:01.344613	2025-10-15 19:00:01.344613
7	yellow	17	2	2025-12-03 19:57:06.400082	2025-12-03 19:57:06.400082
8	reply here ! 	19	2	2025-12-09 22:33:37.783369	2025-12-09 22:33:37.783369
9	yerp! 	20	1	2025-12-11 22:49:28.261381	2025-12-11 22:49:28.261381
10	DONE!	23	1	2025-12-17 01:59:42.846844	2025-12-17 01:59:42.846844
11	           I'm baby franzen celiac direct trade, thundercats adaptogen seitan chartreuse banjo retro. Kombucha stumptown marfa cliche palo santo green juice. YOLO master cleanse glossier poutine intelligentsia single-origin coffee. +1 lo-fi vice, scenester neutra ugh cold-pressed irony wayfarers live-edge shaman quinoa. Normcore scenester mixtape af DSA bicycle rights, waistcoat knausgaard pabst taxidermy chillwave godard taiyaki. Leggings direct trade vape organic butcher banjo neutral milk hotel gentrify mumblecore letterpress food truck you probably haven't heard of them cardigan disrupt. Brunch fam tousled, typewriter keytar readymade dreamcatcher shabby chic taiyaki bodega boys.	25	3	2025-12-17 05:14:24.990396	2025-12-17 05:14:24.990396
12	test	24	6	2026-01-27 23:17:53.034469	2026-01-27 23:17:53.034469
\.


--
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
environment	development	2025-09-29 18:09:50.084037	2025-09-29 18:09:50.084039
schema_sha1	2a2ca43d06e5c248ed43259d33c272f8e8241c46	2025-09-29 18:09:50.093355	2025-09-29 18:09:50.093356
\.


--
-- Data for Name: availabilities; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.availabilities (id, user_id, day_of_week, created_at, updated_at, start_time, end_time, start_minute, end_minute, off) FROM stdin;
25	4	3	2025-10-08 20:43:45.189951	2026-02-10 18:04:18.566405	00:37:00	00:38:00	997	998	f
26	4	4	2025-10-08 20:43:45.190481	2026-02-10 18:04:18.56726	19:11:00	03:26:00	671	1166	f
64	9	0	2026-02-20 01:50:23.630801	2026-02-20 01:50:23.630801	19:11:00	19:11:00	671	671	f
61	10	4	2026-02-20 01:49:35.554252	2026-02-20 21:25:52.237568	19:11:00	07:01:00	671	1381	t
27	4	5	2025-10-08 20:43:45.191003	2026-02-10 18:04:18.567916	19:11:00	07:11:00	671	1391	f
28	4	6	2025-10-08 20:43:45.191632	2025-12-15 23:43:04.845156	19:11:00	19:11:00	\N	\N	f
62	10	5	2026-02-20 01:49:35.554924	2026-02-20 21:25:52.239045	21:26:00	21:27:00	806	807	f
65	9	1	2026-02-20 01:50:23.632878	2026-06-23 00:24:35.112615	19:11:00	07:11:00	671	1391	f
68	9	4	2026-02-20 01:50:23.639864	2026-06-23 00:24:35.128209	19:11:00	07:01:00	671	1381	f
50	8	0	2026-02-06 03:35:36.947643	2026-02-06 03:35:36.947643	19:11:00	19:11:00	671	671	f
51	8	1	2026-02-06 03:35:36.952696	2026-02-06 03:35:36.952696	19:11:00	19:11:00	671	671	f
52	8	2	2026-02-06 03:35:36.95772	2026-02-06 03:35:36.95772	19:11:00	19:11:00	671	671	f
53	8	3	2026-02-06 03:35:36.959634	2026-02-06 03:35:36.959634	19:11:00	19:11:00	671	671	f
9	2	1	2025-09-30 23:06:54.455479	2026-02-05 00:31:20.874803	16:01:00	04:01:00	481	1201	f
11	2	3	2025-09-30 23:06:54.463196	2026-02-05 00:31:20.875485	16:11:00	04:11:00	491	1211	f
57	10	0	2026-02-20 01:49:35.544431	2026-02-20 01:49:35.544431	19:11:00	19:11:00	671	671	f
58	10	1	2026-02-20 01:49:35.551672	2026-02-20 01:49:35.551672	19:11:00	19:11:00	671	671	f
40	6	4	2025-12-11 23:49:23.411419	2026-01-27 21:17:00.960934	08:00:00	08:00:00	0	0	t
34	5	5	2025-12-10 01:34:02.874504	2025-12-15 23:35:37.259675	19:11:00	19:11:00	\N	\N	f
35	5	6	2025-12-10 01:34:02.877647	2025-12-15 23:35:37.262065	19:11:00	19:11:00	\N	\N	f
56	8	6	2026-02-06 03:35:36.964337	2026-02-06 03:35:36.964337	19:11:00	19:01:00	671	661	f
59	10	2	2026-02-20 01:49:35.55261	2026-02-20 01:49:35.55261	19:11:00	19:01:00	671	661	f
66	9	2	2026-02-20 01:50:23.634181	2026-02-20 01:50:23.634181	19:01:00	19:11:00	661	671	f
30	5	1	2025-12-10 01:34:02.867783	2026-02-02 20:35:40.150919	19:11:00	20:36:00	671	756	f
67	9	3	2026-02-20 01:50:23.639018	2026-02-20 01:50:23.639018	19:11:00	19:11:00	671	671	f
60	10	3	2026-02-20 01:49:35.553357	2026-02-20 01:49:35.553357	19:01:00	19:01:00	661	661	f
45	7	2	2026-02-05 06:48:33.468074	2026-02-10 17:48:20.535733	17:11:00	18:14:00	551	614	f
8	2	0	2025-09-30 23:06:54.449958	2025-12-15 23:38:54.726122	16:11:00	16:11:00	\N	\N	f
31	5	2	2025-12-10 01:34:02.869419	2026-05-19 22:53:46.739665	23:54:00	23:55:00	954	955	f
10	2	2	2025-09-30 23:06:54.457564	2025-12-15 23:38:54.727605	16:11:00	16:11:00	\N	\N	f
12	2	4	2025-09-30 23:06:54.46402	2025-12-15 23:38:54.728683	16:11:00	16:11:00	\N	\N	f
13	2	5	2025-09-30 23:06:54.464822	2025-12-15 23:38:54.731138	16:11:00	16:11:00	\N	\N	f
14	2	6	2025-09-30 23:06:54.465706	2025-12-15 23:38:54.7331	16:11:00	16:11:00	\N	\N	f
36	6	0	2025-12-11 23:49:23.393487	2025-12-15 23:39:44.586723	16:11:00	16:11:00	\N	\N	f
69	9	5	2026-02-20 01:50:23.640648	2026-02-20 01:50:23.640648	19:12:00	19:01:00	672	661	f
23	4	1	2025-10-08 20:43:45.188839	2026-02-10 18:04:18.563759	19:08:00	03:37:00	668	1177	f
70	9	6	2026-02-20 01:50:23.641254	2026-02-20 01:50:23.641254	19:01:00	19:11:00	661	671	f
43	7	0	2026-02-05 06:48:33.455705	2026-02-05 06:48:33.455705	09:11:00	23:08:00	71	908	f
24	4	2	2025-10-08 20:43:45.189408	2026-02-03 17:44:10.371971	17:38:00	17:45:00	578	585	f
42	6	6	2025-12-11 23:49:23.415239	2025-12-15 23:39:44.596852	08:33:00	08:33:00	\N	\N	f
22	4	0	2025-10-08 20:43:45.187485	2025-12-15 23:43:04.841416	19:11:00	19:01:00	\N	\N	f
1	1	0	2025-09-29 23:15:26.315232	2025-12-17 01:43:26.093483	19:01:00	19:11:00	661	671	f
5	1	4	2025-09-29 23:15:26.33408	2025-12-17 01:43:26.101724	19:11:00	19:01:00	671	661	f
6	1	5	2025-09-29 23:15:26.337589	2025-12-17 01:43:26.102959	19:01:00	19:01:00	661	661	f
7	1	6	2025-09-29 23:15:26.338961	2025-12-17 01:43:26.10368	19:11:00	19:11:00	671	671	f
48	7	5	2026-02-05 06:48:33.471473	2026-02-05 06:48:33.471473	19:11:00	19:11:00	671	671	f
49	7	6	2026-02-05 06:48:33.473808	2026-02-05 06:48:33.473808	19:11:00	19:11:00	671	671	f
72	11	1	2026-02-20 01:53:57.010738	2026-02-20 01:53:57.010738	12:44:00	12:04:00	284	244	f
73	11	2	2026-02-20 01:53:57.011316	2026-02-20 01:53:57.011316	12:44:00	12:44:00	284	284	f
74	11	3	2026-02-20 01:53:57.011863	2026-02-20 01:53:57.011863	12:44:00	12:44:00	284	284	f
76	11	5	2026-02-20 01:53:57.013524	2026-02-20 01:53:57.013524	12:44:00	12:44:00	284	284	f
77	11	6	2026-02-20 01:53:57.01467	2026-02-20 01:53:57.01467	12:44:00	12:44:00	284	284	f
71	11	0	2026-02-20 01:53:57.010088	2026-02-20 04:22:39.828484	13:00:00	05:44:00	300	1304	f
75	11	4	2026-02-20 01:53:57.01284	2026-02-20 04:22:39.829692	12:44:00	07:55:00	284	1435	f
63	10	6	2026-02-20 01:49:35.555519	2026-02-20 21:25:52.239941	05:44:00	07:11:00	1304	1391	t
2	1	1	2025-09-29 23:15:26.329079	2026-07-01 01:32:36.410525	19:11:00	01:59:00	671	1079	f
3	1	2	2025-09-29 23:15:26.331017	2026-07-01 01:32:36.416029	09:42:00	22:56:00	102	896	f
4	1	3	2025-09-29 23:15:26.332835	2026-07-01 01:32:36.41765	08:10:00	22:12:00	10	852	f
15	3	0	2025-10-08 20:40:19.163498	2026-07-01 01:33:02.521089	16:08:00	04:08:00	488	1208	f
16	3	1	2025-10-08 20:40:19.17134	2026-07-01 01:33:02.522703	13:56:00	01:57:00	356	1077	f
17	3	2	2025-10-08 20:40:19.173866	2026-07-01 01:33:02.523569	18:00:00	05:33:00	600	1293	f
18	3	3	2025-10-08 20:40:19.178644	2026-07-01 01:33:02.524252	16:00:00	07:24:00	480	1404	f
29	5	0	2025-12-10 01:34:02.853933	2026-07-08 23:25:47.082339	12:20:00	00:20:00	260	980	f
32	5	3	2025-12-10 01:34:02.873134	2026-07-08 23:25:47.08848	19:10:00	06:08:00	670	1328	f
33	5	4	2025-12-10 01:34:02.873752	2026-07-08 23:25:47.089539	17:27:00	03:21:00	567	1161	t
44	7	1	2026-02-05 06:48:33.463597	2026-07-08 23:31:59.556856	19:11:00	07:11:00	671	1391	f
46	7	3	2026-02-05 06:48:33.468995	2026-07-08 23:31:59.558324	19:11:00	00:31:00	671	991	f
47	7	4	2026-02-05 06:48:33.469636	2026-07-08 23:27:11.130883	19:11:00	19:11:00	671	671	t
37	6	1	2025-12-11 23:49:23.400866	2026-07-08 23:32:25.023377	14:55:00	07:00:00	415	1380	f
38	6	2	2025-12-11 23:49:23.405187	2026-07-08 23:32:25.024293	15:40:00	02:00:00	460	1080	f
39	6	3	2025-12-11 23:49:23.408943	2026-07-08 23:32:25.026584	12:40:00	00:33:00	280	993	f
41	6	5	2025-12-11 23:49:23.413552	2026-07-08 23:32:25.027338	09:00:00	06:00:00	60	1320	f
55	8	5	2026-02-06 03:35:36.96287	2026-07-09 20:42:05.035876	19:11:00	19:11:00	671	671	t
54	8	4	2026-02-06 03:35:36.961286	2026-07-09 20:42:30.465734	19:11:00	21:43:00	671	823	f
19	3	4	2025-10-08 20:40:19.180714	2026-07-01 01:33:02.524911	21:39:00	06:21:00	819	1341	f
20	3	5	2025-10-08 20:40:19.182566	2026-07-01 01:33:02.5257	15:08:00	03:23:00	428	1163	f
21	3	6	2025-10-08 20:40:19.183799	2026-07-01 01:33:02.526338	16:08:00	05:08:00	488	1268	f
\.


--
-- Data for Name: consult_assignments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.consult_assignments (id, consult_id, user_id, assigned_at, created_at, updated_at) FROM stdin;
1	34	3	2026-01-22 01:49:55.604535	2026-01-22 01:49:55.608479	2026-01-22 01:49:55.608479
2	34	5	2026-01-22 01:49:55.61483	2026-01-22 01:49:55.615794	2026-01-22 01:49:55.615794
3	35	3	2026-01-22 01:51:37.181728	2026-01-22 01:51:37.189305	2026-01-22 01:51:37.189305
4	35	5	2026-01-22 01:51:37.193199	2026-01-22 01:51:37.194743	2026-01-22 01:51:37.194743
5	36	3	2026-01-22 01:53:03.126466	2026-01-22 01:53:03.13367	2026-01-22 01:53:03.13367
6	36	5	2026-01-22 01:53:03.135652	2026-01-22 01:53:03.139694	2026-01-22 01:53:03.139694
7	37	3	2026-01-22 01:53:40.712596	2026-01-22 01:53:40.719996	2026-01-22 01:53:40.719996
8	37	5	2026-01-22 01:53:40.722156	2026-01-22 01:53:40.723185	2026-01-22 01:53:40.723185
9	38	3	2026-01-22 01:54:15.072393	2026-01-22 01:54:15.081089	2026-01-22 01:54:15.081089
10	38	5	2026-01-22 01:54:15.085262	2026-01-22 01:54:15.088177	2026-01-22 01:54:15.088177
11	39	3	2026-01-22 01:54:46.513913	2026-01-22 01:54:46.523586	2026-01-22 01:54:46.523586
12	39	5	2026-01-22 01:54:46.526799	2026-01-22 01:54:46.534198	2026-01-22 01:54:46.534198
13	40	3	2026-01-22 01:57:33.429083	2026-01-22 01:57:33.438017	2026-01-22 01:57:33.438017
14	40	5	2026-01-22 01:57:33.440979	2026-01-22 01:57:33.442718	2026-01-22 01:57:33.442718
15	41	5	2026-01-27 20:46:02.406615	2026-01-27 20:46:02.42251	2026-01-27 20:46:02.42251
16	41	1	2026-01-27 20:46:02.427924	2026-01-27 20:46:02.430344	2026-01-27 20:46:02.430344
17	42	3	2026-01-27 21:01:02.604379	2026-01-27 21:01:02.624009	2026-01-27 21:01:02.624009
18	42	5	2026-01-27 21:01:02.629572	2026-01-27 21:01:02.632778	2026-01-27 21:01:02.632778
19	42	1	2026-01-27 21:01:02.635112	2026-01-27 21:01:02.638835	2026-01-27 21:01:02.638835
20	44	5	2026-01-27 21:23:45.537319	2026-01-27 21:23:45.551027	2026-01-27 21:23:45.551027
21	44	1	2026-01-27 21:23:45.557441	2026-01-27 21:23:45.561662	2026-01-27 21:23:45.561662
22	46	5	2026-01-27 23:32:07.447431	2026-01-27 23:32:07.458647	2026-01-27 23:32:07.458647
23	46	6	2026-01-27 23:32:07.463016	2026-01-27 23:32:07.465171	2026-01-27 23:32:07.465171
\.


--
-- Data for Name: consults; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.consults (id, title, body, asked_by_id, assigned_to_id, consult_status, assigned_at, created_at, updated_at, consult_type, read_at) FROM stdin;
33	testing FBX_NEO	test for Dr. Corey and borst	2	\N	0	\N	2026-01-22 01:35:57.251804	2026-01-22 01:35:57.251804	fbx_neo	\N
34	testing FBX NEO	test	2	\N	0	\N	2026-01-22 01:49:55.591756	2026-01-22 01:49:55.591756	fbx_neo	\N
62	ZXTY2314234234	this will be GONE!	2	3	0	2026-02-10 18:07:39.440595	2026-02-10 18:07:39.44559	2026-02-10 18:07:39.44559	standard	2026-02-18 03:02:36.575081
35	test FBX neo	test	2	\N	0	\N	2026-01-22 01:51:37.170333	2026-01-22 01:51:37.170333	fbx_neo	\N
10	TBD1235435	cococococo	2	3	0	2025-10-08 23:04:09.541095	2025-10-08 23:04:09.543898	2025-10-08 23:04:09.543898	standard	\N
11	testtttttt	this is fo you\r\n	2	4	0	2025-10-10 00:19:11.353903	2025-10-10 00:19:11.367537	2025-10-10 00:19:11.367537	standard	\N
12	test one 	test for preassigned 	2	4	0	2025-10-10 00:39:50.064269	2025-10-10 00:39:50.074645	2025-10-10 00:40:29.133612	standard	\N
7	test	tes my consults	1	2	0	2025-09-30 23:07:18.167267	2025-09-30 23:07:18.16939	2025-10-03 21:11:44.046833	standard	2026-02-18 02:53:30.298102
14	TESTTTT	TEst	1	4	0	2025-10-15 19:00:44.917594	2025-10-15 19:00:44.918905	2025-10-15 19:00:44.918905	standard	\N
64	CORE98765432	test	2	6	0	2026-02-17 23:36:45.886336	2026-02-17 23:36:45.897092	2026-02-17 23:36:45.897092	standard	2026-02-18 00:28:22.867669
18	test 5 mins	5 mins till I dies	2	4	0	2025-10-15 19:30:11.883499	2025-10-15 19:30:11.885242	2025-12-09 22:31:58.745912	standard	\N
17	hey tester guy	was up	4	2	0	2025-10-15 19:27:21.162312	2025-10-15 19:27:21.172716	2025-12-03 19:57:06.407737	standard	2026-02-18 00:18:21.131751
36	testing FBX NEO	trest	2	\N	0	\N	2026-01-22 01:53:03.116921	2026-01-22 01:53:03.116921	fbx_neo	\N
20	tres	test * edit	2	3	0	2025-12-11 22:48:34.567148	2025-12-11 22:48:34.573762	2025-12-15 21:27:17.958563	standard	\N
21	testAccession	Hi yeaQ!!!	2	6	0	2025-12-16 02:30:04.275439	2025-12-16 02:30:04.282095	2025-12-16 02:30:04.282095	standard	\N
22	test another 	here we go!!!!	2	6	0	2025-12-16 02:35:05.142587	2025-12-16 02:35:05.150774	2025-12-16 02:35:05.150774	standard	\N
23	testers	THANKS 	2	1	0	2025-12-17 01:59:06.689308	2025-12-17 01:59:06.696505	2025-12-17 01:59:42.856542	standard	\N
25	testAccession	I'm baby franzen celiac direct trade, thundercats adaptogen seitan chartreuse banjo retro. Kombucha stumptown marfa cliche palo santo green juice. YOLO master cleanse glossier poutine intelligentsia single-origin coffee. +1 lo-fi vice, scenester neutra ugh cold-pressed irony wayfarers live-edge shaman quinoa. Normcore scenester mixtape af DSA bicycle rights, waistcoat knausgaard pabst taxidermy chillwave godard taiyaki. Leggings direct trade vape organic butcher banjo neutral milk hotel gentrify mumblecore letterpress food truck you probably haven't heard of them cardigan disrupt. Brunch fam tousled, typewriter keytar readymade dreamcatcher shabby chic taiyaki bodega boys.\n\nScenester aesthetic fam kale chips same Brooklyn bicycle rights activated charcoal JOMO asymmetrical deep v pickled chillwave photo booth. Microdosing adaptogen skateboard mixtape chillwave, schlitz cardigan Brooklyn try-hard celiac. Readymade small batch JOMO, hot chicken bitters blog YOLO iceland fanny pack poutine gluten-free edison bulb chartreuse taiyaki subway tile. Forage brunch fam asymmetrical gatekeep taxidermy organic sriracha gochujang sartorial normcore cronut next level. Lomo 8-bit skateboard, leggings roof party yes plz health goth fixie hexagon sus venmo +1 vegan poke.	2	3	0	2025-12-17 05:13:04.862146	2025-12-17 05:13:04.872339	2025-12-17 05:14:25.005557	standard	\N
37	testing FBX NEO	trest	2	\N	0	\N	2026-01-22 01:53:40.700552	2026-01-22 01:53:40.700552	fbx_neo	\N
38	test redirect 	test2 redirect	2	\N	0	\N	2026-01-22 01:54:15.059351	2026-01-22 01:54:15.059351	fbx_neo	\N
39	test redirect	tets	2	\N	0	\N	2026-01-22 01:54:46.498181	2026-01-22 01:54:46.498181	fbx_neo	\N
40	testing FBX NEO	trest	2	\N	0	\N	2026-01-22 01:57:33.421227	2026-01-22 01:57:33.421227	fbx_neo	\N
41	testing FBX NEO 2	hi core	2	\N	0	\N	2026-01-27 20:46:02.381693	2026-01-27 20:46:02.381693	fbx_neo	\N
42	ree	sadf	2	\N	0	\N	2026-01-27 21:01:02.582057	2026-01-27 21:01:02.582057	fbx_neo	\N
43	test	test to assign	2	4	0	2026-01-27 21:23:20.422915	2026-01-27 21:23:20.425773	2026-01-27 21:23:20.425773	standard	\N
44	testing FBX NEO 3	test fbx neo 3	2	\N	0	\N	2026-01-27 21:23:45.52931	2026-01-27 21:23:45.52931	fbx_neo	\N
24	Accession	her is a questions 	2	6	0	2025-12-17 02:54:54.445333	2025-12-17 02:54:54.448277	2026-01-27 23:17:53.048408	standard	\N
45	hi doc	this is s a 	6	4	0	2026-01-27 23:18:17.140242	2026-01-27 23:18:17.147609	2026-01-27 23:18:17.147609	standard	\N
46	testing FBX NEO3	test	2	\N	0	\N	2026-01-27 23:32:07.433095	2026-01-27 23:32:07.433095	fbx_neo	\N
47	test	test	2	1	0	2026-02-02 19:11:59.779139	2026-02-02 19:11:59.790955	2026-02-02 19:11:59.790955	standard	\N
49	test notif	regular	2	3	0	2026-02-02 23:47:31.75137	2026-02-02 23:47:31.758008	2026-02-02 23:47:31.758008	standard	\N
50	test notif	regular	2	3	0	2026-02-02 23:52:41.3669	2026-02-02 23:52:41.371906	2026-02-02 23:52:41.371906	standard	\N
52	BCAA1343345	check out that growth	2	3	0	2026-02-05 06:43:23.032864	2026-02-05 06:43:23.036586	2026-02-05 06:43:23.036586	standard	\N
54	SEAN123435567	test access 	2	3	0	2026-02-05 21:40:22.952938	2026-02-05 21:40:22.959848	2026-02-05 21:40:22.959848	standard	\N
55	POBC23478745	testttttt	3	5	0	2026-02-05 23:29:46.437463	2026-02-05 23:29:46.439458	2026-02-05 23:29:46.439458	standard	\N
56	POBC234787451233	erwwwq	3	5	0	2026-02-05 23:31:17.767884	2026-02-05 23:31:17.771609	2026-02-05 23:31:17.771609	standard	\N
57	WISC4899705	tester hellos 	2	3	0	2026-02-05 23:34:36.268077	2026-02-05 23:34:36.269461	2026-02-05 23:34:36.269461	standard	\N
30	TEST2 be on top latest	TOP MOST UP 	3	2	0	2025-12-17 18:39:45.747665	2025-12-17 18:39:45.749173	2025-12-17 18:39:45.749173	standard	2026-02-17 23:24:58.066351
65	CORE98765432	test	2	1	0	2026-02-17 23:37:18.450667	2026-02-17 23:37:18.458833	2026-02-17 23:37:18.458833	standard	\N
67	testforBorder	test tet	2	6	0	2026-02-17 23:50:17.678183	2026-02-17 23:50:17.680297	2026-02-17 23:50:17.680297	standard	2026-02-17 23:50:35.072893
68	NewBorderTest	test	2	6	0	2026-02-17 23:52:24.067305	2026-02-17 23:52:24.072345	2026-02-17 23:52:24.072345	standard	2026-02-17 23:52:33.939235
69	TBD12344	testsssss	2	6	0	2026-02-17 23:54:16.801014	2026-02-17 23:54:16.802963	2026-02-17 23:54:16.802963	standard	2026-02-17 23:54:18.858961
70	testConsultsBorder	tes	2	6	0	2026-02-18 00:15:29.834368	2026-02-18 00:15:29.837969	2026-02-18 00:15:29.837969	standard	2026-02-18 00:15:37.450519
29	ABCD213432423	test questions 	3	2	0	2025-12-17 18:38:18.890537	2025-12-17 18:38:18.895029	2025-12-17 18:38:18.895029	standard	2026-02-18 00:17:01.341311
19	test accession 	Hi Dr. 	1	2	0	2025-12-09 22:33:14.987029	2025-12-09 22:33:14.990082	2025-12-09 22:33:37.788595	standard	2026-02-18 00:17:53.168661
16	hey you	new one	4	2	0	2025-10-15 19:09:49.596991	2025-10-15 19:09:49.598041	2025-10-15 19:09:49.598041	standard	2026-02-18 00:32:51.46363
15	test again to see 2	hi you	4	2	0	2025-10-15 19:08:26.891429	2025-10-15 19:08:26.893248	2025-10-15 19:08:26.893248	standard	2026-02-18 00:32:56.619605
63	CORE12345678	nothing here 1	2	6	0	2026-02-17 23:29:14.707111	2026-02-17 23:29:14.713912	2026-02-17 23:29:14.713912	standard	2026-02-18 00:34:11.09294
13	test to respond	hey You!!	1	2	0	2025-10-15 18:59:41.092879	2025-10-15 18:59:41.096858	2025-10-15 19:00:01.350056	standard	2026-02-18 00:34:37.762667
61	BCAA12344455	test	2	3	0	2026-02-10 17:49:05.751855	2026-02-10 17:49:05.75538	2026-02-10 17:49:05.75538	standard	2026-02-18 03:02:37.069097
59	ANTY324453567	test accesison 	2	3	0	2026-02-05 23:41:55.44359	2026-02-05 23:41:55.450994	2026-02-05 23:41:55.450994	standard	2026-02-18 03:02:43.076203
71	testColorBorder	terst	2	3	0	2026-02-18 03:10:46.930504	2026-02-18 03:10:46.933804	2026-02-18 03:10:46.933804	standard	2026-02-18 03:11:09.3565
60	EUGE23432563	rwtretewt	2	3	0	2026-02-06 02:45:13.043018	2026-02-06 02:45:13.051249	2026-02-06 02:45:13.051249	standard	2026-02-20 04:39:51.668544
53	BCAA553336633	test note	2	3	0	2026-02-05 21:27:12.270595	2026-02-05 21:27:12.274906	2026-02-05 21:27:12.274906	standard	2026-02-20 04:40:01.364142
48	test notif	regular	2	3	0	2026-02-02 23:45:42.325023	2026-02-02 23:45:42.338167	2026-02-02 23:45:42.338167	standard	2026-02-20 05:23:15.295923
51	test	testt	2	3	0	2026-02-03 00:04:01.337624	2026-02-03 00:04:01.348752	2026-02-03 00:04:01.348752	standard	2026-02-24 01:41:08.735435
58	ENGL34567345465	6s; is the loniiest number 	1	3	0	2026-02-05 23:36:09.850474	2026-02-05 23:36:09.852846	2026-02-05 23:36:09.852846	standard	2026-02-24 01:41:18.362143
72	borderColor	testssss	2	3	0	2026-02-18 18:05:28.603516	2026-02-18 18:05:28.607937	2026-02-18 18:05:28.607937	standard	2026-02-18 18:05:33.179989
73	BorderColoreUserContext	tests	2	3	0	2026-02-18 18:18:24.607477	2026-02-18 18:18:24.611782	2026-02-18 18:18:24.611782	standard	2026-02-18 18:18:29.411065
74	TestBorder_Coo	testerinao	2	3	0	2026-02-18 23:31:12.884041	2026-02-18 23:31:12.886587	2026-02-18 23:31:12.886587	standard	2026-02-18 23:31:19.071902
75	testone	hello	2	5	0	2026-02-18 23:31:49.619439	2026-02-18 23:31:49.622692	2026-02-18 23:31:49.622692	standard	\N
77	TEST	Hi yea	2	5	0	2026-02-18 23:35:27.15093	2026-02-18 23:35:27.162504	2026-02-18 23:35:27.162504	standard	\N
79	TASKREDIRECT	Hello	2	5	0	2026-02-18 23:38:26.931395	2026-02-18 23:38:26.934134	2026-02-18 23:38:26.934134	standard	\N
78	testing redirects	hello	2	3	0	2026-02-18 23:37:48.643513	2026-02-18 23:37:48.645481	2026-02-18 23:37:48.645481	standard	2026-02-18 23:38:37.950255
76	TEST_REdirect	tests	2	3	0	2026-02-18 23:34:58.402696	2026-02-18 23:34:58.411052	2026-02-18 23:34:58.411052	standard	2026-02-18 23:38:41.043972
80	colorBorder2	2	2	3	0	2026-02-18 23:54:36.118249	2026-02-18 23:54:36.119717	2026-02-18 23:54:36.119717	standard	2026-02-18 23:54:40.071788
81	POBC23478745	\N	3	5	0	2026-02-19 00:07:49.144001	2026-02-19 00:07:49.145913	2026-02-19 00:07:49.145913	standard	\N
82	testINGBODYREM	\N	2	3	0	2026-02-19 02:29:26.160357	2026-02-19 02:29:26.162521	2026-02-19 02:29:26.162521	standard	2026-02-19 02:29:31.249246
83	CORE98765432	\N	2	3	0	2026-02-19 02:31:05.486496	2026-02-19 02:31:05.496387	2026-02-19 02:31:05.496387	standard	2026-02-19 02:31:14.845453
84	testewrino	\N	2	10	0	2026-02-20 01:50:49.630952	2026-02-20 01:50:49.6328	2026-02-20 01:50:49.6328	standard	\N
85	TEsterino1234w542	\N	2	10	0	2026-02-20 02:46:05.988791	2026-02-20 02:46:05.996835	2026-02-20 02:46:05.996835	standard	\N
86	testColorBorder4V	\N	2	3	0	2026-02-20 21:32:02.186719	2026-02-20 21:32:02.191118	2026-02-20 21:32:02.191118	standard	2026-02-20 21:32:14.411436
87	sreraw	\N	2	6	0	2026-02-21 03:49:24.049307	2026-02-21 03:49:24.055363	2026-02-21 03:49:24.055363	standard	\N
88	tehe	\N	3	6	0	2026-02-21 04:11:23.650171	2026-02-21 04:11:23.654823	2026-02-21 04:11:23.654823	standard	\N
89	BCAA543345774	\N	2	3	0	2026-02-23 14:14:44.124992	2026-02-23 14:14:44.12757	2026-02-23 14:14:44.12757	standard	2026-02-23 16:30:56.732799
90	POBC234787451233	\N	2	1	0	2026-06-24 02:13:49.709273	2026-06-24 02:13:49.712918	2026-06-24 02:13:49.712918	standard	2026-06-24 02:16:28.364881
66	CORE98765432	test	2	1	0	2026-02-17 23:49:38.521263	2026-02-17 23:49:38.526989	2026-02-17 23:49:38.526989	standard	2026-06-24 02:16:32.652684
91	 a {   color: rgba(var(--#{$prefix}link-color-rgb), var(--#{$prefix}link-opacity, 1));   text-decoration: $link-decoration;	\N	2	3	0	2026-07-08 21:04:56.884044	2026-07-08 21:04:56.887442	2026-07-08 21:04:56.887442	standard	2026-07-08 21:06:28.081378
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.schema_migrations (version) FROM stdin;
20250916054813
20250916044504
20250915001814
20250915001732
20250914214404
20250914214348
20250914213926
20250929225948
20250929235138
20251211225052
20251215223547
20260121185934
20260121190125
20260121190306
20260122013330
20260127192031
20260204223115
20260204234804
20260217232152
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, email, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, name, user_role, daily_consult_limit, cooldown_minutes, available_start_time, available_end_time, created_at, updated_at, time_zone, can_accept_fbx_neo, can_receive_consults) FROM stdin;
1	test@example.com	$2a$12$llo6geMK0PtcJ0sf9g.SxeNBrQ81aiBg8UWzAh58p25Ao6iGvImf.	\N	\N	\N	Dr. Garcia	user	12	5	22:29:00	22:32:00	2025-09-29 18:19:24.450305	2026-02-05 23:48:33.457404	London	t	t
5	corey@corey.com	$2a$12$YzZagKOoRFt.LloYMyG4duyBwQasyI.t8shHGwnEBHqCMR/oVAUri	a0e612e82167a9d717b4ca6c590392cfb6efe51da0b1d40885fe07a4dd6c455b	2026-02-06 03:31:58.895595	\N	Dr. Cutlip	user	20	1	\N	\N	2025-12-10 01:33:06.977544	2026-02-06 03:31:58.895669	Pacific Time (US & Canada)	f	t
4	dr@example.com	$2a$12$u7fw5u2o.yfnx08hcUiPy.C/r2RcWv19U.kqX60srubfOx2aZJ7kC	\N	\N	\N	Dr. Gerdin	user	5	5	\N	\N	2025-10-08 20:42:44.086676	2026-02-10 18:04:18.560081	Pacific Time (US & Canada)	f	f
3	regular@example.com	$2a$12$7UZxs/lufljdBVxnweVfPuOWgA2UAFfIkHJUJxKwkyEz50G4/FYJa	\N	\N	\N	Dr. Borst	user	50	1	\N	\N	2025-10-08 20:39:01.026941	2026-02-13 19:35:16.253971	Eastern Time (US & Canada)	t	t
6	tt@example.com	$2a$12$JOlpcu6x2jnxy8HxgfTu7eYC6HOkDCjgh8rpnIO/OCNa1qcQkJ532	\N	\N	\N	Dr. Tran	user	6	1	\N	\N	2025-12-11 23:48:21.208241	2026-02-17 23:50:02.869186	Pacific Time (US & Canada)	t	t
8	coreycor904@gmail.com	$2a$12$aUgKGp0x0nLRuznegozlJuegMPK98VGMSQe3iEHAoTWXwMP.vo3YK	21bb30d73f356a479bb939541ea56abeb0a4e1aa7580bc9f3ad7e7963422c310	2026-02-06 03:38:13.627368	\N	Dr.coreyheah	user	15	0	\N	\N	2026-02-06 03:33:18.890407	2026-02-20 01:05:17.095712	Pacific Time (US & Canada)	f	t
9	coco@gmail.com	$2a$12$il3Rf9BNMHfNZ4QXOsG9i.14vwZBv1jbJ/nEX4hiLoDYoFRTb4z1S	\N	\N	\N	Dr. Firstly	user	5	5	\N	\N	2026-02-20 01:35:17.719209	2026-02-20 01:50:23.628854	Pacific Time (US & Canada)	f	t
11	antony@email.com	$2a$12$/61yE1OeneHWheKE489wk.PGbSyOseac9FpLO99YvXR0OGY8ct9DS	\N	\N	\N	Dr. Antony	user	5	5	\N	\N	2026-02-20 01:53:57.005735	2026-02-20 01:53:57.005735	Pacific Time (US & Canada)	f	t
10	dh@email.com	$2a$12$aSLTuQUDtp.MStOTwIq1VuCVHyGHiJ2qhAz.BuYWZs/UCJyO3Z76m	\N	\N	\N	Dr. Hardgrove	user	5	5	\N	\N	2026-02-20 01:46:05.366015	2026-02-20 05:33:01.654615	Pacific Time (US & Canada)	t	t
2	admin@example.com	$2a$12$yEVTnCwOiY61LD8.CYo8EuCbE9plKK/w5CEBGMknSkmcl9TSU40tS	\N	\N	\N	admin	admin	5	1	\N	\N	2025-09-29 18:20:44.367772	2026-02-05 00:31:20.87377	Pacific Time (US & Canada)	f	f
7	whipple@example.com	$2a$12$IhHd36Vl9ybH5mrVFlymD.sF9k0uQmmiowBAFBnefWd7xjsmeq1tu	\N	\N	\N	Dr. Whipple	user	15	2	\N	\N	2026-02-05 06:47:01.538855	2026-02-05 06:54:28.71635	Pacific Time (US & Canada)	t	t
\.


--
-- Name: answers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.answers_id_seq', 12, true);


--
-- Name: availabilities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.availabilities_id_seq', 77, true);


--
-- Name: consult_assignments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.consult_assignments_id_seq', 23, true);


--
-- Name: consults_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.consults_id_seq', 91, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 11, true);


--
-- Name: answers answers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.answers
    ADD CONSTRAINT answers_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: availabilities availabilities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.availabilities
    ADD CONSTRAINT availabilities_pkey PRIMARY KEY (id);


--
-- Name: consult_assignments consult_assignments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.consult_assignments
    ADD CONSTRAINT consult_assignments_pkey PRIMARY KEY (id);


--
-- Name: consults consults_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.consults
    ADD CONSTRAINT consults_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_answers_on_consult_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_answers_on_consult_id ON public.answers USING btree (consult_id);


--
-- Name: index_answers_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_answers_on_user_id ON public.answers USING btree (user_id);


--
-- Name: index_availabilities_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_availabilities_on_user_id ON public.availabilities USING btree (user_id);


--
-- Name: index_consult_assignments_on_consult_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_consult_assignments_on_consult_id ON public.consult_assignments USING btree (consult_id);


--
-- Name: index_consult_assignments_on_consult_id_and_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_consult_assignments_on_consult_id_and_user_id ON public.consult_assignments USING btree (consult_id, user_id);


--
-- Name: index_consult_assignments_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_consult_assignments_on_user_id ON public.consult_assignments USING btree (user_id);


--
-- Name: index_consults_on_asked_by_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_consults_on_asked_by_id ON public.consults USING btree (asked_by_id);


--
-- Name: index_consults_on_assigned_to_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_consults_on_assigned_to_id ON public.consults USING btree (assigned_to_id);


--
-- Name: index_consults_on_consult_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_consults_on_consult_type ON public.consults USING btree (consult_type);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_users_on_email ON public.users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON public.users USING btree (reset_password_token);


--
-- Name: consult_assignments fk_rails_254dda126c; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.consult_assignments
    ADD CONSTRAINT fk_rails_254dda126c FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: consults fk_rails_26beec50c8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.consults
    ADD CONSTRAINT fk_rails_26beec50c8 FOREIGN KEY (asked_by_id) REFERENCES public.users(id);


--
-- Name: answers fk_rails_584be190c2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.answers
    ADD CONSTRAINT fk_rails_584be190c2 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: consult_assignments fk_rails_b9366a38cb; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.consult_assignments
    ADD CONSTRAINT fk_rails_b9366a38cb FOREIGN KEY (consult_id) REFERENCES public.consults(id);


--
-- Name: consults fk_rails_cc9cd423f3; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.consults
    ADD CONSTRAINT fk_rails_cc9cd423f3 FOREIGN KEY (assigned_to_id) REFERENCES public.users(id);


--
-- Name: answers fk_rails_cdf32de480; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.answers
    ADD CONSTRAINT fk_rails_cdf32de480 FOREIGN KEY (consult_id) REFERENCES public.consults(id);


--
-- Name: availabilities fk_rails_f567fbd0f7; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.availabilities
    ADD CONSTRAINT fk_rails_f567fbd0f7 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

\unrestrict LFjJU5QZZO4Kg1YA31o0GYbbeOuWuuhiuVgUWPEUpzWtAG0obsZXQi9N7dIaxvb

