--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.11
-- Dumped by pg_dump version 9.6.11

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: devices; Type: TABLE; Schema: public; Owner: ec2-user
--

CREATE TABLE public.devices (
    id integer NOT NULL,
    name text NOT NULL,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.devices OWNER TO "ec2-user";

--
-- Name: devices_id_seq; Type: SEQUENCE; Schema: public; Owner: ec2-user
--

CREATE SEQUENCE public.devices_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.devices_id_seq OWNER TO "ec2-user";

--
-- Name: devices_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ec2-user
--

ALTER SEQUENCE public.devices_id_seq OWNED BY public.devices.id;


--
-- Name: parts; Type: TABLE; Schema: public; Owner: ec2-user
--

CREATE TABLE public.parts (
    id integer NOT NULL,
    part_number integer NOT NULL,
    device_id integer
);


ALTER TABLE public.parts OWNER TO "ec2-user";

--
-- Name: parts_id_seq; Type: SEQUENCE; Schema: public; Owner: ec2-user
--

CREATE SEQUENCE public.parts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.parts_id_seq OWNER TO "ec2-user";

--
-- Name: parts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ec2-user
--

ALTER SEQUENCE public.parts_id_seq OWNED BY public.parts.id;


--
-- Name: devices id; Type: DEFAULT; Schema: public; Owner: ec2-user
--

ALTER TABLE ONLY public.devices ALTER COLUMN id SET DEFAULT nextval('public.devices_id_seq'::regclass);


--
-- Name: parts id; Type: DEFAULT; Schema: public; Owner: ec2-user
--

ALTER TABLE ONLY public.parts ALTER COLUMN id SET DEFAULT nextval('public.parts_id_seq'::regclass);


--
-- Data for Name: devices; Type: TABLE DATA; Schema: public; Owner: ec2-user
--

INSERT INTO public.devices VALUES (2, 'Gyroscope', '2020-02-14 18:17:09.517678');
INSERT INTO public.devices VALUES (3, 'Magnetometer', '2020-02-15 13:57:18.018346');


--
-- Name: devices_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ec2-user
--

SELECT pg_catalog.setval('public.devices_id_seq', 3, true);


--
-- Data for Name: parts; Type: TABLE DATA; Schema: public; Owner: ec2-user
--

INSERT INTO public.parts VALUES (4, 31, 2);
INSERT INTO public.parts VALUES (5, 33, 2);
INSERT INTO public.parts VALUES (6, 35, 2);
INSERT INTO public.parts VALUES (9, 50, NULL);
INSERT INTO public.parts VALUES (10, 54, NULL);
INSERT INTO public.parts VALUES (11, 58, NULL);
INSERT INTO public.parts VALUES (12, 42, 3);


--
-- Name: parts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ec2-user
--

SELECT pg_catalog.setval('public.parts_id_seq', 12, true);


--
-- Name: devices devices_pkey; Type: CONSTRAINT; Schema: public; Owner: ec2-user
--

ALTER TABLE ONLY public.devices
    ADD CONSTRAINT devices_pkey PRIMARY KEY (id);


--
-- Name: parts parts_part_number_key; Type: CONSTRAINT; Schema: public; Owner: ec2-user
--

ALTER TABLE ONLY public.parts
    ADD CONSTRAINT parts_part_number_key UNIQUE (part_number);


--
-- Name: parts parts_pkey; Type: CONSTRAINT; Schema: public; Owner: ec2-user
--

ALTER TABLE ONLY public.parts
    ADD CONSTRAINT parts_pkey PRIMARY KEY (id);


--
-- Name: parts parts_device_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ec2-user
--

ALTER TABLE ONLY public.parts
    ADD CONSTRAINT parts_device_id_fkey FOREIGN KEY (device_id) REFERENCES public.devices(id);


--
-- PostgreSQL database dump complete
--

