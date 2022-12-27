--
-- PostgreSQL database dump
--

-- Dumped from database version 15.1
-- Dumped by pg_dump version 15.1

-- Started on 2022-12-27 20:01:32

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 2 (class 3079 OID 16384)
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- TOC entry 3497 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


--
-- TOC entry 247 (class 1255 OID 24774)
-- Name: benzinucret(integer, real); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.benzinucret(otobusnoo integer, yol real) RETURNS real
    LANGUAGE plpgsql
    AS $$ -- Fonksiyon govdesinin (tanımının) başlangıcı
DECLARE
seferSayisi integer;
yuzKmBenzin real;
benzinUcret real;
BEGIN
seferSayisi=(select "seferSayisi" from "Otobus" where "Otobus"."otobusNo"=otobusNoo);
yuzKmBenzin=(select "yuzKmBenzin" from "Otobus" where "Otobus"."otobusNo"=otobusNoo);
    RETURN 20*seferSayisi *yol*yuzKmBenzin/100;
END;
$$;


ALTER FUNCTION public.benzinucret(otobusnoo integer, yol real) OWNER TO postgres;

--
-- TOC entry 259 (class 1255 OID 32969)
-- Name: bilettartis(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.bilettartis() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
   update "Bilet" set biletSayisi = biletSayisi+ 1;
   return new;
end;
$$;


ALTER FUNCTION public.bilettartis() OWNER TO postgres;

--
-- TOC entry 244 (class 1255 OID 16821)
-- Name: cirohesabi(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.cirohesabi() RETURNS integer
    LANGUAGE plpgsql
    AS $$ 
BEGIN
    RETURN 500*(select max("SatilanBilet"."satilanBiletNo") from "SatilanBilet");
END;
$$;


ALTER FUNCTION public.cirohesabi() OWNER TO postgres;

--
-- TOC entry 246 (class 1255 OID 24772)
-- Name: harcananbenzin(integer, real); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.harcananbenzin(otobusnoo integer, yol real) RETURNS real
    LANGUAGE plpgsql
    AS $$ -- Fonksiyon govdesinin (tanımının) başlangıcı
DECLARE
seferSayisi integer;
yuzKmBenzin real;
BEGIN
seferSayisi=(select "seferSayisi" from "Otobus" where "Otobus"."otobusNo"=otobusNoo);
yuzKmBenzin=(select "yuzKmBenzin" from "Otobus" where "Otobus"."otobusNo"=otobusNoo);
    RETURN seferSayisi *yol*yuzKmBenzin/100;
END;
$$;


ALTER FUNCTION public.harcananbenzin(otobusnoo integer, yol real) OWNER TO postgres;

--
-- TOC entry 245 (class 1255 OID 24761)
-- Name: maashesabi(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.maashesabi(tcnoo bigint) RETURNS real
    LANGUAGE plpgsql
    AS $$ -- Fonksiyon govdesinin (tanımının) başlangıcı
DECLARE 
calismaSaati integer;
BEGIN
calismaSaati=(select "calismaSaati" from "Personel" where "Personel"."tcNo"=tcNoo);
    RETURN 600 *calismaSaati;
END;
$$;


ALTER FUNCTION public.maashesabi(tcnoo bigint) OWNER TO postgres;

--
-- TOC entry 262 (class 1255 OID 32981)
-- Name: satilanbiletartis(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.satilanbiletartis() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
   update "SatilanBilet" set satilanbiletsayisi = satilanbiletsayisi+ 1;
   return new;
end;
$$;


ALTER FUNCTION public.satilanbiletartis() OWNER TO postgres;

--
-- TOC entry 261 (class 1255 OID 32978)
-- Name: yolcucikarma(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.yolcucikarma() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
   update yolcular set yolcusayisi = yolcusayisi- 1;
   return new;
end;
$$;


ALTER FUNCTION public.yolcucikarma() OWNER TO postgres;

--
-- TOC entry 260 (class 1255 OID 32976)
-- Name: yolcuekleme(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.yolcuekleme() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
   update yolcular set yolcusayisi = yolcusayisi+ 1;
   return new;
end;
$$;


ALTER FUNCTION public.yolcuekleme() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 235 (class 1259 OID 16747)
-- Name: AracYakit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."AracYakit" (
    "sirketNo" integer NOT NULL,
    "sirketAdi" character varying(20) NOT NULL,
    "firmaKodu" integer NOT NULL,
    "benzinUcret" double precision DEFAULT 10 NOT NULL
);


ALTER TABLE public."AracYakit" OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 16746)
-- Name: AracYakit_sirketNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."AracYakit_sirketNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."AracYakit_sirketNo_seq" OWNER TO postgres;

--
-- TOC entry 3498 (class 0 OID 0)
-- Dependencies: 234
-- Name: AracYakit_sirketNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."AracYakit_sirketNo_seq" OWNED BY public."AracYakit"."sirketNo";


--
-- TOC entry 223 (class 1259 OID 16673)
-- Name: Bilet; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Bilet" (
    "biletNo" integer NOT NULL,
    tarih date NOT NULL,
    ucret integer NOT NULL,
    "firmaKodu" integer NOT NULL,
    "gidilecekSehir" integer DEFAULT 1 NOT NULL,
    "mevcutSehir" integer DEFAULT 1 NOT NULL,
    "musteriTc" bigint NOT NULL,
    "biletSayisi" integer NOT NULL
);


ALTER TABLE public."Bilet" OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16672)
-- Name: Bilet_biletNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Bilet_biletNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Bilet_biletNo_seq" OWNER TO postgres;

--
-- TOC entry 3499 (class 0 OID 0)
-- Dependencies: 222
-- Name: Bilet_biletNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Bilet_biletNo_seq" OWNED BY public."Bilet"."biletNo";


--
-- TOC entry 241 (class 1259 OID 24775)
-- Name: Bilet_biletSayisi_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Bilet_biletSayisi_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Bilet_biletSayisi_seq" OWNER TO postgres;

--
-- TOC entry 3500 (class 0 OID 0)
-- Dependencies: 241
-- Name: Bilet_biletSayisi_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Bilet_biletSayisi_seq" OWNED BY public."Bilet"."biletSayisi";


--
-- TOC entry 227 (class 1259 OID 16687)
-- Name: Fatura; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Fatura" (
    "faturaNo" integer NOT NULL,
    "kesimTarihi" date NOT NULL,
    "biletNo" integer NOT NULL
);


ALTER TABLE public."Fatura" OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16686)
-- Name: Fatura_faturaNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Fatura_faturaNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Fatura_faturaNo_seq" OWNER TO postgres;

--
-- TOC entry 3501 (class 0 OID 0)
-- Dependencies: 226
-- Name: Fatura_faturaNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Fatura_faturaNo_seq" OWNED BY public."Fatura"."faturaNo";


--
-- TOC entry 229 (class 1259 OID 16699)
-- Name: Firma; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Firma" (
    "firmaKodu" integer NOT NULL,
    "firmaAdi" character varying(20) NOT NULL,
    "personelTc" bigint NOT NULL,
    "otobusNo" integer NOT NULL
);


ALTER TABLE public."Firma" OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 16698)
-- Name: Firma_firmaKodu_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Firma_firmaKodu_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Firma_firmaKodu_seq" OWNER TO postgres;

--
-- TOC entry 3502 (class 0 OID 0)
-- Dependencies: 228
-- Name: Firma_firmaKodu_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Firma_firmaKodu_seq" OWNED BY public."Firma"."firmaKodu";


--
-- TOC entry 233 (class 1259 OID 16740)
-- Name: Koltuk; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Koltuk" (
    "koltukNo" integer NOT NULL,
    "KoltukDurumNo" boolean NOT NULL
);


ALTER TABLE public."Koltuk" OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 16807)
-- Name: Koltuk_koltukNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Koltuk_koltukNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Koltuk_koltukNo_seq" OWNER TO postgres;

--
-- TOC entry 3503 (class 0 OID 0)
-- Dependencies: 240
-- Name: Koltuk_koltukNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Koltuk_koltukNo_seq" OWNED BY public."Koltuk"."koltukNo";


--
-- TOC entry 217 (class 1259 OID 16648)
-- Name: Muavin; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Muavin" (
    "tcNo" bigint NOT NULL,
    ad character varying(20) NOT NULL,
    soyad character varying(20) NOT NULL
);


ALTER TABLE public."Muavin" OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 16727)
-- Name: Musteri; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Musteri" (
    "tcNo" bigint NOT NULL,
    ad character varying(20) NOT NULL,
    soyad character varying(20) NOT NULL,
    cinsiyet character varying NOT NULL,
    "etiketNo" integer DEFAULT 1
);


ALTER TABLE public."Musteri" OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16659)
-- Name: Otobus; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Otobus" (
    "otobusNo" integer NOT NULL,
    "firmaAdi" character varying(20) NOT NULL,
    "seferSayisi" integer DEFAULT 2 NOT NULL,
    "yuzKmBenzin" integer DEFAULT 80 NOT NULL
);


ALTER TABLE public."Otobus" OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16658)
-- Name: Otobus_otobusNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Otobus_otobusNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Otobus_otobusNo_seq" OWNER TO postgres;

--
-- TOC entry 3504 (class 0 OID 0)
-- Dependencies: 218
-- Name: Otobus_otobusNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Otobus_otobusNo_seq" OWNED BY public."Otobus"."otobusNo";


--
-- TOC entry 215 (class 1259 OID 16632)
-- Name: Personel; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Personel" (
    "tcNo" bigint NOT NULL,
    "personelTipi" character varying(6) NOT NULL,
    "calismaSaati" integer DEFAULT 10 NOT NULL
);


ALTER TABLE public."Personel" OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16680)
-- Name: SatilanBilet; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."SatilanBilet" (
    "satilanBiletNo" integer NOT NULL,
    "biletNo" integer NOT NULL,
    satilanbiletsayisi integer DEFAULT 0
);


ALTER TABLE public."SatilanBilet" OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16679)
-- Name: SatilanBilet_satilanBiletNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."SatilanBilet_satilanBiletNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."SatilanBilet_satilanBiletNo_seq" OWNER TO postgres;

--
-- TOC entry 3505 (class 0 OID 0)
-- Dependencies: 224
-- Name: SatilanBilet_satilanBiletNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."SatilanBilet_satilanBiletNo_seq" OWNED BY public."SatilanBilet"."satilanBiletNo";


--
-- TOC entry 221 (class 1259 OID 16666)
-- Name: Sehir; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Sehir" (
    "sehirKodu" integer NOT NULL,
    "sehirAdi" character varying(20) NOT NULL
);


ALTER TABLE public."Sehir" OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16665)
-- Name: Sehir_sehirKodu_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Sehir_sehirKodu_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Sehir_sehirKodu_seq" OWNER TO postgres;

--
-- TOC entry 3506 (class 0 OID 0)
-- Dependencies: 220
-- Name: Sehir_sehirKodu_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Sehir_sehirKodu_seq" OWNED BY public."Sehir"."sehirKodu";


--
-- TOC entry 216 (class 1259 OID 16638)
-- Name: Sofor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Sofor" (
    "tcNo" bigint NOT NULL,
    ad character varying(20) NOT NULL,
    soyad character varying(20) NOT NULL
);


ALTER TABLE public."Sofor" OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 16716)
-- Name: Terminal; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Terminal" (
    "terminalNo" integer NOT NULL,
    "terminalAdi" character varying(20) NOT NULL
);


ALTER TABLE public."Terminal" OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 16715)
-- Name: Terminal_terminalNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Terminal_terminalNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Terminal_terminalNo_seq" OWNER TO postgres;

--
-- TOC entry 3507 (class 0 OID 0)
-- Dependencies: 230
-- Name: Terminal_terminalNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Terminal_terminalNo_seq" OWNED BY public."Terminal"."terminalNo";


--
-- TOC entry 237 (class 1259 OID 16759)
-- Name: Valiz; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Valiz" (
    "etiketNo" integer NOT NULL,
    adet integer NOT NULL
);


ALTER TABLE public."Valiz" OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 16758)
-- Name: Valiz_etiketNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Valiz_etiketNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Valiz_etiketNo_seq" OWNER TO postgres;

--
-- TOC entry 3508 (class 0 OID 0)
-- Dependencies: 236
-- Name: Valiz_etiketNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Valiz_etiketNo_seq" OWNED BY public."Valiz"."etiketNo";


--
-- TOC entry 239 (class 1259 OID 16766)
-- Name: otobusMarkasi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."otobusMarkasi" (
    "markaNo" integer NOT NULL,
    "markaAdi" character varying(20) NOT NULL,
    "otobusNo" integer NOT NULL
);


ALTER TABLE public."otobusMarkasi" OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 16765)
-- Name: otobusMarkasi_markaNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."otobusMarkasi_markaNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."otobusMarkasi_markaNo_seq" OWNER TO postgres;

--
-- TOC entry 3509 (class 0 OID 0)
-- Dependencies: 238
-- Name: otobusMarkasi_markaNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."otobusMarkasi_markaNo_seq" OWNED BY public."otobusMarkasi"."markaNo";


--
-- TOC entry 243 (class 1259 OID 32972)
-- Name: yolcular; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.yolcular (
    id integer NOT NULL,
    yolcusayisi integer
);


ALTER TABLE public.yolcular OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 32971)
-- Name: yolcular_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.yolcular_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.yolcular_id_seq OWNER TO postgres;

--
-- TOC entry 3510 (class 0 OID 0)
-- Dependencies: 242
-- Name: yolcular_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.yolcular_id_seq OWNED BY public.yolcular.id;


--
-- TOC entry 3269 (class 2604 OID 16750)
-- Name: AracYakit sirketNo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AracYakit" ALTER COLUMN "sirketNo" SET DEFAULT nextval('public."AracYakit_sirketNo_seq"'::regclass);


--
-- TOC entry 3259 (class 2604 OID 16676)
-- Name: Bilet biletNo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Bilet" ALTER COLUMN "biletNo" SET DEFAULT nextval('public."Bilet_biletNo_seq"'::regclass);


--
-- TOC entry 3264 (class 2604 OID 16690)
-- Name: Fatura faturaNo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Fatura" ALTER COLUMN "faturaNo" SET DEFAULT nextval('public."Fatura_faturaNo_seq"'::regclass);


--
-- TOC entry 3265 (class 2604 OID 16702)
-- Name: Firma firmaKodu; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Firma" ALTER COLUMN "firmaKodu" SET DEFAULT nextval('public."Firma_firmaKodu_seq"'::regclass);


--
-- TOC entry 3268 (class 2604 OID 16808)
-- Name: Koltuk koltukNo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Koltuk" ALTER COLUMN "koltukNo" SET DEFAULT nextval('public."Koltuk_koltukNo_seq"'::regclass);


--
-- TOC entry 3255 (class 2604 OID 16662)
-- Name: Otobus otobusNo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Otobus" ALTER COLUMN "otobusNo" SET DEFAULT nextval('public."Otobus_otobusNo_seq"'::regclass);


--
-- TOC entry 3262 (class 2604 OID 16683)
-- Name: SatilanBilet satilanBiletNo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."SatilanBilet" ALTER COLUMN "satilanBiletNo" SET DEFAULT nextval('public."SatilanBilet_satilanBiletNo_seq"'::regclass);


--
-- TOC entry 3258 (class 2604 OID 16669)
-- Name: Sehir sehirKodu; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Sehir" ALTER COLUMN "sehirKodu" SET DEFAULT nextval('public."Sehir_sehirKodu_seq"'::regclass);


--
-- TOC entry 3266 (class 2604 OID 16719)
-- Name: Terminal terminalNo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Terminal" ALTER COLUMN "terminalNo" SET DEFAULT nextval('public."Terminal_terminalNo_seq"'::regclass);


--
-- TOC entry 3271 (class 2604 OID 16762)
-- Name: Valiz etiketNo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Valiz" ALTER COLUMN "etiketNo" SET DEFAULT nextval('public."Valiz_etiketNo_seq"'::regclass);


--
-- TOC entry 3272 (class 2604 OID 16769)
-- Name: otobusMarkasi markaNo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."otobusMarkasi" ALTER COLUMN "markaNo" SET DEFAULT nextval('public."otobusMarkasi_markaNo_seq"'::regclass);


--
-- TOC entry 3273 (class 2604 OID 32975)
-- Name: yolcular id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.yolcular ALTER COLUMN id SET DEFAULT nextval('public.yolcular_id_seq'::regclass);


--
-- TOC entry 3483 (class 0 OID 16747)
-- Dependencies: 235
-- Data for Name: AracYakit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."AracYakit" ("sirketNo", "sirketAdi", "firmaKodu", "benzinUcret") FROM stdin;
1	GO	2	10
2	NEXT	1	10
\.


--
-- TOC entry 3471 (class 0 OID 16673)
-- Dependencies: 223
-- Data for Name: Bilet; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Bilet" ("biletNo", tarih, ucret, "firmaKodu", "gidilecekSehir", "mevcutSehir", "musteriTc", "biletSayisi") FROM stdin;
1	2022-10-10	500	1	2	1	12345678923	1
2	2022-10-10	500	1	2	1	12345678924	2
6	2022-10-10	500	1	2	1	12345678925	3
\.


--
-- TOC entry 3475 (class 0 OID 16687)
-- Dependencies: 227
-- Data for Name: Fatura; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Fatura" ("faturaNo", "kesimTarihi", "biletNo") FROM stdin;
\.


--
-- TOC entry 3477 (class 0 OID 16699)
-- Dependencies: 229
-- Data for Name: Firma; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Firma" ("firmaKodu", "firmaAdi", "personelTc", "otobusNo") FROM stdin;
2	Nilüfer	12345678919	2
1	Kontur	12345678912	1
3	KamilKoç	12345678916	3
\.


--
-- TOC entry 3481 (class 0 OID 16740)
-- Dependencies: 233
-- Data for Name: Koltuk; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Koltuk" ("koltukNo", "KoltukDurumNo") FROM stdin;
5	t
6	f
\.


--
-- TOC entry 3465 (class 0 OID 16648)
-- Dependencies: 217
-- Data for Name: Muavin; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Muavin" ("tcNo", ad, soyad) FROM stdin;
12345678914	yusuf	kahraman
12345678915	ali	altındağ
12345678917	muhammed	tekdamar
12345678918	veysel	şahin
\.


--
-- TOC entry 3480 (class 0 OID 16727)
-- Dependencies: 232
-- Data for Name: Musteri; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Musteri" ("tcNo", ad, soyad, cinsiyet, "etiketNo") FROM stdin;
12345678923	Ayşegül	Bilici	k	1
12345678924	Havva	Çiçek	k	2
12345678925	Umut	Çiçek	e	3
12345678926	Umut	Bilici	e	1
12345678927	mustafa	Biçer	e	1
\.


--
-- TOC entry 3467 (class 0 OID 16659)
-- Dependencies: 219
-- Data for Name: Otobus; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Otobus" ("otobusNo", "firmaAdi", "seferSayisi", "yuzKmBenzin") FROM stdin;
1	Kontur	2	80
3	KamilKoç	3	80
5	Anka	1	80
2	Nilüfer	2	120
4	VİB	4	100
\.


--
-- TOC entry 3463 (class 0 OID 16632)
-- Dependencies: 215
-- Data for Name: Personel; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Personel" ("tcNo", "personelTipi", "calismaSaati") FROM stdin;
12345678919	s	10
12345678917	m	10
12345678918	m	10
12345678912	s	12
12345678913	s	7
12345678914	m	3
12345678915	m	2
12345678916	s	5
\.


--
-- TOC entry 3473 (class 0 OID 16680)
-- Dependencies: 225
-- Data for Name: SatilanBilet; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."SatilanBilet" ("satilanBiletNo", "biletNo", satilanbiletsayisi) FROM stdin;
3	1	0
4	2	0
\.


--
-- TOC entry 3469 (class 0 OID 16666)
-- Dependencies: 221
-- Data for Name: Sehir; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Sehir" ("sehirKodu", "sehirAdi") FROM stdin;
1	Konya
2	Bursa
3	İstanbul
4	İzmir
5	Çanakkale
6	Sakarya
7	Niğde
8	Eskişehir
\.


--
-- TOC entry 3464 (class 0 OID 16638)
-- Dependencies: 216
-- Data for Name: Sofor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Sofor" ("tcNo", ad, soyad) FROM stdin;
12345678912	murat	çiçek
12345678913	umut	bilici
12345678916	selçuk	aydınlı
12345678919	mustafa	biçer
\.


--
-- TOC entry 3479 (class 0 OID 16716)
-- Dependencies: 231
-- Data for Name: Terminal; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Terminal" ("terminalNo", "terminalAdi") FROM stdin;
2	BursaT
3	İstanbulT
1	KonyaT
4	İzmirT
5	ÇanakkaleT
6	SakaryaT
7	NiğdeT
8	EskişehirT
\.


--
-- TOC entry 3485 (class 0 OID 16759)
-- Dependencies: 237
-- Data for Name: Valiz; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Valiz" ("etiketNo", adet) FROM stdin;
1	1
2	5
3	3
\.


--
-- TOC entry 3487 (class 0 OID 16766)
-- Dependencies: 239
-- Data for Name: otobusMarkasi; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."otobusMarkasi" ("markaNo", "markaAdi", "otobusNo") FROM stdin;
1	X	1
2	Y	2
\.


--
-- TOC entry 3491 (class 0 OID 32972)
-- Dependencies: 243
-- Data for Name: yolcular; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.yolcular (id, yolcusayisi) FROM stdin;
1	5
\.


--
-- TOC entry 3511 (class 0 OID 0)
-- Dependencies: 234
-- Name: AracYakit_sirketNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."AracYakit_sirketNo_seq"', 2, true);


--
-- TOC entry 3512 (class 0 OID 0)
-- Dependencies: 222
-- Name: Bilet_biletNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Bilet_biletNo_seq"', 6, true);


--
-- TOC entry 3513 (class 0 OID 0)
-- Dependencies: 241
-- Name: Bilet_biletSayisi_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Bilet_biletSayisi_seq"', 3, true);


--
-- TOC entry 3514 (class 0 OID 0)
-- Dependencies: 226
-- Name: Fatura_faturaNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Fatura_faturaNo_seq"', 2, true);


--
-- TOC entry 3515 (class 0 OID 0)
-- Dependencies: 228
-- Name: Firma_firmaKodu_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Firma_firmaKodu_seq"', 3, true);


--
-- TOC entry 3516 (class 0 OID 0)
-- Dependencies: 240
-- Name: Koltuk_koltukNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Koltuk_koltukNo_seq"', 6, true);


--
-- TOC entry 3517 (class 0 OID 0)
-- Dependencies: 218
-- Name: Otobus_otobusNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Otobus_otobusNo_seq"', 6, true);


--
-- TOC entry 3518 (class 0 OID 0)
-- Dependencies: 224
-- Name: SatilanBilet_satilanBiletNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."SatilanBilet_satilanBiletNo_seq"', 6, true);


--
-- TOC entry 3519 (class 0 OID 0)
-- Dependencies: 220
-- Name: Sehir_sehirKodu_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Sehir_sehirKodu_seq"', 8, true);


--
-- TOC entry 3520 (class 0 OID 0)
-- Dependencies: 230
-- Name: Terminal_terminalNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Terminal_terminalNo_seq"', 8, true);


--
-- TOC entry 3521 (class 0 OID 0)
-- Dependencies: 236
-- Name: Valiz_etiketNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Valiz_etiketNo_seq"', 3, true);


--
-- TOC entry 3522 (class 0 OID 0)
-- Dependencies: 238
-- Name: otobusMarkasi_markaNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."otobusMarkasi_markaNo_seq"', 2, true);


--
-- TOC entry 3523 (class 0 OID 0)
-- Dependencies: 242
-- Name: yolcular_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.yolcular_id_seq', 1, false);


--
-- TOC entry 3299 (class 2606 OID 16752)
-- Name: AracYakit AracYakit_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AracYakit"
    ADD CONSTRAINT "AracYakit_pkey" PRIMARY KEY ("sirketNo");


--
-- TOC entry 3285 (class 2606 OID 16678)
-- Name: Bilet Bilet_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Bilet"
    ADD CONSTRAINT "Bilet_pkey" PRIMARY KEY ("biletNo");


--
-- TOC entry 3289 (class 2606 OID 16692)
-- Name: Fatura Fatura_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Fatura"
    ADD CONSTRAINT "Fatura_pkey" PRIMARY KEY ("faturaNo");


--
-- TOC entry 3291 (class 2606 OID 16704)
-- Name: Firma Firma_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Firma"
    ADD CONSTRAINT "Firma_pkey" PRIMARY KEY ("firmaKodu");


--
-- TOC entry 3297 (class 2606 OID 16813)
-- Name: Koltuk Koltuk_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Koltuk"
    ADD CONSTRAINT "Koltuk_pkey" PRIMARY KEY ("koltukNo") INCLUDE ("koltukNo");


--
-- TOC entry 3279 (class 2606 OID 16652)
-- Name: Muavin Muavin_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Muavin"
    ADD CONSTRAINT "Muavin_pkey" PRIMARY KEY ("tcNo");


--
-- TOC entry 3295 (class 2606 OID 16733)
-- Name: Musteri Musteri_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Musteri"
    ADD CONSTRAINT "Musteri_pkey" PRIMARY KEY ("tcNo");


--
-- TOC entry 3281 (class 2606 OID 16664)
-- Name: Otobus Otobus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Otobus"
    ADD CONSTRAINT "Otobus_pkey" PRIMARY KEY ("otobusNo");


--
-- TOC entry 3275 (class 2606 OID 16636)
-- Name: Personel Personel_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Personel"
    ADD CONSTRAINT "Personel_pkey" PRIMARY KEY ("tcNo");


--
-- TOC entry 3287 (class 2606 OID 16685)
-- Name: SatilanBilet SatilanBilet_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."SatilanBilet"
    ADD CONSTRAINT "SatilanBilet_pkey" PRIMARY KEY ("satilanBiletNo");


--
-- TOC entry 3283 (class 2606 OID 16671)
-- Name: Sehir Sehir_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Sehir"
    ADD CONSTRAINT "Sehir_pkey" PRIMARY KEY ("sehirKodu");


--
-- TOC entry 3277 (class 2606 OID 16642)
-- Name: Sofor Sofor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Sofor"
    ADD CONSTRAINT "Sofor_pkey" PRIMARY KEY ("tcNo");


--
-- TOC entry 3293 (class 2606 OID 16721)
-- Name: Terminal Terminal_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Terminal"
    ADD CONSTRAINT "Terminal_pkey" PRIMARY KEY ("terminalNo");


--
-- TOC entry 3301 (class 2606 OID 16764)
-- Name: Valiz Valiz_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Valiz"
    ADD CONSTRAINT "Valiz_pkey" PRIMARY KEY ("etiketNo");


--
-- TOC entry 3303 (class 2606 OID 16771)
-- Name: otobusMarkasi otobusMarkasi_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."otobusMarkasi"
    ADD CONSTRAINT "otobusMarkasi_pkey" PRIMARY KEY ("markaNo");


--
-- TOC entry 3318 (class 2620 OID 32987)
-- Name: SatilanBilet bilettartis; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER bilettartis AFTER INSERT ON public."SatilanBilet" FOR EACH ROW EXECUTE FUNCTION public.bilettartis();


--
-- TOC entry 3317 (class 2620 OID 32986)
-- Name: Bilet satilanbiletartis; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER satilanbiletartis AFTER INSERT ON public."Bilet" FOR EACH ROW EXECUTE FUNCTION public.satilanbiletartis();


--
-- TOC entry 3319 (class 2620 OID 32984)
-- Name: Musteri yolcucikarma; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER yolcucikarma AFTER DELETE ON public."Musteri" FOR EACH ROW EXECUTE FUNCTION public.yolcucikarma();


--
-- TOC entry 3320 (class 2620 OID 32985)
-- Name: Musteri yolcuekleme; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER yolcuekleme AFTER INSERT ON public."Musteri" FOR EACH ROW EXECUTE FUNCTION public.yolcuekleme();


--
-- TOC entry 3306 (class 2606 OID 16828)
-- Name: Bilet Bilet_gidilecekSehir_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Bilet"
    ADD CONSTRAINT "Bilet_gidilecekSehir_fkey" FOREIGN KEY ("gidilecekSehir") REFERENCES public."Sehir"("sehirKodu") ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3307 (class 2606 OID 16833)
-- Name: Bilet Bilet_mevcutSehir_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Bilet"
    ADD CONSTRAINT "Bilet_mevcutSehir_fkey" FOREIGN KEY ("mevcutSehir") REFERENCES public."Sehir"("sehirKodu") ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3311 (class 2606 OID 16693)
-- Name: Fatura biletNo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Fatura"
    ADD CONSTRAINT "biletNo" FOREIGN KEY ("biletNo") REFERENCES public."Bilet"("biletNo") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3310 (class 2606 OID 16802)
-- Name: SatilanBilet biletNo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."SatilanBilet"
    ADD CONSTRAINT "biletNo" FOREIGN KEY ("biletNo") REFERENCES public."Bilet"("biletNo") ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3314 (class 2606 OID 16787)
-- Name: Musteri etiketNo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Musteri"
    ADD CONSTRAINT "etiketNo" FOREIGN KEY ("etiketNo") REFERENCES public."Valiz"("etiketNo") ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3315 (class 2606 OID 16753)
-- Name: AracYakit firmaKodu; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AracYakit"
    ADD CONSTRAINT "firmaKodu" FOREIGN KEY ("firmaKodu") REFERENCES public."Firma"("firmaKodu") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3308 (class 2606 OID 16777)
-- Name: Bilet firmaKodu; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Bilet"
    ADD CONSTRAINT "firmaKodu" FOREIGN KEY ("firmaKodu") REFERENCES public."Firma"("firmaKodu") ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3309 (class 2606 OID 16850)
-- Name: Bilet musteriTc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Bilet"
    ADD CONSTRAINT "musteriTc" FOREIGN KEY ("musteriTc") REFERENCES public."Musteri"("tcNo") ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3312 (class 2606 OID 16710)
-- Name: Firma otobusNo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Firma"
    ADD CONSTRAINT "otobusNo" FOREIGN KEY ("otobusNo") REFERENCES public."Otobus"("otobusNo") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3316 (class 2606 OID 16772)
-- Name: otobusMarkasi otobusNo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."otobusMarkasi"
    ADD CONSTRAINT "otobusNo" FOREIGN KEY ("otobusNo") REFERENCES public."Otobus"("otobusNo") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3313 (class 2606 OID 16705)
-- Name: Firma personelTc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Firma"
    ADD CONSTRAINT "personelTc" FOREIGN KEY ("personelTc") REFERENCES public."Personel"("tcNo") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3304 (class 2606 OID 16643)
-- Name: Sofor tcNo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Sofor"
    ADD CONSTRAINT "tcNo" FOREIGN KEY ("tcNo") REFERENCES public."Personel"("tcNo") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3305 (class 2606 OID 16653)
-- Name: Muavin tcNo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Muavin"
    ADD CONSTRAINT "tcNo" FOREIGN KEY ("tcNo") REFERENCES public."Personel"("tcNo") ON UPDATE CASCADE ON DELETE CASCADE;


-- Completed on 2022-12-27 20:01:33

--
-- PostgreSQL database dump complete
--

