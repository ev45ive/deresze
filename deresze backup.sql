--
-- PostgreSQL database dump
--

-- Dumped from database version 9.1.2
-- Dumped by pg_dump version 9.1.3
-- Started on 2012-10-15 10:34:39

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 925 (class 1259 OID 56052258)
-- Dependencies: 7
-- Name: deresze; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE deresze (
    id integer NOT NULL,
    title character varying(50),
    author character varying(50),
    content text,
    votes integer
);


ALTER TABLE public.deresze OWNER TO postgres;

--
-- TOC entry 924 (class 1259 OID 56052256)
-- Dependencies: 925 7
-- Name: deresze_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE deresze_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.deresze_id_seq OWNER TO postgres;

--
-- TOC entry 5113 (class 0 OID 0)
-- Dependencies: 924
-- Name: deresze_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE deresze_id_seq OWNED BY deresze.id;


--
-- TOC entry 5114 (class 0 OID 0)
-- Dependencies: 924
-- Name: deresze_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('deresze_id_seq', 15, true);


--
-- TOC entry 5107 (class 2604 OID 56052261)
-- Dependencies: 924 925 925
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY deresze ALTER COLUMN id SET DEFAULT nextval('deresze_id_seq'::regclass);


--
-- TOC entry 5110 (class 0 OID 56052258)
-- Dependencies: 925
-- Data for Name: deresze; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY deresze (id, title, author, content, votes) FROM stdin;
14	;)	Anonim	["WSIPnet pad\\u0142!","Serio!?","Pijemy dalej"]	\N
15	Afro dyzjak	Autor	["Laski lec\\u0105 na \\u0142ysych",null,"Mamo przesta\\u0144!"]	\N
\.


--
-- TOC entry 5109 (class 2606 OID 56052263)
-- Dependencies: 925 925
-- Name: deresze_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY deresze
    ADD CONSTRAINT deresze_pkey PRIMARY KEY (id);


-- Completed on 2012-10-15 10:34:40

--
-- PostgreSQL database dump complete
--

