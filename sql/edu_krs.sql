--
-- PostgreSQL database dump
--

-- Dumped from database version 9.1.10
-- Dumped by pg_dump version 9.1.10
-- Started on 2013-11-12 15:39:16 BRST

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 212 (class 3079 OID 11679)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2379 (class 0 OID 0)
-- Dependencies: 212
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_with_oids = false;

--
-- TOC entry 161 (class 1259 OID 16385)
-- Dependencies: 1943 1944 1945 1946 1947 5
-- Name: abas; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE abas (
    seq integer NOT NULL,
    abaid character varying(30) NOT NULL,
    nomeaba character varying(40),
    obapendice character varying(110) DEFAULT '-'::character varying,
    action character varying(200) DEFAULT '-'::character varying,
    impressao character(1) DEFAULT '0'::bpchar,
    ordem bigint DEFAULT 0,
    usuaseq bigint NOT NULL,
    unidseq bigint NOT NULL,
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    statseq bigint NOT NULL
);


--
-- TOC entry 162 (class 1259 OID 16393)
-- Dependencies: 5 161
-- Name: abas_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE abas_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2380 (class 0 OID 0)
-- Dependencies: 162
-- Name: abas_seq_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE abas_seq_seq OWNED BY abas.seq;


--
-- TOC entry 163 (class 1259 OID 16395)
-- Dependencies: 1949 1950 1951 5
-- Name: blocos; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE blocos (
    seq integer NOT NULL,
    blocoid character varying(50) NOT NULL,
    nomebloco character varying(50),
    formato character(3),
    tabseq bigint NOT NULL,
    blocoheight character varying(10) DEFAULT '200px'::character varying,
    statseq bigint DEFAULT 1 NOT NULL,
    formseq bigint,
    obapendice character varying(120),
    frmpseq bigint,
    usuaseq bigint NOT NULL,
    unidseq bigint NOT NULL,
    datacad date DEFAULT ('now'::text)::date NOT NULL
);


--
-- TOC entry 164 (class 1259 OID 16401)
-- Dependencies: 5 163
-- Name: blocos_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE blocos_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2381 (class 0 OID 0)
-- Dependencies: 164
-- Name: blocos_seq_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE blocos_seq_seq OWNED BY blocos.seq;


--
-- TOC entry 165 (class 1259 OID 16403)
-- Dependencies: 1953 1954 5
-- Name: blocos_x_abas; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE blocos_x_abas (
    seq integer NOT NULL,
    abaseq bigint NOT NULL,
    blocseq integer NOT NULL,
    ordem bigint DEFAULT 1,
    usuaseq bigint NOT NULL,
    unidseq bigint NOT NULL,
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    statseq bigint NOT NULL
);


--
-- TOC entry 166 (class 1259 OID 16408)
-- Dependencies: 5 165
-- Name: blocos_x_abas_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE blocos_x_abas_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2382 (class 0 OID 0)
-- Dependencies: 166
-- Name: blocos_x_abas_seq_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE blocos_x_abas_seq_seq OWNED BY blocos_x_abas.seq;


--
-- TOC entry 167 (class 1259 OID 16410)
-- Dependencies: 1956 1957 1958 1959 1960 1961 1962 1963 1964 5
-- Name: campos; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE campos (
    seq integer NOT NULL,
    colunadb character varying(255) NOT NULL,
    campo character varying(80) NOT NULL,
    label character varying(50),
    mascara character varying(150),
    seletor text,
    tpcaseq bigint NOT NULL,
    tabseq bigint DEFAULT 0 NOT NULL,
    ativafunction bigint DEFAULT 0 NOT NULL,
    ativapesquisa bigint DEFAULT 0 NOT NULL,
    valorpadrao character varying(200) DEFAULT '-'::character varying,
    outcontrol text,
    incontrol text,
    trigger character varying(150),
    help text,
    statseq bigint DEFAULT 1 NOT NULL,
    required bigint DEFAULT 0,
    alteravel bigint DEFAULT 1,
    autosave character varying(1) DEFAULT '0'::character varying,
    manter boolean,
    usuaseq bigint NOT NULL,
    unidseq bigint NOT NULL,
    datacad date DEFAULT ('now'::text)::date NOT NULL
);


--
-- TOC entry 168 (class 1259 OID 16425)
-- Dependencies: 5 167
-- Name: campos_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE campos_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2383 (class 0 OID 0)
-- Dependencies: 168
-- Name: campos_seq_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE campos_seq_seq OWNED BY campos.seq;


--
-- TOC entry 169 (class 1259 OID 16427)
-- Dependencies: 1966 1967 5
-- Name: campos_x_blocos; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE campos_x_blocos (
    seq integer NOT NULL,
    blocseq bigint NOT NULL,
    campseq bigint NOT NULL,
    mostrarcampo character(1),
    formato character(3),
    ordem bigint DEFAULT 0 NOT NULL,
    usuaseq bigint NOT NULL,
    unidseq bigint NOT NULL,
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    statseq bigint NOT NULL
);


--
-- TOC entry 170 (class 1259 OID 16432)
-- Dependencies: 5 169
-- Name: campos_x_blocos_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE campos_x_blocos_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2384 (class 0 OID 0)
-- Dependencies: 170
-- Name: campos_x_blocos_seq_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE campos_x_blocos_seq_seq OWNED BY campos_x_blocos.seq;


--
-- TOC entry 171 (class 1259 OID 16434)
-- Dependencies: 1969 1970 5
-- Name: campos_x_propriedades; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE campos_x_propriedades (
    seq integer NOT NULL,
    campseq bigint NOT NULL,
    metodo character varying(30) NOT NULL,
    valor text NOT NULL,
    statseq bigint DEFAULT 1 NOT NULL,
    usuaseq bigint NOT NULL,
    unidseq bigint NOT NULL,
    datacad date DEFAULT ('now'::text)::date NOT NULL
);


--
-- TOC entry 172 (class 1259 OID 16442)
-- Dependencies: 5 171
-- Name: campos_x_propriedades_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE campos_x_propriedades_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2385 (class 0 OID 0)
-- Dependencies: 172
-- Name: campos_x_propriedades_seq_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE campos_x_propriedades_seq_seq OWNED BY campos_x_propriedades.seq;


--
-- TOC entry 173 (class 1259 OID 16444)
-- Dependencies: 1972 1973 1974 1975 1976 1977 1978 1979 5
-- Name: coluna; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE coluna (
    seq integer NOT NULL,
    listseq bigint NOT NULL,
    coluna character varying(60) NOT NULL,
    label character varying(60) NOT NULL,
    alinhalabel character varying(30),
    alinhadados character varying(30),
    largura bigint,
    colfunction character varying(80) DEFAULT '-'::character varying,
    valorpadrao character varying(110) DEFAULT '0'::character varying,
    tipocoluna bigint DEFAULT 1,
    tabseq bigint NOT NULL,
    colunaaux character varying(60) DEFAULT '-'::character varying,
    link character varying(255) DEFAULT '0'::character varying,
    ordem bigint DEFAULT 0 NOT NULL,
    statseq bigint DEFAULT 1 NOT NULL,
    usuaseq bigint NOT NULL,
    unidseq bigint NOT NULL,
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    tipodado character varying(40)
);


--
-- TOC entry 174 (class 1259 OID 16458)
-- Dependencies: 5 173
-- Name: coluna_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE coluna_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2386 (class 0 OID 0)
-- Dependencies: 174
-- Name: coluna_seq_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE coluna_seq_seq OWNED BY coluna.seq;


--
-- TOC entry 175 (class 1259 OID 16460)
-- Dependencies: 1981 1982 1983 1984 1985 1986 1987 5
-- Name: dbpessoa; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbpessoa (
    seq integer NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq bigint DEFAULT 0,
    tipo character(1) DEFAULT 'F'::bpchar,
    pessnmrz character varying(160),
    pessnmrf numeric(14,0) NOT NULL,
    pessrgie character varying(20),
    pessteim character varying(20),
    cliente character varying(1) DEFAULT '0'::character varying,
    fornecedor character varying(1) DEFAULT '0'::character varying,
    funcionario character varying(1) DEFAULT '0'::character varying,
    datacad date DEFAULT ('now'::text)::date,
    foto text,
    statseq bigint DEFAULT 9 NOT NULL
);


--
-- TOC entry 176 (class 1259 OID 16473)
-- Dependencies: 5 175
-- Name: dbpessoa_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbpessoa_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2387 (class 0 OID 0)
-- Dependencies: 176
-- Name: dbpessoa_seq_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dbpessoa_seq_seq OWNED BY dbpessoa.seq;


--
-- TOC entry 177 (class 1259 OID 16475)
-- Dependencies: 1989 1990 5
-- Name: dbstatus; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbstatus (
    seq integer NOT NULL,
    unidseq bigint,
    usuaseq bigint,
    statdesc character varying(80),
    datacad date DEFAULT ('now'::text)::date,
    statseq bigint DEFAULT 9
);


--
-- TOC entry 178 (class 1259 OID 16480)
-- Dependencies: 177 5
-- Name: dbstatus_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbstatus_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2388 (class 0 OID 0)
-- Dependencies: 178
-- Name: dbstatus_seq_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dbstatus_seq_seq OWNED BY dbstatus.seq;


--
-- TOC entry 179 (class 1259 OID 16482)
-- Dependencies: 1992 1993 5
-- Name: dbunidade; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbunidade (
    seq integer NOT NULL,
    unidseq bigint,
    usuaseq bigint,
    nomeunidade character varying(80),
    razaosocial character varying(180),
    cnpj character varying(20),
    inscestadual character varying(20),
    inscmunicipal character varying(20),
    gerente character varying(120),
    diretor character varying(120),
    representante character varying(120),
    logradouro character varying(80),
    bairro character varying(60),
    cidade character varying(60),
    estado character varying(2),
    cep character varying(12),
    email character varying(255),
    telefone character varying(20),
    datacad date DEFAULT ('now'::text)::date,
    statseq bigint DEFAULT 1 NOT NULL
);


--
-- TOC entry 180 (class 1259 OID 16490)
-- Dependencies: 1995 1996 1997 5
-- Name: dbunidade_parametro; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbunidade_parametro (
    seq integer NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq bigint DEFAULT 0 NOT NULL,
    parametro character varying(60) NOT NULL,
    valor character varying(180) NOT NULL,
    obs text,
    datacad date DEFAULT ('now'::text)::date,
    statseq bigint DEFAULT 1 NOT NULL
);


--
-- TOC entry 181 (class 1259 OID 16499)
-- Dependencies: 5 180
-- Name: dbunidade_parametro_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbunidade_parametro_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2389 (class 0 OID 0)
-- Dependencies: 181
-- Name: dbunidade_parametro_seq_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dbunidade_parametro_seq_seq OWNED BY dbunidade_parametro.seq;


--
-- TOC entry 182 (class 1259 OID 16501)
-- Dependencies: 5 179
-- Name: dbunidade_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbunidade_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2390 (class 0 OID 0)
-- Dependencies: 182
-- Name: dbunidade_seq_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dbunidade_seq_seq OWNED BY dbunidade.seq;


--
-- TOC entry 183 (class 1259 OID 16503)
-- Dependencies: 1999 2000 2001 2002 5
-- Name: dbusuario; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbusuario (
    seq integer NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq bigint,
    classeuser bigint,
    pessseq bigint NOT NULL,
    usuario character varying(80) DEFAULT "current_user"() NOT NULL,
    senha character varying(60),
    entidadepai character varying(30),
    temaseq bigint DEFAULT 0,
    datacad date DEFAULT ('now'::text)::date,
    lastip character varying(80),
    lastaccess character varying(30),
    lastpass character varying(30),
    statseq bigint DEFAULT 1 NOT NULL
);


--
-- TOC entry 184 (class 1259 OID 16510)
-- Dependencies: 2004 2005 2006 2007 2008 5
-- Name: dbusuario_privilegio; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbusuario_privilegio (
    seq integer NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq bigint DEFAULT 0 NOT NULL,
    funcionalidade bigint DEFAULT 0 NOT NULL,
    modulo bigint NOT NULL,
    nivel bigint DEFAULT 0 NOT NULL,
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    statseq bigint DEFAULT 1 NOT NULL
);


--
-- TOC entry 185 (class 1259 OID 16518)
-- Dependencies: 5 184
-- Name: dbusuario_privilegio_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbusuario_privilegio_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2391 (class 0 OID 0)
-- Dependencies: 185
-- Name: dbusuario_privilegio_seq_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dbusuario_privilegio_seq_seq OWNED BY dbusuario_privilegio.seq;


--
-- TOC entry 186 (class 1259 OID 16520)
-- Dependencies: 183 5
-- Name: dbusuario_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbusuario_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2392 (class 0 OID 0)
-- Dependencies: 186
-- Name: dbusuario_seq_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dbusuario_seq_seq OWNED BY dbusuario.seq;


--
-- TOC entry 187 (class 1259 OID 16522)
-- Dependencies: 2010 2011 5
-- Name: form_button; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE form_button (
    seq integer NOT NULL,
    formseq bigint NOT NULL,
    botao character varying(60),
    labelbotao character varying(80),
    confirmacao character varying(255),
    actionjs character varying(120),
    metodo character varying(80),
    ordem character(2),
    statseq bigint DEFAULT 1 NOT NULL,
    usuaseq bigint NOT NULL,
    unidseq bigint NOT NULL,
    datacad date DEFAULT ('now'::text)::date NOT NULL
);


--
-- TOC entry 188 (class 1259 OID 16530)
-- Dependencies: 187 5
-- Name: form_button_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE form_button_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2393 (class 0 OID 0)
-- Dependencies: 188
-- Name: form_button_seq_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE form_button_seq_seq OWNED BY form_button.seq;


--
-- TOC entry 189 (class 1259 OID 16532)
-- Dependencies: 5
-- Name: form_list_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE form_list_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 190 (class 1259 OID 16534)
-- Dependencies: 2013 5
-- Name: form_validacao; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE form_validacao (
    seq integer NOT NULL,
    formseq bigint NOT NULL,
    usuaseq bigint NOT NULL,
    unidseq bigint NOT NULL,
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    statseq bigint NOT NULL
);


--
-- TOC entry 191 (class 1259 OID 16538)
-- Dependencies: 5 190
-- Name: form_validacao_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE form_validacao_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2394 (class 0 OID 0)
-- Dependencies: 191
-- Name: form_validacao_seq_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE form_validacao_seq_seq OWNED BY form_validacao.seq;


--
-- TOC entry 192 (class 1259 OID 16540)
-- Dependencies: 2015 2016 2017 5
-- Name: form_x_abas; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE form_x_abas (
    seq integer NOT NULL,
    formseq bigint NOT NULL,
    abaseq bigint NOT NULL,
    statseq bigint DEFAULT 1 NOT NULL,
    ordem bigint DEFAULT 0,
    usuaseq bigint NOT NULL,
    unidseq bigint NOT NULL,
    datacad date DEFAULT ('now'::text)::date NOT NULL
);


--
-- TOC entry 193 (class 1259 OID 16546)
-- Dependencies: 5 192
-- Name: form_x_abas_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE form_x_abas_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2395 (class 0 OID 0)
-- Dependencies: 193
-- Name: form_x_abas_seq_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE form_x_abas_seq_seq OWNED BY form_x_abas.seq;


--
-- TOC entry 194 (class 1259 OID 16548)
-- Dependencies: 2019 2020 5
-- Name: form_x_tabelas; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE form_x_tabelas (
    seq integer NOT NULL,
    formseq bigint NOT NULL,
    tabseq bigint NOT NULL,
    statseq bigint DEFAULT 1 NOT NULL,
    usuaseq bigint NOT NULL,
    unidseq bigint NOT NULL,
    datacad date DEFAULT ('now'::text)::date NOT NULL
);


--
-- TOC entry 195 (class 1259 OID 16553)
-- Dependencies: 5 194
-- Name: form_x_tabelas_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE form_x_tabelas_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2396 (class 0 OID 0)
-- Dependencies: 195
-- Name: form_x_tabelas_seq_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE form_x_tabelas_seq_seq OWNED BY form_x_tabelas.seq;


--
-- TOC entry 196 (class 1259 OID 16555)
-- Dependencies: 2022 2023 2024 2025 2026 2027 2028 2029 5
-- Name: forms; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE forms (
    seq bigint DEFAULT nextval('form_list_seq_seq'::regclass) NOT NULL,
    formid character varying(50) NOT NULL,
    nomeform character varying(60),
    tabseq bigint NOT NULL,
    statseq bigint DEFAULT 1 NOT NULL,
    formseq bigint,
    listseq bigint,
    formainclude character varying(30) DEFAULT 'one'::character varying,
    dimensao character varying(10),
    botconcluir character varying(40) DEFAULT '0'::character varying NOT NULL,
    botcancelar character varying(1) DEFAULT '0'::character varying NOT NULL,
    formoutcontrol character varying(200) DEFAULT '0'::character varying,
    autosave character varying(1) DEFAULT '1'::character varying NOT NULL,
    nivel bigint,
    usuaseq bigint NOT NULL,
    unidseq bigint NOT NULL,
    datacad date DEFAULT ('now'::text)::date NOT NULL
);


--
-- TOC entry 197 (class 1259 OID 16566)
-- Dependencies: 2030 2031 2032 2033 2034 2035 2036 2037 2038 2039 2040 2041 2042 2043 5
-- Name: lista; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE lista (
    seq bigint DEFAULT nextval('form_list_seq_seq'::regclass) NOT NULL,
    tipo character varying(20),
    formseq bigint NOT NULL,
    filtropai character varying(65) DEFAULT '0'::character varying,
    pesquisa text NOT NULL,
    lista character varying(40) NOT NULL,
    label character varying(60),
    tabseq bigint NOT NULL,
    listseq bigint DEFAULT 0 NOT NULL,
    obapendice character varying(120) DEFAULT '-'::character varying,
    acfiltro character(1),
    acincluir character varying(40) DEFAULT '0'::character varying,
    nivel bigint,
    acdeletar character(1),
    aceditar character(1),
    acviews character(1),
    acenviar character varying(200) DEFAULT '0'::character varying,
    filtro text DEFAULT 'statseq/!=/AND/9'::text,
    trigger character varying(120),
    formainclude character varying(10) DEFAULT 'one'::character varying,
    incontrol text,
    acreplicar character(1) DEFAULT '0'::bpchar,
    acselecao character varying(2) DEFAULT '0'::character varying,
    ordem character varying(250) DEFAULT 'datacad/desc;id/desc'::character varying,
    aclimite character varying(1) DEFAULT '1'::character varying,
    required boolean,
    usuaseq bigint NOT NULL,
    unidseq bigint NOT NULL,
    statseq bigint DEFAULT 1 NOT NULL,
    datacad date DEFAULT ('now'::text)::date NOT NULL
);


--
-- TOC entry 198 (class 1259 OID 16586)
-- Dependencies: 2044 2045 2046 2047 2048 2049 2050 2051 2052 5
-- Name: lista_actions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE lista_actions (
    seq integer NOT NULL,
    listseq bigint DEFAULT 0 NOT NULL,
    tipocampo character varying(40),
    nameaction character varying(60) DEFAULT '-'::character varying,
    label character varying(40) DEFAULT '-'::character varying,
    actionjs character varying(110) DEFAULT '-'::character varying,
    metodoexe character varying(60),
    confirm character varying(200),
    campoparam character varying(30) DEFAULT '-'::character varying,
    img character varying(250) DEFAULT '-'::character varying,
    ordem bigint DEFAULT 0 NOT NULL,
    statseq bigint DEFAULT 1 NOT NULL,
    tiporetorno character varying(6),
    usuaseq bigint NOT NULL,
    unidseq bigint NOT NULL,
    datacad date DEFAULT ('now'::text)::date NOT NULL
);


--
-- TOC entry 199 (class 1259 OID 16601)
-- Dependencies: 198 5
-- Name: lista_actions_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE lista_actions_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2397 (class 0 OID 0)
-- Dependencies: 199
-- Name: lista_actions_seq_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE lista_actions_seq_seq OWNED BY lista_actions.seq;


--
-- TOC entry 200 (class 1259 OID 16603)
-- Dependencies: 2054 2055 5
-- Name: lista_bnav; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE lista_bnav (
    seq integer NOT NULL,
    listseq bigint NOT NULL,
    nome character varying(40),
    tipocampo character varying(30),
    label character varying(60),
    metodo character varying(40),
    funcaojs character varying(50),
    argumento character varying DEFAULT '0'::character varying,
    usuaseq bigint NOT NULL,
    unidseq bigint NOT NULL,
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    statseq bigint NOT NULL
);


--
-- TOC entry 201 (class 1259 OID 16611)
-- Dependencies: 200 5
-- Name: lista_bnav_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE lista_bnav_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2398 (class 0 OID 0)
-- Dependencies: 201
-- Name: lista_bnav_seq_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE lista_bnav_seq_seq OWNED BY lista_bnav.seq;


--
-- TOC entry 202 (class 1259 OID 16613)
-- Dependencies: 2057 2058 2059 2060 5
-- Name: lista_fields; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE lista_fields (
    seq integer NOT NULL,
    listseq bigint,
    nomecol character varying(70) DEFAULT '-'::character varying,
    labelcol character varying(60),
    campseq bigint,
    ordem bigint DEFAULT 0 NOT NULL,
    statseq bigint DEFAULT 1,
    usuaseq bigint,
    unidseq bigint,
    datacad date DEFAULT ('now'::text)::date
);


--
-- TOC entry 203 (class 1259 OID 16620)
-- Dependencies: 202 5
-- Name: lista_fields_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE lista_fields_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2399 (class 0 OID 0)
-- Dependencies: 203
-- Name: lista_fields_seq_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE lista_fields_seq_seq OWNED BY lista_fields.seq;


--
-- TOC entry 204 (class 1259 OID 16622)
-- Dependencies: 2062 2063 2064 2065 2066 5
-- Name: menu; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE menu (
    seq integer NOT NULL,
    modulo character varying(80),
    labelmodulo character varying(80) NOT NULL,
    metodo character varying(255) DEFAULT '-'::character varying NOT NULL,
    argumento bigint DEFAULT 0 NOT NULL,
    formseq bigint NOT NULL,
    nivel character varying(6),
    modseq bigint NOT NULL,
    ordem bigint DEFAULT 0,
    statseq bigint DEFAULT 1 NOT NULL,
    usuaseq bigint NOT NULL,
    unidseq bigint NOT NULL,
    datacad date DEFAULT ('now'::text)::date NOT NULL
);


--
-- TOC entry 205 (class 1259 OID 16630)
-- Dependencies: 5 204
-- Name: menu_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE menu_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2400 (class 0 OID 0)
-- Dependencies: 205
-- Name: menu_seq_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE menu_seq_seq OWNED BY menu.seq;


--
-- TOC entry 206 (class 1259 OID 16632)
-- Dependencies: 2068 2069 2070 5
-- Name: modulo; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE modulo (
    seq integer NOT NULL,
    modulo character varying(60) NOT NULL,
    labelmodulo character varying(80) NOT NULL,
    nivel bigint,
    ordem bigint DEFAULT 0,
    statseq bigint DEFAULT 1 NOT NULL,
    usuaseq bigint NOT NULL,
    unidseq bigint NOT NULL,
    datacad date DEFAULT ('now'::text)::date NOT NULL
);


--
-- TOC entry 207 (class 1259 OID 16638)
-- Dependencies: 5 206
-- Name: modulo_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE modulo_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2401 (class 0 OID 0)
-- Dependencies: 207
-- Name: modulo_seq_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE modulo_seq_seq OWNED BY modulo.seq;


--
-- TOC entry 208 (class 1259 OID 16640)
-- Dependencies: 2072 2073 2074 5
-- Name: tabelas; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE tabelas (
    seq integer NOT NULL,
    tabela character varying(120) NOT NULL,
    tabela_view character varying(120) DEFAULT '-'::character varying,
    tabseq bigint,
    statseq bigint DEFAULT 1 NOT NULL,
    colunafilho character varying(40) NOT NULL,
    usuaseq bigint NOT NULL,
    unidseq bigint NOT NULL,
    datacad date DEFAULT ('now'::text)::date NOT NULL
);


--
-- TOC entry 209 (class 1259 OID 16646)
-- Dependencies: 208 5
-- Name: tabelas_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE tabelas_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2402 (class 0 OID 0)
-- Dependencies: 209
-- Name: tabelas_seq_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE tabelas_seq_seq OWNED BY tabelas.seq;


--
-- TOC entry 210 (class 1259 OID 16648)
-- Dependencies: 2076 5
-- Name: tipo_campo; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE tipo_campo (
    seq integer NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq bigint NOT NULL,
    tpcadesc character varying(40) NOT NULL,
    tipodado character varying(20),
    statseq bigint NOT NULL,
    datacad date DEFAULT ('now'::text)::date NOT NULL
);


--
-- TOC entry 211 (class 1259 OID 16652)
-- Dependencies: 5 210
-- Name: tipo_campo_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE tipo_campo_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2403 (class 0 OID 0)
-- Dependencies: 211
-- Name: tipo_campo_seq_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE tipo_campo_seq_seq OWNED BY tipo_campo.seq;


--
-- TOC entry 1948 (class 2604 OID 16654)
-- Dependencies: 162 161
-- Name: seq; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY abas ALTER COLUMN seq SET DEFAULT nextval('abas_seq_seq'::regclass);


--
-- TOC entry 1952 (class 2604 OID 16655)
-- Dependencies: 164 163
-- Name: seq; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY blocos ALTER COLUMN seq SET DEFAULT nextval('blocos_seq_seq'::regclass);


--
-- TOC entry 1955 (class 2604 OID 16656)
-- Dependencies: 166 165
-- Name: seq; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY blocos_x_abas ALTER COLUMN seq SET DEFAULT nextval('blocos_x_abas_seq_seq'::regclass);


--
-- TOC entry 1965 (class 2604 OID 16657)
-- Dependencies: 168 167
-- Name: seq; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY campos ALTER COLUMN seq SET DEFAULT nextval('campos_seq_seq'::regclass);


--
-- TOC entry 1968 (class 2604 OID 16658)
-- Dependencies: 170 169
-- Name: seq; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY campos_x_blocos ALTER COLUMN seq SET DEFAULT nextval('campos_x_blocos_seq_seq'::regclass);


--
-- TOC entry 1971 (class 2604 OID 16659)
-- Dependencies: 172 171
-- Name: seq; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY campos_x_propriedades ALTER COLUMN seq SET DEFAULT nextval('campos_x_propriedades_seq_seq'::regclass);


--
-- TOC entry 1980 (class 2604 OID 16660)
-- Dependencies: 174 173
-- Name: seq; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY coluna ALTER COLUMN seq SET DEFAULT nextval('coluna_seq_seq'::regclass);


--
-- TOC entry 1988 (class 2604 OID 16661)
-- Dependencies: 176 175
-- Name: seq; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoa ALTER COLUMN seq SET DEFAULT nextval('dbpessoa_seq_seq'::regclass);


--
-- TOC entry 1991 (class 2604 OID 16662)
-- Dependencies: 178 177
-- Name: seq; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbstatus ALTER COLUMN seq SET DEFAULT nextval('dbstatus_seq_seq'::regclass);


--
-- TOC entry 1994 (class 2604 OID 16663)
-- Dependencies: 182 179
-- Name: seq; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbunidade ALTER COLUMN seq SET DEFAULT nextval('dbunidade_seq_seq'::regclass);


--
-- TOC entry 1998 (class 2604 OID 16664)
-- Dependencies: 181 180
-- Name: seq; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbunidade_parametro ALTER COLUMN seq SET DEFAULT nextval('dbunidade_parametro_seq_seq'::regclass);


--
-- TOC entry 2003 (class 2604 OID 16665)
-- Dependencies: 186 183
-- Name: seq; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbusuario ALTER COLUMN seq SET DEFAULT nextval('dbusuario_seq_seq'::regclass);


--
-- TOC entry 2009 (class 2604 OID 16666)
-- Dependencies: 185 184
-- Name: seq; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbusuario_privilegio ALTER COLUMN seq SET DEFAULT nextval('dbusuario_privilegio_seq_seq'::regclass);


--
-- TOC entry 2012 (class 2604 OID 16667)
-- Dependencies: 188 187
-- Name: seq; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY form_button ALTER COLUMN seq SET DEFAULT nextval('form_button_seq_seq'::regclass);


--
-- TOC entry 2014 (class 2604 OID 16668)
-- Dependencies: 191 190
-- Name: seq; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY form_validacao ALTER COLUMN seq SET DEFAULT nextval('form_validacao_seq_seq'::regclass);


--
-- TOC entry 2018 (class 2604 OID 16669)
-- Dependencies: 193 192
-- Name: seq; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY form_x_abas ALTER COLUMN seq SET DEFAULT nextval('form_x_abas_seq_seq'::regclass);


--
-- TOC entry 2021 (class 2604 OID 16670)
-- Dependencies: 195 194
-- Name: seq; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY form_x_tabelas ALTER COLUMN seq SET DEFAULT nextval('form_x_tabelas_seq_seq'::regclass);


--
-- TOC entry 2053 (class 2604 OID 16671)
-- Dependencies: 199 198
-- Name: seq; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY lista_actions ALTER COLUMN seq SET DEFAULT nextval('lista_actions_seq_seq'::regclass);


--
-- TOC entry 2056 (class 2604 OID 16672)
-- Dependencies: 201 200
-- Name: seq; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY lista_bnav ALTER COLUMN seq SET DEFAULT nextval('lista_bnav_seq_seq'::regclass);


--
-- TOC entry 2061 (class 2604 OID 16673)
-- Dependencies: 203 202
-- Name: seq; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY lista_fields ALTER COLUMN seq SET DEFAULT nextval('lista_fields_seq_seq'::regclass);


--
-- TOC entry 2067 (class 2604 OID 16674)
-- Dependencies: 205 204
-- Name: seq; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY menu ALTER COLUMN seq SET DEFAULT nextval('menu_seq_seq'::regclass);


--
-- TOC entry 2071 (class 2604 OID 16675)
-- Dependencies: 207 206
-- Name: seq; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY modulo ALTER COLUMN seq SET DEFAULT nextval('modulo_seq_seq'::regclass);


--
-- TOC entry 2075 (class 2604 OID 16676)
-- Dependencies: 209 208
-- Name: seq; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY tabelas ALTER COLUMN seq SET DEFAULT nextval('tabelas_seq_seq'::regclass);


--
-- TOC entry 2077 (class 2604 OID 16677)
-- Dependencies: 211 210
-- Name: seq; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY tipo_campo ALTER COLUMN seq SET DEFAULT nextval('tipo_campo_seq_seq'::regclass);


--
-- TOC entry 2322 (class 0 OID 16385)
-- Dependencies: 161 2373
-- Data for Name: abas; Type: TABLE DATA; Schema: public; Owner: -
--

COPY abas (seq, abaid, nomeaba, obapendice, action, impressao, ordem, usuaseq, unidseq, datacad, statseq) FROM stdin;
21	disciplinas	Disciplinas	-	-	1	0	1	1	1900-01-01	1
22	dadosPessoais	Dados Pessoais	-	-	1	0	1	1	1900-01-01	1
23	dadosPrincipais	Dados Principais	-	-	1	0	1	1	1900-01-01	1
24	dados	Dados	-	-	1	0	1	1	1900-01-01	1
26	gerenciamentoDuplicata	Gerenciar Duplicatas	-	-	1	0	1	1	1900-01-01	1
27	obs	Observações	-	-	1	0	1	1	1900-01-01	1
28	infoConta	Conta caixa	-	-	1	0	1	1	1900-01-01	1
29	dadosConta	Dados da Conta	-	-	1	0	1	1	1900-01-01	1
30	dadosCredito	Dados do Crédito	-	-	1	0	1	1	1900-01-01	1
35	abaContasCaixa	Contas Caixa	-	-	1	0	1	1	1900-01-01	1
37	infoUsuarios	Informações de acesso	-	-	1	0	1	1	1900-01-01	1
39	discAvaliacao	Avaliações	-	-	1	0	1	1	1900-01-01	1
42	cargo	Informações do Cargo	-	-	1	0	1	1	1900-01-01	1
43	dado	Dados Pessoais	-	-	1	0	1	1	1900-01-01	1
44	formacao	Formação	-	-	1	0	1	1	1900-01-01	1
45	dadosPessoais	Dados Pessoais	-	-	1	0	1	1	1900-01-01	1
46	dadosComplementares	Dados Complementares	-	-	1	0	1	1	1900-01-01	1
47	patrimonios	Patrimonios	-	-	1	0	1	1	1900-01-01	1
48	conhecimentos	Competências	-	-	1	0	1	1	1900-01-01	1
49	hierarquia	Hierarquia	-	-	1	0	1	1	1900-01-01	1
50	treinamento	Treinamento	-	-	1	0	1	1	1900-01-01	1
52	atributos	Atributos	-	-	1	0	1	1	1900-01-01	1
53	dadosAdministrstatseqs	Dados Administrstatseqs	-	-	1	0	1	1	1900-01-01	1
54	dadosCurriculares	Dados Curriculares	-	-	1	0	1	1	1900-01-01	1
55	financeiro	Financeiro	-	-	1	0	1	1	1900-01-01	1
57	filiais	Cadastrar Filial	-	-	1	0	1	1	1900-01-01	1
58	dadosPrincipais	Dados Principais	-	-	1	0	1	1	1900-01-01	1
59	contato	Contato	-	-	1	0	1	1	1900-01-01	1
60	insumos	Insumos	-	-	1	0	1	1	1900-01-01	1
61	historico	Histórico	-	-	1	0	1	1	1900-01-01	1
63	cotacao	Cotação	-	-	1	0	1	1	1900-01-01	1
64	gerNegociacao	Gerenciar Negociação	-	-	1	1	1	1	1900-01-01	1
65	dadosContrato	Dados Principais	-	-	1	0	1	1	1900-01-01	1
66	dadosUsuario	Dados Principais	-	-	1	0	1	1	1900-01-01	1
68	dadosFerias	Dados Principais	-	-	1	0	1	1	1900-01-01	1
69	dadosSala	Dados Principais	-	-	1	0	1	1	1900-01-01	1
70	patrimoniosHistorico	Histórico	-	-	1	0	1	1	1900-01-01	1
71	dadosAreaCurso	Area de Curso	-	-	1	0	1	1	1900-01-01	1
73	solicitacao	Solicitação	-	-	1	0	1	1	1900-01-01	1
74	dadosCompra	Dados da Compra	-	-	1	0	1	1	1900-01-01	1
77	interesses	Cursos Interessados	-	-	1	0	1	1	1900-01-01	1
80	parametrosComercial	Comercial	-	-	1	0	1	1	1900-01-01	1
81	parametrosSecretaria	Secretaria	-	-	1	0	1	1	1900-01-01	1
82	parametrosFinanceiro	Financeiro	-	-	1	0	1	1	1900-01-01	1
83	parametrosAdministrstatseq	Administrstatseq	-	-	1	0	1	1	1900-01-01	1
84	parametrosRH	Recursos Humanos	-	-	1	0	1	1	1900-01-01	1
85	parametrosCoordenador	Coordenador	-	-	1	0	1	1	1900-01-01	1
86	parametrosProfessores	Professores	-	-	1	0	1	1	1900-01-01	1
88	matdidaticos	Materiais Didáticos	-	-	1	0	1	1	1900-01-01	1
90	historioFechaCaixa	Histórico	-	-	1	0	1	1	1900-01-01	1
99	histOcorrencia	Ocorrências	-	-	1	0	1	1	1900-01-01	1
200	experienciaCurriculo	Experiência	-	-	1	0	1	1	1900-01-01	1
201	obsCurriculo	Observações	-	-	1	0	1	1	1900-01-01	1
202	resumo	Resumo do Curriculo	-	-	1	0	1	1	1900-01-01	1
203	projetoEscopo	Escopo	-	-	1	0	1	1	1900-01-01	1
204	projetoRecursos	Recursos	-	-	1	0	1	1	1900-01-01	1
205	projetoRiscos	Riscos	-	-	1	0	1	1	1900-01-01	1
206	projetoProduto	Produto Final	-	-	1	0	1	1	1900-01-01	1
207	projetoRH	R.H.	-	-	1	0	1	1	1900-01-01	1
208	projetoReceita	Receita	-	-	1	0	1	1	1900-01-01	1
209	projetoCusto	Custos	-	-	1	0	1	1	1900-01-01	1
211	gerTurmaDisc	Disciplina	-	-	1	1	1	1	1900-01-01	1
212	planoaulaDisciplina	Disciplina	-	-	1	1	1	1	1900-01-01	1
213	planoaulaConteudo	Conteudo	-	-	1	2	1	1	1900-01-01	1
214	planoaulaRecursos	Recursos	-	-	1	3	1	1	1900-01-01	1
215	planoaulaMetodologia	Metodologia	-	-	1	4	1	1	1900-01-01	1
217	abaGeraArquivos	Arquivos	-	-	1	1	1	1	1900-01-01	1
34	turmasDisicplinasRequisitos	Pré-requisitos	-	-	1	0	1	1	1900-01-01	1
36	lanFaltas	Lançar Faltas	-	-	1	0	1	1	1900-01-01	1
210	historicoFinanceiro	Histórico Financeiro	TSecretaria/viewGetFinanceiro	-	1	0	1	1	1900-01-01	1
62	produtoCaracteristicas	Características	-	-	1	1	1	1	1900-01-01	1
216	abaGeraDisciplina	Adicionar Disciplinas	confirmaGeraDisciplina/get	-	1	1	1	1	1900-01-01	1
87	conciliaBoletos	Conciliação Bancária	TConciliacaoCaixa/setForm	-	1	0	1	1	1900-01-01	1
93	notasAluno	Notas	-	-	1	0	1	1	1900-01-01	1
56	historicoCliente	Histórico	-	-	1	0	1	1	1900-01-01	1
92	dadosFolhaPag	Folha de Pagamento	setCriterioFolhaPag/get	-	1	0	1	1	1900-01-01	1
91	mostraDuplicatasAluno	Boletos	TAluno/viewGetFinanceiro	-	1	0	1	1	1900-01-01	1
33	matricula	Gerenciador Matrícula	-	-	1	1	1	1	1900-01-01	1
79	dre	DRE	setPeriodoDRE/get	-	1	0	1	1	1900-01-01	1
78	balancoPatrimonial	Balanço Patrimonial	setDataBP/get	-	1	0	1	1	1900-01-01	1
76	relatorioCaixaD	Relatório de Despesa	relatorioCaixaD/get	-	1	0	1	1	1900-01-01	1
75	relatorioCaixaR	Relatório de Receita	relatorioCaixaR/get	-	1	0	1	1	1900-01-01	1
67	usuarioPrivilegios	Privilégios	TPrivilegios/viewGetModulos	-	1	0	1	1	1900-01-01	1
219	estatistica	Estatistica	-	-	1	0	1	1	1900-01-01	1
94	faltasAluno	Faltas	-	-	1	0	1	1	1900-01-01	1
38	lanNotas	Lançar Notas	-	-	1	0	1	1	1900-01-01	1
31	contaReceber	Informações da Conta	-	-	1	0	1	1	1900-01-01	1
32	contasPagar	Informações da Conta	-	-	1	1	1	1	1900-01-01	1
220	lancaExtorno	Lançamento	-	-	1	0	1	1	1900-01-01	1
221	transac_InfoC	Informações Principais	-	-	1	1	1	1	1900-01-01	1
222	transac_infoD	Informações Principais	-	-	1	1	1	1	1900-01-01	1
223	transac_condC	Condições de Pagamento	-	-	1	2	1	1	1900-01-01	1
225	permissaoPessoa	Permissões	-	-	1	0	1	1	1900-01-01	1
226	transac_condD	Condições de Pagamento	-	-	1	2	1	1	1900-01-01	1
227	justFaltas	Justificar Falta	-	-	1	0	1	1	1900-01-01	1
228	dadosProdutos	Dados Principais	-	-	1	0	1	1	1900-01-01	1
229	conteudoMinistradoProd	Conteudo Ministrado	-	-	1	0	1	1	1900-01-01	1
230	solicitacaoAluno	Solicitação	-	-	1	0	1	1	1900-01-01	1
231	departamentoInfo	Dados Principais	-	-	1	0	1	1	1900-01-01	1
232	departamentoPessoas	Funcionários	-	-	1	0	1	1	1900-01-01	1
233	setDisciplinasAlunos	Lista de Disciplinas	-	-	1	0	1	1	1900-01-01	1
234	solicitacaoEncaminhdada	Solicitação	-	-	1	0	1	1	1900-01-01	1
239	livrosInfoPrincipais	Informações Principais	-	-	1	1	1	1	1900-01-01	1
241	scoreCardParametrizacao	Parametrização	-	-	1	1	1	1	1900-01-01	1
244	insumoDet	Detalhes	-	-	1	2	1	1	1900-01-01	1
245	abaTiposCurso	Tipos de curso	-	-	1	1	1	1	1900-01-01	1
246	miniCurriculo	Curriculo	-	-	1	0	1	1	1900-01-01	1
249	disciplinas	Disciplinas	-	-	1	0	1	1	1900-01-01	1
250	questionarioDados	Informações Principais	-	-	1	1	1	1	1900-01-01	1
251	questionarioPerguntas	Questões	-	-	1	2	1	1	1900-01-01	1
252	questionarioPessoas	Usuários Autorizados	-	-	1	3	1	1	1900-01-01	1
253	cursostatseq	Vincular Curso	-	-	0	1	1	1	1900-01-01	1
248	alunoRequisitos	Pré-Requisitos	TAluno/viewSetRequisitos	-	1	4	1	1	1900-01-01	1
247	disciplinasTurma	Disciplinas	viewDisciplinasTurma/get	-	1	0	1	1	1900-01-01	1
243	scoreteste	Teste	TScoreCard/get	-	1	2	1	1	1900-01-01	1
89	abaFechamentoCaixa	Fechamento de caixa	TFechaCaixa/get	-	1	0	1	1	1900-01-01	1
273	contasDebito	Informações do Pagamento	-	-	1	2	1	1	1900-01-01	1
274	listaContasCredito	Informações do Pagamento	-	-	1	2	1	1	1900-01-01	1
254	setFaltaAlunos	Lançamento de Faltas	TTurmaDisciplinas/viewSetFaltasAlunos	-	0	1	1	1	1900-01-01	1
256	setNotaAlunos	Lançamento de Notas	-	-	1	1	1	1	1900-01-01	1
240	livrosInfoComplementares	Informações Complementares	-	-	1	4	1	1	1900-01-01	1
257	livrosInformacoesSinopse	Sinópse	-	-	1	2	1	1	1900-01-01	1
258	livrosInformacoesSumario	Sumário	-	-	1	3	1	1	1900-01-01	1
259	informacoesPrincipaisCDU	Informações	-	-	1	1	1	1	1900-01-01	1
5	bibliotecaLocacao	Locação de Livros	-	-	1	1	1	1	1900-01-01	1
260	bibliotecaLocacao	Locação de Livros	-	-	1	1	1	1	1900-01-01	1
261	bibliotecaReserv	Reserva de Livros	-	-	1	1	1	1	1900-01-01	1
262	bibliotecaDevolucao	Devolução de Livros	TBiblioteca/viewSetDevolucao	-	1	1	1	1	1900-01-01	1
6	prerequisitos	Pré-requisitos	TMatricula/viewSetRequisitos	-	1	0	1	1	1900-01-01	1
95	histAcademicoAluno	Histórico Acadêmico	TAluno/viewGetAcademico	-	1	0	1	1	1900-01-01	1
266	dadosConvenio	Dados do convênio	-	-	1	1	1	1	1900-01-01	1
267	pessoaConvenios	Convênios	-	-	1	1	1	1	1900-01-01	1
72	historicoAcademico	Histórico Acadêmico	TSecretaria/viewGetAcademico	-	1	0	1	1	1900-01-01	1
268	orientacoesArquivos	Orientações e Arquivos	-	-	1	4	1	1	1900-01-01	1
270	prodCaracteristicas	Características	-	-	1	1	1	1	1900-01-01	1
271	prodInfoComplementares	Informações Complementares	-	-	1	1	1	1	1900-01-01	1
272	dadosFuncionarioCaixa	Funcionário Autorizado	-	-	0	1	1	1	1900-01-01	1
275	aba_cobranca	Dados para Cobrança	-	-	1	1	1	1	1900-01-01	1
276	aba_inforDisciplinasTurma	Detalhes	-	-	1	1	1	1	1900-01-01	1
277	aba_datasDisciplinas	Datas	-	-	1	1	1	1	1900-01-01	1
20	dadosPrincipais	Dados Principais	-	-	1	0	1	1	1900-01-01	1
278	aba_blocoProfAreas	Professores Relacionados	-	-	1	1	1	1	1900-01-01	1
279	aba_blocoParticipantes	Participantes	-	-	1	1	1	1	1900-01-01	1
280	aba_fornecedoresProdutos	Produtos	-	-	1	1	1	1	1900-01-01	1
281	aba_produtoCotacao	Cotação do Produto	-	-	1	1	1	1	1900-01-01	1
282	aba_blocoClienteFormacao	Formação Acadêmica	-	-	1	1	1	1	1900-01-01	1
283	aba_blocoListaInteresses	Interesses	-	-	1	1	1	1	1900-01-01	1
284	aba_matdidaticos	Lista de Materiais	-	-	1	1	1	1	1900-01-01	1
285	aba_blocoOcorrencia	Ocorrencia	-	-	1	1	1	1	1900-01-01	1
286	aba_blprojetoRecursos	-	-	-	1	1	1	1	1900-01-01	1
287	aba_blprojetoRH	-	-	-	1	1	1	1	1900-01-01	1
288	aba_privilegios	-	-	-	1	1	1	1	1900-01-01	1
289	aba_blocolistObs	-	-	-	1	1	1	1	1900-01-01	1
290	aba_blocoFormacao	Formação	-	-	1	1	1	1	1900-01-01	1
291	aba_blocoFormProf	Formação	-	-	1	1	1	1	1900-01-01	1
292	aba_blocoAreasProf	Áreas Relacionadas	-	-	1	1	1	1	1900-01-01	1
293	aba_listaContasNegociacao	Contas a receber	-	-	1	1	1	1	1900-01-01	1
294	aba_discCursoDisp	Disciplinas do Curso	-	-	1	1	1	1	1900-01-01	1
295	aba_discCurso	Disciplinas do curso	-	-	1	1	1	1	1900-01-01	1
296	aba_requisitosCurso	Pré-requisitos da turma	-	-	1	1	1	1	1900-01-01	1
297	aba_blprojetoCusto	-	-	-	1	1	1	1	1900-01-01	1
298	aba_blocQuestinarioQuestoes	-	-	-	1	1	1	1	1900-01-01	1
299	aba_scorecardSentenças	-	-	-	1	1	1	1	1900-01-01	1
300	aba_blocoDepartamentoPessoas	-	-	-	1	1	1	1	1900-01-01	1
301	aba_blocoListaDiscAluno	-	-	-	1	1	1	1	1900-01-01	1
302	aba_listTreinamento	-	-	-	1	1	1	1	1900-01-01	1
303	aba_blocoContMinistProf	-	-	-	1	1	1	1	1900-01-01	1
304	aba_blJustFalta	-	-	-	1	1	1	1	1900-01-01	1
305	aba_blocoContMinistCoord	-	-	-	1	1	1	1	1900-01-01	1
306	aba_listContasTransacaoD	Contas	-	-	1	1	1	1	1900-01-01	1
309	aba_blocolistObsProf	-	-	-	1	1	1	1	1900-01-01	1
311	aba_blocoContMinistProf	-	-	-	1	1	1	1	1900-01-01	1
312	aba_listContasTransacaoC	Contas	-	-	1	1	1	1	1900-01-01	1
313	aba_lstProdutosTransacaoC	Produtos	-	-	1	1	1	1	1900-01-01	1
314	aba_blocPessoaConvenios	Lista de convênios	-	-	1	1	1	1	1900-01-01	1
315	aba_blocDescProgressivos	Descontos	-	-	1	1	1	1	1900-01-01	1
316	aba_blocOrientacoesArquivos	-	-	-	1	1	1	1	1900-01-01	1
317	aba_lstProdutosTransacaoD	Produtos	-	-	1	1	1	1	1900-01-01	1
318	aba_blocContasDebito	Contas a Pagar	-	-	1	1	1	1	1900-01-01	1
319	aba_cheques	Informações do Cheque	-	-	1	1	1	1	1900-01-01	1
320	aba_detalhamentoCaixa	Informações	TCaixa/viewDetalhamentoCaixa	-	1	1	1	1	1900-01-01	1
321	transacaoContasDebito	Contas a pagar	-	-	1	1	1	1	1900-01-01	1
323	movimentosProgramadosD	Movimentos de débito	-	-	0	0	1	1	1900-01-01	1
322	movimentosProgramadosC	Movimentos de crédito	-	-	1	1	1	1	1900-01-01	1
324	planosdeAulaProfessor	Plano de Aula	-	-	0	1	1	1	1900-01-01	1
325	infoLivroAluno	Informações do Livro	TBiblioteca/viewReserva	-	0	1	1	1	1900-01-01	1
310	aba_blocLancamentoNotas	Avaliações	TTurmaDisciplinas/viewSetNotasAlunos	-	1	1	1	1	1900-01-01	1
255	lancamentoNotas	Lançamento de Notas	-	-	0	0	1	1	1900-01-01	1
263	lancamentoAulas	Lançamento de Aulas	-	-	0	0	1	1	1900-01-01	1
264	obsAlunos	Observações	-	-	0	0	1	1	1900-01-01	1
265	lancamentoNotas	Lançamento de Notas	-	-	0	0	1	1	1900-01-01	1
326	informacoesCaixa	Movimentações	TCaixa/viewsCaixa	-	0	1	1	1	1900-01-01	1
327	movimentacaoInterna	Transferência	-	-	0	1	1	1	1900-01-01	1
328	historicoAcademicoCompleto	Histórico Completo	TSecretaria/viewGetAcademicoCompleto	-	0	1	1	1	1900-01-01	1
307	aba_blocLancamentoNotas	Avaliações	TTurmaDisciplinas/viewSetNotasAlunos	-	1	1	1	1	1900-01-01	1
331	prof-histAlunos	Histórico Alunos	TSecretaria/viewGetAcademicoDisciplina	-	1	1	1	1	1900-01-01	1
330	coord-histAlunos	Histórico Alunos	TSecretaria/viewGetAcademicoDisciplina	-	1	1	1	1	1900-01-01	1
329	sec-histAlunos	Histórico Alunos	TSecretaria/viewGetAcademicoDisciplina	-	1	1	1	1	1900-01-01	1
332	sec-taxaOcupacao	Taxa de Ocupação	TSecretaria/viewTaxaOcupacao	-	1	2	1	1	1900-01-01	1
333	coord-taxaOcupacao	Taxa de Ocupação	TSecretaria/viewTaxaOcupacao	-	1	2	1	1	1900-01-01	1
334	prof-taxaOcupacao	Taxa de Ocupação	TSecretaria/viewTaxaOcupacao	-	1	2	1	1	1900-01-01	1
335	sec-ProcessosAcademicos	Processos Acadêmicos	TSecretaria/viewProcessosAcademicos	-	0	6	1	1	1900-01-01	1
336	disciplinasSemelhantes	Disciplinas Semelhantes	-	-	0	7	1	1	1900-01-01	1
337	discSemelhante	Disciplinas	-	-	0	1	1	1	1900-01-01	1
338	histCaixa-Contas	Movimentações	-	-	0	1	1	1	1900-01-01	1
339	histCaixa-Grafico	Gráfico	TCaixa/viewGraficoHistorico	-	0	2	1	1	1900-01-01	1
1	dadosPrincipais	Dados Principais	-	-	1	0	1	1	1900-01-01	1
2	contato	Contato	-	-	1	0	1	1	1900-01-01	1
3	formacao_Profissao	Formação / Profissão	-	-	1	0	1	1	1900-01-01	1
4	cobranca	Cobrança	-	-	1	0	1	1	1900-01-01	1
11	disciplina	Disciplinas	-	-	1	0	1	1	1900-01-01	1
13	programa	Programa	-	-	1	0	1	1	1900-01-01	1
14	competencias	Competências	-	-	1	0	1	1	1900-01-01	1
15	bibliografia	Bibliografia	-	-	1	0	1	1	1900-01-01	1
16	metodologia	Metodologia	-	-	1	0	1	1	1900-01-01	1
17	formacaoProfissional	Formação profissional	-	-	1	0	1	1	1900-01-01	1
18	curso	Curso	-	-	1	0	1	1	1900-01-01	1
19	disciplinas	Disciplinas	-	-	1	0	1	1	1900-01-01	1
340	solicitacao-Atendimento	Atendimento	TSecretaria/viewAtendimentoSolicitacao	-	0	2	1	1	1900-01-01	1
363	transacoesConvenios	Convênios	-	-	0	3	1	1	1900-01-01	1
364	transacConvenioAba	Convênio	-	-	0	1	1	1	1900-01-01	1
366	turmaConvenioAba	Convênio	-	-	0	1	1	1	1900-01-01	1
365	turmaConvenio	Convênios	-	-	0	1	1	1	1900-01-01	1
367	processoEfetivacao	Efetivação	-	-	0	0	1	1	1900-01-01	1
308	aba_dAvaliacao	Avaliações X	-	-	1	1	1	1	1900-01-01	1
368	gradeAvaliacoes	Informações Principais	-	-	0	1	1	1	1900-01-01	1
369	infoAvaliacao	Informações da Avaliação	-	-	0	1	1	1	1900-01-01	1
370	descAvaliacao	Descriminação de Avaliações	-	-	0	2	1	1	1900-01-01	1
40	lancamentoAulas	Lançamento de Aulas	-	-	0	0	1	1	1900-01-01	1
41	obsAlunos	Observações	-	-	0	0	1	1	1900-01-01	1
371	descAvaliacao	Descriminação de Avaliações	-	-	0	0	1	1	1900-01-01	1
372	processoEfetivacao	Efetivação	-	-	0	0	1	1	1900-01-01	1
373	processoEfetivacao	Efetivação	-	-	0	0	1	1	1900-01-01	1
374	processoEfetivacao	Efetivação	-	-	0	0	1	1	1900-01-01	1
375	configUsuario-AlteracaoSenha	Alteração de Senha	TUsuario/apendicePassword	-	0	0	1	1	1900-01-01	1
376	discProjetoDeCursoConcluido	Disciplinas	-	-	 	0	1	1	1900-01-01	1
377	estornoMovimentos	Lista de Movimentos	-	-	0	1	1	1	1900-01-01	1
378	estornoDados	Informações do Estorno	-	-	0	2	1	1	1900-01-01	1
379	aba_consolidNotasFrequencias	Consolidação	TSecretaria/viewConsolidacaoNotasFrequencias	-	0	1	1	1	1900-01-01	1
380	aba_baixaMultiplaCredito	Contas de Crédito	-	-	0	1	1	1	1900-01-01	1
381	aba_vencimentoConta	Alteração da Data de Vencimento	-	-	0	1	1	1	1900-01-01	1
341	historicoMovimentacoes	Hist. Movimentações	-	-	0	6	1	1	1900-01-01	1
342	recado	Recado	-	-	0	1	1	1	1900-01-01	1
343	listaAproveitamento	Detalhes	-	-	0	1	1	1	1900-01-01	1
344	listAprovDisc	Detalhes	-	-	0	1	1	1	1900-01-01	1
345	processoEfetivacao	Efetivação	-	-	0	1	1	1	1900-01-01	1
346	processoEfetivacao	Efetivação	-	-	0	0	1	1	1900-01-01	1
357	processoEfetivacao	Efetivação	-	-	0	0	1	1	1900-01-01	1
356	processoEfetivacao	Efetivação	-	-	0	0	1	1	1900-01-01	1
355	processoEfetivacao	Efetivação	-	-	0	0	1	1	1900-01-01	1
354	processoEfetivacao	Efetivação	-	-	0	0	1	1	1900-01-01	1
352	processoEfetivacao	Efetivação	-	-	0	0	1	1	1900-01-01	1
351	processoEfetivacao	Efetivação	-	-	0	0	1	1	1900-01-01	1
350	processoEfetivacao	Efetivação	-	-	0	0	1	1	1900-01-01	1
349	processoEfetivacao	Efetivação	-	-	0	0	1	1	1900-01-01	1
347	processoEfetivacao	Efetivação	-	-	0	0	1	1	1900-01-01	1
353	processoEfetivacao	Efetivação	-	-	0	0	1	1	1900-01-01	1
348	processoEfetivacao	Efetivação	-	-	0	0	1	1	1900-01-01	1
358	justificativaFalta	Justificativa	-	-	0	1	1	1	1900-01-01	1
218	viewArquivos	Arquivos	TAluno/viewArquivos	-	1	0	1	1	1900-01-01	1
269	viewOrientacoes	Orientações	TAluno/viewOrientacoes	-	1	2	1	1	1900-01-01	1
359	avaliacaoCurso	Avaliações	-	-	0	4	1	1	1900-01-01	1
360	avaliacao	Avaliação	-	-	0	1	1	1	1900-01-01	1
361	descontos	Descontos	-	-	0	2	1	1	1900-01-01	1
362	detalheDesconto	Informações do Desconto	-	-	0	1	1	1	1900-01-01	1
7	aba_pess_fone	Telefone	-	-	0	1	1	1	2013-08-21	1
\.


--
-- TOC entry 2404 (class 0 OID 0)
-- Dependencies: 162
-- Name: abas_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('abas_seq_seq', 7, true);


--
-- TOC entry 2324 (class 0 OID 16395)
-- Dependencies: 163 2373
-- Data for Name: blocos; Type: TABLE DATA; Schema: public; Owner: -
--

COPY blocos (seq, blocoid, nomebloco, formato, tabseq, blocoheight, statseq, formseq, obapendice, frmpseq, usuaseq, unidseq, datacad) FROM stdin;
59	blocoDadosFuncionarios	-	frm	1	200px	1	\N	\N	6	1	1	1900-01-01
137	blListaArquivos	Adicionados	frm	63	400px	1	\N	\N	62	1	1	1900-01-01
158	blocoSolicitacaoAluno	Formulário de Solicitação	frm	46	200px	1	\N	\N	76	1	1	1900-01-01
162	informacoes	Registro de Solicitação	frm	46	200px	1	\N	\N	78	1	1	1900-01-01
253	movimentacaoContaDebito	Histórico de movimento da Conta	frm	65	430px	1	\N	\N	333	1	1	1900-01-01
255	informacoesCheque	Informações do Cheque	frm	95	200px	1	\N	\N	365	1	1	1900-01-01
168	infoLivroFinanc	Dados Financeiros	frm	32	400px	1	\N	\N	83	1	1	1900-01-01
172	detalhesProdutoInsumo	Detalhes	frm	32	400px	1	\N	\N	27	1	1	1900-01-01
174	blocTipoCurso	Dados	frm	80	200px	1	\N	\N	85	1	1	1900-01-01
175	dadosDescontosAcrescimosD	Descontos e acrescimos	frm	21	200px	1	\N	\N	\N	1	1	1900-01-01
180	blocQuestionarioInformacoes	-	frm	89	200px	1	\N	\N	89	1	1	1900-01-01
170	scoreCard	-	frm	78	200px	1	\N	\N	84	1	1	1900-01-01
159	blocoDepartamentoInfo	-	frm	77	200px	1	\N	\N	77	1	1	1900-01-01
154	bloProdutos	-	frm	70	200px	1	\N	\N	75	1	1	1900-01-01
182	blocSelecCurso	-	frm	85	400px	1	\N	\N	90	1	1	1900-01-01
188	infoLivroAcademSumario	-	frm	32	200px	1	\N	\N	83	1	1	1900-01-01
187	infoLivroAcademSinopse	-	frm	32	200px	1	\N	\N	83	1	1	1900-01-01
4	dadosPessoaisMatricula	Dados Pessoais	frm	16	200px	1	\N	\N	14	1	1	1900-01-01
191	infoReservaLivro	-	frm	87	200px	1	\N	\N	266	1	1	1900-01-01
192	infoDevolucaoLivro	-	frm	87	200px	1	\N	\N	267	1	1	1900-01-01
167	infoLivroAcadem1	-	frm	32	400px	1	\N	\N	83	1	1	1900-01-01
184	infoLivroAcadem0	-	frm	32	200px	1	\N	\N	83	1	1	1900-01-01
185	infoLivroAcadem2	-	frm	32	200px	1	\N	\N	83	1	1	1900-01-01
186	infoLivroAcadem3	-	frm	32	200px	1	\N	\N	83	1	1	1900-01-01
256	blocmovimentosProgramadosC	Movimentos de créditos programados	lst	21	400	1	389	\N	383	1	1	1900-01-01
257	blocmovimentosProgramadosD	Movimentos de débitos programados	lst	21	400	1	390	\N	383	1	1	1900-01-01
181	blocQuestinarioQuestoes	-	lst	89	400px	1	357	\N	89	1	1	1900-01-01
13	cobranca	Dados para Cobrança	lst	49	330px	1	334	\N	71	1	1	1900-01-01
166	blocoProfAreas	Professores Relacionados	lst	75	400px	1	337	\N	39	1	1	1900-01-01
65	blocoParticipantes	Participantes	lst	34	200px	1	338	\N	22	1	1	1900-01-01
75	fornecedoresProdutos	Produtos	lst	37	450px	1	339	\N	26	1	1	1900-01-01
79	produtoCotacao	Cotação do Produto	lst	38	450px	1	340	\N	27	1	1	1900-01-01
96	blocoListaInteresses	Interesses	lst	48	400px	1	342	\N	1	1	1	1900-01-01
98	matdidaticos	Lista de Materiais	lst	53	450px	1	343	\N	87	1	1	1900-01-01
111	blocoOcorrencia	Ocorrencia	lst	57	400px	1	344	\N	\N	1	1	1900-01-01
83	privilegios	-	lst	40	430px	1	347	\N	32	1	1	1900-01-01
169	scorecardSentenças	-	lst	77	400px	1	358	\N	84	1	1	1900-01-01
209	bloco_cobranca	Dados para Cobrança	frm	49	200px	1	\N	\N	334	1	1	1900-01-01
207	movimentosContaCredito	Histórico de movimentos da Conta	frm	65	430px	1	\N	\N	13	1	1	1900-01-01
212	bloco_blocoProfAreas	Professores Relacionados	frm	75	200px	1	\N	\N	337	1	1	1900-01-01
163	atendimento	Resolução	frm	46	200px	1	\N	\N	78	1	1	1900-01-01
213	bloco_blocoParticipantes	Participantes	frm	34	200px	1	\N	\N	338	1	1	1900-01-01
254	bloco_cheques	Informações do Cheque	frm	95	400px	1	\N	\N	378	1	1	1900-01-01
214	bloco_fornecedoresProdutos	Produtos	frm	38	200px	1	\N	\N	339	1	1	1900-01-01
246	bloco_listContasTransacaoC	Dados da conta	frm	65	200px	1	\N	\N	371	1	1	1900-01-01
215	bloco_produtoCotacao	Cotação do Produto	frm	38	200px	1	\N	\N	340	1	1	1900-01-01
216	bloco_blocoClienteFormacao	Formação Acadêmica	frm	43	200px	1	\N	\N	341	1	1	1900-01-01
217	bloco_blocoListaInteresses	Interesses	frm	48	200px	1	\N	\N	342	1	1	1900-01-01
160	blocoDepartamentoPessoas	-	lst	14	400px	1	359	\N	77	1	1	1900-01-01
156	blocoContMinistProf	-	lst	28	200px	1	362	\N	\N	1	1	1900-01-01
153	blJustFalta	-	lst	25	400px	1	363	\N	\N	1	1	1900-01-01
116	blocoContMinistCoord	-	lst	28	400px	1	364	\N	58	1	1	1900-01-01
152	listContasTransacaoD	Contas	lst	65	350px	1	365	\N	72	1	1	1900-01-01
161	blocoListaDiscAluno	-	lst	56	250px	1	360	\N	15	1	1	1900-01-01
210	bloco_inforDisciplinasTurma	Disciplinas Disponiveis	lst	10	350px	1	395	\N	335	1	1	1900-01-01
201	blocDescProgressivos	Descontos	lst	92	150px	1	374	\N	5	1	1	1900-01-01
100	listTreinamento	-	lst	34	200px	1	361	\N	\N	1	1	1900-01-01
196	blocolistObsProf	-	lst	28	400px	1	368	\N	18	1	1	1900-01-01
260	blocListaPlanoAulasProf	Planos de Aula	lst	62	360px	1	60	\N	397	1	1	1900-01-01
202	blocOrientacoesArquivos	Orientações e Arquivos	lst	63	365px	1	375	\N	399	1	1	1900-01-01
173	listaContasNegociacao	Contas a receber	lst	65	280px	1	352	\N	29	1	1	1900-01-01
144	listContasTransacaoC	Contas	lst	66	250px	1	371	\N	67	1	1	1900-01-01
143	lstProdutosTransacaoC	Produtos	lst	67	300px	1	372	\N	67	1	1	1900-01-01
258	bloc_Disciplinas	Disciplinas	lst	8	400px	1	393	\N	354	1	1	1900-01-01
183	blocLancamentoNotas	Avaliações	lst	27	400px	1	366	TTurmaDisciplinas/viewSetNotasAlunos	58	1	1	1900-01-01
54	dAvaliacao	Avaliações	lst	27	350px	1	367	\N	59	1	1	1900-01-01
197	blocLancamentoNotas	Avaliações	lst	27	400px	1	369	TTurmaDisciplinas/viewSetNotasAlunos	18	1	1	1900-01-01
259	bloc_InfoAluno	Informações do Aluno	frm	56	200px	1	\N	TAluno/viewInfoAluno	15	1	1	1900-01-01
132	blplanoaulaDisciplina	-	frm	62	400px	1	\N	\N	60	1	1	1900-01-01
20	escolaridade	Escolaridade	frm	1	200px	1	\N	\N	\N	1	1	1900-01-01
195	blocoContMinistProf	-	lst	28	400px	1	370	\N	18	1	1	1900-01-01
264	discSemelhantes	Lista de Disciplinas	lst	97	280px	1	413	\N	3	1	1	1900-01-01
266	histCaixa-Mov	Histórico de Movimentações	lst	21	380px	1	420	\N	418	1	1	1900-01-01
267	histCliente-Mov	Histórico de Movimentações	lst	21	380px	1	424	\N	1	1	1	1900-01-01
269	listAprov	Aproveitamentos	lst	100	380px	1	429	\N	428	1	1	1900-01-01
272	AprovdisciplinasAluno	Lista de Disciplinas	lst	56	380px	1	428	\N	434	1	1	1900-01-01
273	justificaFalta	Faltas Lançadas	lst	25	380px	1	444	\N	440	1	1	1900-01-01
89	blocoClienteFormacao	Formação Acadêmica	lst	43	250px	1	341	\N	1	1	1	1900-01-01
276	avaliacoes	Avaliações	lst	101	380px	1	446	\N	4	1	1	1900-01-01
278	blocoCOnveniosDEscontos	Lista de Descontos	lst	102	380px	1	448	\N	320	1	1	1900-01-01
280	listaConveniosTransacs	Convênios	lst	103	380px	1	450	\N	67	1	1	1900-01-01
277	infoAvaliacao	Dados da Avaliação	frm	101	380px	1	446	\N	\N	1	1	1900-01-01
78	produtoCaracteristicas	Caracteristicas do Produto	frm	32	200px	1	\N	\N	\N	1	1	1900-01-01
82	usuarios	Dados	frm	26	200px	1	\N	\N	31	1	1	1900-01-01
84	blocoFeriasPrincipal	Dados do Funcionário	frm	41	200px	1	\N	\N	33	1	1	1900-01-01
85	blocoFeriasPrevisão	Previsão de Férias	frm	41	200px	1	\N	\N	33	1	1	1900-01-01
86	blocoFeriasReal	Efetivação de Férias	frm	41	200px	1	\N	\N	33	1	1	1900-01-01
135	blplanoaulaMetodologia	Metodologia	frm	62	400px	1	\N	\N	60	1	1	1900-01-01
133	blplanoaulaConteudo	Conteudo	frm	62	400px	1	\N	\N	60	1	1	1900-01-01
231	bloco_blprojetoCusto	-	frm	59	200px	1	\N	\N	356	1	1	1900-01-01
232	bloco_blocQuestinarioQuestoes	-	frm	83	200px	1	\N	\N	357	1	1	1900-01-01
233	bloco_scorecardSentenças	-	frm	78	200px	1	\N	\N	358	1	1	1900-01-01
234	bloco_blocoDepartamentoPessoas	-	frm	14	200px	1	\N	\N	359	1	1	1900-01-01
200	blocPessoaConvenios	Lista de convênios	lst	89	400px	1	373	\N	1	1	1	1900-01-01
151	lstProdutosTransacaoD	Produtos	lst	67	300px	1	376	\N	72	1	1	1900-01-01
287	avaliacoes	Avaliações	lst	106	380px	1	464	\N	463	1	1	1900-01-01
289	avDescriminacao	Descriminação da Avaliação	lst	108	380px	1	467	\N	18	1	1	1900-01-01
290	avDescriminacao	Descriminação da Avaliação	lst	108	380px	1	467	\N	58	1	1	1900-01-01
296	blocoEstornoMovimento	Movimentos de caixa	lst	21	380px	1	480	\N	478	1	1	1900-01-01
299	blocoBaixaMultiplaCredito	Contas em Aberto para Baixa	lst	65	200px	1	486	\N	484	1	1	1900-01-01
88	blocoInfoChq	Informações do Cheque	frm	42	200px	1	\N	\N	\N	1	1	1900-01-01
90	blocoSalas	Informações da Sala	frm	44	200px	1	\N	\N	34	1	1	1900-01-01
91	blocoAreaCursos	Área	frm	45	200px	1	\N	\N	39	1	1	1900-01-01
97	bParametrosBPatrimonial	Balanço Patrimonial	frm	50	200px	1	\N	\N	46	1	1	1900-01-01
33	gerenciarTurmaInscricao	Turma	frm	11	380px	1	\N	\N	8	1	1	1900-01-01
118	blocoAtualizacao	-	frm	12	200px	1	\N	\N	\N	1	1	1900-01-01
288	avalInfo	Informações Principais	frm	106	380px	1	\N	\N	464	1	1	1900-01-01
87	blocoProfissao	Dados Profissionais	frm	1	200px	0	\N	\N	71	1	1	1900-01-01
81	contratos	Contratos e Convênios	frm	39	200px	1	\N	\N	30	1	1	1900-01-01
3	pessoaJuridica	Pessoa Jurídica	frm	6	200px	1	\N	\N	1	1	1	1900-01-01
1	tipoCadastro	Tipo de Cadastro	frm	1	200px	1	\N	\N	\N	1	1	1900-01-01
282	turmasConvenios	Lista de Convênios	lst	104	380px	1	452	\N	5	1	1	1900-01-01
300	blocoInformacoesAdicionais	Outras Informações	frm	65	200px	1	\N	\N	484	1	1	1900-01-01
301	blocoAlteraDataConta	Alteração das Informações da Conta	frm	65	200px	1	\N	\N	487	1	1	1900-01-01
56	blocoCargo	-	frm	999	200px	1	\N	\N	19	1	1	1900-01-01
67	blocoPatrimonios	-	frm	999	200px	1	\N	\N	21	1	1	1900-01-01
62	blocoCargoCompetencias	-	frm	999	200px	1	\N	\N	19	1	1	1900-01-01
63	blocoCargosHierarquia	-	frm	999	200px	1	\N	\N	19	1	1	1900-01-01
112	formacao	-	frm	999	200px	1	\N	\N	20	1	1	1900-01-01
127	blprojetoCusto	-	lst	999	200px	1	356	\N	57	1	1	1900-01-01
28	datasDisciplinas	Datas	lst	999	200px	1	336	\N	\N	1	1	1900-01-01
120	blprojetoRecursos	-	lst	999	200px	1	345	\N	57	1	1	1900-01-01
124	blprojetoRH	-	lst	999	200px	1	346	\N	57	1	1	1900-01-01
117	blocolistObs	-	lst	999	400px	1	348	\N	58	1	1	1900-01-01
179	discCursoDisp	Disciplinas do Curso	lst	999	420px	1	353	\N	87	1	1	1900-01-01
243	bloco_blocolistObsProf	-	frm	28	200px	1	\N	\N	368	1	1	1900-01-01
244	bloco_blocLancamentoNotas	Avaliações	frm	27	200px	1	\N	\N	369	1	1	1900-01-01
295	discCursoProjConcluido	Disciplinas do curso	lst	999	380px	1	476	\N	475	1	1	1900-01-01
194	dadosCursoMatricula	Dados do Curso	frm	16	300px	1	\N	\N	14	1	1	1900-01-01
199	blocDadosConvenio	Dados do convênio	frm	89	200px	1	\N	\N	320	1	1	1900-01-01
190	infoLocacaoLivros	Locador	frm	87	200px	1	\N	\N	264	1	1	1900-01-01
198	blocSelectLivro	Livro	frm	87	200px	1	\N	\N	264	1	1	1900-01-01
94	blocoDadosCompras	Formulário de Compra	frm	47	200px	1	\N	\N	40	1	1	1900-01-01
150	bloc_transac_InformacoesBasicasD	Cabeçalho da transação	frm	66	200px	1	\N	\N	72	1	1	1900-01-01
203	blocValidaProdInsumo	Especialização	frm	70	200px	1	\N	\N	\N	1	1	1900-01-01
204	blocInformacoesProdInsumo	-	frm	37	400px	1	\N	\N	75	1	1	1900-01-01
206	blocFuncCaixa	-	frm	94	400px	1	\N	\N	332	1	1	1900-01-01
205	blocProdutoInfTecnicas	-	frm	37	400px	1	\N	\N	75	1	1	1900-01-01
218	bloco_matdidaticos	Lista de Materiais	frm	53	200px	1	\N	\N	343	1	1	1900-01-01
219	bloco_blocoOcorrencia	Ocorrencia	frm	57	200px	1	\N	\N	344	1	1	1900-01-01
220	bloco_blprojetoRecursos	-	frm	61	200px	1	\N	\N	345	1	1	1900-01-01
221	bloco_blprojetoRH	-	frm	60	200px	1	\N	\N	346	1	1	1900-01-01
222	bloco_privilegios	-	frm	40	200px	1	\N	\N	347	1	1	1900-01-01
223	bloco_blocolistObs	-	frm	28	200px	1	\N	\N	348	1	1	1900-01-01
224	bloco_blocoFormacao	Formação	frm	43	200px	1	\N	\N	349	1	1	1900-01-01
225	bloco_blocoFormProf	Formação	frm	43	200px	1	\N	\N	350	1	1	1900-01-01
226	bloco_blocoAreasProf	Áreas Relacionadas	frm	75	200px	1	\N	\N	351	1	1	1900-01-01
227	bloco_listaContasNegociacao	Contas a receber	frm	65	200px	1	\N	\N	352	1	1	1900-01-01
228	bloco_discCursoDisp	Disciplinas do Curso	frm	10	200px	1	\N	\N	353	1	1	1900-01-01
229	bloco_discCurso	Disciplinas do curso	frm	10	200px	1	\N	\N	\N	1	1	1900-01-01
230	bloco_requisitosCurso	Pré-requisitos da turma	frm	23	200px	1	\N	\N	355	1	1	1900-01-01
134	blplanoaulaRecursos	Recursos	frm	62	400px	1	\N	\N	60	1	1	1900-01-01
245	bloco_blocoContMinistProf	-	frm	28	200px	1	\N	\N	370	1	1	1900-01-01
247	bloco_lstProdutosTransacaoC	Produtos	frm	67	200px	1	\N	\N	\N	1	1	1900-01-01
248	bloco_blocPessoaConvenios	Lista de convênios	frm	90	200px	1	\N	\N	373	1	1	1900-01-01
250	bloco_blocOrientacoesArquivos	-	frm	63	200px	1	\N	\N	375	1	1	1900-01-01
251	bloco_lstProdutosTransacaoD	Produtos	frm	67	200px	1	\N	\N	376	1	1	1900-01-01
235	bloco_blocoListaDiscAluno	-	frm	56	200px	1	\N	\N	360	1	1	1900-01-01
236	bloco_listTreinamento	-	frm	34	200px	1	\N	\N	361	1	1	1900-01-01
238	bloco_blJustFalta	-	frm	25	200px	1	\N	\N	363	1	1	1900-01-01
239	bloco_blocoContMinistCoord	-	frm	28	200px	1	\N	\N	364	1	1	1900-01-01
240	bloco_listContasTransacaoD	Contas	frm	65	200px	1	\N	\N	365	1	1	1900-01-01
241	bloco_blocLancamentoNotas	Avaliações	frm	27	200px	1	\N	\N	366	1	1	1900-01-01
242	bloco_dAvaliacao	Avaliações	frm	27	200px	1	\N	\N	367	1	1	1900-01-01
114	obs	-	frm	999	200px	1	\N	\N	20	1	1	1900-01-01
92	infoPadraoTurma	Informações Padrão	frm	999	200px	1	\N	\N	\N	1	1	1900-01-01
265	blocdiscSemelhante	Disciplina	frm	97	200px	1	\N	\N	413	1	1	1900-01-01
268	info	Informações	frm	99	380px	1	\N	\N	426	1	1	1900-01-01
270	disc	Disciplina	frm	100	380px	1	\N	\N	429	1	1	1900-01-01
69	blocoDadosAdminist	-	frm	43	200px	1	\N	\N	6	1	1	1900-01-01
70	blocoFormacao	Formação	lst	999	200px	0	349	\N	6	1	1	1900-01-01
274	textoJustificativa	Detalhamento	frm	25	380px	1	\N	\N	444	1	1	1900-01-01
275	senha	Senha	frm	26	380px	1	\N	TUsuario/apendicePassword	31	1	1	1900-01-01
249	bloco_blocDescProgressivos	Descontos de Pontualidade	frm	92	150px	1	\N	\N	374	1	1	1900-01-01
279	detDesconto	Detalhamento	frm	102	380px	1	\N	\N	448	1	1	1900-01-01
281	transacConvenio	Detalhe	frm	103	380px	1	\N	\N	450	1	1	1900-01-01
283	turmaConvenio	Detalhe	frm	104	380px	1	\N	\N	452	1	1	1900-01-01
285	AprovdisciplinasAluno	Lista de Disciplinas	frm	56	380px	1	\N	\N	454	1	1	1900-01-01
113	experiencia	-	frm	999	200px	1	\N	\N	20	1	1	1900-01-01
115	resumo	-	frm	999	200px	1	\N	\N	20	1	1	1900-01-01
130	opcaoCobraca	Opção de cobrança	frm	999	200px	1	\N	\N	71	1	1	1900-01-01
139	bloc_LancaExtornoDebito	Gerar Débido	frm	999	400px	1	\N	\N	64	1	1	1900-01-01
140	bloc_LancaExtornoCredito	Gerar Crédito	frm	999	400px	1	\N	\N	64	1	1	1900-01-01
155	encaminhamento	Encaminhamento	frm	999	200px	1	\N	\N	38	1	1	1900-01-01
138	blSetTipoExtorno	-	frm	999	200px	1	\N	\N	64	1	1	1900-01-01
131	blgerTurmaDisc	-	frm	999	200px	1	\N	\N	59	1	1	1900-01-01
128	blprojetoCustoTotal	-	frm	999	200px	1	\N	\N	57	1	1	1900-01-01
126	blprojetoResp	-	frm	999	200px	1	\N	\N	57	1	1	1900-01-01
125	blprojetoReceita	-	frm	999	200px	1	\N	\N	57	1	1	1900-01-01
286	gradeAvaliacao	Grade de Avaliações	frm	105	380px	1	\N	\N	\N	1	1	1900-01-01
146	blcPermissaoPessoa	-	frm	999	200px	1	\N	\N	71	1	1	1900-01-01
141	bloc_transac_InformacoesBasicasC	-	frm	999	200px	1	\N	\N	67	1	1	1900-01-01
189	informacoesCDU	CDU	frm	999	200px	1	\N	\N	270	1	1	1900-01-01
193	retLocacao	Livros Locados	frm	999	400px	1	\N	TBiblioteca/viewSetLocacao	264	1	1	1900-01-01
211	bloco_datasDisciplinas	Datas	frm	999	200px	1	\N	\N	336	1	1	1900-01-01
263	movInterna	Detalhes	frm	999	200px	1	\N	\N	404	1	1	1900-01-01
252	bloco_blocContasDebito	Contas a Pagar	frm	999	200px	1	\N	\N	377	1	1	1900-01-01
262	negociacaoInfo	-	frm	999	200	1	\N	\N	29	1	1	1900-01-01
14	disciplina	Formulário de Disciplinas	frm	999	200px	1	\N	\N	3	1	1	1900-01-01
261	gerenciarTransacaoContasC	Condições de Pagamento	frm	999	200px	1	\N	\N	67	1	1	1900-01-01
15	ementa	Ementa	frm	999	200px	1	\N	\N	3	1	1	1900-01-01
16	competencias	Competências	frm	999	200px	1	\N	\N	3	1	1	1900-01-01
17	bibliografia	Bibliografia	frm	999	200px	1	\N	\N	3	1	1	1900-01-01
18	metodologia	Metodologia	frm	999	200px	1	\N	\N	3	1	1	1900-01-01
19	programa	Programa	frm	999	200px	1	\N	\N	3	1	1	1900-01-01
24	cargaHorTotal	Carga Horaria	frm	999	200px	0	\N	\N	\N	1	1	1900-01-01
27	blocFinanceiroCusto	Base de custo Mensal	frm	999	200px	1	\N	\N	\N	1	1	1900-01-01
29	dadosPrincipais	Informações principais	frm	999	200px	1	\N	\N	\N	1	1	1900-01-01
32	dados	Dados	frm	999	200px	1	\N	\N	8	1	1	1900-01-01
34	dadosDuplicata	Dados	frm	999	200px	1	\N	\N	9	1	1	1900-01-01
35	valoresNominais	Valores Nominais	frm	999	200px	1	\N	\N	9	1	1	1900-01-01
36	valoresReais	Valores Reais	frm	999	200px	1	\N	\N	9	1	1	1900-01-01
37	obsDuplicatas	Observações	frm	999	200px	1	\N	\N	9	1	1	1900-01-01
38	dadosConta	Conta	frm	999	200px	1	\N	\N	10	1	1	1900-01-01
39	infoContas	Informações	frm	999	200px	1	\N	\N	11	1	1	1900-01-01
40	infoCredito	Informações	frm	999	200px	1	\N	\N	12	1	1	1900-01-01
44	dadosContaD	Informações do Débito	frm	999	200px	1	\N	\N	333	1	1	1900-01-01
45	dadosPagD	Dados do Pagamento	frm	999	200px	1	\N	\N	333	1	1	1900-01-01
51	infoContaCaixa	Dados da Conta Caixa	frm	999	200px	1	\N	\N	17	1	1	1900-01-01
53	dadosUsuario	Dados do Usuario	frm	999	200px	1	\N	\N	\N	1	1	1900-01-01
57	blocoDados	Dados Gerais	frm	999	200px	1	\N	\N	20	1	1	1900-01-01
58	blocoCurriculo	Áreas de Interesse	frm	999	200px	1	\N	\N	20	1	1	1900-01-01
22	infoCurso	Inforrmações do Curso	frm	9	200px	1	\N	\N	4	1	1	1900-01-01
64	blocoTreinamentos	Informações do Treinamento	frm	999	200px	1	\N	\N	22	1	1	1900-01-01
66	blocoAtributos	Atributos	frm	999	200px	1	\N	\N	\N	1	1	1900-01-01
171	gerenciarTransacaocontasD	Forma de pagamento	frm	999	200px	1	\N	\N	72	1	1	1900-01-01
31	curriculo	Curriculo	frm	15	200px	1	\N	\N	7	1	1	1900-01-01
25	infoGeraisTurma	Informações gerais	frm	12	200px	1	\N	\N	5	1	1	1900-01-01
157	blocFinanceiroRec	Base de Receita	frm	999	200px	1	\N	\N	5	1	1	1900-01-01
177	blocCurso Turma	Curso	frm	999	200px	1	\N	\N	5	1	1	1900-01-01
43	dadosPagC	Dados do Pagamento	frm	21	200px	1	\N	\N	13	1	1	1900-01-01
71	blocoFiliais	Dados	frm	999	200px	1	\N	\N	24	1	1	1900-01-01
72	pessoaFisica	Pessoa Física	frm	999	200px	1	\N	\N	26	1	1	1900-01-01
73	pessoaJuridica	Pessoa Jurídica	frm	999	200px	1	\N	\N	26	1	1	1900-01-01
74	fornecedoresContatos	Contatos	frm	999	200px	1	\N	\N	26	1	1	1900-01-01
77	fornecedoresTipo	Tipo de Cadastro	frm	999	200px	1	\N	\N	26	1	1	1900-01-01
80	produtoEspecificacoes	Especificações do Produto	frm	999	200px	1	\N	\N	\N	1	1	1900-01-01
237	bloco_blocoContMinistProf	-	frm	999	200px	1	\N	\N	362	1	1	1900-01-01
93	blocoSolicitacao	Formulário de Solicitação	frm	999	200px	1	\N	\N	38	1	1	1900-01-01
95	blocoComprasPagamento	Forma de Pagamento	frm	999	200px	1	\N	\N	40	1	1	1900-01-01
119	blprojetoEscopo	-	frm	999	200px	1	\N	\N	57	1	1	1900-01-01
41	gerenciarTransacaocontas	Gerenciamento de Contas	frm	999	200px	1	\N	\N	\N	1	1	1900-01-01
121	blprojetoRecursosTotal	-	frm	999	200px	1	\N	\N	57	1	1	1900-01-01
123	blprojetoProduto	-	frm	999	200px	1	\N	\N	57	1	1	1900-01-01
122	blprojetoRisco	-	frm	999	200px	1	\N	\N	57	1	1	1900-01-01
291	totalCustoProfessor	Totalizador	frm	999	200px	1	\N	\N	59	1	1	1900-01-01
292	procConfAbandonoCurso	Confirmação	frm	999	200px	1	\N	\N	460	1	1	1900-01-01
293	procConfDesTrancamentoMatricula	Confirmação	frm	999	200px	1	\N	\N	460	1	1	1900-01-01
294	procConfTrancamentoCurso	Confirmação	frm	999	200px	1	\N	\N	460	1	1	1900-01-01
297	blocoEstornoDados	Dados do Estorno	frm	999	200px	1	\N	\N	482	1	1	1900-01-01
298	blocoEstornoContaInfo	Informações da Conta	frm	999	200px	1	\N	\N	482	1	1	1900-01-01
271	detalheProcesso	Informações do Processo	frm	999	200px	1	\N	TProcessoAcademico/viewDetalheProcessoAcademico	\N	1	1	1900-01-01
284	detalheProcesso	Informações do Processo	frm	999	200px	1	\N	TProcessoAcademico/viewDetalheProcessoAcademico	\N	1	1	1900-01-01
5	bloco_telefones	Telefones e Celulares	lst	3	200px	1	2	\N	1	1	1	2013-08-21
12	endereco	Endereço	frm	49	200px	1	\N	\N	1	1	1	1900-01-01
6	bloco_pess_fone	Dados do Telefone	frm	3	200px	1	2	\N	1	1	1	2013-08-21
23	discCurso	Disciplinas do curso	lst	9	380px	1	354	\N	4	1	1	1900-01-01
2	pessoaFisica	Pessoa Física	frm	5	200px	1	\N	\N	1	1	1	1900-01-01
30	informacao	Informações	frm	15	200px	1	\N	\N	7	1	1	1900-01-01
164	blocoFormProf	Formação	lst	1	200px	1	350	\N	7	1	1	1900-01-01
165	blocoAreasProf	Áreas Relacionadas	lst	75	150px	1	351	\N	7	1	1	1900-01-01
99	infoFolhaPag	Informações para Folha de Pagamento	frm	999	200px	0	\N	\N	6	1	1	1900-01-01
60	blocoDadosComplementaresFuncionarios	-	frm	43	200px	1	\N	\N	6	1	1	1900-01-01
26	inforDisciplinasTurma	Disciplinas da turma	lst	12	380px	1	335	\N	5	1	1	1900-01-01
46	requisitosCurso	Pré-requisitos da turma	lst	23	380px	1	355	\N	5	1	1	1900-01-01
7	blocoEmail	E-mails	frm	1	200px	1	\N	\N	\N	1	1	2013-10-11
42	dadosContaC	Informações da Receita	frm	21	200px	1	\N	\N	13	1	1	1900-01-01
\.


--
-- TOC entry 2405 (class 0 OID 0)
-- Dependencies: 164
-- Name: blocos_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('blocos_seq_seq', 7, true);


--
-- TOC entry 2326 (class 0 OID 16403)
-- Dependencies: 165 2373
-- Data for Name: blocos_x_abas; Type: TABLE DATA; Schema: public; Owner: -
--

COPY blocos_x_abas (seq, abaseq, blocseq, ordem, usuaseq, unidseq, datacad, statseq) FROM stdin;
14	18	22	\N	1	1	1900-01-01	1
15	19	23	\N	1	1	1900-01-01	1
17	20	25	2	1	1	1900-01-01	1
18	21	26	\N	1	1	1900-01-01	1
20	22	29	\N	1	1	1900-01-01	1
21	23	30	1	1	1	1900-01-01	1
170	246	31	1	1	1	1900-01-01	1
25	26	34	\N	1	1	1900-01-01	1
26	26	35	\N	1	1	1900-01-01	1
27	26	36	\N	1	1	1900-01-01	1
28	27	37	\N	1	1	1900-01-01	1
29	28	38	\N	1	1	1900-01-01	1
30	29	39	\N	1	1	1900-01-01	1
31	30	40	\N	1	1	1900-01-01	1
33	31	42	1	1	1	1900-01-01	1
41	34	46	\N	1	1	1900-01-01	1
42	35	51	\N	1	1	1900-01-01	1
44	22	53	\N	1	1	1900-01-01	1
45	39	54	2	1	1	1900-01-01	1
47	42	56	\N	1	1	1900-01-01	1
48	43	57	\N	1	1	1900-01-01	1
49	43	58	\N	1	1	1900-01-01	1
50	45	59	\N	1	1	1900-01-01	1
51	46	60	\N	1	1	1900-01-01	1
52	48	62	\N	1	1	1900-01-01	1
53	49	63	\N	1	1	1900-01-01	1
54	50	64	\N	1	1	1900-01-01	1
55	50	65	\N	1	1	1900-01-01	1
56	52	66	\N	1	1	1900-01-01	1
57	71	166	2	1	1	1900-01-01	1
58	53	69	\N	1	1	1900-01-01	1
59	54	70	\N	1	1	1900-01-01	1
60	57	71	\N	1	1	1900-01-01	1
61	58	77	\N	1	1	1900-01-01	1
62	58	72	\N	1	1	1900-01-01	1
63	59	74	\N	1	1	1900-01-01	1
64	62	78	\N	1	1	1900-01-01	1
66	58	73	\N	1	1	1900-01-01	1
67	63	79	\N	1	1	1900-01-01	1
68	62	80	\N	1	1	1900-01-01	1
69	60	75	\N	1	1	1900-01-01	1
70	65	81	\N	1	1	1900-01-01	1
72	67	83	\N	1	1	1900-01-01	1
74	68	85	\N	1	1	1900-01-01	1
75	68	86	\N	1	1	1900-01-01	1
76	3	87	1	1	1	1900-01-01	1
77	3	89	2	1	1	1900-01-01	1
78	69	90	\N	1	1	1900-01-01	1
79	71	91	1	1	1	1900-01-01	1
80	73	93	\N	1	1	1900-01-01	1
81	74	94	\N	1	1	1900-01-01	1
82	74	95	\N	1	1	1900-01-01	1
83	77	96	\N	1	1	1900-01-01	1
84	82	97	\N	1	1	1900-01-01	1
85	88	98	\N	1	1	1900-01-01	1
87	53	99	\N	1	1	1900-01-01	1
88	54	100	\N	1	1	1900-01-01	1
89	99	111	\N	1	1	1900-01-01	1
93	44	112	\N	1	1	1900-01-01	1
94	200	113	\N	1	1	1900-01-01	1
95	201	114	\N	1	1	1900-01-01	1
96	202	115	\N	1	1	1900-01-01	1
100	203	119	\N	1	1	1900-01-01	1
101	204	120	\N	1	1	1900-01-01	1
102	205	122	\N	1	1	1900-01-01	1
103	206	123	\N	1	1	1900-01-01	1
104	207	124	\N	1	1	1900-01-01	1
105	208	125	\N	1	1	1900-01-01	1
108	204	121	\N	1	1	1900-01-01	1
109	209	127	\N	1	1	1900-01-01	1
111	209	128	\N	1	1	1900-01-01	1
112	207	126	\N	1	1	1900-01-01	1
113	4	130	1	1	1	1900-01-01	1
114	211	131	1	1	1	1900-01-01	1
117	214	134	1	1	1	1900-01-01	1
118	215	135	1	1	1	1900-01-01	1
120	217	137	1	1	1	1900-01-01	1
121	220	138	1	1	1	1900-01-01	1
122	220	139	2	1	1	1900-01-01	1
123	220	140	2	1	1	1900-01-01	1
126	221	143	2	1	1	1900-01-01	1
159	240	168	1	1	1	1900-01-01	1
130	225	146	1	1	1	1900-01-01	1
134	222	150	1	1	1	1900-01-01	1
135	222	151	2	1	1	1900-01-01	1
154	23	165	3	1	1	1900-01-01	1
73	68	84	\N	1	1	1900-01-01	9
6	11	14	1	1	1	1900-01-01	1
7	11	15	2	1	1	1900-01-01	1
8	13	19	1	1	1	1900-01-01	1
9	14	16	1	1	1	1900-01-01	1
10	15	17	1	1	1	1900-01-01	1
11	16	18	1	1	1	1900-01-01	1
141	227	153	1	1	1	1900-01-01	1
142	228	154	1	1	1	1900-01-01	1
143	73	155	1	1	1	1900-01-01	1
144	229	156	1	1	1	1900-01-01	1
145	55	157	1	1	1	1900-01-01	1
146	230	158	1	1	1	1900-01-01	1
147	231	159	1	1	1	1900-01-01	1
149	232	160	1	1	1	1900-01-01	1
151	234	162	1	1	1	1900-01-01	1
152	234	163	1	1	1	1900-01-01	1
153	23	164	3	1	1	1900-01-01	1
161	241	169	1	1	1	1900-01-01	1
162	241	170	1	1	1	1900-01-01	1
163	47	67	1	1	1	1900-01-01	1
167	244	172	1	1	1	1900-01-01	1
169	245	174	1	1	1	1900-01-01	1
173	20	177	1	1	1	1900-01-01	1
174	249	179	1	1	1	1900-01-01	1
175	250	180	1	1	1	1900-01-01	1
176	251	181	1	1	1	1900-01-01	1
178	253	182	1	1	1	1900-01-01	1
12	33	4	1	1	1	1900-01-01	1
179	255	183	1	1	1	1900-01-01	1
158	239	167	2	1	1	1900-01-01	1
185	259	189	1	1	1	1900-01-01	1
180	239	184	1	1	1	1900-01-01	1
181	239	185	3	1	1	1900-01-01	1
182	239	186	4	1	1	1900-01-01	1
183	257	187	1	1	1	1900-01-01	1
184	258	188	1	1	1	1900-01-01	1
186	261	191	1	1	1	1900-01-01	1
187	260	190	1	1	1	1900-01-01	1
188	262	192	1	1	1	1900-01-01	1
98	41	117	1	1	1	1900-01-01	1
97	40	116	1	1	1	1900-01-01	1
191	263	195	1	1	1	1900-01-01	1
192	264	196	1	1	1	1900-01-01	1
193	265	197	1	1	1	1900-01-01	1
194	260	198	2	1	1	1900-01-01	1
189	260	193	3	1	1	1900-01-01	1
195	266	199	1	1	1	1900-01-01	1
196	267	200	1	1	1	1900-01-01	1
198	268	202	1	1	1	1900-01-01	1
166	226	171	1	1	1	1900-01-01	1
201	270	205	1	1	1	1900-01-01	1
202	272	206	1	1	1	1900-01-01	1
200	271	204	1	1	1	1900-01-01	1
35	32	44	1	1	1	1900-01-01	1
34	274	43	3	1	1	1900-01-01	1
36	273	45	3	1	1	1900-01-01	1
205	275	209	1	1	1	1900-01-01	1
206	276	210	1	1	1	1900-01-01	1
207	277	211	1	1	1	1900-01-01	1
208	278	212	1	1	1	1900-01-01	1
209	279	213	1	1	1	1900-01-01	1
210	280	214	1	1	1	1900-01-01	1
211	281	215	1	1	1	1900-01-01	1
212	282	216	1	1	1	1900-01-01	1
213	283	217	1	1	1	1900-01-01	1
214	284	218	1	1	1	1900-01-01	1
215	285	219	1	1	1	1900-01-01	1
216	286	220	1	1	1	1900-01-01	1
217	287	221	1	1	1	1900-01-01	1
218	288	222	1	1	1	1900-01-01	1
219	289	223	1	1	1	1900-01-01	1
220	290	224	1	1	1	1900-01-01	1
221	291	225	1	1	1	1900-01-01	1
222	292	226	1	1	1	1900-01-01	1
223	293	227	1	1	1	1900-01-01	1
150	233	161	2	1	1	1900-01-01	1
224	294	228	1	1	1	1900-01-01	1
226	296	230	1	1	1	1900-01-01	1
227	297	231	1	1	1	1900-01-01	1
228	298	232	1	1	1	1900-01-01	1
116	213	133	2	1	1	1900-01-01	1
229	299	233	1	1	1	1900-01-01	1
157	64	173	2	1	1	1900-01-01	1
230	300	234	1	1	1	1900-01-01	1
155	64	262	1	1	1	1900-01-01	1
231	301	235	1	1	1	1900-01-01	1
232	302	236	1	1	1	1900-01-01	1
233	303	237	1	1	1	1900-01-01	1
234	304	238	1	1	1	1900-01-01	1
24	24	33	2	1	1	1900-01-01	1
235	305	239	1	1	1	1900-01-01	1
236	306	240	1	1	1	1900-01-01	1
1	1	1	1	1	1	1900-01-01	1
204	31	207	2	1	1	1900-01-01	1
4	4	13	2	1	1	1900-01-01	1
245	315	249	1	1	1	1900-01-01	1
246	316	250	1	1	1	1900-01-01	1
247	317	251	1	1	1	1900-01-01	1
248	318	252	1	1	1	1900-01-01	1
249	32	253	1	1	1	1900-01-01	1
251	306	255	2	1	1	1900-01-01	1
252	321	152	1	1	1	1900-01-01	1
250	319	254	1	1	1	1900-01-01	1
253	312	255	2	1	1	1900-01-01	1
254	322	256	1	1	1	1900-01-01	1
255	323	257	2	1	1	1900-01-01	1
225	295	258	1	1	1	1900-01-01	1
256	233	259	1	1	1	1900-01-01	1
257	324	260	1	1	1	1900-01-01	1
115	213	132	1	1	1	1900-01-01	1
259	223	261	1	1	1	1900-01-01	1
124	221	141	1	1	1	1900-01-01	1
260	327	263	1	1	1	1900-01-01	1
261	336	264	1	1	1	1900-01-01	1
262	337	265	1	1	1	1900-01-01	1
263	338	266	1	1	1	1900-01-01	1
264	341	267	1	1	1	1900-01-01	1
265	342	268	1	1	1	1900-01-01	1
266	343	269	1	1	1	1900-01-01	1
267	344	270	1	1	1	1900-01-01	1
268	345	271	1	1	1	1900-01-01	1
269	346	271	1	1	1	1900-01-01	1
270	347	271	1	1	1	1900-01-01	1
271	348	271	1	1	1	1900-01-01	1
272	349	271	1	1	1	1900-01-01	1
273	350	271	1	1	1	1900-01-01	1
274	351	271	1	1	1	1900-01-01	1
275	352	271	1	1	1	1900-01-01	1
276	353	271	1	1	1	1900-01-01	1
277	354	271	1	1	1	1900-01-01	1
278	355	271	1	1	1	1900-01-01	1
279	356	271	1	1	1	1900-01-01	1
280	348	272	1	1	1	1900-01-01	1
281	354	273	1	1	1	1900-01-01	1
282	358	274	1	1	1	1900-01-01	1
71	66	82	1	1	1	1900-01-01	1
283	66	275	2	1	1	1900-01-01	1
284	359	276	1	1	1	1900-01-01	1
285	360	277	1	1	1	1900-01-01	1
168	223	144	2	1	1	1900-01-01	1
286	361	278	1	1	1	1900-01-01	1
287	362	279	1	1	1	1900-01-01	1
288	362	279	1	1	1	1900-01-01	1
289	363	280	1	1	1	1900-01-01	1
290	364	281	1	1	1	1900-01-01	1
291	365	282	1	1	1	1900-01-01	1
292	366	283	1	1	1	1900-01-01	1
293	367	284	1	1	1	1900-01-01	1
294	367	285	1	1	1	1900-01-01	1
295	368	286	1	1	1	1900-01-01	1
296	368	287	1	1	1	1900-01-01	1
297	369	288	1	1	1	1900-01-01	1
298	211	291	2	1	1	1900-01-01	1
299	372	271	1	1	1	1900-01-01	1
300	373	271	1	1	1	1900-01-01	1
301	374	271	1	1	1	1900-01-01	1
302	345	292	2	1	1	1900-01-01	1
303	351	293	2	1	1	1900-01-01	1
304	374	294	2	1	1	1900-01-01	1
305	376	295	1	1	1	1900-01-01	1
23	24	32	1	1	1	1900-01-01	1
306	377	296	1	1	1	1900-01-01	1
308	378	298	1	1	1	1900-01-01	1
307	378	297	2	1	1	1900-01-01	1
309	380	299	1	1	1	1900-01-01	1
310	380	300	2	1	1	1900-01-01	1
311	381	301	1	1	1	1900-01-01	1
237	307	241	1	1	1	1900-01-01	1
238	308	242	1	1	1	1900-01-01	1
239	309	243	1	1	1	1900-01-01	1
240	310	244	1	1	1	1900-01-01	1
241	311	245	1	1	1	1900-01-01	1
242	312	246	1	1	1	1900-01-01	1
243	313	247	1	1	1	1900-01-01	1
244	314	248	1	1	1	1900-01-01	1
5	1	2	2	1	1	1900-01-01	1
3	1	12	4	1	1	1900-01-01	1
13	1	5	5	1	1	2013-08-21	1
16	7	6	1	1	1	2013-08-21	1
190	33	194	2	1	1	1900-01-01	1
19	1	7	3	1	1	2013-10-11	1
2	1	3	2	1	1	1900-01-01	1
\.


--
-- TOC entry 2406 (class 0 OID 0)
-- Dependencies: 166
-- Name: blocos_x_abas_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('blocos_x_abas_seq_seq', 19, true);


--
-- TOC entry 2328 (class 0 OID 16410)
-- Dependencies: 167 2373
-- Data for Name: campos; Type: TABLE DATA; Schema: public; Owner: -
--

COPY campos (seq, colunadb, campo, label, mascara, seletor, tpcaseq, tabseq, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, statseq, required, alteravel, autosave, manter, usuaseq, unidseq, datacad) FROM stdin;
385	unid	unid	Unidade:	\N	\N	1	37	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
436	diretor	diretor	Diretor:	\N	\N	1	6	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
802	situacao	situacao	\N	\N	\N	7	87	1	0	1	\N	0	0	\N	1	1	2	0	\N	1	1	1900-01-01
803	situacao	situacao	\N	\N	\N	7	87	1	0	2	\N	0	0	\N	1	0	2	0	\N	1	1	1900-01-01
817	titulo	tutiulo	Nome do convênio:	\N	\N	1	89	1	0	-	-	0	0	\N	1	1	1	0	\N	1	1	1900-01-01
818	descricao	descricao	Objeto do convênio:	\N	\N	9	89	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
819	tipoconvenio	tipoconvenio	Tipo de convênio:	\N	\N	2	89	1	0	-	-	0	0	\N	1	1	1	0	\N	1	1	1900-01-01
843	transeq	transeq	Transação:	\N	\N	1	65	0	0	-	-	0	0	\N	1	0	2	0	\N	1	1	1900-01-01
10	cnhValidade	cnhValidade	Valindade CNH: 	\N	\N	1	5	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
11	registroProfissional	registroProfissional		\N	\N	1	5	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
852	seq	parcseq	Cod. Conta:	\N	\N	1	65	0	0	-	-	0	0	\N	1	0	2	0	\N	1	1	1900-01-01
820	tipotransacao	tipotrasacao	Tipo de transação:	\N	\N	2	89	1	0	-	-	0	0	\N	1	1	1	0	\N	1	1	1900-01-01
125	statusDuplicata	statusDuplicata	Situação:	\N	\N	2	17	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
853	pessseq	pessseq	Pessoa:	\N	\N	2	65	0	0	-	-	0	0	\N	1	0	2	0	\N	1	1	1900-01-01
854	plcoseq	plcoseq	Plano de Contas:	\N	\N	2	65	0	0	-	-	0	0	\N	1	0	2	0	\N	1	1	1900-01-01
822	plcoseq	plcoseq	Plano de Conta:	\N	\N	2	89	1	0	-	-	0	0	\N	1	1	1	0	\N	1	1	1900-01-01
126	obs	obs		\N	\N	9	17	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
858	obs	obs	Observações:	\N	\N	9	65	0	0	-	-	0	0	\N	1	0	2	0	\N	1	1	1900-01-01
437	gerente	gerente	Gerente:	\N	\N	1	6	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
684	data	data	Data:	'99/99/9999',1	CLASS_CALENDARIO	10	46	1	0	function/TSetData/getData	setDataPT	setDataDB	0	\N	1	0	1	0	\N	1	1	1900-01-01
801	previsaoentrada	previsaoentrada	Data de Devolução:	'99/99/9999',1	CLASS_CALENDARIO	10	87	1	0	function/TSetData/getData	setDataPT	setDataDB	0	\N	1	1	2	0	\N	1	1	1900-01-01
679	dataaula	dataaula	Data da aula:	'99/99/9999',1	CLASS_CALENDARIO	10	28	1	0	function/TSetData/getData	setDataPT	setDataDB	0	\N	1	0	1	0	\N	1	1	1900-01-01
75	dataFim	dataFim	Data do término:	'99/99/9999',1	CLASS_CALENDARIO	10	11	1	0	function/TSetData/getData	setDataPT	setDataDB	0	\N	1	1	1	0	\N	1	1	1900-01-01
338	dataCad	dataCad	Data do Cadastro:	'99/99/9999',1	\N	1	1	1	0	function/TSetData/getData	setDataPT	setDataDB	0	\N	1	0	1	0	\N	1	1	1900-01-01
131	obs	obs	Observações:	\N	\N	9	18	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
804	statseq	validaLocacao	Confirmar	\N	\N	5	87	1	0	-	\N	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
218	peso	peso	Peso:	\N	\N	1	27	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
128	seq	seq	Cod.:	\N	\N	1	18	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
827	dialimite	dialimite	Dia Limite:	\N	\N	2	92	1	0	-	-	0	0	\N	1	1	1	0	\N	1	1	1900-01-01
239	experiencia	experiencia	Experiências Profissionais:	\N	\N	9	30	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
240	obs	obs	Informações Adicionais:	\N	\N	9	30	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
810	frequencia	frequencia	Nº de frequencia	\N	\N	1	28	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
813	conteudo	conteudo	Conteudo:	\N	\N	9	28	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
794	pessseq	pessseq	locador:	\N	\N	11	87	1	219	-	-	0	0	\N	1	1	2	0	\N	1	1	1900-01-01
796	pessseq	pessseq	Locador:	\N	\N	11	87	1	219	-	-	0	0	\N	1	1	2	0	\N	1	1	1900-01-01
797	livrseq	livrseq	Livro:	\N	\N	11	87	1	277	-	-	0	0	\N	1	1	2	0	\N	1	1	1900-01-01
798	pessseq	pessseq	Locador:	\N	\N	11	87	1	219	-	-	0	0	\N	1	1	2	0	\N	1	1	1900-01-01
816	pessseq	pessseq	Concedente:	\N	\N	11	89	1	219	-	-	0	0	\N	1	0	2	0	\N	1	1	1900-01-01
824	convseq	convseq	Convênio:	\N	\N	11	90	1	323	-	-	0	0	\N	1	1	1	0	\N	1	1	1900-01-01
814	obs	obs	Observações:	\N	\N	9	28	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
8	cnh	cnh	CNH: 	\N	\N	1	5	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
808	nometurma	nometurma	Turma Inicial:	\N	\N	1	16	0	0	-	-	0	0	\N	1	0	0	0	\N	1	1	1900-01-01
807	nomecurso	nomecurso	Curso:	\N	\N	1	16	0	0	-	-	0	0	\N	1	0	0	0	\N	1	1	1900-01-01
651	datainicio	datainicio	Data de início:	\N	\N	1	16	0	0	-	setDataPT	setDataDB	0	\N	1	0	0	0	\N	1	1	1900-01-01
815	setfaltaalunos	setfaltaalunos	Lançar Faltas	\N	\N	5	25	0	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
387	cor	cor	Cor:	\N	\N	1	37	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
247	nacionalidade	nacionalidade	Nacionalidade:	\N	\N	1	5	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
252	bairro	bairro	Setor:	\N	\N	1	1	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
253	cidade	cidade	Cidade:	\N	\N	1	1	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
254	estado	estado	Estado:	\N	\N	2	1	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
255	cep	cep	CEP:	'99.999-999',1	\N	1	1	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
256	email1	email1	E-mail:	\N	\N	1	1	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
388	tamanho	tamanho	Tamanho:	\N	\N	1	37	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
567	obs	obs	Obs.:	\N	\N	9	21	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
260	necessidadesEspeciais	necessidadesEspeciais	Quais?	\N	\N	9	5	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
261	carteiraReservista	carteiraReservista	Carteira de Reservista (Número):	\N	\N	1	5	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
264	cnh	cnh	Carteira de Habilitação:	\N	\N	2	5	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
265	conhecimentos	conhecimentos	Conhecimentos Necessários:	\N	\N	9	29	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
266	habilidades	habilidades	Habilidades Necessárias:	\N	\N	9	29	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
267	atitudes	atitudes	Atitudes Esperadas:	\N	\N	9	29	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
510	site	site	Site:	\N	\N	1	1	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
856	numparcela	numparcela	Parcela N°:	\N	\N	1	65	0	0	-	-	0	0	\N	1	0	2	0	\N	1	1	1900-01-01
718	obs	obs	Obs.:	\N	\N	9	76	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
831	quantidade	quantidadeproduto	Quantidade:	\N	\N	1	67	1	0	1	-	0	0	\N	1	1	1	0	\N	1	1	1900-01-01
268	preRequisitos	preRequisitos	Pré-Requisitos:	\N	\N	9	29	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
269	horarioTrabalho	horarioTrabalho	Horário de Trabalho:	\N	\N	2	29	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
270	maquinasUtilizadas	maquinasUtilizadas	Maquinas e Equipamentos Utilizados:	\N	\N	9	29	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
744	tpprseq	tpprseq	Tipo de Produto:	\N	\N	2	70	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
130	tipoCusto	tipoCusto	Tipo de custo:	\N	\N	2	18	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
825	tipodesconto	tipodesconto	Tipo:	\N	\N	2	92	1	0	-	-	0	0	\N	1	1	1	0	\N	1	1	1900-01-01
263	statseq	statseq	Situação:	\N	\N	2	14	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
259	portadorNecessidades	portadorNecessidades	Portador de Necessidades Especiais?	\N	\N	2	5	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
245	sexo	sexo	Sexo:	\N	\N	2	5	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
132	statseq	statseq	Situação:	\N	\N	2	18	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
127	statseq	statseq	Situação:	\N	\N	2	17	1	0	-	-	0	0	\N	0	0	1	0	\N	1	1	1900-01-01
257	tel1	tel1	Telefone Fixo:	\N	CLASS_UI_TELEFONE	1	1	1	0	-	setTelefone	setTelefoneDB	0	\N	1	0	1	0	\N	1	1	1900-01-01
271	grauRisco	grauRisco	Grau de Risco:	\N	\N	2	29	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
272	subordinado	subordinado	Subordinado a:	\N	\N	2	29	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
273	cargoAscendente	cargoAscendente	Cargos Ascendentes:	\N	\N	9	29	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
274	cargoDescendente	cargoDescendente	Cargos Descendentes:	\N	\N	9	29	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
276	cargaHoraria	cargaHoraria	Carga Horaria:	\N	\N	1	33	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
277	ministrante	ministrante	Ministrante:	\N	\N	1	33	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
278	curriculoMinistrante	curriculoMinistrante	Mini-Curriculo do Ministrante:	\N	\N	9	33	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
279	instituicaoCertificadora	instituicaoCertificadora	Instituição Certificadora:	\N	\N	1	33	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
223	nomeCargo	nomeCargo	Nome do Cargo:	\N	\N	1	29	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
226	nome	nome	Nome do Candidato:	\N	\N	1	30	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
24	endereco	endereco	Endereço:	\N	\N	9	1	1	0	-	-	0	0	\N	1	1	1	0	\N	1	1	1900-01-01
251	endereco	endereco	Endereço:	\N	\N	1	1	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
790	cdu	cdu	Classificação CDU:	\N	\N	1	86	1	0	-	-	0	0	\N	1	1	1	0	\N	1	1	1900-01-01
791	titulo	titulo	Titulo:	\N	\N	1	86	1	0	-	-	0	0	\N	1	1	1	0	\N	1	1	1900-01-01
275	nomeCurso	nomeCurso	Nome do Curso:	\N	\N	1	33	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
248	pessrgie	pessrgie	RG:	\N	\N	1	1	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
285	relatorioExame	relatorioExame	Relatório do Exame Ocupacional:	\N	\N	9	14	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
219	statseq	statseq	Situação:	\N	\N	2	27	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
288	perfil	perfil	Perfil do Funcionario:	\N	\N	9	14	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
290	cbo	cbo	C.B.O.:	\N	\N	1	14	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
291	salarioBase	salarioBase	Salário base:	\N	\N	1	29	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
855	valornominal	valornominal	Valor:	\N	CLASS_MASCARA_VALOR	11	65	0	0	-	setMoney	setFloat	0	\N	1	0	2	0	\N	1	1	1900-01-01
237	escolaridade	escolaridade	Escolaridade:	\N	\N	9	30	1	0	-	-	0	0	\N	0	0	1	0	\N	1	1	1900-01-01
28	pais	pais	País: 	\N	\N	1	1	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
29	referencia	endReferencia	Referência do Endereço: 	\N	\N	1	1	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
30	cep	cep	CEP: 	'99.999-999',1	\N	1	1	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
42	site	site	Site / Pagina Pessoal:	\N	\N	1	1	1	0		-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
49	tipoend	tipoend	Tipo: 	\N	\N	2	5	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
70	publicoAlvo	publicoAlvo	Publico Alvo:	\N	\N	9	9	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
72	cargaHorTotal	cargaHorTotal	Carga horária total:	\N	\N	1	9	1	0	-	-	0	0	\N	0	0	1	0	\N	1	1	1900-01-01
78	frequenciaAula	frequenciaAula	Frequência das aulas:	\N	\N	2	11	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
80	localAulas	localAulas	Local das Aulas:	\N	\N	1	11	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
89	statseq	statseq	Situação:	\N	\N	2	9	1	0	4	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
102	curriculo	curriculo		\N	\N	9	15	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
106	opCobranca	opCobranca	Usar Endereço de cobrança:	\N	\N	2	1	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
115	seq	seq	Cod.:	\N	\N	1	17	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
116	fonte	fonte	Fonte:	\N	\N	1	17	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
117	numDoc	numDoc	Nº do documento:	\N	\N	1	17	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
18	tipoSangueRH	tipoSangueRH	Fator RH: 	\N	\N	2	5	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
19	peso	peso	Peso: 	\N	\N	1	5	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
20	altura	altura	Altura: 	\N	\N	1	5	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
23	numDependentes	numDependentes	N. de Dependentes: 	\N	\N	1	5	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
38	referenciaComercial	referenciaComercial	Referências Comercias: 	\N	\N	1	5	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
39	referenciaPessoal	referenciaPessoal	Referência Pessoal: 	\N	\N	1	5	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
17	tipoSangue	tipoSangue	Tipo Sanguineo: 	\N	\N	2	5	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
119	tipoDuplicata	tipoDuplicata	Tipo da duplicata:	\N	\N	2	17	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
840	obs	obs	Observações:	\N	\N	9	94	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
836	titulo	titulo	Referência:	\N	\N	1	94	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
25	bairro	bairro	Bairro: 	\N	\N	1	1	1	0	-	-	0	0	\N	1	1	1	0	\N	1	1	1900-01-01
26	cidade	cidade	Cidade: 	\N	\N	1	1	1	0	-	-	0	0	\N	1	1	1	0	\N	1	1	1900-01-01
27	estado	estado	Estado: 	\N	\N	2	1	1	0	-	-	0	0	\N	1	1	1	0	\N	1	1	1900-01-01
103	statseq	statseq	Situação:	\N	\N	2	15	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
118	tipo	tipo	Tipo do movimento:	\N	\N	2	17	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
558	funcseq	funcseq	Fornecedor:	\N	\N	11	55	1	172	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
58	metodologia	metodologia		\N	\N	9	8	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
53	ementa	ementa		\N	\N	9	8	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
56	cargahoraria	cargahoraria	Carga horária:	\N	\N	1	8	1	0	-	-	0	0	\N	1	1	1	0	\N	1	1	1900-01-01
55	competencias	competencias		\N	\N	9	8	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
1	seq	seq	Cod.:	\N	\N	1	24	1	0	-	-	0	0	\N	0	0	1	0	\N	1	1	1900-01-01
68	arcuseq	arcuseq	Área do Curso:	\N	\N	2	9	1	0	-	\N	0	0	\N	1	1	1	0	\N	1	1	1900-01-01
54	programa	programa		\N	\N	9	8	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
57	biografia	biografia		\N	\N	9	8	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
293	beneficios	beneficios	Beneficios:	\N	\N	9	14	1	0	0	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
52	titulo	titulo	Disciplina:	\N	\N	1	8	1	0	-	-	0	0	\N	1	1	1	0	\N	1	1	1900-01-01
124	mora	mora	Mora dia:	\N	\N	1	17	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
389	peso	peso	Peso:	\N	\N	1	37	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
76	frequencia	frequencia	Nº. Total de Frequência:	\N	\N	1	12	1	0	-	\N	0	0	\N	1	1	1	1	\N	1	1	1900-01-01
77	datas	datas	Datas:	\N	\N	1	12	1	0	-	-	0	0	\N	1	0	1	1	\N	1	1	1900-01-01
86	discseq	discseq	\N	\N	CLASS_MULTISELECT	4	12	1	0	-	-	setDuplicacao	0	\N	1	1	1	0	\N	1	1	1900-01-01
67	nome	nome	Nome do Curso:	\N	\N	1	9	1	0	-	-	0	0	\N	1	1	1	0	\N	1	1	1900-01-01
141	seq	seq	Cod.:	\N	\N	1	65	0	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
147	obs	obs	Observações:	\N	\N	9	65	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
156	pessseq	pessseq	Pessoa:	\N	\N	2	21	1	0	-	-	0	0	\N	1	1	1	0	\N	1	1	1900-01-01
200	tipoConta	tipoConta	Tipo da conta:	\N	\N	2	24	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
201	banco	banco	Banco:	\N	\N	1	24	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
202	numConta	numConta	N da Conta:	\N	\N	1	24	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
203	agencia	agencia	Agencia:	\N	\N	1	24	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
204	saldoInicial	saldoInicial	Saldo Inícial:	\N	\N	1	24	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
199	nomeConta	nomeConta	Conta Caixa:	\N	\N	1	24	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
37	foneContatoNome	foneContatoNome	Nome do Contato: 	\N	\N	1	5	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
169	pessseq	pessseq	Pessoa:	\N	\N	2	21	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
170	plcoseq	plcoseq	Plano de conta:	\N	\N	2	21	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
139	tipoConta	tipoConta	Tipo da conta:	\N	\N	2	18	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
166	caixatroco	caixatroco	Troco:	\N	\N	1	21	0	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
22	filiacaoMae	filiacaoMae	Nome da Mãe: 	\N	\N	1	5	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
738	descricao	descricao	Descrição:	\N	\N	9	70	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
213	senha	senha	Senha:	\N	\N	6	26	1	0	-	-	setPass	0	\N	1	0	2	0	\N	1	1	1900-01-01
205	statseq	statseq	Situação:	\N	\N	2	24	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
198	statseq	statseq	Situação:	\N	\N	2	23	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
164	formadesconto	formadesconto	Forma de desconto:	\N	\N	2	21	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
212	usuario	usuario	Usuario:	\N	\N	1	26	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
215	seq	seq	Cod.:	\N	\N	1	27	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
216	avaliacao	avaliacao	Avaliação:	\N	\N	1	27	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
196	requisito	requisito	Pré-requisito:	\N	\N	1	23	1	0	-	-	0	0	\N	1	1	1	0	\N	1	1	1900-01-01
521	salaseq	salaseq	Sala:	\N	\N	11	12	1	175	-	-	0	0	\N	1	0	1	1	\N	1	1	1900-01-01
378	email2	email2	E-mail Secundario:	\N	\N	1	1	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
383	limitacoes	limitacoes	Limitações:	\N	\N	9	37	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
222	conteudo	conteudo	Conteudo:	\N	\N	9	28	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
83	valorMensal	valorMensal	Valor das parcelas:	\N	CLASS_MASCARA_VALOR	11	11	1	0	-	setMoney	setFloat	0	\N	1	1	1	0	\N	1	1	1900-01-01
174	fmpgseq	formaPag	Forma de Pagamento	\N	\N	2	21	1	0	-	-	0	0	\N	1	1	1	0	\N	1	1	1900-01-01
183	diasaula	diasaula	Dias da semana:	\N	\N	1	11	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
162	mora	mora	Mora dia:	\N	\N	2	21	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
160	valorentrada	valorentrada	Valor Recebido:	\N	CLASS_MASCARA_VALOR	11	21	1	0	-	-	setFloat	0	\N	1	1	1	0	\N	1	1	1900-01-01
69	objetivo	objetivo	Objetivo do Curso:	\N	\N	9	9	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
224	descricao	descricao	Descrição:	\N	\N	9	29	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
225	cargaHoraria	cargaHoraria	Carga Horaria (Semanal):	\N	\N	1	29	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
231	cidade	cidade	Cidade:	\N	\N	1	30	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
232	estado	estado	Estado:	\N	\N	2	30	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
233	bairro	bairro	Bairro:	\N	\N	1	30	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
236	email	email	E-mail:	\N	\N	1	30	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
712	dataaquisicao	dataAquisicao	Data de Aquisição:	'99/99/9999',1	\N	1	76	1	0	function/TSetData/getData	setDataPT	setDataDB	0	\N	1	0	1	0	\N	1	1	1900-01-01
711	datafabricacao	dataFabricacao	Data de Fabricação:	'99/99/9999',1	\N	1	76	1	0	function/TSetData/getData	setDataPT	setDataDB	0	\N	1	0	1	0	\N	1	1	1900-01-01
238	cursos	cursos	Cursos Extra Curriculares:	\N	\N	9	30	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
297	obs	obs	Observações:	\N	\N	9	14	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
302	descricao	descricao	Descrição:	\N	\N	9	32	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
303	tipo	tipo	Tipo de Patrimonio:	\N	\N	2	32	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
313	obs	obs	OBS.:	\N	\N	9	32	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
314	seq	seq	Cod.:	\N	\N	1	32	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
569	ementa	ementa	Ementa:	\N	\N	9	33	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
315	seq	seq	Cod.:	\N	\N	1	35	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
319	bairro	bairro	Bairro:	\N	\N	1	35	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
320	cidade	cidade	Cidade:	\N	\N	1	35	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
321	estado	estado	Estado:	\N	\N	2	35	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
322	cep	cep	CEP:	'99.999-999',1	\N	1	35	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
324	seq	seq	Cod.:	\N	\N	1	9	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
325	seq	seq	Cod.:	\N	\N	1	30	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
326	seq	seq	Cod.:	\N	\N	1	29	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
327	seq	seq	Cod.:	\N	\N	1	32	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
328	seq	seq	Cod.:	\N	\N	1	34	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
329	seq	seq	Cod.:	\N	\N	1	33	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
331	seq	seq	Cod.:	\N	\N	1	11	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
335	seq	seq	Cod.:	\N	\N	1	35	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
336	seq	seq	Cod.:	\N	\N	1	1	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
206	cofiseq	cofiseq	Conta/Caixa de Destino:	\N	\N	2	21	1	0	-	-	0	0	\N	1	1	1	0	\N	1	1	1900-01-01
177	cofiseq	cofiseq	Conta/Caixa de Origem:	\N	\N	2	21	1	0	-	-	0	0	\N	1	1	1	0	\N	1	1	1900-01-01
706	label	label	Nome do Livro:	\N	\N	1	76	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
341	pessrgie	pessrgie	RG:	\N	\N	1	1	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
342	pessteim	pessteim	Titulo de Eleitor:	\N	\N	1	1	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
344	estadoCivil	estadoCivil	Estado Civil:	\N	\N	2	5	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
345	tipoSanguineo	tipoSanguineo	Tipo Sanguineo:	\N	\N	2	5	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
349	pessrgie	pessrgie	Inscrição Estadual:	\N	\N	1	1	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
350	pessteim	pessteim	Inscrição Municipal:	\N	\N	1	1	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
351	diretor	diretor	Diretor da Empresa:	\N	\N	1	6	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
230	logadouro	logadouro	Endereço:	\N	\N	1	30	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
227	sexo	sexo	Sexo:	\N	\N	2	30	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
214	statseq	statseq	Situação:	\N	\N	2	26	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
343	etinia	etinia	Etnia:	\N	\N	2	5	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
235	celular	celular	Celular:	\N	CLASS_UI_TELEFONE	1	30	1	0	-	setTelefone	setTelefoneDB	0	\N	1	0	1	0	\N	1	1	1900-01-01
296	numerodependentes	numerodependentes	Quantidade de Dependentes:	\N	\N	1	5	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
318	endereco	endereco	Endereço:	\N	\N	1	35	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
352	gerente	gerente	Gerente da Empresa:	\N	\N	1	6	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
353	representante	representante	Representante da Empresa:	\N	\N	1	6	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
355	bairro	bairro	Bairro:	\N	\N	1	1	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
356	cidade	cidade	Cidade:	\N	\N	1	1	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
357	estado	estado	Estado:	\N	\N	2	1	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
358	cep	cep	CEP:	'99.999-999',1	\N	1	1	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
339	pessnmrz	pessnmrz	Nome:	\N	\N	1	1	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
311	foto	foto	Foto do Patrimonio:	\N	\N	8	32	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
360	referencia	referencia	Referencia de Endereço:	\N	\N	1	1	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
377	email1	email1	E-mail Primario:	\N	\N	1	1	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
347	pessnmrz	pessnmrz	Razão Social:	\N	\N	1	1	1	0	-	-	0	0	\N	1	1	1	0	\N	1	1	1900-01-01
382	beneficios	beneficios	Beneficios:	\N	\N	9	37	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
384	modoDeUso	modoDeUso	Modo de Uso:	\N	\N	9	37	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
386	qtde	qtde	Quantidade:	\N	\N	1	37	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
310	numnf	numNF	Número da Nota Fiscal:	\N	\N	1	32	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
739	desconto	desconto	Desconto:	\N	\N	1	66	1	0	-	-	setFloat	0	\N	1	0	1	1	\N	1	1	1900-01-01
390	altura	altura	Altura:	\N	\N	1	37	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
391	largura	largura	Largura:	\N	\N	1	37	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
392	comprimento	comprimento	Comprimento:	\N	\N	1	37	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
395	entrega	entrega	Tempo de Entrega (Dias):	\N	\N	1	38	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
396	pessseq	pessseq	Pessoa:	\N	\N	2	39	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
397	tipoDocumento	tipoDocumento	Documento:	\N	\N	2	39	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
779	setfaltaalunos	setfaltaalunos	Lançar Faltas	\N	\N	5	25	0	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
400	prodseq	prodseq	Produto:	\N	\N	2	39	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
405	nivel	nivel	Modulo:	\N	\N	2	40	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
406	modulo	modulo	Item do menu:	\N	\N	2	40	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
411	diasFeriasPrevisao	diasFeriasPrevisao	Quantidade de dias previstos:	\N	\N	1	41	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
414	diasFeriasReal	diasFeriasReal	Quantidade de dias:	\N	\N	1	41	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
418	agencia	agencia	Agencia:	\N	\N	1	42	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
419	numConta	numConta	N. Conta:	\N	\N	1	42	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
425	pessteim	titEleitorCliente	Titulo de Eleitor:	\N	\N	1	1	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
426	estadoCivil	estadoCivil	Estado Civil:	\N	\N	2	5	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
428	tipoSanguineo	tipoSanguineo	Tipo Sanguineo:	\N	\N	2	5	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
435	pessteim	inscMunCliente	Inscrição Municipal:	\N	\N	1	1	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
438	representante	representante	Representante:	\N	\N	1	6	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
416	nomeTitular	nomeTitular	Nome do Titular:	\N	\N	1	42	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
417	banco	banco	Nome do Banco:	\N	\N	1	42	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
432	pessnmrz	nomeJ_razaoSocial	Razão Social:	\N	\N	1	1	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
434	pessrgie	inscEst	Inscrição Estadual:	\N	\N	1	1	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
317	cnpj	cnpj	CNPJ:	'99.999.999/9999-99',1	\N	1	35	1	0	-	setCNPJ	validaCnpj	0	\N	1	0	1	0	\N	1	1	1900-01-01
372	tel2	tel2	Telefone 2	\N	CLASS_UI_TELEFONE	1	1	1	0	-	setTelefone	setTelefoneDB	0	\N	1	0	1	0	\N	1	1	1900-01-01
404	statseq	statseq	Situação:	\N	\N	2	26	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
442	estado	estado	Estado:	\N	\N	2	49	1	0	-	-	0	0	\N	1	1	1	0	\N	1	1	1900-01-01
422	pessnmrz	nome	Nome:	\N	\N	1	1	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
424	pessrgie	rg	RG:	\N	\N	1	1	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
337	tipo	tipo	Tipo de Fornecedor:	\N	\N	3	1	1	0	-	-	0	setTipoForm('tipo1')	\N	1	0	1	0	\N	1	1	1900-01-01
370	tel1	tel1	Telefone 1:	\N	CLASS_UI_TELEFONE	1	1	1	0	-	setTelefone	setTelefoneDB	0	\N	1	0	1	0	\N	1	1	1900-01-01
427	etinia	etinia	Etnia:	\N	\N	2	5	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
464	pessnmrfCobranca	pessnmrfCobranca	CPF / CNPJ:	\N	\N	1	49	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
466	cidadeCobranca	cidadeCobranca	Cidade:	\N	\N	1	49	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
548	turno	turno	Turno:	\N	\N	2	48	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
467	estadoCobranca	estadoCobranca	Estado:	\N	\N	2	49	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
468	cepCobranca	cepCobranca	CEP:	'99.999-999',1	\N	1	49	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
469	marca	marca	Marca:	\N	\N	1	32	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
470	modelo	modelo	Modelo:	\N	\N	1	32	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
474	inscEstadual	inscEstadual	Inscrição Estadual:	\N	\N	1	35	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
475	inscMunicipal	inscMunicipal	Inscrição Municipal:	\N	\N	1	35	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
476	diretor	diretor	Diretor:	\N	\N	1	35	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
477	gerente	gerente	Gerente Geral:	\N	\N	1	35	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
478	representante	representante	Representante:	\N	\N	1	35	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
483	curso	curso	Curso:	\N	\N	1	43	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
484	instituicao	instituicao	Instituição:	\N	\N	1	43	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
485	anoConclusao	anoConclusao	Ano de Conclusão:	\N	\N	1	43	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
486	observacao	observacao	Observações:	\N	\N	9	43	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
488	seq	seq	Cod.:	\N	\N	1	44	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
490	endereco	endereco	Endereço da sala:	\N	\N	1	44	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
491	descricao	descricao	Descrição:	\N	\N	9	44	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
509	razaoSocial	razaoSocial	Razão Social:	\N	\N	1	35	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
512	diaSemana	diaSemana	Dia da Semana	\N	\N	2	12	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
513	unidade	unidade	Unidade	\N	\N	1	12	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
780	seq	seq	Cód. Inscrição:	\N	\N	1	2	0	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
463	nomeCobranca	nomeCobranca	Nome:	\N	\N	1	49	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
489	nome	nome	Sala:	\N	\N	1	44	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
519	justificativa	justificativa	Justificativa:	\N	\N	9	46	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
393	pessseq	pessseq	Fornecedor:	\N	\N	11	38	1	165	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
408	funcseq	funcseq	Funcionários:	\N	\N	11	41	1	172	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
526	tempoEntrega	tempoEntrega	Tempo de Entrega:	\N	\N	1	47	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
527	quantidade	quantidade	Quantidade:	\N	\N	1	47	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
511	titulo	titulo	Nome da Área:	\N	\N	1	45	1	0	-	-	0	0	\N	1	1	1	0	\N	1	1	1900-01-01
535	entrega	entrega	Prazo de Entrega:	\N	\N	1	38	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
781	nomepessoa	nomepessoa	Nome:	\N	\N	1	2	0	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
482	tituseq	tituseq	Escolaridade:	\N	\N	2	43	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
714	lotacao	lotacao	Lotação:	\N	\N	2	76	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
455	email	email	E-mail:	\N	\N	1	1	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
421	tipo	tipo	Tipo de Cadastro:	\N	\N	3	1	1	0	-	-	0	setTipoForm('tipo1')	\N	1	0	1	0	\N	1	1	1900-01-01
493	statseq	statseq	Situação:	\N	\N	2	44	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
479	statseq	statseq	Situação:	\N	\N	2	35	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
480	telefone	telefone	Telefone:	\N	CLASS_UI_TELEFONE	1	35	1	0	-	setTelefone	setTelefoneDB	0	\N	1	0	1	0	\N	1	1	1900-01-01
598	item	item	Item:	\N	\N	1	59	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
520	status	status	Situação:	\N	\N	2	46	1	0	2	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
549	capitalSocial	capitalSocial	Capital Social:	\N	\N	1	50	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
554	descricao	descricao	Descrição:	\N	\N	9	53	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
557	seq	seq	Cod.:	\N	\N	1	55	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
559	plcoseq	plcoseq	Conta Débito:	\N	\N	1	55	0	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
560	pagBanco	pagBanco	Banco	\N	\N	1	14	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
561	pagAgencia	pagAgencia	Agencia:	\N	\N	1	14	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
562	pagConta	pagConta	Conta:	\N	\N	1	14	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
563	pagVencimento	pagVencimento	Dia para vencimento:	'99',1	\N	1	14	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
724	isbn	isbn	ISBN:	\N	\N	1	96	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
565	regimeContrato	regimeContrato	Regime de Contrato:	\N	\N	2	14	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
568	obs	obs	Obs.:	\N	\N	9	21	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
570	titulo	titulo	Titulo:	\N	\N	1	57	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
571	descricao	descricao	Descrição:	\N	\N	9	57	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
572	categoria	categoria	Categoria:	\N	\N	2	18	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
574	obs	obs	Observações:	\N	\N	9	28	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
575	estadoCivil	estadoCivil	Estado Civil:	\N	\N	2	30	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
576	cnh	cnh	Carteira de Habilitação:	\N	\N	2	30	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
577	dependentes	dependentes	Nº de Dependentes:	\N	\N	1	30	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
578	areaInteresse	areaInteresse	Primeira:	\N	\N	2	30	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
579	idiomas	idiomas	Idiomas Falados:	\N	\N	9	30	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
580	resumo	resumo	Resumo do Curriculo:	\N	\N	9	30	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
581	areaInteresse2	areaInteresse2	Segunda:	\N	\N	2	30	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
507	custoHospedagem	custohospedagem	Custo Hospedagem:	\N	\N	1	12	1	0	-	setMoney	setFloat	0	\N	1	0	1	1	\N	1	1	1900-01-01
508	custoDeslocamento	custodeslocamento	Custo Deslocamento:	\N	\N	1	12	1	0	-	setMoney	setFloat	0	\N	1	0	1	1	\N	1	1	1900-01-01
582	areaInteresse3	areaInteresse3	Terceira:	\N	\N	2	30	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
584	conteudo	conteudo	Conteudo:	\N	\N	9	28	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
585	obs	obs	Observações:	\N	\N	9	28	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
588	dataAtualizacao	dataAtualizacao		\N	\N	7	12	1	0	-	-	0	atualizaDataCampo('dataAtualizacao')	\N	1	0	1	0	\N	1	1	1900-01-01
514	coordenador	coordenador	Coordenador:	\N	\N	11	12	1	172	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
516	alunseq	alunseq	Aluno:	\N	\N	11	46	1	423	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
523	prodseq	prodseq	Produto:	\N	\N	11	47	1	180	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
589	titulo	titulo	Titulo:	\N	\N	1	58	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
590	objetivo	objetivo	Objetivo:	\N	\N	9	58	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
591	prazo	prazo	Prazo Máximo (em dias):	\N	\N	1	58	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
592	resumo	resumo	Resumo:	\N	\N	9	58	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
593	recurso	recurso	Recurso:	\N	\N	1	61	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
594	quantidade	quantidade	Quantidade:	\N	\N	1	61	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
595	tempo	tempo	Tempo de uso (em dias):	\N	\N	1	61	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
596	tipoUso	tipoUso	Forma de uso:	\N	\N	2	61	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
600	descRisco	descRisco	Descrição de riscos:	\N	\N	9	58	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
601	medidasRisco	medidasRisco	Medidas para contensão de riscos:	\N	\N	9	58	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
602	descResultado	descResultado	Descrição do resultado esperado:	\N	\N	9	58	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
553	material	material	Nome do Material:	\N	\N	1	53	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
603	responsavelNome	responsavelNome	Responsavel pelo projeto:	\N	\N	1	58	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
604	responavelFuncao	responsavelFuncao	Função do responsavel:	\N	\N	1	58	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
605	colaborador	colaborador	Colaborador:	\N	\N	1	60	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
606	funcao	funcao	Função:	\N	\N	1	60	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
607	receitaPropria	receitaPropria	Própria:	\N	\N	1	58	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
608	receitaCliente	receitaCliente	Clientes:	\N	\N	1	58	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
609	receitaParceiros	receitaParceiros	Parceiros:	\N	\N	1	58	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
610	receitaFornecedores	receitaFornecedores	Fornecedores:	\N	\N	1	58	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
611	receitaTotal	receitaTotal	Total:	\N	\N	1	58	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
613	recursosTotal	recursosTotal	Total:	\N	\N	1	58	0	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
617	conteudo	conteudo		\N	\N	9	62	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
618	recursos	recursos		\N	\N	9	62	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
619	metodologia	metodologia		\N	\N	9	62	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
622	titulo	titulo	Titulo:	\N	\N	1	63	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
623	obs	obs	Observações:	\N	\N	9	63	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
625	pis_pasep	pis_pasep	PIS/PASEP:	\N	\N	1	14	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
626	rendaMensal	rendaMensal	Renda Mensal:	\N	\N	1	5	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
40	email1	email1	E-mail: 	\N	\N	1	1	1	0	-	-	0	0	\N	1	1	1	0	\N	1	1	1900-01-01
551	plcoseq	plcoseq	Plano de conta	\N	\N	2	11	1	0	-	-	0	0	\N	1	1	1	0	\N	1	1	1900-01-01
636	tabelaProduto	tabelaProduto		\N	\N	7	67	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
668	tabelaProduto	tabelaProduto		\N	\N	7	67	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
677	deptseq	deptseq	Departamento:	\N	\N	2	46	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
646	fornecedor	fornecedor	Fornecedor:	\N	\N	2	1	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
647	funcionario	funcionario	Funcionario:	\N	\N	2	1	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
675	obs	obs	Observações:	\N	\N	9	67	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
676	obs	obs	Observações:	\N	\N	9	67	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
680	conteudo	conteudo	Conteudo:	\N	\N	9	28	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
686	statseq	statseq		\N	\N	7	46	1	0	2	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
637	seq	seq	Cod.:	\N	\N	1	11	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
687	deptseq	deptseq	Departamento:	\N	\N	2	14	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
547	cursseq	cursseq	Curso:	\N	\N	11	48	1	184	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
566	empTerc	pessseq	Empresa Vinculada:	\N	\N	11	14	1	165	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
691	obs	obs	Observações:	\N	\N	9	74	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
698	justificativa	justificativa	Justificativa:	\N	\N	9	46	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
688	funcseq	funcseq	Responsavel:	\N	\N	2	74	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
690	salaseq	salaseq	Lotação:	\N	\N	2	74	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
699	atendimento	atendimento	Atendimento:	\N	\N	9	46	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
783	seq	seq	Codigo:	\N	\N	1	76	0	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
650	acrescimo	acrescimo	Acréscimo:	\N	\N	1	66	0	0	-	-	0	0	\N	1	0	1	1	\N	1	1	1900-01-01
665	seq	seq	Cod.:	\N	\N	1	66	1	0	-	-	0	0	\N	1	0	1	1	\N	1	1	1900-01-01
681	obs	obs	Observações:	\N	\N	9	28	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
701	escolaridade	escolaridade	Escolaridade:	\N	\N	2	33	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
765	titulo	titulo	Titulo:	\N	\N	1	82	1	0	-	\N	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
728	tabelaX	tabelaX	Módulo X:	\N	\N	2	78	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
692	funcionario	funcionario	\N	\N	\N	12	1	1	0	true	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
659	stmoseq	tipomovimentacao	Movimentação:	\N	\N	2	21	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
656	plcoseq	plcoseq	Plano de Conta:	\N	\N	2	21	1	0	-	-	0	0	\N	1	1	1	0	\N	1	1	1900-01-01
552	sttuseq	sttuseq	Situação da Turma:	\N	\N	2	11	1	0	-	-	0	0	\N	1	1	1	0	\N	1	1	1900-01-01
655	transeq	transeq	\N	\N	\N	13	21	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
661	tipo	tipo		\N	\N	7	66	0	0	D	-	0	0	\N	1	0	1	1	\N	1	1	1900-01-01
685	justificativa	justificativa	Justificativa:	\N	\N	9	46	1	0	function/TUsuario/getCodigoPessoa	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
729	colunaX	colunaX	Informação X:	\N	\N	1	78	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
654	seq	seq	Cod.:	\N	\N	1	66	1	0	-	-	0	0	\N	1	0	2	1	\N	1	1	1900-01-01
700	statseq	statseq	Nova situação:	\N	\N	2	46	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
627	tipoExtorno	tipoExtorno	Extorno:	\N	\N	2	64	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
703	arcuseq	arcuseq	Área:	\N	\N	2	75	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
732	colunaY	colunaY	Informação Y:	\N	\N	1	78	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
734	titulo	titulo	Titulo:	\N	\N	1	77	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
736	pareto	pareto	Pareto:	\N	\N	1	77	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
737	agrupamentoPeriodico	agrupamentoPeriodico	Agrupamento Periodico:	\N	\N	2	77	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
755	obs	obs	Observações:	\N	\N	9	80	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
766	obs	obs	Observações:	\N	\N	9	82	1	0	-	\N	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
758	tipoAssinatura	tipoAssinatura	Assinatura:	\N	\N	2	39	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
761	tipo	tipo	Tipo:	\N	\N	2	63	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
683	alsoseq	alsoseq	Solicitação:	\N	\N	2	46	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
696	alunseq	alunseq	Aluno:	\N	\N	2	46	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
764	discseq	discseq	Disciplinas do curso:	\N	\N	2	12	1	0	-	\N	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
704	profseq	profseq	Professor:	\N	\N	2	75	1	0	-	-	0	0	\N	1	1	1	0	\N	1	1	1900-01-01
735	meta	meta	Meta:	\N	\N	1	77	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
973	seq	seq	\N	\N	\N	7	22	0	0	-	\N	\N	\N	\N	1	0	1	0	\N	1	1	1900-01-01
769	numTentativas	numTentativas	Número de Tentativas:	\N	\N	1	82	1	0	-	\N	0	0	Número de vezes que um usuário pode abrir o questionário.	1	0	1	0	\N	1	1	1900-01-01
129	nomeConta	nomeConta	Nome da conta:	\N	\N	1	18	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
316	nomeUnidade	nomeUnidade	Nome da Unidade:	\N	\N	1	35	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
671	label	label	Nome:	\N	\N	1	70	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
629	contaOrigem	pesqContaOrigemC	Conta a Extornar:	\N	\N	11	64	1	205	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
634	prodseq	prodseq	Produto:	\N	\N	11	67	1	208	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
678	funcseq	funcseq	Funcionário:	\N	\N	11	46	1	172	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
689	label	label	Nome:	\N	\N	1	74	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
723	ano	ano	Ano:	'9999',1	\N	1	96	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
725	tradutor	tradutor	Traduzido por:	\N	\N	1	96	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
726	sinopse	sinopse	Sinopse:	\N	\N	9	96	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
727	sumario	sumario	Sumário:	\N	\N	9	96	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
785	phaseq	phaseq	Classificação PHA:	\N	\N	1	96	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
707	marca	marca	Editora:	\N	\N	1	76	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
708	modelo	modelo	Edição:	\N	\N	1	76	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
709	descricao	descricao	Descrição:	\N	\N	9	76	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
710	tipo	tipo		\N	\N	7	76	1	0	5	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
21	filiacaoPai	filiacaoPai	Nome do Pai: 	\N	\N	1	5	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
664	plcoseq	plcoseq	Plano de Contas:	\N	\N	2	66	1	0	-	-	0	0	\N	1	1	1	1	\N	1	1	1900-01-01
740	acrescimo	acrescimo	Acréscimo: 	\N	\N	1	66	1	0	-	-	0	0	\N	1	0	1	1	\N	1	1	1900-01-01
751	numParcelas	numParcelas	Parcelas:	\N	\N	1	66	1	0	-	-	0	0	\N	1	0	1	1	\N	1	1	1900-01-01
770	numQuestoesMax	numQuestoesMax	Número de Questões por questionário:	\N	\N	1	82	1	0	-	\N	0	0	Número de questões liberadas por usuário. Permite o usar randerização de questões.	1	0	1	0	\N	1	1	1900-01-01
771	enunciado	enunciado	Enunciado:	\N	\N	9	83	1	0	-	\N	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
772	tipoQuestao	tipoQuestao	Tipo:	\N	\N	2	83	1	0	-	\N	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
242	pessnmrz	pessnmrz	Nome do Funcionario:	\N	\N	1	1	1	0	-	-	0	0	\N	1	1	1	0	\N	1	1	1900-01-01
774	obs	obs	Observações:	\N	\N	9	83	1	0	-	\N	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
180	tpcuseq	tpcuseq	Tipo do Curso:	\N	\N	2	9	1	0	-	-	0	0	\N	1	1	1	0	\N	1	1	1900-01-01
154	titulo	titulo	Nome da Turma:	\N	\N	1	11	1	0	-	-	0	0	\N	1	1	1	0	\N	1	1	1900-01-01
753	titulo	titulo	Tipo:	\N	\N	1	80	1	0	-	-	0	0	Nome do tipo de curso.Ex: Treinamento	1	0	1	0	\N	1	1	1900-01-01
757	salaAula	salaAula	Sala de aula:	\N	\N	2	44	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
754	statseq	statseq	Situação:	\N	\N	2	80	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
733	agrupamentoY	agrupamentoY	Forma de Agrupamento Y:	\N	\N	2	78	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
730	agrupamentoX	agrupamentoX	Forma de Agrupamento X:	\N	\N	2	78	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
71	discseq	discseq	\N	\N	CLASS_MULTISELECT	4	10	1	0	-	-	setDuplicacao	0	\N	1	1	1	0	\N	1	1	1900-01-01
777	titulo	titulo	Referência:	\N	\N	1	85	1	0	-	\N	0	0	\N	1	1	1	0	\N	1	1	1900-01-01
778	obs	obs	Observações:	\N	\N	9	85	1	0	-	\N	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
767	dataInicio	dataInicio	Data de Início:	\N	\N	1	82	1	0	-	setDataPT	setDataDB	0	\N	1	0	1	0	\N	1	1	1900-01-01
768	dataFim	dataFim	Data de Término:	\N	\N	1	82	1	0	-	setDataPT	setDataDB	0	\N	1	0	1	0	\N	1	1	1900-01-01
860	numdoc	numdoc	N° do documento:	\N	\N	1	21	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
722	outrosautores	outrosAutores	Outros Autores:	\N	\N	9	96	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
788	idioma	idioma	Idioma:	\N	\N	1	96	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
789	paginas	paginas	Nº de Paginas:	\N	\N	1	96	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
717	numnf	numNF	Número NF:	\N	\N	1	76	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
694	tudiseq	tudiseq	Nova Disciplina:	\N	\N	11	56	1	226	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
666	prodseq	prodseq	Produto:	\N	\N	11	67	1	208	-	-	0	0	\N	1	1	2	0	\N	1	1	1900-01-01
663	pessseq	pessseq	Fornecedor:	\N	\N	11	66	1	165	-	-	0	0	\N	1	1	2	1	\N	1	1	1900-01-01
705	avalseq	avalseq	Avaliação Antecessora:	\N	\N	11	27	1	235	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
776	pjcuseq	pjcuseq	Curso:	\N	\N	11	85	1	310	-	\N	0	0	\N	1	1	2	0	\N	1	1	1900-01-01
786	cursseq	cursseq	Referência do curso:	\N	\N	11	11	1	184	-	\N	\N	0	\N	1	1	2	0	\N	1	1	1900-01-01
633	cursseq	cursseq	Curso:	\N	\N	11	16	1	184	-	-	0	0	\N	1	1	2	0	\N	1	1	1900-01-01
868	transeq	transeq	Transação:	\N	\N	1	65	1	0	-	-	0	0	\N	1	0	2	0	\N	1	1	1900-01-01
632	pessseq	pessseq	Cliente:	\N	\N	2	66	1	0	-	-	0	0	\N	1	1	2	1	\N	1	1	1900-01-01
4	frequencia	frequencia	Nº. de frequências:	\N	\N	1	28	1	0	1	-	0	0	\N	1	0	1	1	\N	1	1	1900-01-01
3	frequencia	frequencia	Nº. de frequências:	\N	\N	1	28	1	0	1	-	0	0	\N	1	0	1	1	\N	1	1	1900-01-01
869	seq	seq	Conta:	\N	\N	1	65	1	0	-	-	0	0	\N	1	0	2	0	\N	1	1	1900-01-01
657	cofiseq	cofiseq	Conta de Destino:	\N	\N	2	21	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
873	nometitular	nometitular	Titular:	\N	\N	1	95	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
874	banco	banco	Banco:	\N	\N	1	95	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
875	agencia	agencia	Agência:	\N	\N	1	95	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
876	numconta	numconta	Conta:	\N	\N	1	95	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
877	numcheque	numcheque	Nº do Cheque:	\N	\N	1	95	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
773	valorQuestao	valorQuestao	Valor:	\N	\N	1	83	1	0	-	\N	setFloat	0	\N	1	0	1	0	\N	1	1	1900-01-01
658	numdoc	numdoc	Nº de Documento:	\N	\N	1	21	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
612	custosTotal	custosTotal	Total:	\N	CLASS_MASCARA_VALOR	11	58	0	0	-	setMoney	setFloat	0	\N	1	0	1	0	\N	1	1	1900-01-01
882	statusconta	statusconta	Conta programada	\N	\N	2	65	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
883	obs	obs	Cod. da Conta:	\N	\N	1	18	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
884	pessnmrf	pessnmrf	CPF/CNPJ:	\N	\N	1	95	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
885	stmoseq	stmoseq	Tipo de movimento:	\N	\N	2	21	1	0	1	-	0	0	Define o tipo de movimento Ex: Movimento programado.	1	0	2	0	\N	1	1	1900-01-01
163	fmpgseq	formapag	Forma de pagamento:	\N	\N	2	21	1	0	-	-	0	0	\N	1	1	1	0	\N	1	1	1900-01-01
861	acrescimo	acrescimo	Acréscimos:	\N	CLASS_MASCARA_VALOR	11	21	1	0	0	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
721	autor	autor	Autor:	\N	\N	1	96	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
9	cnhCategoria	cnhCategoria	Categoria CNH: 	\N	\N	2	5	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
614	tudiseq	tudiseq	Disciplina:	\N	\N	2	62	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
631	turmseq	turmseq	Turmas Disponiveis:	\N	\N	2	16	1	0	-	-	0	0	\N	1	1	2	1	\N	1	1	1900-01-01
615	profseq	profseq	\N	\N	\N	7	62	1	0	function/TUsuario/getCodigoProfessor	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
886	volume	volume	Volume:	\N	\N	1	96	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
152	intervaloParcelas	intervaloParcelas	Intervalo:	\N	\N	1	66	0	0	-	-	0	0	Caso o valor do intervalo seja omitido o sistema aplica o valor padrão de 30 dias como intervalo entre as parcelas.	1	0	1	1	\N	1	1	1900-01-01
900	cofiseq	cofiseq	Conta Caixa:	\N	\N	2	94	1	0	-	-	0	0	\N	1	1	2	0	\N	1	1	1900-01-01
743	intervaloParcelas	intervaloParcelas	Intervalo:	\N	\N	1	66	1	0	-	-	0	0	Caso o valor do intervalo seja omitido o sistema aplica o valor padrão de 30 dias como intervalo entre as parcelas.	1	0	1	1	\N	1	1	1900-01-01
750	buttonTransacaoD	buttonTransacaoD	Gerar Contas	\N	\N	5	66	0	0	-	-	0	0	\N	1	0	2	1	\N	1	1	1900-01-01
896	intervaloParcelas	intervaloParcelas	Intervalo:	\N	\N	1	66	1	0	-	-	0	0	\N	1	0	1	1	\N	1	1	1900-01-01
897	buttonTransacaoC	buttonTransacaoC	Gerar Contas	\N	\N	5	66	0	0	-	-	0	0	\N	1	0	2	1	\N	1	1	1900-01-01
898	numparcelas	numParcelas	Parcelas:	\N	\N	1	66	1	0	-	-	0	0	\N	1	0	1	1	\N	1	1	1900-01-01
907	obs	obs	Nº do Doc.:	\N	\N	1	16	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
641	plcoseq	plcoseq	Plano de Contas:	\N	\N	2	66	1	0	-	-	0	0	\N	1	1	2	1	\N	1	1	1900-01-01
901	seq	seq	Cod.:	\N	\N	1	66	1	0	-	-	0	0	\N	1	0	2	1	\N	1	1	1900-01-01
906	obs	obs	\N	\N	\N	7	56	1	0	-	-	0	0	\N	1	0	2	0	\N	1	1	1900-01-01
891	desconto	desconto	Desconto:	\N	\N	1	66	1	0	-	-	setFloat	0	\N	1	0	1	1	\N	1	1	1900-01-01
892	acrescimo	acrescimo	Acrescimo:	\N	\N	1	66	1	0	-	-	setFloat	0	\N	1	0	1	1	\N	1	1	1900-01-01
715	funcseq	funcseq	Responsavel:	\N	\N	11	76	1	172	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
775	profseq	profseq	Professor:	\N	\N	11	12	1	221	-	\N	0	0	\N	1	0	1	1	\N	1	1	1900-01-01
784	ccduseq	ccduseq	Classificação CDU:	\N	\N	11	96	1	272	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
870	valornominal	valornominal	Valor nominal:	\N	CLASS_MASCARA_VALOR	11	65	1	0	-	setMoney	setFloat	0	\N	1	0	2	0	\N	1	1	1900-01-01
881	valorcalculado	valorcalculado	Valor Calculado:	\N	CLASS_MASCARA_VALOR	11	21	0	0	-	setMoney	setFloat	0	\N	1	0	1	0	\N	1	1	1900-01-01
878	valor	valor	Valor:	\N	CLASS_MASCARA_VALOR	11	95	1	0	-	setMoney	setFloat	0	\N	1	0	1	0	\N	1	1	1900-01-01
197	obs	obs	Observações:	\N	\N	9	23	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
194	endereco	endereco	Endereço:	\N	\N	1	11	1	0	-	-	0	0	\N	0	0	1	0	\N	1	1	1900-01-01
465	logradouroCobranca	logradouroCobranca	Endereço:	\N	\N	1	49	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
234	telefone	telefone	Telefone:	\N	CLASS_UI_TELEFONE	1	30	1	0	-	setTelefone	setTelefoneDB	0	\N	1	0	1	0	\N	1	1	1900-01-01
258	cel1	cel1	Celular:	\N	CLASS_UI_TELEFONE	1	1	1	0	-	setTelefone	setTelefoneDB	0	\N	1	0	1	0	\N	1	1	1900-01-01
376	cel2	cel2	Celular 2:	\N	CLASS_UI_TELEFONE	1	1	1	0	-	setTelefone	setTelefoneDB	0	\N	1	0	1	0	\N	1	1	1900-01-01
374	cel1	cel1	Celular 1	\N	CLASS_UI_TELEFONE	1	1	1	0	-	setTelefone	setTelefoneDB	0	\N	1	0	1	0	\N	1	1	1900-01-01
909	vagas	vagas	Vagas:	\N	\N	1	11	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
697	alsoseq	alsoseq	Solicitação:	\N	\N	2	46	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
517	alsoseq	alsoseq	Solicitação:	\N	\N	2	46	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
719	foto	foto	Foto:	\N	\N	8	76	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
624	arquivo	arquivo	Arquivo:	\N	\N	8	63	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
916	nomepessoa	nomepessoa	Nome:	\N	\N	1	99	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
880	padraovencimento	padraovencimento	Intervalo de Vencimentos:	\N	\N	2	11	1	0	0	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
354	endereco	endereco	Endereço:	\N	\N	1	1	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
908	aceitainscricao	aceitainscricao	Visível no site:	\N	\N	2	15	1	0	1	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
630	tipo	tipo		\N	\N	7	66	0	0	C	-	0	0	\N	1	0	2	1	\N	1	1	1900-01-01
917	referencia	referencia	Referência:	\N	\N	1	99	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
918	interessado	interessado	Interessado:	\N	\N	1	99	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
921	email	email	E-mail:	\N	\N	1	99	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
922	obs	obs	Anotações:	\N	\N	9	99	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
919	tel1	tel1	Telefone:	\N	CLASS_UI_TELEFONE	1	99	1	0	-	setTelefone	setTelefoneDB	0	\N	1	0	1	0	\N	1	1	1900-01-01
920	tel2	tel2	Celular:	\N	CLASS_UI_TELEFONE	1	99	1	0	-	setTelefone	setTelefoneDB	0	\N	1	0	1	0	\N	1	1	1900-01-01
923	situacao	situacao	Situação:	\N	\N	2	99	1	0	Aberto	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
928	nomedisciplina	nomedisciplina	Disciplina:	\N	\N	1	100	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
929	cargahoraria	cargahoraria	C.H.:	\N	\N	1	100	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
930	ementa	ementa	Ementa:	\N	\N	9	100	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
821	valor	valor	Valor:	\N	CLASS_MASCARA_VALOR	11	89	1	0	-	setMoney	setFloat	0	\N	1	1	1	0	\N	1	1	1900-01-01
899	valortotal	valortotal	Valor Total:	\N	CLASS_MASCARA_VALOR	11	66	0	0	-	setMoney	setFloat	0	\N	1	0	2	1	\N	1	1	1900-01-01
894	valorcorrigido	valorcorrigido	Valor Corrigido:	\N	CLASS_MASCARA_VALOR	11	66	1	0	-	setMoney	setFloat	0	\N	1	0	1	1	\N	1	1	1900-01-01
826	valordescontado	valordescontado_desc_prog	Valor/Percentual:	\N	CLASS_MASCARA_VALOR	11	92	1	0	-	setMoney	setFloat	0	\N	1	1	1	0	\N	1	1	1900-01-01
931	nota	nota	Nota:	\N	\N	1	100	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
105	pessseq	pessseq	Cliente:	\N	\N	11	16	1	143	-	-	0	0	\N	1	1	1	1	\N	1	1	1900-01-01
913	pessseq	pessseq	Cliente:	\N	\N	11	16	1	143	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
932	frequencia	frequencia	Frequência:	\N	\N	1	100	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
933	justificativa	justificativa	\N	\N	\N	9	25	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
402	usuario	usuario	Nome de usuário:	\N	\N	1	26	1	0	-	-	0	0	\N	1	1	2	0	\N	1	1	1900-01-01
403	senha	senha	Senha de acesso:	\N	\N	6	26	1	0	-	-	setPass	0	\N	1	1	2	1	\N	1	1	1900-01-01
292	gratificacao	gratificacao	Gratificação:	\N	\N	1	14	1	0	0	-	0	0	\N	1	0	1	1	\N	1	1	1900-01-01
284	cargseq	cargseq	Cargo:	\N	\N	2	14	1	0	-	-	0	0	\N	1	1	1	1	\N	1	1	1900-01-01
935	instituicao	instituicao	Instituição:	\N	\N	1	100	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
936	ano	ano	Ano de Conclusão:	\N	\N	1	100	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
2	frequencia	frequencia	Nº. de frequências:	\N	\N	1	28	1	0	1	-	0	0	\N	1	1	1	1	\N	1	1	1900-01-01
682	alunseq	alunseq	Aluno:	\N	\N	2	46	1	0	function/TUsuario/getCodigoAluno	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
910	capacidade	capacidade	Capacidade máxima:	\N	\N	1	44	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
937	avaliacao	avaliacao	Nome da Avaliação:	\N	\N	1	101	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
939	peso	peso	Peso:	\N	\N	1	101	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
217	notamax	notamax	Nota Máxima:	\N	\N	2	27	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
73	cursseq	cursseq	Curso:	\N	\N	2	11	1	184	-	setAlocaDados	setAlocaDados	0	\N	1	1	2	1	\N	1	1	1900-01-01
348	pessnmrf	cnpjFornecedor	CNPJ:	'99.999.999/9999-99',1	\N	1	1	1	0	-	setCpfCnpj	validaCpfCnpj	0	\N	1	1	1	0	\N	1	1	1900-01-01
938	notamax	notamax	Nota Máxima:	\N	\N	2	101	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
940	descricao	descricao	Descrição:	\N	\N	9	45	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
941	mercadodetrabalho	mercadodetrabalho	Mercado de Trabalho:	\N	\N	9	9	1	0	-	\N	\N	\N	\N	1	0	1	0	\N	1	1	1900-01-01
944	convseq	convseq	Convênio:	\N	\N	2	103	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
943	dialimite	dialimite	Dia Limite:	\N	\N	2	102	1	0	-	-	0	0	Caso o desconto não tenha validade, mantenha o valor ''--'' (Mantendo o valor no campo ''Outras deduções/Abatimentos'' do boleto).	1	0	1	0	\N	1	1	1900-01-01
945	convseq	convseq	Convênio:	\N	\N	2	104	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
702	valorCorrigido	valorCorrigido	Valor total corrigido:	\N	CLASS_MASCARA_VALOR,CLASS_DESTAQUE	1	66	0	0	-	-	setFloat	0	\N	1	0	1	1	\N	1	1	1900-01-01
673	valorAlteravel	valorAlteravel	Valor pode ser alterado:	\N	\N	2	70	1	0	-	-	setFloat	0	Define se o valor pode sofrer alteração durante a negociação.	1	0	1	0	\N	1	1	1900-01-01
645	cliente	cliente	Cliente:	\N	\N	2	1	1	0	true	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
309	valorcompra	valorCompra	Valor de Compra:	\N	\N	1	32	1	0	-	-	setFloat	0	\N	1	0	1	0	\N	1	1	1900-01-01
122	valorPago	valorPago	Valor Pago:	\N	\N	1	17	1	0	-	-	setFloat	0	\N	1	0	1	0	\N	1	1	1900-01-01
176	desconto	desconto	Desconto:	\N	\N	1	21	1	0	-	-	setFloat	0	\N	1	0	1	0	\N	1	1	1900-01-01
649	desconto	desconto	Desconto:	\N	\N	1	66	0	0	-	-	setFloat	0	\N	1	0	1	1	\N	1	1	1900-01-01
951	titulo	titulo	Titulo	\N	\N	1	105	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
952	observacoes	observacoes	Obs.:	\N	\N	9	105	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
953	avaliacao	avaliacao	Avaliação:	\N	\N	1	106	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
954	peso	peso	Peso:	\N	\N	1	106	1	0	-	\N	\N	\N	\N	1	0	1	0	\N	1	1	1900-01-01
960	condicao	condicao	Condição:	\N	\N	9	106	1	0	-	\N	\N	\N	\N	1	0	1	0	\N	1	1	1900-01-01
955	ordem	ordem	Ordem:	\N	\N	1	106	1	0	-	\N	\N	\N	\N	1	0	1	0	\N	1	1	1900-01-01
956	rgavseq	rgavseq	Regra para a Avaliação:	\N	\N	2	106	1	0	-	\N	\N	\N	\N	1	0	1	0	\N	1	1	1900-01-01
957	incontrol	incontrol	Função de controle:	\N	\N	1	106	1	0	-	\N	\N	\N	\N	1	0	1	0	\N	1	1	1900-01-01
959	referencia	referencia	Referência:	\N	\N	1	106	1	0	-	\N	\N	\N	\N	1	0	1	0	\N	1	1	1900-01-01
294	valorBeneficios	valorBeneficios	Valor total dos Beneficios:	\N	CLASS_MASCARA_VALOR	11	14	1	0	0	setMoney	setFloat	0	\N	1	0	1	0	\N	1	1	1900-01-01
857	vencimento	vencimento	Vencimento:	'99/99/9999',1	\N	1	65	0	0	function/TSetData/getData	setDataPT	setDataDB	0	\N	1	0	2	0	\N	1	1	1900-01-01
720	dataverificacao	dataVerificacao	Data da Última Verificação:	'99/99/9999',1	\N	1	76	1	0	function/TSetData/getData	setDataPT	setDataDB	0	\N	1	0	1	0	\N	1	1	1900-01-01
481	dataCad	dataCad	Data do Cadastro:	'99/99/9999',1	\N	1	1	1	0	function/TSetData/getData	setDataPT	setDataDB	0	\N	1	0	1	0	\N	1	1	1900-01-01
961	custoalimentacao	custoalimentacao	Custo Alimentação:	\N	\N	1	12	1	0	-	setMoney	setFloat	0	\N	1	0	1	1	\N	1	1	1900-01-01
963	custoextra	custoextra	Custo Extra:	\N	\N	1	12	1	0	-	setMoney	setFloat	0	\N	1	0	1	1	\N	1	1	1900-01-01
505	custoHoraAula	custohoraaula	Custo Hora/Aula:	\N	\N	1	12	1	0	-	setMoney	setFloat	0	\N	1	0	1	1	\N	1	1	1900-01-01
506	regimeTrabalho	regimeTrabalho	Regime de Trabalho:	\N	\N	2	12	1	0	-	-	0	0	\N	1	0	1	1	\N	1	1	1900-01-01
971	seq	seq	\N	\N	\N	7	22	0	0	-	\N	\N	\N	\N	1	0	1	0	\N	1	1	1900-01-01
972	seq	seq	\N	\N	\N	7	22	0	0	-	\N	\N	\N	\N	1	0	1	0	\N	1	1	1900-01-01
841	temaseq	temaseq	Tema:	\N	\N	2	26	1	0	17	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
14	seq	seq	Cod.:	\N	\N	1	8	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
401	pessseq	pessseq	Nome do Funcionário:	\N	\N	2	26	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
934	exemplar	exemplar	Exemplar:	\N	\N	1	96	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
978	parcseq	parcseq	Cod. Conta:	\N	\N	1	21	0	0	-	\N	\N	\N	\N	1	0	0	0	\N	1	1	1900-01-01
295	ferias	ferias	Valor das férias:	\N	\N	1	14	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
121	vencimento	vencimento	Vencimento:	'99/99/9999',1	CLASS_CALENDARIO	10	17	1	0	function/TSetData/getData	setDataPT	setDataDB	0	\N	1	0	1	0	\N	1	1	1900-01-01
667	valornominal	valornominalproduto	Valor:	\N	CLASS_MASCARA_VALOR	11	67	1	0	0	setMoney	setFloat	0	\N	1	0	1	1	\N	1	1	1900-01-01
834	valortotal	valortotalproduto	Valor total:	\N	CLASS_MASCARA_VALOR	11	67	0	0	-	setMoney	setFloat	0	\N	1	0	2	0	\N	1	1	1900-01-01
980	pessseq	pessseq	Pessoa:	\N	\N	2	21	1	0	-	-	0	0	\N	1	0	0	0	\N	1	1	1900-01-01
133	codigo	codigo	Cod.:	\N	\N	1	999	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
36	tipofone	tipofone	Tipo	\N	\N	1	999	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
50	addlista	addlista	Adicionar	\N	\N	5	999	0	0	-	-	0	0	\N	0	0	1	0	\N	1	1	1900-01-01
43	voip	voip	Voip: 	\N	\N	1	999	0	0	-	-	0	0	\N	0	0	1	0	\N	1	1	1900-01-01
135	codigoPlanoConta	codigoPlanoConta	Conta débito:	\N	\N	2	999	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
946	gdavseq	gdavseq	Grade de Avaliações:	\N	\N	2	11	1	0	-	-	\N	\N	\N	7	0	1	0	\N	1	1	1900-01-01
652	Confirmar	confirmar	Confirmar escolha	\N	\N	5	16	0	0	-	-	0	0	\N	1	0	0	0	\N	1	1	1900-01-01
644	valordescontado	valordescontado	Valor do desconto:	\N	CLASS_MASCARA_VALOR	11	16	0	0	-	setMoney	setFloat	0	\N	0	0	0	0	\N	1	1	1900-01-01
809	botefetivamatricula	botefetivamatricula	Confirmar Matrícula	\N	\N	5	16	0	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
161	desconto	desconto	Desconto:	\N	CLASS_MASCARA_VALOR	11	21	1	0	-	-	setFloat	0	\N	1	0	1	0	\N	1	1	1900-01-01
140	obs	obs	Observações:	\N	\N	9	999	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
138	statseq	statseq	Situação:	\N	\N	2	999	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
458	empregoAtual	empregoAtual	Empresa:	\N	\N	1	999	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
459	empregoFuncao	empregoFuncao	Função:	\N	\N	1	999	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
462	empregoContato	empregoContato	Nome para Contato:	\N	\N	1	999	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
529	codigoPlanoConta	codigoPlanoConta	Conta Débito:	\N	\N	2	999	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
531	obs	obs	Observações:	\N	\N	9	999	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
532	statseq	statseq	Situação:	\N	\N	2	999	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
653	botSetContas	botSetContas	Redefinir contas	\N	\N	5	999	0	0	-	-	0	\N	\N	1	0	1	0	\N	1	1	1900-01-01
660	valorAlteravel	valorAlteravel		\N	\N	7	999	1	0	-	-	0	validaValorAlteravel('valorNominal')	\N	1	0	1	0	\N	1	1	1900-01-01
759	buttonVis	buttonVis	Visualizar	\N	\N	5	999	0	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
760	codigo	codigo	Nº do Documento	\N	\N	1	999	0	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
32	fone	fone	Telefone: 	\N	CLASS_UI_TELEFONE	1	999	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
795	livrseq	livrseq	Livro:	\N	\N	11	87	1	277	-	-	0	0	\N	1	1	2	0	\N	1	1	1900-01-01
524	pessseq	pessseq	Fornecedor:	\N	\N	11	999	1	165	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
461	empregoFone	empregoFone	Telefone de Contato:	\N	CLASS_UI_TELEFONE	1	999	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
902	codigocontacaixa	codigocontacaixa_origem	Conta de Origem:	\N	\N	2	999	0	0	-	-	0	0	\N	1	0	2	0	\N	1	1	1900-01-01
903	codigocontacaixa	codigocontacaixa_destino	Conta de Destino:	\N	\N	2	999	0	0	-	-	0	0	\N	1	0	2	0	\N	1	1	1900-01-01
905	buttonMov	buttonMov	Gerar  Movimentação	\N	\N	5	999	0	0	-	-	0	0	\N	1	0	2	0	\N	1	1	1900-01-01
950	alterar	alterar	Alterar	\N	\N	5	999	0	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
949	codigoturmadisciplina	codigoturmadisciplina	Turma Disciplina Disponível para cursar:	\N	\N	2	999	0	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
965	totalcargahoraria	totalcargahoraria	Total Carga Horária:	\N	\N	1	999	0	0	-	\N	\N	\N	\N	1	0	1	0	\N	1	1	1900-01-01
136	valorNominal	valorNominal	Valor nominal:	\N	CLASS_MASCARA_VALOR	11	999	1	0	-	setMoney	setFloat	0	\N	1	0	1	0	\N	1	1	1900-01-01
528	valorNominal	valorNominal	Valor Total:	\N	CLASS_MASCARA_VALOR	11	999	1	0	-	setMoney	setFloat	0	\N	1	0	1	0	\N	1	1	1900-01-01
879	valorreal	valorrealview	Valor:	\N	CLASS_MASCARA_VALOR	11	999	0	0	-	setMoney	setFloat	0	\N	1	0	2	0	\N	1	1	1900-01-01
966	totalinsspatronal	totalinsspatronal	Total INSS Patr.:	\N	\N	1	999	0	0	-	\N	\N	\N	\N	1	0	1	0	\N	1	1	1900-01-01
967	totalinssprofessor	totalinssprofessor	Total INSS Prof.:	\N	\N	1	999	0	0	-	\N	\N	\N	\N	1	0	1	0	\N	1	1	1900-01-01
968	totalgeralencargos	totalgeralencargos	Total com Encargos:	\N	\N	1	999	0	0	-	\N	\N	\N	\N	1	0	1	0	\N	1	1	1900-01-01
970	gerarcontas	gerarcontas	Gerar Contas	\N	\N	5	999	0	0	-	\N	\N	\N	\N	1	0	1	0	\N	1	1	1900-01-01
782	pessnmrf	pessnmrf	CPF:	'999.999.999-99',1	\N	1	2	0	0	-	setCpfCnpj	validaCpfCnpj	0	\N	1	0	1	0	\N	1	1	1900-01-01
340	pessnmrf	cpfFornecedor	CPF:	'999.999.999-99',1	\N	1	1	1	0	-	setCpfCnpj	validaCpfCnpj	0	\N	1	0	1	0	\N	1	1	1900-01-01
969	totalgeral	totalgeral	Total Geral:	\N	\N	1	999	0	0	-	\N	\N	calculaDebitoProfessor()	\N	1	0	1	0	\N	1	1	1900-01-01
964	codigodisciplina	cargahoraria	Carga Horária:	\N	\N	2	999	0	0	-	\N	\N	\N	\N	1	0	1	0	\N	1	1	1900-01-01
974	confirmacao	confAbandono	Confirmar o Abandono de Curso	\N	\N	5	999	0	0	-	\N	\N	\N	\N	1	0	1	0	\N	1	1	1900-01-01
975	confirmacao	confDestrancamento	Confirmar o Destrancamento de Matrícula	\N	\N	5	999	0	0	-	\N	\N	\N	\N	1	0	1	0	\N	1	1	1900-01-01
976	confirmacao	confTrancamento	Confirmar o Trancamento de Curso	\N	\N	5	999	0	0	-	\N	\N	\N	\N	1	0	1	0	\N	1	1	1900-01-01
670	vencimentotaxa	vencimentotaxa	Vencimento da taxa:	'99/99/9999',1	CLASS_CALENDARIO	10	16	1	0	function/TSetData/getData	setDataPT	setDataDB	0	\N	1	0	1	1	\N	1	1	1900-01-01
642	vencimento	vencimento	Data base:	'99/99/9999',1	CLASS_CALENDARIO	10	66	0	0	function/TSetData/getData	setDataPT	setDataDB	0	\N	1	0	1	1	\N	1	1	1900-01-01
616	dataAula	dataAula	Data:	'99/99/9999',1	CLASS_CALENDARIO	10	62	1	0	function/TSetData/getData	setDataPT	setDataDB	0	\N	1	0	1	0	\N	1	1	1900-01-01
583	dataaula	dataaula	Data da aula:	'99/99/9999',1	CLASS_CALENDARIO	10	28	1	0	function/TSetData/getData	setDataPT	setDataDB	0	\N	1	1	1	0	\N	1	1	1900-01-01
546	dataRealizacao	dataRealizacao	Data de Inicio:	'99/99/9999',1	CLASS_CALENDARIO	10	12	1	0	function/TSetData/getData	setDataPT	setDataDB	0	\N	1	0	1	0	\N	1	1	1900-01-01
412	retornoFeriasPrevisao	retornoFeriasPrevisao	Data prevista para o fim das férias:	'99/99/9999',1	CLASS_CALENDARIO	10	41	1	0	function/TSetData/getData	setDataPT	setDataDB	0	\N	1	0	1	0	\N	1	1	1900-01-01
410	dataFeriasPrevisao	dataFeriasPrevisao	Data prevista para o início das férias:	'99/99/9999',1	CLASS_CALENDARIO	10	41	1	0	function/TSetData/getData	setDataPT	setDataDB	0	\N	1	0	1	0	\N	1	1	1900-01-01
399	dataTermino	dataTermino	Data do Termino:	'99/99/9999',1	CLASS_CALENDARIO	10	39	1	0	function/TSetData/getData	setDataPT	setDataDB	0	\N	1	0	1	0	\N	1	1	1900-01-01
398	dataAssinatura	dataAssinatura	Data da Assinatura:	'99/99/9999',1	CLASS_CALENDARIO	10	39	1	0	function/TSetData/getData	setDataPT	setDataDB	0	\N	1	0	1	0	\N	1	1	1900-01-01
146	vencimento	vencimento	Vencimento:	'99/99/9999',1	CLASS_CALENDARIO	10	65	1	0	function/TSetData/getData	setDataPT	setDataDB	0	\N	1	0	1	0	\N	1	1	1900-01-01
304	datafabricacao	dataFabricacao	Data de Fabricação:	'99/99/9999',1	CLASS_CALENDARIO	10	32	1	0	function/TSetData/getData	setDataPT	setDataDB	0	\N	1	0	1	0	\N	1	1	1900-01-01
305	dataaquisicao	dataAquisicao	Data de Aquisição:	'99/99/9999',1	CLASS_CALENDARIO	10	32	1	0	function/TSetData/getData	setDataPT	setDataDB	0	\N	1	0	1	0	\N	1	1	1900-01-01
812	dataaula	dataaula	Data da aula:	'99/99/9999',1	CLASS_CALENDARIO	10	28	1	0	function/TSetData/getData	setDataPT	setDataDB	0	\N	1	0	1	0	\N	1	1	1900-01-01
948	codigodisciplina_nova	codigodisciplina_nova	Disciplina não cursada atualmente:	\N	\N	11	999	0	456	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
123	dataPag	dataPag	Data do Pagamento:	'99/99/9999',1	CLASS_CALENDARIO	10	17	1	0	function/TSetData/getData	setDataPT	setDataDB	0	\N	1	0	1	0	\N	1	1	1900-01-01
494	dataLimite	dataLimite	Data Limite:	'99/99/9999',1	CLASS_CALENDARIO	10	41	1	0	function/TSetData/getData	setDataPT	setDataDB	0	\N	1	0	1	0	\N	1	1	1900-01-01
415	retornoFeriasReal	retornoFeriasReal	Data real para o fim das férias:	'99/99/9999',1	CLASS_CALENDARIO	10	41	1	0	function/TSetData/getData	setDataPT	setDataDB	0	\N	1	0	1	0	\N	1	1	1900-01-01
346	dataNasc	dataNasc	Data de Nascimento:	'99/99/9999',1	CLASS_CALENDARIO	10	5	1	0	function/TSetData/getData	setDataPT	setDataDB	0	\N	1	0	1	0	\N	1	1	1900-01-01
286	dataExame	dataExame	Data do Exame:	'99/99/9999',1	CLASS_CALENDARIO	10	14	1	0	function/TSetData/getData	setDataPT	setDataDB	0	\N	1	0	1	0	\N	1	1	1900-01-01
221	dataaula	dataaula	Data:	'99/99/9999',1	CLASS_CALENDARIO	10	28	1	0	function/TSetData/getData	setDataPT	setDataDB	0	\N	1	0	1	0	\N	1	1	1900-01-01
522	dataCad	dataCad	Data do Pedido:	'99/99/9999',1	CLASS_CALENDARIO	10	47	1	0	function/TSetData/getData	setDataPT	setDataDB	0	\N	1	0	1	0	\N	1	1	1900-01-01
518	data	data	Data:	'99/99/9999',1	CLASS_CALENDARIO	10	46	1	0	function/TSetData/getData	setDataPT	setDataDB	0	\N	1	0	1	0	\N	1	1	1900-01-01
158	vencimento	vencimento	Vencimento:	'99/99/9999',1	CLASS_CALENDARIO	10	21	1	0	function/TSetData/getData	setDataPT	setDataDB	0	\N	1	1	1	0	\N	1	1	1900-01-01
244	datanasc	datanasc	Data de Nascimento:	'99/99/9999',1	CLASS_CALENDARIO	10	5	1	0	function/TSetData/getData	setDataPT	setDataDB	0	\N	1	0	1	0	\N	1	1	1900-01-01
228	dataNasc	dataNasc	Data de Nascimento:	'99/99/9999',1	CLASS_CALENDARIO	10	30	1	0	function/TSetData/getData	setDataPT	setDataDB	0	\N	1	0	1	0	\N	1	1	1900-01-01
895	vencimento	vencimento	Data base:	'99/99/9999',1	CLASS_CALENDARIO	10	66	1	0	function/TSetData/getData	setDataPT	setDataDB	0	\N	1	0	1	1	\N	1	1	1900-01-01
695	data	data	Data:	\N	CLASS_CALENDARIO	10	46	1	0	-	setDataPT	setDataDB	0	\N	1	0	1	0	\N	1	1	1900-01-01
241	dataReg	dataReg	Data do Registro:	\N	CLASS_CALENDARIO	10	30	1	0	function/TSetData/getData	setDataPT	setDataDB	0	\N	1	0	1	0	\N	1	1	1900-01-01
924	retorno	retorno	Data de Retorno:	'99/99/9999',1	CLASS_CALENDARIO	10	99	1	0	function/TSetData/getData	setDataPT	setDataDB	0	\N	1	0	1	0	\N	1	1	1900-01-01
823	datavigencia	datavigencia	Data de Vigência:	'99/99/9999',1	CLASS_CALENDARIO	10	89	1	0	function/TSetData/getData	setDataPT	setDataDB	0	Data em que o Convênio passa a valer	1	1	1	0	\N	1	1	1900-01-01
104	datacad	datacad	Data da Inscrição:	'99/99/9999',1	CLASS_CALENDARIO	10	16	1	0	function/TSetData/getData	setDataPT	setDataDB	setBotAbas('concluir_botform','0')	\N	1	0	1	0	\N	1	1	1900-01-01
828	datacad	datacad	Data da Matrícula:	'99/99/9999',1	CLASS_CALENDARIO	10	16	1	0	function/TSetData/getData	setDataPT	setDataDB	0	\N	1	1	1	0	\N	1	1	1900-01-01
742	vencimento	vencimento	Data base:	'99/99/9999',1	CLASS_CALENDARIO	10	66	1	0	function/TSetData/getData	setDataPT	setDataDB	0	\N	1	0	1	1	\N	1	1	1900-01-01
669	vencimentomatricula	vencimentomatricula	Vencimento da matrícula:	'99/99/9999',1	CLASS_CALENDARIO	10	16	1	0	function/TSetData/getData	setDataPT	setDataDB	0	\N	1	0	1	1	\N	1	1	1900-01-01
429	dataNasc	dataNasc	Data de Nascimento:	'99/99/9999',1	CLASS_CALENDARIO	10	5	1	0	function/TSetData/getData	setDataPT	setDataDB	0	\N	1	0	1	0	\N	1	1	1900-01-01
413	dataFeriasReal	dataFeriasReal	Data real para início das ferias:	'99/99/9999',1	CLASS_CALENDARIO	10	41	1	0	function/TSetData/getData	setDataPT	setDataDB	0	\N	1	0	1	0	\N	1	1	1900-01-01
159	datacad	datacad	Data do Movimento	'99/99/9999',1	CLASS_CALENDARIO	10	21	1	0	function/TSetData/getData	setDataPT	setDataDB	0	\N	1	0	1	0	\N	1	1	1900-01-01
312	dataverificacao	dataVerificacao	Data da Última Verificação:	'99/99/9999',1	CLASS_CALENDARIO	10	32	1	0	function/TSetData/getData	setDataPT	setDataDB	0	\N	1	0	1	0	\N	1	1	1900-01-01
172	vencimento	vencimento	Vencimento:	'99/99/9999',1	CLASS_CALENDARIO	10	21	1	0	function/TSetData/getData	setDataPT	setDataDB	0	\N	1	1	1	0	\N	1	1	1900-01-01
800	confirmacaosaida	confirmacaosaida	Data de Saida:	'99/99/9999',1	CLASS_CALENDARIO	10	87	1	0	function/TSetData/getData	setDataPT	setDataDB	0	\N	1	1	2	0	\N	1	1	1900-01-01
982	vencimento	vencimento	Nova data de Vencimento	'99/99/9999',1	CLASS_CALENDARIO	10	65	1	0	function/TSetData/getData	setDataPT	setDataDB	0	\N	1	1	1	0	\N	1	1	1900-01-01
91	dataDisc	dataDisc	Data:	'99/99/9999',1	CLASS_CALENDARIO	10	999	1	0	function/TSetData/getData	setDataPT	setDataDB	0	\N	1	0	1	0	\N	1	1	1900-01-01
137	vencimento	vencimento	Data de vencimento:	'99/99/9999',1	CLASS_CALENDARIO	10	999	1	0	function/TSetData/getData	setDataPT	setDataDB	0	\N	1	0	1	0	\N	1	1	1900-01-01
460	empregoDataAdmissao	empregoDataAdmissao	Data de Admissão:	'99/99/9999',1	CLASS_CALENDARIO	10	999	1	0	function/TSetData/getData	setDataPT	setDataDB	0	\N	1	0	1	0	\N	1	1	1900-01-01
530	vencimento	vencimento	Vencimento:	'99/99/9999',1	CLASS_CALENDARIO	10	999	1	0	function/TSetData/getData	setDataPT	setDataDB	0	\N	1	0	1	0	\N	1	1	1900-01-01
74	dataInicio	dataInicio	Data de início:	'99/99/9999',1	CLASS_CALENDARIO	10	11	1	0	function/TSetData/getData	setDataPT	setDataDB	0	\N	1	1	1	0	\N	1	1	1900-01-01
120	valorNominal	valorNominal	Valor Nominal:	\N	CLASS_MASCARA_VALOR	11	17	1	0	-	setMoney	setFloat	0	\N	1	0	1	0	\N	1	1	1900-01-01
82	valorMatricula	valorMatricula	Valor da matrícula:	\N	CLASS_MASCARA_VALOR	11	11	1	0	-	setMoney	setFloat	0	\N	1	0	1	0	\N	1	1	1900-01-01
81	valorTaxa	valorTaxa	Valor da taxa:	\N	CLASS_MASCARA_VALOR	11	11	1	0	-	setMoney	setFloat	0	\N	1	0	1	0	\N	1	1	1900-01-01
145	valorNominal	valorNominal	Valor nominal:	\N	CLASS_MASCARA_VALOR	11	65	1	0	-	setMoney	setFloat	0	\N	1	0	1	0	\N	1	1	1900-01-01
306	valornominal	valorNominal	Valor Contábil:	\N	CLASS_MASCARA_VALOR	11	32	1	0	-	setMoney	setFloat	0	\N	1	0	1	0	\N	1	1	1900-01-01
394	preco	preco	Valor:	\N	CLASS_MASCARA_VALOR	11	38	1	0	-	setMoney	setFloat	0	\N	1	0	1	0	\N	1	1	1900-01-01
525	valorUnitario	valorUnitario	Valor Unitario:	\N	CLASS_MASCARA_VALOR	11	47	1	0	-	setMoney	setFloat	0	\N	1	0	1	0	\N	1	1	1900-01-01
534	preco	preco	Preço:	\N	CLASS_MASCARA_VALOR	11	38	1	0	-	setMoney	setFloat	0	\N	1	0	1	0	\N	1	1	1900-01-01
597	custoUnitario	custoUnitario	Custo unitário:	\N	CLASS_MASCARA_VALOR	11	61	1	0	-	setMoney	setFloat	0	\N	1	0	1	0	\N	1	1	1900-01-01
555	custo	custo	Custo:	\N	CLASS_MASCARA_VALOR	11	53	1	0	-	setMoney	setFloat	0	\N	1	0	1	0	\N	1	1	1900-01-01
599	valor	valor	Custo unitário:	\N	CLASS_MASCARA_VALOR	11	59	1	0	-	setMoney	setFloat	0	\N	1	0	1	0	\N	1	1	1900-01-01
713	valornominal	valorNominal	Valor Nominal:	\N	CLASS_MASCARA_VALOR	11	76	1	0	-	setMoney	setFloat	0	\N	1	0	1	0	\N	1	1	1900-01-01
635	valorNominal	valorNominal	Valor:	\N	CLASS_MASCARA_VALOR	11	67	1	0	-	setMoney	setFloat	0	\N	1	0	1	0	\N	1	1	1900-01-01
175	valorfinal	valorpago	Valor Pago:	\N	CLASS_MASCARA_VALOR	11	21	1	0	-	setMoney	setFloat	0	\N	1	1	1	0	\N	1	1	1900-01-01
495	custolanche	custolanche	Custo lanche / aluno:	\N	CLASS_MASCARA_VALOR	11	11	1	0	-	setMoney	setFloat	0	\N	1	0	1	0	\N	1	1	1900-01-01
496	custovaletransporte	custovaletransporte	Custo VT / aluno:	\N	CLASS_MASCARA_VALOR	11	11	1	0	-	setMoney	setFloat	0	\N	1	0	1	0	\N	1	1	1900-01-01
497	custoapostila	custoapostila	Custo Apostila / aluno:	\N	CLASS_MASCARA_VALOR	11	11	1	0	-	setMoney	setFloat	0	\N	1	0	1	0	\N	1	1	1900-01-01
498	custoBbrinde	custobrinde	Custo Brinde / aluno:	\N	CLASS_MASCARA_VALOR	11	11	1	0	-	setMoney	setFloat	0	\N	1	0	1	0	\N	1	1	1900-01-01
499	custoparceiro	custoparceiro	Custo Parceiros:	\N	CLASS_MASCARA_VALOR	11	11	1	0	-	setMoney	setFloat	0	\N	1	0	1	0	\N	1	1	1900-01-01
500	custoaluguel	custoaluguel	Custo aluguel:	\N	CLASS_MASCARA_VALOR	11	11	1	0	-	setMoney	setFloat	0	\N	1	0	1	0	\N	1	1	1900-01-01
501	custocertificado	custocertificado	Custo Certificado:	\N	CLASS_MASCARA_VALOR	11	11	1	0	-	setMoney	setFloat	0	\N	1	0	1	0	\N	1	1	1900-01-01
502	custodiversos	custodiversos	Custo diversos:	\N	CLASS_MASCARA_VALOR	11	11	1	0	-	setMoney	setFloat	0	\N	1	0	1	0	\N	1	1	1900-01-01
672	valor	valor	Valor:	\N	CLASS_MASCARA_VALOR	11	70	1	0	-	setMoney	setFloat	0	\N	1	0	1	0	\N	1	1	1900-01-01
716	valorcompra	valorCompra	Valor de Compra:	\N	CLASS_MASCARA_VALOR	11	76	1	0	-	setMoney	setFloat	0	\N	1	0	1	0	\N	1	1	1900-01-01
741	valorcorrigido	valorcorrigido	Valor Corrigido:	\N	CLASS_MASCARA_VALOR	11	66	1	0	-	setMoney	setFloat	0	\N	1	0	1	1	\N	1	1	1900-01-01
829	valortotal	valortotal	Valor total:	\N	CLASS_MASCARA_VALOR	11	66	0	0	-	setMoney	setFloat	0	\N	1	0	2	1	\N	1	1	1900-01-01
942	valor	valor	Valor (R$):	\N	CLASS_MASCARA_VALOR	11	102	1	0	-	setMoney	setFloat	0	\N	1	0	1	0	\N	1	1	1900-01-01
904	valorreal	valorreal	Valor da Transferência:	\N	CLASS_MASCARA_VALOR	11	999	0	0	-	setMoney	setFloat	0	\N	1	0	2	0	\N	1	1	1900-01-01
134	pessseq	pessseq	Fornecedor:	\N	\N	11	999	1	165	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
168	parcseq	parcseq	Cod. da Conta:	\N	\N	11	21	1	146	-	-	0	0	\N	1	1	1	0	\N	1	1	1900-01-01
281	funcseq	funcseq	Funcionário:	\N	\N	11	34	1	172	-	-	0	0	\N	1	0	1	1	\N	1	1	1900-01-01
287	lotacao	lotacao	Lotação do Funcionario:	\N	\N	11	14	1	175	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
307	lotacao	lotacao	Lotação:	\N	\N	11	32	1	175	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
308	funcseq	funcseq	Responsável:	\N	\N	11	32	1	172	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
492	funcseq	funcseq	Responsavel:	\N	\N	11	44	1	172	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
533	prodseq	prodseq	Produto:	\N	\N	11	38	1	181	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
628	contaOrigem	pesqContaOrigemD	Conta a Extornar:	\N	\N	11	64	1	204	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
792	livrseq	livrseq	livro:	\N	\N	11	87	1	278	-	-	0	0	\N	1	1	2	0	\N	1	1	1900-01-01
835	funcseq	funcseq	Funcionário:	\N	\N	11	94	1	172	-	-	0	0	\N	1	1	2	0	\N	1	1	1900-01-01
912	disiseq	disiseq	Disciplina Semelhante:	\N	\N	11	97	1	187	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
947	codigodisciplina_antiga	codigodisciplina_antiga	Disciplina a ser Alterada:	\N	\N	11	999	0	455	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
229	cpf	cpf	CPF:	'999.999.999-99',1	\N	1	30	1	0	-	setCPF	validaCpf	0	\N	1	0	1	0	\N	1	1	1900-01-01
12	complemento	complemento	Complemento:	\N	\N	1	49	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	2013-09-03
440	bairro	bairro	Bairro:	\N	\N	1	49	1	0	-	-	0	0	\N	1	1	1	0	\N	1	1	1900-01-01
441	cidade	cidade	Cidade:	\N	\N	1	49	1	0	-	-	0	0	\N	1	1	1	0	\N	1	1	1900-01-01
448	telefone	telefone	Telefone:	\N	CLASS_UI_TELEFONE	1	3	1	0	-	setTelefone	setTelefoneDB	0	\N	1	1	1	0	\N	1	1	1900-01-01
859	valor	valorrealview	Valor da conta:	\N	CLASS_MASCARA_VALOR	11	21	1	0	-	setMoney	setFloat	0	\N	1	0	1	0	\N	1	1	1900-01-01
433	pessnmrf	cnpj	*CNPJ:	'99.999.999/9999-99',1	\N	1	1	1	0	-	setCpfCnpj	validaCpfCnpj	0	\N	1	0	1	0	\N	1	1	1900-01-01
443	cep	cep	Cep:	'99.999-999',1	\N	1	49	1	0	-	setCep	validaCep	0	\N	1	1	1	0	\N	1	1	1900-01-01
648	cliente	cliente	\N	\N	\N	12	1	1	0	true	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
171	valor	valorreal_calculo	Valor a Pagar:	\N	CLASS_MASCARA_VALOR	11	21	0	0	-	setMoney	setFloat	0	\N	1	0	1	0	\N	1	1	1900-01-01
756	valor	valorreal	Valor a pagar:	\N	CLASS_MASCARA_VALOR	11	21	1	0	-	setMoney	setFloat	0	\N	1	1	1	0	\N	1	1	1900-01-01
101	pessseq	pessseq	Pessoa:	\N	\N	11	15	1	172	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
439	endereco	endereco	Endereço:	\N	\N	1	49	1	0	-	-	0	0	\N	1	1	1	0	\N	1	1	1900-01-01
243	pessnmrf	pessnmrf	CPF:	'999.999.999-99',1	\N	1	1	1	0	-	setCpfCnpj	validaCpfCnpj	0	\N	1	1	1	0	\N	1	1	1900-01-01
5	tpteseq	tpteseq	Tipo:	\N	\N	2	3	1	0	-	\N	\N	0	\N	1	1	1	0	\N	1	1	2013-08-21
7	codigoarea	codigoarea	DDD:	'99',1	\N	11	3	1	0	-	\N	\N	\N	\N	1	1	1	0	\N	1	1	2013-08-21
515	valorDescontado	valorDescontado	Desconto:	\N	CLASS_MASCARA_VALOR	11	11	0	0	-	setMoney	setFloat	0	Desconto aplicado sobre o valor da parcela paga em dia.	7	0	1	0	\N	1	1	1900-01-01
752	valortotal	valortotal	Valor total:	\N	CLASS_MASCARA_VALOR	11	11	1	0	-	setMoney	setFloat	0	\N	1	0	1	0	\N	1	1	1900-01-01
643	valorparcelas	valorparcelas	Valor das parcelas:	\N	CLASS_MASCARA_VALOR	11	16	0	0	-	setMoney	setFloat	0	\N	1	0	0	0	\N	1	1	1900-01-01
639	valormatricula	valormatricula	Valor da matricula:	\N	CLASS_MASCARA_VALOR	11	16	0	0	-	setMoney	setFloat	0	\N	1	0	0	0	\N	1	1	1900-01-01
638	valortaxa	valortaxa	Taxa de inscrição:	\N	CLASS_MASCARA_VALOR	11	16	0	0	-	setMoney	setFloat	0	\N	1	0	0	0	\N	1	1	1900-01-01
155	parcseq	parcseq	Cod. da Conta:	\N	\N	11	21	1	145	-	-	0	0	\N	1	1	1	0	t	1	1	1900-01-01
35	cxfuseq	cxfuseq	\N	\N	\N	13	21	1	0	-	\N	\N	\N	\N	1	0	1	0	\N	1	1	2013-10-17
423	pessnmrf	cpf	*CPF:	'999.999.999-99',1	\N	1	1	1	0	-	setCpfCnpj	validaCpfCnpj	0	\N	1	0	1	0	\N	1	1	1900-01-01
693	fornecedor	fornecedor	\N	\N	\N	12	1	1	0	true	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
763	funcionario	funcionario	\N	\N	\N	12	14	1	0	true	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
178	acrescimo	multaacrecimo	Acréscimos:	\N	\N	1	21	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
977	stmoseq	tipomovimentacao	Tipo de Movimentação:	\N	\N	2	21	0	0	-	-	0	0	\N	1	1	0	0	\N	1	1	1900-01-01
157	valor	valorreal	Valor:	\N	CLASS_MASCARA_VALOR	11	21	1	0	-	setMoney	setFloat	0	\N	1	1	1	0	\N	1	1	1900-01-01
981	valor	valorreal	Valor da conta:	\N	CLASS_MASCARA_VALOR	11	21	1	0	-	setMoney	setFloat	0	\N	1	0	0	0	\N	1	1	1900-01-01
173	datacad	dataCad	Data do Movimento:	'99/99/9999',1	CLASS_CALENDARIO	10	21	1	0	function/TSetData/getData	setDataPT	setDataDB	0	\N	1	0	1	0	\N	1	1	1900-01-01
246	estadocivil	estadocivil	Estado Civil:	\N	\N	2	5	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
407	dataadmissao	dataadmissao	Data de Admissão:	'99/99/9999',1	CLASS_CALENDARIO	10	14	1	0	function/TSetData/getData	setDataPT	setDataDB	0	\N	1	0	1	0	\N	1	1	1900-01-01
84	parcelas	parcelas	N° de parcelas	\N	\N	1	11	1	0	-	-	0	0	\N	1	0	1	0	\N	1	1	1900-01-01
195	datainiciovencimentos	datainiciovencimentos	Data base para vencimento:	'99/99/9999',1	CLASS_CALENDARIO	10	11	1	0	function/TSetData/getData	setDataPT	setDataDB	0	Data base para o vemcimento das prestações da turma iniciando pela matrícula.	1	1	1	0	\N	1	1	1900-01-01
640	parcelas	parcelas	N° de Parcelas:	\N	CLASS_MASCARA_VALOR	11	16	0	0	-	-	0	0	\N	1	0	0	0	\N	1	1	1900-01-01
15	datainiciovencimentos	datainiciovencimentos	Início dos Vencimentos:	'99/99/9999',1	CLASS_CALENDARIO	1	16	0	0	function/TSetData/getData	setDataPT	setDataDB	0	\N	1	1	1	0	\N	1	1	2013-10-09
16	padraovencimento	padraovencimento	Padrão de Vencimentos	\N	\N	2	16	0	0	-	-	0	0	\N	1	0	0	0	\N	1	1	2013-10-09
31	email_principal	email_principal	E-mail:	\N	\N	1	1	1	0	-	\N	\N	\N	\N	1	1	1	0	\N	1	1	2013-10-11
33	email_secundario	email_secundario	E-mail Secundário:	\N	\N	1	1	1	0	-	\N	\N	\N	\N	1	0	1	0	\N	1	1	2013-10-11
165	valorfinal	valorfinal	Valor Pago:	\N	CLASS_UI_H2,CLASS_MASCARA_VALOR	1	21	1	0	-	setMoney	setFloat	0	\N	1	0	1	0	\N	1	1	1900-01-01
34	tipo	tipo	\N	\N	\N	14	21	1	0	-	-	0	0	\N	1	0	0	0	\N	1	1	2013-10-17
41	multa	juros	Multa e Juros:	\N	CLASS_MASCARA_VALOR	11	21	1	0	0	setMoney	setFloat	0	\N	1	0	0	0	\N	1	1	2013-10-18
\.


--
-- TOC entry 2407 (class 0 OID 0)
-- Dependencies: 168
-- Name: campos_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('campos_seq_seq', 41, true);


--
-- TOC entry 2330 (class 0 OID 16427)
-- Dependencies: 169 2373
-- Data for Name: campos_x_blocos; Type: TABLE DATA; Schema: public; Owner: -
--

COPY campos_x_blocos (seq, blocseq, campseq, mostrarcampo, formato, ordem, usuaseq, unidseq, datacad, statseq) FROM stdin;
131	34	119	S	\N	0	1	1	1900-01-01	1
132	35	120	S	\N	0	1	1	1900-01-01	1
133	35	121	S	\N	0	1	1	1900-01-01	1
134	35	124	S	\N	0	1	1	1900-01-01	1
135	36	122	S	\N	0	1	1	1900-01-01	1
136	36	123	S	\N	0	1	1	1900-01-01	1
137	36	125	S	\N	0	1	1	1900-01-01	1
138	37	126	S	\N	0	1	1	1900-01-01	1
139	38	128	S	\N	1	1	1	1900-01-01	1
140	38	129	S	\N	3	1	1	1900-01-01	1
141	38	139	S	\N	4	1	1	1900-01-01	1
142	38	130	S	\N	5	1	1	1900-01-01	1
143	38	131	S	\N	6	1	1	1900-01-01	1
144	39	133	S	\N	0	1	1	1900-01-01	1
145	39	134	S	\N	0	1	1	1900-01-01	1
146	39	135	S	\N	0	1	1	1900-01-01	1
147	39	136	S	\N	0	1	1	1900-01-01	1
148	39	137	S	\N	0	1	1	1900-01-01	1
149	39	138	S	\N	0	1	1	1900-01-01	1
150	38	132	S	\N	7	1	1	1900-01-01	1
151	39	140	S	\N	0	1	1	1900-01-01	1
859	254	873	S	\N	1	1	1	1900-01-01	1
855	43	859	S	\N	3	1	1	1900-01-01	1
176	43	165	S	\N	11	1	1	1900-01-01	1
171	43	160	S	\N	10	1	1	1900-01-01	1
177	43	166	S	\N	12	1	1	1900-01-01	1
715	167	706	S	\N	1	1	1	1900-01-01	1
163	41	152	S	\N	7	1	1	1900-01-01	1
717	167	708	S	\N	3	1	1	1900-01-01	1
179	44	168	S	\N	1	1	1	1900-01-01	1
180	44	169	S	\N	2	1	1	1900-01-01	1
191	22	180	S	\N	2	1	1	1900-01-01	1
205	25	183	S	\N	8	1	1	1900-01-01	1
206	25	194	N	\N	10	1	1	1900-01-01	1
207	157	195	S	\N	8	1	1	1900-01-01	1
190	45	179	N	\N	10	1	1	1900-01-01	1
211	51	199	S	\N	1	1	1	1900-01-01	1
212	51	200	S	\N	2	1	1	1900-01-01	1
213	51	201	S	\N	3	1	1	1900-01-01	1
214	51	202	S	\N	4	1	1	1900-01-01	1
215	51	203	S	\N	5	1	1	1900-01-01	1
216	51	204	S	\N	6	1	1	1900-01-01	1
217	51	205	S	\N	7	1	1	1900-01-01	1
218	43	206	S	\N	2	1	1	1900-01-01	1
222	52	210	S	\N	4	1	1	1900-01-01	1
224	53	212	S	\N	1	1	1	1900-01-01	1
225	53	213	S	\N	2	1	1	1900-01-01	1
226	53	214	S	\N	3	1	1	1900-01-01	1
235	56	223	S	\N	0	1	1	1900-01-01	1
236	56	224	S	\N	0	1	1	1900-01-01	1
237	56	225	S	\N	0	1	1	1900-01-01	1
238	57	226	S	\N	1	1	1	1900-01-01	1
239	57	227	S	\N	2	1	1	1900-01-01	1
240	57	228	S	\N	3	1	1	1900-01-01	1
241	57	229	S	\N	4	1	1	1900-01-01	1
242	57	230	S	\N	5	1	1	1900-01-01	1
243	57	231	S	\N	6	1	1	1900-01-01	1
244	57	232	S	\N	8	1	1	1900-01-01	1
245	57	233	S	\N	7	1	1	1900-01-01	1
246	57	241	S	\N	16	1	1	1900-01-01	1
247	57	234	S	\N	9	1	1	1900-01-01	1
248	57	235	S	\N	10	1	1	1900-01-01	1
249	57	236	S	\N	11	1	1	1900-01-01	1
250	112	237	N	\N	0	1	1	1900-01-01	1
251	112	238	S	\N	0	1	1	1900-01-01	1
252	113	239	S	\N	0	1	1	1900-01-01	1
253	114	240	S	\N	0	1	1	1900-01-01	1
254	59	242	S	\N	2	1	1	1900-01-01	1
255	59	243	S	\N	3	1	1	1900-01-01	1
256	59	244	S	\N	4	1	1	1900-01-01	1
173	43	881	S	\N	7	1	1	1900-01-01	1
174	43	163	S	\N	8	1	1	1900-01-01	1
857	43	861	S	\N	5	1	1	1900-01-01	1
172	43	161	S	\N	6	1	1	1900-01-01	1
257	59	245	S	\N	5	1	1	1900-01-01	1
258	59	246	S	\N	6	1	1	1900-01-01	1
259	59	247	S	\N	7	1	1	1900-01-01	1
260	59	248	S	\N	8	1	1	1900-01-01	1
716	167	707	S	\N	4	1	1	1900-01-01	1
86	177	73	S	\N	2	1	1	1900-01-01	1
720	185	725	S	\N	2	1	1	1900-01-01	1
96	157	83	S	\N	3	1	1	1900-01-01	1
263	60	251	S	\N	1	1	1	1900-01-01	1
264	60	252	S	\N	2	1	1	1900-01-01	1
265	60	253	S	\N	3	1	1	1900-01-01	1
266	60	254	S	\N	4	1	1	1900-01-01	1
189	45	879	S	\N	4	1	1	1900-01-01	1
182	45	178	S	\N	6	1	1	1900-01-01	1
865	240	869	S	\N	2	1	1	1900-01-01	1
866	240	870	S	\N	3	1	1	1900-01-01	1
871	255	877	S	\N	5	1	1	1900-01-01	1
872	255	878	S	\N	6	1	1	1900-01-01	1
867	255	873	S	\N	1	1	1	1900-01-01	1
184	45	177	S	\N	2	1	1	1900-01-01	1
186	45	175	S	\N	8	1	1	1900-01-01	1
188	45	174	S	\N	3	1	1	1900-01-01	1
187	45	171	S	\N	7	1	1	1900-01-01	1
185	45	176	S	\N	5	1	1	1900-01-01	1
864	240	868	S	\N	1	1	1	1900-01-01	1
860	254	874	S	\N	2	1	1	1900-01-01	1
166	42	155	S	\N	1	1	1	1900-01-01	1
861	254	875	S	\N	3	1	1	1900-01-01	1
862	254	876	S	\N	4	1	1	1900-01-01	1
863	254	877	S	\N	5	1	1	1900-01-01	1
167	42	156	S	\N	2	1	1	1900-01-01	1
168	42	157	S	\N	3	1	1	1900-01-01	1
169	42	158	S	\N	4	1	1	1900-01-01	1
267	60	255	S	\N	5	1	1	1900-01-01	1
268	60	256	S	\N	6	1	1	1900-01-01	1
269	60	257	S	\N	7	1	1	1900-01-01	1
270	60	258	S	\N	8	1	1	1900-01-01	1
271	60	259	S	\N	9	1	1	1900-01-01	1
272	60	260	S	\N	10	1	1	1900-01-01	1
273	60	261	S	\N	11	1	1	1900-01-01	1
275	69	263	S	\N	23	1	1	1900-01-01	1
276	60	264	S	\N	13	1	1	1900-01-01	1
277	56	269	S	\N	0	1	1	1900-01-01	1
278	56	270	S	\N	0	1	1	1900-01-01	1
279	56	271	S	\N	0	1	1	1900-01-01	1
117	32	105	N	\N	2	1	1	1900-01-01	1
280	62	265	S	\N	0	1	1	1900-01-01	1
281	62	266	S	\N	0	1	1	1900-01-01	1
282	62	267	S	\N	0	1	1	1900-01-01	1
283	62	268	S	\N	0	1	1	1900-01-01	1
284	63	272	S	\N	0	1	1	1900-01-01	1
285	63	273	S	\N	0	1	1	1900-01-01	1
286	63	274	S	\N	0	1	1	1900-01-01	1
287	64	275	S	\N	1	1	1	1900-01-01	1
288	64	276	S	\N	3	1	1	1900-01-01	1
289	64	277	S	\N	4	1	1	1900-01-01	1
290	64	278	S	\N	5	1	1	1900-01-01	1
291	64	279	S	\N	6	1	1	1900-01-01	1
296	69	285	S	\N	4	1	1	1900-01-01	1
297	69	286	S	\N	5	1	1	1900-01-01	1
298	69	287	S	\N	6	1	1	1900-01-01	1
321	59	296	S	\N	12	1	1	1900-01-01	1
322	60	288	S	\N	14	1	1	1900-01-01	1
323	69	290	S	\N	3	1	1	1900-01-01	1
324	59	297	S	\N	16	1	1	1900-01-01	1
325	69	284	S	\N	1	1	1	1900-01-01	1
326	56	291	S	\N	5	1	1	1900-01-01	1
327	69	292	S	\N	7	1	1	1900-01-01	1
328	69	293	S	\N	8	1	1	1900-01-01	1
329	69	294	S	\N	9	1	1	1900-01-01	1
330	69	295	S	\N	10	1	1	1900-01-01	1
335	67	302	S	\N	2	1	1	1900-01-01	1
336	67	303	S	\N	5	1	1	1900-01-01	1
337	67	304	S	\N	6	1	1	1900-01-01	1
338	67	305	S	\N	7	1	1	1900-01-01	1
339	67	306	S	\N	8	1	1	1900-01-01	1
340	67	307	S	\N	9	1	1	1900-01-01	1
341	67	308	S	\N	10	1	1	1900-01-01	1
342	67	309	S	\N	11	1	1	1900-01-01	1
343	67	310	S	\N	12	1	1	1900-01-01	1
344	67	311	S	\N	16	1	1	1900-01-01	1
347	67	312	S	\N	14	1	1	1900-01-01	1
348	67	313	S	\N	15	1	1	1900-01-01	1
349	67	314	S	\N	0	1	1	1900-01-01	1
351	71	315	S	\N	0	1	1	1900-01-01	1
352	71	316	S	\N	2	1	1	1900-01-01	1
353	71	317	S	\N	3	1	1	1900-01-01	1
354	71	318	S	\N	9	1	1	1900-01-01	1
355	71	319	S	\N	10	1	1	1900-01-01	1
356	71	320	S	\N	11	1	1	1900-01-01	1
357	71	321	S	\N	12	1	1	1900-01-01	1
358	71	322	S	\N	13	1	1	1900-01-01	1
360	72	339	S	\N	1	1	1	1900-01-01	1
361	72	340	S	\N	2	1	1	1900-01-01	1
362	72	341	S	\N	3	1	1	1900-01-01	1
363	72	342	N	\N	4	1	1	1900-01-01	1
364	72	343	N	\N	5	1	1	1900-01-01	1
365	72	344	N	\N	6	1	1	1900-01-01	1
366	72	345	N	\N	7	1	1	1900-01-01	1
367	72	346	N	\N	8	1	1	1900-01-01	1
368	73	347	S	\N	1	1	1	1900-01-01	1
369	73	348	S	\N	2	1	1	1900-01-01	1
370	73	349	S	\N	3	1	1	1900-01-01	1
371	73	350	S	\N	4	1	1	1900-01-01	1
372	73	351	S	\N	5	1	1	1900-01-01	1
373	73	352	S	\N	6	1	1	1900-01-01	1
374	73	353	S	\N	7	1	1	1900-01-01	1
375	74	354	S	\N	1	1	1	1900-01-01	1
376	74	355	S	\N	2	1	1	1900-01-01	1
377	74	356	S	\N	3	1	1	1900-01-01	1
378	74	357	S	\N	4	1	1	1900-01-01	1
379	74	358	S	\N	5	1	1	1900-01-01	1
381	74	360	S	\N	7	1	1	1900-01-01	1
383	74	370	S	\N	9	1	1	1900-01-01	1
385	74	372	S	\N	11	1	1	1900-01-01	1
387	74	374	S	\N	13	1	1	1900-01-01	1
389	74	376	S	\N	15	1	1	1900-01-01	1
390	74	377	S	\N	16	1	1	1900-01-01	1
391	74	378	S	\N	17	1	1	1900-01-01	1
392	77	336	S	\N	2	1	1	1900-01-01	1
393	77	337	S	\N	1	1	1	1900-01-01	1
394	77	338	S	\N	3	1	1	1900-01-01	1
395	78	379	S	\N	1	1	1	1900-01-01	1
396	78	380	S	\N	2	1	1	1900-01-01	1
397	172	381	S	\N	3	1	1	1900-01-01	1
878	254	884	S	\N	7	1	1	1900-01-01	1
412	81	396	S	\N	2	1	1	1900-01-01	1
413	81	397	S	\N	3	1	1	1900-01-01	1
414	81	398	S	\N	4	1	1	1900-01-01	1
415	81	399	S	\N	5	1	1	1900-01-01	1
416	81	400	S	\N	6	1	1	1900-01-01	1
417	82	401	S	\N	1	1	1	1900-01-01	1
418	82	402	S	\N	2	1	1	1900-01-01	1
420	82	404	S	\N	4	1	1	1900-01-01	1
870	255	876	S	\N	4	1	1	1900-01-01	1
423	59	407	S	\N	1	1	1	1900-01-01	1
424	84	408	S	\N	1	1	1	1900-01-01	1
426	85	410	S	\N	3	1	1	1900-01-01	1
427	85	411	S	\N	4	1	1	1900-01-01	1
428	85	412	S	\N	5	1	1	1900-01-01	1
429	86	413	S	\N	6	1	1	1900-01-01	1
430	86	414	S	\N	7	1	1	1900-01-01	1
431	86	415	S	\N	8	1	1	1900-01-01	1
432	1	421	S	\N	1	1	1	1900-01-01	1
435	2	422	S	\N	1	1	1	1900-01-01	1
436	2	423	S	\N	2	1	1	1900-01-01	1
437	2	424	S	\N	3	1	1	1900-01-01	1
438	2	425	S	\N	4	1	1	1900-01-01	1
439	2	426	S	\N	5	1	1	1900-01-01	1
440	2	427	S	\N	6	1	1	1900-01-01	1
442	2	429	S	\N	8	1	1	1900-01-01	1
443	3	432	S	\N	1	1	1	1900-01-01	1
444	3	433	S	\N	2	1	1	1900-01-01	1
445	3	434	S	\N	3	1	1	1900-01-01	1
446	3	435	S	\N	4	1	1	1900-01-01	1
447	3	436	S	\N	5	1	1	1900-01-01	1
448	3	437	S	\N	6	1	1	1900-01-01	1
449	3	438	S	\N	7	1	1	1900-01-01	1
752	171	742	S	\N	5	1	1	1900-01-01	1
398	204	382	S	\N	4	1	1	1900-01-01	1
399	204	383	S	\N	5	1	1	1900-01-01	1
400	204	384	S	\N	6	1	1	1900-01-01	1
401	205	385	S	\N	1	1	1	1900-01-01	1
403	205	387	S	\N	3	1	1	1900-01-01	1
404	205	388	S	\N	4	1	1	1900-01-01	1
405	205	389	S	\N	5	1	1	1900-01-01	1
406	205	390	S	\N	6	1	1	1900-01-01	1
407	205	391	S	\N	7	1	1	1900-01-01	1
408	205	392	S	\N	8	1	1	1900-01-01	1
747	154	738	S	\N	5	1	1	1900-01-01	1
868	255	874	S	\N	2	1	1	1900-01-01	1
879	255	884	S	\N	7	1	1	1900-01-01	1
469	87	458	S	\N	2	1	1	1900-01-01	1
470	87	459	S	\N	3	1	1	1900-01-01	1
471	87	460	S	\N	4	1	1	1900-01-01	1
472	87	461	S	\N	5	1	1	1900-01-01	1
473	87	462	S	\N	6	1	1	1900-01-01	1
570	43	567	S	\N	13	1	1	1900-01-01	1
869	255	875	S	\N	3	1	1	1900-01-01	1
571	45	568	S	\N	9	1	1	1900-01-01	1
480	67	469	S	\N	3	1	1	1900-01-01	1
481	67	470	S	\N	4	1	1	1900-01-01	1
482	71	474	S	\N	4	1	1	1900-01-01	1
483	71	475	S	\N	5	1	1	1900-01-01	1
484	71	476	S	\N	6	1	1	1900-01-01	1
485	71	477	S	\N	7	1	1	1900-01-01	1
486	71	478	S	\N	8	1	1	1900-01-01	1
487	71	479	S	\N	15	1	1	1900-01-01	1
489	71	480	S	\N	14	1	1	1900-01-01	1
491	88	416	S	\N	1	1	1	1900-01-01	1
492	88	417	S	\N	2	1	1	1900-01-01	1
493	88	418	S	\N	3	1	1	1900-01-01	1
494	88	419	S	\N	4	1	1	1900-01-01	1
495	1	481	S	\N	2	1	1	1900-01-01	1
529	157	880	S	\N	9	1	1	1900-01-01	1
711	41	702	S	\N	3	1	1	1900-01-01	1
503	90	488	S	\N	1	1	1	1900-01-01	1
504	90	489	S	\N	2	1	1	1900-01-01	1
505	90	490	S	\N	3	1	1	1900-01-01	1
506	90	491	S	\N	4	1	1	1900-01-01	1
507	90	492	S	\N	5	1	1	1900-01-01	1
508	90	493	S	\N	6	1	1	1900-01-01	1
509	84	494	S	\N	2	1	1	1900-01-01	1
513	27	495	S	\N	3	1	1	1900-01-01	1
514	27	496	S	\N	4	1	1	1900-01-01	1
515	27	497	S	\N	2	1	1	1900-01-01	1
516	27	498	S	\N	5	1	1	1900-01-01	1
517	27	499	S	\N	6	1	1	1900-01-01	1
518	27	500	S	\N	7	1	1	1900-01-01	1
519	27	501	S	\N	8	1	1	1900-01-01	1
451	12	440	S	\N	3	1	1	1900-01-01	1
450	12	439	S	\N	1	1	1	1900-01-01	1
452	12	441	S	\N	4	1	1	1900-01-01	1
453	12	442	S	\N	5	1	1	1900-01-01	1
454	12	443	S	\N	6	1	1	1900-01-01	1
520	27	502	S	\N	9	1	1	1900-01-01	1
526	71	509	S	\N	1	1	1	1900-01-01	1
527	74	510	S	\N	18	1	1	1900-01-01	1
528	91	511	S	\N	0	1	1	1900-01-01	1
530	93	516	S	\N	2	1	1	1900-01-01	1
531	93	517	S	\N	3	1	1	1900-01-01	1
532	93	518	S	\N	1	1	1	1900-01-01	1
533	93	519	S	\N	4	1	1	1900-01-01	1
534	93	520	S	\N	5	1	1	1900-01-01	1
536	94	522	S	\N	1	1	1	1900-01-01	1
537	94	523	S	\N	2	1	1	1900-01-01	1
538	94	524	S	\N	4	1	1	1900-01-01	1
539	94	525	S	\N	5	1	1	1900-01-01	1
540	94	526	S	\N	6	1	1	1900-01-01	1
541	94	527	S	\N	7	1	1	1900-01-01	1
542	95	528	S	\N	7	1	1	1900-01-01	1
543	95	529	S	\N	0	1	1	1900-01-01	1
544	95	530	S	\N	0	1	1	1900-01-01	1
545	95	531	S	\N	0	1	1	1900-01-01	1
546	95	532	S	\N	0	1	1	1900-01-01	1
554	97	549	S	\N	0	1	1	1900-01-01	1
556	157	551	S	\N	1	1	1	1900-01-01	1
557	25	552	S	\N	15	1	1	1900-01-01	1
562	99	560	S	\N	1	1	1	1900-01-01	1
563	99	561	S	\N	2	1	1	1900-01-01	1
564	99	562	S	\N	3	1	1	1900-01-01	1
565	99	563	S	\N	4	1	1	1900-01-01	1
567	25	80	S	\N	3	1	1	1900-01-01	1
568	69	565	S	\N	2	1	1	1900-01-01	1
569	69	566	S	\N	3	1	1	1900-01-01	1
572	64	569	S	\N	2	1	1	1900-01-01	1
575	38	572	S	\N	2	1	1	1900-01-01	1
578	57	579	S	\N	15	1	1	1900-01-01	1
579	58	578	S	\N	1	1	1	1900-01-01	1
580	57	575	S	\N	12	1	1	1900-01-01	1
581	57	576	S	\N	13	1	1	1900-01-01	1
582	57	577	S	\N	14	1	1	1900-01-01	1
583	115	580	S	\N	0	1	1	1900-01-01	1
584	58	581	S	\N	2	1	1	1900-01-01	1
585	58	582	S	\N	3	1	1	1900-01-01	1
590	118	588	S	\N	0	1	1	1900-01-01	1
591	119	589	S	\N	1	1	1	1900-01-01	1
592	119	590	S	\N	3	1	1	1900-01-01	1
593	119	591	S	\N	2	1	1	1900-01-01	1
594	119	592	S	\N	4	1	1	1900-01-01	1
602	122	600	S	\N	0	1	1	1900-01-01	1
603	122	601	S	\N	0	1	1	1900-01-01	1
604	123	602	S	\N	0	1	1	1900-01-01	1
605	126	603	S	\N	0	1	1	1900-01-01	1
606	126	604	S	\N	0	1	1	1900-01-01	1
609	125	607	S	\N	0	1	1	1900-01-01	1
610	125	608	S	\N	0	1	1	1900-01-01	1
611	125	609	S	\N	0	1	1	1900-01-01	1
612	125	610	S	\N	0	1	1	1900-01-01	1
613	125	611	S	\N	0	1	1	1900-01-01	1
614	128	612	S	\N	0	1	1	1900-01-01	1
615	121	613	S	\N	0	1	1	1900-01-01	1
616	130	106	S	\N	1	1	1	1900-01-01	1
624	132	615	S	\N	2	1	1	1900-01-01	1
625	132	616	S	\N	3	1	1	1900-01-01	1
626	133	617	S	\N	1	1	1	1900-01-01	1
627	134	618	S	\N	1	1	1	1900-01-01	1
628	135	619	S	\N	1	1	1	1900-01-01	1
750	171	740	S	\N	3	1	1	1900-01-01	1
749	171	741	S	\N	4	1	1	1900-01-01	1
751	171	743	S	\N	7	1	1	1900-01-01	1
634	59	625	S	\N	3	1	1	1900-01-01	1
635	2	626	S	\N	9	1	1	1900-01-01	1
636	138	627	S	\N	0	1	1	1900-01-01	1
637	139	628	S	\N	0	1	1	1900-01-01	1
645	25	637	S	\N	0	1	1	1900-01-01	1
649	141	641	S	\N	3	1	1	1900-01-01	1
650	41	642	S	\N	4	1	1	1900-01-01	1
651	146	645	S	\N	0	1	1	1900-01-01	1
652	146	646	S	\N	0	1	1	1900-01-01	1
653	146	647	S	\N	0	1	1	1900-01-01	1
654	1	648	S	\N	0	1	1	1900-01-01	1
655	141	632	S	\N	2	1	1	1900-01-01	1
656	141	630	S	\N	0	1	1	1900-01-01	1
657	41	649	S	\N	1	1	1	1900-01-01	1
658	41	650	S	\N	2	1	1	1900-01-01	1
661	41	653	S	\N	9	1	1	1900-01-01	1
662	141	654	S	\N	1	1	1	1900-01-01	1
666	150	661	S	\N	0	1	1	1900-01-01	1
667	150	665	S	\N	1	1	1	1900-01-01	1
668	150	663	S	\N	2	1	1	1900-01-01	1
669	150	664	S	\N	3	1	1	1900-01-01	1
681	155	677	S	\N	1	1	1	1900-01-01	1
675	154	671	S	\N	2	1	1	1900-01-01	1
676	154	672	S	\N	3	1	1	1900-01-01	1
677	154	673	S	\N	4	1	1	1900-01-01	1
682	155	678	S	\N	2	1	1	1900-01-01	1
686	158	682	S	\N	1	1	1	1900-01-01	1
687	158	683	S	\N	2	1	1	1900-01-01	1
688	158	684	S	\N	3	1	1	1900-01-01	1
689	158	685	S	\N	4	1	1	1900-01-01	1
690	158	686	S	\N	5	1	1	1900-01-01	1
691	69	687	S	\N	0	1	1	1900-01-01	1
692	159	688	S	\N	2	1	1	1900-01-01	1
693	159	689	S	\N	1	1	1	1900-01-01	1
694	159	690	S	\N	3	1	1	1900-01-01	1
695	159	691	S	\N	4	1	1	1900-01-01	1
696	59	692	S	\N	0	1	1	1900-01-01	1
697	77	693	S	\N	0	1	1	1900-01-01	1
699	162	695	S	\N	1	1	1	1900-01-01	1
700	162	696	S	\N	2	1	1	1900-01-01	1
701	162	697	S	\N	3	1	1	1900-01-01	1
702	162	698	S	\N	4	1	1	1900-01-01	1
703	163	699	S	\N	1	1	1	1900-01-01	1
704	163	700	S	\N	2	1	1	1900-01-01	1
710	64	701	S	\N	0	1	1	1900-01-01	1
724	168	710	S	\N	1	1	1	1900-01-01	1
725	168	711	S	\N	2	1	1	1900-01-01	1
726	168	712	S	\N	3	1	1	1900-01-01	1
727	168	713	S	\N	4	1	1	1900-01-01	1
728	168	714	S	\N	5	1	1	1900-01-01	1
729	168	715	S	\N	6	1	1	1900-01-01	1
730	168	716	S	\N	7	1	1	1900-01-01	1
731	168	717	S	\N	8	1	1	1900-01-01	1
732	168	720	S	\N	9	1	1	1900-01-01	1
733	168	719	S	\N	10	1	1	1900-01-01	1
734	168	709	S	\N	11	1	1	1900-01-01	1
735	168	718	S	\N	12	1	1	1900-01-01	1
874	254	878	S	\N	6	1	1	1900-01-01	1
766	44	756	S	\N	4	1	1	1900-01-01	1
880	246	882	S	\N	4	1	1	1900-01-01	1
875	240	882	S	\N	5	1	1	1900-01-01	1
743	170	734	S	\N	0	1	1	1900-01-01	1
744	170	735	S	\N	0	1	1	1900-01-01	1
745	170	736	S	\N	0	1	1	1900-01-01	1
522	131	505	S	\N	7	1	1	1900-01-01	1
525	131	508	S	\N	9	1	1	1900-01-01	1
524	131	507	S	\N	8	1	1	1900-01-01	1
621	131	521	S	\N	5	1	1	1900-01-01	1
746	170	737	S	\N	0	1	1	1900-01-01	1
763	174	753	S	\N	1	1	1	1900-01-01	1
764	174	755	S	\N	2	1	1	1900-01-01	1
765	174	754	S	\N	3	1	1	1900-01-01	1
767	90	757	S	\N	0	1	1	1900-01-01	1
768	81	758	S	\N	7	1	1	1900-01-01	1
769	81	759	S	\N	8	1	1	1900-01-01	1
770	81	760	S	\N	1	1	1	1900-01-01	1
774	180	766	S	\N	2	1	1	1900-01-01	1
775	180	767	S	\N	3	1	1	1900-01-01	1
776	180	768	S	\N	4	1	1	1900-01-01	1
777	180	769	S	\N	5	1	1	1900-01-01	1
778	180	770	S	\N	6	1	1	1900-01-01	1
877	240	856	S	\N	4	1	1	1900-01-01	1
882	44	885	S	\N	6	1	1	1900-01-01	1
884	44	173	S	\N	7	1	1	1900-01-01	1
65	14	52	S	\N	2	1	1	1900-01-01	1
69	14	56	S	\N	3	1	1	1900-01-01	1
784	182	776	S	\N	1	1	1	1900-01-01	1
785	182	777	S	\N	2	1	1	1900-01-01	1
786	182	778	S	\N	3	1	1	1900-01-01	1
5	33	638	S	\N	3	1	1	1900-01-01	1
6	33	639	S	\N	4	1	1	1900-01-01	1
883	42	159	S	\N	7	1	1	1900-01-01	1
7	33	640	S	\N	5	1	1	1900-01-01	1
8	33	643	S	\N	6	1	1	1900-01-01	1
10	33	651	S	\N	8	1	1	1900-01-01	1
11	33	652	S	\N	11	1	1	1900-01-01	1
13	33	669	S	\N	9	1	1	1900-01-01	1
14	33	670	S	\N	10	1	1	1900-01-01	1
718	167	721	S	\N	2	1	1	1900-01-01	1
719	185	722	S	\N	1	1	1	1900-01-01	1
788	4	780	S	\N	1	1	1	1900-01-01	1
789	4	781	S	\N	2	1	1	1900-01-01	1
790	4	782	S	\N	3	1	1	1900-01-01	1
721	167	723	S	\N	5	1	1	1900-01-01	1
722	186	724	S	\N	1	1	1	1900-01-01	1
723	187	726	S	\N	1	1	1	1900-01-01	1
736	188	727	S	\N	1	1	1	1900-01-01	1
791	186	784	S	\N	2	1	1	1900-01-01	1
792	186	785	S	\N	3	1	1	1900-01-01	1
793	184	783	S	\N	1	1	1	1900-01-01	1
794	187	726	S	\N	1	1	1	1900-01-01	1
795	188	727	S	\N	1	1	1	1900-01-01	1
796	177	786	S	\N	1	1	1	1900-01-01	1
797	167	789	S	\N	6	1	1	1900-01-01	1
798	185	788	S	\N	3	1	1	1900-01-01	1
799	189	790	S	\N	1	1	1	1900-01-01	1
800	189	791	S	\N	2	1	1	1900-01-01	1
3	33	631	S	\N	2	1	1	1900-01-01	1
4	33	633	S	\N	1	1	1	1900-01-01	1
762	157	752	S	\N	5	1	1	1900-01-01	1
761	171	751	S	\N	6	1	1	1900-01-01	1
760	171	750	S	\N	8	1	1	1900-01-01	1
801	191	792	S	\N	1	1	1	1900-01-01	1
802	191	794	S	\N	2	1	1	1900-01-01	1
804	190	796	S	\N	2	1	1	1900-01-01	1
805	192	797	S	\N	1	1	1	1900-01-01	1
806	192	798	S	\N	2	1	1	1900-01-01	1
810	191	803	S	\N	5	1	1	1900-01-01	1
807	190	800	N	\N	3	1	1	1900-01-01	1
808	190	801	N	\N	4	1	1	1900-01-01	1
809	190	802	N	\N	5	1	1	1900-01-01	1
812	194	807	S	\N	1	1	1	1900-01-01	1
813	194	808	S	\N	2	1	1	1900-01-01	1
814	194	651	S	\N	3	1	1	1900-01-01	1
815	194	638	S	\N	4	1	1	1900-01-01	1
816	194	639	S	\N	5	1	1	1900-01-01	1
817	194	640	S	\N	6	1	1	1900-01-01	1
818	194	643	S	\N	7	1	1	1900-01-01	1
876	38	883	S	\N	3	1	1	1900-01-01	1
156	246	145	S	\N	2	1	1	1900-01-01	1
157	246	146	S	\N	3	1	1	1900-01-01	1
811	198	804	S	\N	3	1	1	1900-01-01	1
803	198	795	S	\N	1	1	1	1900-01-01	1
826	199	816	S	\N	1	1	1	1900-01-01	1
828	199	818	S	\N	3	1	1	1900-01-01	1
827	199	817	S	\N	2	1	1	1900-01-01	1
829	199	819	S	\N	4	1	1	1900-01-01	1
830	199	820	S	\N	5	1	1	1900-01-01	1
833	199	823	S	\N	8	1	1	1900-01-01	1
183	44	172	S	\N	5	1	1	1900-01-01	1
158	246	147	S	\N	5	1	1	1900-01-01	1
839	4	828	S	\N	5	1	1	1900-01-01	1
840	171	829	S	\N	1	1	1	1900-01-01	1
748	171	739	S	\N	2	1	1	1900-01-01	1
753	154	744	S	\N	6	1	1	1900-01-01	1
402	205	386	S	\N	2	1	1	1900-01-01	1
843	206	835	S	\N	1	1	1	1900-01-01	1
846	82	841	S	\N	2	1	1	1900-01-01	1
847	40	843	S	\N	1	1	1	1900-01-01	1
848	40	852	S	\N	2	1	1	1900-01-01	1
849	40	853	S	\N	3	1	1	1900-01-01	1
850	40	854	S	\N	4	1	1	1900-01-01	1
851	40	855	S	\N	5	1	1	1900-01-01	1
852	40	856	S	\N	6	1	1	1900-01-01	1
853	40	857	S	\N	7	1	1	1900-01-01	1
854	40	858	S	\N	8	1	1	1900-01-01	1
181	44	170	N	\N	3	1	1	1900-01-01	1
474	209	463	S	\N	1	1	1	1900-01-01	1
475	209	464	S	\N	2	1	1	1900-01-01	1
476	209	465	S	\N	3	1	1	1900-01-01	1
477	209	466	S	\N	4	1	1	1900-01-01	1
478	209	467	S	\N	5	1	1	1900-01-01	1
479	209	468	S	\N	6	1	1	1900-01-01	1
512	210	77	N	\N	5	1	1	1900-01-01	1
535	210	521	N	\N	12	1	1	1900-01-01	1
550	210	546	N	\N	14	1	1	1900-01-01	1
100	210	87	N	\N	2	1	1	1900-01-01	1
511	210	76	N	\N	4	1	1	1900-01-01	1
103	211	91	S	\N	0	1	1	1900-01-01	1
713	212	704	S	\N	1	1	1	1900-01-01	1
293	213	281	S	\N	0	1	1	1900-01-01	1
547	214	533	S	\N	0	1	1	1900-01-01	1
548	214	534	S	\N	0	1	1	1900-01-01	1
549	214	535	S	\N	0	1	1	1900-01-01	1
409	215	393	S	\N	1	1	1	1900-01-01	1
410	215	394	S	\N	2	1	1	1900-01-01	1
411	215	395	S	\N	3	1	1	1900-01-01	1
496	216	482	S	\N	1	1	1	1900-01-01	1
497	216	483	S	\N	2	1	1	1900-01-01	1
498	216	484	S	\N	3	1	1	1900-01-01	1
499	216	485	S	\N	4	1	1	1900-01-01	1
500	216	486	S	\N	5	1	1	1900-01-01	1
552	217	548	S	\N	0	1	1	1900-01-01	1
617	217	547	S	\N	0	1	1	1900-01-01	1
558	218	553	S	\N	1	1	1	1900-01-01	1
559	218	554	S	\N	2	1	1	1900-01-01	1
560	218	555	S	\N	3	1	1	1900-01-01	1
573	219	570	S	\N	1	1	1	1900-01-01	1
574	219	571	S	\N	2	1	1	1900-01-01	1
595	220	593	S	\N	0	1	1	1900-01-01	1
596	220	594	S	\N	0	1	1	1900-01-01	1
597	220	595	S	\N	0	1	1	1900-01-01	1
598	220	596	S	\N	0	1	1	1900-01-01	1
599	220	597	S	\N	0	1	1	1900-01-01	1
607	221	605	S	\N	0	1	1	1900-01-01	1
608	221	606	S	\N	0	1	1	1900-01-01	1
421	222	405	S	\N	1	1	1	1900-01-01	1
422	222	406	S	\N	2	1	1	1900-01-01	1
705	224	483	S	\N	1	1	1	1900-01-01	1
845	206	840	S	\N	4	1	1	1900-01-01	1
706	224	484	S	\N	2	1	1	1900-01-01	1
707	224	485	S	\N	3	1	1	1900-01-01	1
708	224	486	S	\N	4	1	1	1900-01-01	1
709	224	482	S	\N	0	1	1	1900-01-01	1
712	226	703	S	\N	1	1	1	1900-01-01	1
84	229	71	S	\N	0	1	1	1900-01-01	1
208	230	196	S	\N	1	1	1	1900-01-01	1
209	230	197	S	\N	2	1	1	1900-01-01	1
832	199	822	S	\N	7	1	1	1900-01-01	1
210	230	198	N	\N	3	1	1	1900-01-01	1
600	231	598	S	\N	0	1	1	1900-01-01	1
601	231	599	S	\N	0	1	1	1900-01-01	1
619	131	76	S	\N	3	1	1	1900-01-01	1
779	232	771	S	\N	1	1	1	1900-01-01	1
780	232	772	S	\N	2	1	1	1900-01-01	1
781	232	773	S	\N	3	1	1	1900-01-01	1
782	232	774	S	\N	4	1	1	1900-01-01	1
737	233	728	S	\N	1	1	1	1900-01-01	1
738	233	729	S	\N	2	1	1	1900-01-01	1
739	233	730	N	\N	3	1	1	1900-01-01	1
741	233	732	S	\N	5	1	1	1900-01-01	1
742	233	733	S	\N	6	1	1	1900-01-01	1
698	235	694	S	\N	0	1	1	1900-01-01	1
683	237	679	S	\N	1	1	1	1900-01-01	1
684	237	680	S	\N	2	1	1	1900-01-01	1
685	237	681	S	\N	3	1	1	1900-01-01	1
2	237	3	S	\N	1	1	1	1900-01-01	1
587	239	584	S	\N	3	1	1	1900-01-01	1
1	239	2	S	\N	1	1	1	1900-01-01	1
586	239	583	S	\N	2	1	1	1900-01-01	1
588	239	585	S	\N	4	1	1	1900-01-01	1
787	239	779	S	\N	5	1	1	1900-01-01	1
714	242	705	S	\N	8	1	1	1900-01-01	1
227	242	215	N	\N	0	1	1	1900-01-01	1
228	242	216	S	\N	2	1	1	1900-01-01	1
229	242	217	S	\N	3	1	1	1900-01-01	1
230	242	218	S	\N	4	1	1	1900-01-01	1
231	242	219	S	\N	5	1	1	1900-01-01	1
821	245	810	S	\N	1	1	1	1900-01-01	1
822	245	812	S	\N	2	1	1	1900-01-01	1
823	245	813	S	\N	3	1	1	1900-01-01	1
824	245	814	S	\N	4	1	1	1900-01-01	1
825	245	815	S	\N	5	1	1	1900-01-01	1
152	246	141	S	\N	1	1	1	1900-01-01	1
679	247	675	S	\N	4	1	1	1900-01-01	1
642	247	634	S	\N	0	1	1	1900-01-01	1
643	247	635	S	\N	0	1	1	1900-01-01	1
663	247	660	S	\N	3	1	1	1900-01-01	1
834	248	824	S	\N	1	1	1	1900-01-01	1
835	249	825	S	\N	1	1	1	1900-01-01	1
836	249	826	S	\N	2	1	1	1900-01-01	1
837	249	827	S	\N	3	1	1	1900-01-01	1
771	250	761	S	\N	1	1	1	1900-01-01	1
631	250	622	S	\N	2	1	1	1900-01-01	1
632	250	623	S	\N	3	1	1	1900-01-01	1
633	250	624	S	\N	4	1	1	1900-01-01	1
670	251	666	S	\N	1	1	1	1900-01-01	1
672	251	668	S	\N	2	1	1	1900-01-01	1
680	251	676	S	\N	3	1	1	1900-01-01	1
671	251	667	S	\N	4	1	1	1900-01-01	1
841	251	831	S	\N	5	1	1	1900-01-01	1
842	251	834	S	\N	6	1	1	1900-01-01	1
99	210	86	N	\N	1	1	1	1900-01-01	1
623	132	614	N	\N	1	1	1	1900-01-01	1
885	167	886	S	\N	5	1	1	1900-01-01	1
894	261	899	S	\N	1	1	1	1900-01-01	1
886	261	891	S	\N	2	1	1	1900-01-01	1
887	261	892	S	\N	3	1	1	1900-01-01	1
889	261	894	S	\N	4	1	1	1900-01-01	1
890	261	895	S	\N	5	1	1	1900-01-01	1
891	261	896	S	\N	6	1	1	1900-01-01	1
893	261	898	S	\N	7	1	1	1900-01-01	1
892	261	897	S	\N	8	1	1	1900-01-01	1
895	206	900	S	\N	2	1	1	1900-01-01	1
844	206	836	S	\N	3	1	1	1900-01-01	1
644	247	636	S	\N	8	1	1	1900-01-01	1
896	262	901	S	\N	1	1	1	1900-01-01	1
897	262	632	S	\N	2	1	1	1900-01-01	1
898	262	641	S	\N	3	1	1	1900-01-01	1
899	263	902	S	\N	1	1	1	1900-01-01	1
900	263	903	S	\N	2	1	1	1900-01-01	1
901	263	904	S	\N	3	1	1	1900-01-01	1
902	263	905	S	\N	4	1	1	1900-01-01	1
903	235	906	S	\N	0	1	1	1900-01-01	1
904	150	907	S	\N	4	1	1	1900-01-01	1
905	25	908	S	\N	16	1	1	1900-01-01	1
906	25	909	S	\N	17	1	1	1900-01-01	1
907	90	910	S	\N	8	1	1	1900-01-01	1
908	265	912	S	\N	1	1	1	1900-01-01	1
116	32	104	S	\N	1	1	1	1900-01-01	1
909	32	913	S	\N	2	1	1	1900-01-01	1
910	268	916	S	\N	1	1	1	1900-01-01	1
911	268	917	S	\N	2	1	1	1900-01-01	1
912	268	918	S	\N	3	1	1	1900-01-01	1
913	268	919	S	\N	4	1	1	1900-01-01	1
914	268	920	S	\N	5	1	1	1900-01-01	1
915	268	921	S	\N	6	1	1	1900-01-01	1
916	268	922	S	\N	7	1	1	1900-01-01	1
917	268	923	S	\N	8	1	1	1900-01-01	1
918	268	924	S	\N	1	1	1	1900-01-01	1
919	270	928	S	\N	2	1	1	1900-01-01	1
920	270	929	S	\N	3	1	1	1900-01-01	1
921	270	930	S	\N	4	1	1	1900-01-01	1
922	270	931	S	\N	5	1	1	1900-01-01	1
923	270	932	S	\N	6	1	1	1900-01-01	1
924	274	933	S	\N	1	1	1	1900-01-01	1
9	33	644	N	\N	7	1	1	1900-01-01	1
831	199	821	N	\N	6	1	1	1900-01-01	1
934	279	942	S	\N	1	1	1	1900-01-01	1
935	279	943	S	\N	2	1	1	1900-01-01	1
936	281	944	S	\N	1	1	1	1900-01-01	1
937	283	945	S	\N	1	1	1	1900-01-01	1
939	285	947	S	\N	1	1	1	1900-01-01	1
940	285	948	S	\N	2	1	1	1900-01-01	1
943	286	951	S	\N	1	1	1	1900-01-01	1
944	286	952	S	\N	2	1	1	1900-01-01	1
951	288	960	S	\N	7	1	1	1900-01-01	1
945	288	953	S	\N	1	1	1	1900-01-01	1
946	288	954	S	\N	2	1	1	1900-01-01	1
947	288	955	S	\N	3	1	1	1900-01-01	1
948	288	956	S	\N	4	1	1	1900-01-01	1
949	288	957	S	\N	5	1	1	1900-01-01	1
950	288	959	S	\N	6	1	1	1900-01-01	1
838	194	644	N	\N	0	1	1	1900-01-01	1
941	285	949	S	\N	4	1	1	1900-01-01	1
942	285	950	S	\N	5	1	1	1900-01-01	1
783	131	775	S	\N	1	1	1	1900-01-01	1
523	131	506	S	\N	2	1	1	1900-01-01	1
954	131	964	S	\N	4	1	1	1900-01-01	1
620	131	77	S	\N	6	1	1	1900-01-01	1
952	131	961	S	\N	10	1	1	1900-01-01	1
953	131	963	S	\N	11	1	1	1900-01-01	1
956	291	965	S	\N	12	1	1	1900-01-01	1
959	291	966	S	\N	13	1	1	1900-01-01	1
958	291	967	S	\N	14	1	1	1900-01-01	1
957	291	968	S	\N	15	1	1	1900-01-01	1
955	291	969	S	\N	16	1	1	1900-01-01	1
960	291	970	S	\N	17	1	1	1900-01-01	1
961	292	971	S	\N	1	1	1	1900-01-01	1
962	293	972	S	\N	1	1	1	1900-01-01	1
963	294	973	S	\N	1	1	1	1900-01-01	1
965	293	975	S	\N	0	1	1	1900-01-01	1
966	294	976	S	\N	0	1	1	1900-01-01	1
964	292	974	S	\N	0	1	1	1900-01-01	1
968	297	161	S	\N	5	1	1	1900-01-01	1
969	297	881	S	\N	6	1	1	1900-01-01	1
970	297	163	S	\N	7	1	1	1900-01-01	1
971	297	165	S	\N	11	1	1	1900-01-01	1
973	297	206	S	\N	2	1	1	1900-01-01	1
974	297	567	S	\N	13	1	1	1900-01-01	1
977	297	861	S	\N	4	1	1	1900-01-01	1
978	297	977	S	\N	1	1	1	1900-01-01	1
980	298	980	S	\N	2	1	1	1900-01-01	1
981	298	981	S	\N	3	1	1	1900-01-01	1
979	298	978	S	\N	1	1	1	1900-01-01	1
982	300	206	S	\N	1	1	1	1900-01-01	1
983	300	163	S	\N	2	1	1	1900-01-01	1
984	300	861	S	\N	3	1	1	1900-01-01	1
985	300	161	S	\N	4	1	1	1900-01-01	1
986	300	567	S	\N	5	1	1	1900-01-01	1
987	301	982	S	\N	1	1	1	1900-01-01	1
64	14	14	S	\N	1	1	1	1900-01-01	1
66	15	53	S	\N	0	1	1	1900-01-01	1
67	19	54	S	\N	0	1	1	1900-01-01	1
68	16	55	S	\N	0	1	1	1900-01-01	1
70	17	57	S	\N	0	1	1	1900-01-01	1
71	18	58	S	\N	0	1	1	1900-01-01	1
80	22	67	S	\N	1	1	1	1900-01-01	1
81	22	68	S	\N	3	1	1	1900-01-01	1
82	22	69	S	\N	4	1	1	1900-01-01	1
83	22	70	S	\N	5	1	1	1900-01-01	1
87	25	154	S	\N	2	1	1	1900-01-01	1
88	25	74	S	\N	3	1	1	1900-01-01	1
89	25	75	S	\N	4	1	1	1900-01-01	1
92	25	78	S	\N	7	1	1	1900-01-01	1
94	157	81	S	\N	2	1	1	1900-01-01	1
95	157	82	N	\N	6	1	1	1900-01-01	1
97	157	84	S	\N	4	1	1	1900-01-01	1
773	180	765	S	\N	1	1	1	1900-01-01	1
976	297	860	N	\N	8	1	1	1900-01-01	1
104	29	92	S	\N	0	1	1	1900-01-01	1
105	29	93	S	\N	0	1	1	1900-01-01	1
106	29	94	S	\N	0	1	1	1900-01-01	1
107	29	95	S	\N	0	1	1	1900-01-01	1
108	29	96	S	\N	0	1	1	1900-01-01	1
109	29	97	S	\N	0	1	1	1900-01-01	1
110	29	98	S	\N	0	1	1	1900-01-01	1
111	29	99	S	\N	0	1	1	1900-01-01	1
113	30	101	S	\N	1	1	1	1900-01-01	1
114	31	102	S	\N	0	1	1	1900-01-01	1
115	30	103	S	\N	3	1	1	1900-01-01	1
127	34	115	S	\N	0	1	1	1900-01-01	1
128	34	117	S	\N	0	1	1	1900-01-01	1
129	34	116	S	\N	0	1	1	1900-01-01	1
130	34	118	S	\N	0	1	1	1900-01-01	1
926	167	934	S	\N	4	1	1	1900-01-01	1
927	270	935	S	\N	7	1	1	1900-01-01	1
928	270	936	S	\N	8	1	1	1900-01-01	1
929	277	937	S	\N	1	1	1	1900-01-01	1
930	277	938	S	\N	2	1	1	1900-01-01	1
931	277	939	S	\N	3	1	1	1900-01-01	1
932	91	940	S	\N	2	1	1	1900-01-01	1
933	22	941	S	\N	6	1	1	1900-01-01	1
101	22	89	S	\N	7	1	1	1900-01-01	1
12	6	5	S	\N	1	1	1	2013-08-21	1
16	6	7	S	\N	2	1	1	2013-08-21	1
15	6	448	S	\N	3	1	1	2013-08-21	1
17	12	12	S	\N	2	1	1	2013-09-03	1
938	25	946	N	\N	7	1	1	1900-01-01	1
20	194	16	S	\N	8	1	1	2013-10-09	1
19	194	15	S	\N	9	1	1	2013-10-09	1
820	194	809	S	\N	10	1	1	1900-01-01	1
21	7	31	S	\N	1	1	1	2013-10-11	1
22	7	33	S	\N	2	1	1	2013-10-11	1
23	42	656	S	\N	5	1	1	2013-10-17	1
881	42	885	S	\N	6	1	1	1900-01-01	1
28	42	655	S	\N	1	1	1	2013-10-17	1
30	42	34	S	\N	1	1	1	2013-10-17	1
36	43	35	S	\N	1	1	1	2013-10-17	1
856	43	860	N	\N	9	1	1	1900-01-01	1
37	43	41	S	\N	4	1	1	2013-10-18	1
\.


--
-- TOC entry 2408 (class 0 OID 0)
-- Dependencies: 170
-- Name: campos_x_blocos_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('campos_x_blocos_seq_seq', 37, true);


--
-- TOC entry 2332 (class 0 OID 16434)
-- Dependencies: 171 2373
-- Data for Name: campos_x_propriedades; Type: TABLE DATA; Schema: public; Owner: -
--

COPY campos_x_propriedades (seq, campseq, metodo, valor, statseq, usuaseq, unidseq, datacad) FROM stdin;
8	3	setSize	200	1	1	1	1900-01-01
9	50	setProperty	onClick;addLinha()	1	1	1	1900-01-01
10	50	setAction		1	1	1	1900-01-01
11	24	setSize	450	1	1	1	1900-01-01
12	25	setSize	200	1	1	1	1900-01-01
13	26	setSize	200	1	1	1	1900-01-01
14	27	addItems	=>;AC=>AC;AL=>AL;AP=>AP;AM=>AM;BA=>BA;CE=>CE;DF=>DF;ES=>ES;GO=>GO;MA=>MA;MT=>MT;MS=>MS;MG=>MG;PA=>PA;PB=>PB;PR=>PR;PE=>PE;PI=>PI;RJ=>RJ;RN=>RN;RS=>RS;RO=>RO;RR=>RR;SC=>SC;SP=>SP;SE=>SE;TO=>TO	1	1	1	1900-01-01
15	27	setSize	50	1	1	1	1900-01-01
16	30	setSize	200	1	1	1	1900-01-01
17	31	setSize	100	1	1	1	1900-01-01
18	29	setSize	450	1	1	1	1900-01-01
19	49	addItems	=>Tipos;residencia=>Residencial;comercial=>Comercial;amigo=>Amigo	1	1	1	1900-01-01
20	49	setSize	200	1	1	1	1900-01-01
21	51	setSize	200;60	1	1	1	1900-01-01
22	44	setSize	200	1	1	1	1900-01-01
23	45	setSize	200	1	1	1	1900-01-01
24	46	setSize	200	1	1	1	1900-01-01
25	47	setSize	200	1	1	1	1900-01-01
26	48	setSize	200	1	1	1	1900-01-01
27	53	setSize	100%;250	1	1	1	1900-01-01
28	54	setSize	100%;300	1	1	1	1900-01-01
29	55	setSize	100%;300	1	1	1	1900-01-01
30	56	setSize	60	1	1	1	1900-01-01
31	57	setSize	100%;300	1	1	1	1900-01-01
32	58	setSize	100%;300	1	1	1	1900-01-01
36	67	setSize	450	1	1	1	1900-01-01
37	72	setSize	80	1	1	1	1900-01-01
38	71	setSize	450	1	1	1	1900-01-01
39	73	setProperty	onchange;alocaDado(this)	1	1	1	1900-01-01
41	73	setSize	350	1	1	1	1900-01-01
42	78	addItems	=>;Diária=>Diária;Semanal=>Semanal;Quinzenal=>Quinzenal;Mensal=>Mensal;Bimestral=>Bimestral;Trimestral=>Trimestral;Quadrimestral=>Quadrimestral;Semestral=>Semestral;Anual=>Anual	1	1	1	1900-01-01
43	74	setSize	80	1	1	1	1900-01-01
44	75	setSize	80	1	1	1	1900-01-01
45	76	setSize	80	1	1	1	1900-01-01
46	77	setSize	450;120	1	1	1	1900-01-01
47	80	setSize	350	1	1	1	1900-01-01
48	86	setSize	400	1	1	1	1900-01-01
50	92	setSize	80	1	1	1	1900-01-01
51	93	setSize	400	1	1	1	1900-01-01
52	94	setSize	100	1	1	1	1900-01-01
53	95	setSize	80	1	1	1	1900-01-01
54	96	setSize	100	1	1	1	1900-01-01
55	97	setSize	80	1	1	1	1900-01-01
56	98	addItems	M=>Marculino;F=>Feminino	1	1	1	1900-01-01
57	98	setLayout	horizontal	1	1	1	1900-01-01
58	99	addItems	=>;Solteiro=>Solteiro;Casado=>Casado;Divorciado=>Divorciado;Outros=>Outros	1	1	1	1900-01-01
59	102	setSize	100%;200	1	1	1	1900-01-01
61	216	setSize	250	1	1	1	1900-01-01
567	532	addItems	1=>Ativo;0=>Inativo;2=>Standby	1	1	1	1900-01-01
64	118	addItems	Entrada=>Entrada;Saida=>Saída	1	1	1	1900-01-01
65	118	setSize	80	1	1	1	1900-01-01
66	115	setSize	130	1	1	1	1900-01-01
67	117	setSize	240	1	1	1	1900-01-01
68	119	addItems	=>Selecione;Parcela=>Parcela;Pagamento único=>Pagamento único;Negociação=>Negociação	1	1	1	1900-01-01
69	126	setSize	100%;200	1	1	1	1900-01-01
70	118	setLayout	horizontal	1	1	1	1900-01-01
71	128	setSize	100	1	1	1	1900-01-01
72	129	setSize	250	1	1	1	1900-01-01
74	130	setSize	80	1	1	1	1900-01-01
75	131	setSize	450;60	1	1	1	1900-01-01
77	130	setLayout	horizontal	1	1	1	1900-01-01
78	133	setSize	100	1	1	1	1900-01-01
79	134	setSize	450	1	1	1	1900-01-01
80	135	addItems	select seq,nomeConta from dbplano_conta where tipoconta='D' and statseq='1' order by nomeconta	1	1	1	1900-01-01
81	135	setSize	250	1	1	1	1900-01-01
82	136	setSize	80	1	1	1	1900-01-01
83	137	setSize	80	1	1	1	1900-01-01
85	139	addItems	=>- -;D=>Débito;C=>Crédito	1	1	1	1900-01-01
86	139	setSize	60	1	1	1	1900-01-01
87	140	setSize	450;60	1	1	1	1900-01-01
476	479	addItems	1=>Ativo;0=>Inativo;2=>Standby	1	1	1	1900-01-01
396	404	addItems	1=>Ativo;0=>Inativo;2=>Standby	1	1	1	1900-01-01
84	138	addItems	1=>Ativo;0=>Inativo;2=>Standby	1	1	1	1900-01-01
76	132	addItems	1=>Ativo;0=>Inativo;2=>Standby	1	1	1	1900-01-01
40	89	addItems	4=>Em Construção;1=>Concluido;2=>Inativo	1	1	1	1900-01-01
707	632	addItems	select seq,pessnmrz from dbpessoa where statseq=1 order by pessnmrz	1	1	1	1900-01-01
92	196	setSize	250	1	1	1	1900-01-01
94	702	readonly	true	1	1	1	1900-01-01
95	145	setSize	80	1	1	1	1900-01-01
96	146	setSize	80	1	1	1	1900-01-01
97	147	setSize	450;50	1	1	1	1900-01-01
99	711	setSize	100	1	1	1	1900-01-01
100	706	setSize	350	1	1	1	1900-01-01
101	709	setSize	400;60	1	1	1	1900-01-01
102	653	setAction	setContas=seq,desconto,acrescimo,vencimento,numParcelas,intervaloParcelas	1	1	1	1900-01-01
103	152	setSize	60	1	1	1	1900-01-01
104	649	setSize	90	1	1	1	1900-01-01
106	712	setSize	100	1	1	1	1900-01-01
107	155	setSize	110	1	1	1	1900-01-01
108	156	setSize	450	1	1	1	1900-01-01
110	157	setSize	60	1	1	1	1900-01-01
111	157	setProperty	readonly;true	1	1	1	1900-01-01
63	114	addItems	select seq,titulo  from dbturma where statseq=1 order by titulo	1	1	1	1900-01-01
93	703	addItems	select seq,titulo  from dbarea_curso where statseq=1 order by titulo	1	1	1	1900-01-01
112	158	setSize	80	1	1	1	1900-01-01
113	158	setProperty	readonly;true	1	1	1	1900-01-01
462	463	setSize	450	1	1	1	1900-01-01
35	70	setSize	650;140	1	1	1	1900-01-01
7	1	setAction	onSave	0	1	1	1900-01-01
109	156	disabled	disabled	1	1	1	1900-01-01
115	159	setSize	80	1	1	1	1900-01-01
121	161	setSize	60	1	1	1	1900-01-01
199	219	addItems	1=>Ativo;0=>Inativo;2=>Standby	1	1	1	1900-01-01
127	160	setSize	60	1	1	1	1900-01-01
73	130	addItems	Fixo=>Fixo;Variável=>Variável;Direto=>Direto;Indireto=>Indireto	1	1	1	1900-01-01
129	165	setSize	60	1	1	1	1900-01-01
131	166	setSize	60	1	1	1	1900-01-01
133	173	setSize	80	1	1	1	1900-01-01
137	168	setSize	110	1	1	1	1900-01-01
138	616	setSize	100	1	1	1	1900-01-01
139	169	setSize	450	1	1	1	1900-01-01
141	170	setSize	200	1	1	1	1900-01-01
143	615	setSize	450	1	1	1	1900-01-01
144	171	setSize	60	1	1	1	1900-01-01
146	614	setSize	450	1	1	1	1900-01-01
147	172	setSize	80	1	1	1	1900-01-01
149	170	addItems	select seq,nomeconta from  dbplano_conta where tipoconta='D' and statseq='1' order by nomeconta	1	1	1	1900-01-01
153	175	setSize	60	1	1	1	1900-01-01
155	176	setSize	60	1	1	1	1900-01-01
156	176	onkeyup	--	0	1	1	1900-01-01
158	177	onkeyup	--	0	1	1	1900-01-01
163	729	setProperty	disabled;disabled	1	1	1	1900-01-01
164	732	setProperty	disabled;disabled	1	1	1	1900-01-01
165	179	setAction	runCaixa=D	1	1	1	1900-01-01
166	179	disabled	disabled	1	1	1	1900-01-01
169	682	setSize	300	1	1	1	1900-01-01
172	180	setSize	100	1	1	1	1900-01-01
173	642	setSize	90	1	1	1	1900-01-01
175	194	setSize	450	1	1	1	1900-01-01
176	183	setSize	300	1	1	1	1900-01-01
177	81	setSize	80	1	1	1	1900-01-01
178	82	setSize	80	1	1	1	1900-01-01
179	83	setSize	80	1	1	1	1900-01-01
180	84	setSize	80	1	1	1	1900-01-01
184	197	setSize	450;60	1	1	1	1900-01-01
186	200	setSize	80	0	1	1	1900-01-01
187	200	addItems	=>;Conta Bancária=>Conta Bancária;Conta Caixa=>Conta Caixa	1	1	1	1900-01-01
188	201	setSize	250	1	1	1	1900-01-01
189	202	setSize	100	1	1	1	1900-01-01
190	203	setSize	60	1	1	1	1900-01-01
191	204	setSize	60	1	1	1	1900-01-01
194	206	setSize	200	1	1	1	1900-01-01
196	675	setSize	250;35	1	1	1	1900-01-01
197	216	setSize	250	1	1	1	1900-01-01
198	218	setSize	50	1	1	1	1900-01-01
200	217	setSize	50	1	1	1	1900-01-01
201	223	setSize	450	1	1	1	1900-01-01
202	224	setSize	450;100	1	1	1	1900-01-01
388	394	setSize	100	1	1	1	1900-01-01
203	225	addItems	=>Selecione;Horista=>Horista;Assalariado=>Assalariado	1	1	1	1900-01-01
204	575	addItems	=>;Solteiro=>Solteiro;Casado=>Casado;Divorciado=>Divorciado;Outros=>Outros	1	1	1	1900-01-01
205	576	setSize	100	1	1	1	1900-01-01
192	205	addItems	1=>Ativo;0=>Inativo;2=>Standby	1	1	1	1900-01-01
185	198	addItems	1=>Ativo;0=>Inativo;2=>Standby	1	1	1	1900-01-01
91	151	addItems	1=>Ativo;0=>Inativo;2=>Standby	1	1	1	1900-01-01
206	576	addItems	Nenhuma=>Nenhuma;A=>A;B=>B;C=>C;D=>D;AB=>AB;AC=>AC;AD=>AD;	1	1	1	1900-01-01
207	577	setSize	20	1	1	1	1900-01-01
208	578	setSize	400	1	1	1	1900-01-01
209	579	setSize	300;40	1	1	1	1900-01-01
210	237	setSize	100%;200	1	1	1	1900-01-01
211	236	setSize	300	1	1	1	1900-01-01
212	235	setSize	180	1	1	1	1900-01-01
213	234	setSize	180	1	1	1	1900-01-01
214	233	setSize	200	1	1	1	1900-01-01
215	246	addItems	=>Selecione;Solteiro=>Solteiro;Casado=>Casado;Divorciado=>Divorciado;Outros=>Outros	1	1	1	1900-01-01
216	246	setSize	100	1	1	1	1900-01-01
217	245	addItems	M=>Masculino;F=>Feminino	1	1	1	1900-01-01
218	260	setSize	300;40	1	1	1	1900-01-01
219	244	setSize	160	1	1	1	1900-01-01
220	243	setSize	180	1	1	1	1900-01-01
221	225	setSize	160	1	1	1	1900-01-01
222	238	setSize	100%;200	1	1	1	1900-01-01
167	180	addItems	select seq,titulo from dbtipo_curso where statseq='1' order by titulo	1	1	1	1900-01-01
223	239	setSize	100%;400	1	1	1	1900-01-01
224	240	setSize	100%;400	1	1	1	1900-01-01
225	241	setSize	100	1	1	1	1900-01-01
226	242	setSize	450	1	1	1	1900-01-01
227	226	setSize	450	1	1	1	1900-01-01
181	195	setSize	80	1	1	1	1900-01-01
114	156	addItems	select seq,pessnmrz from dbpessoa where statseq='1' or statseq='8' order by pessnmrz	1	1	1	1900-01-01
228	227	addItems	M=>Masculino;F=>Feminino	1	1	1	1900-01-01
229	228	setSize	160	1	1	1	1900-01-01
230	229	setSize	180	1	1	1	1900-01-01
231	230	setSize	450	1	1	1	1900-01-01
232	231	setSize	160	1	1	1	1900-01-01
233	232	setSize	50	1	1	1	1900-01-01
234	232	addItems	=>;AC=>AC;AL=>AL;AP=>AP;AM=>AM;BA=>BA;CE=>CE;DF=>DF;ES=>ES;GO=>GO;MA=>MA;MT=>MT;MS=>MS;MG=>MG;PA=>PA;PB=>PB;PR=>PR;PE=>PE;PI=>PI;RJ=>RJ;RN=>RN;RS=>RS;RO=>RO;RR=>RR;SC=>SC;SP=>SP;SE=>SE;TO=>TO	1	1	1	1900-01-01
235	247	setSize	160	1	1	1	1900-01-01
236	248	setSize	160	1	1	1	1900-01-01
237	249	setSize	160	1	1	1	1900-01-01
238	250	setSize	100	1	1	1	1900-01-01
239	250	addItems	=>;AC=>AC;AL=>AL;AP=>AP;AM=>AM;BA=>BA;CE=>CE;DF=>DF;ES=>ES;GO=>GO;MA=>MA;MT=>MT;MS=>MS;MG=>MG;PA=>PA;PB=>PB;PR=>PR;PE=>PE;PI=>PI;RJ=>RJ;RN=>RN;RS=>RS;RO=>RO;RR=>RR;SC=>SC;SP=>SP;SE=>SE;TO=>TO	1	1	1	1900-01-01
240	251	setSize	450	1	1	1	1900-01-01
241	252	setSize	160	1	1	1	1900-01-01
162	176	setProperty	disabled;disabled	0	1	1	1900-01-01
124	163	setSize	160	1	1	1	1900-01-01
125	163	onChange	openCadCheque(this)	1	1	1	1900-01-01
145	175	setProperty	disabled;disabled	1	1	1	1900-01-01
157	177	setSize	200	1	1	1	1900-01-01
151	174	setSize	160	1	1	1	1900-01-01
242	254	setSize	50	1	1	1	1900-01-01
243	254	addItems	=>;AC=>AC;AL=>AL;AP=>AP;AM=>AM;BA=>BA;CE=>CE;DF=>DF;ES=>ES;GO=>GO;MA=>MA;MT=>MT;MS=>MS;MG=>MG;PA=>PA;PB=>PB;PR=>PR;PE=>PE;PI=>PI;RJ=>RJ;RN=>RN;RS=>RS;RO=>RO;RR=>RR;SC=>SC;SP=>SP;SE=>SE;TO=>TO	1	1	1	1900-01-01
244	255	setSize	200	1	1	1	1900-01-01
245	256	setSize	300	1	1	1	1900-01-01
246	257	setSize	180	1	1	1	1900-01-01
247	258	setSize	180	1	1	1	1900-01-01
248	259	addItems	Sim=>Sim;Não=>Não	1	1	1	1900-01-01
249	261	setSize	160	1	1	1	1900-01-01
251	263	addItems	1=>Ativo;0=>Inativo;2=>Standby	1	1	1	1900-01-01
371	378	setSize	300	1	1	1	1900-01-01
252	264	addItems	Nenhuma=>Nenhuma;A=>A;B=>B;C=>C;D=>D;AB=>AB;AC=>AC;AD=>AD;	1	1	1	1900-01-01
253	264	setSize	100	1	1	1	1900-01-01
254	265	setSize	100%;100	1	1	1	1900-01-01
255	288	setSize	300;40	1	1	1	1900-01-01
256	266	setSize	100%;100	1	1	1	1900-01-01
257	267	setSize	100%;100	1	1	1	1900-01-01
258	223	setSize	450	1	1	1	1900-01-01
259	224	setSize	450;100	1	1	1	1900-01-01
260	225	setSize	80	1	1	1	1900-01-01
261	268	setSize	100%;100	1	1	1	1900-01-01
263	273	setSize	100%;100	1	1	1	1900-01-01
264	274	setSize	100%;100	1	1	1	1900-01-01
265	269	setSize	200	1	1	1	1900-01-01
387	393	setSize	200	1	1	1	1900-01-01
505	107	setSize	200	1	1	1	1900-01-01
891	779	setAction	onFormOpen(260,this)	1	1	1	1900-01-01
736	726	setSize	100%;400	1	1	1	1900-01-01
266	269	addItems	=>Selecione;Matutino=>Matutino;Vespertino=>Vespertino;Noturno=>Noturno;Matutino e Vespertino=>Matutino e Vespertino;Vespertino e Noturno=>Vespertino e Noturno;Noturno e Matutino=>Noturno e Matutino	1	1	1	1900-01-01
267	270	setSize	450;100	1	1	1	1900-01-01
268	271	setSize	200	1	1	1	1900-01-01
269	271	addItems	=>Selecione;Leve (Grau I)=>Leve (Grau I);Médio (Grau II)=>Médio (Grau II);Grave (Grau III)=>Grave (Grau III)	1	1	1	1900-01-01
270	272	setSize	160	1	1	1	1900-01-01
271	253	setSize	160    	1	1	1	1900-01-01
272	290	setSize	160	1	1	1	1900-01-01
273	297	setSize	450;60	1	1	1	1900-01-01
274	284	setSize	250	1	1	1	1900-01-01
275	284	addItems	select seq,nomecargo from dbcargo where statseq='1' order by nomecargo	1	1	1	1900-01-01
276	285	setSize	350;60	1	1	1	1900-01-01
277	286	setSize	160	1	1	1	1900-01-01
278	287	setSize	160	1	1	1	1900-01-01
279	291	setSize	160	1	1	1	1900-01-01
280	292	setSize	160	1	1	1	1900-01-01
281	293	setSize	350;60	1	1	1	1900-01-01
282	294	setSize	160	1	1	1	1900-01-01
283	295	setSize	160	1	1	1	1900-01-01
284	298	setSize	160	1	1	1	1900-01-01
285	298	addItems	=>;\n1=>Ens. Fundamental;\n2=>Ens. Primeira Fase (1º Grau);\n3=>Ens. Segunda Fase (1º Grau);\n4=>Ens. 2º Grau;\n5=>Ens. Superior;\n6=>Especialização;\n7=>Mestrado;\n8=>Doutorado;\n9=>Pos-Doutorado;	1	1	1	1900-01-01
286	299	setSize	450;80	1	1	1	1900-01-01
287	300	setSize	450;80	1	1	1	1900-01-01
288	289	setSize	40%	1	1	1	1900-01-01
289	296	setSize	40	1	1	1	1900-01-01
290	314	setProperty	disabled;disabled\n	1	1	1	1900-01-01
292	14	setSize	100	1	1	1	1900-01-01
293	14	setProperty	disabled;disabled	1	1	1	1900-01-01
294	16	setSize	100	1	1	1	1900-01-01
295	59	setSize	200	1	1	1	1900-01-01
296	59	addItems	=>;\n1=>Ens. Fundamental;\n2=>Ens. Primeira Fase (1º Grau);\n3=>Ens. Segunda Fase (1º Grau);\n4=>Ens. 2º Grau;\n5=>Ens. Superior;\n6=>Especialização;\n7=>Mestrado;\n8=>Doutorado;\n9=>Pos-Doutorado	1	1	1	1900-01-01
297	60	setSize	200	1	1	1	1900-01-01
298	61	setSize	200;40	1	1	1	1900-01-01
299	302	setSize	450;40	1	1	1	1900-01-01
300	303	setSize	200	1	1	1	1900-01-01
301	304	setSize	100	1	1	1	1900-01-01
302	305	setSize	100	1	1	1	1900-01-01
303	306	setSize	100	1	1	1	1900-01-01
304	307	setSize	200	1	1	1	1900-01-01
305	308	setSize	425	1	1	1	1900-01-01
306	309	setSize	100	1	1	1	1900-01-01
307	310	setSize	200	1	1	1	1900-01-01
308	311	setSize	40%	1	1	1	1900-01-01
309	312	setSize	100	1	1	1	1900-01-01
310	313	setSize	450;60	1	1	1	1900-01-01
311	314	setSize	100	1	1	1	1900-01-01
312	315	setSize	100	1	1	1	1900-01-01
313	315	setProperty	disabled;disabled	1	1	1	1900-01-01
314	316	setSize	450	1	1	1	1900-01-01
315	317	setSize	200	1	1	1	1900-01-01
316	318	setSize	450	1	1	1	1900-01-01
317	319	setSize	200	1	1	1	1900-01-01
318	320	setSize	200	1	1	1	1900-01-01
319	337	addItems	F=>Pessoa Física;J=>Pessoa Jurídica	1	1	1	1900-01-01
320	322	setSize	200	1	1	1	1900-01-01
321	141	setProperty	disabled;disabled	1	1	1	1900-01-01
322	336	setProperty	disabled;disabled	1	1	1	1900-01-01
323	336	setSize	100	1	1	1	1900-01-01
324	321	setSize	50	1	1	1	1900-01-01
325	323	setSize	100	1	1	1	1900-01-01
326	323	setProperty	disabled;disabled	1	1	1	1900-01-01
327	133	setProperty	disabled;disabled	1	1	1	1900-01-01
328	338	setProperty	disabled;disabled	1	1	1	1900-01-01
329	340	setSize	180	1	1	1	1900-01-01
330	338	setSize	100	1	1	1	1900-01-01
331	339	setSize	450	1	1	1	1900-01-01
332	341	setSize	200	1	1	1	1900-01-01
333	342	setSize	100	1	1	1	1900-01-01
337	523	setSize	425	1	1	1	1900-01-01
338	524	setSize	450	1	1	1	1900-01-01
494	491	setSize	450;60	1	1	1	1900-01-01
339	343	addItems	=>;afro-brasileiro (negro)=>afro-brasileiro (negro);asiático=>asiático;caucasiano (branco)=>caucasiano (branco);Índias Orientais=>Índias Orientais;hispânico/latino=>hispânico/latino;Oriente Médio=>Oriente Médio;indígena americano=>indígena americ	1	1	1	1900-01-01
340	343	setSize	200	1	1	1	1900-01-01
341	344	addItems	Solteiro=>Solteiro;Casado=>Casado;Divorciado=>Divorciado;Outros=>Outros	1	1	1	1900-01-01
342	344	setSize	200	1	1	1	1900-01-01
343	345	setSize	100	1	1	1	1900-01-01
344	345	addItems	=>Selecione;A-=>A-;A+=>A+;B-=>B-;B+=>B+;AB-=>AB-;AB+=>AB+;O-=>O-;O+=>O+	1	1	1	1900-01-01
345	346	setSize	100	1	1	1	1900-01-01
346	347	setSize	450	1	1	1	1900-01-01
347	348	setSize	180	1	1	1	1900-01-01
348	349	setSize	200	1	1	1	1900-01-01
349	350	setSize	200	1	1	1	1900-01-01
350	351	setSize	450	1	1	1	1900-01-01
351	352	setSize	450	1	1	1	1900-01-01
352	353	setSize	450	1	1	1	1900-01-01
353	354	setSize	450	1	1	1	1900-01-01
354	355	setSize	200	1	1	1	1900-01-01
355	256	setSize		0	1	1	1900-01-01
356	356	setSize	200	1	1	1	1900-01-01
357	357	setSize	50	1	1	1	1900-01-01
478	481	setSize	100	1	1	1	1900-01-01
480	626	setSize	100	1	1	1	1900-01-01
481	625	setSize	100	1	1	1	1900-01-01
358	357	addItems	=>;AC=>AC;AL=>AL;AP=>AP;AM=>AM;BA=>BA;CE=>CE;DF=>DF;ES=>ES;GO=>GO;MA=>MA;MT=>MT;MS=>MS;MG=>MG;PA=>PA;PB=>PB;PR=>PR;PE=>PE;PI=>PI;RJ=>RJ;RN=>RN;RS=>RS;RO=>RO;RR=>RR;SC=>SC;SP=>SP;SE=>SE;TO=>TO	1	1	1	1900-01-01
359	358	setSize	200	1	1	1	1900-01-01
360	359	setSize	100	1	1	1	1900-01-01
361	360	setSize	450	1	1	1	1900-01-01
362	369	setSize	180	1	1	1	1900-01-01
363	370	setSize	180	1	1	1	1900-01-01
364	371	setSize	180	1	1	1	1900-01-01
365	372	setSize	180	1	1	1	1900-01-01
366	373	setSize	180	1	1	1	1900-01-01
367	374	setSize	180	1	1	1	1900-01-01
368	375	setSize	180	1	1	1	1900-01-01
369	376	setSize	180	1	1	1	1900-01-01
370	377	setSize	300	1	1	1	1900-01-01
372	379	setSize	450	1	1	1	1900-01-01
373	380	setSize	200	1	1	1	1900-01-01
374	381	setSize	450;100	1	1	1	1900-01-01
375	382	setSize	450;100	1	1	1	1900-01-01
376	383	setSize	450;100	1	1	1	1900-01-01
377	384	setSize	450;100	1	1	1	1900-01-01
378	385	setSize	100	1	1	1	1900-01-01
379	385	addItems		1	1	1	1900-01-01
380	386	setSize	100	1	1	1	1900-01-01
381	387	setSize	100	1	1	1	1900-01-01
382	388	setSize	100	1	1	1	1900-01-01
383	389	setSize	100	1	1	1	1900-01-01
384	390	setSize	100	1	1	1	1900-01-01
385	391	setSize	100	1	1	1	1900-01-01
386	392	setSize	100	1	1	1	1900-01-01
390	396	setSize	200	1	1	1	1900-01-01
391	397	addItems	select seq,titulo from dbdocumento where statseq=1	1	1	1	1900-01-01
392	398	setSize	100	1	1	1	1900-01-01
393	399	setSize	100	1	1	1	1900-01-01
394	400	addItems	select seq,label from dbproduto where statseq=1	1	1	1	1900-01-01
395	396	addItems	select seq,pessnmrz from dbpessoa where statseq=1 order by pessnmrz	1	1	1	1900-01-01
398	125	addItems	1=>Ativo;0=>Inativo;2=>Standby	1	1	1	1900-01-01
399	124	addItems		0	1	1	1900-01-01
400	214	addItems	1=>Ativo;0=>Inativo;2=>Standby	1	1	1	1900-01-01
401	127	addItems	1=>Ativo;0=>Inativo;2=>Standby	1	1	1	1900-01-01
402	113	addItems	1=>Ativo;0=>Inativo;2=>Standby	1	1	1	1900-01-01
403	407	setSize	100	1	1	1	1900-01-01
404	408	setSize	200	1	1	1	1900-01-01
405	410	setSize	100	1	1	1	1900-01-01
406	414	setSize	100	1	1	1	1900-01-01
407	412	setSize	100	1	1	1	1900-01-01
408	413	setSize	100	1	1	1	1900-01-01
409	411	setSize	100	1	1	1	1900-01-01
410	415	setSize	100	1	1	1	1900-01-01
411	412	setProperty	disabled;disabled	1	1	1	1900-01-01
412	415	setProperty	disabled;disabled	1	1	1	1900-01-01
493	490	setSize	450	1	1	1	1900-01-01
495	492	setSize	425	1	1	1	1900-01-01
397	401	addItems	select seq,pessnmrz from dbpessoa where funcionario=true and statseq=1 order by pessnmrz	1	1	1	1900-01-01
416	481	setproperty	disabled;disabled	1	1	1	1900-01-01
418	416	setSize	450	1	1	1	1900-01-01
419	417	setSize	200	1	1	1	1900-01-01
420	418	setSize	100	1	1	1	1900-01-01
421	419	setSize	100	1	1	1	1900-01-01
422	421	addItems	F=>Pessoa Física;J=>Pessoa Jurídica	1	1	1	1900-01-01
423	422	setSize	450	1	1	1	1900-01-01
424	423	setSize	180	1	1	1	1900-01-01
425	424	setSize	100	1	1	1	1900-01-01
426	425	setSize	100	1	1	1	1900-01-01
427	426	setSize	130	1	1	1	1900-01-01
428	426	addItems	=>;Solteiro=>Solteiro;Casado=>Casado;Divorciado=>Divorciado;Outros=>Outros	1	1	1	1900-01-01
429	427	addItems	=>;afro-brasileiro (negro)=>afro-brasileiro (negro);asiático=>asiático;caucasiano (branco)=>caucasiano (branco);Índias Orientais=>Índias Orientais;hispânico/latino=>hispânico/latino;Oriente Médio=>Oriente Médio;indígena americano=>indígena americano	1	1	1	1900-01-01
430	428	setSize	50	1	1	1	1900-01-01
431	428	addItems	=>;A-=>A-;A+=>A+;B-=>B-;B+=>B+;AB-=>AB-;AB+=>AB+;O-=>O-;O+=>O+	1	1	1	1900-01-01
432	427	setSize	180	1	1	1	1900-01-01
433	429	setSize	100	1	1	1	1900-01-01
434	432	setSize	450	1	1	1	1900-01-01
435	433	setSize	180	1	1	1	1900-01-01
436	434	setSize	120	1	1	1	1900-01-01
437	435	setSize	120	1	1	1	1900-01-01
438	436	setSize	450	1	1	1	1900-01-01
439	437	setSize	450	1	1	1	1900-01-01
440	438	setSize	450	1	1	1	1900-01-01
442	440	setSize	200	1	1	1	1900-01-01
443	441	setSize	200	1	1	1	1900-01-01
444	442	setSize	50	1	1	1	1900-01-01
445	443	setSize	200	1	1	1	1900-01-01
446	445	setSize	120	1	1	1	1900-01-01
447	446	setSize	450	1	1	1	1900-01-01
448	447	setSize	180	1	1	1	1900-01-01
449	449	setSize	180	1	1	1	1900-01-01
450	451	setSize	180	1	1	1	1900-01-01
451	453	setSize	180	1	1	1	1900-01-01
455	442	addItems	=>;AC=>AC;AL=>AL;AP=>AP;AM=>AM;BA=>BA;CE=>CE;DF=>DF;ES=>ES;GO=>GO;MA=>MA;MT=>MT;MS=>MS;MG=>MG;PA=>PA;PB=>PB;PR=>PR;PE=>PE;PI=>PI;RJ=>RJ;RN=>RN;RS=>RS;RO=>RO;RR=>RR;SC=>SC;SP=>SP;SE=>SE;TO=>TO	1	1	1	1900-01-01
456	457	setSize	100	1	1	1	1900-01-01
457	458	setSize	450	1	1	1	1900-01-01
458	460	setSize	100	1	1	1	1900-01-01
459	460	setSize	100	1	1	1	1900-01-01
460	461	setSize	180	1	1	1	1900-01-01
461	462	setSize	200	1	1	1	1900-01-01
463	464	setSize	200	1	1	1	1900-01-01
464	465	setSize	450	1	1	1	1900-01-01
465	466	setSize	200	1	1	1	1900-01-01
466	467	setSize	50	1	1	1	1900-01-01
467	467	addItems	=>;AC=>AC;AL=>AL;AP=>AP;AM=>AM;BA=>BA;CE=>CE;DF=>DF;ES=>ES;GO=>GO;MA=>MA;MT=>MT;MS=>MS;MG=>MG;PA=>PA;PB=>PB;PR=>PR;PE=>PE;PI=>PI;RJ=>RJ;RN=>RN;RS=>RS;RO=>RO;RR=>RR;SC=>SC;SP=>SP;SE=>SE;TO=>TO	1	1	1	1900-01-01
468	468	setSize	200	1	1	1	1900-01-01
469	469	setSize	200	1	1	1	1900-01-01
470	470	setSize	100	1	1	1	1900-01-01
471	474	setSize	100	1	1	1	1900-01-01
472	475	setSize	100	1	1	1	1900-01-01
473	476	setSize	450	1	1	1	1900-01-01
474	477	setSize	450	1	1	1	1900-01-01
475	478	setSize	450	1	1	1	1900-01-01
477	480	setSize	150	1	1	1	1900-01-01
482	627	addItems	D=>Lançar Extorno gerando Débito;C=>Lançar Extorno gerando Crédito	1	1	1	1900-01-01
483	516	setSize	450	1	1	1	1900-01-01
484	321	addItems	=>;AC=>AC;AL=>AL;AP=>AP;AM=>AM;BA=>BA;CE=>CE;DF=>DF;ES=>ES;GO=>GO;MA=>MA;MT=>MT;MS=>MS;MG=>MG;PA=>PA;PB=>PB;PR=>PR;PE=>PE;PI=>PI;RJ=>RJ;RN=>RN;RS=>RS;RO=>RO;RR=>RR;SC=>SC;SP=>SP;SE=>SE;TO=>TO	1	1	1	1900-01-01
485	575	setSize	200	1	1	1	1900-01-01
486	627	onClick	setTipoExtorno(this)	1	1	1	1900-01-01
488	488	setSize	100	1	1	1	1900-01-01
605	563	setSize	20	1	1	1	1900-01-01
491	488	setProperty	disabled;disabled	1	1	1	1900-01-01
492	489	setSize	200	1	1	1	1900-01-01
487	628	addItems	select parcseq,parcseq from dbcaixa where tipo='D' and statseq=1	9	1	1	1900-01-01
497	493	addItems	1=>Ativo;0=>Inativo;2=>Standby	1	1	1	1900-01-01
500	494	setSize	100	1	1	1	1900-01-01
501	494	setProperty	disabled;disabled	1	1	1	1900-01-01
502	104	setSize	80	1	1	1	1900-01-01
504	106	setSize	350	1	1	1	1900-01-01
506	108	setSize	50	1	1	1	1900-01-01
507	108	addItems	=>;AC=>AC;AL=>AL;AP=>AP;AM=>AM;BA=>BA;CE=>CE;DF=>DF;ES=>ES;GO=>GO;MA=>MA;MT=>MT;MS=>MS;MG=>MG;PA=>PA;PB=>PB;PR=>PR;PE=>PE;PI=>PI;RJ=>RJ;RN=>RN;RS=>RS;RO=>RO;RR=>RR;SC=>SC;SP=>SP;SE=>SE;TO=>TO	1	1	1	1900-01-01
508	109	setSize	180	1	1	1	1900-01-01
509	110	setSize	180	1	1	1	1900-01-01
510	111	setSize	300	1	1	1	1900-01-01
511	112	setSize	180	1	1	1	1900-01-01
512	332	setSize	100	1	1	1	1900-01-01
441	12	setSize	450	1	1	1	1900-01-01
513	332	setProperty	disabled;disabled	1	1	1	1900-01-01
514	112	addItems	=>;\n1=>Ens. Fundamental;\n2=>Ens. Primeira Fase (1º Grau);\n3=>Ens. Segunda Fase (1º Grau);\n4=>Ens. 2º Grau;\n5=>Ens. Superior;\n6=>Especialização;\n7=>Mestrado;\n8=>Doutorado;\n9=>Pos-Doutorado	1	1	1	1900-01-01
516	23	setSize	40	1	1	1	1900-01-01
517	522	setProperty	disabled;disabled	1	1	1	1900-01-01
518	495	setSize	80	1	1	1	1900-01-01
519	496	setSize	80	1	1	1	1900-01-01
520	497	setSize	80	1	1	1	1900-01-01
521	498	setSize	80	1	1	1	1900-01-01
522	499	setSize	80	1	1	1	1900-01-01
523	500	setSize	80	1	1	1	1900-01-01
524	501	setSize	80	1	1	1	1900-01-01
525	502	setSize	80	1	1	1	1900-01-01
526	585	setSize	500;100	1	1	1	1900-01-01
527	505	setSize	80	1	1	1	1900-01-01
528	506	setSize	120	1	1	1	1900-01-01
529	507	setSize	80	1	1	1	1900-01-01
530	508	setSize	80	1	1	1	1900-01-01
531	21	setSize	450	1	1	1	1900-01-01
532	22	setSize	450	1	1	1	1900-01-01
533	37	setSize	450	1	1	1	1900-01-01
534	401	setSize	450	1	1	1	1900-01-01
535	486	setSize	450;60	1	1	1	1900-01-01
536	40	setSize	300	1	1	1	1900-01-01
537	509	setSize	450	1	1	1	1900-01-01
538	510	setSize	300	1	1	1	1900-01-01
539	483	setSize	450	1	1	1	1900-01-01
540	484	setSize	450	1	1	1	1900-01-01
541	68	setSize	450	1	1	1	1900-01-01
542	89	setSize	450	1	1	1	1900-01-01
543	180	setSize	450	1	1	1	1900-01-01
544	515	setSize	80	1	1	1	1900-01-01
545	517	setSize	450	1	1	1	1900-01-01
546	518	setSize	120	1	1	1	1900-01-01
547	519	setSize	650;180	1	1	1	1900-01-01
550	518	setProperty	disabled;disabled	1	1	1	1900-01-01
552	565	setSize	250	1	1	1	1900-01-01
555	421	onClick	setTipoForm(this)	1	1	1	1900-01-01
556	527	onkeyup	gerValorTotal(this)	1	1	1	1900-01-01
557	522	setSize	100	1	1	1	1900-01-01
558	525	setSize	120	1	1	1	1900-01-01
559	526	setSize	120	1	1	1	1900-01-01
560	527	setSize	120	1	1	1	1900-01-01
561	528	setSize	120	1	1	1	1900-01-01
562	337	onClick	setTipoForm(this)	1	1	1	1900-01-01
565	52	setSize	450	1	1	1	1900-01-01
566	529	addItems	select seq,nomeconta from  dbplano_conta where tipoconta='D' and statseq=1 order by nomeConta	1	1	1	1900-01-01
548	520	addItems	3=>Negada;2=>Sob análise;1=>Aprovada	1	1	1	1900-01-01
568	529	setSize	200	1	1	1	1900-01-01
569	530	setSize	200	1	1	1	1900-01-01
570	531	setSize	450;40	1	1	1	1900-01-01
571	533	setSize	300	1	1	1	1900-01-01
572	534	setSize	100	1	1	1	1900-01-01
573	535	setSize	100	1	1	1	1900-01-01
574	275	setSize	450	1	1	1	1900-01-01
575	276	setSize	150	1	1	1	1900-01-01
576	277	setSize	450	1	1	1	1900-01-01
577	278	setSize	450;50	1	1	1	1900-01-01
578	279	setSize	450	1	1	1	1900-01-01
498	307	addItems	select seq,nome from dbsala where statseq=1 order by nome	9	1	1	1900-01-01
579	548	setSize	200	1	1	1	1900-01-01
580	547	setSize	300	1	1	1	1900-01-01
582	229	maxlength	14	1	1	1	1900-01-01
583	32	setSize	180	1	1	1	1900-01-01
585	548	addItems	=>;Matutino=>Matutino;Vespertino=>Vespertino;Noturno=>Noturno	1	1	1	1900-01-01
589	546	setSize	100	1	1	1	1900-01-01
590	550	setSize	100	1	1	1	1900-01-01
591	550	setProperty	disabled;disabled	1	1	1	1900-01-01
595	179	style	font-size:18px;	1	1	1	1900-01-01
596	551	setSize	250	1	1	1	1900-01-01
597	551	addItems	select seq,nomeconta  from  dbplano_conta WHERE tipoconta='C' and statseq=1 order by nomeconta	1	1	1	1900-01-01
598	552	addItems	1=>Aberta;4=>Concluida;5=>Em Andamento;2=>Adiada;3=>Cancelada\n	1	1	1	1900-01-01
599	553	setSize	450	1	1	1	1900-01-01
600	554	setSize	450;40 \n	1	1	1	1900-01-01
601	555	setSize	120	1	1	1	1900-01-01
602	562	setSize	100	1	1	1	1900-01-01
603	560	setSize	250	1	1	1	1900-01-01
604	561	setSize	100	1	1	1	1900-01-01
606	564	setSize	250	1	1	1	1900-01-01
778	623	setSize	100%;300	1	1	1	1900-01-01
607	564	addItems	select seq,nomeconta from  dbplano_conta where tipoconta='D' and statseq=1 order by nomeconta	1	1	1	1900-01-01
609	566	setSize	350	1	1	1	1900-01-01
586	303	addItems	Maquinário=>Maquinário;Prédio=>Prédio;Móvel e Ut.=>Móvel e Ut.;Veículo=>Veículo	1	1	1	1900-01-01
611	565	onChange	setEmpTerc(this);	1	1	1	1900-01-01
612	566	setProperty	disabled;disabled	1	1	1	1900-01-01
779	73	setProperty	disabled;disabled	1	1	1	1900-01-01
614	567	setSize	450;40	1	1	1	1900-01-01
615	568	setSize	450;40	1	1	1	1900-01-01
616	220	addItems		1	1	1	1900-01-01
617	569	setSize	650;80	1	1	1	1900-01-01
618	570	setSize	100%	1	1	1	1900-01-01
619	571	setSize	100%;300	1	1	1	1900-01-01
620	572	setSize	200	1	1	1	1900-01-01
621	572	addItems	=>;1=>Funcionários;2=>Tributos;3=>Fornecedores	1	1	1	1900-01-01
622	241	setProperty	disabled;disabled	1	1	1	1900-01-01
797	652	setAction	setConfirmaInscricao(this)	1	1	1	1900-01-01
183	71	size	20	1	1	1	1900-01-01
34	69	setSize	650;140	1	1	1	1900-01-01
752	741	disabled	true	1	1	1	1900-01-01
737	727	setSize	100%;400\n	1	1	1	1900-01-01
623	578	addItems	Administrativa=>Administrativa;\nAdministrstatseq Comercial=>Administrstatseq Comercial;\nAdministrstatseq/ Operacional=>Administrstatseq/ Operacional;\nAgronômica/ Engenharia Agronômica/ Agribusiness=>Agronômica/ Engenharia Agronômica/ Agribusiness;\nAgropecuária/ Veterinária/ Agrobusiness=>Agropecuária/ Veterinária/ Agrobusiness;\nArquitetura/ Decoração/ Urbanismo=>Arquitetura/ Decoração/ Urbanismo;\nArtes=>Artes;\nArtes Gráficas=>Artes Gráficas;\nAtendimento ao Cliente/ Call Center/ Telemarketing=>Atendimento ao Cliente/ Call Center/ Telemarketing;\nAutomação Industrial/ Comercial=>Automação Industrial/ Comercial;\nAviação/ Aeronáutica=>Aviação/ Aeronáutica;\nBancária/ Private Corporate Bank=>Bancária/ Private Corporate Bank;\nBiblioteconomia=>Biblioteconomia;\nBiologia=>Biologia;\nBiotecnologia/ Biomédicas/ Bioquímica=>Biotecnologia/ Biomédicas/ Bioquímica;\nComercial/ Vendas=>Comercial/ Vendas;\nComércio Exterior/ Trade/ Importação/ Exportação=>Comércio Exterior/ Trade/ Importação/ Exportação;\nCompras=>Compras;\nContabilidade=>Contabilidade;\nDepartamento Pessoal=>Departamento Pessoal;\nDesenho Industrial=>Desenho Industrial;\nEconomia=>Economia;\nEducação/ Ensino/ Idiomas=>Educação/ Ensino/ Idiomas;\nEnfermagem=>Enfermagem;\nEngenharia Civil/Construção Civil=>Engenharia Civil/Construção Civil;\nEngenharia de Alimentos=>Engenharia de Alimentos;\nEngenharia de Materiais=>Engenharia de Materiais;\nEngenharia de Minas=>Engenharia de Minas;\nEngenharia de Produção/ Industrial=>Engenharia de Produção/ Industrial;\nEngenharia Elétrica/ Eletrônica=>Engenharia Elétrica/ Eletrônica;\nEngenharia Mecânica/ Mecatrônica=>Engenharia Mecânica/ Mecatrônica;\nEsportes/ Educação Física=>Esportes/ Educação Física;\nEstatística /Matemática /Atuária=>Estatística /Matemática /Atuária;\nEstética Corporal=>Estética Corporal;\nFarmácia=>Farmácia;\nFinanceira/ Administrativa=>Financeira/ Administrativa;\nFisioterapia=>Fisioterapia;\nFonoaudiologia=>Fonoaudiologia;\nGeologia /Engenharia Agrimensura=>Geologia /Engenharia Agrimensura;\nHotelaria/ Turismo=>Hotelaria/ Turismo;\nIndustrial=>Industrial;\nInformática /TI / Engenharia da Computação=>Informática /TI / Engenharia da Computação;\nInternet/ E-Commerce/ E-Business/ Web/ Web Designer=>Internet/ E-Commerce/ E-Business/ Web/ Web Designer;\nJornalismo=>Jornalismo;\nJurídica=>Jurídica;\nLogística/ Suprimentos=>Logística/ Suprimentos;\nManutenção=>Manutenção;\nMarketing=>Marketing;\nMédico/ Hospitalar=>Médico/ Hospitalar;\nMeio Ambiente/ Ecologia/ Engenharia de Meio Ambiente=>Meio Ambiente/ Ecologia/ Engenharia de Meio Ambiente;\nModa=>Moda;\nNutrição=>Nutrição;\nOdontologia=>Odontologia;\nPsicologia Clínica/ Hospitalar=>Psicologia Clínica/ Hospitalar;\nPublicidade e Propaganda=>Publicidade e Propaganda;\nQualidade=>Qualidade;\nQuímica/ Engenharia Química=>Química/ Engenharia Química;\nRecursos Humanos=>Recursos Humanos;\nRelações Internacionais=>Relações Internacionais;\nRelações Públicas=>Relações Públicas;\nRestaurante=>Restaurante;\nSecretariado=>Secretariado;\nSegurança do Trabalho=>Segurança do Trabalho;\nSegurança Patrimonial=>Segurança Patrimonial;\nSeguros=>Seguros;\nServiço Social=>Serviço Social;\nTécnica=>Técnica;\nTécnico-Comercial=>Técnico-Comercial;\nTelecomunicações/ Engenharia de Telecomunicações=>Telecomunicações/ Engenharia de Telecomunicações;\nTerapia Ocupacional=>Terapia Ocupacional;\nTêxtil/ Engenharia Têxtil=>Têxtil/ Engenharia Têxtil;\nTradutor/ Intérprete=>Tradutor/ Intérprete;\nTransportes=>Transportes;\nZootecnia=>Zootecnia; 	1	1	1	1900-01-01
624	580	setSize	100%;400	1	1	1	1900-01-01
625	581	setSize	400	1	1	1	1900-01-01
626	582	setSize	400	1	1	1	1900-01-01
627	584	setSize	500;100	1	1	1	1900-01-01
628	506	addItems	=>;CLT=>CLT;RPA=>RPA;Pessoa Jurídica=>Pessoa Jurídica	1	1	1	1900-01-01
629	714	setSize	250	1	1	1	1900-01-01
630	714	addItems	select seq,nome from dbsala where statseq=1 order by nome	1	1	1	1900-01-01
634	671	setSize	300	1	1	1	1900-01-01
635	672	setSize	150	1	1	1	1900-01-01
636	673	addItems	0=>Não;1=>Sim	1	1	1	1900-01-01
638	169	setProperty	disabled;disabled	1	1	1	1900-01-01
593	550	addItems	select seq from dbpessoa where fornecedor=true and statseq=1 order by seq	1	1	1	1900-01-01
584	547	addItems	select seq, nome from dbcurso where statseq=1 order by nome	9	1	1	1900-01-01
640	172	setProperty	disabled;disabled	1	1	1	1900-01-01
642	683	setSize	250	1	1	1	1900-01-01
643	684	setSize	100	1	1	1	1900-01-01
644	684	setProperty	disabled;disabled	1	1	1	1900-01-01
645	685	setSize	650;180	1	1	1	1900-01-01
715	687	addItems	select seq,label from dbdepartamento where statseq=1 order by label	1	1	1	1900-01-01
717	689	setSize	350	1	1	1	1900-01-01
718	690	addItems	select seq,nome from dbsala where statseq=1 order by nome	1	1	1	1900-01-01
719	691	setSize	400;60	1	1	1	1900-01-01
720	677	addItems	select seq,label from dbdepartamento where statseq=1 order by label	1	1	1	1900-01-01
722	694	setProperty	disabled;disabled	1	1	1	1900-01-01
723	695	setProperty	disabled;disabled	1	1	1	1900-01-01
725	697	setProperty	disabled;disabled	1	1	1	1900-01-01
726	698	setProperty	disabled;disabled	1	1	1	1900-01-01
781	284	setSize	350	1	1	1	1900-01-01
865	825	addItems	1=>Percentual;2=>Valor	1	1	1	1900-01-01
756	744	addItems	select seq,titulo from dbtipo_produto order by titulo	1	1	1	1900-01-01
262	272	addItems	select seq,nomecargo from dbcargo where statseq=1 order by nomecargo	1	1	1	1900-01-01
716	688	addItems	select seq,nomefuncionario from view_funcionario order by nomefuncionario	1	1	1	1900-01-01
793	631	addItems	0 => -	1	1	1	1900-01-01
788	631	setSize	400	1	1	1	1900-01-01
633	754	addItems	select seq,statdesc from dbstatus	1	1	1	1900-01-01
744	676	setSize	100%;100	1	1	1	1900-01-01
753	741	setSize	90	1	1	1	1900-01-01
840	775	setSize	300	1	1	1	1900-01-01
841	521	setSize	300	1	1	1	1900-01-01
842	631	onchange	getDadosTurmaInscricao(this, 'TInscricao','getDadosTurmaInscricao')	1	1	1	1900-01-01
885	853	setSize	350	1	1	1	1900-01-01
843	807	setSize	300	1	1	1	1900-01-01
844	808	setSize	300	1	1	1	1900-01-01
646	581	addItems	Administrativa=>Administrativa;\nAdministrstatseq Comercial=>Administrstatseq Comercial;\nAdministrstatseq/ Operacional=>Administrstatseq/ Operacional;\nAgronômica/ Engenharia Agronômica/ Agribusiness=>Agronômica/ Engenharia Agronômica/ Agribusiness;\nAgropecuária/ Veterinária/ Agrobusiness=>Agropecuária/ Veterinária/ Agrobusiness;\nArquitetura/ Decoração/ Urbanismo=>Arquitetura/ Decoração/ Urbanismo;\nArtes=>Artes;\nArtes Gráficas=>Artes Gráficas;\nAtendimento ao Cliente/ Call Center/ Telemarketing=>Atendimento ao Cliente/ Call Center/ Telemarketing;\nAutomação Industrial/ Comercial=>Automação Industrial/ Comercial;\nAviação/ Aeronáutica=>Aviação/ Aeronáutica;\nBancária/ Private Corporate Bank=>Bancária/ Private Corporate Bank;\nBiblioteconomia=>Biblioteconomia;\nBiologia=>Biologia;\nBiotecnologia/ Biomédicas/ Bioquímica=>Biotecnologia/ Biomédicas/ Bioquímica;\nComercial/ Vendas=>Comercial/ Vendas;\nComércio Exterior/ Trade/ Importação/ Exportação=>Comércio Exterior/ Trade/ Importação/ Exportação;\nCompras=>Compras;\nContabilidade=>Contabilidade;\nDepartamento Pessoal=>Departamento Pessoal;\nDesenho Industrial=>Desenho Industrial;\nEconomia=>Economia;\nEducação/ Ensino/ Idiomas=>Educação/ Ensino/ Idiomas;\nEnfermagem=>Enfermagem;\nEngenharia Civil/Construção Civil=>Engenharia Civil/Construção Civil;\nEngenharia de Alimentos=>Engenharia de Alimentos;\nEngenharia de Materiais=>Engenharia de Materiais;\nEngenharia de Minas=>Engenharia de Minas;\nEngenharia de Produção/ Industrial=>Engenharia de Produção/ Industrial;\nEngenharia Elétrica/ Eletrônica=>Engenharia Elétrica/ Eletrônica;\nEngenharia Mecânica/ Mecatrônica=>Engenharia Mecânica/ Mecatrônica;\nEsportes/ Educação Física=>Esportes/ Educação Física;\nEstatística /Matemática /Atuária=>Estatística /Matemática /Atuária;\nEstética Corporal=>Estética Corporal;\nFarmácia=>Farmácia;\nFinanceira/ Administrativa=>Financeira/ Administrativa;\nFisioterapia=>Fisioterapia;\nFonoaudiologia=>Fonoaudiologia;\nGeologia /Engenharia Agrimensura=>Geologia /Engenharia Agrimensura;\nHotelaria/ Turismo=>Hotelaria/ Turismo;\nIndustrial=>Industrial;\nInformática /TI / Engenharia da Computação=>Informática /TI / Engenharia da Computação;\nInternet/ E-Commerce/ E-Business/ Web/ Web Designer=>Internet/ E-Commerce/ E-Business/ Web/ Web Designer;\nJornalismo=>Jornalismo;\nJurídica=>Jurídica;\nLogística/ Suprimentos=>Logística/ Suprimentos;\nManutenção=>Manutenção;\nMarketing=>Marketing;\nMédico/ Hospitalar=>Médico/ Hospitalar;\nMeio Ambiente/ Ecologia/ Engenharia de Meio Ambiente=>Meio Ambiente/ Ecologia/ Engenharia de Meio Ambiente;\nModa=>Moda;\nNutrição=>Nutrição;\nOdontologia=>Odontologia;\nPsicologia Clínica/ Hospitalar=>Psicologia Clínica/ Hospitalar;\nPublicidade e Propaganda=>Publicidade e Propaganda;\nQualidade=>Qualidade;\nQuímica/ Engenharia Química=>Química/ Engenharia Química;\nRecursos Humanos=>Recursos Humanos;\nRelações Internacionais=>Relações Internacionais;\nRelações Públicas=>Relações Públicas;\nRestaurante=>Restaurante;\nSecretariado=>Secretariado;\nSegurança do Trabalho=>Segurança do Trabalho;\nSegurança Patrimonial=>Segurança Patrimonial;\nSeguros=>Seguros;\nServiço Social=>Serviço Social;\nTécnica=>Técnica;\nTécnico-Comercial=>Técnico-Comercial;\nTelecomunicações/ Engenharia de Telecomunicações=>Telecomunicações/ Engenharia de Telecomunicações;\nTerapia Ocupacional=>Terapia Ocupacional;\nTêxtil/ Engenharia Têxtil=>Têxtil/ Engenharia Têxtil;\nTradutor/ Intérprete=>Tradutor/ Intérprete;\nTransportes=>Transportes;\nZootecnia=>Zootecnia; 	1	1	1	1900-01-01
647	699	setSize	100%;200	1	1	1	1900-01-01
648	700	addItems	1=>Aprovado;0=>Negado	1	1	1	1900-01-01
649	701	addItems	=>;\n1=>Ens. Fundamental;\n2=>Ens. Primeira Fase (1º Grau);\n3=>Ens. Segunda Fase (1º Grau);\n4=>Ens. 2º Grau;\n5=>Ens. Superior;\n6=>Especialização;\n7=>Mestrado;\n8=>Doutorado;\n9=>Pos-Doutorado	1	1	1	1900-01-01
651	713	setSize	100	1	1	1	1900-01-01
652	715	setSize	350	1	1	1	1900-01-01
654	716	setSize	100	1	1	1	1900-01-01
655	717	setSize	150	1	1	1	1900-01-01
656	719	setSize	50	1	1	1	1900-01-01
657	720	setSize	100	1	1	1	1900-01-01
658	718	setSize	400;60	1	1	1	1900-01-01
659	707	setSize	250	1	1	1	1900-01-01
660	708	setSize	80	1	1	1	1900-01-01
33	71	addItems	select seq,titulo from dbdisciplina where statseq=1 order by titulo	1	1	1	1900-01-01
515	621	addItems	select seq,nomedisciplina  from view_turma_disciplina where statseq=1 order by nomedisciplina	1	1	1	1900-01-01
174	68	addItems	select seq,titulo  from dbarea_curso where statseq=1 order by titulo	1	1	1	1900-01-01
690	614	addItems	select seq,titulo from dbdisciplina where statseq=1 order by titulo	1	1	1	1900-01-01
610	565	addItems	=>;0=>CLT;1=>RPA;2=>Pessoa Jurídica;3=>Propriedade	1	1	1	1900-01-01
780	86	addItems	getItens/view_cursos_disciplinas/discseq/nomedisciplina/cursseq,=,cursseq	1	1	1	1900-01-01
782	86	onChange	triggerPross('discseq')	1	1	1	1900-01-01
417	704	addItems	select seq,nomeprofessor from view_professor where statseq=1 order by nomeprofessor	1	1	1	1900-01-01
784	704	setSize	350	1	1	1	1900-01-01
785	511	setSize	300	1	1	1	1900-01-01
799	638	setSize	50	1	1	1	1900-01-01
800	639	setSize	50	1	1	1	1900-01-01
791	778	setSize	100%;300	1	1	1	1900-01-01
790	777	setSize	450	1	1	1	1900-01-01
792	776	setSize	350	1	1	1	1900-01-01
802	643	setSize	50	1	1	1	1900-01-01
801	640	setSize	50	1	1	1	1900-01-01
803	644	setSize	50	1	1	1	1900-01-01
804	651	setSize	80	1	1	1	1900-01-01
805	669	setSize	80	1	1	1	1900-01-01
806	670	setSize	80	1	1	1	1900-01-01
890	104	setProperty	disabled;disabled	1	1	1	1900-01-01
1104	951	setSize	350	1	1	1	1900-01-01
750	740	setSize	90	1	1	1	1900-01-01
754	742	setSize	90	1	1	1	1900-01-01
755	743	setSize	60	1	1	1	1900-01-01
762	753	setSize	250	1	1	1	1900-01-01
764	751	setSize	60	1	1	1	1900-01-01
765	752	setSize	90	1	1	1	1900-01-01
714	678	addItems	select funcseq,nomefuncionario from view_funcionario order by nomefuncionario	9	1	1	1900-01-01
767	756	setSize	80	1	1	1	1900-01-01
768	620	addItems	select seq,pessnmrz from dbpessoa where statseq=1	1	1	1	1900-01-01
771	84	onkeyup	setValorParcelaTurma('valorTotal','numParcelas','valorMensal')	1	1	1	1900-01-01
772	82	readonly	true	1	1	1	1900-01-01
773	757	addItems	0=>Não;1=>Sim	1	1	1	1900-01-01
774	758	addItems	1=>Pessoal;2=>Digital	1	1	1	1900-01-01
775	759	setAction	viewDocumento('seq')	1	1	1	1900-01-01
786	71	size	10	0	1	1	1900-01-01
705	647	addItems	1=>Sim;2=>Não;	1	1	1	1900-01-01
195	705	setProperty	disabled;disabled	0	1	1	1900-01-01
809	786	setSize	200	1	1	1	1900-01-01
892	791	setSize	350	1	1	1	1900-01-01
813	776	disabled	disabled	1	1	1	1900-01-01
770	83	onblur	setValorParcelaTurma('valorTotal','numParcelas','valorMensal')	1	1	1	1900-01-01
839	633	onchange	onLoadSelect(this, 'turmseq','TTurma','setOptionSelect')	1	1	1	1900-01-01
769	752	disabled	true	1	1	1	1900-01-01
810	786	disabled	disabled	1	1	1	1900-01-01
661	582	addItems	Administrativa=>Administrativa;\nAdministrstatseq Comercial=>Administrstatseq Comercial;\nAdministrstatseq/ Operacional=>Administrstatseq/ Operacional;\nAgronômica/ Engenharia Agronômica/ Agribusiness=>Agronômica/ Engenharia Agronômica/ Agribusiness;\nAgropecuária/ Veterinária/ Agrobusiness=>Agropecuária/ Veterinária/ Agrobusiness;\nArquitetura/ Decoração/ Urbanismo=>Arquitetura/ Decoração/ Urbanismo;\nArtes=>Artes;\nArtes Gráficas=>Artes Gráficas;\nAtendimento ao Cliente/ Call Center/ Telemarketing=>Atendimento ao Cliente/ Call Center/ Telemarketing;\nAutomação Industrial/ Comercial=>Automação Industrial/ Comercial;\nAviação/ Aeronáutica=>Aviação/ Aeronáutica;\nBancária/ Private Corporate Bank=>Bancária/ Private Corporate Bank;\nBiblioteconomia=>Biblioteconomia;\nBiologia=>Biologia;\nBiotecnologia/ Biomédicas/ Bioquímica=>Biotecnologia/ Biomédicas/ Bioquímica;\nComercial/ Vendas=>Comercial/ Vendas;\nComércio Exterior/ Trade/ Importação/ Exportação=>Comércio Exterior/ Trade/ Importação/ Exportação;\nCompras=>Compras;\nContabilidade=>Contabilidade;\nDepartamento Pessoal=>Departamento Pessoal;\nDesenho Industrial=>Desenho Industrial;\nEconomia=>Economia;\nEducação/ Ensino/ Idiomas=>Educação/ Ensino/ Idiomas;\nEnfermagem=>Enfermagem;\nEngenharia Civil/Construção Civil=>Engenharia Civil/Construção Civil;\nEngenharia de Alimentos=>Engenharia de Alimentos;\nEngenharia de Materiais=>Engenharia de Materiais;\nEngenharia de Minas=>Engenharia de Minas;\nEngenharia de Produção/ Industrial=>Engenharia de Produção/ Industrial;\nEngenharia Elétrica/ Eletrônica=>Engenharia Elétrica/ Eletrônica;\nEngenharia Mecânica/ Mecatrônica=>Engenharia Mecânica/ Mecatrônica;\nEsportes/ Educação Física=>Esportes/ Educação Física;\nEstatística /Matemática /Atuária=>Estatística /Matemática /Atuária;\nEstética Corporal=>Estética Corporal;\nFarmácia=>Farmácia;\nFinanceira/ Administrativa=>Financeira/ Administrativa;\nFisioterapia=>Fisioterapia;\nFonoaudiologia=>Fonoaudiologia;\nGeologia /Engenharia Agrimensura=>Geologia /Engenharia Agrimensura;\nHotelaria/ Turismo=>Hotelaria/ Turismo;\nIndustrial=>Industrial;\nInformática /TI / Engenharia da Computação=>Informática /TI / Engenharia da Computação;\nInternet/ E-Commerce/ E-Business/ Web/ Web Designer=>Internet/ E-Commerce/ E-Business/ Web/ Web Designer;\nJornalismo=>Jornalismo;\nJurídica=>Jurídica;\nLogística/ Suprimentos=>Logística/ Suprimentos;\nManutenção=>Manutenção;\nMarketing=>Marketing;\nMédico/ Hospitalar=>Médico/ Hospitalar;\nMeio Ambiente/ Ecologia/ Engenharia de Meio Ambiente=>Meio Ambiente/ Ecologia/ Engenharia de Meio Ambiente;\nModa=>Moda;\nNutrição=>Nutrição;\nOdontologia=>Odontologia;\nPsicologia Clínica/ Hospitalar=>Psicologia Clínica/ Hospitalar;\nPublicidade e Propaganda=>Publicidade e Propaganda;\nQualidade=>Qualidade;\nQuímica/ Engenharia Química=>Química/ Engenharia Química;\nRecursos Humanos=>Recursos Humanos;\nRelações Internacionais=>Relações Internacionais;\nRelações Públicas=>Relações Públicas;\nRestaurante=>Restaurante;\nSecretariado=>Secretariado;\nSegurança do Trabalho=>Segurança do Trabalho;\nSegurança Patrimonial=>Segurança Patrimonial;\nSeguros=>Seguros;\nServiço Social=>Serviço Social;\nTécnica=>Técnica;\nTécnico-Comercial=>Técnico-Comercial;\nTelecomunicações/ Engenharia de Telecomunicações=>Telecomunicações/ Engenharia de Telecomunicações;\nTerapia Ocupacional=>Terapia Ocupacional;\nTêxtil/ Engenharia Têxtil=>Têxtil/ Engenharia Têxtil;\nTradutor/ Intérprete=>Tradutor/ Intérprete;\nTransportes=>Transportes;\nZootecnia=>Zootecnia; 	1	1	1	1900-01-01
662	589	setSize	400	1	1	1	1900-01-01
663	590	setSize	100%;150	1	1	1	1900-01-01
664	591	setSize	70	1	1	1	1900-01-01
665	592	setSize	100%;150	1	1	1	1900-01-01
666	593	setSize	400	1	1	1	1900-01-01
667	594	setSize	70	1	1	1	1900-01-01
668	604	setSize	200	1	1	1	1900-01-01
669	603	setSize	400	1	1	1	1900-01-01
670	602	setSize	100%;400	1	1	1	1900-01-01
671	601	setSize	100%;200	1	1	1	1900-01-01
672	600	setSize	100%;200	1	1	1	1900-01-01
673	598	setSize	400	1	1	1	1900-01-01
674	597	setSize	70	1	1	1	1900-01-01
675	596	setSize	250	1	1	1	1900-01-01
676	595	setSize	70	1	1	1	1900-01-01
677	605	setSize	400	1	1	1	1900-01-01
678	606	setSize	200	1	1	1	1900-01-01
679	607	setSize	70	1	1	1	1900-01-01
680	608	setSize	70	1	1	1	1900-01-01
681	609	setSize	70	1	1	1	1900-01-01
682	610	setSize	70	1	1	1	1900-01-01
683	611	setSize	70	1	1	1	1900-01-01
684	613	setSize	70	1	1	1	1900-01-01
685	612	setSize	70	1	1	1	1900-01-01
688	618	setSize	100%;400	1	1	1	1900-01-01
689	619	setSize	100%;400	1	1	1	1900-01-01
691	620	setProperty	disabled;disabled	1	1	1	1900-01-01
693	702	setSize	90	1	1	1	1900-01-01
695	660	onchange	validaValorAlteravel('valorNominal')	1	1	1	1900-01-01
696	636	setProperty	disabled;disabled	1	1	1	1900-01-01
697	637	setProperty	disabled;disabled	1	1	1	1900-01-01
698	638	addItems	select seq,pessnmrz from dbpessoa where statseq=1	1	1	1	1900-01-01
701	641	addItems	select seq,nomeconta from  dbplano_conta where statseq=1 and tipoconta='C'	1	1	1	1900-01-01
702	634	setProperty	disabled;disabled	1	1	1	1900-01-01
708	650	setSize	90	1	1	1	1900-01-01
709	654	setProperty	disabled;disabled	1	1	1	1900-01-01
710	660	onblur	validaValorAlteravel('valorNominal')	1	1	1	1900-01-01
711	664	addItems	select seq,nomeconta from  dbplano_conta where statseq=1 and tipoconta='D'	1	1	1	1900-01-01
712	665	setProperty	disabled;disabled	1	1	1	1900-01-01
728	697	setSize	350	1	1	1	1900-01-01
729	696	setSize	350	1	1	1	1900-01-01
730	698	setSize	100%;80	1	1	1	1900-01-01
731	721	setSize	350	1	1	1	1900-01-01
732	722	setSize	400;60	1	1	1	1900-01-01
733	723	setSize	50	1	1	1	1900-01-01
734	724	setSize	250	1	1	1	1900-01-01
735	725	setSize	350	1	1	1	1900-01-01
738	730	addItems	1=>Contagem;2=>Somatória	1	1	1	1900-01-01
739	733	addItems	1=>Contagem;2=>Somatória	1	1	1	1900-01-01
1107	954	setSize	30	1	1	1	1900-01-01
700	640	addItems	select seq,pessnmrz from dbpessoa where fornecedor=true and statseq=1	1	1	1	1900-01-01
740	737	addItems	0=>Nenhum;1=>Diário;2=>Semanal;3=>Mensal;4=>Bimestral;5=>Trimestral;6=>Semestral;7=>Anual	1	1	1	1900-01-01
741	728	addItems	show tables like 'view%'	1	1	1	1900-01-01
742	731	addItems	show tables like 'view%'	1	1	1	1900-01-01
743	755	setSize	300;40	1	1	1	1900-01-01
745	667	setSize	80	1	1	1	1900-01-01
746	666	setSize	300	1	1	1	1900-01-01
747	738	setSize	350;80	1	1	1	1900-01-01
748	739	setSize	90	1	1	1	1900-01-01
776	761	addItems	1=>Orientação;2=>Arquivo	1	1	1	1900-01-01
777	622	setSize	350	1	1	1	1900-01-01
845	781	setSize	300	1	1	1	1900-01-01
847	815	setAction	onFormOpen(260,this)	1	1	1	1900-01-01
886	854	setSize	120	1	1	1	1900-01-01
887	855	setSize	40	1	1	1	1900-01-01
182	195	addItems	01=>01;02=>02;03=>03;04=>04;05=>05;06=>06;07=>07;08=>08;09=>09;10=>10;11=>11;12=>12;13=>13;14=>14;15=>15;16=>16;17=>17;18=>18;19=>19;20=>20;21=>21;22=>22;23=>23;24=>24;25=>25;26=>26;27=>27;28=>28;29=>29;30=>30	0	1	1	1900-01-01
895	796	setSize	450	1	1	1	1900-01-01
896	796	setProperty	disabled;disabled	1	1	1	1900-01-01
848	795	setProperty	disabled;disabled	1	1	1	1900-01-01
849	795	setSize	450	1	1	1	1900-01-01
888	856	setSize	20	1	1	1	1900-01-01
889	857	setSize	70	1	1	1	1900-01-01
894	804	setAction	setLocacao('bloc_retLocacao > .ui_bloco_conteudo','livrseq','pessseq','botPesqpessseq')	1	1	1	1900-01-01
850	816	setSize	350	1	1	1	1900-01-01
851	817	setSize	350	1	1	1	1900-01-01
854	819	setSize	200	1	1	1	1900-01-01
855	820	addItems	1=>Crédito;2=>Débito	1	1	1	1900-01-01
856	821	setSize	80	1	1	1	1900-01-01
858	823	setSize	100	1	1	1	1900-01-01
852	818	setSize	350;80	1	1	1	1900-01-01
860	819	addItems	1=>Desconto;2=>Bolsa;3=>Parceria	1	1	1	1900-01-01
1110	955	setSize	30	1	1	1	1900-01-01
783	775	addItems	select seq,nomeprofessor from view_professor	9	1	1	1900-01-01
863	824	setProperty	disabled;disabled	1	1	1	1900-01-01
864	824	setSize	450	1	1	1	1900-01-01
867	827	addItems	01=>01;02=>02;03=>03;04=>04;05=>05;06=>06;07=>07;08=>08;09=>09;10=>10;11=>11;12=>12;13=>13;14=>14;15=>15;16=>16;17=>17;18=>18;19=>19;20=>20;21=>21;22=>22;23=>23;24=>24;25=>25;26=>26;27=>27;28=>28;29=>29;30=>30; 31=>31	1	1	1	1900-01-01
869	826	setSize	80	1	1	1	1900-01-01
868	827	setSize	40	1	1	1	1900-01-01
870	828	setSize	80	1	1	1	1900-01-01
871	663	setSize	350	1	1	1	1900-01-01
900	858	setSize	450;200	1	1	1	1900-01-01
883	843	setSize	80	1	1	1	1900-01-01
884	852	setSize	80	1	1	1	1900-01-01
877	835	setSize	350	1	1	1	1900-01-01
878	836	setSize	350	1	1	1	1900-01-01
879	840	setSize	100%;200	1	1	1	1900-01-01
902	853	addItems	select seq,pessnmrz from dbpessoa	1	1	1	1900-01-01
881	829	disabled	true	1	1	1	1900-01-01
880	829	setSize	90	1	1	1	1900-01-01
901	854	addItems	select seq,nomeconta from  dbplano_conta	1	1	1	1900-01-01
1000	170	setProperty	disabled;disabled	1	1	1	1900-01-01
152	174	addItems	Dinheiro=>Dinheiro;Cheque=>Cheque;Cartão=>Cartão	1	1	1	1900-01-01
608	169	addItems	select seq,pessnmrz from  dbpessoa where statseq='1' order by pessnmrz	1	1	1	1900-01-01
132	166	disabled	true	1	1	1	1900-01-01
1019	178	setSize	60	1	1	1	1900-01-01
1003	155	onchange	viewMovimentacaoConta(this,'contFields207')	1	1	1	1900-01-01
1004	168	onchange	viewMovimentacaoConta(this,'contFields253')	1	1	1	1900-01-01
1005	859	setSize	40	1	1	1	1900-01-01
1007	861	setSize	60	1	1	1	1900-01-01
1009	863	setSize	300	1	1	1	1900-01-01
1010	864	setSize	200	1	1	1	1900-01-01
1011	865	setSize	60	1	1	1	1900-01-01
1012	866	setSize	60	1	1	1	1900-01-01
1020	879	setSize	60	1	1	1	1900-01-01
1026	870	setSize	80	1	1	1	1900-01-01
1032	878	setSize	80	1	1	1	1900-01-01
766	101	onChange	listaRefresh('blocFormProf',164)	1	1	1	1900-01-01
1033	882	setSize	150	1	1	1	1900-01-01
1034	882	addItems	1=>Conta Aberta;5=>Conta Programada	1	1	1	1900-01-01
1035	885	setSize	200	1	1	1	1900-01-01
1027	873	setSize	300	1	1	1	1900-01-01
1028	874	setSize	200	1	1	1	1900-01-01
1029	875	setSize	150	1	1	1	1900-01-01
1030	876	setSize	150	1	1	1	1900-01-01
1023	166	onChange;onBlur	calculaMovimentacao()	1	1	1	1900-01-01
1018	176	onChange;onBlur	calculaMovimentacao()	1	1	1	1900-01-01
1017	165	onChange;onBlur	calculaMovimentacao()	1	1	1	1900-01-01
1016	160	onChange;onBlur	calculaMovimentacao();validaValorRecebido('valorentrada','concluir_botform13')	1	1	1	1900-01-01
1006	859	readonly	readonly	1	1	1	1900-01-01
749	739	onChange;onBlur	calculaMovimentacao('valortotal','acrescimo','desconto',null,null,null,'valorcorrigido');	1	1	1	1900-01-01
1025	178	onChange;onBlur	calculaMovimentacao()	1	1	1	1900-01-01
1031	877	setSize	200	1	1	1	1900-01-01
1037	756	onchange	setMoney(this.value,this)	1	1	1	1900-01-01
1039	879	onchange	setMoney(this.value,this)	1	1	1	1900-01-01
1040	157	onchange	setMoney(this.value,this)	1	1	1	1900-01-01
874	667	onchange	setValorTotalProduto()	1	1	1	1900-01-01
1042	756	disabled	true	1	1	1	1900-01-01
875	831	onchange	setValorTotalProduto()	1	1	1	1900-01-01
687	617	setSize	100%;300	1	1	1	1900-01-01
1045	892	setSize	90	1	1	1	1900-01-01
1047	894	disabled	disabled	1	1	1	1900-01-01
1048	894	setSize	90	1	1	1	1900-01-01
1049	895	setSize	90	1	1	1	1900-01-01
1050	899	setSize	60	1	1	1	1900-01-01
1051	899	disabled	disabled	1	1	1	1900-01-01
1055	900	addItems	select seq,nomeconta from dbconta_financeira where statseq=1 order by nomeconta	1	1	1	1900-01-01
1061	908	addItems	1=>Sim;0=>Não	1	1	1	1900-01-01
763	750	setAction	addContas(this,'seq', 215)	1	1	1	1900-01-01
1052	897	setAction	addContas(this,'seq', 236)	1	1	1	1900-01-01
1056	905	setAction	geraMovimentacaoInterna()	1	1	1	1900-01-01
1057	902	addItems	select seq,nomeconta from dbconta_financeira where statseq=1 order by nomeconta	1	1	1	1900-01-01
1060	903	addItems	select seq,nomeconta from dbconta_financeira where statseq=1 order by nomeconta	1	1	1	1900-01-01
1062	909	setSize	30	1	1	1	1900-01-01
1063	910	SETsIZE	30	1	1	1	1900-01-01
551	517	addItems	select seq,titulo from dbprocesso_academico where statseq = 1	1	1	1	1900-01-01
171	683	addItems	select seq,titulo from dbprocesso_academico where statseq = 1	1	1	1	1900-01-01
1065	697	addItems	select seq,titulo from dbprocesso_academico where statseq = 1	1	1	1	1900-01-01
727	696	addItems	select pessseq,nomepessoa from view_aluno	1	1	1	1900-01-01
1066	105	setSize	450	1	1	1	1900-01-01
1067	913	setSize	450	1	1	1	1900-01-01
1069	916	setSize	450	1	1	1	1900-01-01
1070	917	setSize	450	1	1	1	1900-01-01
1071	918	setSize	450	1	1	1	1900-01-01
1072	919	setSize	150	1	1	1	1900-01-01
1073	920	setSize	150	1	1	1	1900-01-01
1074	921	setSize	250	1	1	1	1900-01-01
1075	922	setSize	100%;250	1	1	1	1900-01-01
1076	923	addItems	Aberto=>Aberto;Atendido=>Atendido	1	1	1	1900-01-01
1077	928	setSize	350	1	1	1	1900-01-01
1078	929	setSize	40	1	1	1	1900-01-01
1079	930	setSize	500;250	1	1	1	1900-01-01
1080	931	setSize	40	1	1	1	1900-01-01
1081	932	setSize	40	1	1	1	1900-01-01
1082	933	setSize	100%;250	1	1	1	1900-01-01
686	596	addItems	Próprio=>Próprio;Alugado=>Alugado;Aquisição=>Aquisição	1	1	1	1900-01-01
703	645	addItems	1=>Sim;2=>Não;	1	1	1	1900-01-01
704	646	addItems	1=>Sim;2=>Não;	1	1	1	1900-01-01
170	682	addItems	select seq,nomepessoa from view_aluno	1	1	1	1900-01-01
1084	682	disabled	disabled	1	1	1	1900-01-01
1087	937	setSize	350	1	1	1	1900-01-01
1088	938	setSize	50	1	1	1	1900-01-01
1089	939	setSize	50	1	1	1	1900-01-01
1090	217	addItems	0.5=>0.5;1.0=>1.0;1.5=>1.5;2.0=>2.0;2.5=>2.5;3.0=>3.0;3.5=>3.5;4.0=>4.0;4.5=>4.5;5.0=>5.0;5.5=>5.5;6.0=>6.0;6.5=>6.5;7.0=>7.0;7.5=>7.5;8.0=>8.0;8.5=>8.5;9.0=>9.0;9.5=>9.5;10.0=>10.0	1	1	1	1900-01-01
1091	938	addItems	0.5=>0.5;1.0=>1.0;1.5=>1.5;2.0=>2.0;2.5=>2.5;3.0=>3.0;3.5=>3.5;4.0=>4.0;4.5=>4.5;5.0=>5.0;5.5=>5.5;6.0=>6.0;6.5=>6.5;7.0=>7.0;7.5=>7.5;8.0=>8.0;8.5=>8.5;9.0=>9.0;9.5=>9.5;10.0=>10.0	1	1	1	1900-01-01
1092	940	setSize	650;140	1	1	1	1900-01-01
1093	941	setSize	650;140	1	1	1	1900-01-01
857	822	addItems	select seq,nomeconta from dbplano_conta order by nomeconta	1	1	1	1900-01-01
1094	943	addItems	--=>--;01=>01;02=>02;03=>03;04=>04;05=>05;06=>06;07=>07;08=>08;09=>09;10=>10;11=>11;12=>12;13=>13;14=>14;15=>15;16=>16;17=>17;18=>18;19=>19;20=>20;21=>21;22=>22;23=>23;24=>24;25=>25;26=>26;27=>27;28=>28;29=>29;30=>30;31=>31	1	1	1	1900-01-01
1106	953	setSize	300	1	1	1	1900-01-01
1	4	setSize	200	1	1	1	1900-01-01
2	15	setSize	200	1	1	1	1900-01-01
1022	859	onChange;onBlur	calculaMovimentacao();setMoney(this.value,this)	1	1	1	1900-01-01
1013	861	onChange;onBlur	calculaMovimentacao();	1	1	1	1900-01-01
751	740	onChange;onBlur	calculaMovimentacao('valortotal','acrescimo','desconto',null,null,null,'valorcorrigido');	1	1	1	1900-01-01
650	650	onChange;onBlur	calculaMovimentacao();	1	1	1	1900-01-01
122	161	onChange;onBlur	calculaMovimentacao();	1	1	1	1900-01-01
1044	891	onChange;onBlur	calculaMovimentacao('valortotal','acrescimo','desconto',null,null,null,'valorcorrigido');	1	1	1	1900-01-01
88	141	setSize	100	1	1	1	1900-01-01
90	128	setProperty	disabled;disabled	1	1	1	1900-01-01
721	694	addItems	select seq,nomedisciplina from view_turma_disciplina where statseq=1 order by nomedisciplina	9	1	1	1900-01-01
1111	956	setSize	250	1	1	1	1900-01-01
1112	956	addItems	select seq,titulo from dbavaliacoes_regras order by seq	1	1	1	1900-01-01
1113	957	setSize	250	1	1	1	1900-01-01
1114	959	setSize	50	1	1	1	1900-01-01
1115	960	setSize	300;50	1	1	1	1900-01-01
846	809	setAction	setMatricula(this, 'Você deseja realmente confirmar esta ação?')	1	1	1	1900-01-01
1117	964	disabled	disabled	1	1	1	1900-01-01
1118	964	setSize	50	1	1	1	1900-01-01
1119	961	setSize	80	1	1	1	1900-01-01
1120	963	setSize	80	1	1	1	1900-01-01
1121	965	setSize	80	1	1	1	1900-01-01
1122	966	setSize	80	1	1	1	1900-01-01
1123	967	setSize	80	1	1	1	1900-01-01
1124	966	disabled	disabled	1	1	1	1900-01-01
1125	967	disabled	disabled	1	1	1	1900-01-01
1126	965	disabled	disabled	1	1	1	1900-01-01
1127	968	disabled	disabled	1	1	1	1900-01-01
1128	969	disabled	disabled	1	1	1	1900-01-01
1129	507	onchange	calculaDebitoProfessor()	1	1	1	1900-01-01
1132	961	onchange	calculaDebitoProfessor()	1	1	1	1900-01-01
1131	508	onchange	calculaDebitoProfessor()	1	1	1	1900-01-01
1130	505	onchange	calculaDebitoProfessor()	1	1	1	1900-01-01
1133	963	onchange	calculaDebitoProfessor()	1	1	1	1900-01-01
1116	964	addItems	select seq,cargahoraria from dbdisciplina	1	1	1	1900-01-01
1136	965	setSize	80	1	1	1	1900-01-01
1137	966	setSize	80	1	1	1	1900-01-01
1138	967	setSize	80	1	1	1	1900-01-01
1139	968	setSize	80	1	1	1	1900-01-01
1140	969	setSize	80	1	1	1	1900-01-01
1141	970	setAction	setTransacaoProfessor('59')	1	1	1	1900-01-01
1142	974	setAction	setAbandonoCurso($('#alunseq_processo').val())	1	1	1	1900-01-01
1143	975	setAction	setDestrancamentoMatricula($('#alunseq_processo').val())	1	1	1	1900-01-01
1144	976	setAction	setTrancamentoCurso($('#alunseq_processo').val())	1	1	1	1900-01-01
882	841	addItems	0=>Aleatório;1=>Custom_petrus;2=>Eggplant;3=>Redmond;4=>Ui-lightness;5=>Black-tie;6=>Sunny;7=>Pepper-grinder;8=>Dot-luv;9=>Ui-tolook;10=>Blitzer;11=>Petrusedu;12=>Petrusedu_alternate;13=>Bluestyle;14=>Flick;15=>Humanity;16=>Overcast;17=>Bluetzer;18=>Fibratec;19=>Remake_bluetzer;20=>South-street;21=>Cupertino;22=>Petrus;	1	1	1	1900-01-01
1145	913	onChange	setCampoTurmaDisabled()	1	1	1	1900-01-01
1147	980	addItems	select seq,pessnmrz from  dbpessoas where statseq=1 order by pessnmrz	1	1	1	1900-01-01
1148	980	setProperty	disabled;disabled	1	1	1	1900-01-01
1149	980	setSize	450	1	1	1	1900-01-01
1150	981	disabled	disabled	1	1	1	1900-01-01
1151	981	setSize	40	1	1	1	1900-01-01
1152	977	addItems	C=>Crédito;D=>Débito	1	1	1	1900-01-01
1153	977	disabled	disabled	1	1	1	1900-01-01
1043	891	setSize	90	1	1	1	1900-01-01
1095	944	addItems	select seq,titulo from dbconvenio order by titulo	1	1	1	1900-01-01
1097	945	addItems	select seq,titulo from dbconvenio order by titulo	1	1	1	1900-01-01
1098	946	addItems	select seq,titulo from dbgrade_avaliacao order by titulo	1	1	1	1900-01-01
1101	949	addItems	select seq, nometurma || ' - ' || nomedisciplina || ' - ' || cargahoraria || ' hr' from view_turma_disciplina where status in ('1','5')	1	1	1	1900-01-01
1103	950	setAction	alteraDisciplinaAlunoEspecial('codigodisciplina_antiga','codigodisciplina_nova','codigoturmadisciplina')	1	1	1	1900-01-01
1105	952	setSize	400;50	1	1	1	1900-01-01
713	666	addItems	select seq,label from dbproduto where statseq=1	9	1	1	1900-01-01
699	639	addItems	select seq,pessnmrz from dbpessoa where funcionario=true and statseq=1 order by pessnmrz	1	1	1	1900-01-01
89	705	addItems	select seq,avaliacao  from dbturma_disciplina_avaliacao where statseq=1 order by avaliacao	9	1	1	1900-01-01
60	101	addItems	select seq,nomefuncionario from view_funcionario order by nomefuncionario	9	1	1	1900-01-01
250	629	addItems	select parcseq,parcseq from dbcaixa where tipo='C' and statseq='1'	9	1	1	1900-01-01
489	308	addItems	select seq,pessnmrz from dbpessoas where funcionario=true and statseq=1 order by pessnmrz	9	1	1	1900-01-01
499	287	addItems	select seq,nome from dbsala where statseq=1 order by nome	9	1	1	1900-01-01
159	177	addItems	getItens/view_caixa_funcionario/cofiseq/nomecontacaixa/funcseq,=,TUsuario::getSeqFuncionario;stcfseq,=,1	1	1	1	1900-01-01
554	533	addItems	select seq,nome from dbinsumo where statseq=1 order by nome	9	1	1	1900-01-01
563	523	addItems	select seq,nome from dbinsumo where statseq=1 order by nome	9	1	1	1900-01-01
553	521	addItems	select seq,nome from dbsala where salaaula=true and statseq=1 order by nome	9	1	1	1900-01-01
549	516	addItems	select seq,nomepessoa from view_aluno	9	1	1	1900-01-01
613	566	addItems	select seq,pessnmrz from dbpessoa where fornecedor=true and statseq=1 order by pessnmrz	9	1	1	1900-01-01
692	663	addItems	select seq,pessnmrz from dbpessoa where statseq=1 order by pessnmrz	9	1	1	1900-01-01
811	786	addItems	select seq,titulo from dbcurso where statseq=1 order by titulo	9	1	1	1900-01-01
812	784	addItems	select seq,cdu from dbcdu order by cdu	9	1	1	1900-01-01
817	797	addItems	select seq,titulo from view_livro where pessseq is not null order by titulo	9	1	1	1900-01-01
893	792	addItems	select seq,titulo from view_livro order by titulo	9	1	1	1900-01-01
820	796	addItems	select seq,pessnmrz from dbpessoas where cliente=true or funcionario=1 order by pessnmrz	9	1	1	1900-01-01
822	798	addItems	select seq,pessnmrz from dbpessoas where cliente=true or funcionario=1 order by pessnmrz	9	1	1	1900-01-01
859	816	addItems	select seq,pessnmrz from dbpessoa where statseq=1 order by pessnmrz	9	1	1	1900-01-01
862	824	addItems	select seq,titulo from view_convenio order by titulo	9	1	1	1900-01-01
789	776	addItems	select seq,nome from view_cursos	9	1	1	1900-01-01
876	835	addItems	select funcseq,nomefuncionario from view_funcionario	9	1	1	1900-01-01
815	795	addItems	select seq,titulo from view_livro where pessseq is null order by titulo	9	1	1	1900-01-01
496	492	addItems	select funcseq,nomefuncionario from view_funcionario order by nomefuncionario	9	1	1	1900-01-01
1064	912	addItems	select seq,titulo from dbdisciplina	9	1	1	1900-01-01
1068	913	addItems	select seq,pessnmrz from dbpessoa where statseq = 1	9	1	1	1900-01-01
694	634	addItems	select seq,label from dbproduto where statseq=1	9	1	1	1900-01-01
1099	947	addItems	select seq,nomedisciplina from view_alunos_disciplinas where situacao = '2'	9	1	1	1900-01-01
1100	948	addItems	select seq,nomedisciplina from view_alunos_disciplinas where situacao in ('1','5','6') and seq < 100	9	1	1	1900-01-01
414	281	addItems	select seq,pessnmrz from dbpessoas where funcionario=true and statseq=1 order by pessnmrz	9	1	1	1900-01-01
413	408	addItems	select seq,pessnmrz from dbpessoa where funcionario=true and statseq=1 order by pessnmrz	9	1	1	1900-01-01
389	393	addItems	select seq,pessnmrz from dbpessoas where fornecedor=true and statseq=1 order by pessnmrz	9	1	1	1900-01-01
564	524	addItems	select seq,pessnmrz from dbpessoa where fornecedor=true and statseq=1 order by pessnmrz	9	1	1	1900-01-01
592	134	addItems	select seq,pessnmrz from dbpessoa where fornecedor=true and statseq=1 order by pessnmrz	9	1	1	1900-01-01
653	715	addItems	select seq,pessnmrz from dbpessoa where funcionario=true and statseq=1	9	1	1	1900-01-01
818	794	addItems	select seq,pessnmrz from dbpessoas where cliente=true or funcionario=1 order by pessnmrz	9	1	1	1900-01-01
98	5	addItems	select seq,tptedesc from dbtipo_telefone where statseq != 9	1	1	1	2013-08-21
116	7	maxlength	2	1	1	1	2013-08-21
117	7	setSize	40	1	1	1	2013-08-21
479	482	addItems	select seq,titulo from dbtitularidade order by peso	1	1	1	1900-01-01
193	206	addItems	getItens/view_caixa_funcionario/cofiseq/nomecontacaixa/funcseq,=,TUsuario::getSeqFuncionario;stcfseq,=,1	1	1	1	1900-01-01
1036	885	addItems	select seq,titulo from dbsituacao_movimento order by titulo	1	1	1	1900-01-01
118	885	disabled	disabled	1	1	1	2013-10-03
62	103	addItems	select seq, statdesc from dbstatus order by statdesc	1	1	1	1900-01-01
119	12	maxlength	200	1	1	1	2013-10-09
126	24	maxlength	200	1	1	1	2013-10-09
128	194	maxlength	200	1	1	1	2013-10-09
130	251	maxlength	200	1	1	1	2013-10-09
134	318	maxlength	200	1	1	1	2013-10-09
135	354	maxlength	200	1	1	1	2013-10-09
136	439	maxlength	200	1	1	1	2013-10-09
140	439	setSize	450	1	1	1	2013-10-09
1021	880	addItems	0=> Dia Fixo;\n1=> 1 dia;\n2=> 2 dias;\n3=> 3 dias;\n4=> 4 dias;\n5=> 5 dias;\n6=> 6 dias;\n7=> 7 dias;\n8=> 8 dias;\n9=> 9 dias;\n10=> 10 dias;\n11=> 11 dias;\n12=> 12 dias;\n13=> 13 dias;\n14=> 14 dias;\n15=> 15 dias;\n16=> 16 dias;\n17=> 17 dias;\n18=> 18 dias;\n19=> 19 dias;\n20=> 20 dias;\n21=> 21 dias;\n22=> 22 dias;\n23=> 23 dias;\n24=> 24 dias;\n25=> 25 dias;\n26=> 26 dias;\n27=> 27 dias;\n28=> 28 dias;\n29=> 29 dias;\n30=> 30 dias;\n31=> 31 dias;\n32=> 32 dias;\n33=> 33 dias;\n34=> 34 dias;\n35=> 35 dias;\n36=> 36 dias;\n37=> 37 dias;\n38=> 38 dias;\n39=> 39 dias;\n40=> 40 dias;\n41=> 41 dias;\n42=> 42 dias;\n43=> 43 dias;\n44=> 44 dias;\n45=> 45 dias;\n46=> 46 dias;\n47=> 47 dias;\n48=> 48 dias;\n49=> 49 dias;\n50=> 50 dias;\n51=> 51 dias;\n52=> 52 dias;\n53=> 53 dias;\n54=> 54 dias;\n55=> 55 dias;\n56=> 56 dias;\n57=> 57 dias;\n58=> 58 dias;\n59=> 59 dias;\n60=> 60 dias	1	1	1	1900-01-01
6	16	addItems	0=> Dia Fixo;\n1=> 1 dia;\n2=> 2 dias;\n3=> 3 dias;\n4=> 4 dias;\n5=> 5 dias;\n6=> 6 dias;\n7=> 7 dias;\n8=> 8 dias;\n9=> 9 dias;\n10=> 10 dias;\n11=> 11 dias;\n12=> 12 dias;\n13=> 13 dias;\n14=> 14 dias;\n15=> 15 dias;\n16=> 16 dias;\n17=> 17 dias;\n18=> 18 dias;\n19=> 19 dias;\n20=> 20 dias;\n21=> 21 dias;\n22=> 22 dias;\n23=> 23 dias;\n24=> 24 dias;\n25=> 25 dias;\n26=> 26 dias;\n27=> 27 dias;\n28=> 28 dias;\n29=> 29 dias;\n30=> 30 dias;\n31=> 31 dias;\n32=> 32 dias;\n33=> 33 dias;\n34=> 34 dias;\n35=> 35 dias;\n36=> 36 dias;\n37=> 37 dias;\n38=> 38 dias;\n39=> 39 dias;\n40=> 40 dias;\n41=> 41 dias;\n42=> 42 dias;\n43=> 43 dias;\n44=> 44 dias;\n45=> 45 dias;\n46=> 46 dias;\n47=> 47 dias;\n48=> 48 dias;\n49=> 49 dias;\n50=> 50 dias;\n51=> 51 dias;\n52=> 52 dias;\n53=> 53 dias;\n54=> 54 dias;\n55=> 55 dias;\n56=> 56 dias;\n57=> 57 dias;\n58=> 58 dias;\n59=> 59 dias;\n60=> 60 dias	1	1	1	1900-01-01
142	31	setSize	300	1	1	1	2013-10-11
148	33	setSize	300	1	1	1	2013-10-11
150	423	onchange	validaCpfCnpj(this,$('input[name=tipo]').val())	1	1	1	2013-10-11
154	433	onchange	validaCpfCnpj(this,$('input[name=tipo]').val())	1	1	1	2013-10-11
123	163	addItems	select seq, titulo from dbforma_pagamento order by titulo	1	1	1	1900-01-01
160	656	setSize	200	1	1	1	2013-10-17
161	656	addItems	select seq,nomeconta from  dbplano_conta where tipoconta='C' and statseq='1' order by nomeconta	1	1	1	2013-10-17
168	206	onchange	onLoadValue(this, 'cxfuseq','TCaixa','getSeqCaixaFuncionario')	1	1	1	2013-10-17
105	649	onChange;onBlur	calculaMovimentacao();	1	1	1	1900-01-01
1046	892	onChange;onBlur	calculaMovimentacao('valortotal','acrescimo','desconto',null,null,null,'valorcorrigido');	1	1	1	1900-01-01
291	41	onChange;onBlur	calculaMovimentacao();	1	1	1	2013-10-18
334	157	onChange;onBLur	calculaMovimentacao();calculaMultas();	1	1	1	2013-10-18
335	41	readonly	readonly	1	1	1	2013-10-18
336	881	readonly	readonly	1	1	1	2013-10-18
415	165	readonly	readonly	1	1	1	2013-10-18
\.


--
-- TOC entry 2409 (class 0 OID 0)
-- Dependencies: 172
-- Name: campos_x_propriedades_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('campos_x_propriedades_seq_seq', 415, true);


--
-- TOC entry 2334 (class 0 OID 16444)
-- Dependencies: 173 2373
-- Data for Name: coluna; Type: TABLE DATA; Schema: public; Owner: -
--

COPY coluna (seq, listseq, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, tabseq, colunaaux, link, ordem, statseq, usuaseq, unidseq, datacad, tipodado) FROM stdin;
2	130	pessnmrf	CPF / CNPJ	center	center	150	TSetModel,setCpfcnpj	0	1	0	-	0	2	1	1	1	1900-01-01	numeric
495	231	pessnmrf	CPF	left	left	120	TSetModel,setCpfcnpj	0	1	0	-	0	2	1	1	1	1900-01-01	numeric
922	467	condicao	Condição	right	right	200	-	0	1	0	-	0	5	1	1	1	1900-01-01	string
15	6	codigoarea	DDD	center	center	80	-	0	1	0	-	0	1	1	1	1	2013-08-21	numeric
478	227	nomefuncionario	Responsável	left	left	250	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
493	227	status	Situação	left	left	100	TSolicitacao,getStatus	0	1	0	-	0	0	1	1	1	1900-01-01	string
518	178	status	Situação	left	left	100	TSolicitacao,getStatus	0	1	0	-	0	0	1	1	1	1900-01-01	string
600	271	cdu	Classificação CDU	left	left	150	-	0	1	0	-	0	2	1	1	1	1900-01-01	string
601	271	titulo	Titulo	left	left	300	-	0	1	0	-	0	3	1	1	1	1900-01-01	string
603	272	cdu	Classificação CDU	left	left	150	-	0	1	0	-	0	2	1	1	1	1900-01-01	string
604	272	titulo	Titulo	left	left	300	-	0	1	0	-	0	3	1	1	1	1900-01-01	string
853	422	formapag	Forma Pag.	left	left	70	-	0	1	0	-	0	8	1	1	1	1900-01-01	string
854	422	nomeconta	Origem/Destino	center	center	150	-	0	1	0	-	0	9	1	1	1	1900-01-01	string
728	381	pessnmrf	CPF/CNPJ	left	left	150	TSetModel,setCpfcnpj	0	1	0	-	0	2	1	1	1	1900-01-01	numeric
727	381	nometitular	Titular	left	left	300	-	0	1	0	-	0	1	1	1	1	1900-01-01	string
729	381	banco	Banco	left	left	100	-	0	1	0	-	0	3	1	1	1	1900-01-01	string
730	381	agencia	Ag.	left	left	40	-	0	1	0	-	0	4	1	1	1	1900-01-01	string
319	154	experiencia	Experiência Profissional	left	left	350	-	0	1	0	-	0	7	1	1	1	1900-01-01	string
8	132	nome	Curso	left	left	400	-	0	1	0	-	0	1	1	1	1	1900-01-01	string
9	132	areacurso	Area do curso	left	left	200	-	0	1	0	-	0	3	1	1	1	1900-01-01	string
363	132	tipocurso	Tipo do Curso	left	left	130	-	0	1	0	-	0	0	0	1	1	1900-01-01	string
546	242	nome	Curso	left	left	400	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
547	242	areacurso	Area do Curso	left	left	100	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
549	242	tipocurso	Tipo	left	left	300	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
829	417	nomedisciplinasemelhante	Disciplina Semelhante	left	left	400	-	0	1	0	-	0	1	1	1	1	1900-01-01	string
366	203	contaOrigem	Conta de Origem	left	left	200	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
367	203	contaDestino	Conta de Destino	left	left	200	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
368	203	tipoExtorno	Tipo de Extorno	left	left	200	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
628	277	cdu	CDU	left	left	60	-	0	1	0	-	0	9	1	1	1	1900-01-01	string
631	277	idioma	Idioma	left	left	100	-	0	1	0	-	0	7	1	1	1	1900-01-01	string
632	277	autor	Autor	left	left	200	-	0	1	0	-	0	3	1	1	1	1900-01-01	string
633	277	edicao	Edição	left	left	80	-	0	1	0	-	0	6	1	1	1	1900-01-01	string
634	277	editora	Editora	left	left	100	-	0	1	0	-	0	3	1	1	1	1900-01-01	string
635	278	titulo	Titulo	left	left	300	-	0	1	0	-	0	1	1	1	1	1900-01-01	string
620	259	cargahoraria	Carga horária	center	center	90	-	0	1	0	-	0	5	1	1	1	1900-01-01	numeric
548	242	cargahoraria	C.H. Total	left	left	60	-	0	1	0	-	0	0	1	1	1	1900-01-01	numeric
224	132	cargahoraria	C.H. Total	left	left	60	-	0	1	0	-	0	4	1	1	1	1900-01-01	numeric
185	171	dataFeriasPrevisao	Previsão de Férias	left	left	200	-	0	1	0	-	0	0	1	1	1	1900-01-01	date
369	203	valor	Valor	right	right	100	TSetModel,setValorMonetario	0	1	0	-	0	0	1	1	1	1900-01-01	numeric
629	277	paginas	Páginas	left	left	50	-	0	1	0	-	0	8	1	1	1	1900-01-01	numeric
477	227	data	Data	left	left	100	-	0	1	0	-	0	0	1	1	1	1900-01-01	date
630	277	ano	Ano	left	left	50	-	0	1	0	-	0	5	1	1	1	1900-01-01	numeric
852	422	vencimento	Data Venc.	left	left	70	-	0	1	0	-	0	7	1	1	1	1900-01-01	date
920	467	peso	Peso	center	center	60	-	0	1	0	-	0	3	1	1	1	1900-01-01	numeric
921	467	ordem	Ordem	center	center	60	-	0	1	0	-	0	4	1	1	1	1900-01-01	numeric
16	6	telefone	Telefone	left	left	200	TSetModel,setTelefone	0	1	0	-	0	2	1	1	1	2013-08-21	numeric
637	278	autor	Autor	left	left	200	-	0	1	0	-	0	3	1	1	1	1900-01-01	string
450	219	pessnmrf	CPF/CNPJ	left	left	100	TSetModel,setCpfcnpj	0	1	0	-	0	0	1	1	1	1900-01-01	numeric
406	212	pessnmrf	CPF / CNPJ	right	right	150	TSetModel,setCpfcnpj	0	1	0	-	0	2	1	1	1	1900-01-01	numeric
158	160	pessnmrz	Nome / Razão Social	left	left	250	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
175	165	pessnmrz	Nome / Razão Social	left	left	200	-	0	1	0	-	0	1	1	1	1	1900-01-01	string
191	160	cidade	Cidade	left	left	200	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
192	160	estado	Estado	left	left	50	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
405	212	pessnmrz	Nome	left	left	300	-	0	1	0	-	0	1	1	1	1	1900-01-01	string
449	219	pessnmrz	Nome	left	left	300	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
451	219	cliente	Cliente	left	left	50	TStatus,getBoolean	0	1	0	-	0	0	1	1	1	1900-01-01	string
452	219	fornecedor	Forn.	left	left	50	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
271	186	nomeCobranca	Nome	left	left	300	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
206	173	curso	Curso	left	left	240	-	0	1	0	-	0	2	1	1	1	1900-01-01	string
595	269	titulolivro	Titulo	left	left	300	-	0	1	0	-	0	2	1	1	1	1900-01-01	string
596	269	autorlivro	Autor	left	left	150	-	0	1	0	-	0	3	1	1	1	1900-01-01	string
381	208	label	Produto	left	left	300	-	0	1	0	-	0	1	1	1	1	1900-01-01	string
216	174	nome	Sala	left	left	200	-	0	1	0	-	0	2	1	1	1	1900-01-01	string
217	174	endereco	Endereço	left	left	400	-	0	1	0	-	0	3	1	1	1	1900-01-01	string
218	174	nomeunidade	Unidade	left	left	180	-	0	1	0	-	0	4	1	1	1	1900-01-01	string
426	145	nomepessoa	Clientes	left	left	300	-	0	1	0	-	0	2	1	1	1	1900-01-01	string
438	146	nomepessoa	Pessoa	left	left	300	-	0	1	0	-	0	4	1	1	1	1900-01-01	string
509	207	descricao	Descrição	left	left	450	-	0	1	0	-	0	2	1	1	1	1900-01-01	string
575	228	status	Situação	left	left	70	TTurma,getStatus	0	1	0	-	0	8	1	1	1	1900-01-01	string
900	453	nomeconvenio	Convênio	left	left	300	-	0	1	0	-	0	1	1	1	1	1900-01-01	string
705	327	tipodesconto	Tipo	left	left	160	TTurma,getTipoDesconto	0	1	0	-	0	0	1	1	1	1900-01-01	string
20	135	nomedisciplina	Disciplina	left	left	400	-	0	1	0	-	0	2	1	1	1	1900-01-01	string
21	135	nomeprofessor	Professor	left	left	300	-	0	1	0	-	0	3	1	1	1	1900-01-01	string
298	193	nometurma	Turma	left	left	180	-	0	1	0	-	0	4	1	1	1	1900-01-01	string
299	193	nomedisciplina	Disciplina	left	left	200	-	0	1	0	-	0	3	1	1	1	1900-01-01	string
300	193	nomeprofessor	Professor	left	left	200	-	0	1	0	-	0	6	1	1	1	1900-01-01	string
792	200	sala	Sala	left	left	150	-	0	1	0	-	0	8	1	1	1	1900-01-01	string
805	410	nometurma	Turma	left	left	180	-	0	1	0	-	0	3	1	1	1	1900-01-01	string
806	410	nomedisciplina	Disciplina	left	left	200	-	0	1	0	-	0	4	1	1	1	1900-01-01	string
807	410	nomeprofessor	Professor	left	left	200	-	0	1	0	-	0	5	1	1	1	1900-01-01	string
810	410	nomecurso	Curso	left	left	250	-	0	1	0	-	0	2	1	1	1	1900-01-01	string
812	410	sala	Sala	left	left	150	-	0	1	0	-	0	8	1	1	1	1900-01-01	string
441	146	valoratual	Valor Atual	right	right	100	TSetModel,setValorMonetario	0	1	0	-	0	6	1	1	1	1900-01-01	numeric
425	215	numero	Parcela	center	center	70	-	0	1	0	-	0	3	1	1	1	1900-01-01	numeric
442	146	vencimento	Vencimento	center	center	80	-	0	1	0	-	0	5	1	1	1	1900-01-01	date
424	215	valoratual	Valor Atual	right	right	100	TSetModel,setValorMonetario	0	1	0	-	0	1	1	1	1	1900-01-01	numeric
598	269	previsaoentrada	Devolução	left	left	100	-	0	1	0	-	0	6	1	1	1	1900-01-01	date
597	269	confirmacaosaida	Data de Saida	left	left	100	-	0	1	0	-	0	5	1	1	1	1900-01-01	date
703	327	dialimite	Dia Limite	left	left	100	-	0	1	0	-	0	0	1	1	1	1900-01-01	numeric
704	327	valordescontado	Valor/Percentual	right	right	120	TSetModel,setMoney	0	1	0	-	0	0	1	1	1	1900-01-01	numeric
808	410	frequencia	Frequência	left	left	80	-	0	1	0	-	0	7	1	1	1	1900-01-01	numeric
809	410	alunos	Nº de Alunos	left	left	80	-	0	1	0	-	0	6	1	1	1	1900-01-01	numeric
879	427	retorno	Retorno	center	center	80	-	0	1	0	-	0	10	1	1	1	1900-01-01	date
813	411	nometurma	Turma	left	left	180	-	0	1	0	-	0	3	1	1	1	1900-01-01	string
915	466	seq	Cod.	center	center	100	-	0	1	0	-	0	1	1	1	1	1900-01-01	numeric
431	216	discseq	Disciplina	left	left	100	-	0	1	0	-	0	0	1	1	1	1900-01-01	numeric
145	158	nomeUnidade	Nome	left	left	300	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
198	158	cidade	Cidade	left	left	150	-	0	1	0	-	0	5	1	1	1	1900-01-01	string
199	158	estado	Estado	left	left	50	-	0	1	0	-	0	6	1	1	1	1900-01-01	string
200	158	gerente	Gerente Geral	left	left	200	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
927	470	seq	Cod.	center	center	100	-	0	1	0	-	0	1	1	1	1	1900-01-01	numeric
599	271	seq	Cod.	left	left	100	-	0	1	0	-	0	1	1	1	1	1900-01-01	numeric
602	272	seq	Cod.	left	left	100	-	0	1	0	-	0	1	1	1	1	1900-01-01	numeric
76	144	seq	Cod.	center	center	110	-	0	1	0	-	0	1	1	1	1	1900-01-01	numeric
89	144	transeq	Transação	left	left	80	-	0	1	0	-	0	4	0	1	1	1900-01-01	numeric
370	204	parcseq	Conta	left	left	200	-	0	1	0	-	0	0	1	1	1	1900-01-01	numeric
372	205	parcseq	Conta	left	left	200	-	0	1	0	-	0	0	1	1	1	1900-01-01	numeric
739	382	seq	Cod.:	center	center	110	-	0	1	0	-	0	1	1	1	1	1900-01-01	numeric
742	388	seq	Cod.:	center	center	110	-	0	1	0	-	0	1	1	1	1	1900-01-01	numeric
748	391	seq	Cod.	center	center	110	-	0	1	0	-	0	1	0	1	1	1900-01-01	numeric
953	481	seq	Cod.	center	center	110	-	0	1	0	-	0	1	0	1	1	1900-01-01	numeric
135	153	seq	Código	left	left	80	-	0	1	0	-	0	2	0	1	1	1900-01-01	numeric
831	419	seq	Cod. Histórico	center	center	120	-	0	1	0	-	0	1	1	1	1	1900-01-01	numeric
778	394	seq	Cod.	center	center	120	-	0	1	0	-	0	1	1	1	1	1900-01-01	numeric
680	321	seq	Código	center	center	100	-	0	1	0	-	0	1	1	1	1	1900-01-01	numeric
695	323	seq	codigo	center	center	100	-	0	1	0	-	0	0	1	1	1	1900-01-01	numeric
164	162	pessseq	Fornecedor	left	left	250	-	0	1	0	-	0	0	1	1	1	1900-01-01	numeric
173	164	prodseq	Produto	left	left	300	-	0	1	0	-	0	1	1	1	1	1900-01-01	numeric
246	180	prodseq	Produto	left	left	200	-	0	1	0	-	0	0	1	1	1	1900-01-01	numeric
247	180	pessseq	Fornecedor	left	left	300	-	0	1	0	-	0	0	1	1	1	1900-01-01	numeric
657	310	seq	Cód. Curso	center	center	100	-	0	1	0	-	0	1	1	1	1	1900-01-01	numeric
660	314	seq	Cod.	left	left	80	-	0	1	0	-	0	1	1	1	1	1900-01-01	numeric
18	134	discseq	Codigo	center	center	120	-	0	1	0	-	0	1	1	1	1	1900-01-01	numeric
779	396	discseq	Cod.	center	center	120	-	0	1	0	-	0	1	1	1	1	1900-01-01	numeric
780	243	discseq	Cod.	center	center	120	-	0	1	0	-	0	1	1	1	1	1900-01-01	numeric
935	477	discseq	Codigo	center	center	120	-	0	1	0	-	0	1	1	1	1	1900-01-01	numeric
573	259	arcuseq	Area	left	left	200	-	0	1	0	-	0	3	1	1	1	1900-01-01	numeric
574	259	tpcuseq	Tipo	left	left	200	-	0	1	0	-	0	4	1	1	1	1900-01-01	numeric
776	131	seq	Cod.	center	center	120	-	0	1	0	-	0	1	1	1	1	1900-01-01	numeric
777	187	seq	Cod.	center	center	120	-	0	1	0	-	0	1	1	1	1	1900-01-01	numeric
184	171	funcseq	Funcionário	left	left	300	-	0	1	0	-	0	0	1	1	1	1900-01-01	numeric
141	157	funcseq	Funcionário	left	left	300	-	0	1	0	-	0	0	1	1	1	1900-01-01	numeric
289	191	seq	Curso	left	left	300	-	0	1	0	-	0	0	1	1	1	1900-01-01	numeric
467	155	seq	Cod.	left	left	100	-	0	1	0	-	0	1	1	1	1	1900-01-01	numeric
611	274	phaseq	PHA	left	left	60	-	0	1	0	-	0	11	1	1	1	1900-01-01	numeric
613	274	livrseq	Cod. Livro	left	left	100	-	0	1	0	-	0	1	1	1	1	1900-01-01	numeric
618	237	livrseq	Cod. Livro	left	left	100	-	0	1	0	-	0	1	1	1	1	1900-01-01	numeric
626	277	phaseq	PHA	left	left	60	-	0	1	0	-	0	11	1	1	1	1900-01-01	numeric
644	278	phaseq	PHA	left	left	60	-	0	1	0	-	0	10	1	1	1	1900-01-01	numeric
670	237	phaseq	PHA	left	left	60	-	0	1	0	-	0	10	1	1	1	1900-01-01	numeric
677	319	phaseq	PHA	left	left	40	-	0	1	0	-	0	6	1	1	1	1900-01-01	numeric
711	331	phaseq	codigopha	left	left	60	-	0	1	0	-	0	9	1	1	1	1900-01-01	numeric
746	277	livrseq	Cod.	left	left	80	-	0	1	0	-	0	1	1	1	1	1900-01-01	numeric
747	278	livrseq	Cod.	left	left	80	-	0	1	0	-	0	1	1	1	1	1900-01-01	numeric
5	130	statseq	Status	right	right	90	-	0	1	0	-	0	6	0	1	1	1900-01-01	numeric
72	143	seq	Cod.	center	center	130	-	0	1	0	-	0	0	0	1	1	1900-01-01	numeric
75	143	statseq	Estatus	center	center	100	-	0	1	0	-	0	0	1	1	1	1900-01-01	numeric
157	160	seq	Codigo	left	left	100	-	0	1	0	-	0	0	0	1	1	1900-01-01	numeric
176	165	seq	Código	left	left	100	-	0	1	0	-	0	2	1	1	1	1900-01-01	numeric
336	130	seq	Escolaridade	left	left	200	-	0	1	0	-	0	7	0	1	1	1900-01-01	numeric
409	212	statseq	Status	right	right	90	-	0	1	0	-	0	6	0	1	1	1900-01-01	numeric
410	212	seq	Escolaridade	left	left	200	-	0	1	0	-	0	7	0	1	1	1900-01-01	numeric
448	219	seq	Código	left	left	90	-	0	1	0	-	0	0	1	1	1	1900-01-01	numeric
365	148	seq	N. Matrícula	center	center	80	-	0	1	0	-	0	1	1	1	1	1900-01-01	numeric
859	423	seq	Matricula	center	center	80	-	0	1	0	-	0	1	1	1	1	1900-01-01	numeric
913	457	seq	N. Matrícula	center	center	80	-	0	1	0	-	0	1	1	1	1	1900-01-01	numeric
914	458	seq	N. Matrícula	center	center	80	-	0	1	0	-	0	1	1	1	1	1900-01-01	numeric
688	322	seq	Código	center	center	100	-	0	1	0	-	0	1	1	1	1	1900-01-01	numeric
581	265	livrseq	Cod. Livro	left	left	100	-	0	1	0	-	0	1	1	1	1	1900-01-01	numeric
589	268	livrseq	Cod. Livro	left	left	100	-	0	1	0	-	0	1	1	1	1	1900-01-01	numeric
594	269	livrseq	Cod. Livro	left	left	100	-	0	1	0	-	0	1	1	1	1	1900-01-01	numeric
44	140	seq	Cod.	center	center	110	-	0	1	0	-	0	1	0	1	1	1900-01-01	numeric
53	140	statseqtitulo	Situação	left	left	80	-	0	1	0	-	0	5	1	1	1	1900-01-01	numeric
161	161	seq	Codigo	left	left	120	-	0	1	0	-	0	0	0	1	1	1900-01-01	numeric
500	233	profseq	Professor	left	left	400	-	0	1	0	-	0	0	1	1	1	1900-01-01	numeric
220	174	seq	Código	left	left	100	-	0	1	0	-	0	1	0	1	1	1900-01-01	numeric
520	238	moduseq	Módulo	left	left	100	-	0	1	0	-	0	0	1	1	1	1900-01-01	numeric
170	163	seq	Cod.	left	left	110	-	0	1	0	-	0	1	1	1	1	1900-01-01	numeric
885	206	seq	Codigo	center	center	120	-	0	1	0	-	0	1	1	1	1	1900-01-01	numeric
436	146	transeq	Transação	left	left	70	-	0	1	0	-	0	2	0	1	1	1900-01-01	numeric
437	146	seq	Cod.	left	left	80	-	0	1	0	-	0	1	1	1	1	1900-01-01	numeric
514	210	seq	Cod. Conta	center	center	100	-	0	1	0	-	0	1	1	1	1	1900-01-01	numeric
725	146	pessseq	Cod. Pessoa	left	left	100	-	0	1	0	-	0	3	0	1	1	1900-01-01	numeric
884	142	seq	Codigo	center	center	120	-	0	1	0	-	0	1	1	1	1	1900-01-01	numeric
949	479	seq	Cod.	left	left	80	-	0	1	0	-	0	1	1	1	1	1900-01-01	numeric
984	488	seq	Codigo	center	center	120	-	0	1	0	-	0	1	1	1	1	1900-01-01	numeric
36	139	seq	Cod.	left	left	100	-	0	1	0	-	0	0	0	1	1	1900-01-01	numeric
10	133	seq	Cod.	center	center	100	-	0	1	0	-	0	1	1	1	1	1900-01-01	numeric
22	135	discseq	Cod.	left	left	120	-	0	1	0	-	0	1	1	1	1	1900-01-01	numeric
471	226	seq	Cod.	left	left	100	-	0	1	0	-	0	2	1	1	1	1900-01-01	numeric
649	193	seq	Cod.	left	left	100	-	0	1	0	-	0	1	1	1	1	1900-01-01	numeric
781	398	discseq	Cod.	left	left	120	-	0	1	0	-	0	1	1	1	1	1900-01-01	numeric
782	402	discseq	Cod.	left	left	120	-	0	1	0	-	0	2	1	1	1	1900-01-01	numeric
783	217	discseq	Cod.	left	left	120	-	0	1	0	-	0	1	1	1	1	1900-01-01	numeric
784	193	discseq	Cod.	left	left	120	-	0	1	0	-	0	2	1	1	1	1900-01-01	numeric
785	226	discseq	Cod. Disciplina	left	left	120	-	0	1	0	-	0	1	1	1	1	1900-01-01	numeric
786	199	discseq	Cod.	left	left	120	-	0	1	0	-	0	1	1	1	1	1900-01-01	numeric
787	200	discseq	Cod.	left	left	120	-	0	1	0	-	0	1	1	1	1	1900-01-01	numeric
811	410	discseq	Cod.	left	left	120	-	0	1	0	-	0	1	1	1	1	1900-01-01	numeric
791	228	nome	Ref. Curso	left	left	160	-	0	1	0	-	0	3	1	1	1	1900-01-01	numeric
790	182	nome	Ref. Curso	left	left	160	-	0	1	0	-	0	3	1	1	1	1900-01-01	numeric
789	149	nome	Ref. Curso	left	left	160	-	0	1	0	-	0	3	1	1	1	1900-01-01	numeric
819	411	discseq	Cod.	left	left	120	-	0	1	0	-	0	1	1	1	1	1900-01-01	numeric
827	412	discseq	Cod.	left	left	120	-	0	1	0	-	0	1	1	1	1	1900-01-01	numeric
918	467	seq	Cod.	center	center	100	-	0	1	0	-	0	1	1	1	1	1900-01-01	numeric
120	152	statseq	Situação	center	center	60	-	0	1	0	-	0	4	1	1	1	1900-01-01	numeric
508	235	seq	Cod.	left	left	100	-	0	1	0	-	0	0	1	1	1	1900-01-01	numeric
110	150	statseq	Situação	center	center	80	-	0	1	0	-	0	2	1	1	1	1900-01-01	numeric
144	158	seq	Un.	left	left	30	-	0	1	0	-	0	0	1	1	1	1900-01-01	numeric
152	159	prodseq	Nome Produto / Serviço	left	left	200	-	0	1	0	-	0	0	1	1	1	1900-01-01	numeric
153	159	plcoseq	Conta	left	left	200	-	0	1	0	-	0	0	1	1	1	1900-01-01	numeric
404	145	seq	Cod.	left	left	80	-	0	1	0	-	0	1	1	1	1	1900-01-01	numeric
757	391	stmoseq	Situação	left	left	80	TSetModel,setStatusMovimento	0	1	0	-	0	12	1	1	1	1900-01-01	numeric
580	184	seq	Cód. Curso	center	center	100	-	0	1	0	-	0	1	1	1	1	1900-01-01	numeric
893	447	avaliacao	Avaliação	left	left	300	-	0	1	0	-	0	1	1	1	1	1900-01-01	string
916	466	titulo	Título	left	left	200	-	0	1	0	-	0	2	1	1	1	1900-01-01	string
917	466	observacoes	Obs.	left	left	200	-	0	1	0	-	0	3	1	1	1	1900-01-01	string
468	225	nomepessoa	Aluno	left	left	300	-	0	1	0	-	0	1	1	1	1	1900-01-01	string
469	225	nomedisciplina	Disciplina	left	left	300	-	0	1	0	-	0	3	1	1	1	1900-01-01	string
470	225	situacao	Situação	left	left	100	TAluno,getSituacaoAlunoDisciplina	0	1	0	-	0	4	1	1	1	1900-01-01	string
510	225	nometurma	Turma	left	left	300	-	0	1	0	-	0	2	1	1	1	1900-01-01	string
537	241	nomePessoa	Aluno	left	left	200	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
538	241	nomedisciplina	Disciplina	left	left	200	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
539	241	nometurma	Turma	left	left	200	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
540	241	nomecurso	Curso	left	left	200	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
886	443	nomedisciplina	Disciplina	left	left	300	-	0	1	0	-	0	1	1	1	1	1900-01-01	string
887	443	nometurma	Turma	left	left	200	-	0	1	0	-	0	2	1	1	1	1900-01-01	string
888	443	situacao	Situação	left	left	100	TAluno,getSituacaoAlunoDisciplina	0	1	0	-	0	3	1	1	1	1900-01-01	string
901	455	nomedisciplina	Disciplina	left	left	300	-	0	1	0	-	0	1	1	1	1	1900-01-01	string
902	455	nometurma	Turma	left	left	200	-	0	1	0	-	0	2	1	1	1	1900-01-01	string
903	456	nomedisciplina	Disciplina	left	left	300	-	0	1	0	-	0	1	1	1	1	1900-01-01	string
904	456	nometurma	Turma	left	left	200	-	0	1	0	-	0	2	1	1	1	1900-01-01	string
428	216	matAluno	Aluno	left	left	300	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
429	216	datafalta	Data	left	left	100	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
430	216	numAula	Aula	left	left	20	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
889	445	nomedisciplina	Disciplina	left	left	300	-	0	1	0	-	0	1	1	1	1	1900-01-01	string
892	445	justificativa	Justificativa	left	left	300	-	0	1	0	-	0	4	1	1	1	1900-01-01	string
928	470	avaliacao	Avaliação	center	center	100	-	0	1	0	-	0	2	1	1	1	1900-01-01	string
929	470	nomepessoa	Aluno	left	left	300	-	0	1	0	-	0	3	1	1	1	1900-01-01	string
930	470	nomedisciplina	Disciplina	left	left	200	-	0	1	0	-	0	4	1	1	1	1900-01-01	string
931	470	nometurma	Turma	left	left	200	-	0	1	0	-	0	5	1	1	1	1900-01-01	string
238	178	nomealuno	Aluno	left	left	250	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
890	445	datafalta	Data	center	center	100	-	0	1	0	-	0	2	1	1	1	1900-01-01	date
894	447	notamax	Nota Max.	center	center	100	-	0	1	0	-	0	2	1	1	1	1900-01-01	numeric
895	447	peso	Peso	center	center	100	-	0	1	0	-	0	3	1	1	1	1900-01-01	numeric
897	449	dialimite	Dia Limite	left	left	100	-	0	1	0	-	0	1	1	1	1	1900-01-01	numeric
898	449	valor	Valor	right	right	100	TSetModel,setValorMonetario	0	1	0	-	0	2	1	1	1	1900-01-01	numeric
932	470	nota	Nota	center	center	100	-	0	1	0	-	0	6	1	1	1	1900-01-01	numeric
933	470	datacad	Data	center	center	100	-	0	1	0	-	0	7	1	1	1	1900-01-01	date
239	178	solicitacao	Solicitação	left	left	300	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
241	178	nomefuncionario	Responsável	left	left	200	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
459	222	nomealuno	Aluno	left	left	250	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
460	222	solicitacao	Solicitação	left	left	300	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
462	222	status	Situação	left	left	100	TSolicitacao,getStatus	0	1	0	-	0	0	1	1	1	1900-01-01	string
475	227	nomealuno	Aluno	left	left	250	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
476	227	solicitacao	Solicitação	left	left	300	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
77	144	nomepessoa	Cliente/Fornecedor	left	left	200	-	0	1	0	-	0	2	1	1	1	1900-01-01	string
78	144	numdoc	Nº Documento	center	center	120	-	0	1	0	-	0	11	0	1	1	1900-01-01	string
88	144	formapag	Forma Pag	center 	center	70	-	0	1	0	-	0	10	1	1	1	1900-01-01	string
95	144	nomeplanoconta	Plano de Contas	left	left	150	-	0	1	0	-	0	5	1	1	1	1900-01-01	string
148	144	nomeconta	Origem / Destino	left	left	150	-	0	1	0	-	0	11	1	1	1	1900-01-01	string
740	382	nomepessoa	Cliente/Fornecedor	center	left	250	-	0	1	0	-	0	2	1	1	1	1900-01-01	string
741	382	valorpago	Valor	right	right	100	-	0	1	0	-	0	3	1	1	1	1900-01-01	string
743	388	nomepessoa	Fornecedor	center	left	250	-	0	1	0	-	0	2	1	1	1	1900-01-01	string
749	391	nomepessoa	Cliente / Fornecedor	left	left	250	-	0	1	0	-	0	2	1	1	1	1900-01-01	string
750	391	numdoc	Nº Documento	center	center	120	-	0	1	0	-	0	11	0	1	1	1900-01-01	string
756	391	formapag	Forma Pag	center	center	65	-	0	1	0	-	0	10	1	1	1	1900-01-01	string
758	391	nomeplanoconta	Plano de Contas	left	left	200	-	0	1	0	-	0	5	1	1	1	1900-01-01	string
759	391	nomeconta	Origem / Destino	left	left	200	-	0	1	0	-	0	11	1	1	1	1900-01-01	string
846	422	nomepessoa	Cliente/Fornecedor	left	left	200	-	0	1	0	-	0	1	1	1	1	1900-01-01	string
848	422	nomeplanoconta	Plano de Contas	left	left	150	-	0	1	0	-	0	3	1	1	1	1900-01-01	string
79	144	tipo	Mov.	center	center	40	-	0	1	0	-	0	3	1	1	1	1900-01-01	string
847	422	tipo	Mov.	center	center	40	-	0	1	0	-	0	2	1	1	1	1900-01-01	string
751	391	tipo	Mov.	center	center	40	-	0	1	0	-	0	3	1	1	1	1900-01-01	string
860	425	nomepessoa	Cliente	left	left	200	-	0	1	0	-	0	1	1	1	1	1900-01-01	string
862	425	nomeplanoconta	Plano de Contas	left	left	150	-	0	1	0	-	0	3	1	1	1	1900-01-01	string
86	144	valorfinal	Valor Pago	right	right	80	TSetModel,setValorMonetario	0	1	0	-	0	6	1	1	1	1900-01-01	numeric
863	425	valorpago	Valor Pago	right	right	80	TSetModel,setValorMonetario	0	1	0	-	0	4	1	1	1	1900-01-01	numeric
753	391	vencimento	Data Venc.	center	center	70	-	0	1	0	-	0	9	1	1	1	1900-01-01	date
85	144	vencimento	Data Venc.	center	center	70	-	0	1	0	-	0	9	1	1	1	1900-01-01	date
87	144	datacad	Data Pag	center	center	70	-	0	1	0	-	0	7	1	1	1	1900-01-01	date
240	178	data	Data	left	left	100	-	0	1	0	-	0	0	1	1	1	1900-01-01	date
371	204	valorPago	Valor Pago	right	right	100	TSetModel,setValorMonetario	0	1	0	-	0	0	1	1	1	1900-01-01	numeric
373	205	valorPago	Valor Pago	right	right	100	TSetModel,setValorMonetario	0	1	0	-	0	0	1	1	1	1900-01-01	numeric
461	222	data	Data	left	left	100	-	0	1	0	-	0	0	1	1	1	1900-01-01	date
744	388	valorpago	Valor	right	right	100	-	0	1	0	-	0	3	1	1	1	1900-01-01	numeric
752	391	valor	Valor Nominal	right	right	100	TSetModel,setValorMonetario	0	1	0	-	0	8	1	1	1	1900-01-01	numeric
754	391	valorpago	Valor Pago	right	right	80	TSetModel,setValorMonetario	0	1	0	-	0	6	1	1	1	1900-01-01	numeric
755	391	datacad	Data Pag	center	center	65	-	0	1	0	-	0	7	1	1	1	1900-01-01	date
849	422	valorpago	Valor Pago	right	right	80	TSetModel,setValorMonetario	0	1	0	-	0	4	1	1	1	1900-01-01	numeric
850	422	datacad	Dapa Pag	center	center	70	-	0	1	0	-	0	5	1	1	1	1900-01-01	date
851	422	valor	Valor Nominal	right	right	100	TSetModel,setValorMonetario	0	1	0	-	0	6	1	1	1	1900-01-01	numeric
864	425	datacad	Data Pag.	center	center	70	-	0	1	0	-	0	5	1	1	1	1900-01-01	date
865	425	valor	Valor Nominal	right	right	100	TSetModel,setValorMonetario	0	1	0	-	0	6	1	1	1	1900-01-01	numeric
867	425	formapag	Forma Pag.	left	left	70	-	0	1	0	-	0	8	1	1	1	1900-01-01	string
868	425	nomeconta	Origem/Destino	center	center	150	-	0	1	0	-	0	9	1	1	1	1900-01-01	string
954	481	nomepessoa	Cliente/Fornecedor	left	left	200	-	0	1	0	-	0	2	0	1	1	1900-01-01	string
955	481	numdoc	Nº Documento	center	center	120	-	0	1	0	-	0	1	1	1	1	1900-01-01	string
961	481	formapag	Forma Pag	center 	center	70	-	0	1	0	-	0	8	1	1	1	1900-01-01	string
963	481	nomeplanoconta	Plano de Contas	left	left	150	-	0	1	0	-	0	7	1	1	1	1900-01-01	string
964	481	nomeconta	Origem / Destino	left	left	150	-	0	1	0	-	0	9	1	1	1	1900-01-01	string
721	335	nomefuncionario	Funcionário	left	left	300	-	0	1	0	-	0	1	1	1	1	1900-01-01	string
722	335	nomecargo	Cargo	left	left	100	-	0	1	0	-	0	2	1	1	1	1900-01-01	string
770	335	nomecontacaixa	Conta Caixa	left	left	300	-	0	1	0	-	0	3	1	1	1	1900-01-01	string
123	153	nomeCargo	Nome do Cargo	left	left	180	-	0	1	0	-	0	1	1	1	1	1900-01-01	string
124	153	descricao	Descrição do Cargo	left	left	600	-	0	1	0	-	0	3	1	1	1	1900-01-01	string
111	151	nomeConta	Conta	left	left	300	-	0	1	0	-	0	1	1	1	1	1900-01-01	string
112	151	tipoConta	Tipo da Conta	left	left	150	-	0	1	0	-	0	2	1	1	1	1900-01-01	string
113	151	banco	Banco	left	left	200	-	0	1	0	-	0	3	1	1	1	1900-01-01	string
114	151	numConta	N da Conta	center	center	70	-	0	1	0	-	0	4	1	1	1	1900-01-01	string
115	151	agencia	Agencia	center	center	60	-	0	1	0	-	0	5	1	1	1	1900-01-01	string
322	151	nomeConta	Conta	left	left	200	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
832	419	nomeconta	Conta Caixa	left	left	200	-	0	1	0	-	0	2	1	1	1	1900-01-01	string
833	419	tipoconta	Tipo	left	left	200	-	0	1	0	-	0	3	1	1	1	1900-01-01	string
317	154	escolaridade	Escolaridade	left	left	350	-	0	1	0	-	0	5	0	1	1	1900-01-01	string
861	425	tipo	Mov.	center	center	40	-	0	1	0	-	0	2	1	1	1	1900-01-01	string
731	381	numconta	Conta	left	left	70	-	0	1	0	-	0	5	1	1	1	1900-01-01	string
732	381	numcheque	nº Cheque	left	left	70	-	0	1	0	-	0	6	1	1	1	1900-01-01	string
177	166	nomePessoa	Pessoa	left	left	250	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
681	321	titulo	Convênio	left	left	200	-	0	1	0	-	0	3	1	1	1	1900-01-01	string
682	321	tipoconvenio	Tipo do convênio	left	left	110	TConvenios,setTipoConvenio	0	1	0	-	0	4	1	1	1	1900-01-01	string
683	321	tipotransacao	Tipo da transação	left	left	110	TConvenios,setTipoTransacao	0	1	0	-	0	5	1	1	1	1900-01-01	string
116	151	saldoInicial	Saldo Inícial	center	center	80	-	0	1	0	-	0	6	1	1	1	1900-01-01	numeric
178	166	dataAssinatura	Data da Assinatura	left	left	120	-	0	1	0	-	0	0	1	1	1	1900-01-01	date
179	166	dataTermino	Data do Termino	left	left	120	-	0	1	0	-	0	0	1	1	1	1900-01-01	date
243	179	dataCad	Data do Pedido	left	left	150	-	0	1	0	-	0	0	1	1	1	1900-01-01	date
245	179	tempoEntrega	Entrega (Dias)	left	left	120	-	0	1	0	-	0	0	1	1	1	1900-01-01	numeric
686	321	datavigencia	Data de vigência	center	center	120	-	0	1	0	-	0	8	1	1	1	1900-01-01	date
733	381	valor	Valor	right	right	70	TSetModel,setValorMonetario	0	1	0	-	0	7	1	1	1	1900-01-01	numeric
834	419	datainicio	Início	center	center	120	-	0	1	0	-	0	4	1	1	1	1900-01-01	date
835	419	datafim	Fim	center	center	120	-	0	1	0	-	0	5	1	1	1	1900-01-01	date
836	419	entrada_dinheiro	Rec. Dinheiro	center	center	120	TSetModel,setValorMonetario	0	1	0	-	0	6	1	1	1	1900-01-01	numeric
837	419	saida_dinheiro	Desp. Dinheiro	center	center	120	TSetModel,setValorMonetario	0	1	0	-	0	7	1	1	1	1900-01-01	numeric
838	419	entrada_cheque	Rec. Cheques	center	center	120	TSetModel,setValorMonetario	0	1	0	-	0	8	1	1	1	1900-01-01	numeric
839	419	saida_cheque	Desp. Cheques	center	center	120	TSetModel,setValorMonetario	0	1	0	-	0	9	1	1	1	1900-01-01	numeric
840	419	entrada_cartao	Rec. Cartão	center	center	120	TSetModel,setValorMonetario	0	1	0	-	0	10	1	1	1	1900-01-01	numeric
958	481	vencimento	Data Venc.	center	center	70	-	0	1	0	-	0	5	1	1	1	1900-01-01	date
959	481	valorpago	Valor Pago	right	right	80	TSetModel,setValorMonetario	0	1	0	-	0	4	1	1	1	1900-01-01	numeric
960	481	datacad	Data Pag	center	center	70	-	0	1	0	-	0	6	1	1	1	1900-01-01	date
687	321	concedente	Concedente	left	left	300	-	0	1	0	-	0	2	1	1	1	1900-01-01	string
696	323	titulo	Titulo	left	left	200	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
697	323	tipoconvenio	Convenio	left	left	110	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
698	323	tipotransacao	Transação	left	left	110	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
700	323	formato	Formato	left	left	100	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
702	323	nomeconveniado	Concedente	left	left	300	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
896	321	nomeplanoconta	Plano de Conta	left	left	200	-	0	1	0	-	0	6	1	1	1	1900-01-01	string
125	154	nome	Nome do Candidato	left	left	300	-	0	1	0	-	0	1	1	1	1	1900-01-01	string
210	154	email	E-mail	left	left	250	-	0	1	0	-	0	10	1	1	1	1900-01-01	string
307	154	sexo	Sexo	left	left	100	-	0	1	0	-	0	11	1	1	1	1900-01-01	string
308	154	cidade	cidade	left	left	200	-	0	1	0	-	0	12	1	1	1	1900-01-01	string
309	154	estado	Estado	left	left	50	-	0	1	0	-	0	13	1	1	1	1900-01-01	string
311	154	email	E-mail	left	left	200	-	0	1	0	-	0	15	1	1	1	1900-01-01	string
312	154	cnh	C.N.H.	left	left	50	-	0	1	0	-	0	16	1	1	1	1900-01-01	string
313	154	idiomas	Idiomas Falados	left	left	350	-	0	1	0	-	0	17	1	1	1	1900-01-01	string
314	154	areaInteresse	Area de Interesse	left	left	200	-	0	1	0	-	0	2	1	1	1	1900-01-01	string
315	154	areaInteresse2	Area de Interesse (2ª)	left	left	200	-	0	1	0	-	0	3	1	1	1	1900-01-01	string
316	154	areaInteresse3	Area de Interesse (3ª)	left	left	200	-	0	1	0	-	0	4	1	1	1	1900-01-01	string
318	154	cursos	Cursos Extra-Curriculares	left	left	350	-	0	1	0	-	0	6	1	1	1	1900-01-01	string
658	310	nome	Curso	left	left	300	-	0	1	0	-	0	2	1	1	1	1900-01-01	string
661	314	nome	Curso	left	left	300	-	0	1	0	-	0	2	1	1	1	1900-01-01	string
662	314	tipocurso	Tipo	left	left	100	-	0	1	0	-	0	3	1	1	1	1900-01-01	string
663	314	areacurso	Area	left	left	100	-	0	1	0	-	0	4	1	1	1	1900-01-01	string
229	176	titulo	Área de Curso	left	left	400	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
551	243	nomedisciplina	Disciplina	left	left	400	-	0	1	0	-	0	2	1	1	1	1900-01-01	string
576	134	nomedisciplina	Disciplina	left	left	400	-	0	1	0	-	0	2	1	1	1	1900-01-01	string
762	396	nomedisciplina	Disciplina	left	left	400	-	0	1	0	-	0	2	1	1	1	1900-01-01	string
938	477	nomedisciplina	Disciplina	left	left	400	-	0	1	0	-	0	2	1	1	1	1900-01-01	string
13	184	nome	Nome do curso	left	left	250	-	0	1	0	-	0	2	1	1	1	1900-01-01	string
265	184	titulo	Referência	left	left	150	-	0	1	0	-	0	3	1	1	1	1900-01-01	string
266	184	tipocurso	Tipo	left	left	150	-	0	1	0	-	0	4	1	1	1	1900-01-01	string
267	184	areacurso	Área	left	left	150	-	0	1	0	-	0	5	1	1	1	1900-01-01	string
571	259	nome	Curso	left	left	300	-	0	1	0	-	0	2	1	1	1	1900-01-01	string
572	259	titulo	Referencia	left	left	200	-	0	1	0	-	0	1	1	1	1	1900-01-01	string
763	396	cargahoraria	C.H.	center	center	30	-	0	1	0	-	0	3	1	1	1	1900-01-01	numeric
570	134	cargahoraria	C.H.	left	right	30	-	0	1	0	-	0	3	1	1	1	1900-01-01	numeric
560	243	cargahoraria	C.H.	left	right	30	-	0	1	0	-	0	3	1	1	1	1900-01-01	numeric
128	154	dataNasc	D. Nascimento	left	left	100	-	0	1	0	-	0	8	1	1	1	1900-01-01	date
165	162	preco	Preço	left	left	200	-	0	1	0	-	0	0	1	1	1	1900-01-01	numeric
166	162	entrega	Tempo de Entrega (Dias)	left	left	200	-	0	1	0	-	0	0	1	1	1	1900-01-01	numeric
174	164	preco	Preço	left	left	100	-	0	1	0	-	0	2	1	1	1	1900-01-01	numeric
310	154	telefone2	Celular	center	center	120	TSetModel,setTelefone	0	1	0	-	0	14	1	1	1	1900-01-01	numeric
248	180	preco	Preço	left	left	100	-	0	1	0	-	0	0	1	1	1	1900-01-01	numeric
249	180	entrega	Entrega (Dias)	left	left	120	-	0	1	0	-	0	0	1	1	1	1900-01-01	numeric
699	323	valor	Valor	right	right	60	TSetModel,setValorMonetario	0	1	0	-	0	0	1	1	1	1900-01-01	numeric
701	323	datavigencia	Vigência	center	center	120	-	0	1	0	-	0	0	1	1	1	1900-01-01	date
209	154	telefone1	Telefone	center	center	120	TSetModel,setTelefone	0	1	0	-	0	9	1	1	1	1900-01-01	numeric
527	240	titulo	Tipo do curso	left	left	250	-	0	1	0	-	0	1	1	1	1	1900-01-01	string
528	240	dataCad	Data do cadastro	center	center	120	-	0	1	0	-	0	2	1	1	1	1900-01-01	string
463	223	label	Departamento	left	left	300	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
464	223	nomeResponsavel	Responsável	left	left	200	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
465	223	nomeSala	Lotação	left	left	100	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
6	131	titulo	Disciplina	left	left	400	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
272	187	titulo	Disciplina	left	left	300	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
760	394	titulo	Disciplina	left	left	300	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
278	190	totalLiquido	Valor	right	right	90	setMoeda,setValor	0	1	0	-	0	2	1	1	1	1900-01-01	string
280	190	referencia	referencia	left	center	100	-	0	1	0	-	0	3	1	1	1	1900-01-01	string
293	192	titulo	Ocorrência	left	left	300	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
29	137	nomeprofessor	Professor	left	left	300	-	0	1	0	-	0	1	1	1	1	1900-01-01	string
457	221	nomeprofessor	Nome	left	left	300	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
134	155	label	Patrimonio	left	left	200	-	0	1	0	-	0	2	1	1	1	1900-01-01	string
142	155	tipo	Tipo do Patrimonio	left	left	200	-	0	1	0	-	0	3	1	1	1	1900-01-01	string
143	155	nomesala	Lotação	left	left	200	-	0	1	0	-	0	4	1	1	1	1900-01-01	string
197	155	nomeunidade	Filial	left	left	200	-	0	1	0	-	0	5	1	1	1	1900-01-01	string
515	274	titulo	Titulo	left	left	300	-	0	1	0	-	0	2	1	1	1	1900-01-01	string
516	274	editora	Editora	left	left	100	-	0	1	0	-	0	3	1	1	1	1900-01-01	string
517	274	edicao	Edição	left	left	80	-	0	1	0	-	0	6	1	1	1	1900-01-01	string
605	274	autor	Autor	left	left	200	-	0	1	0	-	0	3	1	1	1	1900-01-01	string
607	274	idioma	Idioma	left	left	100	-	0	1	0	-	0	7	1	1	1	1900-01-01	string
609	274	cdu	CDU	left	left	60	-	0	1	0	-	0	9	1	1	1	1900-01-01	string
610	274	titulocdu	Classificação CDU	left	left	150	-	0	1	0	-	0	10	1	1	1	1900-01-01	string
612	274	isbn	ISBN	left	left	60	-	0	1	0	-	0	12	1	1	1	1900-01-01	string
614	274	nomelocador	Emprestimo	left	left	150	-	0	1	0	-	0	0	0	1	1	1900-01-01	string
617	237	titulo	Titulo	left	left	300	-	0	1	0	-	0	2	1	1	1	1900-01-01	string
619	237	editora	Editora	left	left	100	-	0	1	0	-	0	3	1	1	1	1900-01-01	string
624	277	titulo	Titulo	left	left	300	-	0	1	0	-	0	2	1	1	1	1900-01-01	string
625	277	isbn	ISBN	left	left	60	-	0	1	0	-	0	12	1	1	1	1900-01-01	string
627	277	titulocdu	Classificação CDU	left	left	150	-	0	1	0	-	0	10	1	1	1	1900-01-01	string
636	278	editora	Editora	left	left	100	-	0	1	0	-	0	2	1	1	1	1900-01-01	string
761	394	cargahoraria	Carga Horária	left	left	120	-	0	1	0	-	0	0	1	1	1	1900-01-01	numeric
659	310	cargahoraria	Carga Horária	center	center	100	-	0	1	0	-	0	3	1	1	1	1900-01-01	numeric
273	187	cargahoraria	Carga Horaria	left	left	120	-	0	1	0	-	0	0	1	1	1	1900-01-01	numeric
186	171	dataFeriasReal	Data Real	left	left	200	-	0	1	0	-	0	0	1	1	1	1900-01-01	date
226	171	dataLimite	Data Limite	left	left	100	-	0	1	0	-	0	0	1	1	1	1900-01-01	date
277	190	funcseq	Funcionario	left	left	300	-	0	1	0	-	0	1	1	1	1	1900-01-01	numeric
279	190	vencimento	Vencimento	center	center	90	-	0	1	0	-	0	4	1	1	1	1900-01-01	date
294	192	dataCad	Data	left	left	100	-	0	1	0	-	0	0	1	1	1	1900-01-01	date
454	137	nomeacao	Titularidade	left	left	250	-	0	1	0	-	0	2	1	1	1	1900-01-01	string
606	274	ano	Ano	left	left	50	-	0	1	0	-	0	5	1	1	1	1900-01-01	numeric
608	274	paginas	Páginas	left	left	50	-	0	1	0	-	0	8	1	1	1	1900-01-01	numeric
615	274	locacoes	Locações	left	left	50	-	0	1	0	-	0	13	1	1	1	1900-01-01	numeric
616	274	reservas	Reservas	left	left	50	-	0	1	0	-	0	14	1	1	1	1900-01-01	numeric
458	221	nomeacao	Titularidade	left	left	200	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
529	137	telefone1	Telefone	left	left	200	TSetModel,setTelefone	0	1	0	-	0	3	1	1	1	1900-01-01	numeric
639	278	edicao	Edição	left	left	30	-	0	1	0	-	0	5	1	1	1	1900-01-01	string
640	278	idioma	Idioma	left	left	100	-	0	1	0	-	0	6	1	1	1	1900-01-01	string
642	278	cdu	CDU	left	left	60	-	0	1	0	-	0	8	1	1	1	1900-01-01	string
643	278	titulocdu	Classificação CDU	left	left	150	-	0	1	0	-	0	9	1	1	1	1900-01-01	string
645	278	isbn	ISBN	left	left	60	-	0	1	0	-	0	11	1	1	1	1900-01-01	string
664	237	autor	Autor	left	left	200	-	0	1	0	-	0	3	1	1	1	1900-01-01	string
665	237	ano	Ano	left	left	30	-	0	1	0	-	0	4	1	1	1	1900-01-01	string
666	237	edicao	Edição	left	left	30	-	0	1	0	-	0	5	1	1	1	1900-01-01	string
667	237	idioma	Idioma	left	left	100	-	0	1	0	-	0	6	1	1	1	1900-01-01	string
669	237	cdu	CDU	left	left	60	-	0	1	0	-	0	8	1	1	1	1900-01-01	string
671	237	isbn	ISBN	left	left	60	-	0	1	0	-	0	11	1	1	1	1900-01-01	string
672	319	titulo	Titulo	left	left	300	-	0	1	0	-	0	1	1	1	1	1900-01-01	string
673	319	editora	Editora	left	left	100	-	0	1	0	-	0	2	1	1	1	1900-01-01	string
674	319	autor	Autor	left	left	200	-	0	1	0	-	0	3	1	1	1	1900-01-01	string
675	319	edicao	Edição	left	left	30	-	0	1	0	-	0	4	1	1	1	1900-01-01	string
676	319	cdu	CDU	left	left	40	-	0	1	0	-	0	5	1	1	1	1900-01-01	string
678	319	isbn	ISBN	left	left	40	-	0	1	0	-	0	7	1	1	1	1900-01-01	string
709	331	titulo	Titulo	left	left	300	-	0	1	0	-	0	1	1	1	1	1900-01-01	string
710	331	isbn	ISBN	left	left	60	-	0	1	0	-	0	8	1	1	1	1900-01-01	string
712	331	titulocdu	Classificação CDU	left	left	150	-	0	1	0	-	0	10	1	1	1	1900-01-01	string
713	331	cdu	CDU	left	left	60	-	0	1	0	-	0	11	1	1	1	1900-01-01	string
716	331	idioma	Idioma	left	left	50	-	0	1	0	-	0	4	1	1	1	1900-01-01	string
717	331	autor	Autor	left	left	100	-	0	1	0	-	0	5	1	1	1	1900-01-01	string
718	331	edicao	Edição	left	left	80	-	0	1	0	-	0	6	1	1	1	1900-01-01	string
719	331	editora	Editora	left	left	100	-	0	1	0	-	0	7	1	1	1	1900-01-01	string
1	130	pessnmrz	Nome	left	left	300	-	0	1	0	-	0	1	1	1	1	1900-01-01	string
73	143	pessnmrz	Nome	left	left	300	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
453	219	funcionario	Func.	left	left	50	TStatus,getBoolean	0	1	0	-	0	0	1	1	1	1900-01-01	string
104	148	nomeTurma	Turma	left	left	180	-	0	1	0	-	0	4	1	1	1	1900-01-01	string
228	148	nomeUnidade	Unidade	left	left	200	-	0	1	0	-	0	8	1	1	1	1900-01-01	string
281	148	nomePessoa	Aluno	left	left	250	-	0	1	0	-	0	2	1	1	1	1900-01-01	string
354	148	nomeCurso	Curso	left	left	350	-	0	1	0	-	0	3	1	1	1	1900-01-01	string
855	423	nometurma	Turma	left	left	180	-	0	1	0	-	0	4	1	1	1	1900-01-01	string
856	423	nomeunidade	Unidade	left	left	200	-	0	1	0	-	0	8	1	1	1	1900-01-01	string
857	423	nomepessoa	Aluno	left	left	250	-	0	1	0	-	0	2	1	1	1	1900-01-01	string
858	423	nomecurso	Curso	left	left	350	-	0	1	0	-	0	3	1	1	1	1900-01-01	string
905	457	nomeTurma	Turma	left	left	180	-	0	1	0	-	0	4	1	1	1	1900-01-01	string
906	458	nomeTurma	Turma	left	left	180	-	0	1	0	-	0	4	1	1	1	1900-01-01	string
907	457	nomeUnidade	Unidade	left	left	200	-	0	1	0	-	0	8	1	1	1	1900-01-01	string
908	458	nomeUnidade	Unidade	left	left	200	-	0	1	0	-	0	8	1	1	1	1900-01-01	string
909	457	nomePessoa	Aluno	left	left	250	-	0	1	0	-	0	2	1	1	1	1900-01-01	string
910	458	nomePessoa	Aluno	left	left	250	-	0	1	0	-	0	2	1	1	1	1900-01-01	string
911	457	nomeCurso	Curso	left	left	350	-	0	1	0	-	0	3	1	1	1	1900-01-01	string
912	458	nomeCurso	Curso	left	left	350	-	0	1	0	-	0	3	1	1	1	1900-01-01	string
689	322	titulo	Convênio	left	left	300	-	0	1	0	-	0	2	1	1	1	1900-01-01	string
641	278	paginas	Paginas	left	left	50	-	0	1	0	-	0	7	1	1	1	1900-01-01	numeric
668	237	paginas	Páginas	left	left	50	-	0	1	0	-	0	7	1	1	1	1900-01-01	numeric
714	331	paginas	Páginas	left	left	50	-	0	1	0	-	0	2	1	1	1	1900-01-01	numeric
715	331	ano	Ano	left	left	50	-	0	1	0	-	0	3	1	1	1	1900-01-01	numeric
690	322	tipoconvenio	Tipo do convênio	left	left	110	TConvenios,setTipoConvenio	0	1	0	-	0	4	1	1	1	1900-01-01	string
691	322	tipotransacao	Tipo da transação	left	left	110	TConvenios,setTipoTransacao	0	1	0	-	0	5	1	1	1	1900-01-01	string
74	143	pessnmrf	CPF	center	center	100	TSetModel,setCpfcnpj	0	1	0	-	0	0	1	1	1	1900-01-01	numeric
693	322	formato	Formato	left	left	100	TConvenios,setFormato	0	1	0	-	0	7	1	1	1	1900-01-01	string
262	183	nomecurso	Curso	left	left	300	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
263	183	turno	Turno	left	left	200	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
268	185	nomePessoa	Cliente	left	left	300	-	0	1	0	-	0	1	1	1	1	1900-01-01	string
269	185	nomeCurso	Curso	left	left	300	-	0	1	0	-	0	2	1	1	1	1900-01-01	string
270	185	turno	Turno	left	left	120	-	0	1	0	-	0	3	1	1	1	1900-01-01	string
799	185	datacad	Inclusão	center	center	100	-	0	1	0	-	0	7	1	1	1	1900-01-01	string
207	173	instituicao	Instituição	left	left	240	-	0	1	0	-	0	3	1	1	1	1900-01-01	string
212	173	titularidade	Titularidade	left	left	200	-	0	1	0	-	0	1	0	1	1	1900-01-01	string
484	229	curso	Curso	left	left	300	-	0	1	0	-	0	1	1	1	1	1900-01-01	string
485	229	instituicao	Instituição	left	left	200	-	0	1	0	-	0	3	1	1	1	1900-01-01	string
486	230	curso	Curso	left	left	300	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
487	230	instituicao	Instituição	left	left	100	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
489	173	titularidade	Titularidade	left	left	200	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
490	229	titularidade	Titularidade	left	left	200	-	0	1	0	-	0	2	1	1	1	1900-01-01	string
491	230	titularidade	Titularidade	left	left	200	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
24	136	nomefuncionario	Nome	left	left	300	-	0	1	0	-	0	1	1	1	1	1900-01-01	string
26	136	nomeDepartamento	Departamento	left	left	100	-	0	1	0	-	0	3	1	1	1	1900-01-01	string
466	224	pessnmrz	Funcionário	left	left	400	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
483	224	nomeDepartamento	Departamento	left	left	100	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
494	231	pessnmrz	Nome	left	left	300	-	0	1	0	-	0	1	1	1	1	1900-01-01	string
496	231	nomeDepartamento	Departamento	left	left	100	-	0	1	0	-	0	3	1	1	1	1900-01-01	string
498	231	nomeCargo	Cargo	left	left	200	-	0	1	0	-	0	4	1	1	1	1900-01-01	string
31	138	nomepessoa	Cliente	left	left	250	-	0	1	0	-	0	1	1	1	1	1900-01-01	string
32	138	nomecurso	Curso	left	left	200	-	0	1	0	-	0	3	1	1	1	1900-01-01	string
96	147	nomePessoa	Nome	left	left	250	-	0	1	0	-	0	1	1	1	1	1900-01-01	string
98	147	nomeTurma	Turma	left	left	200	-	0	1	0	-	0	2	1	1	1	1900-01-01	string
99	147	nomeCurso	Curso	left	left	250	-	0	1	0	-	0	3	1	1	1	1900-01-01	string
232	177	nome	Nome	left	left	200	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
236	177	emails	E-mail	left	left	200	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
33	138	datacad	Data do Cadastro	left	center	110	-	0	1	0	-	0	15	1	1	1	1900-01-01	date
100	147	dataCad	Data da inscrição	left	left	120	-	0	1	0	-	0	4	1	1	1	1900-01-01	date
235	177	telefone2	Celular	center	center	120	TSetModel,setTelefone	0	1	0	-	0	0	1	1	1	1900-01-01	numeric
208	173	anoConclusao	Ano de Conclusão	left	left	120	-	0	1	0	-	0	4	1	1	1	1900-01-01	numeric
233	177	cpf	CPF	left	left	100	-	0	1	0	-	0	0	1	1	1	1900-01-01	numeric
189	172	telefone2	Telefone Secundário	left	left	120	TSetModel,setTelefone	0	1	0	-	0	3	1	1	1	1900-01-01	string
264	183	datacad	Data da Inclusão	left	left	120	-	0	1	0	-	0	0	1	1	1	1900-01-01	date
497	231	dataAdmissao	Admissão	left	left	100	-	0	1	0	-	0	5	1	1	1	1900-01-01	date
692	322	valor	Valor	right	right	60	TSetModel,setValorMonetario	0	1	0	-	0	6	1	1	1	1900-01-01	numeric
694	322	datavigencia	Data do convênio	center	center	120	-	0	1	0	-	0	8	1	1	1	1900-01-01	date
101	147	telefone1	Telefone	center	center	120	TSetModel,setTelefone	0	1	0	-	0	5	0	1	1	1900-01-01	numeric
188	172	pessnmrz	Nome	left	left	400	-	0	1	0	-	0	1	1	1	1	1900-01-01	string
102	147	email_principal	E-mail	left	left	200	-	0	1	0	-	0	6	0	1	1	1900-01-01	string
237	177	produto	Produto	left	left	250	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
260	138	nometurma	Turma	left	left	200	-	0	1	0	-	0	2	1	1	1	1900-01-01	string
25	136	pessnmrf	CPF	left	left	120	TSetModel,setCpfcnpj	0	1	0	-	0	2	1	1	1	1900-01-01	numeric
582	265	titulolivro	Titulo	left	left	300	-	0	1	0	-	0	2	1	1	1	1900-01-01	string
583	265	autorlivro	Autor	left	left	150	-	0	1	0	-	0	3	1	1	1	1900-01-01	string
590	268	titulolivro	Titulo	left	left	300	-	0	1	0	-	0	2	1	1	1	1900-01-01	string
591	268	autorlivro	Autor	left	left	150	-	0	1	0	-	0	3	1	1	1	1900-01-01	string
621	265	nomepessoa	Locador	left	left	300	-	0	1	0	-	0	4	1	1	1	1900-01-01	string
622	268	nomepessoa	Reservado por	left	left	200	-	0	1	0	-	0	4	1	1	1	1900-01-01	string
623	269	nomepessoa	Locador	left	left	200	-	0	1	0	-	0	4	1	1	1	1900-01-01	string
45	140	nomeConta	Conta	left	left	300	-	0	1	0	-	0	2	1	1	1	1900-01-01	string
46	140	tipoCusto	Tipo de custo	left	left	120	-	0	1	0	-	0	3	1	1	1	1900-01-01	string
47	140	tipoConta	Tipo da conta	center	center	100	-	0	1	0	-	0	4	1	1	1	1900-01-01	string
393	208	tabela	Tipo	left	left	200	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
445	218	label	Produto	left	left	300	-	0	1	0	-	0	1	1	1	1	1900-01-01	string
772	218	descricao	Descrição	left	left	300	-	0	1	0	-	0	3	1	1	1	1900-01-01	string
774	218	tipoproduto	Tipo	left	left	100	-	0	1	0	-	0	4	1	1	1	1900-01-01	string
775	208	tipoproduto	Tipo	left	left	100	-	0	1	0	-	0	4	1	1	1	1900-01-01	string
162	161	nome	Nome do Produto	left	left	250	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
163	161	marca	Marca	left	left	250	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
250	181	nome	Produto	left	left	400	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
499	232	nomeareacurso	Área	left	left	400	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
324	195	titulo	Titulo	left	left	300	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
325	195	responsavelNome	Responsável	left	left	300	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
329	197	colaborador	Nome	left	left	300	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
330	197	funcao	Função	left	left	200	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
331	198	item	Item	left	left	300	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
327	196	recurso	Recurso	left	left	300	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
553	244	titulo	Titulo	left	left	250	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
557	245	enunciado	Enunciado	left	left	200	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
559	245	tipoQuestao	Tipo	left	left	100	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
869	427	nomepessoa	Nome	left	left	200	-	0	1	0	-	0	1	1	1	1	1900-01-01	string
870	427	interessado	Interessado	left	left	180	-	0	1	0	-	0	2	1	1	1	1900-01-01	string
871	427	referencia	Referência	left	left	130	-	0	1	0	-	0	3	1	1	1	1900-01-01	string
328	196	quantidade	Qtde.	left	left	60	-	0	1	0	-	0	0	1	1	1	1900-01-01	date
332	198	valor	Valor	right	right	60	TSetModel,setValorMonetario	0	1	0	-	0	0	1	1	1	1900-01-01	numeric
382	208	valor	Valor	right	right	100	TSetModel,setValorMonetario	0	1	0	-	0	2	1	1	1	1900-01-01	numeric
419	208	valorAlteravel	V.A.	left	left	10	TSetModel,setValorMonetario	0	1	0	-	0	3	1	1	1	1900-01-01	numeric
446	218	valor	Valor	right	right	100	TSetModel,setValorMonetario	0	1	0	-	0	2	0	1	1	1900-01-01	numeric
554	244	dataInicio	Data de Início	left	left	100	-	0	1	0	-	0	0	1	1	1	1900-01-01	date
555	244	dataFim	Data de Término	left	left	110	-	0	1	0	-	0	0	1	1	1	1900-01-01	date
556	244	numQuestoesMax	Nº de Questões	left	left	100	-	0	1	0	-	0	0	1	1	1	1900-01-01	numeric
558	245	valorQuestao	Valor	right	right	100	TSetModel,setValorMonetario	0	1	0	-	0	0	1	1	1	1900-01-01	numeric
592	268	previsaosaida	Disponibilidade	left	left	100	-	0	1	0	-	0	5	1	1	1	1900-01-01	date
593	268	previsaoentrada	Devolução	left	left	100	-	0	1	0	-	0	6	1	1	1	1900-01-01	date
584	265	confirmacaosaida	Data de Saida	left	left	100	-	0	1	0	-	0	5	1	1	1	1900-01-01	date
585	265	previsaoentrada	Devolução	left	left	100	-	0	1	0	-	0	6	1	1	1	1900-01-01	date
874	427	email	E-mail	left	left	140	-	0	1	0	-	0	6	1	1	1	1900-01-01	string
875	427	obs	Anotação	left	left	400	-	0	1	0	-	0	7	1	1	1	1900-01-01	string
877	427	situacao	Situação	center	center	80	-	0	1	0	-	0	8	1	1	1	1900-01-01	string
219	174	nomefuncionario	Responsável	left	left	250	-	0	1	0	-	0	5	1	1	1	1900-01-01	string
221	175	nome	Sala	left	left	150	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
222	175	endereco	Endereço	left	left	340	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
223	175	unidade	Unidade	left	left	180	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
519	238	titulo	Relatório	left	left	300	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
521	239	tabela	Módulo	left	left	200	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
522	239	colunaX	Informação X	left	left	200	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
523	239	agrupamentoX	Forma de Agrupamento X	left	left	200	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
525	239	colunaY	Informação Y	left	left	200	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
526	239	agrupamentoY	Forma de Agrupamento Y	left	left	200	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
167	163	cliente	Cliente	left	left	250	-	0	1	0	-	0	2	1	1	1	1900-01-01	string
168	163	planoConta	Plano de contas	left	left	200	-	0	1	0	-	0	3	1	1	1	1900-01-01	string
169	163	valortotal	Valor Total	right	right	100	TSetModel,setValorMonetario	0	1	0	-	0	5	1	1	1	1900-01-01	string
374	206	cliente	Pessoa	left	left	300	-	0	1	0	-	0	2	1	1	1	1900-01-01	string
376	206	planoConta	Plano de Conta	left	left	200	-	0	1	0	-	0	3	1	1	1	1900-01-01	string
415	213	cliente	Fornecedor	left	left	300	-	0	1	0	-	0	1	1	1	1	1900-01-01	string
417	213	planoconta	Plano de Conta	left	left	200	-	0	1	0	-	0	3	1	1	1	1900-01-01	string
50	141	nomePessoa	Pessoa	left	left	200	-	0	1	0	-	0	1	1	1	1	1900-01-01	string
57	142	nomepessoa	Pessoa	left	left	300	-	0	1	0	-	0	2	1	1	1	1900-01-01	string
512	210	numParcela	N. Parcela	right	right	80	-	0	1	0	-	0	3	1	1	1	1900-01-01	string
403	145	vencimento	Vencimento	center	center	80	-	0	1	0	-	0	6	1	1	1	1900-01-01	date
878	427	datacad	Data	center	center	80	-	0	1	0	-	0	9	1	1	1	1900-01-01	date
398	236	numParcela	Parcela	left	left	100	-	0	1	0	-	0	0	1	1	1	1900-01-01	numeric
401	145	numero	Parcela	left	left	60	-	0	1	0	-	0	3	1	1	1	1900-01-01	numeric
70	142	vencimento	Vencimento	center	center	80	-	0	1	0	-	0	4	1	1	1	1900-01-01	date
544	206	numParcelas	Parcelas	left	left	100	-	0	1	0	-	0	5	1	1	1	1900-01-01	numeric
52	141	vencimento	Vencimento	center	center	90	-	0	1	0	-	0	3	1	1	1	1900-01-01	date
51	141	valorinicial	Valor Inicial	right	right	100	TSetModel,setValorMonetario	0	1	0	-	0	2	1	1	1	1900-01-01	numeric
55	142	numparcela	Parcela	left	left	50	-	0	1	0	-	0	5	1	1	1	1900-01-01	numeric
59	142	valorinicial	Valor Inicial	right	right	100	TSetModel,setValorMonetario	0	1	0	-	0	3	1	1	1	1900-01-01	numeric
171	163	numparcelasabertas	Parc. Disp.	right	right	70	-	0	1	0	-	0	4	1	1	1	1900-01-01	numeric
172	163	dataCad	Data	center	center	90	-	0	1	0	-	0	7	1	1	1	1900-01-01	date
377	206	valorTotal	Valor	right	right	100	TSetModel,setValorMonetario	0	1	0	-	0	4	1	1	1	1900-01-01	numeric
395	236	vencimento	Vencimento	center	center	100	-	0	1	0	-	0	0	1	1	1	1900-01-01	date
397	236	valorinicial	Valor Inicial	right	right	100	TSetModel,setValorMonetario	0	1	0	-	0	0	1	1	1	1900-01-01	numeric
399	145	valorinicial	Valor Inicial	right	right	100	TSetModel,setValorMonetario	0	1	0	-	0	4	1	1	1	1900-01-01	numeric
418	213	valortotal	Valor Total	right	right	100	TSetModel,setValorMonetario	0	1	0	-	0	4	1	1	1	1900-01-01	numeric
511	210	valorinicial	Valor Inicial	right	right	100	TSetModel,setValorMonetario	0	1	0	-	0	2	1	1	1	1900-01-01	numeric
422	215	vencimento	Vencimento	center	center	100	-	0	1	0	-	0	2	1	1	1	1900-01-01	date
545	206	numparcelasabertas	Parc. Abertas	left	left	130	-	0	1	0	-	0	6	1	1	1	1900-01-01	numeric
720	213	numparcelas	N° de Parcelas	left	left	100	-	0	1	0	1	0	5	1	1	1	1900-01-01	numeric
773	163	valor	Valor em Aberto	right	right	100	TSetModel,setValorMonetario	0	1	0	-	0	6	1	1	1	1900-01-01	numeric
543	236	statusConta	Situação	left	left	100	TSetModel,setStatusConta	0	1	0	-	0	0	1	1	1	1900-01-01	string
950	479	nomepessoa	Clientes	left	left	300	-	0	1	0	-	0	2	1	1	1	1900-01-01	string
966	485	nomepessoa	Pessoa	left	left	300	-	0	1	0	-	0	2	1	1	1	1900-01-01	string
980	488	nomepessoa	Pessoa	left	left	300	-	0	1	0	-	0	2	1	1	1	1900-01-01	string
38	139	fonte	Fonte	left	left	120	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
41	139	tipo	Tipo de conta	center	center	130	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
42	139	statusDuplicata	Situação	center	center	80	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
899	451	nomeconvenio	Convênio	left	left	300	-	0	1	0	-	0	1	1	1	1	1900-01-01	string
379	207	label	Produto	left	left	200	-	0	1	0	-	0	1	1	1	1	1900-01-01	string
420	214	label	Produto	left	left	300	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
771	214	descricao	Descrição	left	left	300	-	0	1	0	-	0	3	1	1	1	1900-01-01	string
136	156	nomeCurso	Curso	left	left	300	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
138	156	ministrante	Ministrante	left	left	180	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
139	156	instituicaoCertificadora	Intituição Ministradora	left	left	300	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
488	156	escolaridade	Titularidade	left	left	200	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
11	133	titulo	Nome da Turma	left	left	120	-	0	1	0	-	0	2	1	1	1	1900-01-01	string
12	133	nomecurso	Curso	left	left	230	-	0	1	0	-	0	3	1	1	1	1900-01-01	string
106	149	nomecurso	Curso	left	left	250	-	0	1	0	-	0	1	1	1	1	1900-01-01	string
107	149	titulo	Turma	left	left	200	-	0	1	0	-	0	2	1	1	1	1900-01-01	string
981	488	valorinicial	Valor Inicial	right	right	100	TSetModel,setValorMonetario	0	1	0	-	0	3	1	1	1	1900-01-01	numeric
967	485	valorinicial	Valor Inicial	right	right	100	TSetModel,setValorMonetario	0	1	0	-	0	3	1	1	1	1900-01-01	numeric
947	479	valoratual	Valor Atual	right	right	100	TSetModel,setValorMonetario	0	1	0	-	0	6	1	1	1	1900-01-01	numeric
982	488	vencimento	Vencimento	center	center	80	-	0	1	0	-	0	4	1	1	1	1900-01-01	date
948	479	vencimento	Vencimento	center	center	80	-	0	1	0	-	0	7	1	1	1	1900-01-01	date
421	214	valortotal	Valor	right	right	100	TSetModel,setValorMonetario	0	1	0	-	0	0	1	1	1	1900-01-01	numeric
40	139	vencimento	Vencimento	center	center	100	-	0	1	0	-	0	0	1	1	1	1900-01-01	date
969	485	vencimento	Vencimento	center	center	80	-	0	1	0	-	0	4	1	1	1	1900-01-01	date
14	133	valormensal	Parcela	center	center	70	TSetModel,setValorMonetario	0	1	0	-	0	7	1	1	1	1900-01-01	numeric
946	479	numero	Parcela	left	left	60	-	0	1	0	-	0	4	1	1	1	1900-01-01	numeric
37	139	numDoc	Documento	left	left	120	-	0	1	0	-	0	0	1	1	1	1900-01-01	numeric
39	139	valorinicial	Valor Nominal	right	right	100	TSetModel,setValorMonetario	0	1	0	-	0	0	1	1	1	1900-01-01	numeric
60	133	numparcelas	N. Parcelas	center	center	70	-	0	1	0	-	0	8	1	1	1	1900-01-01	numeric
61	133	datainicio	Data de início	center	center	100	-	0	1	0	-	0	9	1	1	1	1900-01-01	date
380	207	valorinicial	Valor	right	right	100	TSetModel,setValorMonetario	0	1	0	-	0	3	1	1	1	1900-01-01	numeric
323	156	dataCad	Data de Cadastro	left	left	110	-	0	1	0	-	0	0	1	1	1	1900-01-01	date
513	210	vencimento	Vencimento	center	center	80	-	0	1	0	-	0	4	1	1	1	1900-01-01	date
945	479	valorinicial	Valor Inicial	right	right	100	TSetModel,setValorMonetario	0	1	0	-	0	5	1	1	1	1900-01-01	numeric
965	485	numero	Parcela	left	left	50	-	0	1	0	-	0	5	1	1	1	1900-01-01	numeric
979	488	numero	Parcela	left	left	50	-	0	1	0	-	0	5	1	1	1	1900-01-01	numeric
726	215	stpadesc	Status da conta	center	center	150	TSetModel,setStatusConta	0	1	0	-	0	4	1	1	1	1900-01-01	string
723	142	stpadesc	Status	left	center	50	-	0	1	0	1	0	6	1	1	1	1900-01-01	string
983	488	stpadesc	Status	left	center	50	-	0	1	0	1	0	6	1	1	1	1900-01-01	string
970	485	stpadesc	Status	left	center	50	-	0	1	0	1	0	6	1	1	1	1900-01-01	string
724	145	stpadesc	Situação	left	left	100	-	0	1	0	-	0	7	1	1	1	1900-01-01	string
951	479	stpadesc	Status	left	left	100	TSetModel,setStatusConta	0	1	0	-	0	8	1	1	1	1900-01-01	string
202	170	titulo	Turma	left	left	350	-	0	1	0	-	0	1	1	1	1	1900-01-01	string
203	170	nomecurso	Curso	left	left	240	-	0	1	0	-	0	2	1	1	1	1900-01-01	string
214	133	nomeunidade	Unidade	left	left	100	-	0	1	0	-	0	10	1	1	1	1900-01-01	string
251	182	titulo	Turma	left	left	180	-	0	1	0	-	0	1	1	1	1	1900-01-01	string
252	182	nomecurso	Curso	left	left	270	-	0	1	0	-	0	2	1	1	1	1900-01-01	string
364	133	status	Status	center	center	60	TTurma,getStatus	0	1	0	-	0	13	1	1	1	1900-01-01	string
388	209	titulo	Nome da Turma	left	left	200	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
389	209	nomecurso	Curso	left	left	250	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
391	209	unidade	Unidade	left	left	140	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
392	209	status	Status	left	left	80	TTurma,getStatus	0	1	0	-	0	0	1	1	1	1900-01-01	string
479	228	titulo	Turma	left	left	300	-	0	1	0	-	0	1	1	1	1	1900-01-01	string
480	228	nomecurso	Curso	left	left	300	-	0	1	0	-	0	2	1	1	1	1900-01-01	string
501	234	titulo	nome da Turma	left	left	200	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
502	234	nomecurso	Curso	left	left	250	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
504	234	unidade	Unidade	left	left	140	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
505	234	status	Status	left	left	80	TTurma,getStatus	0	1	0	-	0	0	1	1	1	1900-01-01	string
301	193	alunos	Nº de Alunos	left	left	80	-	0	1	0	-	0	7	1	1	1	1900-01-01	string
333	135	datas	Datas	left	left	300	-	0	1	0	-	0	5	1	1	1	1900-01-01	string
340	199	nomeTurma	Turma	left	left	180	-	0	1	0	-	0	3	1	1	1	1900-01-01	string
341	199	nomedisciplina	Disciplina	left	left	200	-	0	1	0	-	0	2	1	1	1	1900-01-01	string
342	199	nomeprofessor	Professor	left	left	200	-	0	1	0	-	0	5	1	1	1	1900-01-01	string
346	200	nometurma	Turma	left	left	180	-	0	1	0	-	0	3	1	1	1	1900-01-01	string
347	200	nomedisciplina	Disciplina	left	left	200	-	0	1	0	-	0	4	1	1	1	1900-01-01	string
348	200	nomeprofessor	Professor	left	left	200	-	0	1	0	-	0	5	1	1	1	1900-01-01	string
360	193	nomecurso	Curso	Left	Left	300	-	0	1	0	-	0	5	1	1	1	1900-01-01	string
361	199	nomecurso	Curso	left	left	300	-	0	1	0	-	0	4	1	1	1	1900-01-01	string
108	149	dataInicio	data de Início	center	center	90	-	0	1	0	-	0	4	1	1	1	1900-01-01	date
230	133	valortaxa	Taxa	center	center	70	TSetModel,setValorMonetario	0	1	0	-	0	5	1	1	1	1900-01-01	numeric
231	133	valormatricula	Matricula	center	center	70	TSetModel,setValorMonetario	0	1	0	-	0	6	0	1	1	1900-01-01	numeric
253	182	dataInicio	Data de Início	left	left	100	-	0	1	0	-	0	9	1	1	1	1900-01-01	date
255	182	valordescontado	Descontado	left	left	70	TSetModel,setValorMonetario	0	1	0	-	0	8	1	1	1	1900-01-01	numeric
256	182	valortaxa	Taxa	left	left	60	TSetModel,setValorMonetario	0	1	0	-	0	4	1	1	1	1900-01-01	numeric
257	182	valormatricula	Matrícula	left	left	60	TSetModel,setValorMonetario	0	1	0	-	0	5	1	1	1	1900-01-01	numeric
258	182	valormensal	Valor Parcela	right	right	90	TSetModel,setValorMonetario	0	1	0	-	0	7	1	1	1	1900-01-01	numeric
259	182	numparcelas	Parcelas	left	left	50	-	0	1	0	-	0	6	1	1	1	1900-01-01	numeric
302	193	dataAtualizacao	Ultima Atualização	left	left	120	-	0	1	0	-	0	8	1	1	1	1900-01-01	date
343	199	alunos	Nº de Alunos 	left	left	80	-	0	1	0	-	0	6	1	1	1	1900-01-01	numeric
349	200	alunos	Nº de Alunos	left	left	80	-	0	1	0	-	0	6	1	1	1	1900-01-01	numeric
350	200	frequencia	Frequência	left	left	80	-	0	1	0	-	0	7	1	1	1	1900-01-01	numeric
390	209	datainicio	Data de Inicio	left	left	100	-	0	1	0	-	0	0	1	1	1	1900-01-01	date
344	199	dataAtualizacao	Ultima Atualização	left	left	120	-	0	1	0	-	0	7	1	1	1	1900-01-01	date
503	234	datainicio	Data de Inicio	left	left	100	-	0	1	0	-	0	0	1	1	1	1900-01-01	date
533	228	valorMatricula	Matricula	left	left	60	TSetModel,setValorMonetario	0	1	0	-	0	5	1	1	1	1900-01-01	numeric
534	228	valorMensal	Mensalidade	left	left	60	TSetModel,setValorMonetario	0	1	0	-	0	6	1	1	1	1900-01-01	numeric
535	228	numParcelas	Nº de Parcelas	left	left	100	-	0	1	0	-	0	7	1	1	1	1900-01-01	numeric
362	200	nomecurso	Curso	left	left	250	-	0	1	0	-	0	2	1	1	1	1900-01-01	string
432	217	nomecurso	curso	left	left	250	-	0	1	0	-	0	5	1	1	1	1900-01-01	string
433	217	nometurma	Turma	left	left	200	-	0	1	0	-	0	3	1	1	1	1900-01-01	string
434	217	nomedisciplina	Disciplina	left	left	200	-	0	1	0	-	0	2	1	1	1	1900-01-01	string
435	217	nomeprofessor	Professor	left	left	200	-	0	1	0	-	0	4	1	1	1	1900-01-01	string
472	226	nomedisciplina	Disciplina	left	left	200	-	0	1	0	-	0	3	1	1	1	1900-01-01	string
473	226	nometurma	Turma	left	left	200	-	0	1	0	-	0	4	1	1	1	1900-01-01	string
474	226	nomecurso	Curso	left	left	200	-	0	1	0	-	0	4	1	1	1	1900-01-01	string
764	398	nomedisciplina	Disciplina	left	left	300	-	0	1	0	-	0	2	1	1	1	1900-01-01	string
765	398	nometurma	Turma	left	left	250	-	0	1	0	-	0	3	1	1	1	1900-01-01	string
766	398	nomecurso	Curso	left	left	200	-	0	1	0	-	0	4	1	1	1	1900-01-01	string
767	402	nomedisciplina	Disciplina	left	left	300	-	0	1	0	-	0	1	1	1	1	1900-01-01	string
768	402	nometurma	Turma	left	left	250	-	0	1	0	-	0	3	1	1	1	1900-01-01	string
769	402	nomecurso	Curso	left	left	200	-	0	1	0	-	0	4	1	1	1	1900-01-01	string
814	411	nomedisciplina	Disciplina	left	left	200	-	0	1	0	-	0	4	1	1	1	1900-01-01	string
815	411	nomeprofessor	Professor	left	left	200	-	0	1	0	-	0	5	1	1	1	1900-01-01	string
818	411	nomecurso	Curso	left	left	250	-	0	1	0	-	0	2	1	1	1	1900-01-01	string
820	411	sala	Sala	left	left	150	-	0	1	0	-	0	8	1	1	1	1900-01-01	string
821	412	nometurma	Turma	left	left	180	-	0	1	0	-	0	3	1	1	1	1900-01-01	string
826	412	nomecurso	Curso	left	left	250	-	0	1	0	-	0	2	1	1	1	1900-01-01	string
828	412	sala	Sala	left	left	150	-	0	1	0	-	0	8	1	1	1	1900-01-01	string
919	467	avaliacao	Avaliação	left	left	200	-	0	1	0	-	0	2	1	1	1	1900-01-01	string
306	194	obs	Observação	left	left	400	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
355	189	conteudo	Conteudo	left	left	500	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
651	282	obs	Observações	left	left	400	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
653	279	conteudo	Conteudo	left	left	500	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
117	152	avaliacao	Avaliação	left	left	300	-	0	1	0	-	0	1	1	1	1	1900-01-01	string
507	235	avaliacao	Avaliação	left	left	300	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
577	263	avaliacao	Avaliação	left	left	400	-	0	1	0	-	0	1	1	1	1	1900-01-01	string
654	283	avaliacao	Avaliação	left	left	400	-	0	1	0	-	0	1	1	1	1	1900-01-01	string
274	188	material	Material	left	left	300	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
352	201	conteudo	Conteúdo	left	left	450	-	0	1	0	-	0	2	1	1	1	1900-01-01	string
109	150	requisito	Requisito	left	left	400	-	0	1	0	-	0	1	1	1	1	1900-01-01	string
541	135	cargahoraria	C.H.	left	left	40	-	0	1	0	-	0	4	1	1	1	1900-01-01	numeric
119	152	peso	Peso	center	center	60	-	0	1	0	-	0	3	1	1	1	1900-01-01	numeric
275	188	custo	Custo	left	left	100	TSetModel,setValorMonetario	0	1	0	-	0	0	1	1	1	1900-01-01	numeric
353	201	dataaula	Data	center	center	90	-	0	1	0	-	0	1	1	1	1	1900-01-01	date
579	263	peso	Peso	left	left	100	-	0	1	0	-	0	3	1	1	1	1900-01-01	numeric
650	282	dataaula	Data	left	left	100	-	0	1	0	-	0	0	1	1	1	1900-01-01	date
652	279	dataaula	Data	left	left	100	-	0	1	0	-	0	0	1	1	1	1900-01-01	date
656	283	peso	Peso	left	left	100	-	0	1	0	-	0	3	1	1	1	1900-01-01	numeric
816	411	frequencia	Frequência	left	left	80	-	0	1	0	-	0	7	1	1	1	1900-01-01	numeric
817	411	alunos	Nº de Alunos	left	left	80	-	0	1	0	-	0	6	1	1	1	1900-01-01	numeric
824	412	frequencia	Frequência	left	left	80	-	0	1	0	-	0	7	1	1	1	1900-01-01	numeric
825	412	alunos	Nº de Alunos	left	left	80	-	0	1	0	-	0	6	1	1	1	1900-01-01	numeric
882	430	nota	Nota	center	center	100	-	0	1	0	-	0	3	1	1	1	1900-01-01	numeric
883	430	frequencia	Freq.	center	center	100	-	0	1	0	-	0	4	1	1	1	1900-01-01	numeric
201	158	telefone1	Telefone	center	center	120	TSetModel,setTelefone	0	1	0	-	0	0	1	1	1	1900-01-01	numeric
180	167	usuario	Usuário	left	left	200	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
181	167	nomepessoa	Responsável	left	left	400	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
151	159	cliente	Cliente	left	left	200	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
321	159	unidade	Unidade	left	left	200	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
880	430	nomedisciplina	Disciplina	left	left	250	-	0	1	0	-	0	1	1	1	1	1900-01-01	string
822	412	nomedisciplina	Disciplina	left	left	200	-	0	1	0	-	0	4	1	1	1	1900-01-01	string
823	412	nomeprofessor	Professor	left	left	200	-	0	1	0	-	0	5	1	1	1	1900-01-01	string
357	202	titulo	Titulo	left	left	300	-	0	1	0	-	0	0	1	1	1	1900-01-01	string
358	202	tipo	Tipo	left	left	200	TTurmaDisciplinas,getTipoArquivo	0	1	0	-	0	0	1	1	1	1900-01-01	string
956	481	tipo	Mov.	center	center	40	-	0	1	0	-	0	2	1	1	1	1900-01-01	string
952	479	tipo	Mov.	center	center	50	-	0	1	0	-	0	3	1	1	1	1900-01-01	string
7	131	cargahoraria	Carga horaria	right	right	100	-	0	1	0	-	0	0	1	1	1	1900-01-01	numeric
937	477	cargahoraria	C.H.	left	right	30	-	0	1	0	-	0	3	1	1	1	1900-01-01	numeric
881	430	cargahoraria	C.H.	center	center	50	-	0	1	0	-	0	2	1	1	1	1900-01-01	numeric
830	417	cargahorariasemelhante	C.H.	left	left	120	-	0	2	0	-	0	1	1	1	1	1900-01-01	numeric
506	133	cargahoraria	C.H.	center	center	40	-	0	1	0	-	0	12	1	1	1	1900-01-01	numeric
137	156	cargaHoraria	Carga Horaria	left	left	100	-	0	1	0	-	0	0	1	1	1	1900-01-01	numeric
48	141	numero	Parcela	center	center	100	-	0	1	0	-	0	4	1	1	1	1900-01-01	numeric
345	130	email_secundario	E-mail	left	left	250	-	0	1	0	-	0	5	9	1	1	1900-01-01	string
84	144	valor	Valor da Conta	rigth	right	100	TSetModel,setValorMonetario	0	1	0	-	0	8	1	1	1	1900-01-01	numeric
4	130	telefone2	Telefone Secundário	center	center	120	TSetModel,setTelefone	0	1	0	-	0	4	1	1	1	1900-01-01	numeric
149	159	vencimento	Vencimento	center	center	100	-	0	1	0	-	0	0	1	1	1	1900-01-01	date
413	212	telefone2	Celular	center	center	120	TSetModel,setTelefone	0	1	0	-	0	0	9	1	1	1900-01-01	numeric
182	168	nivel	Modulo	left	left	300	-	0	1	0	-	0	0	1	1	1	1900-01-01	numeric
183	168	modulo	Item do Menu	left	left	300	-	0	1	0	-	0	0	1	1	1	1900-01-01	numeric
303	189	dataaula	Data	left	left	100	-	0	1	0	-	0	0	1	1	1	1900-01-01	date
305	194	dataaula	Data	left	left	100	-	0	1	0	-	0	0	1	1	1	1900-01-01	date
339	130	telefone2	Celular	center	center	120	TSetModel,setTelefone	0	1	0	-	0	0	9	1	1	1900-01-01	numeric
411	212	email_principal	E-Mail	left	left	250	-	0	1	0	-	0	0	9	1	1	1900-01-01	string
338	130	telefone1	Telefone	center	center	120	TSetModel,setTelefone	0	1	0	-	0	0	9	1	1	1900-01-01	numeric
359	202	dataCad	Data	left	left	60	-	0	1	0	-	0	0	1	1	1	1900-01-01	date
408	212	telefone2	Celular	center	center	120	TSetModel,setTelefone	0	1	0	-	0	4	9	1	1	1900-01-01	numeric
337	130	email_principal	E-mail	left	left	250	-	0	1	0	-	0	5	1	1	1	1900-01-01	string
407	212	telefone1	Telefone	center	center	120	TSetModel,setTelefone	0	1	0	-	0	3	9	1	1	1900-01-01	numeric
3	130	telefone1	Telefone Principal	center	center	120	TSetModel,setTelefone	0	1	0	-	0	3	1	1	1	1900-01-01	numeric
412	212	telefone1	Telefone	center	center	120	TSetModel,setTelefone	0	1	0	-	0	0	9	1	1	1900-01-01	numeric
440	146	numero	Parcela	left	left	60	-	0	1	0	-	0	7	1	1	1	1900-01-01	numeric
801	185	telefone2	Celular	center	center	120	TSetModel,setTelefone	0	1	0	-	0	5	9	1	1	1900-01-01	numeric
414	212	email_secundario	E-mail	left	left	150	-	0	1	0	-	0	5	9	1	1	1900-01-01	string
800	185	telefone1	Telefone	center	center	120	TSetModel,setTelefone	0	1	0	-	0	4	9	1	1	1900-01-01	numeric
873	427	telefone2	Cel.	center	center	100	TSetModel,setTelefone	0	1	0	-	0	5	9	1	1	1900-01-01	numeric
957	481	valor	Valor Nominal	rigth	right	100	TSetModel,setValorMonetario	0	1	0	-	0	3	1	1	1	1900-01-01	numeric
708	165	email_principal	E-Mail	left	left	200	-	0	1	0	-	0	1	9	1	1	1900-01-01	string
802	185	email	E-mail	left	left	200	-	0	1	0	-	0	6	9	1	1	1900-01-01	string
872	427	telefone1	Tel.	center	center	100	TSetModel,setTelefone	0	1	0	-	0	4	9	1	1	1900-01-01	numeric
146	158	cnpj	CNPJ	left	left	120	-	0	1	0	-	0	0	1	1	1	1900-01-01	numeric
150	159	valorinicial	Valor Nominal	right	right	100	TSetModel,setValorMonetario	0	1	0	-	0	0	1	1	1	1900-01-01	numeric
234	177	telefones	Telefone	center	center	120	TSetModel,setTelefone	0	1	0	-	0	0	1	1	1	1900-01-01	numeric
326	195	dataCad	Registro	left	left	100	-	0	1	0	-	0	0	1	1	1	1900-01-01	date
402	145	valoratual	Valor Atual	right	right	100	TSetModel,setValorMonetario	0	1	0	-	0	5	1	1	1	1900-01-01	numeric
532	228	valorTaxa	Taxa	left	left	60	TSetModel,setValorMonetario	0	1	0	-	0	4	1	1	1	1900-01-01	numeric
638	278	ano	Ano	left	left	30	-	0	1	0	-	0	4	1	1	1	1900-01-01	numeric
788	133	nome	Ref. Curso	left	left	200	-	0	1	0	-	0	4	1	1	1	1900-01-01	numeric
841	419	saida_cartao	Desp. Cartão	center	center	120	TSetModel,setValorMonetario	0	1	0	-	0	11	1	1	1	1900-01-01	numeric
866	425	vencimento	Data Venc.	left	left	70	-	0	1	0	-	0	7	1	1	1	1900-01-01	date
891	445	numaula	Nº	center	center	30	-	0	1	0	-	0	3	1	1	1	1900-01-01	numeric
160	160	telefone1	Telefone	center	center	120	TSetModel,setTelefone	0	1	0	-	0	0	9	1	1	1900-01-01	numeric
17	172	telefone1	Telefone	center	center	120	TSetModel,setTelefone	0	1	0	-	0	2	1	1	1	1900-01-01	numeric
27	136	dataAdmissao	Admissão	center	center	100	-	0	1	0	-	0	4	1	1	1	1900-01-01	date
23	136	telefone1	Telefone	center	center	120	TSetModel,setTelefone	0	1	0	-	0	5	1	1	1	2013-10-07	numeric
19	172	email_principal	E-mail	left	left	250	-	0	1	0	-	0	4	1	1	1	1900-01-01	string
28	136	email_principal	E-mail	left	left	200	-	0	1	0	-	0	6	1	1	1	2013-10-07	string
530	137	email_principal	E-mail	left	left	200	-	0	1	0	-	0	4	1	1	1	1900-01-01	string
\.


--
-- TOC entry 2410 (class 0 OID 0)
-- Dependencies: 174
-- Name: coluna_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('coluna_seq_seq', 28, true);


--
-- TOC entry 2336 (class 0 OID 16460)
-- Dependencies: 175 2373
-- Data for Name: dbpessoa; Type: TABLE DATA; Schema: public; Owner: -
--

COPY dbpessoa (seq, unidseq, usuaseq, tipo, pessnmrz, pessnmrf, pessrgie, pessteim, cliente, fornecedor, funcionario, datacad, foto, statseq) FROM stdin;
1	1	1	F	Skynet	0	0	\N	0	0	0	2013-07-16	\N	1
\.


--
-- TOC entry 2411 (class 0 OID 0)
-- Dependencies: 176
-- Name: dbpessoa_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbpessoa_seq_seq', 1, true);


--
-- TOC entry 2338 (class 0 OID 16475)
-- Dependencies: 177 2373
-- Data for Name: dbstatus; Type: TABLE DATA; Schema: public; Owner: -
--

COPY dbstatus (seq, unidseq, usuaseq, statdesc, datacad, statseq) FROM stdin;
1	1	1	Ativo	2013-07-16	1
8	1	1	Inativo	2013-07-16	1
9	1	1	Inconsistente	2013-07-16	1
7	1	1	Com falha na implementação	2013-08-13	1
\.


--
-- TOC entry 2412 (class 0 OID 0)
-- Dependencies: 178
-- Name: dbstatus_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbstatus_seq_seq', 1, false);


--
-- TOC entry 2340 (class 0 OID 16482)
-- Dependencies: 179 2373
-- Data for Name: dbunidade; Type: TABLE DATA; Schema: public; Owner: -
--

COPY dbunidade (seq, unidseq, usuaseq, nomeunidade, razaosocial, cnpj, inscestadual, inscmunicipal, gerente, diretor, representante, logradouro, bairro, cidade, estado, cep, email, telefone, datacad, statseq) FROM stdin;
1	1	1	Skynet	Skynet	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2013-07-16	1
\.


--
-- TOC entry 2341 (class 0 OID 16490)
-- Dependencies: 180 2373
-- Data for Name: dbunidade_parametro; Type: TABLE DATA; Schema: public; Owner: -
--

COPY dbunidade_parametro (seq, unidseq, usuaseq, parametro, valor, obs, datacad, statseq) FROM stdin;
\.


--
-- TOC entry 2413 (class 0 OID 0)
-- Dependencies: 181
-- Name: dbunidade_parametro_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbunidade_parametro_seq_seq', 1, false);


--
-- TOC entry 2414 (class 0 OID 0)
-- Dependencies: 182
-- Name: dbunidade_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbunidade_seq_seq', 1, true);


--
-- TOC entry 2344 (class 0 OID 16503)
-- Dependencies: 183 2373
-- Data for Name: dbusuario; Type: TABLE DATA; Schema: public; Owner: -
--

COPY dbusuario (seq, unidseq, usuaseq, classeuser, pessseq, usuario, senha, entidadepai, temaseq, datacad, lastip, lastaccess, lastpass, statseq) FROM stdin;
1	1	1	1	1	admin	209d439cb668c11fc8657c4d90dee1d2	\N	17	2013-07-16	::1	1374003596	\N	1
\.


--
-- TOC entry 2345 (class 0 OID 16510)
-- Dependencies: 184 2373
-- Data for Name: dbusuario_privilegio; Type: TABLE DATA; Schema: public; Owner: -
--

COPY dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) FROM stdin;
1	1	1	1	1	2	2013-07-16	1
2	1	1	1	2	2	2013-07-16	1
3	1	1	1	3	2	2013-07-16	1
4	1	1	3	1	2	2013-07-16	1
5	1	1	3	2	2	2013-07-16	1
6	1	1	3	3	2	2013-07-16	1
7	1	1	4	1	2	2013-07-16	1
8	1	1	4	2	2	2013-07-16	1
9	1	1	4	3	2	2013-07-16	1
10	1	1	7	1	2	2013-07-16	1
11	1	1	7	2	2	2013-07-16	1
12	1	1	7	3	2	2013-07-16	1
13	1	1	8	1	2	2013-07-16	1
14	1	1	8	2	2	2013-07-16	1
15	1	1	8	3	2	2013-07-16	1
16	1	1	9	1	2	2013-07-16	1
17	1	1	9	2	2	2013-07-16	1
18	1	1	9	3	2	2013-07-16	1
19	1	1	10	1	2	2013-07-16	1
20	1	1	10	2	2	2013-07-16	1
21	1	1	10	3	2	2013-07-16	1
22	1	1	14	1	2	2013-07-16	1
23	1	1	14	2	2	2013-07-16	1
24	1	1	14	3	2	2013-07-16	1
25	1	1	15	1	2	2013-07-16	1
26	1	1	15	2	2	2013-07-16	1
27	1	1	15	3	2	2013-07-16	1
28	1	1	18	1	2	2013-07-16	1
29	1	1	18	2	2	2013-07-16	1
30	1	1	18	3	2	2013-07-16	1
31	1	1	21	1	2	2013-07-16	1
32	1	1	21	2	2	2013-07-16	1
33	1	1	21	3	2	2013-07-16	1
34	1	1	24	1	2	2013-07-16	1
35	1	1	24	2	2	2013-07-16	1
36	1	1	24	3	2	2013-07-16	1
37	1	1	25	1	2	2013-07-16	1
38	1	1	25	2	2	2013-07-16	1
39	1	1	25	3	2	2013-07-16	1
40	1	1	26	1	2	2013-07-16	1
41	1	1	26	2	2	2013-07-16	1
42	1	1	26	3	2	2013-07-16	1
43	1	1	28	1	2	2013-07-16	1
44	1	1	28	2	2	2013-07-16	1
45	1	1	28	3	2	2013-07-16	1
46	1	1	30	1	2	2013-07-16	1
47	1	1	30	2	2	2013-07-16	1
48	1	1	30	3	2	2013-07-16	1
49	1	1	33	1	2	2013-07-16	1
50	1	1	33	2	2	2013-07-16	1
51	1	1	33	3	2	2013-07-16	1
52	1	1	36	1	2	2013-07-16	1
53	1	1	36	2	2	2013-07-16	1
54	1	1	36	3	2	2013-07-16	1
55	1	1	38	1	2	2013-07-16	1
56	1	1	38	2	2	2013-07-16	1
57	1	1	38	3	2	2013-07-16	1
58	1	1	39	1	2	2013-07-16	1
59	1	1	39	2	2	2013-07-16	1
60	1	1	39	3	2	2013-07-16	1
61	1	1	41	1	2	2013-07-16	1
62	1	1	41	2	2	2013-07-16	1
63	1	1	41	3	2	2013-07-16	1
64	1	1	43	1	2	2013-07-16	1
65	1	1	43	2	2	2013-07-16	1
66	1	1	43	3	2	2013-07-16	1
67	1	1	45	1	2	2013-07-16	1
68	1	1	45	2	2	2013-07-16	1
69	1	1	45	3	2	2013-07-16	1
70	1	1	49	1	2	2013-07-16	1
71	1	1	49	2	2	2013-07-16	1
72	1	1	49	3	2	2013-07-16	1
73	1	1	50	1	2	2013-07-16	1
74	1	1	50	2	2	2013-07-16	1
75	1	1	50	3	2	2013-07-16	1
76	1	1	51	1	2	2013-07-16	1
77	1	1	51	2	2	2013-07-16	1
78	1	1	51	3	2	2013-07-16	1
79	1	1	0	1	0	2013-07-16	1
80	1	1	1	1	1	2013-07-16	1
81	1	1	1	2	1	2013-07-16	1
82	1	1	1	3	1	2013-07-16	1
83	1	1	1	4	1	2013-07-16	1
84	1	1	1	5	1	2013-07-16	1
85	1	1	1	6	1	2013-07-16	1
86	1	1	1	7	1	2013-07-16	1
87	1	1	1	8	1	2013-07-16	1
88	1	1	1	9	1	2013-07-16	1
89	1	1	1	10	1	2013-07-16	1
90	1	1	1	11	1	2013-07-16	1
91	1	1	1	12	1	2013-07-16	1
92	1	1	1	13	1	2013-07-16	1
93	1	1	1	14	1	2013-07-16	1
94	1	1	1	15	1	2013-07-16	1
95	1	1	1	16	1	2013-07-16	1
96	1	1	1	17	1	2013-07-16	1
97	1	1	1	18	1	2013-07-16	1
98	1	1	1	19	1	2013-07-16	1
99	1	1	1	20	1	2013-07-16	1
100	1	1	1	21	1	2013-07-16	1
101	1	1	1	22	1	2013-07-16	1
102	1	1	1	23	1	2013-07-16	1
103	1	1	1	24	1	2013-07-16	1
104	1	1	1	25	1	2013-07-16	1
105	1	1	1	26	1	2013-07-16	1
\.


--
-- TOC entry 2415 (class 0 OID 0)
-- Dependencies: 185
-- Name: dbusuario_privilegio_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbusuario_privilegio_seq_seq', 105, true);


--
-- TOC entry 2416 (class 0 OID 0)
-- Dependencies: 186
-- Name: dbusuario_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbusuario_seq_seq', 1, true);


--
-- TOC entry 2348 (class 0 OID 16522)
-- Dependencies: 187 2373
-- Data for Name: form_button; Type: TABLE DATA; Schema: public; Owner: -
--

COPY form_button (seq, formseq, botao, labelbotao, confirmacao, actionjs, metodo, ordem, statseq, usuaseq, unidseq, datacad) FROM stdin;
1	49	fecharCaixa	Fechar Caixa	Você deseja Realmente executar esta ação?	closeCaixaDia	\N	1 	1	1	1	1900-01-01
2	13	concluir_botform	Baixar conta	Você deseja realmente executar o pagamento desta conta?	onClose	onClose	2 	0	1	1	1900-01-01
4	8	concluir_inscricao	Concluir	\N	onClose	onClose	2 	1	1	1	1900-01-01
5	483	bot_consolidarNotasFrequencias	Consolidar	Atenção, apenas as disciplinas selecionadas serão consolidadas, deseja continuar?	closeConsolidacaoNotasFrequencias	onClose	1 	1	1	1	1900-01-01
6	484	bot_baixaMultipla	Baixar Contas	Você deseja realmente executar a baixa de todas as contas selecionadas?	setBaixaMultipla	onClose	1 	1	1	1	1900-01-01
\.


--
-- TOC entry 2417 (class 0 OID 0)
-- Dependencies: 188
-- Name: form_button_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('form_button_seq_seq', 1, false);


--
-- TOC entry 2418 (class 0 OID 0)
-- Dependencies: 189
-- Name: form_list_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('form_list_seq_seq', 6, true);


--
-- TOC entry 2351 (class 0 OID 16534)
-- Dependencies: 190 2373
-- Data for Name: form_validacao; Type: TABLE DATA; Schema: public; Owner: -
--

COPY form_validacao (seq, formseq, usuaseq, unidseq, datacad, statseq) FROM stdin;
\.


--
-- TOC entry 2419 (class 0 OID 0)
-- Dependencies: 191
-- Name: form_validacao_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('form_validacao_seq_seq', 1, false);


--
-- TOC entry 2353 (class 0 OID 16540)
-- Dependencies: 192 2373
-- Data for Name: form_x_abas; Type: TABLE DATA; Schema: public; Owner: -
--

COPY form_x_abas (seq, formseq, abaseq, statseq, ordem, usuaseq, unidseq, datacad) FROM stdin;
22	8	24	1	0	1	1	1900-01-01
24	9	26	1	0	1	1	1900-01-01
25	9	27	1	0	1	1	1900-01-01
26	10	28	1	0	1	1	1900-01-01
27	11	29	1	0	1	1	1900-01-01
33	17	35	1	0	1	1	1900-01-01
39	19	42	1	0	1	1	1900-01-01
40	20	43	1	0	1	1	1900-01-01
41	20	44	1	0	1	1	1900-01-01
44	19	48	1	0	1	1	1900-01-01
45	19	49	1	0	1	1	1900-01-01
46	22	50	1	0	1	1	1900-01-01
48	21	47	1	0	1	1	1900-01-01
53	24	57	1	0	1	1	1900-01-01
54	26	58	1	0	1	1	1900-01-01
55	26	59	1	0	1	1	1900-01-01
56	26	60	1	0	1	1	1900-01-01
57	26	61	1	0	1	1	1900-01-01
58	79	247	1	1	1	1	1900-01-01
59	27	63	1	3	1	1	1900-01-01
60	30	65	1	0	1	1	1900-01-01
61	31	66	1	0	1	1	1900-01-01
62	32	67	1	0	1	1	1900-01-01
63	31	67	1	0	1	1	1900-01-01
64	33	68	1	0	1	1	1900-01-01
65	34	69	1	0	1	1	1900-01-01
66	21	70	1	0	1	1	1900-01-01
67	39	71	1	0	1	1	1900-01-01
69	38	73	1	0	1	1	1900-01-01
70	40	74	1	0	1	1	1900-01-01
71	41	75	1	0	1	1	1900-01-01
72	41	76	1	0	1	1	1900-01-01
74	44	78	1	0	1	1	1900-01-01
75	44	79	1	0	1	1	1900-01-01
76	46	80	1	0	1	1	1900-01-01
77	46	81	1	0	1	1	1900-01-01
78	46	82	1	0	1	1	1900-01-01
79	46	83	1	0	1	1	1900-01-01
80	46	84	1	0	1	1	1900-01-01
81	46	85	1	0	1	1	1900-01-01
82	46	86	1	0	1	1	1900-01-01
83	47	87	1	0	1	1	1900-01-01
85	49	89	1	0	1	1	1900-01-01
86	49	90	1	0	1	1	1900-01-01
87	50	91	1	0	1	1	1900-01-01
89	52	93	1	0	1	1	1900-01-01
90	53	94	1	0	1	1	1900-01-01
91	54	95	1	0	1	1	1900-01-01
96	20	200	1	0	1	1	1900-01-01
97	20	201	1	0	1	1	1900-01-01
98	20	202	1	0	1	1	1900-01-01
99	57	203	1	0	1	1	1900-01-01
100	57	204	1	0	1	1	1900-01-01
101	57	205	1	0	1	1	1900-01-01
102	57	206	1	0	1	1	1900-01-01
103	57	207	1	0	1	1	1900-01-01
104	57	208	1	0	1	1	1900-01-01
105	57	209	1	0	1	1	1900-01-01
116	61	216	1	0	1	1	1900-01-01
117	62	217	1	0	1	1	1900-01-01
120	43	24	1	0	1	1	1900-01-01
121	64	220	1	0	1	1	1900-01-01
122	67	221	1	1	1	1	1900-01-01
124	67	223	1	2	1	1	1900-01-01
135	76	230	1	0	1	1	1900-01-01
126	71	1	1	0	1	1	1900-01-01
127	71	2	1	0	1	1	1900-01-01
128	71	3	1	0	1	1	1900-01-01
129	71	4	1	0	1	1	1900-01-01
130	71	225	1	0	1	1	1900-01-01
131	72	222	1	1	1	1	1900-01-01
132	72	226	1	2	1	1	1900-01-01
136	77	231	1	1	1	1	1900-01-01
139	78	234	1	0	1	1	1900-01-01
140	29	64	1	1	1	1	1900-01-01
141	83	239	1	1	1	1	1900-01-01
143	84	241	1	0	1	1	1900-01-01
145	84	243	1	0	1	1	1900-01-01
146	27	244	1	2	1	1	1900-01-01
147	85	245	1	1	1	1	1900-01-01
15	3	16	1	5	1	1	1900-01-01
16	4	18	1	1	1	1	1900-01-01
17	4	19	1	2	1	1	1900-01-01
150	87	18	1	1	1	1	1900-01-01
151	87	249	1	2	1	1	1900-01-01
154	89	250	1	1	1	1	1900-01-01
21	7	23	1	1	1	1	1900-01-01
155	89	251	1	2	1	1	1900-01-01
156	89	252	1	3	1	1	1900-01-01
1	1	1	1	1	1	1	1900-01-01
2	1	3	1	3	1	1	1900-01-01
137	77	232	0	2	1	1	1900-01-01
157	90	253	1	1	1	1	1900-01-01
111	59	211	1	1	1	1	1900-01-01
158	260	254	1	1	1	1	1900-01-01
110	58	40	1	2	1	1	1900-01-01
38	18	264	1	3	1	1	1900-01-01
34	18	265	1	1	1	1	1900-01-01
159	58	255	1	1	1	1	1900-01-01
160	261	256	1	1	1	1	1900-01-01
162	83	258	1	3	1	1	1900-01-01
163	270	259	1	1	1	1	1900-01-01
142	83	240	1	4	1	1	1900-01-01
161	83	257	1	2	1	1	1900-01-01
164	266	261	1	1	1	1	1900-01-01
165	264	260	1	1	1	1	1900-01-01
166	267	262	1	1	1	1	1900-01-01
6	14	6	1	2	1	1	1900-01-01
5	14	33	1	1	1	1	1900-01-01
107	58	41	1	3	1	1	1900-01-01
35	18	263	1	2	1	1	1900-01-01
7	320	266	1	1	1	1	1900-01-01
11	63	218	1	0	1	1	1900-01-01
28	12	30	1	1	1	1	1900-01-01
169	63	269	1	2	1	1	1900-01-01
134	75	228	1	1	1	1	1900-01-01
170	75	270	1	2	1	1	1900-01-01
171	75	271	1	3	1	1	1900-01-01
20	332	272	1	1	1	1	1900-01-01
29	13	31	1	1	1	1	1900-01-01
30	13	274	1	2	1	1	1900-01-01
23	333	32	1	1	1	1	1900-01-01
172	333	273	1	2	1	1	1900-01-01
113	60	213	1	2	1	1	1900-01-01
115	60	215	1	4	1	1	1900-01-01
173	334	275	1	1	1	1	1900-01-01
174	335	276	1	1	1	1	1900-01-01
175	336	277	1	1	1	1	1900-01-01
176	337	278	1	1	1	1	1900-01-01
73	1	77	1	5	1	1	1900-01-01
177	338	279	1	1	1	1	1900-01-01
178	339	280	1	1	1	1	1900-01-01
179	340	281	1	1	1	1	1900-01-01
149	0	248	0	4	1	1	1900-01-01
106	459	210	1	2	1	1	1900-01-01
180	341	282	1	1	1	1	1900-01-01
181	342	283	1	1	1	1	1900-01-01
182	343	284	1	1	1	1	1900-01-01
43	6	46	1	2	1	1	1900-01-01
50	6	54	1	4	1	1	1900-01-01
88	6	92	0	5	1	1	1900-01-01
183	344	285	1	1	1	1	1900-01-01
184	345	286	1	1	1	1	1900-01-01
185	346	287	1	1	1	1	1900-01-01
186	347	288	1	1	1	1	1900-01-01
187	348	289	1	1	1	1	1900-01-01
188	349	290	1	1	1	1	1900-01-01
189	350	291	1	1	1	1	1900-01-01
190	351	292	1	1	1	1	1900-01-01
191	352	293	1	1	1	1	1900-01-01
192	353	294	1	1	1	1	1900-01-01
193	354	295	1	1	1	1	1900-01-01
194	355	296	1	1	1	1	1900-01-01
195	356	297	1	1	1	1	1900-01-01
196	357	298	1	1	1	1	1900-01-01
197	358	299	1	1	1	1	1900-01-01
198	359	300	1	1	1	1	1900-01-01
199	360	301	1	1	1	1	1900-01-01
200	361	302	1	1	1	1	1900-01-01
201	362	303	1	1	1	1	1900-01-01
202	363	304	1	1	1	1	1900-01-01
203	364	305	1	1	1	1	1900-01-01
204	365	306	1	1	1	1	1900-01-01
205	366	307	1	1	1	1	1900-01-01
206	367	308	1	1	1	1	1900-01-01
152	87	34	1	3	1	1	1900-01-01
153	87	88	1	4	1	1	1900-01-01
84	5	88	9	5	1	1	1900-01-01
119	5	219	9	6	1	1	1900-01-01
19	5	55	1	3	1	1	2013-09-04
18	5	20	1	1	1	1	2013-09-04
32	5	34	1	4	1	1	2013-09-04
51	5	21	1	2	1	1	2013-09-04
214	375	316	1	1	1	1	1900-01-01
215	376	317	1	1	1	1	1900-01-01
216	377	318	1	1	1	1	1900-01-01
217	378	319	1	1	1	1	1900-01-01
218	379	320	1	1	1	1	1900-01-01
219	72	321	1	3	1	1	1900-01-01
221	383	323	1	2	1	1	1900-01-01
220	383	322	1	1	1	1	1900-01-01
222	389	31	1	1	1	1	1900-01-01
223	389	274	1	2	1	1	1900-01-01
224	390	32	1	1	1	1	1900-01-01
225	390	273	1	2	1	1	1900-01-01
114	60	214	1	3	1	1	1900-01-01
226	397	324	1	1	1	1	1900-01-01
167	399	268	1	4	1	1	1900-01-01
227	328	325	1	1	1	1	1900-01-01
211	372	317	1	1	1	1	1900-01-01
228	403	326	1	1	1	1	1900-01-01
229	404	327	1	1	1	1	1900-01-01
231	405	329	1	1	1	1	1900-01-01
232	406	330	1	1	1	1	1900-01-01
233	407	331	1	1	1	1	1900-01-01
234	405	332	1	2	1	1	1900-01-01
235	406	333	1	2	1	1	1900-01-01
236	407	334	1	2	1	1	1900-01-01
239	413	337	1	1	1	1	1900-01-01
240	418	338	1	1	1	1	1900-01-01
241	418	339	1	2	1	1	1900-01-01
242	78	340	1	2	1	1	1900-01-01
243	1	341	1	6	1	1	1900-01-01
244	426	342	1	0	1	1	1900-01-01
245	428	343	1	0	1	1	1900-01-01
246	429	344	1	1	1	1	1900-01-01
247	431	345	1	0	1	1	1900-01-01
248	432	346	1	0	1	1	1900-01-01
249	433	347	1	0	1	1	1900-01-01
250	434	348	1	0	1	1	1900-01-01
251	435	349	1	0	1	1	1900-01-01
252	436	350	1	0	1	1	1900-01-01
253	437	351	1	0	1	1	1900-01-01
254	438	352	1	0	1	1	1900-01-01
255	439	353	1	0	1	1	1900-01-01
256	440	354	1	0	1	1	1900-01-01
257	441	355	1	0	1	1	1900-01-01
258	442	356	1	0	1	1	1900-01-01
259	444	358	1	0	1	1	1900-01-01
261	446	360	1	1	1	1	1900-01-01
262	320	361	1	2	1	1	1900-01-01
263	448	362	1	1	1	1	1900-01-01
264	67	363	1	3	1	1	1900-01-01
265	450	364	1	1	1	1	1900-01-01
267	452	366	1	1	1	1	1900-01-01
268	454	367	1	1	1	1	1900-01-01
68	15	72	1	1	1	1	1900-01-01
237	460	335	1	6	1	1	1900-01-01
138	0	233	0	3	1	1	1900-01-01
269	463	368	1	1	1	1	1900-01-01
270	464	369	1	1	1	1	1900-01-01
271	18	370	1	2	1	1	1900-01-01
272	58	371	1	2	1	1	1900-01-01
273	471	372	1	1	1	1	1900-01-01
274	472	373	1	1	1	1	1900-01-01
275	473	374	1	1	1	1	1900-01-01
276	474	375	1	1	1	1	1900-01-01
42	6	45	1	1	1	1	1900-01-01
49	6	53	1	3	1	1	1900-01-01
230	15	328	0	2	1	1	1900-01-01
279	478	377	1	1	1	1	1900-01-01
280	482	378	1	1	1	1	1900-01-01
281	483	379	1	1	1	1	1900-01-01
283	484	380	1	1	1	1	1900-01-01
284	487	381	1	1	1	1	1900-01-01
207	368	309	1	1	1	1	1900-01-01
208	369	310	1	1	1	1	1900-01-01
209	370	311	1	1	1	1	1900-01-01
210	371	312	1	1	1	1	1900-01-01
212	373	314	1	1	1	1	1900-01-01
213	374	315	1	1	1	1	1900-01-01
3	2	7	1	1	1	1	2013-08-21
12	3	13	1	2	1	1	1900-01-01
13	3	14	1	3	1	1	1900-01-01
238	3	336	1	6	1	1	1900-01-01
277	475	18	1	1	1	1	1900-01-01
278	475	376	1	2	1	1	1900-01-01
266	5	365	1	8	1	1	2013-09-04
10	3	11	1	1	1	1	1900-01-01
14	3	15	1	4	1	1	1900-01-01
148	7	246	1	2	1	1	1900-01-01
\.


--
-- TOC entry 2420 (class 0 OID 0)
-- Dependencies: 193
-- Name: form_x_abas_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('form_x_abas_seq_seq', 3, true);


--
-- TOC entry 2355 (class 0 OID 16548)
-- Dependencies: 194 2373
-- Data for Name: form_x_tabelas; Type: TABLE DATA; Schema: public; Owner: -
--

COPY form_x_tabelas (seq, formseq, tabseq, statseq, usuaseq, unidseq, datacad) FROM stdin;
17	8	16	1	1	1	1900-01-01
18	9	17	1	1	1	1900-01-01
19	10	18	1	1	1	1900-01-01
22	13	21	1	1	1	1900-01-01
23	14	16	1	1	1	1900-01-01
26	15	22	1	1	1	1900-01-01
27	16	11	1	1	1	1900-01-01
29	17	24	1	1	1	1900-01-01
30	18	25	1	1	1	1900-01-01
31	6	26	1	1	1	1900-01-01
33	18	28	1	1	1	1900-01-01
34	19	29	1	1	1	1900-01-01
35	20	30	1	1	1	1900-01-01
37	22	33	1	1	1	1900-01-01
38	22	34	1	1	1	1900-01-01
39	21	32	1	1	1	1900-01-01
40	24	35	1	1	1	1900-01-01
41	26	1	1	1	1	1900-01-01
42	27	37	1	1	1	1900-01-01
43	28	38	1	1	1	1900-01-01
44	30	39	1	1	1	1900-01-01
45	31	26	1	1	1	1900-01-01
46	33	41	1	1	1	1900-01-01
48	34	44	1	1	1	1900-01-01
49	39	45	1	1	1	1900-01-01
50	36	22	1	1	1	1900-01-01
51	38	46	1	1	1	1900-01-01
52	40	47	1	1	1	1900-01-01
54	46	50	1	1	1	1900-01-01
57	47	17	1	1	1	1900-01-01
59	48	53	1	1	1	1900-01-01
104	85	80	1	1	1	1900-01-01
61	50	22	1	1	1	1900-01-01
66	57	58	1	1	1	1900-01-01
67	58	12	1	1	1	1900-01-01
68	59	12	1	1	1	1900-01-01
69	60	62	1	1	1	1900-01-01
70	61	12	1	1	1	1900-01-01
71	62	63	1	1	1	1900-01-01
72	64	64	1	1	1	1900-01-01
73	65	21	1	1	1	1900-01-01
74	66	21	1	1	1	1900-01-01
75	67	66	1	1	1	1900-01-01
76	68	70	1	1	1	1900-01-01
77	69	11	1	1	1	1900-01-01
78	1	5	1	1	1	1900-01-01
79	1	6	1	1	1	1900-01-01
81	26	5	1	1	1	1900-01-01
82	26	6	1	1	1	1900-01-01
84	71	1	1	1	1	1900-01-01
85	71	5	1	1	1	1900-01-01
86	71	6	1	1	1	1900-01-01
88	6	5	1	1	1	1900-01-01
89	6	14	1	1	1	1900-01-01
90	72	66	1	1	1	1900-01-01
91	58	25	1	1	1	1900-01-01
92	75	70	1	1	1	1900-01-01
93	76	46	1	1	1	1900-01-01
94	77	74	1	1	1	1900-01-01
96	78	46	1	1	1	1900-01-01
97	7	75	1	1	1	1900-01-01
98	82	11	1	1	1	1900-01-01
99	29	66	1	1	1	1900-01-01
102	84	77	1	1	1	1900-01-01
105	86	56	1	1	1	1900-01-01
106	87	9	1	1	1	1900-01-01
107	87	10	1	1	1	1900-01-01
108	87	23	1	1	1	1900-01-01
109	89	82	1	1	1	1900-01-01
110	89	83	1	1	1	1900-01-01
1	5	23	1	1	1	1900-01-01
32	3	27	0	1	1	1900-01-01
63	3	56	0	1	1	1900-01-01
95	77	14	0	1	1	1900-01-01
3	5	53	0	1	1	1900-01-01
111	90	85	1	1	1	1900-01-01
120	58	28	1	1	1	1900-01-01
121	260	25	1	1	1	1900-01-01
122	59	27	1	1	1	1900-01-01
125	267	87	1	1	1	1900-01-01
124	266	87	1	1	1	1900-01-01
24	14	2	1	1	1	1900-01-01
127	18	12	1	1	1	1900-01-01
128	311	9	1	1	1	1900-01-01
130	320	89	1	1	1	1900-01-01
131	75	37	1	1	1	1900-01-01
132	332	94	1	1	1	1900-01-01
134	333	21	1	1	1	1900-01-01
135	334	49	1	1	1	1900-01-01
136	335	12	1	1	1	1900-01-01
2	1	1	1	1	1	1900-01-01
7	3	8	1	1	1	1900-01-01
9	4	9	1	1	1	1900-01-01
10	4	10	1	1	1	1900-01-01
11	5	11	1	1	1	1900-01-01
12	5	12	1	1	1	1900-01-01
16	7	15	1	1	1	1900-01-01
155	354	10	1	1	1	1900-01-01
156	355	23	1	1	1	1900-01-01
157	356	59	1	1	1	1900-01-01
158	357	83	1	1	1	1900-01-01
159	358	78	1	1	1	1900-01-01
160	359	14	1	1	1	1900-01-01
161	360	56	1	1	1	1900-01-01
162	361	34	1	1	1	1900-01-01
164	363	25	1	1	1	1900-01-01
165	364	28	1	1	1	1900-01-01
166	365	65	1	1	1	1900-01-01
167	366	27	1	1	1	1900-01-01
168	367	27	1	1	1	1900-01-01
169	368	28	1	1	1	1900-01-01
170	369	27	1	1	1	1900-01-01
171	370	28	1	1	1	1900-01-01
172	371	65	1	1	1	1900-01-01
173	372	67	1	1	1	1900-01-01
174	373	90	1	1	1	1900-01-01
175	374	92	1	1	1	1900-01-01
176	375	63	1	1	1	1900-01-01
177	376	67	1	1	1	1900-01-01
179	378	95	1	1	1	1900-01-01
181	379	21	1	1	1	1900-01-01
182	380	95	1	1	1	1900-01-01
129	83	96	1	1	1	1900-01-01
101	83	76	1	1	1	1900-01-01
183	393	8	1	1	1	1900-01-01
184	395	10	1	1	1	1900-01-01
185	397	12	1	1	1	1900-01-01
186	399	12	1	1	1	1900-01-01
187	72	65	1	1	1	1900-01-01
188	72	67	1	1	1	1900-01-01
189	405	12	1	1	1	1900-01-01
190	406	12	1	1	1	1900-01-01
191	407	12	1	1	1	1900-01-01
192	413	97	1	1	1	1900-01-01
193	426	99	1	1	1	1900-01-01
194	428	56	1	1	1	1900-01-01
195	428	100	1	1	1	1900-01-01
196	429	100	1	1	1	1900-01-01
197	434	22	1	1	1	1900-01-01
198	444	25	1	1	1	1900-01-01
201	463	105	1	1	1	1900-01-01
202	464	106	1	1	1	1900-01-01
203	465	107	1	1	1	1900-01-01
204	467	108	1	1	1	1900-01-01
205	468	108	1	1	1	1900-01-01
206	474	26	1	1	1	1900-01-01
207	450	103	1	1	1	1900-01-01
208	475	9	1	1	1	1900-01-01
209	475	10	1	1	1	1900-01-01
210	478	65	1	1	1	1900-01-01
211	480	21	1	1	1	1900-01-01
212	483	12	1	1	1	1900-01-01
213	486	65	1	1	1	1900-01-01
214	487	65	1	1	1	1900-01-01
138	337	75	1	1	1	1900-01-01
139	338	34	1	1	1	1900-01-01
140	339	38	1	1	1	1900-01-01
141	340	38	1	1	1	1900-01-01
142	341	43	1	1	1	1900-01-01
143	342	48	1	1	1	1900-01-01
144	343	53	1	1	1	1900-01-01
145	344	57	1	1	1	1900-01-01
146	345	61	1	1	1	1900-01-01
147	346	60	1	1	1	1900-01-01
148	347	40	1	1	1	1900-01-01
149	348	28	1	1	1	1900-01-01
150	349	43	1	1	1	1900-01-01
151	350	43	1	1	1	1900-01-01
152	351	75	1	1	1	1900-01-01
153	352	65	1	1	1	1900-01-01
154	353	10	1	1	1	1900-01-01
20	11	999	1	1	1	1900-01-01
21	12	999	1	1	1	1900-01-01
55	32	999	1	1	1	1900-01-01
56	32	999	1	1	1	1900-01-01
123	264	999	1	1	1	1900-01-01
126	270	999	1	1	1	1900-01-01
163	362	999	1	1	1	1900-01-01
178	377	999	1	1	1	1900-01-01
137	336	999	1	1	1	1900-01-01
4	2	3	1	1	1	2013-08-21
5	1	49	1	1	1	2013-08-21
15	6	1	1	1	1	1900-01-01
\.


--
-- TOC entry 2421 (class 0 OID 0)
-- Dependencies: 195
-- Name: form_x_tabelas_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('form_x_tabelas_seq_seq', 5, true);


--
-- TOC entry 2357 (class 0 OID 16555)
-- Dependencies: 196 2373
-- Data for Name: forms; Type: TABLE DATA; Schema: public; Owner: -
--

COPY forms (seq, formid, nomeform, tabseq, statseq, formseq, listseq, formainclude, dimensao, botconcluir, botcancelar, formoutcontrol, autosave, nivel, usuaseq, unidseq, datacad) FROM stdin;
17	contaCaixa	Contas Caixa	24	1	\N	151	one	\N	1	1	0	0	1	1	1	1900-01-01
19	cargos	Cargos	29	1	\N	153	one	\N	1	1	0	0	1	1	1	1900-01-01
20	curriculos	Curriculos	30	1	\N	154	one	\N	1	1	0	0	1	1	1	1900-01-01
22	treinamentos	Treinamentos	33	1	\N	156	one	\N	1	1	0	0	1	1	1	1900-01-01
24	filiais	Filiais	35	1	\N	158	one	\N	1	1	0	0	1	1	1	1900-01-01
348	form_blocolistObs	-	28	1	58	194	one	\N	1	1	0	0	2	1	1	1900-01-01
349	form_blocoFormacao	Formação	43	1	6	229	one	\N	1	1	0	0	2	1	1	1900-01-01
14	matricula	Matrícula	16	1	\N	147	one	\N	1	1	0	0	1	1	1	1900-01-01
332	caixaPessoas	Funcionários Caixa	94	1	\N	335	one	\N	1	1	0	0	1	1	1	1900-01-01
345	form_blprojetoRecursos	-	61	1	57	196	one	\N	1	1	0	0	2	1	1	1900-01-01
346	form_blprojetoRH	-	60	1	57	197	one	\N	1	1	0	0	2	1	1	1900-01-01
6	cadFuncionario	Cadastro de Funcionario	81	1	\N	136	one	\N	1	1	0	0	1	1	1	1900-01-01
9	duplicatas	Duplicatas	17	1	\N	139	one	\N	1	1	0	0	1	1	1	1900-01-01
27	produtosInsumo	Insumos	37	1	\N	161	one	\N	1	1	TProduto/formOutFunction	0	2	1	1	1900-01-01
28	cotacao	Cotação	38	1	\N	0	one	\N	1	1	0	0	2	1	1	1900-01-01
32	formPrivilegios	Privilégios	40	1	\N	0	one	\N	1	1	0	0	2	1	1	1900-01-01
36	formAlunoHistorico	Histórico do Aluno	22	1	\N	0	one	\N	1	1	0	0	2	1	1	1900-01-01
37	demanda	Demanda	16	1	\N	177	one	\N	1	1	0	0	2	1	1	1900-01-01
48	cadmateriais	Materiais Didáticos	53	1	\N	0	one	\N	1	1	0	0	2	1	1	1900-01-01
49	fechamentoCaixa	Fechamento de Caixa	54	1	\N	0	one	\N	1	1	0	0	2	1	1	1900-01-01
61	geraDisciplina	Gera Disciplina	12	1	\N	0	one	\N	1	1	0	0	2	1	1	1900-01-01
62	orientacoesearquivos	Orientações e Arquivos	63	1	\N	0	one	\N	1	1	0	0	2	1	1	1900-01-01
65	pesqExtornoDebito	Extornar Débito	21	1	\N	0	one	\N	1	1	0	0	2	1	1	1900-01-01
260	lancaFaltas	Lançamento de Faltas	25	1	\N	0	one	\N	1	1	0	0	2	1	1	1900-01-01
261	lancaNotas	Lançamento de Notas	27	1	\N	0	one	\N	1	1	0	0	2	1	1	1900-01-01
275	formDevolucaoBiblioteca	Devolução de Livros	87	1	\N	0	one	\N	1	1	0	0	2	1	1	1900-01-01
26	fornecedores	Fornecedores	1	1	\N	160	one	\N	1	1	0	0	1	1	1	1900-01-01
31	formUsuarios	Usuários	26	1	\N	167	one	\N	1	1	0	0	1	1	1	1900-01-01
33	formFerias	Férias	41	1	\N	171	one	\N	1	1	0	0	1	1	1	1900-01-01
34	formSalas	Salas	44	1	\N	174	one	\N	1	1	0	0	1	1	1	1900-01-01
38	solicitacoes	Solicitações	46	1	\N	178	one	\N	1	1	0	0	1	1	1	1900-01-01
39	areaCurso	Áreas de curso	45	1	\N	176	one	\N	1	1	0	0	1	1	1	1900-01-01
40	formCompras	Compras	47	1	\N	179	one	\N	1	1	0	0	1	1	1	1900-01-01
43	formDemanda	Demanda	48	1	\N	185	one	\N	1	1	0	0	1	1	1	1900-01-01
45	dre	DRE	999	1	\N	0	one	\N	1	1	0	0	2	1	1	1900-01-01
351	form_blocoAreasProf	Áreas Relacionadas	75	1	7	232	one	500;150	1	1	0	0	2	1	1	1900-01-01
356	form_blprojetoCusto	-	59	1	57	198	one	\N	1	1	0	0	2	1	1	1900-01-01
357	form_blocQuestinarioQuestoes	-	83	1	89	245	one	\N	1	1	0	0	2	1	1	1900-01-01
358	form_scorecardSentenças	-	78	1	84	239	one	\N	1	1	0	0	2	1	1	1900-01-01
359	form_blocoDepartamentoPessoas	-	14	1	77	224	one	\N	1	1	0	0	2	1	1	1900-01-01
335	form_inforDisciplinasTurma	Detalhes	12	1	5	135	multiple	900;550	1	1	0	0	2	1	1	1900-01-01
420	histCaixa-Movimentacoes	Movimentações	21	1	418	422	one	\N	0	0	0	0	2	1	1	1900-01-01
424	histCliente-Movimentacoes	Histórico	21	1	1	425	one	\N	0	0	0	0	2	1	1	1900-01-01
429	aproveitamentoDisciplina	Informações da Disciplina	100	1	428	430	one	\N	1	1	0	0	2	1	1	1900-01-01
432	processo-AbonoFalta	Processo Acadêmico: Abono de Faltas	22	1	15	0	one	900;500	1	0	0	0	2	1	1	1900-01-01
433	processo-REvalidacaoDiploma	Processo Acadêmico: Revalidação de Diploma	22	1	15	0	one	900;500	1	0	0	0	2	1	1	1900-01-01
434	processo-AproveitamentoDisciplina	Processo Acadêmico: Aproveitamento de Disciplina	22	1	15	0	one	900;500	1	0	0	0	2	1	1	1900-01-01
413	blocoDiscSemelhantes	Disciplinas	97	1	3	417	one	500;250	1	1	0	0	2	1	1	1900-01-01
60	planoAula	Plano de Aula	62	1	397	201	one	\N	1	1	0	0	2	1	1	1900-01-01
66	pesqExtornoCredito	Extornar Crédito	21	1	\N	0	one	\N	1	1	0	0	2	1	1	1900-01-01
68	pesqProdutos	Produtos	70	1	\N	0	one	\N	1	1	0	0	2	1	1	1900-01-01
311	formListaCursosDisponiveis	Cursos Disponíveis	9	1	\N	314	one	\N	1	1	0	0	2	1	1	1900-01-01
324	formDescontosprog	Descontos Progressivos	92	1	\N	0	one	\N	1	1	0	0	2	1	1	1900-01-01
333	movimentoCaixaDebito	Contas a Pagar	21	1	\N	144	one	\N	Baixar conta	1	TCaixa/baixaCaixa	0	2	1	1	1900-01-01
334	form_cobranca	Dados para Cobrança	49	1	71	186	one	\N	1	1	0	0	2	1	1	1900-01-01
337	form_blocoProfAreas	Professores Relacionados	75	1	39	233	one	\N	1	1	0	0	2	1	1	1900-01-01
338	form_blocoParticipantes	Participantes	34	1	22	157	one	\N	1	1	0	0	2	1	1	1900-01-01
339	form_fornecedoresProdutos	Produtos	38	1	26	164	one	\N	1	1	0	0	2	1	1	1900-01-01
340	form_produtoCotacao	Cotação do Produto	38	1	27	162	one	\N	1	1	0	0	2	1	1	1900-01-01
342	form_blocoListaInteresses	Interesses	48	1	1	183	one	\N	1	1	0	0	2	1	1	1900-01-01
343	form_matdidaticos	Lista de Materiais	53	1	87	188	one	\N	1	1	0	0	2	1	1	1900-01-01
344	form_blocoOcorrencia	Ocorrencia	57	1	\N	192	one	\N	1	1	0	0	2	1	1	1900-01-01
347	form_privilegios	-	40	1	32	168	one	\N	1	1	0	0	2	1	1	1900-01-01
352	form_listaContasNegociacao	Contas a receber	65	1	29	210	one	\N	1	1	0	0	2	1	1	1900-01-01
354	form_discCurso	Disciplinas do curso	10	1	4	134	multiple	900;500	1	1	0	0	2	1	1	1900-01-01
360	form_blocoListaDiscAluno	-	56	1	15	225	one	600;300	1	1	0	0	2	1	1	1900-01-01
363	form_blJustFalta	-	25	1	\N	216	one	\N	1	1	0	0	2	1	1	1900-01-01
364	form_blocoContMinistCoord	-	28	1	58	189	one	\N	1	1	0	0	2	1	1	1900-01-01
365	form_listContasTransacaoD	Contas a pagar	65	1	72	215	one	800;550	1	1	0	0	2	1	1	1900-01-01
367	form_dAvaliacao	Avaliações	27	1	59	152	one	\N	1	1	0	0	2	1	1	1900-01-01
368	form_blocolistObsProf	-	28	1	18	282	one	\N	1	1	0	0	2	1	1	1900-01-01
369	form_blocLancamentoNotas	Avaliações	27	1	18	283	one	\N	1	1	0	0	2	1	1	1900-01-01
370	form_blocoContMinistProf	-	28	1	18	279	one	\N	1	1	0	0	2	1	1	1900-01-01
371	form_listContasTransacaoC	Contas	65	1	67	236	one	800;550	1	1	0	0	2	1	1	1900-01-01
372	form_lstProdutosTransacaoC	Produtos	67	1	67	207	one	\N	1	1	0	0	2	1	1	1900-01-01
373	form_blocPessoaConvenios	Lista de convênios	90	1	1	322	one	800;450	1	1	0	0	2	1	1	1900-01-01
374	form_blocDescProgressivos	Descontos	92	1	5	327	one	600;400	1	1	0	0	2	1	1	1900-01-01
375	form_blocOrientacoesArquivos	Orientações e Arquivos	63	1	399	202	one	900;500	1	1	0	0	2	1	1	1900-01-01
376	form_lstProdutosTransacaoD	Produtos	67	1	72	214	one	800;400	1	1	0	0	2	1	1	1900-01-01
378	form_cheques	Cheques	95	1	\N	0	one	600;400	1	1	0	0	2	1	1	1900-01-01
389	formblocMovimentoProgC	Movimentos Programados	21	1	383	382	one	900;550	1	1	0	0	2	1	1	1900-01-01
390	formblocMovimentoProgD	Movimentos Programados	21	1	383	388	one	900;550	1	1	0	0	2	1	1	1900-01-01
392	consolidacaoCaixa	Consolidação de Caixa	21	1	\N	391	one	\N	Baixar conta	1	0	0	2	1	1	1900-01-01
435	processo-atestadoMatricula	Processo Acadêmico: Atestado de Matrícula	22	1	15	0	one	900;500	1	0	0	0	2	1	1	1900-01-01
436	processo-ColacaoGrau	Processo Acadêmico: Colação de Grau em Gabinete	22	1	15	0	one	900;500	1	0	0	0	2	1	1	1900-01-01
437	processo-DestrancamentoMatricula	Processo Acadêmico: Destrancamento de Matrícula	22	1	15	0	one	900;500	1	0	0	0	2	1	1	1900-01-01
438	processo-GuiaTransferencia	Processo Acadêmico: Guia de Transferência	22	1	15	0	one	900;500	1	0	0	0	2	1	1	1900-01-01
439	processo-HistoricoEscolar	Processo Acadêmico: Histórico Escolar	22	1	15	0	one	900;500	1	0	0	0	2	1	1	1900-01-01
440	processo-JustificativaFalta	Processo Acadêmico: Justificativa de Faltas	22	1	15	0	one	900;500	1	0	0	0	2	1	1	1900-01-01
441	processo-ProvaSegundaChamada	Processo Acadêmico: Prova de Segunda Chamada	22	1	15	0	one	900;500	1	0	0	0	2	1	1	1900-01-01
442	processo-REssarcimento	Processo Acadêmico: Ressarcimento para Desistencia	22	1	15	0	one	900;500	1	0	0	0	2	1	1	1900-01-01
428	detAprovDsc	Aproveitamento de Disciplinas	56	1	434	443	one	900;500	1	0	TProcessoAcademico/setAprovDisc	0	2	1	1	1900-01-01
444	justificativaFalta	Justificativa de Falta	25	1	440	445	one	650;400	1	0	0	0	2	1	1	1900-01-01
446	cursosAvaliacoes	Avaliações	101	1	4	447	one	650;400	1	0	0	0	2	1	1	1900-01-01
448	Descontos	Descontos	102	1	320	449	one	350;200	1	1	0	0	2	1	1	1900-01-01
452	turmasConvenios	Convênios	104	1	5	453	one	550;200	1	1	0	0	2	1	1	1900-01-01
462	alunosDisciplinas	Disciplinas	56	1	460	455	one	\N	1	0	0	1	2	1	1	1900-01-01
393	listaDisciplinasCurso	Disciplinas	8	1	354	394	multiple	900;500	1	1	0	0	2	1	1	1900-01-01
461	alunosDisciplinas	Disciplinas	56	1	460	456	one	\N	1	0	0	0	2	1	1	1900-01-01
464	formAvaliacoes	Avaliações	106	1	463	467	one	\N	1	0	0	1	2	1	1	1900-01-01
465	formAvaliacoesRegras	Regras da Avaliação	107	1	464	468	one	\N	1	0	0	1	2	1	1	1900-01-01
366	form_blocLancamentoNotas	Avaliações	27	1	58	263	one	800;400	1	1	0	0	2	1	1	1900-01-01
467	formAvDescricao	Descriminação da Avaliação	108	1	\N	\N	one	\N	1	0	0	1	2	1	1	1900-01-01
468	formAvDescricao	Descriminação da Avaliação	108	1	\N	\N	one	\N	1	0	0	1	2	1	1	1900-01-01
471	processo-TransferenciaExterna	Processo Acadêmico: Transferência Externa	22	1	15	0	one	900;500	1	0	0	0	2	1	1	1900-01-01
472	processo-TransferenciaInterna	Processo Acadêmico: Transferência Interna	22	1	15	0	one	900;500	1	0	0	0	2	1	1	1900-01-01
473	processo-TrancamentoCurso	Processo Acadêmico: Trancamento de Curso	22	1	15	0	one	900;500	1	0	0	0	2	1	1	1900-01-01
431	processo-Abandono	Processo Acadêmico: Abandono de Curso	22	1	15	0	one	900;500	1	0	0	0	2	1	1	1900-01-01
474	usuarioConfig	Configurações de Usuário	26	1	0	0	one	500;200	1	1	0	0	2	1	1	1900-01-01
475	cadcursosConcluido	Projetos de Cursos Concluídos	9	1	\N	242	one	\N	1	1	0	0	2	1	1	1900-01-01
476	form_discCurso	Disciplinas do curso	10	1	475	477	multiple	900;500	1	1	0	0	2	1	1	1900-01-01
480	form_movimentosEstorno	Movimentos da Conta	21	1	478	481	one	\N	1	1	0	0	2	1	1	1900-01-01
482	form_efetivacaoEstorno	Efetivação de Estorno	21	1	\N	\N	one	700;500	1	1	0	0	2	1	1	1900-01-01
486	form_listaBaixaMultipla	Baixa de Multiplas Contas	65	1	484	485	one	\N	0	0	0	0	2	1	1	1900-01-01
341	form_blocoClienteFormacao	Formação Acadêmica	43	1	1	173	one	\N	1	1	0	0	2	1	1	1900-01-01
353	form_discCursoDisp	Disciplinas do Curso	10	1	87	243	one	\N	1	1	0	0	2	1	1	1900-01-01
355	form_requisitosCurso	Pré-requisitos da turma	23	1	5	150	one	700;300	1	1	0	0	2	1	1	1900-01-01
454	processo-RegularizacaoAlunoEspecial	Processo Acadêmico: Regularização de Aluno Especial	22	1	15	0	one	900;500	1	0	0	0	2	1	1	1900-01-01
52	notasAluno	Notas	999	1	\N	0	one	\N	1	1	0	0	2	1	1	1900-01-01
53	faltasAlunos	Faltas	999	1	\N	0	one	\N	1	1	0	0	2	1	1	1900-01-01
403	detalhesConsolidacaoCaixa	Detalhes	999	1	392	391	multiple	\N	0	0	0	0	2	1	1	1900-01-01
404	movimentacaoInterna	Movimentação Interna	999	1	392	391	multiple	500;250	0	0	0	0	2	1	1	1900-01-01
379	detalhamentoCaixa	Detalhamento de Caixa	999	1	\N	144	multiple	800;550	1	1	0	0	2	1	1	1900-01-01
70	pesqContas	Contas	999	1	\N	0	one	\N	1	1	0	0	2	1	1	1900-01-01
336	form_datasDisciplinas	Datas	999	1	\N	\N	one	\N	1	1	0	0	2	1	1	1900-01-01
362	form_blocoContMinistProf	-	999	1	\N	0	one	\N	1	1	0	0	2	1	1	1900-01-01
377	form_blocContasDebito	Contas a Pagar	999	1	\N	0	one	\N	1	1	0	0	2	1	1	1900-01-01
44	balancoPatrimonial	Balanço Patrimonial	32	1	\N	0	one	\N	1	1	0	0	1	1	1	1900-01-01
46	parametros	Parametros do Sistema	50	1	\N	0	one	\N	1	1	0	0	1	1	1	1900-01-01
50	duplicatasAlunos	Boletos	22	1	\N	0	one	\N	1	1	0	0	1	1	1	1900-01-01
51	contasFolhaPag	Folha de Pagamento	55	1	\N	190	one	\N	1	1	0	0	1	1	1	1900-01-01
57	formProjetos	Projetos	58	1	\N	195	one	\N	1	1	setProduto/formOutFunction	0	1	1	1	1900-01-01
59	gerenciamentoTurmas	Gerenciamento de Turmas	12	1	\N	200	one	\N	1	1	0	0	1	1	1	1900-01-01
64	extorno	Extorno de Caixa	64	1	\N	203	one	\N	1	1	0	0	1	1	1	1900-01-01
69	turmasCanceladas	Turmas Canceladas	11	1	\N	209	one	\N	1	1	0	0	1	1	1	1900-01-01
71	gerenciaPessoas	Pessoas	1	1	\N	212	one	\N	1	1	0	0	1	1	1	1900-01-01
72	transacaoD	Transação de Débito	66	1	\N	213	one	\N	1	1	0	0	1	1	1	1900-01-01
74	listaPresenca	Lista de Presença	12	1	\N	217	one	\N	1	1	0	0	1	1	1	1900-01-01
75	cadProdutos	Produtos	70	1	\N	218	one	\N	1	1	0	0	1	1	1	1900-01-01
77	departamentos	Departamentos	74	1	\N	223	one	\N	1	1	0	0	1	1	1	1900-01-01
78	solicitacoesEncaminhadas	Solicitações Encaminhadas	46	1	\N	227	one	\N	1	1	0	0	1	1	1	1900-01-01
79	produtosTurma	Turmas	70	1	\N	228	one	\N	1	1	0	0	1	1	1	1900-01-01
80	listFuncDemitidos	Funcionários Demitidos	14	1	\N	231	one	\N	1	1	0	0	1	1	1	1900-01-01
82	turmasConcluidas	Turmas Concluidas	11	1	\N	234	one	\N	1	1	0	0	1	1	1	1900-01-01
84	scorecard	Scorecard	77	1	\N	238	one	\N	1	1	0	0	1	1	1	1900-01-01
85	cadCursoTipo	Tipos de curso	80	1	\N	240	one	\N	1	1	0	0	1	1	1	1900-01-01
86	alunosInstatseqs	Alunos Instatseqs	56	1	\N	241	one	\N	1	1	0	0	1	1	1	1900-01-01
89	gerenciaQuestionarios	Gerenciar Questionários	82	1	\N	244	one	\N	1	1	0	0	1	1	1	1900-01-01
266	reservaLivros	Lista de Reservas	87	1	\N	268	one	\N	1	1	0	0	1	1	1	1900-01-01
267	devolucaoLivros	Lista de Devoluções	87	1	\N	269	one	\N	1	1	0	0	1	1	1	1900-01-01
273	consultaLivros	Livros	76	1	\N	274	one	\N	1	1	0	0	1	1	1	1900-01-01
405	sec-relatorioTurma	Relatório por Turma	12	1	\N	410	one	\N	0	0	0	0	1	1	1	1900-01-01
406	coord-relatorioTurma	Relatório por Turma	12	1	\N	411	one	\N	0	0	0	0	1	1	1	1900-01-01
407	prof-relatorioTurma	Relatório por Turma	12	1	\N	412	one	\N	0	0	0	0	1	1	1	1900-01-01
418	historicoCaixa	Históricos de Caixa	98	1	\N	419	multiple	\N	0	0	0	0	1	1	1	1900-01-01
47	conciliacaoBancaria	Conciliação Bancaria	17	1	\N	0	one	\N	1	1	0	0	1	1	1	1900-01-01
1	cadclientes	Cadastro de Clientes	1	1	\N	130	one	\N	1	1	0	0	1	1	1	1900-01-01
5	cadturmas	Cadastro de turmas	11	1	\N	133	one	\N	1	1	TTurma/setProduto	0	1	1	1	1900-01-01
18	diarioEletronico	Diário Elentrônico	12	1	\N	193	multiple	\N	0	0	0	0	1	1	1	1900-01-01
21	patrimonios	Patrimonios	32	1	\N	155	one	\N	1	1	TProduto/setProdutoParametro	0	1	1	1	1900-01-01
30	formContratos	Contratos	39	1	\N	166	one	\N	1	1	0	0	1	1	1	1900-01-01
63	viewArquivos	Orientações e Arquivos	63	1	\N	0	one	\N	1	1	0	0	1	1	1	1900-01-01
83	biblioteca	Biblioteca	76	1	\N	237	one	\N	1	1	TProduto/setProdutoParametro	0	1	1	1	1900-01-01
87	cursosDisponiveis	Cursos Disponiveis	9	1	\N	242	one	\N	1	1	0	0	1	1	1	1900-01-01
320	cadconvenios	Convênios	89	1	\N	321	one	\N	1	1	0	0	1	1	1	1900-01-01
328	alunosListaLivros	Livros	76	1	\N	331	one	900;550	0	0	0	0	1	1	1	1900-01-01
380	form_listacheques	Lista de Cheques	95	1	\N	381	one	\N	1	1	0	0	1	1	1	1900-01-01
383	formMovimentosProgramados	Movimentos Programados	21	1	\N	144	multiple	\N	0	1	0	0	1	1	1	1900-01-01
397	listaDisciplinasPlanoAulaProfessor	Disciplinas	12	1	\N	398	one	900;500	0	0	0	0	1	1	1	1900-01-01
426	Recados	Anotações	99	1	\N	427	one	\N	1	1	0	0	1	1	1	1900-01-01
29	formNegociacao	Negociação	66	1	\N	163	one	\N	0	0	0	0	1	1	1	1900-01-01
3	caddisciplinas	Cadastro de Disciplinas	8	1	\N	131	one	\N	1	1	0	0	1	1	1	1900-01-01
4	cadcursos	Projeto de Curso	9	1	\N	132	one	\N	1	1	0	0	1	1	1	1900-01-01
10	contasCaixa	Conta Caixa	18	1	\N	140	one	\N	1	1	0	0	1	1	1	1900-01-01
7	cadProfessor	Cadastro de Professor	15	1	\N	137	one	\N	1	1	0	0	1	1	1	1900-01-01
15	formAlunoHistAcademico	Histórico Acadêmico	22	1	\N	148	one	\N	0	0	0	0	1	1	1	1900-01-01
463	formGradeAvaliacoes	Grade de Avaliações	105	1	\N	466	one	\N	1	0	0	0	1	1	1	1900-01-01
469	formNotasAlunos	Notas de Alunos	109	1	\N	\N	one	\N	1	0	0	1	1	1	1	1900-01-01
67	transacaoC	Transação de Crédito	66	1	\N	206	one	\N	1	1	0	0	1	1	1	1900-01-01
478	form_estorno	Estorno de Caixa	65	1	\N	\N	one	900;500	0	1	0	0	1	1	1	1900-01-01
483	form_consolidacaoNotasFrequencias	Consolidação de Notas e Frequências	12	1	\N	\N	one	800;500	0	0	0	0	1	1	1	1900-01-01
487	form_alteraDataConta	Alteração de Data da Conta	65	1	\N	488	one	500;200	1	1	TTransacao/limpaInformacoesBoleto	0	1	1	1	1900-01-01
484	form_baixaMultiplasContas	Baixa de Multiplas Contas	65	1	\N	\N	multiple	900;500	0	1	0	0	1	1	1	1900-01-01
16	listaProdutos	Cursos	11	1	\N	149	one	\N	1	1	0	0	1	1	1	1900-01-01
13	movimentoCaixaCredito	Contas a Receber	21	1	\N	144	one	\N	Baixar Conta/2	1	TCaixa/baixaCaixa	0	1	1	1	1900-01-01
41	relatorioCaixa	Relatório de Caixa	21	1	\N	0	one	\N	1	1	0	0	1	1	1	1900-01-01
76	solicitacoesAlun	Solicitações	46	1	\N	222	one	\N	1	1	0	0	1	1	1	1900-01-01
270	bibliotecaCdu	Classificação CDU	86	1	\N	271	one	600;200	1	1	0	0	1	1	1	1900-01-01
399	listaDIsciplinasOrientacoesArquivos	Disciplinas	12	1	\N	402	one	900;500	0	0	0	0	1	1	1	1900-01-01
459	formAlunoHistFinanceiro	Histórico Financeiro	22	1	0	457	one	\N	0	0	0	0	1	1	1	1900-01-01
460	formAlunoProcAcademico	Processos Acadêmicos	22	1	0	458	one	\N	0	0	0	0	1	1	1	1900-01-01
25	inadiplencia	Inadimplência	999	1	\N	159	one	\N	1	1	0	0	1	1	1	1900-01-01
54	HistAcadem	Histórico Acadêmico	999	1	\N	0	one	\N	1	1	0	0	1	1	1	1900-01-01
264	locacaoLivros	Lista de Locações	999	1	\N	265	multiple	\N	1	1	0	0	1	1	1	1900-01-01
11	contasDebito	Contas a pagar	999	1	\N	141	one	\N	1	1	0	0	1	1	1	1900-01-01
12	contasCredito	Contas a receber	999	1	\N	142	one	\N	1	1	0	0	1	1	1	1900-01-01
58	diarioCoordenacao	Diario Coordenacao	12	1	\N	199	one	700;500	1	1	0	0	1	1	1	1900-01-01
395	listaDisciplinasTurma	Disciplinas	10	1	335	396	multiple	900;500	1	1	0	0	1	1	1	1900-01-01
2	form_telefones	Telefones	3	1	1	6	one	400;200	1	1	0	0	2	1	1	2013-08-21
90	cursosativos	Cursos Ativos	85	1	\N	259	one	\N	1	1	0	0	1	1	1	1900-01-01
350	form_blocoFormProf	Formação	43	1	7	230	one	\N	1	1	0	0	2	1	1	1900-01-01
361	form_listTreinamento	-	34	1	\N	191	one	\N	1	1	0	0	2	1	1	1900-01-01
8	fichaInscricao	Ficha de inscrição	16	1	\N	138	one	\N	0	1	0	0	1	1	1	1900-01-01
450	transacoesConvenios	Convênios	103	1	67	451	one	550;200	1	1	0	0	2	1	1	1900-01-01
\.


--
-- TOC entry 2358 (class 0 OID 16566)
-- Dependencies: 197 2373
-- Data for Name: lista; Type: TABLE DATA; Schema: public; Owner: -
--

COPY lista (seq, tipo, formseq, filtropai, pesquisa, lista, label, tabseq, listseq, obapendice, acfiltro, acincluir, nivel, acdeletar, aceditar, acviews, acenviar, filtro, trigger, formainclude, incontrol, acreplicar, acselecao, ordem, aclimite, required, usuaseq, unidseq, statseq, datacad) FROM stdin;
319	form	193	0	0	listlivrosDisponiveis	Livros Disponíveis	76	315	-	0	0	2	0	0	0	0	pessseq/is/AND/null	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
175	pesq	175	seq	lotacao=seq,sala=seq	ListaPesquisaSalas	Salas	44	175	-	1	0	2	0	0	0	1	statseq/=/AND/1;salaaula/=/AND/1	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
277	pesq	273	seq	livrseq=livrseq	pesqListaLivros	Livros disponiveis para Locação	76	277	-	1	0	2	0	0	0	1	pessseq/is/AND/null	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
282	form	368	tudiseq	0	listaObs	Observações	28	193	-	0	0	2	0	0	0	0	obs/!=/AND//	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
177	form	37	pessseq	0	ListaDemanda	Demanda	16	0	-	1	0	2	0	0	1	0	\N	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
236	form	371	transeq	0	listaTransacaoContasView	Contas a receber	65	206	-	0	0	2	0	1	1	0	tipo/=/AND/C;stpaseq/in/AND/(1,3)	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
201	form	60	tudiseq	0	listPlanoAula	Plano de Aula	62	398	-	1	Novo Registro	2	1	1	1	0	profseq/=/AND/TUsuario/getSeqProfessor	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
204	pesq	65	seq	contaorigem=parcseq	pesqExtornoDebito	Extornar Débito	21	204	-	0	0	2	0	0	1	1	valortotal/</AND/0;statseq/=/AND/1	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
205	pesq	66	seq	contaorigem=parcseq	pesqExtornoCredito	Extornar Crédito	21	205	-	0	0	2	0	0	1	1	valortotal/</AND/0;statseq/=/AND/1	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
226	pesq	61	0	tudiseq=seq,obs=seq	pesqTurmaDisciplina	Disciplinas	12	226	-	1	0	2	0	0	0	1	\N	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
230	form	350	pessseq	0	blocFormProf	Formação	43	137	-	0	0	2	0	\N	\N	0	\N	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
323	pesq	320	seq	convseq=seq,pjcuseqLabel=nome	pesqConvenios	Convênios	89	323	-	1	0	2	0	0	0	1	\N	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
229	form	349	pessseq	0	blocoFormFunc	Formação	43	136	-	0	Novo Registro	2	1	1	0	0	\N	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
245	form	357	questseq	0	listaQuestionarioQuestoes	Questões	83	244	-	0	Novo Registro	2	1	1	1	0	\N	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
195	form	57	seq	0	listaProjetos	Projetos em Andamento	58	195	-	1	Novo Registro	2	1	1	1	0	\N	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
161	form	27	seq	0	listaProdutos	Insumos	37	161	-	1	Novo Registro	2	1	1	1	0	\N	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
239	form	358	codigoscorecard	0	scorecardSentencas	Sentenças a Analisar	78	238	-	0	Nova Sentença	2	1	1	1	0	\N	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
447	form	446	cursseq	0	avaliacaoes	Avaliações	101	132	-	1	1	2	1	1	1	0	statseq/!=/AND/9/numeric	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
172	pesq	6	0	pessseq=seq,pessseqLabel=pessnmrz	listaPesqFuncionarios	Pessoa	1	172	-	1	0	2	0	0	0	1	\N	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
423	pesq	15	seq	alunseq=seq,alunseqLabel=nomepessoa	listaAlunos-pesq	Alunos	22	423	-	1	0	2	0	0	0	1	statseq/!=/AND/9/numeric	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
422	form	420	histseq	0	listaHisCaixaMov	Movimentações por Período	21	419	-	1	0	2	0	0	0	0	statseq/!=/AND/9/numeric	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
417	form	413	0	1	discSemelhantes	Disciplinas	97	417	-	1	1	2	1	1	0	0	statseq/!=/AND/9/numeric	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
394	form	393	0	0	listaDisciplinas	Disciplinas	8	394	TCurso/buttonAddCursoDisciplina	1	0	2	0	0	0	0	statseq/!=/AND/9/numeric	\N	one	\N	0	1	seq/desc	1	\N	1	1	1	1900-01-01
278	pesq	273	seq	livrseq=livrseq	pesqReservaLivros	Livros	76	278	-	1	0	2	0	0	0	1	statseq/!=/AND/9/numeric	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
235	pesq	54	tudiseq	avalseq=seq	pesqAvaliacao	Avaliações	27	235	-	0	0	2	0	0	0	1	statseq/=/AND/1/numeric	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
221	pesq	7	seq	profseq=seq	pesqProfessor	Professores	15	221	-	1	0	2	0	0	0	1	statseq/=/AND/1/numeric	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
219	pesq	71	seq	pessseq=seq,pessseqLabel=pessnmrz	pesqPessoa	Pessoas	1	219	-	1	0	2	0	0	0	1	statseq/=/AND/1/numeric	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
211	pesq	70	parcseq	parcseq=seq,pessseq=pessseq,valornominal=valornominal,vencimento=vencimento,parcseqcd=seq,pessseqcd=pessseq,valornominalcd=valornominal,vencimentocd=vencimento	pesqContas	Contas	65	211	-	1	0	2	0	0	0	1	statseq/=/AND/1/numeric	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
181	pesq	27	seq	prodseq=seq,prodseqLabel=seq	listaPesqProdut	Insumos	37	181	-	1	0	2	0	0	0	1	statseq/=/AND/1/numeric	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
180	pesq	28	seq	prodseq=prodseq,nomefornecedor=pessseq,valorunitario=preco,tempoentrega=entrega	listaPesqCotacao	Cotação	38	180	-	1	0	2	0	0	0	1	statseq/=/AND/1/numeric	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
170	pesq	5	seq	prodseq=seq	listaPesqProdutos	Insumos	11	170	-	1	0	2	0	0	0	1	statseq/=/AND/1/numeric	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
194	form	348	tudiseq	0	lsitObs	Observações	28	199	-	0	0	2	0	0	0	0	obs/!=/AND//string	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
455	pesq	462	alunseq	discseq_antiga=seq,discseq_antigaLabel=nomedisciplina	listaDiscAluno	Disciplinas	56	458	-	1	0	2	0	0	0	1	stadseq/=/AND/2/numeric	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
310	pesq	310	pjcuseq	pjcuseq=seq,pjcuseqLabel=nome	pesqCursosConcluidos	Cursos Disponíveis	9	310	-	1	0	2	0	0	0	1	statseq/!=/AND/8;statseq/!=/AND/9	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
168	form	347	usuaseq	0	listaPrivilegios	Privilégios	40	167	-	1	Novo Privilegio	2	1	1	1	0	\N	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
173	form	341	pessseq	0	listaClienteFormacao	Formação Acadêmica	43	130	-	0	Novo Registro	2	1	1	1	0	\N	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
183	form	342	pessseq	0	listaDemandaCliente	Interesses	48	130	-	0	Novo Registro	2	1	1	1	0	\N	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
232	form	351	profseq	0	relAreaProfessor	Áreas Relacionadas	75	137	-	0	Novo Registro	2	1	0	0	0	\N	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
225	form	360	alunseq	0	listaDiscAluno	Disciplinas	56	148	-	0	0	2	0	1	0	0	\N	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
224	form	359	deptseq	0	listPessoasDep	Funcionários	14	223	-	0	0	2	0	0	0	0	\N	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
233	form	337	arcuseq	0	relProfAreas	Professores Relacionados	75	176	-	0	Novo Registro	2	1	0	0	0	\N	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
216	form	363	discseq	0	listaJustFalta	Faltas Lançadas	25	216	-	0	0	2	0	1	0	0	\N	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
215	form	365	transeq	0	listaContasTransacao	Contas a Pagar	65	213	-	1	0	2	0	1	0	0	\N	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
202	form	375	tudiseq	0	listArquivos	Arquivos	63	402	-	0	Novo Registro	2	1	1	0	0	\N	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
198	form	356	projseq	0	listProjetoCustos	Custos	59	195	-	0	Novo Registro	2	1	1	1	0	\N	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
197	form	346	projseq	0	listProjetoRH	Recursos Humanos	60	195	-	0	Novo Registro	2	1	1	1	0	\N	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
196	form	345	projseq	0	listProjetoRecursos	Recursos	61	195	-	0	Novo Registro	2	1	1	1	0	\N	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
192	form	344	funcseq	0	listaOcorrencias	Ocorrências	57	136	-	0	Novo Registro	2	1	1	0	0	\N	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
191	form	361	funcseq	0	listaTreinFunc	Treinamentos	34	136	-	0	0	2	0	0	0	0	\N	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
189	form	364	tudiseq	0	listaConteudo	Conteudo Ministrado	28	199	-	0	Novo Registro	2	1	1	0	0	\N	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
188	form	343	tudiseq	0	listaMateriais	Materiais Didáticos	53	132	-	0	Novo Registro	2	1	1	1	0	\N	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
186	form	334	pessseq	0	listaopCobranca	Opção de Cobrança	49	130	-	\N	Novo Registro	2	1	1	1	0	\N	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
164	form	339	pessseq	0	listaProdutosFornecedor	Insumos	38	160	-	0	Novo Produto	2	1	1	1	0	\N	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
162	form	340	prodseq	0	listaCotacao	Cotação	38	161	-	0	Nova Cotação	2	1	1	1	0	\N	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
157	form	338	funcseq	0	listaParticipantes	Participantes	34	156	-	0	Novo Participante	2	1	1	1	0	\N	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
150	form	355	turmseq	0	listaRequisitos	Pré Requisitos	23	133	-	0	Novo Registro	2	1	1	1	0	\N	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
135	form	335	turmseq	0	turmaDisciplinas	Disciplinas da turma	12	133	TTurma/getCargaHoraria	0	Associar disciplina	2	1	0	0	0	\N	\N	multiple	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
279	form	370	tudiseq	0	listaConteudo	Conteudo Ministrado	28	193	-	0	Novo Registro	2	1	1	0	0	\N	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
283	form	369	tudiseq	0	listaAvaliacoes	Avaliações	27	193	-	0	0	2	0	1	0	0	\N	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
322	form	373	pessseq	0	listaConvenios	Convênios	90	130	-	0	Relacionar novo convênio	2	1	0	0	0	\N	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
327	form	374	turmseq	0	listDescontos	Faixas de Desconto	92	133	-	0	Novo Registro	2	1	1	1	0	\N	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
208	pesq	68	seq	valornominal=valor,prodseq=seq,tabelaproduto=tabela	pesqProdutosC	Produto	70	208	-	1	1	2	1	0	0	1	tpprseq/!=/AND/10004330-830	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
134	form	354	pjcuseq	0	listDisciplinas	Disciplinas	10	132	TCurso/getCargaHoraria	0	Adicionar Disicplinas	2	1	0	0	0	\N	\N	multiple	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
468	form	465	avalseq	0	listaRegrasAvaliacoes	Regras da Avaliação	107	467	-	1	1	2	1	1	0	0	statseq/!=/AND/9/numeric	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
467	form	464	gdavseq	0	listaAvaliacoes	Avaliações	106	466	-	1	1	2	1	1	0	0	statseq/!=/AND/9/numeric	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
453	form	452	turmseq	0	listaTurmaConvenios	Convênios	104	5	-	0	1	2	1	1	0	0	statseq/!=/AND/9/numeric	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
451	form	450	transeq	0	listaTransacConvenios	Convênios	103	206	-	0	1	2	1	1	0	0	statseq/!=/AND/9/numeric	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
449	form	448	convseq	0	lsitaDescontos	Descontos	102	321	-	0	1	2	1	1	1	0	statseq/!=/AND/9/numeric	\N	one	\N	0	0	dialimite/asc	1	\N	1	1	1	1900-01-01
263	form	366	tudiseq	0	listaAvaliacoes	Avaliações	27	199	-	0	0	2	0	1	0	0	statseq/!=/AND/9/numeric	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
321	form	320	0	0	listaConvenios	Convênios	89	321	-	1	Novo convênio	1	1	1	1	0	\N	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
335	form	332	0	0	pessoasCaixa	Funcionários Caixa	94	335	-	1	Novo Registro	1	1	1	1	0	\N		one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
485	form	486	0	0	listBaixaMultiplaCredito	Contas de Crédito	65	485	-	1	0	2	0	0	0	0	tipo/=/AND/C;stpaseq/in/AND/(1,3)	\N	one	\N	0	1	datacad/desc;seq/desc	1	\N	1	1	1	1900-01-01
398	form	397	0	0	discsPlanoAul	Disciplinas	12	398	-	1	0	1	0	1	0	0	profseq/=/AND/TUsuario/getSeqProfessor	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
165	pesq	165	seq	pessseq=seq,pessseqLabel=seq,nomefornecedor=pessnmrz	listaPesqFornecedores	Fornecedores	1	165	-	1	0	2	0	0	0	1	fornecedor/=/AND/true;statseq/=/AND/1	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
382	form	389	0	0	listaMovimentosProgramadosC	Movimentos de crédito programados	21	382	-	0	0	2	1	1	0	0	tipo/=/AND/C;stmoseq/=/AND/3;funcseq/=/AND/TUsuario/getSeqFuncionario	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
388	form	390	0	0	listaMovimentosProgramadosD	Movimentos de débitos programados	21	388	-	0	0	2	1	1	0	0	tipo/=/AND/D;stmoseq/=/AND/3;funcseq/=/AND/TUsuario/getSeqFuncionario	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
481	form	480	parcseq	0	listaMovimentosEstorno	Movimentações	21	478	TCaixa/apendiceMovimentosEstorno	1	0	2	0	0	0	0	stmoseq::bigint/in/AND/(1,2,5)	\N	one	\N	0	1	datacad/desc	1	\N	1	1	1	1900-01-01
210	form	352	transeq	0	listaContasTransac	Contas a receber	65	210	TTransacao/apendiceContasNegociacao	1	0	2	0	0	0	0	tipo/=/ANC/C;stpaseq/in/AND/(1,3)	\N	one	\N	0	1	seq/desc	1	\N	1	1	1	1900-01-01
213	form	72	0	0	formTransacaoD	Transações a pagar	66	213	-	1	Gerar Transação	1	1	1	1	0	valortotal/</AND/0	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
243	form	3	cursseq	0	listaDisciplinas	Disciplinas	10	242	-	0	0	2	0	0	0	0	\N	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
214	form	376	transeq	0	addProdutosD	Produtos	67	214	TTransacao/viewValorTotal	0	Novo Produto	2	1	0	1	0	\N	setValorTotalTransacao()	one	transacaoProdutos	0	0	seq/desc	1	\N	1	1	1	1900-01-01
207	form	372	transeq	0	addProdutosC	Produtos	67	206	TTransacao/viewValorTotal	0	Novo Produto	2	1	0	1	0	\N	setValorTotalTransacao()	one	transacaoProdutos	0	0	seq/desc	1	\N	1	1	1	1900-01-01
159	form	25	seq	0	listaInadimplencia	Inadimplências	999	159	-	1	0	2	0	0	1	0	vencimento/</AND/TSetData/getData	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
152	form	367	tudiseq	0	listaAvaliacao	Avaliações	27	200	-	1	Novo Registro	2	1	1	1	0	\N	\N	one	\N	0	0	ordem/asc	1	\N	1	1	1	1900-01-01
133	form	5	seq	0	listaTurma	Turmas	11	133	-	1	Nova Turma	1	1	1	1	0	\N	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
200	form	59	0	0	listGerenciaTurmas	Gerenciamento de Disciplinas	12	200	-	1	0	1	0	1	1	0	\N	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
218	form	75	0	0	listaProdutos	Produtos	70	218	-	1	Novo Produto	1	1	1	1	0	label/!=/AND/Taxa de inscrição;tabela/!=/AND/dbturmas;tabela/!=/AND/dbtransacoes_contas;	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
147	form	14	seq	0	listaMatricula	Alunos Inscritos	16	147	-	1	0	1	0	1	0	0	statseq/!=/AND/9;pessseq/is not/AND/null	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
138	form	8	seq	0	listaInscritos	Inscritos	16	138	-	1	Nova Inscrição	1	1	0	0	0	statseq/!=/AND/9;pessseq/is not/AND/null	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
470	form	469	seq	0	listaNotasAlunos	Notas de Alunos	109	470	-	1	0	1	0	0	0	0	statseq/!=/AND/9/numeric	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
443	form	428	alunseq	0	listaADisciplinasAproveitamento	Disciplinas	56	443	-	0	0	2	0	1	0	0	statseq/!=/AND/9/numeric	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
430	form	429	aldiseq	0	aproveitamento	Aproveitamentos	100	430	-	1	1	2	1	1	1	0	statseq/!=/AND/9/numeric	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
427	form	426	0	0	anotacoes	Anotações	99	427	-	1	1	1	1	1	1	0	statseq/!=/AND/9/numeric	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
425	form	424	pessseq	0	listaMov-Cliente	Movimentações	21	425	-	0	0	2	0	0	0	0	statseq/!=/AND/9/numeric	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
419	form	418	0	0	historicoCaixa	Históricos de Caixa	98	419	-	1	0	1	0	0	1	0	statseq/!=/AND/9/numeric	\N	multiple	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
412	form	407	0	0	prof-relatorioTurma	Disciplinas	12	412	-	1	0	1	0	0	1	0	statseq/!=/AND/9/numeric	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
411	form	406	0	0	coord-relatorioTurma	Disciplinas	12	411	-	1	0	1	0	0	1	0	statseq/!=/AND/9/numeric	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
410	form	405	0	0	sec-relatorioTurma	Disciplinas	12	410	-	1	0	1	0	0	1	0	statseq/!=/AND/9/numeric	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
331	form	328	0	0	alunoListaLivros	Livros 	76	331	-	1	0	1	0	0	0	0	statseq/!=/AND/9/numeric	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
132	form	4	seq	0	listaCursos	Projetos de Curso	9	132	-	1	Novo Registro	1	1	1	1	0	turmas/=/AND/0/numeric	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
445	form	444	alunseq	0	faltas	Faltas	25	445	-	1	0	2	0	1	0	0	situacao/=/AND/F/string	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
141	form	11	seq	0	listaContasDebito	Contas a pagar	65	141	-	1	0	1	0	0	0	0	tipo/=/AND/D;stpaseq/=/AND/1	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
193	form	18	seq	0	listaProgDisciplinaProf	Disciplinas	12	193	-	1	0	1	0	0	0	0	profseq/=/AND/TUsuario/getSeqProfessor	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
402	form	399	0	0	discOrienArq	Disciplinas	12	402	-	1	0	1	0	1	0	0	profseq/=/AND/TUsuario/getSeqProfessor	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
160	form	26	seq	0	listaFornecedores	Fornecedores	1	160	-	1	Novo Registro	1	1	1	1	0	fornecedor/=/AND/true	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
391	form	392	0	0	consolidacaoCaixa	Consolidação de Caixa	21	391	TCaixa/viewCalcCaixaConsolidacao	1	0	1	0	0	1	0	stmoseq/=/OR/1;stmoseq/=/OR/2;	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
171	form	33	seq	0	listaFerias	Férias	41	171	-	0	Novo Registro	1	1	1	1	0	\N	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
167	form	31	seq	0	listaUsuarios	Usuários	26	167	-	1	Novo Usuario	1	1	1	1	0	\N	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
176	form	39	seq	0	ListaAreas	Áreas de Cursos	45	176	-	1	Novo Registro	1	1	1	1	0	\N	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
178	form	38	seq	0	listaSolicitacoes	Solicitações	46	178	-	1	Novo Registro	1	1	1	1	0	\N	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
240	form	85	seq	0	listaTipoCursos	Tipos de curso	80	240	-	1	Novo Registro	1	1	1	1	0	\N	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
223	form	77	seq	0	listaDepartamentos	Departamentos	74	223	-	1	Novo Registro	1	1	1	1	0	\N	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
217	form	74	seq	0	listaPresenca	Presença	12	217	-	1	0	1	0	0	0	0	\N	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
158	form	24	seq	0	listaFiliais	Filiais	35	158	-	0	Novo Registro	1	0	1	1	0	\N	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
156	form	22	seq	0	listaTreinamentos	Treinamentos	33	156	-	1	Novo Registro	1	1	1	1	0	\N	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
155	form	21	seq	0	listaPatrimonios	Patrimônios	32	155	-	1	Novo Registro	1	1	1	1	0	\N	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
154	form	20	seq	0	listaCurriculos	Currículos	30	154	-	1	Novo Registro	1	1	1	1	0	\N	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
136	form	6	seq	0	listaFuncionarios	Funcionários	81	136	-	1	Novo Registro	1	1	1	1	0	\N	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
151	form	17	seq	0	listaContasCaixa	Contas Caixa	24	151	-	1	Novo Registro	1	1	1	1	0	\N	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
231	form	80	seq	0	ListaFuncionariosDemitidos	Funcionários Demitidos	14	231	-	1	0	1	0	0	0	0	situacao/=/AND/3	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
242	form	475	seq	0	listaCursosDisponiveis	Projeto de Curso Concluído	9	242	-	1	0	1	0	1	0	0	turmas/>/AND/0	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
381	form	380	0	1	listaCheques	Cheques	95	381	-	1	0	1	0	0	0	0	\N	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
234	form	82	seq	0	listaTurmasConcluidas	Turmas Concluidas	11	234	-	1	0	1	0	0	0	0	sttuseq/=/AND/4	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
209	form	69	seq	0	listaTurmaCancelada	Turmas Canceladas	11	209	-	1	0	1	0	0	0	0	sttuseq/=/AND/3	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
142	form	12	seq	0	listaContasCredito	Contas a receber	65	142	-	1	0	1	0	0	0	0	tipo/=/AND/C;stpaseq/in/AND/(1,3)	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
222	form	76	seq	0	listaSolicitacoesAluno	Solicitações	46	222	-	1	Novo Registro	1	1	1	1	0	alunseq/=/AND/TUsuario/getSeqAluno	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
457	form	459	seq	0	listaAlunosHistFinanceiro	Alunos	22	148	-	1	0	1	1	0	0	0	statseq/!=/AND/9/numeric	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
458	form	460	seq	0	listaAlunosProcAcademico	Alunos	22	148	-	1	0	1	1	0	0	0	statseq/!=/AND/9/numeric	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
466	form	463	seq	0	listaGradeAvaliacoes	Grade de Avaliações	105	466	-	1	1	1	1	1	0	0	statseq/!=/AND/9/numeric	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
274	form	273	seq	0	listaLivros	Livros	76	274	-	1	0	1	0	0	0	0	statseq/!=/AND/9/numeric	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
130	form	1	seq	0	listaClientes	Clientes	1	130	-	1	Novo Registro	1	1	1	1	0	cliente/=/AND/true/boolean	\N	one	\N	0	0	pessnmrz/asc	1	\N	1	1	1	1900-01-01
259	form	90	seq	0	listaCursosstatseqs	Referencia de Curso	85	259	-	1	Novo curso	1	0	1	1	0	statseq/=/AND/1/numeric	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
244	form	89	seq	0	listaQuestionarios	Questionários	82	244	-	1	Novo Registro	1	1	1	1	0	statseq/=/AND/1/numeric	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
479	form	478	seq	0	listaContasEstorno	Lista de Contas com Movimento de Caixa	65	478	-	1	0	1	0	1	0	0	stpaseq/in/AND/(2,3)/numeric	\N	one	\N	0	0	datacad/desc;seq/desc	1	\N	1	1	1	1900-01-01
268	form	266	seq	0	listaReservas	Reservas	87	268	-	1	Nova Reserva	1	0	0	1	0	stlvseq/=/AND/2/numeric	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
265	form	264	seq	0	listaLocacoes	Locações	87	265	-	1	Nova Locação	1	0	0	0	0	stlvseq/=/AND/1/numeric	\N	multiple	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
144	form	333	seq	0	listaMovimentoCaixa	Movimento de caixa	21	144	TCaixa/viewCalcCaixa	1	0	1	1	0	0	0	stmoseq/=/AND/1;statseq/=/AND/1;funcseq/=/AND/TUsuario/getSeqFuncionario	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
163	form	29	seq	0	listaCreditoNegociacao	Negociação de Contas a Receber	66	163	-	1	0	1	0	1	0	0	valortotal/>/AND/0;numparcelasabertas/>/AND/0	\N	multiple	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
206	form	67	seq	0	formTransacaoC	Transações de Crédito	66	206	-	1	Novo	1	1	1	1	0	valortotal/>/AND/0	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
166	form	30	seq	0	listaContratos	Contratos e Convênios	39	166	-	1	Novo Registro	1	1	1	1	0	\N	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
179	form	40	seq	0	listaCompras	Compras	47	179	-	1	Novo Registro	1	1	1	1	0	\N	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
238	form	84	seq	0	socrecard	Scorecard	77	238	-	1	Novo Relatório	1	1	1	1	0	\N	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
237	form	83	seq	0	listaBibliotecaLivros	Livros	76	237	TEtiquetas/apendiceEtiquetasLivros	1	Novo Registro	1	1	1	1	0	\N	\N	one	\N	1	0	seq/desc	1	\N	1	1	1	1900-01-01
228	form	79	seq	0	listaProdutosTurma	Turmas	11	228	-	1	0	1	0	0	0	0	\N	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
212	form	71	seq	0	listaPessoas	Pessoas	1	212	-	1	Novo Registro	1	1	1	1	0	\N	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
203	form	64	seq	0	listExtornos	Extornos de Caixa	64	203	-	1	Lançar Extorno	1	1	1	1	0	\N	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
199	form	58	seq	0	listaProgDisciplinaCoord	Disciplinas	12	199	-	1	0	1	0	0	0	0	\N	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
190	form	51	seq	0	listaFolhaPag	Folha de Pagamento	55	190	-	1	0	1	0	0	0	0	\N	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
185	form	43	seq	0	listaDemanda	Demanda	48	185	-	1	0	1	0	0	0	0	\N	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
174	form	34	seq	0	listaSalas	Salas	44	174	-	1	Novo Registro	1	1	1	1	0	\N	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
271	form	270	seq	0	listaClassificacaoCdu	Classificações CDU	86	271	-	1	Nova Classificação	1	1	1	1	0	\N	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
241	form	86	seq	0	listAlunosInstatseqs	Alunos Inativos	56	241	-	1	0	1	0	0	0	0	stadseq/=/AND/3	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
182	pesq	33	0	turmseq=seq,nomecurso=nomecurso,valortaxa=valortaxa,valormatricula=valormensal,numparcelas=numparcelas,valorparcelas=valormensal,valordescontado=valordescontado,datainicio=datainicio,vencimentomatricula=datainicio,vencimentotaxa=datainicio	listaProdutosInscricao	Turmas Abertas	11	182	-	1	0	2	0	0	0	1	sttuseq/!=/AND/3;sttuseq/!=/AND/4;sttuseq/=/AND/1	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
227	form	78	seq	0	listaSolicitacoesEncaminhadas	Solicitações Encaminhadas	46	227	-	1	0	1	0	1	0	0	pessseq/=/AND/TUsuario/getSeqPessoa	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
139	form	9	seq	0	listaDuplicatas	Duplicatas	17	139	-	1	Novo Registro	1	1	1	1	0	\N	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
140	form	10	seq	0	listaContas	Contas	18	140	-	1	Novo Registro	1	1	1	1	0	\N	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
137	form	7	seq	0	listaProfessores	Professores	15	137	-	1	Novo Registro	1	1	1	1	0	\N	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
131	form	3	seq	0	listaDisciplinas	Disciplinas	8	131	-	1	Novo Registro	1	1	1	1	0	\N	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
153	form	19	seq	0	listaCargos	Cargos	29	153	-	1	Novo Registro	1	1	1	1	0	\N	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
149	form	5	seq	0	listaProdutos	Turmas Abertas	11	149	-	1	0	1	0	0	1	0	\N	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
148	form	15	seq	148	listaAlunosHistAcademico	Alunos	22	148	-	1	0	1	1	0	0	0	\N	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
143	pesq	1	seq	pessseq=seq,pessseqLabel=pessnmrz	listaPesqCliente	Clientes	1	143	-	1	0	2	0	0	0	1	cliente/=/AND/true;statseq/=/AND/1	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
145	pesq	145	0	parcseq=seq,parcseqLabel=seq,pessseq=pessseq,valorreal=valoratual,valorrealview=valoratual,vencimento=vencimento,plcoseq=plcoseq,transeq=transeq,tipo=tipo	listaContasCredito	Contas a Receber	65	145	-	1	0	2	0	0	0	1	tipo/=/AND/C/string;stpaseq/in/AND/(1,3,5)/numeric	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
6	form	2	pessseq	0	listaTelefones	Lista de Telefones	3	130	-	1	1	2	1	1	0	0	statseq/!=/AND/9/numeric	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	2013-08-21
187	pesq	3	seq	discseq=seq,disiseqLabel=titulo	pesqDisciplina	Disciplinas	8	187	-	1	0	2	0	0	0	1	statseq/=/AND/1/numeric	\N	oneone	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
456	pesq	461	alunseq	discseq_nova=seq,discseq_novaLabel=nomedisciplina	listaDiscAluno	Disciplinas	56	458	-	1	0	2	0	0	0	1	stadseq/=/AND/1/numeric	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
396	form	395	0	0	listaDisciplinasTurma	Disciplinas	10	395	TTurma/buttonAddTurmaDisciplina	1	0	2	0	0	0	0	pjcuseq/=/AND/TTurma/getCursoSeq/1/numeric	\N	one	\N	0	1	seq/desc	1	\N	1	1	1	1900-01-01
269	form	267	seq	0	listaDevolucoes	Devoluções	87	269	-	1	0	1	0	0	0	0	stlvseq/=/AND/1/numeric	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
146	pesq	11	0	parcseq=seq,parcseqLabel=seq,pessseq=pessseq,valorreal=valoratual,valorrealview=valoratual,valorpago=valoratual,vencimento=vencimento	listaPesqCDebito	Contas a Pagar	65	146	-	1	0	2	0	0	0	1	tipo/=/AND/D;stpaseq/=/AND/1;statseq/=/AND/1	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
184	pesq	4	0	cursseq=seq,cursseqLabel=nome	pesqCursos	Cursos	85	184	-	1	0	2	0	0	0	1	statseq/!=/AND/8;statseq/!=/AND/9	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
488	form	487	0	0	listaTransacoesContas	Lista de Contas	65	488	-	1	0	1	0	1	0	0	statseq/!=/AND/9/numeric	\N	one	\N	0	0	datacad/desc;seq/desc	1	\N	1	1	1	1900-01-01
477	form	476	pjcuseq	0	listDisciplinas	Disciplinas	10	242	TCurso/getCargaHoraria	0	0	2	0	0	0	0	statseq/!=/AND/9/numeric	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
314	form	311	seq	0	listaCursosDisponiveis	Cursos Disponíveis	9	314	-	1	0	2	0	0	0	0	statseq/=/AND/1/numeric	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
272	pesq	270	seq	ccduseq=seq,ccduseqLabel=titulo	pesqClassificacaoCdu	ClassificacoesCdeu	86	272	-	1	Nova Classificação	2	0	0	0	1	statseq/=/AND/1/numeric	\N	one	\N	0	0	seq/desc	1	\N	1	1	1	1900-01-01
\.


--
-- TOC entry 2359 (class 0 OID 16586)
-- Dependencies: 198 2373
-- Data for Name: lista_actions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY lista_actions (seq, listseq, tipocampo, nameaction, label, actionjs, metodoexe, confirm, campoparam, img, ordem, statseq, tiporetorno, usuaseq, unidseq, datacad) FROM stdin;
1	147	\N	onMatricula	Efetivar Matrícula	prossExe	onSet	\N	seq	new_ico_set.png	1	0	form	1	1	1900-01-01
2	163	TCheckButton	onSelect	Selecionar	onMarcador	\N	\N	seq		1	0	lista	1	1	1900-01-01
23	217	\N	onAtaAvaliacao	Ata de Avaliação	showAtaAvaliacao	onSet	\N	seq	new_ico_set.png	2	1	form	1	1	1900-01-01
22	458	\N	onViewProcAcademicos	Visualizar	prossExe	onEdit	\N	seq	new_ico_config.png	1	1	form	1	1	1900-01-01
21	457	\N	onViewHistFinanceiro	Visualizar	prossExe	onEdit	\N	seq	new_ico_config.png	1	1	form	1	1	1900-01-01
20	142	\N	showBoleto	Imprimir Boleto	showBoletoLst	onSet	\N	seq	new_ico_print.png	1	1	form	1	1	1900-01-01
19	144	\N	onComprovante	Imprimir Comprovante	showComprovantePagamento	onSet	\N	seq	new_ico_print.png	2	1	form	1	1	1900-01-01
18	425	\N	onComprovante	Imprimir Comprovante	showComprovantePagamento	onSet	\N	seq	new_ico_print.png	1	1	form	1	1	1900-01-01
17	331	\N	onLivro	Informações do Livro	prossExe	onEdit	\N	seq	new_ico_view.png	1	1	form	1	1	1900-01-01
15	269	\N	onSetDevolucao	Devolver	prossExe	onView	Deseja realmente efetivar a devolução deste livro?	seq	new_ico_set.png	1	1	form	1	1	1900-01-01
10	217	\N	onListaPresenca	Lista de Presença	showListaPresenca	onSet	\N	seq	new_ico_print.png	1	1	form	1	1	1900-01-01
9	185	\N	onInscricao	Lançar Inscrição	prossExe	onEdit	\N	seq	new_ico_set.png	0	1	form	1	1	1900-01-01
7	199	\N	onDiarioCoord	Atualizar Diário	prossExe	onEdit	\N	seq	new_ico_config.png	0	1	form	1	1	1900-01-01
6	193	\N	onDiario	Atualizar Diário	prossExe	onEdit	\N	seq	new_ico_config.png	0	1	form	1	1	1900-01-01
5	182	\N	onViewTurma	Visualizar turma	prossExe	onSet	\N	seq	new_ico_set.png	2	0	form	1	1	1900-01-01
4	182	\N	onConfigTurma	Gerenciar Turma	selectTurma	\N	\N	seq	new_ico_set.png	1	0	form	1	1	1900-01-01
3	148	\N	onViewHistorico	Visualizar	prossExe	onEdit	\N	seq	new_ico_config.png	1	1	form	1	1	1900-01-01
\.


--
-- TOC entry 2422 (class 0 OID 0)
-- Dependencies: 199
-- Name: lista_actions_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('lista_actions_seq_seq', 1, false);


--
-- TOC entry 2361 (class 0 OID 16603)
-- Dependencies: 200 2373
-- Data for Name: lista_bnav; Type: TABLE DATA; Schema: public; Owner: -
--

COPY lista_bnav (seq, listseq, nome, tipocampo, label, metodo, funcaojs, argumento, usuaseq, unidseq, datacad, statseq) FROM stdin;
1	144	botContaCredito	5	 Contas a Receber 	onNew	prossExe	13	1	1	1900-01-01	1
2	144	botContaDebito	5	 Contas a Pagar 	onNew	prossExe	333	1	1	1900-01-01	1
3	144	botMovimentoProgramado	5	 Movimentos Programados 	onFormOpen	prossExe	383	1	1	1900-01-01	1
4	391	botMovInterna	5	 Movimentação Interna	onFormOpen	prossExe	404	1	1	1900-01-01	1
\.


--
-- TOC entry 2423 (class 0 OID 0)
-- Dependencies: 201
-- Name: lista_bnav_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('lista_bnav_seq_seq', 1, false);


--
-- TOC entry 2363 (class 0 OID 16613)
-- Dependencies: 202 2373
-- Data for Name: lista_fields; Type: TABLE DATA; Schema: public; Owner: -
--

COPY lista_fields (seq, listseq, nomecol, labelcol, campseq, ordem, statseq, usuaseq, unidseq, datacad) FROM stdin;
\.


--
-- TOC entry 2424 (class 0 OID 0)
-- Dependencies: 203
-- Name: lista_fields_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('lista_fields_seq_seq', 1, false);


--
-- TOC entry 2365 (class 0 OID 16622)
-- Dependencies: 204 2373
-- Data for Name: menu; Type: TABLE DATA; Schema: public; Owner: -
--

COPY menu (seq, modulo, labelmodulo, metodo, argumento, formseq, nivel, modseq, ordem, statseq, usuaseq, unidseq, datacad) FROM stdin;
25	historico	Histórico Acadêmico	getform	54	54	2	10	1	1	1	1	1900-01-01
82	parametros	Parametros	getform	46	46	2	4	12	1	1	1	1900-01-01
26	financeiroAluno	Histórico Financeiro	getform	50	50	2	10	2	1	1	1	1900-01-01
65	<separador>		-	0	0	2	2	3	1	1	1	1900-01-01
66	<separador>		-	0	0	2	2	8	1	1	1	1900-01-01
97	<separador>		-	0	0	2	4	5	1	1	1	1900-01-01
98	<separador>		-	0	0	2	4	10	1	1	1	1900-01-01
44	botFuncionario	Funcionários	getList	136	6	2	5	0	1	1	1	1900-01-01
14	professores	Professores	getList	137	7	2	7	0	1	1	1	1900-01-01
107	responderQuestionario	Responder Questionário	getList	0	2	2	8	2	1	1	1	1900-01-01
45	botProfessor	Professores	getList	137	7	2	5	0	1	1	1	1900-01-01
7	matricula	Matrícula	getList	147	14	2	2	2	1	1	1	1900-01-01
46	botProdutos	Turmas Abertas	getList	149	16	2	1	0	1	1	1	1900-01-01
48	cargos	Cargos	getList	153	19	1	5	0	1	1	1	1900-01-01
50	patrimonios	Patrimonios	getList	155	21	1	4	4	1	1	1	1900-01-01
51	treinamentos	Treinamentos	getList	156	22	1	5	0	1	1	1	1900-01-01
52	unidades	Unidades	getList	158	24	1	4	1	1	1	1	1900-01-01
53	fornecedores	Fornecedores	getList	160	26	2	4	8	1	1	1	1900-01-01
56	usuarios	Gerenciar Usuários	getList	167	31	2	4	11	1	1	1	1900-01-01
61	salas	Salas	getList	174	34	2	4	2	1	1	1	1900-01-01
63	solicitacoes	Solicitações	getList	178	38	2	2	9	1	1	1	1900-01-01
58	demanda	Demanda	getList	185	43	2	1	0	1	1	1	1900-01-01
16	gerDisciplina	Diário Eletronico	getList	199	58	2	7	0	1	1	1	1900-01-01
17	montarGrade	Gerenciar Disciplinas	getList	200	59	2	7	0	1	1	1	1900-01-01
84	gerenciadorProjetos	Gerenciar Projetos	getList	203	57	2	11	0	1	1	1	1900-01-01
89	turmaCanceladas	Turmas Canceladas	getList	209	69	2	2	8	1	1	1	1900-01-01
13	listPresenca	Lista de Presença	getList	217	74	2	2	21	1	1	1	1900-01-01
93	produtos	Produtos	getList	218	75	2	4	0	1	1	1	1900-01-01
27	solicitacao	Solicitações	getList	222	76	2	10	3	1	1	1	1900-01-01
94	departamentos	Departamentos	getList	223	77	2	4	3	1	1	1	1900-01-01
95	solicitacoesEncaminhadas	Solicitações Encaminhadas	getList	227	78	2	2	10	1	1	1	1900-01-01
100	turmasConcluidas	Turmas Concluidas	getList	234	82	2	2	8	1	1	1	1900-01-01
106	gerenciarQuestionario	Gerenciar Questionário	getList	244	89	2	8	1	1	1	1	1900-01-01
111	reservaLivro	Reservas	getList	268	266	2	12	3	1	1	1	1900-01-01
110	locacaoLivro	Locação	getList	265	264	2	12	2	1	1	1	1900-01-01
112	devoucaoLivro	Devoluções	getList	269	267	2	12	4	1	1	1	1900-01-01
113	<separador>		-	0	0	2	12	5	1	1	1	1900-01-01
114	classificacaoCDU	Classificação CDU	getList	271	270	2	12	6	1	1	1	1900-01-01
86	viewArquivos	Orientações e Arquivos	getform	63	63	2	10	4	1	1	1	1900-01-01
101	biblioteca	Controle de Livros	getList	237	83	2	12	7	1	1	1	1900-01-01
8	bot_convenios	Convênios	getList	321	320	2	4	9	1	1	1	1900-01-01
29	movimentoCaixa	Movimento de Caixa	getList	144	13	2	3	1	1	1	1	1900-01-01
91	transacaoD	Transações a Pagar	getList	213	72	2	3	5	1	1	1	1900-01-01
31	contaReceber	Contas a Receber	getList	142	12	2	3	9	1	1	1	1900-01-01
30	contasPagar	Contas a Pagar	getList	141	11	2	3	10	1	1	1	1900-01-01
32	cadPlanoConta	Plano de Contas	getList	140	10	2	3	12	1	1	1	1900-01-01
34	criaContaCaixa	Conta Caixa / Bancos	getList	151	17	2	3	13	1	1	1	1900-01-01
77	relatorioCaixa	Relatório de Caixa	getform	41	41	2	3	23	1	1	1	1900-01-01
88	transacaoC	Transações a Receber	getList	206	67	2	3	4	1	1	1	1900-01-01
92	alunoListaLivros	Consulta de Livros	getList	331	328	2	10	5	1	1	1	1900-01-01
60	compras	Compras	getList	179	40	2	4	6	9	1	1	1900-01-01
47	botDuplicatas	Duplicatas	getList	139	9	2	3	22	9	1	1	1900-01-01
87	extorno	Extorno de Caixa	getList	203	64	2	3	7	9	1	1	1900-01-01
90	cadPessoa	Cadastro Pessoa	getList	212	71	2	5	30	9	1	1	1900-01-01
55	contratos	Contratos	getList	166	30	2	4	9	9	1	1	1900-01-01
115	consultaLivrosAluno	Consultar Livros	getList	274	273	2	10	1	1	1	1	1900-01-01
118	moviemntosProgramados	Movimentos Programados	getForm	383	383	2	3	2	1	1	1	1900-01-01
6	cadTurma	Turmas	getList	133	5	2	13	1	1	1	1	1900-01-01
105	cursos	Projeto de Curso Concluído	getList	242	87	2	13	3	1	1	1	1900-01-01
75	areaCurso	Áreas de Cursos	getList	176	39	2	13	6	1	1	1	1900-01-01
4	cadDisciplina	Disciplinas	getList	131	3	2	13	5	1	1	1	1900-01-01
5	cadProjetoCursos	Projeto de Curso	getList	132	4	2	13	4	1	1	1	1900-01-01
102	cadTipoCurso	Tipos de Curso	getList	240	85	2	13	7	1	1	1	1900-01-01
117	listaCheques	Cheques	getList	381	380	2	3	16	1	1	1	1900-01-01
116	funcCaixa	Funcionários Caixa	getList	335	332	2	3	14	1	1	1	1900-01-01
19	diario	Diário Eletrônico	getList	193	18	2	9	1	1	1	1	1900-01-01
103	consolidarCaixa	Consolidação de caixa	getList	391	395	2	3	3	1	1	1	1900-01-01
109	cursosstatseqs	Referência de Curso	getList	259	90	2	13	2	1	1	1	1900-01-01
20	planoAula	Plano de Aula	getList	398	397	2	9	2	1	1	1	1900-01-01
85	gerenciadorArquivos	Orientações e Arquivos	getList	402	399	2	9	3	1	1	1	1900-01-01
41	negociacao	Negociação	getList	163	29	2	3	6	1	1	1	1900-01-01
119	Sec-relatorioTurma	Relatório por Turma	getList	410	405	2	2	0	1	1	1	1900-01-01
120	Coord-relatorioTurma	Relatório por Turma	getList	411	406	2	7	0	1	1	1	1900-01-01
1	cadCliente	Clientes	getList	130	1	0	1	0	1	1	1	1900-01-01
121	Prof-relatorioTurma	Relatório por Turma	getList	412	407	2	9	0	1	1	1	1900-01-01
122	historicosCaixa	Históricos de Caixa	getList	419	418	2	3	18	1	1	1	1900-01-01
33	consciliaBanco	Consciliação Bancária	getform	47	47	2	3	8	1	1	1	1900-01-01
123	anotacoes	Anotações	getList	427	426	2	1	25	1	1	1	1900-01-01
124	gerPessoas	Pessoas	getList	212	71	2	4	12	1	1	1	1900-01-01
10	alunosHistAcademico	Históricos Acadêmicos	getList	148	15	2	2	1	1	1	1	1900-01-01
125	alunosHistFinanceiro	Históricos Financeiros	getList	457	459	2	2	1	1	1	1	1900-01-01
126	alunosProcAcademicos	Processos Acadêmicos	getList	458	460	2	2	1	1	1	1	1900-01-01
127	gradeAvaliacoes	Grades de Avaliações	getList	466	463	2	7	10	1	1	1	1900-01-01
128	notasAlunos	Notas de Alunos	getList	470	469	2	2	15	1	1	1	1900-01-01
129	estornoCaixa	Estorno de Caixa	getList	479	478	2	3	0	1	1	1	1900-01-01
130	consolidacaoNotasFrequencias	Consolidação de Notas e Frenquencias	getForm	483	483	2	13	0	1	1	1	1900-01-01
131	baixaMultipla	Baixa Múltipla de Contas	getForm	484	484	2	3	0	1	1	1	1900-01-01
132	alteraVencimentoConta	Alteração de Vencimento de Contas	getList	488	487	2	3	0	1	1	1	1900-01-01
104	alunosInativos	Alunos Inativos	getList	241	86	2	2	2	1	1	1	1900-01-01
57	ferias	Férias	getList	171	33	2	5	0	9	1	1	1900-01-01
49	curriculos	Currículos	getList	154	20	1	5	0	9	1	1	1900-01-01
43	scorecard	Scorecard	getList	238	84	2	3	21	9	1	1	1900-01-01
40	inadimplencia	Inadimplência	getList	151	25	2	3	17	9	1	1	1900-01-01
83	folhaPag	Folha de Pagamento	getList	190	51	2	5	0	9	1	1	1900-01-01
96	produtosTurma	Turmas	getList	228	79	2	1	0	9	1	1	1900-01-01
99	funcDemitidos	Funcionários Demitidos	getList	231	80	2	5	0	9	1	1	1900-01-01
39	contabilidade	Contabilidade	getform	44	44	2	3	20	9	1	1	1900-01-01
2	inscricao	Inscrição	getList	138	8	0	1	0	1	1	1	1900-01-01
\.


--
-- TOC entry 2425 (class 0 OID 0)
-- Dependencies: 205
-- Name: menu_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('menu_seq_seq', 1, false);


--
-- TOC entry 2367 (class 0 OID 16632)
-- Dependencies: 206 2373
-- Data for Name: modulo; Type: TABLE DATA; Schema: public; Owner: -
--

COPY modulo (seq, modulo, labelmodulo, nivel, ordem, statseq, usuaseq, unidseq, datacad) FROM stdin;
1	comercial	Comercial	1	1	1	1	1	1900-01-01
2	secretaria	Secretaria	1	2	1	1	1	1900-01-01
3	financeiro	Financeiro	1	5	1	1	1	1900-01-01
5	rh	Recursos Humanos	1	3	1	1	1	1900-01-01
6	paramentros	Parametros	1	12	0	1	1	1900-01-01
7	coordenador	Coordenador	1	7	1	1	1	1900-01-01
12	biblioteca	Biblioteca	1	10	1	1	1	1900-01-01
13	academico	Acadêmico	1	6	1	1	1	1900-01-01
8	questionarios	Questionarios	1	13	0	1	1	1900-01-01
11	projetos	Projetos	1	11	0	1	1	1900-01-01
9	professores	Professores	1	8	1	1	1	1900-01-01
10	alunos	Alunos	1	9	1	1	1	1900-01-01
4	administrativo	Administrativo	1	4	1	1	1	1900-01-01
\.


--
-- TOC entry 2426 (class 0 OID 0)
-- Dependencies: 207
-- Name: modulo_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('modulo_seq_seq', 1, false);


--
-- TOC entry 2369 (class 0 OID 16640)
-- Dependencies: 208 2373
-- Data for Name: tabelas; Type: TABLE DATA; Schema: public; Owner: -
--

COPY tabelas (seq, tabela, tabela_view, tabseq, statseq, colunafilho, usuaseq, unidseq, datacad) FROM stdin;
100	dbaproveitamento_disciplina	--SEM USO-- dbalunos_disciplinas_aproveitamentos	56	1	0	1	1	1900-01-01
102	dbconvenio_desconto	dbconvenio_desconto	89	1	0	1	1	1900-01-01
101	--SEM USO-- dbcursos_avaliacoes	--SEM USO-- dbcursos_avaliacoes	9	1	0	1	1	1900-01-01
108	--SEM USO-- dbturmas_disciplinas_avaliacao_detalhamento	--SEM USO-- dbturmas_disciplinas_avaliacao_detalhamento	12	1	0	1	1	1900-01-01
25	dbfalta	view_falta	\N	1	0	1	1	1900-01-01
109	dbnota	view_nota	\N	1	0	1	1	1900-01-01
46	dbaluno_solicitacao	view_aluno_solicitacao	22	1	0	1	1	1900-01-01
54	dbfechamento_caixa	view_fechamento_caixa	\N	1	0	1	1	1900-01-01
94	dbcaixa_funcionario	view_caixa_funcionario	\N	1	0	1	1	1900-01-01
29	dbcargo	view_cargo	\N	1	0	1	1	1900-01-01
47	--SEM USO-- dbcompras	--SEM USO-- view_compras	\N	1	0	1	1	1900-01-01
95	dbcheque	view_cheque	\N	1	0	1	1	1900-01-01
39	--SEM USO-- dbcontratos	--SEM USO-- view_contratos	\N	1	0	1	1	1900-01-01
38	dbcotacao	view_cotacao	\N	1	0	1	1	1900-01-01
30	dbcurriculo	view_curriculo	\N	1	0	1	1	1900-01-01
80	dbtipo_curso	view_tipo_curso	\N	1	0	1	1	1900-01-01
97	dbdisciplina_similar	view_disciplina_similar	8	1	0	1	1	1900-01-01
64	dbparcela_estorno	view_parcela_estorno	\N	1	0	1	1	1900-01-01
41	--SEM USO-- dbfuncionarios_ferias	--SEM USO-- view_funcionarios_ferias	14	1	0	1	1	1900-01-01
55	--SEM USO-- dbfuncionarios_folhapagamento	--SEM USO-- view_funcionarios_folhapagamento	14	1	0	1	1	1900-01-01
57	dbfuncionario_ocorrencia	view_funcionario_ocorrencia	14	1	0	1	1	1900-01-01
34	dbfuncionario_treinamento	view_funcionario_treinamento	14	1	0	1	1	1900-01-01
50	dbunidade_parametro	view_unidade_parametro	\N	1	0	1	1	1900-01-01
42	dbcheque	view_cheque	\N	1	0	1	1	1900-01-01
37	--SEM USO-- dbprodutos_caracteristicas	--SEM USO-- view_produtos_caracteristicas	70	1	0	1	1	1900-01-01
79	--SEM USO-- dbprodutos_especialidades	--SEM USO-- view_produtos_especialidades	\N	1	0	1	1	1900-01-01
58	--SEM USO-- dbprojetos	--SEM USO-- view_projetos	\N	1	0	1	1	1900-01-01
60	--SEM USO-- dbprojetos_colaboradores	--SEM USO-- view_projetos_colaboradores	58	1	0	1	1	1900-01-01
74	dbdepartamento	view_departamento	\N	1	deptseq	1	1	1900-01-01
76	dbpatrimonio	view_livro	\N	1	patrseq	1	1	1900-01-01
56	dbaluno_disciplina	view_aluno_disciplina	22	1	aldiseq	1	1	1900-01-01
81	dbpessoa	view_funcionario	\N	1	pessseq	1	1	1900-01-01
85	dbcurso	view_curso	\N	1	cursseq	1	1	1900-01-01
105	dbgrade_avaliacao	dbgrade_avaliacao	\N	1	gdavseq	1	1	1900-01-01
106	dbavaliacao	dbavaliacao	105	1	avalseq	1	1	1900-01-01
87	dblocacao_livro	dblocacao_livro	\N	1	0	1	1	1900-01-01
96	dblivro	view_livro	32	1	livrseq	1	1	1900-01-01
89	dbconvenio	view_convenio	\N	1	convseq	1	1	1900-01-01
32	dbpatrimonio	view_patrimonio	\N	1	patrseq	1	1	1900-01-01
98	dbfechamento_conta_financeira	dbfechamento_conta_financeira	\N	1	fecfseq	1	1	1900-01-01
21	dbcaixa	view_caixa	\N	1	caixseq	1	1	1900-01-01
15	dbprofessor	view_professor	15	1	profseq	1	1	1900-01-01
10	dbprojeto_curso_disciplina	view_projeto_curso_disciplina	8	1	pjcdseq	1	1	1900-01-01
9	dbprojeto_curso	view_projeto_curso	\N	1	pjcuseq	1	1	1900-01-01
8	dbdisciplina	view_disciplina	\N	1	discseq	1	1	1900-01-01
1	dbpessoa	view_pessoa	\N	1	pessseq	1	1	1900-01-01
86	dbcdu	view_cdu	\N	1	ccduseq	1	1	1900-01-01
24	dbconta_financeira	view_conta_financeira	\N	1	cofiseq	1	1	1900-01-01
59	--SEM USO-- dbprojetos_custos	--SEM USO-- view_projetos_custos	58	1	0	1	1	1900-01-01
61	--SEM USO-- dbprojetos_recursos	--SEM USO-- view_projetos_recursos	58	1	0	1	1	1900-01-01
82	--SEM USO-- dbquestionarios	--SEM USO-- view_questionarios	\N	1	0	1	1	1900-01-01
75	dbprofessor_area	view_professor_area	45	1	profseq	1	1	1900-01-01
2	view_inscricao	view_inscricao	1	1	seq	1	1	1900-01-01
6	dbpessoa_juridica	view_pessoa_juridica	1	1	pejuseq	1	1	1900-01-01
18	dbplano_conta	view_plano_conta	\N	1	plcoseq	1	1	1900-01-01
14	dbfuncionario	view_funcionario	1	1	funcseq	1	1	1900-01-01
16	dbinscricao	view_inscricao	1	1	seq	1	1	1900-01-01
22	dbaluno	view_aluno	1	1	alunseq	1	1	1900-01-01
48	dbdemanda	view_demanda	1	1	0	1	1	1900-01-01
90	--SEM USO-- dbpessoas_convenios	--SEM USO-- view_pessoas_convenios	1	1	seq	1	1	1900-01-01
49	dbendereco	view_endereco	1	1	endeseq	1	1	1900-01-01
45	dbarea_curso	view_area_curso	9	1	arcuseq	1	1	1900-01-01
5	dbpessoa_fisica	view_pessoa_fisica	1	1	pefiseq	1	1	1900-01-01
107	dbregra_avaliacao	dbregra_avaliacao	106	1	rgavseq	1	1	1900-01-01
83	--SEM USO-- dbquestoes	--SEM USO-- view_questoes	\N	1	0	1	1	1900-01-01
84	--SEM USO-- dbquestoes_itens	--SEM USO-- view_questoes_itens	\N	1	0	1	1	1900-01-01
77	--SEM USO-- dbscorecard	--SEM USO-- view_scorecard	\N	1	0	1	1	1900-01-01
78	--SEM USO-- dbscorecard_sentencas	--SEM USO-- view_scorecard_sentencas	\N	1	0	1	1	1900-01-01
33	dbtreinamento	view_treinamento	\N	1	0	1	1	1900-01-01
104	dbturma_convenio	view_turma_convenio	11	1	0	1	1	1900-01-01
92	--SEM USO-- dbturmas_descontos	--SEM USO-- view_turmas_descontos	\N	1	0	1	1	1900-01-01
63	dbturma_disciplina_arquivo	view_turma_disciplina_arquivo	\N	1	0	1	1	1900-01-01
28	dbturma_disciplina_aula	view_turma_disciplina_aula	12	1	0	1	1	1900-01-01
53	dbturma_disciplina_material	view_turma_discplina_material	12	1	0	1	1	1900-01-01
62	dbturma_disciplina_planoaula	view_turma_disciplina_planoaula	\N	1	0	1	1	1900-01-01
40	dbusuario_privilegio	view_usuario_privilegio	\N	1	0	1	1	1900-01-01
999	tabela_inexistente	tabela_inexistente	\N	1	seq	1	1	2013-08-05
66	dbtransacao	view_transacao	\N	1	transeq	1	1	1900-01-01
65	dbparcela	view_parcela	66	1	parcseq	1	1	1900-01-01
67	dbtransacao_convenio	view_transacao_produto	66	1	prodseq	1	1	1900-01-01
70	dbproduto	view_produto	\N	1	prodseq	1	1	1900-01-01
103	dbtransacao_convenio	view_transacao_convenio	66	1	seq	1	1	1900-01-01
44	dbsala	view_sala	\N	1	salaseq	1	1	1900-01-01
35	dbunidade	view_unidade	\N	1	unidseq	1	1	1900-01-01
26	dbusuario	view_usuario	\N	1	usuaseq	1	1	1900-01-01
17	dbboleto	view_boleto	\N	1	boleseq	1	1	1900-01-01
12	dbturma_disciplina	view_turma_disciplina	11	1	tudiseq	1	1	1900-01-01
11	dbturma	view_turma	\N	1	turmseq	1	1	1900-01-01
4	dbtitularidade	dbtitularidade	\N	1	tituseq	1	1	2013-09-03
43	dbpessoa_titularidade	view_pessoa_titularidade	1	1	petiseq	1	1	1900-01-01
99	dbrecado	view_recado	\N	1	recaseq	1	1	1900-01-01
23	dbrequisito_turma	view_requisito_turma	11	1	rqtuseq	1	1	1900-01-01
3	dbtelefone	dbtelefone	1	1	foneseq	1	1	2013-08-21
27	dbturma_disciplina_avaliacao	view_turma_disciplina_avaliacao	12	1	avalseq	1	1	1900-01-01
\.


--
-- TOC entry 2427 (class 0 OID 0)
-- Dependencies: 209
-- Name: tabelas_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('tabelas_seq_seq', 4, true);


--
-- TOC entry 2371 (class 0 OID 16648)
-- Dependencies: 210 2373
-- Data for Name: tipo_campo; Type: TABLE DATA; Schema: public; Owner: -
--

COPY tipo_campo (seq, unidseq, usuaseq, tpcadesc, tipodado, statseq, datacad) FROM stdin;
1	1	1	TEntry	string	1	2013-07-16
2	1	1	TCombo	string	1	2013-07-16
3	1	1	TRadioGroup	string	1	2013-07-16
4	1	1	TMultiSelect	string	1	2013-07-16
5	1	1	TButton	string	1	2013-07-16
6	1	1	TPassword	string	1	2013-07-16
7	1	1	THidden	string	1	2013-07-16
8	1	1	TFrameFile	string	1	2013-07-16
9	1	1	TText	string	1	2013-07-16
10	1	1	TEntry	date	1	2013-08-05
11	1	1	TEntry	numeric	1	2013-08-05
12	1	1	THidden	boolean	1	2013-09-19
13	1	1	THidden	numeric	1	2013-10-17
14	1	1	THidden	string	1	2013-10-17
15	1	1	TCombo	boolean	1	2013-10-21
\.


--
-- TOC entry 2428 (class 0 OID 0)
-- Dependencies: 211
-- Name: tipo_campo_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('tipo_campo_seq_seq', 15, true);


--
-- TOC entry 2079 (class 2606 OID 16679)
-- Dependencies: 161 161 2374
-- Name: pk_abas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY abas
    ADD CONSTRAINT pk_abas PRIMARY KEY (seq);


--
-- TOC entry 2081 (class 2606 OID 16681)
-- Dependencies: 163 163 2374
-- Name: pk_blocos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY blocos
    ADD CONSTRAINT pk_blocos PRIMARY KEY (seq);


--
-- TOC entry 2083 (class 2606 OID 16683)
-- Dependencies: 165 165 2374
-- Name: pk_blocos_x_abas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY blocos_x_abas
    ADD CONSTRAINT pk_blocos_x_abas PRIMARY KEY (seq);


--
-- TOC entry 2085 (class 2606 OID 16685)
-- Dependencies: 167 167 2374
-- Name: pk_campos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY campos
    ADD CONSTRAINT pk_campos PRIMARY KEY (seq);


--
-- TOC entry 2087 (class 2606 OID 16687)
-- Dependencies: 169 169 2374
-- Name: pk_campos_x_blocos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY campos_x_blocos
    ADD CONSTRAINT pk_campos_x_blocos PRIMARY KEY (seq);


--
-- TOC entry 2089 (class 2606 OID 16689)
-- Dependencies: 171 171 2374
-- Name: pk_campos_x_propriedades; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY campos_x_propriedades
    ADD CONSTRAINT pk_campos_x_propriedades PRIMARY KEY (seq);


--
-- TOC entry 2091 (class 2606 OID 16691)
-- Dependencies: 173 173 2374
-- Name: pk_coluna; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY coluna
    ADD CONSTRAINT pk_coluna PRIMARY KEY (seq);


--
-- TOC entry 2093 (class 2606 OID 16693)
-- Dependencies: 175 175 2374
-- Name: pk_dbpessoa; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoa
    ADD CONSTRAINT pk_dbpessoa PRIMARY KEY (seq);


--
-- TOC entry 2096 (class 2606 OID 16695)
-- Dependencies: 177 177 2374
-- Name: pk_dbstatus; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbstatus
    ADD CONSTRAINT pk_dbstatus PRIMARY KEY (seq);


--
-- TOC entry 2098 (class 2606 OID 16697)
-- Dependencies: 179 179 2374
-- Name: pk_dbunidade; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbunidade
    ADD CONSTRAINT pk_dbunidade PRIMARY KEY (seq);


--
-- TOC entry 2100 (class 2606 OID 16699)
-- Dependencies: 180 180 2374
-- Name: pk_dbunidade_parametro; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbunidade_parametro
    ADD CONSTRAINT pk_dbunidade_parametro PRIMARY KEY (seq);


--
-- TOC entry 2102 (class 2606 OID 16701)
-- Dependencies: 183 183 2374
-- Name: pk_dbusuario; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbusuario
    ADD CONSTRAINT pk_dbusuario PRIMARY KEY (seq);


--
-- TOC entry 2106 (class 2606 OID 16703)
-- Dependencies: 184 184 2374
-- Name: pk_dbusuario_privilegio; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbusuario_privilegio
    ADD CONSTRAINT pk_dbusuario_privilegio PRIMARY KEY (seq);


--
-- TOC entry 2108 (class 2606 OID 16705)
-- Dependencies: 187 187 2374
-- Name: pk_form_button; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY form_button
    ADD CONSTRAINT pk_form_button PRIMARY KEY (seq);


--
-- TOC entry 2110 (class 2606 OID 16707)
-- Dependencies: 190 190 2374
-- Name: pk_form_validacao; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY form_validacao
    ADD CONSTRAINT pk_form_validacao PRIMARY KEY (seq);


--
-- TOC entry 2112 (class 2606 OID 16709)
-- Dependencies: 192 192 2374
-- Name: pk_form_x_abas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY form_x_abas
    ADD CONSTRAINT pk_form_x_abas PRIMARY KEY (seq);


--
-- TOC entry 2114 (class 2606 OID 16711)
-- Dependencies: 194 194 2374
-- Name: pk_form_x_tabelas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY form_x_tabelas
    ADD CONSTRAINT pk_form_x_tabelas PRIMARY KEY (seq);


--
-- TOC entry 2116 (class 2606 OID 16713)
-- Dependencies: 196 196 2374
-- Name: pk_forms; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY forms
    ADD CONSTRAINT pk_forms PRIMARY KEY (seq);


--
-- TOC entry 2118 (class 2606 OID 16715)
-- Dependencies: 197 197 2374
-- Name: pk_lista; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY lista
    ADD CONSTRAINT pk_lista PRIMARY KEY (seq);


--
-- TOC entry 2120 (class 2606 OID 16717)
-- Dependencies: 198 198 2374
-- Name: pk_lista_actions; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY lista_actions
    ADD CONSTRAINT pk_lista_actions PRIMARY KEY (seq);


--
-- TOC entry 2122 (class 2606 OID 16719)
-- Dependencies: 200 200 2374
-- Name: pk_lista_bnav; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY lista_bnav
    ADD CONSTRAINT pk_lista_bnav PRIMARY KEY (seq);


--
-- TOC entry 2124 (class 2606 OID 16721)
-- Dependencies: 202 202 2374
-- Name: pk_lista_fields; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY lista_fields
    ADD CONSTRAINT pk_lista_fields PRIMARY KEY (seq);


--
-- TOC entry 2126 (class 2606 OID 16723)
-- Dependencies: 204 204 2374
-- Name: pk_menu; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY menu
    ADD CONSTRAINT pk_menu PRIMARY KEY (seq);


--
-- TOC entry 2128 (class 2606 OID 16725)
-- Dependencies: 206 206 2374
-- Name: pk_modulo; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY modulo
    ADD CONSTRAINT pk_modulo PRIMARY KEY (seq);


--
-- TOC entry 2130 (class 2606 OID 16727)
-- Dependencies: 208 208 2374
-- Name: pk_tabelas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tabelas
    ADD CONSTRAINT pk_tabelas PRIMARY KEY (seq);


--
-- TOC entry 2132 (class 2606 OID 16729)
-- Dependencies: 210 210 2374
-- Name: pk_tipo_campo; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tipo_campo
    ADD CONSTRAINT pk_tipo_campo PRIMARY KEY (seq);


--
-- TOC entry 2104 (class 1259 OID 16730)
-- Dependencies: 184 2374
-- Name: id_dbusuario_privilegio; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX id_dbusuario_privilegio ON dbusuario_privilegio USING btree (funcionalidade);


--
-- TOC entry 2094 (class 1259 OID 16731)
-- Dependencies: 175 2374
-- Name: uk_dbpessoas; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX uk_dbpessoas ON dbpessoa USING btree (pessnmrf);


--
-- TOC entry 2103 (class 1259 OID 16732)
-- Dependencies: 183 2374
-- Name: uk_dbusuario; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX uk_dbusuario ON dbusuario USING btree (usuario);


--
-- TOC entry 2141 (class 2606 OID 16733)
-- Dependencies: 165 2078 161 2374
-- Name: fk_aba_blab_abaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY blocos_x_abas
    ADD CONSTRAINT fk_aba_blab_abaseq FOREIGN KEY (abaseq) REFERENCES abas(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2183 (class 2606 OID 16738)
-- Dependencies: 192 2078 161 2374
-- Name: fk_aba_foab_abaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY form_x_abas
    ADD CONSTRAINT fk_aba_foab_abaseq FOREIGN KEY (abaseq) REFERENCES abas(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2142 (class 2606 OID 16743)
-- Dependencies: 165 163 2080 2374
-- Name: fk_bloc_blab_blocseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY blocos_x_abas
    ADD CONSTRAINT fk_bloc_blab_blocseq FOREIGN KEY (blocseq) REFERENCES blocos(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2136 (class 2606 OID 16748)
-- Dependencies: 2115 163 196 2374
-- Name: fk_form_bloc_formseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY blocos
    ADD CONSTRAINT fk_form_bloc_formseq FOREIGN KEY (formseq) REFERENCES forms(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2137 (class 2606 OID 16753)
-- Dependencies: 2115 196 163 2374
-- Name: fk_form_bloc_frmpseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY blocos
    ADD CONSTRAINT fk_form_bloc_frmpseq FOREIGN KEY (frmpseq) REFERENCES forms(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2176 (class 2606 OID 16758)
-- Dependencies: 187 2115 196 2374
-- Name: fk_form_fobu_formseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY form_button
    ADD CONSTRAINT fk_form_fobu_formseq FOREIGN KEY (formseq) REFERENCES forms(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2186 (class 2606 OID 16763)
-- Dependencies: 194 196 2115 2374
-- Name: fk_form_fota_formseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY form_x_tabelas
    ADD CONSTRAINT fk_form_fota_formseq FOREIGN KEY (formseq) REFERENCES forms(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2179 (class 2606 OID 16768)
-- Dependencies: 190 2115 196 2374
-- Name: fk_form_fova_formseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY form_validacao
    ADD CONSTRAINT fk_form_fova_formseq FOREIGN KEY (formseq) REFERENCES forms(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2197 (class 2606 OID 16773)
-- Dependencies: 2117 197 198 2374
-- Name: fk_list_liac_listseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY lista_actions
    ADD CONSTRAINT fk_list_liac_listseq FOREIGN KEY (listseq) REFERENCES lista(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2200 (class 2606 OID 16778)
-- Dependencies: 2117 197 200 2374
-- Name: fk_list_libn_listseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY lista_bnav
    ADD CONSTRAINT fk_list_libn_listseq FOREIGN KEY (listseq) REFERENCES lista(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2155 (class 2606 OID 16783)
-- Dependencies: 173 2117 197 2374
-- Name: fk_list_lico_listseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY coluna
    ADD CONSTRAINT fk_list_lico_listseq FOREIGN KEY (listseq) REFERENCES lista(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2204 (class 2606 OID 16788)
-- Dependencies: 197 2117 202 2374
-- Name: fk_list_lifi_listseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY lista_fields
    ADD CONSTRAINT fk_list_lifi_listseq FOREIGN KEY (listseq) REFERENCES lista(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2208 (class 2606 OID 16793)
-- Dependencies: 204 2127 206 2374
-- Name: fk_mod_menu_modseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY menu
    ADD CONSTRAINT fk_mod_menu_modseq FOREIGN KEY (modseq) REFERENCES modulo(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2133 (class 2606 OID 16798)
-- Dependencies: 2095 177 161 2374
-- Name: fk_stat_aba_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY abas
    ADD CONSTRAINT fk_stat_aba_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2143 (class 2606 OID 16803)
-- Dependencies: 177 165 2095 2374
-- Name: fk_stat_blab_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY blocos_x_abas
    ADD CONSTRAINT fk_stat_blab_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2150 (class 2606 OID 16808)
-- Dependencies: 2095 177 169 2374
-- Name: fk_stat_cabl_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY campos_x_blocos
    ADD CONSTRAINT fk_stat_cabl_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2190 (class 2606 OID 16813)
-- Dependencies: 196 177 2095 2374
-- Name: fk_stat_form_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY forms
    ADD CONSTRAINT fk_stat_form_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2180 (class 2606 OID 16818)
-- Dependencies: 190 177 2095 2374
-- Name: fk_stat_fova_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY form_validacao
    ADD CONSTRAINT fk_stat_fova_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2201 (class 2606 OID 16823)
-- Dependencies: 200 177 2095 2374
-- Name: fk_stat_libn_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY lista_bnav
    ADD CONSTRAINT fk_stat_libn_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2205 (class 2606 OID 16828)
-- Dependencies: 202 177 2095 2374
-- Name: fk_stat_lifi_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY lista_fields
    ADD CONSTRAINT fk_stat_lifi_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2194 (class 2606 OID 16833)
-- Dependencies: 197 177 2095 2374
-- Name: fk_stat_list_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY lista
    ADD CONSTRAINT fk_stat_list_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2209 (class 2606 OID 16838)
-- Dependencies: 204 177 2095 2374
-- Name: fk_stat_menu_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY menu
    ADD CONSTRAINT fk_stat_menu_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2158 (class 2606 OID 16843)
-- Dependencies: 175 177 2095 2374
-- Name: fk_stat_pess_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoa
    ADD CONSTRAINT fk_stat_pess_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2161 (class 2606 OID 16848)
-- Dependencies: 177 177 2095 2374
-- Name: fk_stat_stat_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbstatus
    ADD CONSTRAINT fk_stat_stat_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2214 (class 2606 OID 16853)
-- Dependencies: 208 177 2095 2374
-- Name: fk_stat_tab_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tabelas
    ADD CONSTRAINT fk_stat_tab_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2218 (class 2606 OID 16858)
-- Dependencies: 210 177 2095 2374
-- Name: fk_stat_tpca_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tipo_campo
    ADD CONSTRAINT fk_stat_tpca_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2164 (class 2606 OID 16863)
-- Dependencies: 179 177 2095 2374
-- Name: fk_stat_unid_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbunidade
    ADD CONSTRAINT fk_stat_unid_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2167 (class 2606 OID 16868)
-- Dependencies: 180 177 2095 2374
-- Name: fk_stat_unpa_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbunidade_parametro
    ADD CONSTRAINT fk_stat_unpa_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2170 (class 2606 OID 16873)
-- Dependencies: 183 177 2095 2374
-- Name: fk_stat_usua_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbusuario
    ADD CONSTRAINT fk_stat_usua_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2173 (class 2606 OID 16878)
-- Dependencies: 184 177 2095 2374
-- Name: fk_stat_usup_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbusuario_privilegio
    ADD CONSTRAINT fk_stat_usup_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2138 (class 2606 OID 16883)
-- Dependencies: 163 208 2129 2374
-- Name: fk_tab_bloc_tabseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY blocos
    ADD CONSTRAINT fk_tab_bloc_tabseq FOREIGN KEY (tabseq) REFERENCES tabelas(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2146 (class 2606 OID 16888)
-- Dependencies: 167 208 2129 2374
-- Name: fk_tab_camp_tabseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY campos
    ADD CONSTRAINT fk_tab_camp_tabseq FOREIGN KEY (tabseq) REFERENCES tabelas(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2191 (class 2606 OID 16893)
-- Dependencies: 196 208 2129 2374
-- Name: fk_tab_form_tabseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY forms
    ADD CONSTRAINT fk_tab_form_tabseq FOREIGN KEY (tabseq) REFERENCES tabelas(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2187 (class 2606 OID 16898)
-- Dependencies: 194 208 2129 2374
-- Name: fk_tab_fota_tabseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY form_x_tabelas
    ADD CONSTRAINT fk_tab_fota_tabseq FOREIGN KEY (tabseq) REFERENCES tabelas(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2215 (class 2606 OID 16903)
-- Dependencies: 208 208 2129 2374
-- Name: fk_tab_tab_tabseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tabelas
    ADD CONSTRAINT fk_tab_tab_tabseq FOREIGN KEY (tabseq) REFERENCES tabelas(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2147 (class 2606 OID 16908)
-- Dependencies: 167 210 2131 2374
-- Name: fk_tpca_camp_tpcaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY campos
    ADD CONSTRAINT fk_tpca_camp_tpcaseq FOREIGN KEY (tpcaseq) REFERENCES tipo_campo(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2134 (class 2606 OID 16913)
-- Dependencies: 161 179 2097 2374
-- Name: fk_unid_aba_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY abas
    ADD CONSTRAINT fk_unid_aba_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2144 (class 2606 OID 16918)
-- Dependencies: 165 179 2097 2374
-- Name: fk_unid_blab_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY blocos_x_abas
    ADD CONSTRAINT fk_unid_blab_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2139 (class 2606 OID 16923)
-- Dependencies: 163 179 2097 2374
-- Name: fk_unid_bloc_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY blocos
    ADD CONSTRAINT fk_unid_bloc_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2151 (class 2606 OID 16928)
-- Dependencies: 169 179 2097 2374
-- Name: fk_unid_cabl_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY campos_x_blocos
    ADD CONSTRAINT fk_unid_cabl_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2148 (class 2606 OID 16933)
-- Dependencies: 167 179 2097 2374
-- Name: fk_unid_camp_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY campos
    ADD CONSTRAINT fk_unid_camp_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2153 (class 2606 OID 16938)
-- Dependencies: 171 179 2097 2374
-- Name: fk_unid_capr_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY campos_x_propriedades
    ADD CONSTRAINT fk_unid_capr_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2184 (class 2606 OID 16943)
-- Dependencies: 192 179 2097 2374
-- Name: fk_unid_foab_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY form_x_abas
    ADD CONSTRAINT fk_unid_foab_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2177 (class 2606 OID 16948)
-- Dependencies: 187 179 2097 2374
-- Name: fk_unid_fobu_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY form_button
    ADD CONSTRAINT fk_unid_fobu_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2192 (class 2606 OID 16953)
-- Dependencies: 196 179 2097 2374
-- Name: fk_unid_form_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY forms
    ADD CONSTRAINT fk_unid_form_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2188 (class 2606 OID 16958)
-- Dependencies: 194 179 2097 2374
-- Name: fk_unid_fota_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY form_x_tabelas
    ADD CONSTRAINT fk_unid_fota_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2181 (class 2606 OID 16963)
-- Dependencies: 190 179 2097 2374
-- Name: fk_unid_fova_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY form_validacao
    ADD CONSTRAINT fk_unid_fova_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2198 (class 2606 OID 16968)
-- Dependencies: 198 179 2097 2374
-- Name: fk_unid_liac_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY lista_actions
    ADD CONSTRAINT fk_unid_liac_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2202 (class 2606 OID 16973)
-- Dependencies: 200 179 2097 2374
-- Name: fk_unid_libn_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY lista_bnav
    ADD CONSTRAINT fk_unid_libn_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2156 (class 2606 OID 16978)
-- Dependencies: 173 179 2097 2374
-- Name: fk_unid_lico_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY coluna
    ADD CONSTRAINT fk_unid_lico_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2206 (class 2606 OID 16983)
-- Dependencies: 202 179 2097 2374
-- Name: fk_unid_lifi_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY lista_fields
    ADD CONSTRAINT fk_unid_lifi_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2195 (class 2606 OID 16988)
-- Dependencies: 197 179 2097 2374
-- Name: fk_unid_list_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY lista
    ADD CONSTRAINT fk_unid_list_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2210 (class 2606 OID 16993)
-- Dependencies: 204 179 2097 2374
-- Name: fk_unid_menu_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY menu
    ADD CONSTRAINT fk_unid_menu_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2212 (class 2606 OID 16998)
-- Dependencies: 206 179 2097 2374
-- Name: fk_unid_mod_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY modulo
    ADD CONSTRAINT fk_unid_mod_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2159 (class 2606 OID 17003)
-- Dependencies: 175 179 2097 2374
-- Name: fk_unid_pess_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoa
    ADD CONSTRAINT fk_unid_pess_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2162 (class 2606 OID 17008)
-- Dependencies: 177 179 2097 2374
-- Name: fk_unid_stat_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbstatus
    ADD CONSTRAINT fk_unid_stat_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2216 (class 2606 OID 17013)
-- Dependencies: 208 179 2097 2374
-- Name: fk_unid_tab_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tabelas
    ADD CONSTRAINT fk_unid_tab_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2219 (class 2606 OID 17018)
-- Dependencies: 2097 210 179 2374
-- Name: fk_unid_tpca_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tipo_campo
    ADD CONSTRAINT fk_unid_tpca_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2165 (class 2606 OID 17023)
-- Dependencies: 179 2097 179 2374
-- Name: fk_unid_unid_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbunidade
    ADD CONSTRAINT fk_unid_unid_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2168 (class 2606 OID 17028)
-- Dependencies: 180 2097 179 2374
-- Name: fk_unid_unpa_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbunidade_parametro
    ADD CONSTRAINT fk_unid_unpa_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2171 (class 2606 OID 17033)
-- Dependencies: 179 2097 183 2374
-- Name: fk_unid_usua_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbusuario
    ADD CONSTRAINT fk_unid_usua_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2174 (class 2606 OID 17038)
-- Dependencies: 179 184 2097 2374
-- Name: fk_unid_usup_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbusuario_privilegio
    ADD CONSTRAINT fk_unid_usup_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2135 (class 2606 OID 17043)
-- Dependencies: 161 2101 183 2374
-- Name: fk_usua_aba_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY abas
    ADD CONSTRAINT fk_usua_aba_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2145 (class 2606 OID 17048)
-- Dependencies: 165 183 2101 2374
-- Name: fk_usua_blab_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY blocos_x_abas
    ADD CONSTRAINT fk_usua_blab_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2140 (class 2606 OID 17053)
-- Dependencies: 163 183 2101 2374
-- Name: fk_usua_bloc_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY blocos
    ADD CONSTRAINT fk_usua_bloc_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2152 (class 2606 OID 17058)
-- Dependencies: 169 2101 183 2374
-- Name: fk_usua_cabl_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY campos_x_blocos
    ADD CONSTRAINT fk_usua_cabl_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2149 (class 2606 OID 17063)
-- Dependencies: 183 2101 167 2374
-- Name: fk_usua_camp_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY campos
    ADD CONSTRAINT fk_usua_camp_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2154 (class 2606 OID 17068)
-- Dependencies: 2101 171 183 2374
-- Name: fk_usua_capr_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY campos_x_propriedades
    ADD CONSTRAINT fk_usua_capr_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2185 (class 2606 OID 17073)
-- Dependencies: 192 2101 183 2374
-- Name: fk_usua_foab_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY form_x_abas
    ADD CONSTRAINT fk_usua_foab_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2178 (class 2606 OID 17078)
-- Dependencies: 187 183 2101 2374
-- Name: fk_usua_fobu_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY form_button
    ADD CONSTRAINT fk_usua_fobu_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2193 (class 2606 OID 17083)
-- Dependencies: 196 2101 183 2374
-- Name: fk_usua_form_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY forms
    ADD CONSTRAINT fk_usua_form_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2189 (class 2606 OID 17088)
-- Dependencies: 194 183 2101 2374
-- Name: fk_usua_fota_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY form_x_tabelas
    ADD CONSTRAINT fk_usua_fota_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2182 (class 2606 OID 17093)
-- Dependencies: 183 2101 190 2374
-- Name: fk_usua_fova_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY form_validacao
    ADD CONSTRAINT fk_usua_fova_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2199 (class 2606 OID 17098)
-- Dependencies: 183 198 2101 2374
-- Name: fk_usua_liac_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY lista_actions
    ADD CONSTRAINT fk_usua_liac_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2203 (class 2606 OID 17103)
-- Dependencies: 183 2101 200 2374
-- Name: fk_usua_libn_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY lista_bnav
    ADD CONSTRAINT fk_usua_libn_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2157 (class 2606 OID 17108)
-- Dependencies: 2101 173 183 2374
-- Name: fk_usua_lico_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY coluna
    ADD CONSTRAINT fk_usua_lico_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2207 (class 2606 OID 17113)
-- Dependencies: 202 183 2101 2374
-- Name: fk_usua_lifi_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY lista_fields
    ADD CONSTRAINT fk_usua_lifi_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2196 (class 2606 OID 17118)
-- Dependencies: 183 2101 197 2374
-- Name: fk_usua_list_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY lista
    ADD CONSTRAINT fk_usua_list_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2211 (class 2606 OID 17123)
-- Dependencies: 204 2101 183 2374
-- Name: fk_usua_menu_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY menu
    ADD CONSTRAINT fk_usua_menu_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2213 (class 2606 OID 17128)
-- Dependencies: 206 2101 183 2374
-- Name: fk_usua_mod_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY modulo
    ADD CONSTRAINT fk_usua_mod_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2160 (class 2606 OID 17133)
-- Dependencies: 175 2101 183 2374
-- Name: fk_usua_pess_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoa
    ADD CONSTRAINT fk_usua_pess_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2163 (class 2606 OID 17138)
-- Dependencies: 183 177 2101 2374
-- Name: fk_usua_stat_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbstatus
    ADD CONSTRAINT fk_usua_stat_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2217 (class 2606 OID 17143)
-- Dependencies: 208 183 2101 2374
-- Name: fk_usua_tab_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tabelas
    ADD CONSTRAINT fk_usua_tab_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2220 (class 2606 OID 17148)
-- Dependencies: 183 2101 210 2374
-- Name: fk_usua_tpca_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tipo_campo
    ADD CONSTRAINT fk_usua_tpca_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2166 (class 2606 OID 17153)
-- Dependencies: 179 2101 183 2374
-- Name: fk_usua_unid_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbunidade
    ADD CONSTRAINT fk_usua_unid_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2169 (class 2606 OID 17158)
-- Dependencies: 180 2101 183 2374
-- Name: fk_usua_unpa_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbunidade_parametro
    ADD CONSTRAINT fk_usua_unpa_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2172 (class 2606 OID 17163)
-- Dependencies: 183 2101 183 2374
-- Name: fk_usua_usua_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbusuario
    ADD CONSTRAINT fk_usua_usua_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2175 (class 2606 OID 17168)
-- Dependencies: 184 183 2101 2374
-- Name: fk_usua_usup_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbusuario_privilegio
    ADD CONSTRAINT fk_usua_usup_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


-- Completed on 2013-11-12 15:39:18 BRST

--
-- PostgreSQL database dump complete
--

