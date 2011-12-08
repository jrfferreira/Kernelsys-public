--
-- PostgreSQL database dump
--

-- Dumped from database version 8.4.4
-- Dumped by pg_dump version 9.0.1
-- Started on 2011-01-27 11:48:35

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- TOC entry 371 (class 2612 OID 16386)
-- Name: plpgsql; Type: PROCEDURAL LANGUAGE; Schema: -; Owner: -
--

CREATE OR REPLACE PROCEDURAL LANGUAGE plpgsql;


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 1558 (class 1259 OID 21940)
-- Dependencies: 1875 1876 1877 1878 6
-- Name: abas; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE abas (
    id integer NOT NULL,
    idaba character varying(30),
    nomeaba character varying(40),
    obapendice character varying(110) DEFAULT '-'::character varying NOT NULL,
    action character varying(200) DEFAULT '-'::character varying NOT NULL,
    impressao character(1) DEFAULT '0'::bpchar,
    ordem integer DEFAULT 0
);


--
-- TOC entry 1559 (class 1259 OID 21947)
-- Dependencies: 6 1558
-- Name: abas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE abas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2047 (class 0 OID 0)
-- Dependencies: 1559
-- Name: abas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE abas_id_seq OWNED BY abas.id;


--
-- TOC entry 2048 (class 0 OID 0)
-- Dependencies: 1559
-- Name: abas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('abas_id_seq', 62, true);


--
-- TOC entry 1560 (class 1259 OID 21949)
-- Dependencies: 1880 1881 1882 1883 6
-- Name: blocos; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE blocos (
    id integer NOT NULL,
    blocoid character varying(40),
    nomebloco character varying(50),
    formato character(3),
    entidade integer DEFAULT 0 NOT NULL,
    blocoheight character varying(10) DEFAULT '200px'::character varying,
    ativo integer DEFAULT 1,
    formpai character varying(20) DEFAULT 0,
    obapendice character varying,
    idform character varying(30)
);


--
-- TOC entry 2049 (class 0 OID 0)
-- Dependencies: 1560
-- Name: COLUMN blocos.obapendice; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN blocos.obapendice IS 'refenrencia um apêndice para o bloco
classe/metodo

ps. o metodo chamado como apêndice deve retornar sempre um objeto TElement válido';


--
-- TOC entry 1561 (class 1259 OID 21959)
-- Dependencies: 1560 6
-- Name: blocos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE blocos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2050 (class 0 OID 0)
-- Dependencies: 1561
-- Name: blocos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE blocos_id_seq OWNED BY blocos.id;


--
-- TOC entry 2051 (class 0 OID 0)
-- Dependencies: 1561
-- Name: blocos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('blocos_id_seq', 80, true);


--
-- TOC entry 1562 (class 1259 OID 21961)
-- Dependencies: 1885 6
-- Name: blocos_x_abas; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE blocos_x_abas (
    id integer NOT NULL,
    abaid integer,
    blocoid integer,
    ordem integer DEFAULT 1
);


--
-- TOC entry 1563 (class 1259 OID 21965)
-- Dependencies: 1562 6
-- Name: blocos_x_abas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE blocos_x_abas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2052 (class 0 OID 0)
-- Dependencies: 1563
-- Name: blocos_x_abas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE blocos_x_abas_id_seq OWNED BY blocos_x_abas.id;


--
-- TOC entry 2053 (class 0 OID 0)
-- Dependencies: 1563
-- Name: blocos_x_abas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('blocos_x_abas_id_seq', 78, true);


--
-- TOC entry 1564 (class 1259 OID 21967)
-- Dependencies: 1887 1888 1889 1890 1891 1892 1893 1894 6
-- Name: campos; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE campos (
    id integer NOT NULL,
    colunadb character varying(255),
    campo character varying(80) NOT NULL,
    label character varying(50),
    mascara character varying(150),
    seletor text,
    tipo character varying(30) NOT NULL,
    entidade integer DEFAULT 0 NOT NULL,
    ativafunction integer DEFAULT 0 NOT NULL,
    ativapesquisa integer DEFAULT 0 NOT NULL,
    valorpadrao character varying(200) DEFAULT '-'::character varying NOT NULL,
    outcontrol text,
    incontrol text,
    trigger character varying(150),
    help text,
    ativo integer DEFAULT 1 NOT NULL,
    valornull integer DEFAULT 0,
    alteravel integer DEFAULT 1,
    autosave character varying(1) DEFAULT 0
);


--
-- TOC entry 2054 (class 0 OID 0)
-- Dependencies: 1564
-- Name: COLUMN campos.trigger; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN campos.trigger IS 'função a ser executada quando o campo for carregado';


--
-- TOC entry 2055 (class 0 OID 0)
-- Dependencies: 1564
-- Name: COLUMN campos.autosave; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN campos.autosave IS 'Esepecifica se o campo vai ter a capacidade de disparar a função de onSave no formulário.
0 = not autoSave
1 = yes autoSave';


--
-- TOC entry 1565 (class 1259 OID 21981)
-- Dependencies: 1564 6
-- Name: campos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE campos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2056 (class 0 OID 0)
-- Dependencies: 1565
-- Name: campos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE campos_id_seq OWNED BY campos.id;


--
-- TOC entry 2057 (class 0 OID 0)
-- Dependencies: 1565
-- Name: campos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('campos_id_seq', 344, true);


--
-- TOC entry 1566 (class 1259 OID 21983)
-- Dependencies: 1896 6
-- Name: campos_x_blocos; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE campos_x_blocos (
    id integer NOT NULL,
    blocoid integer,
    campoid integer,
    mostrarcampo character(1),
    formato character(3),
    ordem integer DEFAULT 0 NOT NULL
);


--
-- TOC entry 1567 (class 1259 OID 21987)
-- Dependencies: 6 1566
-- Name: campos_x_blocos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE campos_x_blocos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2058 (class 0 OID 0)
-- Dependencies: 1567
-- Name: campos_x_blocos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE campos_x_blocos_id_seq OWNED BY campos_x_blocos.id;


--
-- TOC entry 2059 (class 0 OID 0)
-- Dependencies: 1567
-- Name: campos_x_blocos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('campos_x_blocos_id_seq', 313, true);


--
-- TOC entry 1568 (class 1259 OID 21989)
-- Dependencies: 6
-- Name: campos_x_propriedades_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE campos_x_propriedades_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2060 (class 0 OID 0)
-- Dependencies: 1568
-- Name: campos_x_propriedades_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('campos_x_propriedades_id_seq', 418, true);


--
-- TOC entry 1569 (class 1259 OID 21991)
-- Dependencies: 1898 1899 6
-- Name: campos_x_propriedades; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE campos_x_propriedades (
    campoid integer NOT NULL,
    metodo character varying(30) NOT NULL,
    valor text NOT NULL,
    ativo integer DEFAULT 1 NOT NULL,
    id integer DEFAULT nextval('campos_x_propriedades_id_seq'::regclass) NOT NULL
);


--
-- TOC entry 2061 (class 0 OID 0)
-- Dependencies: 1569
-- Name: COLUMN campos_x_propriedades.valor; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN campos_x_propriedades.valor IS 'getItens/entidade/campoChave/campoLabel/coluna,operador,chaveAlocaDados;coluna,operador,chaveAlocaDados;...


getItens/ ( Informa para o sistema que o conjunto deve ser compilado em uma transação SQL)
entidade/   ( Informa o entidade que contem os objetos a serem carregados no COMBO/Select)
campoChave/ ( Informa o campo chave a ser retornado da entidade informada a cima, que será o [value] do COMBO)
campoLabel/  ( Informa a coluna da entidade que representará o label da opção select)
coluna, ( Informa a coluna para montagem do criterio de filtro)
operador, ( Informa o operador lógico a ser usado no criterio ex: [=, >, <, !=])
chaveAlocaDados; ( Informa a chave de onde está armazenado no AlocaDados o valor a ser usado como argumento para o criterio, caso a chave não exista o proprio valor é utilizado )

[Apos o  (;) pode ser associado outro filtro se necessario] ';


--
-- TOC entry 1570 (class 1259 OID 21999)
-- Dependencies: 1900 1901 6
-- Name: form_button; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE form_button (
    id integer NOT NULL,
    form integer DEFAULT 0,
    botao character varying(60),
    labelbotao character varying(80),
    confirmacao character varying(255),
    actionjs character varying(120),
    metodo character varying(80),
    ordem character(2),
    ativo character(1) DEFAULT '1'::bpchar
);


--
-- TOC entry 1571 (class 1259 OID 22007)
-- Dependencies: 6 1570
-- Name: form_button_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE form_button_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2062 (class 0 OID 0)
-- Dependencies: 1571
-- Name: form_button_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE form_button_id_seq OWNED BY form_button.id;


--
-- TOC entry 2063 (class 0 OID 0)
-- Dependencies: 1571
-- Name: form_button_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('form_button_id_seq', 1, true);


--
-- TOC entry 1572 (class 1259 OID 22009)
-- Dependencies: 1903 6
-- Name: form_validacao; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE form_validacao (
    id integer NOT NULL,
    formid integer DEFAULT 0
);


--
-- TOC entry 1573 (class 1259 OID 22013)
-- Dependencies: 1572 6
-- Name: form_validacao_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE form_validacao_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2064 (class 0 OID 0)
-- Dependencies: 1573
-- Name: form_validacao_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE form_validacao_id_seq OWNED BY form_validacao.id;


--
-- TOC entry 2065 (class 0 OID 0)
-- Dependencies: 1573
-- Name: form_validacao_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('form_validacao_id_seq', 1, false);


--
-- TOC entry 1574 (class 1259 OID 22015)
-- Dependencies: 1905 1906 6
-- Name: form_x_abas; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE form_x_abas (
    id integer NOT NULL,
    formid integer,
    abaid integer,
    ativo character(1) DEFAULT '1'::bpchar,
    ordem integer DEFAULT 0
);


--
-- TOC entry 1575 (class 1259 OID 22020)
-- Dependencies: 1574 6
-- Name: form_x_abas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE form_x_abas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2066 (class 0 OID 0)
-- Dependencies: 1575
-- Name: form_x_abas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE form_x_abas_id_seq OWNED BY form_x_abas.id;


--
-- TOC entry 2067 (class 0 OID 0)
-- Dependencies: 1575
-- Name: form_x_abas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('form_x_abas_id_seq', 61, true);


--
-- TOC entry 1576 (class 1259 OID 22022)
-- Dependencies: 1908 6
-- Name: form_x_tabelas; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE form_x_tabelas (
    id integer NOT NULL,
    formid integer,
    tabelaid integer,
    ativo character(1) DEFAULT '1'::bpchar
);


--
-- TOC entry 1577 (class 1259 OID 22026)
-- Dependencies: 6 1576
-- Name: form_x_tabelas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE form_x_tabelas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2068 (class 0 OID 0)
-- Dependencies: 1577
-- Name: form_x_tabelas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE form_x_tabelas_id_seq OWNED BY form_x_tabelas.id;


--
-- TOC entry 2069 (class 0 OID 0)
-- Dependencies: 1577
-- Name: form_x_tabelas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('form_x_tabelas_id_seq', 52, true);


--
-- TOC entry 1578 (class 1259 OID 22028)
-- Dependencies: 1910 1911 1912 1913 1914 1915 6
-- Name: forms; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE forms (
    id integer NOT NULL,
    form character varying(50),
    nomeform character varying(60),
    entidade character varying(40),
    ativo character(1) DEFAULT '1'::bpchar,
    formpai character varying(20),
    idlista character varying(30),
    formainclude character varying(30) DEFAULT 'one'::character varying,
    dimensao character varying(10),
    botconcluir character varying(40) DEFAULT 0 NOT NULL,
    botcancelar character varying(1) DEFAULT 0 NOT NULL,
    formoutcontrol character varying(200) DEFAULT 0,
    autosave character varying(1) DEFAULT 1 NOT NULL
);


--
-- TOC entry 2070 (class 0 OID 0)
-- Dependencies: 1578
-- Name: COLUMN forms.dimensao; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN forms.dimensao IS 'dimenção da janela do form
largura;altura';


--
-- TOC entry 2071 (class 0 OID 0)
-- Dependencies: 1578
-- Name: COLUMN forms.botconcluir; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN forms.botconcluir IS 'Habilita ou desabilita o botão padrão do formulário.
0 = desabilitado
1 = ativado
2 = desativado';


--
-- TOC entry 2072 (class 0 OID 0)
-- Dependencies: 1578
-- Name: COLUMN forms.botcancelar; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN forms.botcancelar IS 'Habilita ou desabilita o botão padrão [cancelar] do formulário.
0 = desabilitado
1 = ativado
2 = desativado';


--
-- TOC entry 1579 (class 1259 OID 22037)
-- Dependencies: 1578 6
-- Name: forms_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE forms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2073 (class 0 OID 0)
-- Dependencies: 1579
-- Name: forms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE forms_id_seq OWNED BY forms.id;


--
-- TOC entry 2074 (class 0 OID 0)
-- Dependencies: 1579
-- Name: forms_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('forms_id_seq', 102, true);


--
-- TOC entry 1580 (class 1259 OID 22039)
-- Dependencies: 6
-- Name: info_empresa; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE info_empresa (
    id integer NOT NULL,
    systememp integer,
    nomefantasia character varying(250),
    razaosoc character varying(200),
    empresacnpj character varying(25),
    inscricaoestadual character varying(20),
    inscricaomunicipal character varying(25),
    endereco character varying(160),
    bairro character(6),
    cidade character(3),
    estado character(3),
    tipo character(3)
);


--
-- TOC entry 1581 (class 1259 OID 22045)
-- Dependencies: 6 1580
-- Name: info_empresa_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE info_empresa_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2075 (class 0 OID 0)
-- Dependencies: 1581
-- Name: info_empresa_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE info_empresa_id_seq OWNED BY info_empresa.id;


--
-- TOC entry 2076 (class 0 OID 0)
-- Dependencies: 1581
-- Name: info_empresa_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('info_empresa_id_seq', 1, false);


--
-- TOC entry 1582 (class 1259 OID 22047)
-- Dependencies: 1918 1919 1920 1921 1922 1923 1924 1925 6
-- Name: lista_actions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE lista_actions (
    id integer NOT NULL,
    idlista integer DEFAULT 0 NOT NULL,
    tipocampo character varying(40),
    "nameAction" character varying(60) DEFAULT '-'::character varying NOT NULL,
    label character varying(40) DEFAULT '-'::character varying NOT NULL,
    actionjs character varying(110) DEFAULT '-'::character varying NOT NULL,
    metodoexe character varying(60),
    confirm character varying(200),
    campoparam character varying(30) DEFAULT '-'::character varying NOT NULL,
    img character varying(250) DEFAULT '-'::character varying NOT NULL,
    ordem integer DEFAULT 0 NOT NULL,
    ativo character(1) DEFAULT '1'::bpchar NOT NULL,
    tiporetorno character varying(6)
);


--
-- TOC entry 1583 (class 1259 OID 22061)
-- Dependencies: 1582 6
-- Name: lista_actions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE lista_actions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2077 (class 0 OID 0)
-- Dependencies: 1583
-- Name: lista_actions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE lista_actions_id_seq OWNED BY lista_actions.id;


--
-- TOC entry 2078 (class 0 OID 0)
-- Dependencies: 1583
-- Name: lista_actions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('lista_actions_id_seq', 5, true);


--
-- TOC entry 1584 (class 1259 OID 22063)
-- Dependencies: 1927 1928 6
-- Name: lista_bnav; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE lista_bnav (
    id integer NOT NULL,
    lista_form_id integer DEFAULT 0 NOT NULL,
    nome character varying(40),
    tipocampo character varying(30),
    label character varying(60),
    metodo character varying(40),
    funcaojs character varying(50),
    argumento character varying DEFAULT 0
);


--
-- TOC entry 1585 (class 1259 OID 22071)
-- Dependencies: 1584 6
-- Name: lista_bnav_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE lista_bnav_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2079 (class 0 OID 0)
-- Dependencies: 1585
-- Name: lista_bnav_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE lista_bnav_id_seq OWNED BY lista_bnav.id;


--
-- TOC entry 2080 (class 0 OID 0)
-- Dependencies: 1585
-- Name: lista_bnav_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('lista_bnav_id_seq', 1, false);


--
-- TOC entry 1586 (class 1259 OID 22073)
-- Dependencies: 1930 1931 1932 1933 1934 1935 1936 1937 1938 6
-- Name: lista_colunas; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE lista_colunas (
    id integer NOT NULL,
    lista_form_id integer DEFAULT 0 NOT NULL,
    coluna character varying(60),
    label character varying(60),
    alinhalabel character varying(30),
    alinhadados character varying(30),
    largura integer,
    colfunction character varying(80) DEFAULT '-'::character varying NOT NULL,
    valorpadrao character varying(110) DEFAULT '0'::character varying NOT NULL,
    tipocoluna integer DEFAULT 1,
    entidade_pai integer DEFAULT 0 NOT NULL,
    colunaaux character varying(60) DEFAULT '-'::character varying NOT NULL,
    link character varying(255) DEFAULT '0'::character varying,
    ordem integer DEFAULT 0 NOT NULL,
    ativo character(1) DEFAULT '1'::bpchar
);


--
-- TOC entry 1587 (class 1259 OID 22088)
-- Dependencies: 6 1586
-- Name: lista_colunas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE lista_colunas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2081 (class 0 OID 0)
-- Dependencies: 1587
-- Name: lista_colunas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE lista_colunas_id_seq OWNED BY lista_colunas.id;


--
-- TOC entry 2082 (class 0 OID 0)
-- Dependencies: 1587
-- Name: lista_colunas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('lista_colunas_id_seq', 274, true);


--
-- TOC entry 1588 (class 1259 OID 22090)
-- Dependencies: 1940 1941 1942 1943 1944 6
-- Name: lista_fields; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE lista_fields (
    id integer NOT NULL,
    idlista integer DEFAULT 0 NOT NULL,
    nomecol character varying(70) DEFAULT '-'::character varying NOT NULL,
    labelcol character varying(60),
    idcampo integer DEFAULT 0 NOT NULL,
    ordem integer DEFAULT 0 NOT NULL,
    ativo character(1) DEFAULT '1'::bpchar NOT NULL
);


--
-- TOC entry 1589 (class 1259 OID 22098)
-- Dependencies: 1588 6
-- Name: lista_fields_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE lista_fields_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2083 (class 0 OID 0)
-- Dependencies: 1589
-- Name: lista_fields_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE lista_fields_id_seq OWNED BY lista_fields.id;


--
-- TOC entry 2084 (class 0 OID 0)
-- Dependencies: 1589
-- Name: lista_fields_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('lista_fields_id_seq', 1, false);


--
-- TOC entry 1590 (class 1259 OID 22100)
-- Dependencies: 1946 1947 1948 1949 1950 1951 1952 1953 1954 1955 1956 1957 1958 1959 6
-- Name: lista_form; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE lista_form (
    id integer DEFAULT nextval('forms_id_seq'::regclass) NOT NULL,
    tipo character varying(20),
    forms_id integer DEFAULT 0 NOT NULL,
    filtropai character varying(65) DEFAULT '0'::character varying,
    pesquisa text NOT NULL,
    lista character varying(40),
    label character varying(60),
    entidade integer,
    listapai integer DEFAULT 0 NOT NULL,
    obapendice character varying(120) DEFAULT '-'::character varying NOT NULL,
    acfiltro character(1),
    acincluir character varying(40) DEFAULT '0'::character varying NOT NULL,
    accolunas character(2) DEFAULT '0'::bpchar,
    acdeletar character(1),
    aceditar character(1),
    acviews character(1),
    acenviar character varying(200) DEFAULT '0'::character varying NOT NULL,
    filtro text DEFAULT 'ativo/!=/AND/9'::text,
    ativo character(1) DEFAULT '1'::bpchar,
    formainclude character varying(10) DEFAULT 'one'::bpchar,
    trigger character varying(120),
    incontrol text,
    acreplicar character(1) DEFAULT 0,
    acselecao character varying(2) DEFAULT 0,
    ordem character varying(250) DEFAULT 'datacad/desc;id/desc'::character varying
);


--
-- TOC entry 2085 (class 0 OID 0)
-- Dependencies: 1590
-- Name: COLUMN lista_form.pesquisa; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN lista_form.pesquisa IS 'padrão dos argumentos de retorno da pesquisa.

campo do formulário=coluna entidade[>coluna label],campo do formulário=coluna entidade[>coluna label]';


--
-- TOC entry 2086 (class 0 OID 0)
-- Dependencies: 1590
-- Name: COLUMN lista_form.filtro; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN lista_form.filtro IS 'pos 0 = coluna table
pos 1 = operador logico(=,like,>, etc) pos 2 = operador condicional(OR - AND)
pos 3 = classe ou valor fixo
pos 4 = metodo se o pos 3 for uma classe
pos 5 = se o metodo da classe vai receber o idLista ou não

(O metodo passado como filhtro deve retornar um valor valido e não dever receber nenhum paramentro)';


--
-- TOC entry 2087 (class 0 OID 0)
-- Dependencies: 1590
-- Name: COLUMN lista_form.formainclude; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN lista_form.formainclude IS 'define a forma de inclusão da lista (unitaria) ou (multipla)';


--
-- TOC entry 2088 (class 0 OID 0)
-- Dependencies: 1590
-- Name: COLUMN lista_form.trigger; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN lista_form.trigger IS 'Ações [JavaScript] a serem executadas quando a lista for carregada ou recarregada

';


--
-- TOC entry 2089 (class 0 OID 0)
-- Dependencies: 1590
-- Name: COLUMN lista_form.incontrol; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN lista_form.incontrol IS 'Regras de negócio a serem aplicadas nas ações da lista.
Ex: botão adicionar, excluir, editar
padrão de execução TSetControl';


--
-- TOC entry 2090 (class 0 OID 0)
-- Dependencies: 1590
-- Name: COLUMN lista_form.ordem; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN lista_form.ordem IS 'Padrão: (coluna)/(ordenação)?
Ex: id/desc;datacad';


--
-- TOC entry 1591 (class 1259 OID 22120)
-- Dependencies: 1590 6
-- Name: lista_form_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE lista_form_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2091 (class 0 OID 0)
-- Dependencies: 1591
-- Name: lista_form_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE lista_form_id_seq OWNED BY lista_form.id;


--
-- TOC entry 2092 (class 0 OID 0)
-- Dependencies: 1591
-- Name: lista_form_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('lista_form_id_seq', 1, false);


--
-- TOC entry 1592 (class 1259 OID 22122)
-- Dependencies: 6
-- Name: menu_modulos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE menu_modulos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2093 (class 0 OID 0)
-- Dependencies: 1592
-- Name: menu_modulos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('menu_modulos_id_seq', 21, true);


--
-- TOC entry 1593 (class 1259 OID 22124)
-- Dependencies: 1960 1961 1962 1963 1964 1965 6
-- Name: menu_modulos; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE menu_modulos (
    id integer DEFAULT nextval('menu_modulos_id_seq'::regclass) NOT NULL,
    modulo character varying(60),
    labelmodulo character varying(80),
    metodo character varying(255) DEFAULT '-'::character varying NOT NULL,
    argumento integer DEFAULT 0 NOT NULL,
    form integer DEFAULT 0 NOT NULL,
    nivel character varying(6),
    moduloprincipal integer,
    ordem integer DEFAULT 0,
    ativo character(1) DEFAULT '1'::bpchar
);


--
-- TOC entry 1594 (class 1259 OID 22133)
-- Dependencies: 1966 1967 6
-- Name: modulos_principais; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE modulos_principais (
    id integer NOT NULL,
    modulo character varying(60),
    labelmodulo character varying(80),
    nivel integer,
    ordem integer DEFAULT 0,
    ativo character(1) DEFAULT '1'::bpchar
);


--
-- TOC entry 1595 (class 1259 OID 22138)
-- Dependencies: 6 1594
-- Name: modulos_principais_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE modulos_principais_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2094 (class 0 OID 0)
-- Dependencies: 1595
-- Name: modulos_principais_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE modulos_principais_id_seq OWNED BY modulos_principais.id;


--
-- TOC entry 2095 (class 0 OID 0)
-- Dependencies: 1595
-- Name: modulos_principais_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('modulos_principais_id_seq', 6, true);


--
-- TOC entry 1596 (class 1259 OID 22140)
-- Dependencies: 1969 1970 1971 6
-- Name: tabelas; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE tabelas (
    id integer NOT NULL,
    tabela character varying(120) NOT NULL,
    tabela_view character varying(120) DEFAULT '-'::character varying NOT NULL,
    tabpai character varying(120) DEFAULT '-'::character varying NOT NULL,
    ativo integer DEFAULT 1 NOT NULL,
    colunafilho character varying(40)
);


--
-- TOC entry 2096 (class 0 OID 0)
-- Dependencies: 1596
-- Name: COLUMN tabelas.colunafilho; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN tabelas.colunafilho IS 'Nome da coluna necessar para todos os filhos da tabela em questão';


--
-- TOC entry 1597 (class 1259 OID 22146)
-- Dependencies: 6 1596
-- Name: tabelas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE tabelas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2097 (class 0 OID 0)
-- Dependencies: 1597
-- Name: tabelas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE tabelas_id_seq OWNED BY tabelas.id;


--
-- TOC entry 2098 (class 0 OID 0)
-- Dependencies: 1597
-- Name: tabelas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('tabelas_id_seq', 55, true);


--
-- TOC entry 1879 (class 2604 OID 22148)
-- Dependencies: 1559 1558
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE abas ALTER COLUMN id SET DEFAULT nextval('abas_id_seq'::regclass);


--
-- TOC entry 1884 (class 2604 OID 22149)
-- Dependencies: 1561 1560
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE blocos ALTER COLUMN id SET DEFAULT nextval('blocos_id_seq'::regclass);


--
-- TOC entry 1886 (class 2604 OID 22150)
-- Dependencies: 1563 1562
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE blocos_x_abas ALTER COLUMN id SET DEFAULT nextval('blocos_x_abas_id_seq'::regclass);


--
-- TOC entry 1895 (class 2604 OID 22151)
-- Dependencies: 1565 1564
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE campos ALTER COLUMN id SET DEFAULT nextval('campos_id_seq'::regclass);


--
-- TOC entry 1897 (class 2604 OID 22152)
-- Dependencies: 1567 1566
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE campos_x_blocos ALTER COLUMN id SET DEFAULT nextval('campos_x_blocos_id_seq'::regclass);


--
-- TOC entry 1902 (class 2604 OID 22153)
-- Dependencies: 1571 1570
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE form_button ALTER COLUMN id SET DEFAULT nextval('form_button_id_seq'::regclass);


--
-- TOC entry 1904 (class 2604 OID 22154)
-- Dependencies: 1573 1572
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE form_validacao ALTER COLUMN id SET DEFAULT nextval('form_validacao_id_seq'::regclass);


--
-- TOC entry 1907 (class 2604 OID 22155)
-- Dependencies: 1575 1574
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE form_x_abas ALTER COLUMN id SET DEFAULT nextval('form_x_abas_id_seq'::regclass);


--
-- TOC entry 1909 (class 2604 OID 22156)
-- Dependencies: 1577 1576
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE form_x_tabelas ALTER COLUMN id SET DEFAULT nextval('form_x_tabelas_id_seq'::regclass);


--
-- TOC entry 1916 (class 2604 OID 22157)
-- Dependencies: 1579 1578
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE forms ALTER COLUMN id SET DEFAULT nextval('forms_id_seq'::regclass);


--
-- TOC entry 1917 (class 2604 OID 22158)
-- Dependencies: 1581 1580
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE info_empresa ALTER COLUMN id SET DEFAULT nextval('info_empresa_id_seq'::regclass);


--
-- TOC entry 1926 (class 2604 OID 22159)
-- Dependencies: 1583 1582
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE lista_actions ALTER COLUMN id SET DEFAULT nextval('lista_actions_id_seq'::regclass);


--
-- TOC entry 1929 (class 2604 OID 22160)
-- Dependencies: 1585 1584
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE lista_bnav ALTER COLUMN id SET DEFAULT nextval('lista_bnav_id_seq'::regclass);


--
-- TOC entry 1939 (class 2604 OID 22161)
-- Dependencies: 1587 1586
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE lista_colunas ALTER COLUMN id SET DEFAULT nextval('lista_colunas_id_seq'::regclass);


--
-- TOC entry 1945 (class 2604 OID 22162)
-- Dependencies: 1589 1588
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE lista_fields ALTER COLUMN id SET DEFAULT nextval('lista_fields_id_seq'::regclass);


--
-- TOC entry 1968 (class 2604 OID 22163)
-- Dependencies: 1595 1594
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE modulos_principais ALTER COLUMN id SET DEFAULT nextval('modulos_principais_id_seq'::regclass);


--
-- TOC entry 1972 (class 2604 OID 22164)
-- Dependencies: 1597 1596
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE tabelas ALTER COLUMN id SET DEFAULT nextval('tabelas_id_seq'::regclass);


--
-- TOC entry 2022 (class 0 OID 21940)
-- Dependencies: 1558
-- Data for Name: abas; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO abas (id, idaba, nomeaba, obapendice, action, impressao, ordem) VALUES (1, 'dadosUsuario', 'Dados do Usuário', '-', '-', '0', 1);
INSERT INTO abas (id, idaba, nomeaba, obapendice, action, impressao, ordem) VALUES (2, 'privilegiosUsuario', 'Privilégios', 'TPrivilegios/viewGetModulos', '-', '0', 2);
INSERT INTO abas (id, idaba, nomeaba, obapendice, action, impressao, ordem) VALUES (3, 'dadosPatrimonio', 'Patrimônio', '-', '-', '0', 1);
INSERT INTO abas (id, idaba, nomeaba, obapendice, action, impressao, ordem) VALUES (4, 'fotosPatrimonio', 'Fotos', '-', '-', '0', 2);
INSERT INTO abas (id, idaba, nomeaba, obapendice, action, impressao, ordem) VALUES (5, 'fotos', 'Foto', '-', '-', '0', 1);
INSERT INTO abas (id, idaba, nomeaba, obapendice, action, impressao, ordem) VALUES (6, 'sala', 'Sala', '-', '-', '0', 1);
INSERT INTO abas (id, idaba, nomeaba, obapendice, action, impressao, ordem) VALUES (7, 'departamento', 'Departamento', '-', '-', '0', 1);
INSERT INTO abas (id, idaba, nomeaba, obapendice, action, impressao, ordem) VALUES (8, 'produto', 'Produto', '-', '-', '0', 1);
INSERT INTO abas (id, idaba, nomeaba, obapendice, action, impressao, ordem) VALUES (41, 'vendedor_x_condPag', 'Condição de Pagamento', '-', '-', '0', 1);
INSERT INTO abas (id, idaba, nomeaba, obapendice, action, impressao, ordem) VALUES (42, 'infoPedido', 'Informações do Pedido', '-', '-', '0', 1);
INSERT INTO abas (id, idaba, nomeaba, obapendice, action, impressao, ordem) VALUES (43, 'infoFaturamento', 'Faturamento', '-', '-', '0', 2);
INSERT INTO abas (id, idaba, nomeaba, obapendice, action, impressao, ordem) VALUES (44, 'caracteristicas', 'Caracteristicas', '-', '-', '0', 2);
INSERT INTO abas (id, idaba, nomeaba, obapendice, action, impressao, ordem) VALUES (45, 'infoVendedor', 'Informações para Vendedor', '-', '-', '0', 6);
INSERT INTO abas (id, idaba, nomeaba, obapendice, action, impressao, ordem) VALUES (9, 'contato', 'Contato', '-', '-', '0', 0);
INSERT INTO abas (id, idaba, nomeaba, obapendice, action, impressao, ordem) VALUES (10, 'dadosPrincipais', 'Dados Principais', '-', '-', '0', 0);
INSERT INTO abas (id, idaba, nomeaba, obapendice, action, impressao, ordem) VALUES (20, 'dadosPessoais', 'Dados Pessoais', '-', '-', '0', 0);
INSERT INTO abas (id, idaba, nomeaba, obapendice, action, impressao, ordem) VALUES (21, 'dadosComplementares', 'Dados Complementares', '-', '-', '0', 0);
INSERT INTO abas (id, idaba, nomeaba, obapendice, action, impressao, ordem) VALUES (22, 'dadosAdministrativos', 'Dados Administrativos', '-', '-', '0', 0);
INSERT INTO abas (id, idaba, nomeaba, obapendice, action, impressao, ordem) VALUES (24, 'aba_blocoFormacao', 'Formação', '-', '-', '0', 1);
INSERT INTO abas (id, idaba, nomeaba, obapendice, action, impressao, ordem) VALUES (25, 'aba_listTreinamento', '-', '-', '-', '0', 1);
INSERT INTO abas (id, idaba, nomeaba, obapendice, action, impressao, ordem) VALUES (34, 'transac_InfoC', 'Informações Principais', '-', '-', '0', 1);
INSERT INTO abas (id, idaba, nomeaba, obapendice, action, impressao, ordem) VALUES (35, 'aba_lstProdutosTransacaoD', 'Produtos', '-', '-', '0', 1);
INSERT INTO abas (id, idaba, nomeaba, obapendice, action, impressao, ordem) VALUES (36, 'transac_condC', 'Condições de Pagamento', '-', '-', '0', 2);
INSERT INTO abas (id, idaba, nomeaba, obapendice, action, impressao, ordem) VALUES (38, 'formaPag', 'Condição de Pagamento', '-', '-', '0', 1);
INSERT INTO abas (id, idaba, nomeaba, obapendice, action, impressao, ordem) VALUES (39, 'produtoFormacaoPreco', 'Formação de Preço', '-', '-', '0', 3);
INSERT INTO abas (id, idaba, nomeaba, obapendice, action, impressao, ordem) VALUES (40, 'produtoMarkup', 'Formulação de Preço', '-', '-', '0', 1);
INSERT INTO abas (id, idaba, nomeaba, obapendice, action, impressao, ordem) VALUES (37, 'aba_listContasTransacaoC', 'Contas', '-', '-', '0', 1);
INSERT INTO abas (id, idaba, nomeaba, obapendice, action, impressao, ordem) VALUES (46, 'detMovimentacao', 'Detalhe da Movimentação', '-', '-', '0', 1);
INSERT INTO abas (id, idaba, nomeaba, obapendice, action, impressao, ordem) VALUES (47, 'ajusteContagem', 'Ajuste Contagem', '-', '-', '0', 1);
INSERT INTO abas (id, idaba, nomeaba, obapendice, action, impressao, ordem) VALUES (48, 'conferenciaProduto', 'Conferência', '-', '-', '0', 1);
INSERT INTO abas (id, idaba, nomeaba, obapendice, action, impressao, ordem) VALUES (49, 'transacaoDadosPrincipais', 'Dados Principais', '-', '-', '0', 1);
INSERT INTO abas (id, idaba, nomeaba, obapendice, action, impressao, ordem) VALUES (50, 'transacaoItens', 'Itens', '-', '-', '0', 2);
INSERT INTO abas (id, idaba, nomeaba, obapendice, action, impressao, ordem) VALUES (51, 'transacaoTotalizador', 'Totalizador', '-', '-', '0', 3);
INSERT INTO abas (id, idaba, nomeaba, obapendice, action, impressao, ordem) VALUES (52, 'transacaoNfe', 'NF-e', '-', '-', '0', 4);
INSERT INTO abas (id, idaba, nomeaba, obapendice, action, impressao, ordem) VALUES (53, 'transacItemInfo', 'Informações do Item', '-', '-', '0', 1);
INSERT INTO abas (id, idaba, nomeaba, obapendice, action, impressao, ordem) VALUES (55, 'prodDGDadosbasicos', 'Dados Principais', '-', '-', '0', 1);
INSERT INTO abas (id, idaba, nomeaba, obapendice, action, impressao, ordem) VALUES (56, 'prodDGSimilares', 'Sinônimos e Similares', '-', '-', '0', 2);
INSERT INTO abas (id, idaba, nomeaba, obapendice, action, impressao, ordem) VALUES (57, 'prodSimilar', 'Produtos Similares', '-', '-', '0', 1);
INSERT INTO abas (id, idaba, nomeaba, obapendice, action, impressao, ordem) VALUES (59, 'prodEstoque', 'Estoque', '-', '-', '0', 1);
INSERT INTO abas (id, idaba, nomeaba, obapendice, action, impressao, ordem) VALUES (60, 'vendaInfo', 'Informações da Venda', '-', '-', '0', 1);
INSERT INTO abas (id, idaba, nomeaba, obapendice, action, impressao, ordem) VALUES (61, 'vendaTot', 'Totalizador', '-', '-', '0', 2);
INSERT INTO abas (id, idaba, nomeaba, obapendice, action, impressao, ordem) VALUES (62, 'vendaItens', 'Itens da Venda', '-', '-', '0', 3);


--
-- TOC entry 2023 (class 0 OID 21949)
-- Dependencies: 1560
-- Data for Name: blocos; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO blocos (id, blocoid, nomebloco, formato, entidade, blocoheight, ativo, formpai, obapendice, idform) VALUES (4, 'patrimonioFotos', 'Imagens', 'lst', 5, '380px', 1, '3', NULL, '5');
INSERT INTO blocos (id, blocoid, nomebloco, formato, entidade, blocoheight, ativo, formpai, obapendice, idform) VALUES (47, 'formaPag', 'Descrição', 'frm', 48, '200px', 1, '54', NULL, '0');
INSERT INTO blocos (id, blocoid, nomebloco, formato, entidade, blocoheight, ativo, formpai, obapendice, idform) VALUES (53, 'bloc_faturamento_pedidoProdutos', 'Produtos do Pedido', 'lst', 42, '200px', 1, '65', NULL, '69');
INSERT INTO blocos (id, blocoid, nomebloco, formato, entidade, blocoheight, ativo, formpai, obapendice, idform) VALUES (48, 'produtosAtribuicao', 'Atribuições de Preços', 'lst', 49, '380px', 1, '9', NULL, '58');
INSERT INTO blocos (id, blocoid, nomebloco, formato, entidade, blocoheight, ativo, formpai, obapendice, idform) VALUES (56, 'bloc_dadosVendedor', 'Condições de Pagamento', 'lst', 50, '380px', 1, '30', NULL, '63');
INSERT INTO blocos (id, blocoid, nomebloco, formato, entidade, blocoheight, ativo, formpai, obapendice, idform) VALUES (57, 'informacaoMercadoria', 'Informações', 'frm', 10, '200px', 1, '0', NULL, '72');
INSERT INTO blocos (id, blocoid, nomebloco, formato, entidade, blocoheight, ativo, formpai, obapendice, idform) VALUES (52, 'bloc_faturamento_pedidoInformacoes', 'Informações do Pedido', 'frm', 42, '380px', 1, '65', NULL, '0');
INSERT INTO blocos (id, blocoid, nomebloco, formato, entidade, blocoheight, ativo, formpai, obapendice, idform) VALUES (54, 'bloc_caractProduto', 'Detalhamento', 'frm', 51, '200px', 1, '9', NULL, '0');
INSERT INTO blocos (id, blocoid, nomebloco, formato, entidade, blocoheight, ativo, formpai, obapendice, idform) VALUES (69, 'prodDGSimilares', 'Similares', 'lst', 54, '280px', 1, '85', NULL, '87');
INSERT INTO blocos (id, blocoid, nomebloco, formato, entidade, blocoheight, ativo, formpai, obapendice, idform) VALUES (51, 'bloco_vendedor_x_condPag', 'Relacionamento', 'frm', 50, '380px', 1, '63', NULL, '0');
INSERT INTO blocos (id, blocoid, nomebloco, formato, entidade, blocoheight, ativo, formpai, obapendice, idform) VALUES (72, 'prodSimilar', 'Produto Similar', 'frm', 55, '380px', 1, '85', NULL, '87');
INSERT INTO blocos (id, blocoid, nomebloco, formato, entidade, blocoheight, ativo, formpai, obapendice, idform) VALUES (1, 'usuario', 'Dados', 'frm', 1, '200px', 1, '1', NULL, '0');
INSERT INTO blocos (id, blocoid, nomebloco, formato, entidade, blocoheight, ativo, formpai, obapendice, idform) VALUES (70, 'prodDGSinonimos', 'Sinônimos', 'frm', 54, '380px', 1, '85', NULL, '0');
INSERT INTO blocos (id, blocoid, nomebloco, formato, entidade, blocoheight, ativo, formpai, obapendice, idform) VALUES (68, 'prodDGDadosBasicaos', 'Dados Principais', 'frm', 54, '380px', 1, '85', NULL, '0');
INSERT INTO blocos (id, blocoid, nomebloco, formato, entidade, blocoheight, ativo, formpai, obapendice, idform) VALUES (50, 'prodPreco', 'Valor Final', 'frm', 49, '200px', 1, '58', 'TProduto/apendiceSetValor', '0');
INSERT INTO blocos (id, blocoid, nomebloco, formato, entidade, blocoheight, ativo, formpai, obapendice, idform) VALUES (49, 'produtosMarkup', 'Detalhe', 'frm', 49, '380px', 1, '58', NULL, '0');
INSERT INTO blocos (id, blocoid, nomebloco, formato, entidade, blocoheight, ativo, formpai, obapendice, idform) VALUES (66, 'detiTEMTransac', 'Item', 'frm', 43, '380px', 1, '79', NULL, '0');
INSERT INTO blocos (id, blocoid, nomebloco, formato, entidade, blocoheight, ativo, formpai, obapendice, idform) VALUES (65, 'transacNFe', 'Nota Fiscal Eletrônica', 'frm', 42, '380px', 1, '79', NULL, '0');
INSERT INTO blocos (id, blocoid, nomebloco, formato, entidade, blocoheight, ativo, formpai, obapendice, idform) VALUES (24, 'blocoDadosAdminist', 'Dados Administrativos', 'frm', 0, '200px', 1, '30', NULL, '0');
INSERT INTO blocos (id, blocoid, nomebloco, formato, entidade, blocoheight, ativo, formpai, obapendice, idform) VALUES (63, 'transacListaIntens', 'Lista de Itens', 'lst', 43, '380px', 1, '79', NULL, '81');
INSERT INTO blocos (id, blocoid, nomebloco, formato, entidade, blocoheight, ativo, formpai, obapendice, idform) VALUES (9, 'contatos', 'Contatos', 'frm', 3, '200px', 1, '18', NULL, '0');
INSERT INTO blocos (id, blocoid, nomebloco, formato, entidade, blocoheight, ativo, formpai, obapendice, idform) VALUES (10, 'tipoCadastro', 'Tipo de Cadastro', 'frm', 3, '200px', 1, '18', NULL, '0');
INSERT INTO blocos (id, blocoid, nomebloco, formato, entidade, blocoheight, ativo, formpai, obapendice, idform) VALUES (64, 'transacTotalizador', 'Totalizador', 'frm', 42, '380px', 1, '79', NULL, '0');
INSERT INTO blocos (id, blocoid, nomebloco, formato, entidade, blocoheight, ativo, formpai, obapendice, idform) VALUES (62, 'transacDadosNota', 'Informações da Nota', 'frm', 42, '380px', 1, '79', NULL, '0');
INSERT INTO blocos (id, blocoid, nomebloco, formato, entidade, blocoheight, ativo, formpai, obapendice, idform) VALUES (61, 'transacDadosCliente', 'Dados do Cliente', 'frm', 42, '380px', 1, '79', NULL, '0');
INSERT INTO blocos (id, blocoid, nomebloco, formato, entidade, blocoheight, ativo, formpai, obapendice, idform) VALUES (60, 'transacDadosEmpresa', 'Dados da Empresa', 'frm', 42, '380px', 1, '79', NULL, '0');
INSERT INTO blocos (id, blocoid, nomebloco, formato, entidade, blocoheight, ativo, formpai, obapendice, idform) VALUES (59, 'dadosConferencia', 'Dados Conferência', 'frm', 52, '380px', 1, '77', NULL, '0');
INSERT INTO blocos (id, blocoid, nomebloco, formato, entidade, blocoheight, ativo, formpai, obapendice, idform) VALUES (58, 'dadosContagem', 'Dados Contagem', 'frm', 52, '380px', 1, '75', NULL, '0');
INSERT INTO blocos (id, blocoid, nomebloco, formato, entidade, blocoheight, ativo, formpai, obapendice, idform) VALUES (55, 'bloc_medidas', 'Medidas', 'frm', 51, '200px', 1, '9', NULL, '0');
INSERT INTO blocos (id, blocoid, nomebloco, formato, entidade, blocoheight, ativo, formpai, obapendice, idform) VALUES (23, 'blocoDadosComplementaresFuncionarios', 'Dados Complementares', 'frm', 0, '200px', 1, '30', '', '0');
INSERT INTO blocos (id, blocoid, nomebloco, formato, entidade, blocoheight, ativo, formpai, obapendice, idform) VALUES (8, 'produto', 'Dados do Produto', 'frm', 9, '380px', 1, '0', NULL, '0');
INSERT INTO blocos (id, blocoid, nomebloco, formato, entidade, blocoheight, ativo, formpai, obapendice, idform) VALUES (7, 'departamento', 'Departamento', 'frm', 8, '200px', 1, '0', NULL, '0');
INSERT INTO blocos (id, blocoid, nomebloco, formato, entidade, blocoheight, ativo, formpai, obapendice, idform) VALUES (6, 'sala', 'Dados da Sala', 'frm', 7, '380px', 1, '0', NULL, '0');
INSERT INTO blocos (id, blocoid, nomebloco, formato, entidade, blocoheight, ativo, formpai, obapendice, idform) VALUES (5, 'foto', 'Foto', 'frm', 5, '380px', 1, '0', NULL, '0');
INSERT INTO blocos (id, blocoid, nomebloco, formato, entidade, blocoheight, ativo, formpai, obapendice, idform) VALUES (3, 'patrimonio', 'Dados do Patrimônio', 'frm', 4, '380px', 1, '0', NULL, '0');
INSERT INTO blocos (id, blocoid, nomebloco, formato, entidade, blocoheight, ativo, formpai, obapendice, idform) VALUES (2, 'senha', 'Senha', 'frm', 1, '380px', 1, '1', 'TUsuario/apendicePassword', '0');
INSERT INTO blocos (id, blocoid, nomebloco, formato, entidade, blocoheight, ativo, formpai, obapendice, idform) VALUES (43, 'bloco_listContasTransacaoC', 'Dados da conta', 'frm', 44, '200px', 1, '52', NULL, '0');
INSERT INTO blocos (id, blocoid, nomebloco, formato, entidade, blocoheight, ativo, formpai, obapendice, idform) VALUES (73, 'transacDGImpressao', 'Imprimir Pedido', 'frm', 42, '200px', 1, '79', 'TTransacao/viewOrcamento', '0');
INSERT INTO blocos (id, blocoid, nomebloco, formato, entidade, blocoheight, ativo, formpai, obapendice, idform) VALUES (13, 'bloco_blocPessoaConvenios', 'Lista de convênios', 'frm', 16, '200px', 1, '20', NULL, '0');
INSERT INTO blocos (id, blocoid, nomebloco, formato, entidade, blocoheight, ativo, formpai, obapendice, idform) VALUES (14, 'blocPessoaConvenios', 'Lista de convênios', 'lst', 15, '400px', 1, '18', NULL, '20');
INSERT INTO blocos (id, blocoid, nomebloco, formato, entidade, blocoheight, ativo, formpai, obapendice, idform) VALUES (29, 'listTreinamento', '--------', 'lst', 34, '200px', 1, '30', NULL, '34');
INSERT INTO blocos (id, blocoid, nomebloco, formato, entidade, blocoheight, ativo, formpai, obapendice, idform) VALUES (40, 'bloco_produtostransacao', 'Dados do produto', 'frm', 43, '200px', 1, '50', NULL, '0');
INSERT INTO blocos (id, blocoid, nomebloco, formato, entidade, blocoheight, ativo, formpai, obapendice, idform) VALUES (45, 'listContasTransacaoC', 'Contas', 'lst', 42, '250px', 1, '48', NULL, '52');
INSERT INTO blocos (id, blocoid, nomebloco, formato, entidade, blocoheight, ativo, formpai, obapendice, idform) VALUES (44, 'informacoesCheque', 'Informações do Cheque', 'frm', 45, '200px', 1, '52', NULL, '0');
INSERT INTO blocos (id, blocoid, nomebloco, formato, entidade, blocoheight, ativo, formpai, obapendice, idform) VALUES (27, 'blocoFormacao', 'Formação', 'lst', 0, '200px', 1, '30', NULL, '32');
INSERT INTO blocos (id, blocoid, nomebloco, formato, entidade, blocoheight, ativo, formpai, obapendice, idform) VALUES (26, 'bloco_blocoFormacao', 'Formação', 'frm', 14, '200px', 1, '32', NULL, '0');
INSERT INTO blocos (id, blocoid, nomebloco, formato, entidade, blocoheight, ativo, formpai, obapendice, idform) VALUES (17, 'histCliente-Mov', 'Histórico de Movimentações', 'lst', 18, '380px', 1, '18', NULL, '24');
INSERT INTO blocos (id, blocoid, nomebloco, formato, entidade, blocoheight, ativo, formpai, obapendice, idform) VALUES (15, 'bloco_blocoListaInteresses', 'Interesses', 'frm', 17, '200px', 1, '22', NULL, '0');
INSERT INTO blocos (id, blocoid, nomebloco, formato, entidade, blocoheight, ativo, formpai, obapendice, idform) VALUES (28, 'bloco_listTreinamento', '--------', 'frm', 34, '200px', 1, '34', NULL, '0');
INSERT INTO blocos (id, blocoid, nomebloco, formato, entidade, blocoheight, ativo, formpai, obapendice, idform) VALUES (16, 'blocoListaInteresses', 'Interesses', 'lst', 17, '400px', 1, '18', NULL, '22');
INSERT INTO blocos (id, blocoid, nomebloco, formato, entidade, blocoheight, ativo, formpai, obapendice, idform) VALUES (41, 'lstProdutosTransacaoC', 'Itens do Pedido', 'lst', 43, '250px', 1, '48', NULL, '50');
INSERT INTO blocos (id, blocoid, nomebloco, formato, entidade, blocoheight, ativo, formpai, obapendice, idform) VALUES (46, 'gerenciarTransacaoContasC', 'Condição de Pagamento', 'frm', 0, '200px', 1, '48', NULL, '0');
INSERT INTO blocos (id, blocoid, nomebloco, formato, entidade, blocoheight, ativo, formpai, obapendice, idform) VALUES (25, 'infoFolhaPag', 'Informações para Folha de Pagamento', 'frm', 0, '200px', 1, '30', NULL, '0');
INSERT INTO blocos (id, blocoid, nomebloco, formato, entidade, blocoheight, ativo, formpai, obapendice, idform) VALUES (42, 'bloc_transac_InformacoesBasicasC', 'Cabeçalho do pedido', 'frm', 0, '200px', 1, '48', NULL, '0');
INSERT INTO blocos (id, blocoid, nomebloco, formato, entidade, blocoheight, ativo, formpai, obapendice, idform) VALUES (11, 'pessoaJuridica', 'Pessoa Jurídica', 'frm', 3, '200px', 1, '18', NULL, '0');
INSERT INTO blocos (id, blocoid, nomebloco, formato, entidade, blocoheight, ativo, formpai, obapendice, idform) VALUES (12, 'pessoaFisica', 'Pessoa Física', 'frm', 3, '200px', 1, '18', NULL, '0');
INSERT INTO blocos (id, blocoid, nomebloco, formato, entidade, blocoheight, ativo, formpai, obapendice, idform) VALUES (22, 'blocoDadosFuncionarios', 'Dados Principais', 'frm', 3, '200px', 1, '30', NULL, '0');
INSERT INTO blocos (id, blocoid, nomebloco, formato, entidade, blocoheight, ativo, formpai, obapendice, idform) VALUES (74, 'null', NULL, NULL, 0, '200px', 1, '0', NULL, '0');
INSERT INTO blocos (id, blocoid, nomebloco, formato, entidade, blocoheight, ativo, formpai, obapendice, idform) VALUES (71, 'prodDGEstoques', 'Estoques', 'lst', 56, '200px', 1, '85', NULL, '94');
INSERT INTO blocos (id, blocoid, nomebloco, formato, entidade, blocoheight, ativo, formpai, obapendice, idform) VALUES (75, 'prodEstoque', 'Detalhe', 'frm', 56, '200px', 1, '85', NULL, '0');
INSERT INTO blocos (id, blocoid, nomebloco, formato, entidade, blocoheight, ativo, formpai, obapendice, idform) VALUES (76, 'InfoVenda', 'Informações da Venda', 'frm', 42, '200px', 1, '96', NULL, '0');
INSERT INTO blocos (id, blocoid, nomebloco, formato, entidade, blocoheight, ativo, formpai, obapendice, idform) VALUES (77, 'dadosEmpresa', 'Dados da Empresa', 'frm', 42, '200px', 1, '96', NULL, '0');
INSERT INTO blocos (id, blocoid, nomebloco, formato, entidade, blocoheight, ativo, formpai, obapendice, idform) VALUES (78, 'dadosCliente', 'Dados do Cliente', 'frm', 42, '200px', 1, '96', NULL, NULL);
INSERT INTO blocos (id, blocoid, nomebloco, formato, entidade, blocoheight, ativo, formpai, obapendice, idform) VALUES (79, 'totalizador', 'Totalizador', 'frm', 42, '200px', 1, '96', NULL, NULL);
INSERT INTO blocos (id, blocoid, nomebloco, formato, entidade, blocoheight, ativo, formpai, obapendice, idform) VALUES (80, 'itens', 'Itens', 'lst', 43, '380px', 1, '96', NULL, '102');


--
-- TOC entry 2024 (class 0 OID 21961)
-- Dependencies: 1562
-- Data for Name: blocos_x_abas; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO blocos_x_abas (id, abaid, blocoid, ordem) VALUES (1, 1, 1, 1);
INSERT INTO blocos_x_abas (id, abaid, blocoid, ordem) VALUES (2, 1, 2, 2);
INSERT INTO blocos_x_abas (id, abaid, blocoid, ordem) VALUES (3, 3, 3, 1);
INSERT INTO blocos_x_abas (id, abaid, blocoid, ordem) VALUES (4, 4, 4, 1);
INSERT INTO blocos_x_abas (id, abaid, blocoid, ordem) VALUES (5, 5, 5, 1);
INSERT INTO blocos_x_abas (id, abaid, blocoid, ordem) VALUES (6, 6, 6, 1);
INSERT INTO blocos_x_abas (id, abaid, blocoid, ordem) VALUES (7, 7, 7, 1);
INSERT INTO blocos_x_abas (id, abaid, blocoid, ordem) VALUES (8, 8, 8, 1);
INSERT INTO blocos_x_abas (id, abaid, blocoid, ordem) VALUES (9, 9, 9, 2);
INSERT INTO blocos_x_abas (id, abaid, blocoid, ordem) VALUES (10, 10, 10, 1);
INSERT INTO blocos_x_abas (id, abaid, blocoid, ordem) VALUES (11, 10, 11, 1);
INSERT INTO blocos_x_abas (id, abaid, blocoid, ordem) VALUES (12, 10, 12, 1);
INSERT INTO blocos_x_abas (id, abaid, blocoid, ordem) VALUES (13, 12, 13, 1);
INSERT INTO blocos_x_abas (id, abaid, blocoid, ordem) VALUES (14, 11, 14, 4);
INSERT INTO blocos_x_abas (id, abaid, blocoid, ordem) VALUES (15, 14, 15, 1);
INSERT INTO blocos_x_abas (id, abaid, blocoid, ordem) VALUES (16, 13, 16, 5);
INSERT INTO blocos_x_abas (id, abaid, blocoid, ordem) VALUES (17, 15, 17, 6);
INSERT INTO blocos_x_abas (id, abaid, blocoid, ordem) VALUES (20, 20, 22, 0);
INSERT INTO blocos_x_abas (id, abaid, blocoid, ordem) VALUES (21, 21, 23, 0);
INSERT INTO blocos_x_abas (id, abaid, blocoid, ordem) VALUES (22, 22, 24, 0);
INSERT INTO blocos_x_abas (id, abaid, blocoid, ordem) VALUES (23, 22, 25, 0);
INSERT INTO blocos_x_abas (id, abaid, blocoid, ordem) VALUES (24, 24, 26, 1);
INSERT INTO blocos_x_abas (id, abaid, blocoid, ordem) VALUES (25, 23, 27, 0);
INSERT INTO blocos_x_abas (id, abaid, blocoid, ordem) VALUES (26, 25, 28, 1);
INSERT INTO blocos_x_abas (id, abaid, blocoid, ordem) VALUES (27, 23, 29, 0);
INSERT INTO blocos_x_abas (id, abaid, blocoid, ordem) VALUES (36, 35, 40, 1);
INSERT INTO blocos_x_abas (id, abaid, blocoid, ordem) VALUES (39, 37, 43, 1);
INSERT INTO blocos_x_abas (id, abaid, blocoid, ordem) VALUES (40, 37, 44, 1);
INSERT INTO blocos_x_abas (id, abaid, blocoid, ordem) VALUES (41, 36, 45, 2);
INSERT INTO blocos_x_abas (id, abaid, blocoid, ordem) VALUES (42, 36, 46, 2);
INSERT INTO blocos_x_abas (id, abaid, blocoid, ordem) VALUES (43, 38, 47, 1);
INSERT INTO blocos_x_abas (id, abaid, blocoid, ordem) VALUES (37, 34, 41, 2);
INSERT INTO blocos_x_abas (id, abaid, blocoid, ordem) VALUES (38, 34, 42, 1);
INSERT INTO blocos_x_abas (id, abaid, blocoid, ordem) VALUES (44, 39, 48, 1);
INSERT INTO blocos_x_abas (id, abaid, blocoid, ordem) VALUES (45, 40, 49, 1);
INSERT INTO blocos_x_abas (id, abaid, blocoid, ordem) VALUES (46, 40, 50, 2);
INSERT INTO blocos_x_abas (id, abaid, blocoid, ordem) VALUES (47, 41, 51, 1);
INSERT INTO blocos_x_abas (id, abaid, blocoid, ordem) VALUES (48, 42, 52, 1);
INSERT INTO blocos_x_abas (id, abaid, blocoid, ordem) VALUES (49, 42, 53, 1);
INSERT INTO blocos_x_abas (id, abaid, blocoid, ordem) VALUES (50, 44, 54, 1);
INSERT INTO blocos_x_abas (id, abaid, blocoid, ordem) VALUES (51, 44, 55, 1);
INSERT INTO blocos_x_abas (id, abaid, blocoid, ordem) VALUES (52, 45, 56, 1);
INSERT INTO blocos_x_abas (id, abaid, blocoid, ordem) VALUES (53, 46, 57, 1);
INSERT INTO blocos_x_abas (id, abaid, blocoid, ordem) VALUES (54, 47, 58, 1);
INSERT INTO blocos_x_abas (id, abaid, blocoid, ordem) VALUES (55, 48, 59, 1);
INSERT INTO blocos_x_abas (id, abaid, blocoid, ordem) VALUES (60, 51, 64, 1);
INSERT INTO blocos_x_abas (id, abaid, blocoid, ordem) VALUES (64, 55, 68, 1);
INSERT INTO blocos_x_abas (id, abaid, blocoid, ordem) VALUES (65, 55, 71, 2);
INSERT INTO blocos_x_abas (id, abaid, blocoid, ordem) VALUES (68, 57, 72, 1);
INSERT INTO blocos_x_abas (id, abaid, blocoid, ordem) VALUES (69, 53, 66, 1);
INSERT INTO blocos_x_abas (id, abaid, blocoid, ordem) VALUES (66, 56, 69, 2);
INSERT INTO blocos_x_abas (id, abaid, blocoid, ordem) VALUES (67, 56, 70, 1);
INSERT INTO blocos_x_abas (id, abaid, blocoid, ordem) VALUES (57, 49, 61, 3);
INSERT INTO blocos_x_abas (id, abaid, blocoid, ordem) VALUES (56, 49, 60, 2);
INSERT INTO blocos_x_abas (id, abaid, blocoid, ordem) VALUES (58, 49, 62, 1);
INSERT INTO blocos_x_abas (id, abaid, blocoid, ordem) VALUES (71, 51, 73, 2);
INSERT INTO blocos_x_abas (id, abaid, blocoid, ordem) VALUES (59, 50, 63, 2);
INSERT INTO blocos_x_abas (id, abaid, blocoid, ordem) VALUES (73, 59, 75, 1);
INSERT INTO blocos_x_abas (id, abaid, blocoid, ordem) VALUES (74, 60, 76, 1);
INSERT INTO blocos_x_abas (id, abaid, blocoid, ordem) VALUES (75, 60, 77, 2);
INSERT INTO blocos_x_abas (id, abaid, blocoid, ordem) VALUES (76, 60, 78, 3);
INSERT INTO blocos_x_abas (id, abaid, blocoid, ordem) VALUES (77, 61, 79, 1);
INSERT INTO blocos_x_abas (id, abaid, blocoid, ordem) VALUES (78, 62, 80, 1);


--
-- TOC entry 2025 (class 0 OID 21967)
-- Dependencies: 1564
-- Data for Name: campos; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (3, 'ativo', 'ativo', 'Situação:', NULL, NULL, 'TCombo', 1, 1, 0, '-', NULL, NULL, NULL, NULL, 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (2, 'usuario', 'usuario', 'Nome de usuário:', NULL, NULL, 'TEntry', 1, 1, 0, '-', NULL, NULL, NULL, NULL, 1, 1, 2, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (1, 'codigopessoa', 'codigopessoa', 'Nome do Responsável:', NULL, NULL, 'TCombo', 1, 1, 0, '-', NULL, NULL, NULL, NULL, 1, 1, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (4, 'codigotema', 'codigotema', 'Tema:', NULL, NULL, 'TCombo', 1, 1, 0, '17', NULL, NULL, NULL, NULL, 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (5, 'descricao', 'descricao', 'Descrição:', NULL, NULL, 'TText', 4, 1, 0, '-', '-', '0', '0', NULL, 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (6, 'tipo', 'tipo', 'Tipo de Patrimonio:', NULL, NULL, 'TCombo', 4, 1, 0, '-', '-', '0', '0', NULL, 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (7, 'datafabricacao', 'dataFabricacao', 'Data de Fabricação:', '''99/99/9999'',1', 'CLASS_CALENDARIO', 'TEntry', 4, 1, 0, '-', 'setDataPT', 'setDataDB', '0', NULL, 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (8, 'dataaquisicao', 'dataAquisicao', 'Data de Aquisição:', '''99/99/9999'',1', 'CLASS_CALENDARIO', 'TEntry', 4, 1, 0, '-', 'setDataPT', 'setDataDB', '0', NULL, 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (9, 'valornominal', 'valorNominal', 'Valor Contábil:', NULL, 'CLASS_MASCARA_VALOR', 'TEntry', 4, 1, 0, '-', 'setMoney', 'setFloat', '0', NULL, 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (12, 'valorcompra', 'valorCompra', 'Valor de Compra:', NULL, NULL, 'TEntry', 4, 1, 0, '-', '-', '0', '0', NULL, 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (13, 'numnf', 'numNF', 'Número da Nota Fiscal:', NULL, NULL, 'TEntry', 4, 1, 0, '-', '-', '0', '0', NULL, 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (14, 'dataverificacao', 'dataVerificacao', 'Data da Última Verificação:', '''99/99/9999'',1', 'CLASS_CALENDARIO', 'TEntry', 4, 1, 0, '-', 'setDataPT', 'setDataDB', '0', NULL, 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (15, 'obs', 'obs', 'OBS.:', NULL, NULL, 'TText', 4, 1, 0, '-', '-', '0', '0', NULL, 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (16, 'codigo', 'codigo', 'Cod.:', NULL, NULL, 'TEntry', 4, 1, 0, '-', '-', '0', '0', NULL, 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (17, 'marca', 'marca', 'Marca:', NULL, NULL, 'TEntry', 4, 1, 0, '-', '-', '0', '0', NULL, 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (18, 'modelo', 'modelo', 'Modelo:', NULL, NULL, 'TEntry', 4, 1, 0, '-', '-', '0', '0', NULL, 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (10, 'lotacao', 'lotacao', 'Lotação:', NULL, NULL, 'TCombo', 4, 1, 0, '-', '-', '0', '0', NULL, 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (11, 'codigofuncionario', 'codigofuncionario', 'Responsável:', NULL, NULL, 'TCombo', 4, 1, 0, '-', '-', '0', '0', NULL, 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (21, 'patharquivo', 'patharquivo', 'Foto:', NULL, NULL, 'TFrameFile', 5, 1, 0, '-', '-', '0', '0', NULL, 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (24, 'nome', 'nome', 'Sala:', NULL, NULL, 'TEntry', 7, 1, 0, '-', '-', '0', '0', NULL, 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (25, 'endereco', 'endereco', 'Endereço:', NULL, NULL, 'TText', 7, 1, 0, '-', '-', '0', '0', NULL, 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (27, 'descricao', 'descricao', 'Descrição:', NULL, NULL, 'TText', 7, 1, 0, '-', '-', '0', '0', NULL, 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (28, 'codigofuncionario', 'codigofuncionario', 'Responsável:', NULL, NULL, 'TCombo', 7, 1, 0, '-', '-', '0', '0', NULL, 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (29, 'label', 'label', 'Departamento:', NULL, NULL, 'TEntry', 8, 1, 0, '-', '-', '0', '0', NULL, 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (32, 'codigoprodutotipo', 'codigoprodutotipo', 'Tipo do Produto:', NULL, NULL, 'TCombo', 9, 1, 0, '-', '-', '0', '0', NULL, 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (33, 'codigocomportamentofiscal', 'codigocomportamentofiscal', 'Comportamento Fiscal:', NULL, NULL, 'TCombo', 9, 1, 0, '-', '-', '0', '0', NULL, 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (35, 'estoquemaximo', 'estoquemaximo', 'Estoque Máximo:', NULL, NULL, 'TEntry', 9, 1, 0, '-', '-', '0', '0', NULL, 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (38, 'label', 'label', 'Patrimônio:', NULL, NULL, 'TEntry', 4, 1, 0, '-', '-', '0', '0', 'Nome Descritivo', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (39, 'codigoproduto', 'codigoproduto', 'Produto referente:', NULL, NULL, 'TCombo', 4, 1, 15, '-', '-', '0', '0', NULL, 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (61, 'diretor', 'diretor', 'Diretor:', '', '', 'TEntry', 13, 1, 0, '-', '-', '0', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (62, 'gerente', 'gerente', 'Gerente:', '', '', 'TEntry', 13, 1, 0, '-', '-', '0', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (63, 'representante', 'representante', 'Representante:', '', '', 'TEntry', 13, 1, 0, '-', '-', '0', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (68, 'estadoCivil', 'estadoCivil', 'Estado Civil:', '', '', 'TCombo', 12, 1, 0, '-', '-', '0', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (69, 'etinia', 'etinia', 'Etnia:', '', '', 'TCombo', 12, 1, 0, '-', '-', '0', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (70, 'dataNasc', 'dataNasc', 'Data de Nascimento:', '''99/99/9999'',1', 'CLASS_CALENDARIO', 'TEntry', 12, 1, 0, '-', 'setDataPT', 'setDataDB', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (71, 'rendaMensal', 'rendaMensal', 'Renda Mensal:', '', '', 'TEntry', 12, 1, 0, '-', '-', '0', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (72, 'codigoconvenio', 'codigoconvenio', 'Convênio:', '', '', 'TCombo', 16, 1, 0, '-', '-', '0', '0', '', 1, 1, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (73, 'turno', 'turno', 'Turno:', '', '', 'TCombo', 17, 1, 0, '-', '-', '0', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (41, 'bairro', 'bairro', 'Bairro:', '', '', 'TEntry', 3, 1, 0, '-', '-', '0', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (43, 'estado', 'estado', 'Estado:', '', '', 'TCombo', 3, 1, 0, '-', '-', '0', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (42, 'cidade', 'cidade', 'Cidade:', '', '', 'TEntry', 3, 1, 0, '-', '-', '0', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (44, 'cep', 'cep', 'Cep:', '''99.999-999'',1', '', 'TEntry', 3, 1, 0, '-', '-', '0', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (46, 'tel1', 'tel1', 'Telefone 1:', '', 'CLASS_UI_TELEFONE', 'TEntry', 3, 1, 0, '-', 'setTelefone', 'setTelefoneDB', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (47, 'tel2', 'tel2', 'Telefone 2:', '', 'CLASS_UI_TELEFONE', 'TEntry', 3, 1, 0, '-', 'setTelefone', 'setTelefoneDB', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (48, 'cel1', 'cel1', 'Celular 1:', '', 'CLASS_UI_TELEFONE', 'TEntry', 3, 1, 0, '-', 'setTelefone', 'setTelefoneDB', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (49, 'cel2', 'cel2', 'Celular 2:', '', 'CLASS_UI_TELEFONE', 'TEntry', 3, 1, 0, '-', 'setTelefone', 'setTelefoneDB', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (50, 'email1', 'email1', 'E-mail 1:', '', '', 'TEntry', 3, 1, 0, '-', '-', '0', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (51, 'email2', 'email2', 'E-mail 2:', '', '', 'TEntry', 3, 1, 0, '-', '-', '0', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (52, 'site', 'site', 'Site:', '', '', 'TEntry', 3, 1, 0, '-', '-', '0', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (53, 'tipo', 'tipo', 'Tipo de Cadastro:', '', '', 'TRadioGroup', 3, 1, 0, '-', '-', '0', 'setTipoForm(''tipo1'')', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (54, 'codigo', 'codigo', 'Cod.:', '', '', 'TEntry', 3, 1, 0, '-', '-', '0', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (55, 'dataCad', 'dataCad', 'Data do Cadastro:', '''99/99/9999'',1', '', 'TEntry', 3, 1, 0, '-', 'setDataPT', 'setDataDB', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (57, 'nome_razaoSocial', 'nomeJ_razaoSocial', 'Razão Social:', '', '', 'TEntry', 3, 1, 0, '-', '-', '0', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (58, 'cpf_cnpj', 'cnpj', 'CNPJ:', '''99.999.999/9999-99'',1', '', 'TEntry', 3, 1, 0, '-', 'setCNPJ', '0', '0', '', 1, 1, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (59, 'rg_inscEst', 'inscEst', 'Inscrição Estadual:', '', '', 'TEntry', 3, 1, 0, '-', '-', '0', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (60, 'titEleitor_inscMun', 'inscMunCliente', 'Inscrição Municipal:', '', '', 'TEntry', 3, 1, 0, '-', '-', '0', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (64, 'nome_razaoSocial', 'nome_razaoSocial', 'Nome:', '', '', 'TEntry', 3, 1, 0, '-', '-', '0', '0', '', 1, 1, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (66, 'rg_inscEst', 'rg', 'RG:', '', '', 'TEntry', 3, 1, 0, '-', '-', '0', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (67, 'titEleitor_inscMun', 'titEleitorCliente', 'Titulo de Eleitor:', '', '', 'TEntry', 3, 1, 0, '-', '-', '0', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (30, 'produto', 'produto', 'Produto:', NULL, NULL, 'TEntry', 9, 1, 0, '-', '-', '0', '0', NULL, 1, 1, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (31, 'descricao', 'descricao', 'Descrição:', NULL, NULL, 'TText', 9, 1, 0, '-', '-', '0', '0', NULL, 1, 1, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (34, 'estoqueminimo', 'estoqueminimo', 'Estoque Mínimo:', NULL, NULL, 'TEntry', 9, 1, 0, '-', '-', '0', '0', NULL, 1, 1, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (56, 'cliente', 'cliente', 'Tipo de Relação:', '', '', 'THidden', 3, 1, 0, '1', '-', '0', '0', '', 1, 0, 1, '1');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (74, 'codigoCurso', 'codigoCurso', 'Curso:', '', '', 'TCombo', 17, 1, 0, '-', '-', '0', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (203, 'acrescimo', 'acrescimo', 'Acrescimo:', '', '', 'TEntry', 42, 1, 0, '-', '-', '0', '0', '', 1, 0, 1, '1');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (103, 'datanasc', 'datanasc', 'Data de Nascimento:', '''99/99/9999'',1', 'CLASS_CALENDARIO', 'TEntry', 12, 1, 0, '-', 'setDataPT', 'setDataDB', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (104, 'sexo', 'sexo', 'Sexo:', '', '', 'TCombo', 12, 1, 0, '-', '-', '0', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (105, 'estadoCivil', 'estadoCivil', 'Estado Civil:', '', '', 'TCombo', 12, 1, 0, '-', '-', '0', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (106, 'nacionalidade', 'nacionalidade', 'Nacionalidade:', '', '', 'TEntry', 12, 1, 0, '-', '-', '0', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (108, 'foto', 'foto', 'Foto:', '', '', 'TFrameFile', 31, 1, 0, '-', '-', '0', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (110, 'obs', 'obs', 'Observações:', '', '', 'TText', 31, 1, 0, '-', '-', '0', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (111, 'dataAdmissao', 'dataAdmissao', 'Data de Admissão:', '''99/99/9999'',1', 'CLASS_CALENDARIO', 'TEntry', 31, 1, 0, '-', 'setDataPT', 'setDataDB', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (112, 'pis_pasep', 'pis_pasep', 'PIS/PASEP:', '', '', 'TEntry', 31, 1, 0, '-', '-', '0', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (122, 'portadorNecessidades', 'portadorNecessidades', 'Portador de Necessidades Especiais?', '', '', 'TCombo', 12, 1, 0, '-', '-', '0', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (123, 'necessidadesEspeciais', 'necessidadesEspeciais', 'Quais?', '', '', 'TText', 12, 1, 0, '-', '-', '0', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (124, 'carteiraReservista', 'carteiraReservista', 'Carteira de Reservista (Número):', '', '', 'TEntry', 12, 1, 0, '-', '-', '0', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (125, 'cnh', 'cnh', 'Carteira de Habilitação:', '', '', 'TCombo', 12, 1, 0, '-', '-', '0', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (126, 'perfil', 'perfil', 'Perfil do Funcionario:', '', '', 'TText', 31, 1, 0, '-', '-', '0', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (127, 'ativo', 'ativo', 'Situação:', '', '', 'TCombo', 31, 1, 0, '-', '-', '0', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (128, 'relatorioExame', 'relatorioExame', 'Relatório do Exame Ocupacional:', '', '', 'TText', 31, 1, 0, '-', '-', '0', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (129, 'dataExame', 'dataExame', 'Data do Exame:', '''99/99/9999'',1', 'CLASS_CALENDARIO', 'TEntry', 31, 1, 0, '-', 'setDataPT', 'setDataDB', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (130, 'lotacao', 'lotacao', 'Lotação do Funcionario:', '', '', 'TCombo', 31, 1, 0, '-', '-', '0', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (131, 'cbo', 'cbo', 'C.B.O.:', '', '', 'TEntry', 31, 1, 0, '-', '-', '0', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (132, 'codigoCargo', 'codigocargo', 'Cargo:', '', '', 'TCombo', 31, 1, 0, '-', '-', '0', '0', '', 1, 1, 1, '1');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (133, 'gratificacao', 'gratificacao', 'Gratificação:', '', '', 'TEntry', 31, 1, 0, '0', '-', '0', '0', '', 1, 0, 1, '1');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (134, 'beneficios', 'beneficios', 'Beneficios:', '', '', 'TText', 31, 1, 0, '0', '-', '0', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (135, 'valorBeneficios', 'valorBeneficios', 'Valor total dos Beneficios:', '', 'CLASS_MASCARA_VALOR', 'TEntry', 31, 1, 0, '0', 'setMoney', 'setFloat', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (137, 'regimeContrato', 'regimeContrato', 'Regime de Contrato:', '', '', 'TCombo', 31, 1, 0, '-', '-', '0', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (138, 'empTerc', 'codigofornecedor', 'Empresa Vinculada:', '', '', 'TCombo', 31, 1, 0, '-', '-', '0', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (139, 'codigoDepartamento', 'codigoDepartamento', 'Departamento:', '', '', 'TCombo', 31, 1, 0, '-', '-', '0', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (140, 'pagBanco', 'pagBanco', 'Banco', '', '', 'TEntry', 31, 1, 0, '-', '-', '0', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (141, 'pagAgencia', 'pagAgencia', 'Agencia:', '', '', 'TEntry', 31, 1, 0, '-', '-', '0', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (142, 'pagConta', 'pagConta', 'Conta:', '', '', 'TEntry', 31, 1, 0, '-', '-', '0', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (143, 'pagVencimento', 'pagVencimento', 'Dia para vencimento:', '''99'',1', '', 'TEntry', 31, 1, 0, '-', '-', '0', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (144, 'curso', 'curso', 'Curso:', '', '', 'TEntry', 14, 1, 0, '-', '-', '0', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (145, 'instituicao', 'instituicao', 'Instituição:', '', '', 'TEntry', 14, 1, 0, '-', '-', '0', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (146, 'anoConclusao', 'anoConclusao', 'Ano de Conclusão:', '', '', 'TEntry', 14, 1, 0, '-', '-', '0', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (147, 'observacao', 'observacao', 'Observações:', '', '', 'TText', 14, 1, 0, '-', '-', '0', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (148, 'codigotitularidade', 'codigotitularidade', 'Escolaridade:', '', '', 'TCombo', 14, 1, 0, '-', '-', '0', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (189, 'statusconta', 'statusconta', 'Conta programada', '', '', 'TCombo', 44, 1, 0, '-', '-', '0', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (190, 'valorNominal', 'valorNominal', 'Valor nominal:', '', 'CLASS_MASCARA_VALOR', 'TEntry', 44, 1, 0, '-', 'setMoney', 'setFloat', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (191, 'vencimento', 'vencimento', 'Vencimento:', '''99/99/9999'',1', 'CLASS_CALENDARIO', 'TEntry', 44, 1, 0, '-', 'setDataPT', 'setDataDB', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (192, 'obs', 'obs', 'Observações:', '', '', 'TText', 44, 1, 0, '-', '-', '0', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (193, 'codigo', 'codigo', 'Cod.:', '', '', 'TEntry', 44, 0, 0, '-', '-', '0', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (194, 'numcheque', 'numcheque', 'Nº do Cheque:', '', '', 'TEntry', 45, 1, 0, '-', '-', '0', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (195, 'valor', 'valor', 'Valor:', '', 'CLASS_MASCARA_VALOR', 'TEntry', 45, 1, 0, '-', 'setMoney', 'setFloat', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (196, 'nometitular', 'nometitular', 'Titular:', '', '', 'TEntry', 45, 1, 0, '-', '-', '0', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (197, 'numconta', 'numconta', 'Conta:', '', '', 'TEntry', 45, 1, 0, '-', '-', '0', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (198, 'banco', 'banco', 'Banco:', '', '', 'TEntry', 45, 1, 0, '-', '-', '0', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (199, 'cpf_cnpj', 'cpf_cnpj', 'CPF/CNPJ:', '', '', 'TEntry', 45, 1, 0, '-', '-', '0', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (188, 'codigo', 'codigo', 'Cod.:', '', '', 'TEntry', 42, 1, 0, '-', '-', '0', '0', '', 1, 0, 1, '1');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (182, 'valorunitario', 'valorunitario', 'Valor Unitário:', '', 'CLASS_MASCARA_VALOR', 'TEntry', 43, 1, 0, '-', 'setMoney', 'setFloat', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (101, 'nome_razaoSocial', 'nome_razaoSocial', 'Nome do Funcionario:', '', '', 'TEntry', 3, 1, 0, '-', '-', '0', '0', '', 1, 1, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (107, 'rg_inscEst', 'rg_inscEst', 'RG:', '', '', 'TEntry', 3, 1, 0, '-', '-', '0', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (113, 'funcionario', 'funcionario', '', '', '', 'THidden', 3, 1, 0, '1', '-', '0', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (114, 'logradouro', 'logradouro', 'Endereço:', '', '', 'TEntry', 3, 1, 0, '-', '-', '0', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (115, 'bairro', 'bairro', 'Setor:', '', '', 'TEntry', 3, 1, 0, '-', '-', '0', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (116, 'cidade', 'cidade', 'Cidade:', '', '', 'TEntry', 3, 1, 0, '-', '-', '0', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (117, 'estado', 'estado', 'Estado:', '', '', 'TCombo', 3, 1, 0, '-', '-', '0', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (118, 'cep', 'cep', 'CEP:', '''99.999-999'',1', '', 'TEntry', 3, 1, 0, '-', '-', '0', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (119, 'email1', 'email1', 'E-mail:', '', '', 'TEntry', 3, 1, 0, '-', '-', '0', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (121, 'cel1', 'cel1', 'Celular:', '', 'CLASS_UI_TELEFONE', 'TEntry', 3, 1, 0, '-', 'setTelefone', 'setTelefoneDB', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (136, 'ferias', 'ferias', 'Data para Férias Programada:', '''99/99/9999'',1', 'CLASS_CALENDARIO', 'TEntry', 31, 1, 0, '-', 'setDataPT', 'setDataDB', '0', '', 0, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (186, 'codigocliente', 'codigocliente', 'Cliente:', '', '', 'TCombo', 42, 1, 57, '-', '-', '0', '0', '', 1, 1, 2, '1');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (179, 'codigoproduto', 'codigoproduto', 'Produto:', '', '', 'TCombo', 43, 1, 62, '-', '-', 'setDuplicacao', '0', '', 1, 1, 1, '1');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (185, 'codigocondicaopagamento', 'codigocondicaopagamento', 'Condição de Pagamento:', '', '', 'TCombo', 42, 1, 56, '-', '-', '0', '0', '', 1, 1, 2, '1');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (200, 'agencia', 'agencia', 'Agência:', '', '', 'TEntry', 45, 1, 0, '-', '-', '0', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (201, 'valortotal', 'valortotal', 'Valor Total:', '', 'CLASS_MASCARA_VALOR', 'TEntry', 42, 0, 0, '-', 'setMoney', 'setFloat', '0', '', 1, 0, 2, '1');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (202, 'desconto', 'desconto', 'Desconto:', '', '', 'TEntry', 42, 1, 0, '-', '-', '0', '0', '', 1, 0, 1, '1');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (204, 'valorcorrigido', 'valorcorrigido', 'Valor Corrigido:', '', 'CLASS_MASCARA_VALOR', 'TEntry', 42, 1, 0, '-', 'setMoney', 'setFloat', '0', '', 1, 0, 1, '1');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (205, 'vencimento', 'vencimento', 'Data base:', '''99/99/9999'',1', 'CLASS_CALENDARIO', 'TEntry', 42, 1, 0, '-', 'setDataPT', 'setDataDB', '0', '', 1, 0, 1, '1');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (206, 'intervaloParcelas', 'intervaloParcelas', 'Intervalo:', '', '', 'TEntry', 42, 1, 0, '-', '-', '0', '0', '', 1, 0, 1, '1');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (207, 'numparcelas', 'numParcelas', 'Parcelas:', '', '', 'TEntry', 42, 1, 0, '-', '-', '0', '0', '', 1, 0, 1, '1');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (208, 'buttonTransacaoC', 'buttonTransacaoC', 'Gerar Contas', '', '', 'TButton', 42, 0, 0, '-', '-', '0', '0', '', 1, 0, 2, '1');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (209, 'parcelas', 'parcelas', 'Parcelas:', NULL, NULL, 'TEntry', 48, 1, 0, '-', '-', '0', '0', NULL, 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (212, 'intervalo', 'intervalo', 'Intervalo:', NULL, NULL, 'TEntry', 48, 1, 0, '-', NULL, NULL, NULL, NULL, 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (213, 'entrada', 'entrada', 'Entrada:', NULL, NULL, 'TCombo', 48, 1, 0, '-', NULL, NULL, NULL, NULL, 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (187, 'codigovendedor', 'codigovendedor', '', '', '', 'THidden', 42, 1, 0, 'function/TUsuario/getCodigoFuncionario', '-', '0', '0', '', 1, 0, 2, '1');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (225, 'codigotipotransacao', 'codigotipotransacao', NULL, NULL, NULL, 'THidden', 42, 1, 0, '10000541-641', NULL, NULL, NULL, NULL, 1, 0, 1, '1');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (109, 'numeroDependentes', 'numeroDependentes', 'Nº de Dependentes:', '', '', 'TEntry', 12, 1, 0, '-', '-', '0', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (40, 'logradouro', 'logradouro', 'Endereço:', '', '', 'TEntry', 3, 1, 0, '-', '-', '0', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (45, 'referencia', 'referencia', 'Referência de Endereço:', '', '', 'TEntry', 3, 1, 0, '-', '-', '0', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (65, 'cpf_cnpj', 'cpf', 'CPF:', '''999.999.999-99'',1', '', 'TEntry', 3, 1, 0, '-', 'setCPF', '0', '0', '', 1, 1, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (102, 'cpf_cnpj', 'cpf_cnpj', 'CPF:', '''999.999.999-99'',1', '', 'TEntry', 3, 1, 0, '-', 'setCPF', '0', '0', '', 1, 1, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (120, 'tel1', 'tel1', 'Telefone Fixo:', '', 'CLASS_UI_TELEFONE', 'TEntry', 3, 1, 0, '-', 'setTelefone', 'setTelefoneDB', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (214, 'descricao', 'descricao', 'Descrição:', NULL, NULL, 'TEntry', 48, 1, 0, '-', NULL, NULL, NULL, NULL, 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (224, 'codigoformapagamento', 'codigoformapagamento', 'Condição de Pagamento:', NULL, NULL, 'TCombo', 50, 1, 0, '-', NULL, NULL, NULL, NULL, 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (215, 'codigoestado', 'codigoestado', 'Estado:', NULL, NULL, 'TCombo', 49, 1, 0, '-', NULL, NULL, NULL, NULL, 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (217, 'taxaadministrativa', 'taxaadministrativa', 'Taxas Administrativas (%):', NULL, 'CLASS_MASCARA_VALOR', 'TEntry', 49, 1, 0, '-', 'setMoney', 'setFloat', NULL, NULL, 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (216, 'margem', 'margem', 'Margem de Lucro (%):', NULL, 'CLASS_MASCARA_VALOR', 'TEntry', 49, 1, 0, '-', 'setMoney', 'setFloat', 'viewProdutoValor()', NULL, 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (242, 'largura', 'largura', 'Largura (m):', NULL, NULL, 'TEntry', 51, 1, 0, '-', 'setMoney', 'setFloat', NULL, NULL, 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (226, 'codigo', 'codigo', 'Codigo:', NULL, NULL, 'TEntry', 42, 0, 0, '-', NULL, NULL, NULL, NULL, 1, 0, 2, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (227, 'codigocliente', 'codigocliente', 'Cliente:', NULL, NULL, 'TCombo', 42, 0, 0, '-', NULL, NULL, NULL, NULL, 1, 0, 2, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (184, 'valordesconto', 'valordescontoproduto', 'Desconto Unitário:', '', 'CLASS_MASCARA_VALOR', 'TEntry', 43, 1, 0, '-', 'setMoney', 'setFloat', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (229, 'codigocondicaopagamento', 'codigocondicaopagamento', 'Condição de Pagamento:', NULL, NULL, 'TCombo', 42, 0, 0, '-', NULL, NULL, NULL, NULL, 1, 0, 2, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (241, 'altura', 'altura', 'Altura (m):', NULL, NULL, 'TEntry', 51, 1, 0, '-', 'setMoney', 'setFloat', NULL, NULL, 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (231, 'datacad', 'datacad', 'Data:', '''99/99/9999'',1', NULL, 'TEntry', 42, 0, 0, '-', 'setDataPT', NULL, NULL, NULL, 1, 0, 2, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (230, 'valortotal', 'valortotal', 'Valor Total:', NULL, 'CLASS_MASCARA_DINHEIRO', 'TEntry', 42, 0, 0, '-', 'setMoney', 'setFloat', NULL, NULL, 1, 0, 2, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (233, 'beneficios', 'beneficios', 'Beneficios:', NULL, NULL, 'TText', 51, 1, 0, '-', NULL, NULL, NULL, NULL, 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (235, 'mododeuso', 'mododeuso', 'Modo de uso:', NULL, NULL, 'TText', 51, 1, 0, '-', NULL, NULL, NULL, NULL, 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (236, 'unid', 'unid', 'Unidade:', NULL, NULL, 'TCombo', 51, 1, 0, '-', NULL, NULL, NULL, NULL, 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (238, 'cor', 'cor', 'Cor:', NULL, NULL, 'TEntry', 51, 1, 0, '-', NULL, NULL, NULL, NULL, 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (221, 'valortotal', 'valortotalitem', 'Valor Total do Item:', '', 'CLASS_MASCARA_VALOR', 'TEntry', 43, 1, 0, '-', 'setMoney', 'setFloat', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (222, 'valordescontototal', 'valordescontototalitem', NULL, '', NULL, 'THidden', 43, 1, 0, '-', 'setMoney', 'setFloat', '0', '', 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (183, 'quantidade', 'quantidadeproduto', 'Quantidade:', '', '', 'TEntry', 43, 1, 0, '-', '-', '0', '0', '', 1, 1, 1, '1');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (239, 'cubagem', 'cubagem', 'Cubagem (kg/m³):', NULL, NULL, 'TEntry', 51, 1, 0, '-', 'setMoney', 'setFloat', NULL, NULL, 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (234, 'limitacoes', 'limitacoes', 'Limitações:', NULL, NULL, 'Ttext', 51, 1, 0, '-', NULL, NULL, NULL, NULL, 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (240, 'peso', 'peso', 'Peso (kg):', NULL, NULL, 'TEntry', 51, 1, 0, '-', 'setMoney', 'setFloat', NULL, NULL, 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (228, 'codigovendedor', 'codigovendedor', 'Vendedor:', NULL, NULL, 'TCombo', 42, 0, 0, '-', NULL, NULL, NULL, NULL, 0, 0, 2, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (245, 'quantidade', 'quantidade', 'Quantidade', NULL, NULL, 'TEntry', 10, 1, 0, '-', NULL, NULL, NULL, NULL, 1, 1, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (249, 'codigotipomovimentacao', 'codigotipomovimentacao', 'Tipo de Movimentação', NULL, NULL, 'TCombo', 10, 1, 0, '-', NULL, NULL, NULL, NULL, 1, 1, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (243, 'comprimento', 'comprimento', 'Comprimento (m):', NULL, NULL, 'TEntry', 51, 1, 0, '-', 'setMoney', 'setFloat', NULL, NULL, 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (251, 'nome_mer', 'nome_mer', 'Produto:', NULL, NULL, 'TEntry', 52, 0, 0, '-', NULL, NULL, NULL, NULL, 1, 0, 0, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (252, 'nome_com', 'nome_com', 'Marca:', NULL, NULL, 'TEntry', 52, 0, 0, '-', NULL, NULL, NULL, NULL, 1, 0, 0, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (253, 'endereco_mer', 'endereco_mer', 'Endereço:', NULL, NULL, 'TText', 52, 0, 0, '-', NULL, NULL, NULL, NULL, 1, 0, 0, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (254, 'estoque_fisico', 'qtd_atual', 'Qtde. Atual:', NULL, NULL, 'TEntry', 52, 0, 0, '-', NULL, NULL, NULL, NULL, 1, 0, 0, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (263, 'blepnpag', 'blepnpag', 'Pagina:', NULL, 'CLASS_UI_H2', 'TEntry', 52, 1, 0, '-', NULL, NULL, NULL, NULL, 1, 1, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (260, 'estoque_fisico', 'qtd_atual', 'Qtde. Atual:', NULL, NULL, 'TEntry', 52, 0, 0, '-', NULL, NULL, NULL, NULL, 1, 0, 0, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (259, 'endereco_mer', 'endereco_mer', 'Endereço:', NULL, NULL, 'TText', 52, 0, 0, '-', NULL, NULL, NULL, NULL, 1, 0, 0, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (261, 'nova_qtd', 'nova_qtd', 'Nova Qtde.:', NULL, NULL, 'TEntry', 52, 0, 0, '-', NULL, NULL, NULL, NULL, 1, 0, 0, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (250, 'cod_mer', 'cod_mer', 'Codigo:', NULL, NULL, 'TEntry', 52, 0, 0, '-', NULL, NULL, NULL, NULL, 1, 0, 0, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (264, 'blepstcf', 'blepstcf', 'Situação Conferência:', NULL, NULL, 'TCombo', 52, 1, 0, '-', NULL, NULL, NULL, NULL, 1, 1, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (262, 'blccapel', 'blccapel', 'Dupla Contagem:', NULL, NULL, 'TCombo', 52, 1, 0, '-', NULL, NULL, NULL, NULL, 1, 1, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (258, 'nome_com', 'nome_com', 'Marca:', NULL, NULL, 'TEntry', 52, 0, 0, '-', NULL, NULL, NULL, NULL, 1, 0, 0, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (255, 'nova_qtd', 'nova_qtd', 'Nova Qtde.:', NULL, 'CLASS_UI_H2', 'TEntry', 52, 1, 0, '-', NULL, NULL, NULL, NULL, 1, 1, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (265, 'limitedesconto', 'limitedesconto', 'Limite de Desconto:', NULL, 'CLASS_MASCARA_VALOR', 'TEntry', 31, 1, 0, '-', 'setMoney', 'setFloat', NULL, NULL, 1, 1, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (256, 'cod_mer', 'cod_mer', 'Codigo:', NULL, NULL, 'TEntry', 52, 0, 0, '-', NULL, NULL, NULL, NULL, 1, 0, 0, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (257, 'nome_mer', 'nome_mer', 'Produto:', NULL, NULL, 'TEntry', 52, 0, 0, '-', NULL, NULL, NULL, NULL, 1, 0, 0, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (244, 'codigoproduto', 'codigoproduto', 'Produto:', NULL, NULL, 'TCombo', 10, 1, 62, '-', NULL, NULL, NULL, NULL, 1, 1, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (267, 'codigounidade', 'codigounidade', 'Empresa:', NULL, NULL, 'TCombo', 42, 1, 91, '-', NULL, NULL, NULL, NULL, 1, 1, 1, '1');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (274, 'ufcliente', 'ufcliente', 'UF:', NULL, NULL, 'TEntry', 0, 0, 0, '-', NULL, NULL, 'populaCampo(''ufcliente'',''codigocliente'',''codigo'',''dbpessoas'',''estado'')', NULL, 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (277, 'codigo', 'codigo', 'Nº Nota:', NULL, NULL, 'TEntry', 42, 1, 0, '-', NULL, NULL, NULL, NULL, 1, 0, 1, '1');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (305, 'juros', 'juros', 'Juros:', NULL, NULL, 'TEntry', 48, 1, 0, '-', NULL, 'setFloat', NULL, NULL, 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (306, 'indice', 'indice', 'Índice sobre o Documento:', NULL, NULL, 'TEntry', 48, 1, 0, '-', NULL, 'setFloat', NULL, NULL, 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (290, 'descricao', 'descricao', 'Descrição:', NULL, NULL, 'TEntry', 54, 1, 0, '-', NULL, NULL, NULL, NULL, 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (291, 'referencia', 'referencia', 'Referência:', NULL, NULL, 'TEntry', 54, 1, 0, '-', NULL, NULL, NULL, NULL, 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (292, 'unidademedida', 'unidademedida', 'Unidade de Medida:', NULL, NULL, 'TCombo', 54, 1, 0, '-', NULL, NULL, NULL, NULL, 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (299, 'codigounidade', 'codigounidade', 'Empresa:', NULL, NULL, 'TCombo', 54, 1, 0, '-', NULL, NULL, NULL, NULL, 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (300, 'endereco', 'endereco', 'Endereço:', NULL, NULL, 'TEntry', 54, 1, 0, '-', NULL, NULL, NULL, NULL, 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (280, 'quantidade', 'quantidadeproduto', 'Quantidade:', NULL, NULL, 'TEntry', 43, 1, 0, '0', NULL, NULL, NULL, NULL, 1, 1, 1, '1');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (266, 'codigotipotransacao', 'codigotipotransacao', NULL, NULL, NULL, 'THidden', 42, 1, 0, '10000541-641', NULL, NULL, NULL, NULL, 1, 0, 1, '1');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (269, 'cnpjunidade', 'cnpjunidade', 'CNPJ:', NULL, NULL, 'TEntry', 0, 0, 0, '-', NULL, NULL, 'populaCampo(''cnpjunidade'',''codigounidade'',''codigo'',''dbunidades'',''cnpj'')', NULL, 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (282, 'valorprodutos', 'valorprodutos', 'Total Produtos:', NULL, NULL, 'TEntry', 0, 0, 0, '-', NULL, NULL, NULL, NULL, 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (301, 'observacao', 'observacao', 'Observações:', NULL, NULL, 'TText', 54, 1, 0, '-', NULL, NULL, NULL, NULL, 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (270, 'ufunidade', 'ufunidade', 'UF:', NULL, NULL, 'TEntry', 0, 0, 0, '-', NULL, NULL, 'populaCampo(''ufunidade'',''codigounidade'',''codigo'',''dbunidades'',''estado'')', NULL, 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (285, 'valormaxdesconto', 'valormaxdesconto', 'Valor Máximo do Desconto:', NULL, NULL, 'TEntry', 0, 0, 0, '-', NULL, NULL, NULL, NULL, 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (307, 'codigocondicaopagamento', 'codigocondicaopagamento', 'Condição de Pagamento:', NULL, NULL, 'TCombo', 42, 1, 0, '-', NULL, NULL, NULL, NULL, 1, 0, 1, '1');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (271, 'ieunidade', 'ieunidade', 'IE:', NULL, NULL, 'TEntry', 0, 0, 0, '-', NULL, NULL, 'populaCampo(''ieunidade'',''codigounidade'',''codigo'',''dbunidades'',''inscestadual'')', NULL, 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (279, 'valorunitario', 'valorunitario', 'Valor Unitário:', NULL, NULL, 'TEntry', 43, 1, 0, '-', '-', 'setFloat', NULL, NULL, 1, 0, 1, '1');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (296, 'sinonimos', 'sinonimos', 'Sinônimos:', NULL, NULL, 'TText', 54, 1, 0, '-', NULL, NULL, NULL, NULL, 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (302, 'codigoprodutosimilar', 'codigoprodutosimilar', 'Produto Similar:', NULL, NULL, 'TCombo', 55, 1, 89, '-', NULL, NULL, NULL, NULL, 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (281, 'valortotal', 'valortotalitem', 'Valor Total:', NULL, NULL, 'TEntry', 43, 1, 0, '-', '-', 'setFloat', NULL, NULL, 1, 0, 1, '1');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (293, 'codigomarca', 'codigomarca', 'Marca:', NULL, NULL, 'TCombo', 54, 1, 0, '-', NULL, NULL, NULL, NULL, 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (276, 'datacad', 'datacad', 'Data de Emissão:', '''99/99/9999'',1', 'CLASS_CALENDARIO', 'TEntry', 42, 1, 0, '-', 'setDataPT', 'setDataDB', NULL, NULL, 1, 0, 1, '1');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (272, 'codigocliente', 'codigocliente', 'Cliente:', NULL, NULL, 'TCombo', 42, 1, 90, '-', NULL, NULL, NULL, NULL, 1, 0, 1, '1');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (275, 'cpf_cnpjcliente', 'cpf_cnpjcliente', 'CPF/CNPJ:', NULL, NULL, 'TEntry', 0, 0, 0, '-', NULL, NULL, 'populaCampo(''cpf_cnpjcliente'',''codigocliente'',''codigo'',''dbpessoas'',''cpf_cnpj'')', NULL, 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (283, 'valorfrete', 'valorfrete', 'Valor Frete:', NULL, 'CLASS_MASCARA_VALOR', 'TEntry', 42, 1, 0, '-', 'setMoney', 'setFloat', NULL, NULL, 1, 0, 1, '1');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (284, 'valordespesas', 'valordespesas', 'Outras Despesas:', NULL, 'CLASS_MASCARA_VALOR', 'TEntry', 42, 1, 0, '-', 'setMoney', 'setFloat', NULL, NULL, 1, 0, 1, '1');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (273, 'ie_rgcliente', 'ie_rgcliente', 'RG/IE:', NULL, NULL, 'TEntry', 0, 0, 0, '-', NULL, NULL, 'populaCampo(''ie_rgcliente'',''codigocliente'',''codigo'',''dbpessoas'',''rg_inscest'')', NULL, 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (286, 'valordesconto', 'valordesconto', 'Valor Desconto:', NULL, 'CLASS_MASCARA_VALOR', 'TEntry', 42, 1, 0, '-', 'setMoney', 'setFloat', NULL, NULL, 1, 0, 1, '1');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (287, 'valortotal', 'valortotal', 'Total da Nota:', NULL, NULL, 'TEntry', 42, 1, 0, '-', 'setMoney', 'setFloat', NULL, NULL, 1, 0, 1, '1');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (310, 'codigovendedor', 'codigovendedor', NULL, NULL, NULL, 'THidden', 42, 1, 0, 'function/TUsuario/getCodigoFuncionario', '-', '0', '0', NULL, 1, 0, 2, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (308, 'valorjuros', 'valorjuros', NULL, NULL, NULL, 'THidden', 42, 1, 0, '-', NULL, 'setFloat', NULL, NULL, 1, 0, 1, '1');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (309, 'obs', 'obs', 'Observações:', NULL, NULL, 'TText', 42, 1, 0, '-', NULL, NULL, NULL, NULL, 1, 0, 1, '1');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (295, 'preco', 'preco', 'Preço:', NULL, NULL, 'TEntry', 54, 1, 0, '-', NULL, 'setFloat', NULL, NULL, 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (294, 'custo', 'custo', 'Custo:', NULL, NULL, 'TEntry', 54, 1, 0, '-', NULL, 'setFloat', NULL, NULL, 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (268, 'nomeunidade', 'nomeunidade', 'Razão Social:', NULL, NULL, 'TEntry', 0, 0, 0, '-', NULL, NULL, NULL, NULL, 0, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (311, 'valorindice', 'valorindice', NULL, NULL, NULL, 'THidden', 42, 0, 0, '-', NULL, NULL, 'populaCampo(''valorindice'',''codigocondicaopagamento'',''codigo'',''dbcondicoes_pagamento'',''indice'')', NULL, 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (312, 'codigounidade', 'codigounidade', 'Empresa:', NULL, NULL, 'TCombo', 56, 1, 0, '-', NULL, NULL, NULL, NULL, 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (314, 'custo', 'custo', 'Custo:', NULL, NULL, 'TEntry', 56, 1, 0, '-', NULL, 'setFloat', NULL, NULL, 1, 1, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (316, 'endereco', 'endereco', 'Endereço:', NULL, NULL, 'TEntry', 56, 1, 0, '-', NULL, NULL, NULL, NULL, 1, 0, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (313, 'quantidadeinicial', 'quantidadeinicialq', 'Quantidade Inicial:', NULL, NULL, 'TEntry', 56, 1, 0, '-', NULL, NULL, NULL, NULL, 1, 1, 2, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (319, 'cnpjunidade', 'cnpjunidade', 'CNPJ:', '', '', 'TEntry', 0, 0, 0, '-', '', '', 'populaCampo(''cnpjunidade'',''codigounidade'',''codigo'',''dbunidades'',''cnpj'')', '', 1, 0, 2, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (278, 'codigoprodutounidade', 'codigoprodutounidade', 'Item:', NULL, NULL, 'TCombo', 43, 1, 89, '-', NULL, NULL, NULL, NULL, 1, 1, 1, '1');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (318, 'codigounidade', 'codigounidade', 'Empresa:', '', '', 'TCombo', 42, 0, 0, '-', '', '', '', '', 1, 1, 2, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (322, 'codigocliente', 'codigocliente', 'Cliente:', '', '', 'TCombo', 42, 0, 0, '-', '', '', '', '', 1, 0, 2, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (320, 'ufunidade', 'ufunidade', 'UF:', '', '', 'TEntry', 0, 0, 0, '-', '', '', 'populaCampo(''ufunidade'',''codigounidade'',''codigo'',''dbunidades'',''estado'')', '', 1, 0, 2, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (321, 'ieunidade', 'ieunidade', 'IE:', '', '', 'TEntry', 0, 0, 0, '-', '', '', 'populaCampo(''ieunidade'',''codigounidade'',''codigo'',''dbunidades'',''inscestadual'')', '', 1, 0, 2, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (326, 'datacad', 'datacad', 'Data de Emissão:', '', 'CLASS_CALENDARIO', 'TEntry', 42, 0, 0, '-', 'setDataPT', 'setDataDB', '', '', 1, 0, 2, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (323, 'ie_rgcliente', 'ie_rgcliente', 'RG/IE:', '', '', 'TEntry', 0, 0, 0, '-', '', '', 'populaCampo(''ie_rgcliente'',''codigocliente'',''codigo'',''dbpessoas'',''rg_inscest'')', '', 1, 0, 2, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (324, 'ufcliente', 'ufcliente', 'UF:', '', '', 'TEntry', 0, 0, 0, '-', '', '', 'populaCampo(''ufcliente'',''codigocliente'',''codigo'',''dbpessoas'',''estado'')', '', 1, 0, 2, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (325, 'cpf_cnpjcliente', 'cpf_cnpjcliente', 'CPF/CNPJ:', '', '', 'TEntry', 0, 0, 0, '-', '', '', 'populaCampo(''cpf_cnpjcliente'',''codigocliente'',''codigo'',''dbpessoas'',''cpf_cnpj'')', '', 1, 0, 2, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (327, 'codigo', 'codigo', 'Nº Nota:', '', '', 'TEntry', 42, 0, 0, '-', '', '', '', '', 1, 0, 2, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (317, 'codigotipotransacao', 'codigotipotransacao', '', '', '', 'THidden', 42, 0, 0, '10000541-641', '', '', '', '', 1, 0, 2, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (338, 'valorindice', 'valorindice', '', '', '', 'THidden', 42, 0, 0, '-', '', '', 'populaCampo(''valorindice'',''codigocondicaopagamento'',''codigo'',''dbcondicoes_pagamento'',''indice'')', '', 1, 0, 2, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (329, 'valorfrete', 'valorfrete', 'Valor Frete:', '', 'CLASS_MASCARA_VALOR', 'TEntry', 42, 0, 0, '-', 'setMoney', 'setFloat', '', '', 1, 0, 2, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (330, 'valordespesas', 'valordespesas', 'Outras Despesas:', '', 'CLASS_MASCARA_VALOR', 'TEntry', 42, 0, 0, '-', 'setMoney', 'setFloat', '', '', 1, 0, 2, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (315, 'preco', 'preco', 'Preço:', NULL, NULL, 'TEntry', 56, 1, 0, '-', NULL, 'setFloat', NULL, NULL, 1, 1, 1, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (332, 'valordesconto', 'valordesconto', 'Valor Desconto:', '', 'CLASS_MASCARA_VALOR', 'TEntry', 42, 0, 0, '-', 'setMoney', 'setFloat', '', '', 1, 0, 2, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (333, 'valortotal', 'valortotal', 'Total da Nota:', '', '', 'TEntry', 42, 0, 0, '-', 'setMoney', 'setFloat', '', '', 1, 0, 2, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (334, 'codigocondicaopagamento', 'codigocondicaopagamento', 'Condição de Pagamento:', '', '', 'TCombo', 42, 0, 0, '-', '', '', '', '', 1, 0, 2, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (335, 'valorjuros', 'valorjuros', '', '', '', 'THidden', 42, 0, 0, '-', '', 'setFloat', '', '', 1, 0, 2, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (336, 'obs', 'obs', 'Observações:', '', '', 'TText', 42, 0, 0, '-', '', '', '', '', 1, 0, 2, '0');
INSERT INTO campos (id, colunadb, campo, label, mascara, seletor, tipo, entidade, ativafunction, ativapesquisa, valorpadrao, outcontrol, incontrol, trigger, help, ativo, valornull, alteravel, autosave) VALUES (328, 'valorprodutos', 'valorprodutos', 'Total Produtos:', '', '', 'TEntry', 0, 0, 0, '-', '', '', 'setValorTotalProdutosVendasDG()', '', 1, 0, 2, '0');


--
-- TOC entry 2026 (class 0 OID 21983)
-- Dependencies: 1566
-- Data for Name: campos_x_blocos; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (19, 5, 21, 'S', NULL, 1);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (1, 1, 1, 'S', NULL, 1);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (2, 1, 2, 'S', NULL, 2);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (3, 1, 3, 'S', NULL, 3);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (4, 1, 4, 'S', NULL, 4);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (20, 6, 24, 'S', NULL, 1);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (21, 6, 25, 'S', NULL, 2);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (23, 6, 27, 'S', NULL, 4);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (24, 6, 28, 'S', NULL, 5);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (25, 7, 29, 'S', NULL, 1);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (26, 8, 30, 'S', NULL, 1);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (27, 8, 31, 'S', NULL, 2);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (28, 8, 32, 'S', NULL, 3);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (30, 8, 34, 'S', NULL, 5);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (31, 8, 35, 'S', NULL, 6);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (33, 3, 39, 'S', NULL, 1);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (11, 3, 11, 'S', NULL, 2);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (16, 3, 16, 'S', NULL, 3);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (17, 3, 17, 'S', NULL, 4);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (18, 3, 18, 'S', NULL, 5);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (32, 3, 38, 'S', NULL, 6);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (5, 3, 5, 'S', NULL, 7);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (6, 3, 6, 'S', NULL, 8);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (7, 3, 7, 'S', NULL, 9);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (8, 3, 8, 'S', NULL, 10);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (9, 3, 9, 'S', NULL, 11);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (10, 3, 10, 'S', NULL, 12);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (12, 3, 12, 'S', NULL, 13);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (13, 3, 13, 'S', NULL, 14);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (14, 3, 14, 'S', NULL, 15);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (15, 3, 15, 'S', NULL, 16);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (34, 9, 40, 'S', '   ', 1);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (35, 9, 41, 'S', '   ', 2);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (36, 9, 42, 'S', '   ', 3);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (37, 9, 43, 'S', '   ', 4);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (38, 9, 44, 'S', '   ', 5);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (39, 9, 45, 'S', '   ', 8);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (40, 9, 46, 'S', '   ', 10);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (41, 9, 47, 'S', '   ', 12);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (42, 9, 48, 'S', '   ', 14);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (43, 9, 49, 'S', '   ', 16);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (44, 9, 50, 'S', '   ', 17);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (45, 9, 51, 'S', '   ', 18);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (46, 9, 52, 'S', '   ', 19);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (47, 10, 53, 'S', '   ', 1);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (48, 10, 54, 'S', '   ', 2);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (49, 10, 55, 'S', '   ', 2);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (50, 10, 56, 'S', '   ', 0);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (51, 11, 57, 'S', '   ', 1);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (52, 11, 58, 'S', '   ', 2);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (53, 11, 59, 'S', '   ', 3);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (54, 11, 60, 'S', '   ', 4);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (55, 11, 61, 'S', '   ', 5);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (56, 11, 62, 'S', '   ', 6);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (57, 11, 63, 'S', '   ', 7);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (58, 12, 64, 'S', '   ', 1);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (59, 12, 65, 'S', '   ', 2);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (60, 12, 66, 'S', '   ', 3);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (61, 12, 67, 'S', '   ', 4);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (62, 12, 68, 'S', '   ', 5);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (63, 12, 69, 'S', '   ', 6);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (64, 12, 70, 'S', '   ', 8);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (65, 12, 71, 'S', '   ', 9);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (66, 13, 72, 'S', '   ', 1);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (67, 15, 73, 'S', '   ', 0);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (68, 15, 74, 'S', '   ', 0);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (95, 22, 101, 'S', '   ', 2);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (96, 22, 102, 'S', '   ', 3);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (97, 22, 103, 'S', '   ', 4);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (98, 22, 104, 'S', '   ', 5);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (99, 22, 105, 'S', '   ', 6);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (100, 22, 106, 'S', '   ', 7);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (101, 22, 107, 'S', '   ', 8);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (102, 22, 108, 'S', '   ', 11);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (103, 22, 109, 'S', '   ', 12);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (104, 22, 110, 'S', '   ', 16);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (105, 22, 111, 'S', '   ', 1);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (106, 22, 112, 'S', '   ', 3);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (107, 22, 113, 'S', '   ', 0);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (108, 23, 114, 'S', '   ', 1);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (109, 23, 115, 'S', '   ', 2);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (110, 23, 116, 'S', '   ', 3);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (111, 23, 117, 'S', '   ', 4);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (112, 23, 118, 'S', '   ', 5);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (113, 23, 119, 'S', '   ', 6);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (114, 23, 120, 'S', '   ', 7);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (115, 23, 121, 'S', '   ', 8);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (116, 23, 122, 'S', '   ', 9);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (117, 23, 123, 'S', '   ', 10);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (118, 23, 124, 'S', '   ', 11);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (119, 23, 125, 'S', '   ', 13);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (120, 23, 126, 'S', '   ', 14);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (121, 24, 127, 'S', '   ', 23);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (122, 24, 128, 'S', '   ', 4);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (123, 24, 129, 'S', '   ', 5);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (124, 24, 130, 'S', '   ', 6);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (125, 24, 131, 'S', '   ', 3);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (126, 24, 132, 'S', '   ', 1);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (127, 24, 133, 'S', '   ', 7);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (128, 24, 134, 'S', '   ', 8);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (129, 24, 135, 'S', '   ', 9);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (131, 24, 137, 'S', '   ', 2);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (132, 24, 138, 'S', '   ', 3);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (133, 24, 139, 'S', '   ', 0);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (134, 25, 140, 'S', '   ', 1);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (135, 25, 141, 'S', '   ', 2);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (136, 25, 142, 'S', '   ', 3);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (137, 25, 143, 'S', '   ', 4);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (138, 26, 144, 'S', '   ', 1);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (139, 26, 145, 'S', '   ', 2);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (140, 26, 146, 'S', '   ', 3);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (141, 26, 147, 'S', '   ', 4);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (142, 26, 148, 'S', '   ', 0);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (173, 40, 179, 'S', '   ', 1);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (176, 40, 182, 'S', '   ', 4);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (177, 40, 183, 'S', '   ', 5);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (178, 40, 184, 'S', '   ', 6);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (179, 42, 185, 'S', '   ', 3);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (180, 42, 186, 'S', '   ', 2);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (181, 42, 187, 'S', '   ', 0);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (182, 42, 188, 'S', '   ', 1);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (183, 43, 189, 'S', '   ', 4);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (184, 43, 190, 'S', '   ', 2);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (185, 43, 191, 'S', '   ', 3);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (186, 43, 192, 'S', '   ', 5);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (187, 43, 193, 'S', '   ', 1);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (188, 44, 194, 'S', '   ', 5);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (189, 44, 195, 'S', '   ', 6);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (190, 44, 196, 'S', '   ', 1);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (191, 44, 197, 'S', '   ', 4);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (192, 44, 198, 'S', '   ', 2);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (193, 44, 199, 'S', '   ', 7);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (194, 44, 200, 'S', '   ', 3);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (195, 46, 201, 'S', '   ', 1);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (196, 46, 202, 'S', '   ', 2);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (197, 46, 203, 'S', '   ', 3);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (198, 46, 204, 'S', '   ', 4);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (199, 46, 205, 'S', '   ', 5);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (200, 46, 206, 'S', '   ', 6);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (201, 46, 207, 'S', '   ', 7);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (202, 46, 208, 'S', '   ', 8);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (206, 47, 214, 'S', NULL, 1);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (203, 47, 209, 'S', NULL, 2);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (204, 47, 212, 'S', NULL, 3);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (205, 47, 213, 'S', NULL, 4);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (209, 49, 217, 'S', NULL, 3);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (207, 49, 215, 'S', NULL, 1);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (208, 49, 216, 'S', NULL, 2);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (210, 40, 222, 'S', NULL, 5);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (211, 40, 221, 'S', NULL, 6);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (29, 8, 33, 'N', NULL, 4);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (213, 51, 224, 'S', NULL, 2);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (214, 42, 225, 'S', NULL, 1);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (215, 52, 226, 'S', NULL, 1);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (216, 52, 227, 'S', NULL, 2);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (218, 52, 229, 'S', NULL, 4);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (219, 52, 230, 'S', NULL, 5);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (220, 52, 231, 'S', NULL, 6);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (221, 54, 233, 'S', NULL, 1);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (222, 54, 234, 'S', NULL, 2);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (223, 54, 235, 'S', NULL, 3);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (224, 55, 236, 'S', NULL, 1);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (226, 55, 238, 'S', NULL, 3);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (227, 55, 239, 'S', NULL, 4);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (228, 55, 240, 'S', NULL, 5);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (229, 55, 241, 'S', NULL, 6);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (230, 55, 242, 'S', NULL, 7);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (231, 55, 243, 'S', NULL, 8);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (130, 24, 136, 'N', '   ', 10);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (217, 52, 228, 'N', NULL, 3);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (232, 57, 244, 'S', NULL, 1);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (233, 57, 245, 'S', NULL, 2);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (234, 57, 249, 'S', NULL, 3);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (267, 64, 282, 'S', NULL, 1);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (268, 64, 283, 'S', NULL, 2);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (269, 64, 284, 'S', NULL, 3);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (270, 64, 285, 'S', NULL, 4);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (271, 64, 286, 'S', NULL, 5);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (235, 58, 250, 'S', NULL, 1);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (236, 58, 251, 'S', NULL, 2);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (237, 58, 252, 'S', NULL, 3);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (238, 58, 253, 'S', NULL, 4);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (239, 58, 254, 'S', NULL, 5);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (240, 58, 255, 'S', NULL, 6);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (241, 59, 256, 'S', NULL, 1);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (242, 59, 257, 'S', NULL, 2);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (243, 59, 258, 'S', NULL, 3);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (244, 59, 259, 'S', NULL, 4);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (245, 59, 260, 'S', NULL, 5);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (246, 59, 261, 'S', NULL, 6);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (247, 59, 262, 'S', NULL, 7);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (248, 59, 263, 'S', NULL, 8);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (249, 59, 264, 'S', NULL, 9);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (250, 24, 265, 'S', NULL, 24);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (275, 68, 290, 'S', NULL, 1);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (276, 68, 291, 'S', NULL, 2);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (277, 68, 292, 'S', NULL, 3);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (278, 68, 301, 'S', NULL, 4);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (279, 68, 293, 'S', NULL, 5);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (282, 70, 296, 'S', NULL, 1);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (251, 60, 266, 'S', NULL, 1);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (252, 60, 267, 'S', NULL, 2);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (285, 72, 302, 'S', NULL, 1);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (286, 47, 305, 'S', NULL, 5);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (287, 47, 306, 'S', NULL, 6);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (255, 60, 270, 'S', NULL, 5);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (257, 61, 272, 'S', NULL, 1);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (261, 62, 276, 'S', NULL, 1);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (262, 62, 277, 'S', NULL, 2);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (263, 66, 278, 'S', NULL, 1);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (264, 66, 279, 'S', NULL, 2);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (265, 66, 280, 'S', NULL, 3);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (266, 66, 281, 'S', NULL, 4);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (272, 64, 287, 'S', NULL, 7);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (288, 64, 307, 'S', NULL, 6);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (289, 64, 308, 'S', NULL, 0);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (290, 62, 309, 'S', NULL, 3);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (291, 62, 310, 'S', NULL, 4);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (253, 60, 268, 'N', NULL, 3);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (254, 60, 269, 'N', NULL, 4);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (256, 60, 271, 'N', NULL, 6);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (260, 61, 275, 'S', NULL, 2);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (258, 61, 273, 'S', NULL, 3);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (259, 61, 274, 'S', NULL, 4);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (274, 67, 289, 'S', NULL, 1);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (308, 79, 329, 'S', NULL, 2);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (309, 79, 330, 'S', NULL, 3);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (292, 64, 311, 'S', NULL, 1);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (293, 75, 312, 'S', NULL, 2);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (294, 75, 313, 'S', NULL, 3);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (295, 75, 314, 'S', NULL, 4);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (296, 75, 315, 'S', NULL, 5);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (297, 75, 316, 'S', NULL, 6);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (310, 79, 332, 'S', NULL, 4);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (311, 79, 333, 'S', NULL, 5);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (312, 79, 334, 'S', NULL, 6);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (298, 76, 326, 'S', NULL, 1);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (299, 76, 327, 'S', NULL, 2);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (300, 76, 336, 'S', NULL, 3);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (301, 77, 318, 'S', NULL, 1);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (302, 77, 320, 'S', NULL, 2);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (303, 78, 322, 'S', NULL, 1);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (304, 78, 325, 'S', NULL, 2);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (305, 78, 323, 'S', NULL, 3);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (306, 78, 324, 'S', NULL, 4);
INSERT INTO campos_x_blocos (id, blocoid, campoid, mostrarcampo, formato, ordem) VALUES (313, 79, 328, 'S', NULL, 1);


--
-- TOC entry 2027 (class 0 OID 21991)
-- Dependencies: 1569
-- Data for Name: campos_x_propriedades; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (3, 'addItems', '1=>Ativo;0=>Inativo;2=>Standby', 1, 6);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (1, 'addItems', 'select codigo,nome_razaoSocial from dbpessoas where funcionario=''1'' and ativo=''1'' order by nome_razaoSocial', 1, 7);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (1, 'setSize', '450', 1, 8);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (17, 'setSize', '400', 1, 10);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (18, 'setSize', '400', 1, 11);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (16, 'setSize', '150', 1, 9);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (16, 'disabled', 'disabled', 1, 12);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (10, 'addItems', 'select codigo,nome from dbsalas where ativo=''1'' order by nome', 1, 16);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (6, 'addItems', 'Maquinário=>Maquinário;Prédio=>Prédio;Móvel e Ut.=>Móvel e Ut.;Veículo=>Veículo', 1, 17);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (21, 'setSize', '80%;80%', 1, 18);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (24, 'setSize', '400', 1, 19);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (25, 'setSize', '450;50', 1, 20);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (27, 'setSize', '450;100', 1, 21);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (30, 'setSize', '400', 1, 22);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (34, 'setSize', '50', 1, 24);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (35, 'setSize', '50', 1, 25);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (31, 'setSize', '450;100', 1, 23);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (5, 'setSize', '500;40', 1, 14);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (15, 'setSize', '500;40', 1, 13);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (11, 'addItems', 'select codigofuncionario,nomefuncionario from view_pessoas_funcionarios order by nomefuncionario', 1, 15);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (28, 'addItems', 'select codigofuncionario,nomefuncionario from view_pessoas_funcionarios order by nomefuncionario', 1, 26);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (38, 'setSize', '400', 1, 27);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (39, 'addItems', 'select codigo,produto from dbprodutos order by produto', 1, 28);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (39, 'disabled', 'disabled', 1, 29);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (40, 'setSize', '450', 1, 30);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (41, 'setSize', '200', 1, 31);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (42, 'setSize', '200', 1, 32);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (43, 'setSize', '50', 1, 33);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (43, 'addItems', '=>;AC=>AC;AL=>AL;AP=>AP;AM=>AM;BA=>BA;CE=>CE;DF=>DF;ES=>ES;GO=>GO;MA=>MA;MT=>MT;MS=>MS;MG=>MG;PA=>PA;PB=>PB;PR=>PR;PE=>PE;PI=>PI;RJ=>RJ;RN=>RN;RS=>RS;RO=>RO;RR=>RR;SC=>SC;SP=>SP;SE=>SE;TO=>TO', 1, 34);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (44, 'setSize', '200', 1, 35);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (45, 'setSize', '450', 1, 36);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (46, 'setSize', '180', 1, 37);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (47, 'setSize', '180', 1, 38);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (48, 'setSize', '180', 1, 39);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (49, 'setSize', '180 ', 1, 40);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (50, 'setSize', '300', 1, 41);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (51, 'setSize', '300', 1, 42);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (52, 'setSize', '300', 1, 43);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (53, 'addItems', 'F=>Pessoa Física;J=>Pessoa Jurídica', 1, 44);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (53, 'onClick', 'setTipoForm(this)', 1, 45);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (54, 'setSize', '100', 1, 46);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (54, 'setProperty', 'disabled;disabled', 1, 47);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (55, 'setSize', '100', 1, 48);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (55, 'setproperty', 'disabled;disabled', 1, 49);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (57, 'setSize', '450', 1, 51);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (58, 'setSize', '180', 1, 52);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (59, 'setSize', '120', 1, 53);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (60, 'setSize', '120', 1, 54);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (61, 'setSize', '450', 1, 55);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (62, 'setSize', '450', 1, 56);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (63, 'setSize', '450', 1, 57);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (64, 'setSize', '450', 1, 58);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (65, 'setSize', '180', 1, 59);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (66, 'setSize', '100', 1, 60);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (67, 'setSize', '100', 1, 61);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (68, 'setSize', '130', 1, 62);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (68, 'addItems', '=>;Solteiro=>Solteiro;Casado=>Casado;Divorciado=>Divorciado;Outros=>Outros', 1, 63);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (69, 'addItems', '=>;afro-brasileiro (negro)=>afro-brasileiro (negro);asiático=>asiático;caucasiano (branco)=>caucasiano (branco);Índias Orientais=>Índias Orientais;hispânico/latino=>hispânico/latino;Oriente Médio=>Oriente Médio;indígena americano=>indígena americano', 1, 64);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (69, 'setSize', '180', 1, 65);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (70, 'setSize', '100', 1, 66);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (71, 'setSize', '100', 1, 67);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (72, 'addItems', 'select codigo,titulo from view_convenios order by titulo', 1, 68);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (72, 'setProperty', 'disabled;disabled', 1, 69);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (72, 'setSize', '450', 1, 70);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (73, 'setSize', '200', 1, 71);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (73, 'addItems', '=>;Matutino=>Matutino;Vespertino=>Vespertino;Noturno=>Noturno', 1, 72);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (74, 'setSize', '300', 1, 73);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (74, 'addItems', 'select codigo, nome from dbcursos where ativo=''1'' order by nome', 1, 74);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (101, 'setSize', '450', 1, 101);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (102, 'setSize', '180', 1, 102);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (103, 'setSize', '160', 1, 103);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (104, 'addItems', 'M=>Masculino;F=>Feminino', 1, 104);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (105, 'addItems', '=>Selecione;Solteiro=>Solteiro;Casado=>Casado;Divorciado=>Divorciado;Outros=>Outros', 1, 105);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (105, 'setSize', '100', 1, 106);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (106, 'setSize', '160', 1, 107);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (107, 'setSize', '160', 1, 108);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (108, 'setSize', '40%', 1, 109);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (109, 'setSize', '40', 1, 110);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (110, 'setSize', '450;60', 1, 111);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (111, 'setSize', '100', 1, 112);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (112, 'setSize', '100', 1, 113);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (114, 'setSize', '450', 1, 114);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (115, 'setSize', '160', 1, 115);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (116, 'setSize', '160	 ', 1, 116);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (117, 'setSize', '50', 1, 117);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (117, 'addItems', '=>;AC=>AC;AL=>AL;AP=>AP;AM=>AM;BA=>BA;CE=>CE;DF=>DF;ES=>ES;GO=>GO;MA=>MA;MT=>MT;MS=>MS;MG=>MG;PA=>PA;PB=>PB;PR=>PR;PE=>PE;PI=>PI;RJ=>RJ;RN=>RN;RS=>RS;RO=>RO;RR=>RR;SC=>SC;SP=>SP;SE=>SE;TO=>TO', 1, 118);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (118, 'setSize', '200', 1, 119);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (119, 'setSize', '300', 1, 120);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (120, 'setSize', '180', 1, 121);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (121, 'setSize', '180', 1, 122);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (122, 'addItems', 'Sim=>Sim;Não=>Não', 1, 123);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (123, 'setSize', '300;40', 1, 124);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (124, 'setSize', '160', 1, 125);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (125, 'addItems', 'Nenhuma=>Nenhuma;A=>A;B=>B;C=>C;D=>D;AB=>AB;AC=>AC;AD=>AD;', 1, 126);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (125, 'setSize', '100', 1, 127);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (126, 'setSize', '300;40', 1, 128);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (127, 'addItems', '1=>Ativo;0=>Inativo;2=>Standby', 1, 129);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (128, 'setSize', '350;60', 1, 130);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (129, 'setSize', '160', 1, 131);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (130, 'setSize', '160', 1, 132);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (130, 'addItems', 'select codigo,nome from dbsalas where ativo=''1'' order by nome', 1, 133);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (131, 'setSize', '160', 1, 134);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (132, 'setSize', '250', 1, 135);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (132, 'addItems', 'select codigo,nomeCargo from dbcargos where ativo=''1'' order by nomeCargo', 1, 136);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (132, 'setSize', '350', 1, 137);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (133, 'setSize', '160', 1, 138);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (134, 'setSize', '350;60', 1, 139);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (135, 'setSize', '160', 1, 140);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (136, 'setSize', '160', 1, 141);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (137, 'setSize', '250', 1, 142);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (137, 'onChange', 'setEmpTerc(this);', 1, 143);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (137, 'addItems', '=>;0=>CLT;1=>RPA;2=>Pessoa Jurídica;3=>Propriedade', 1, 144);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (138, 'setSize', '350', 1, 145);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (138, 'setProperty', 'disabled;disabled', 1, 146);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (138, 'addItems', 'select codigo,nome_razaoSocial from dbpessoas where fornecedor=''1'' and ativo=''1'' order by nome_razaoSocial', 1, 147);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (139, 'addItems', 'select codigo,label from dbdepartamentos where ativo=''1'' order by label', 1, 148);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (140, 'setSize', '250', 1, 149);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (141, 'setSize', '100', 1, 150);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (142, 'setSize', '100', 1, 151);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (143, 'setSize', '20', 1, 152);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (144, 'setSize', '450', 1, 153);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (145, 'setSize', '450', 1, 154);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (147, 'setSize', '450;60', 1, 155);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (148, 'addItems', 'select codigo,titularidade from dbpessoas_titularidades order by peso', 1, 156);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (179, 'setSize', '300', 1, 189);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (181, 'setSize', '100%;100', 1, 191);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (182, 'setSize', '80', 1, 192);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (186, 'addItems', 'select codigo,nome_razaoSocial from dbpessoas where cliente=''1'' and ativo=''1'' order by nome_razaoSocial', 1, 196);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (188, 'setProperty', 'disabled;disabled', 1, 197);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (189, 'setSize', '150', 1, 198);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (189, 'addItems', '1=>Conta Aberta;5=>Conta Programada', 1, 199);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (190, 'setSize', '80', 1, 200);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (191, 'setSize', '80', 1, 201);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (192, 'setSize', '450;50', 1, 202);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (193, 'setSize', '100', 1, 203);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (193, 'setProperty', 'disabled;disabled', 1, 204);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (194, 'setSize', '200', 1, 205);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (195, 'setSize', '80', 1, 206);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (196, 'setSize', '300', 1, 207);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (197, 'setSize', '150', 1, 208);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (198, 'setSize', '200', 1, 209);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (200, 'setSize', '150', 1, 210);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (201, 'setSize', '60', 1, 211);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (201, 'disabled', 'disabled', 1, 212);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (202, 'setSize', '90', 1, 213);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (202, 'onChange', 'calculaMovimentacao(''valortotal'',''acrescimo'',''desconto'',null,null,null,''valorcorrigido'');', 1, 214);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (203, 'setSize', '90', 1, 215);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (203, 'onChange', 'calculaMovimentacao(''valortotal'',''acrescimo'',''desconto'',null,null,null,''valorcorrigido'');', 1, 216);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (204, 'disabled', 'disabled', 1, 217);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (204, 'setSize', '90', 1, 218);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (205, 'setSize', '90', 1, 219);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (208, 'setAction', 'addContas(this,''codigo'', ''236'')', 1, 220);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (209, 'setSize', '50', 1, 223);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (212, 'setSize', '50', 1, 224);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (213, 'setSize', '50', 1, 225);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (213, 'addItems', '1=>Sim;0=>Não', 1, 226);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (185, 'disabled', 'disabled', 1, 227);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (179, 'addItems', 'select codigo,produto from dbprodutos order by produto', 1, 190);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (214, 'maxlength', '40', 1, 228);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (214, 'setSize', '250', 1, 231);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (185, 'addItems', 'select codigo,descricao from dbcondicoes_pagamento', 1, 195);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (216, 'setSize', '50', 1, 232);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (217, 'setSize', '50', 1, 233);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (217, 'onblur', 'viewProdutoValor()', 1, 236);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (216, 'onblur', 'viewProdutoValor()', 1, 235);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (215, 'addItems', 'TD=>Todos;AC=>AC;AL=>AL;AP=>AP;AM=>AM;BA=>BA;CE=>CE;DF=>DF;ES=>ES;GO=>GO;MA=>MA;MT=>MT;MS=>MS;MG=>MG;PA=>PA;PB=>PB;PR=>PR;PE=>PE;PI=>PI;RJ=>RJ;RN=>RN;RS=>RS;RO=>RO;RR=>RR;SC=>SC;SP=>SP;SE=>SE;TO=>TO', 1, 234);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (182, 'onchange', 'setMoney()', 1, 237);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (182, 'disabled', 'disabled', 1, 238);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (183, 'onblur', 'calculaValorItem()', 1, 239);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (182, 'onchange', 'calculaValorItem()', 1, 240);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (224, 'addItems', 'select codigo,descricao from dbcondicoes_pagamento', 1, 245);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (223, 'addItems', 'select codigofuncionario,nomefuncionario from view_pessoas_funcionarios', 1, 246);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (182, 'setSize', '50', 1, 248);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (183, 'setSize', '50', 1, 249);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (184, 'setSize', '50', 1, 250);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (221, 'setSize', '50', 1, 251);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (221, 'disabled', 'disabled', 1, 253);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (230, 'disabled', 'disabled', 1, 260);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (184, 'onblur', 'calculaValorItem()', 1, 241);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (226, 'setSize', '100', 1, 255);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (226, 'disabled', 'disabled', 1, 256);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (227, 'disabled', 'disabled', 1, 257);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (228, 'disabled', 'disabled', 1, 258);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (229, 'disabled', 'disabled', 1, 259);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (231, 'disabled', 'disabled', 1, 261);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (230, 'setSize', '80', 1, 262);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (231, 'setSize', '80', 1, 263);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (228, 'addItems', 'select codigofuncionario,nomefuncionario from view_pessoas_funcionarios', 1, 264);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (229, 'addItems', 'select codigo,descricao from dbcondicoes_pagamento', 1, 265);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (227, 'addItems', 'select codigo,nome_razaoSocial from dbpessoas where cliente=''1'' and ativo=''1'' order by nome_razaoSocial', 1, 266);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (236, 'addItems', 'saca=>Saca;caixa=>Caixa;peça=>Peça;unidade=>Unidade;', 1, 267);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (237, 'setSize', '50', 1, 271);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (239, 'setSize', '50', 1, 273);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (240, 'setSize', '50', 1, 274);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (241, 'setSize', '50', 1, 275);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (242, 'setSize', '50', 1, 276);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (243, 'setSize', '50', 1, 277);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (233, 'setSize', '450;60', 1, 268);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (234, 'setSize', '450;60', 1, 269);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (238, 'setSize', '120', 1, 272);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (238, 'maxlength', '20', 1, 278);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (235, 'setSize', '450;60', 1, 270);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (245, 'setSize', '50', 1, 283);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (249, 'addItems', 'select codigo,tipomovimentacao FROM dbtipos_movimentacao order by tipomovimentacao', 1, 284);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (244, 'addItems', 'select codigo,produto FROM dbprodutos order by produto', 1, 282);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (250, 'setSize', '100', 1, 285);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (253, 'setSize', '200;50', 1, 288);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (254, 'setSize', '30', 1, 289);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (255, 'setSize', '30', 1, 290);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (250, 'disabled', 'disabled', 1, 291);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (251, 'disabled', 'disabled', 1, 292);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (252, 'disabled', 'disabled', 1, 293);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (253, 'disabled', 'disabled', 1, 294);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (254, 'disabled', 'disabled', 1, 296);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (256, 'disabled', 'disabled', 1, 297);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (257, 'disabled', 'disabled', 1, 298);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (258, 'disabled', 'disabled', 1, 299);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (259, 'disabled', 'disabled', 1, 300);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (260, 'disabled', 'disabled', 1, 301);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (261, 'disabled', 'disabled', 1, 302);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (259, 'setSize', '200;50', 1, 304);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (257, 'setSize', '350', 1, 303);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (252, 'setSize', '300', 1, 287);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (256, 'setSize', '100', 1, 305);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (260, 'setSize', '30', 1, 307);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (261, 'setSize', '30', 1, 308);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (263, 'setSize', '30', 1, 309);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (264, 'addItems', '1=>Conferido;2=>Não Conferido', 1, 310);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (262, 'addItems', 'select blccseq,blccapel from tab_balancocontadorconferente order by blccapel', 1, 311);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (4, 'addItems', '0=>Aleatório;1=>Custom_petrus;2=>Eggplant;3=>Redmond;4=>Ui-lightness;5=>Black-tie;6=>Sunny;7=>Pepper-grinder;8=>Dot-luv;9=>Ui-tolook;10=>Blitzer;11=>Petrusedu;12=>Petrusedu_alternate;13=>Bluestyle;14=>Flick;15=>Humanity;16=>Overcast;17=>Bluetzer;18=>Fibratec;19=>Remake_bluetzer;20=>South-street;21=>Cupertino;22=>Petrus;', 1, 5);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (251, 'setSize', '350', 1, 286);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (258, 'setSize', '300', 1, 306);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (267, 'setSize', '350', 1, 313);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (268, 'setSize', '350', 1, 314);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (269, 'setSize', '120', 1, 315);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (270, 'setSize', '20', 1, 316);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (274, 'setSize', '20', 1, 320);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (275, 'setSize', '120', 1, 321);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (268, 'disabled', 'disabled', 1, 325);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (269, 'disabled', 'disabled', 1, 326);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (270, 'disabled', 'disabled', 1, 327);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (271, 'disabled', 'disabled', 1, 328);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (273, 'disabled', 'disabled', 1, 329);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (274, 'disabled', 'disabled', 1, 330);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (275, 'disabled', 'disabled', 1, 331);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (267, 'addItems', 'select codigo,nomeunidade from dbunidades order by nomeunidade', 1, 332);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (279, 'onblur', 'calculaValorItem()', 1, 334);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (278, 'setSize', '350', 1, 337);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (282, 'disabled', 'disabled', 1, 342);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (285, 'disabled', 'disabled', 1, 343);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (287, 'disabled', 'disabled', 1, 347);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (276, 'setSize', '100', 1, 322);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (277, 'setSize', '100', 1, 323);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (279, 'setSize', '50', 1, 338);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (280, 'setSize', '50', 1, 339);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (281, 'setSize', '50', 1, 340);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (279, 'disabled', 'disabled', 1, 353);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (281, 'disabled', 'disabled', 1, 354);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (308, 'onblur', 'setValorTotalTransacaoDG()', 1, 380);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (309, 'setSize', '350;30', 1, 381);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (292, 'addItems', 'select codigo, unidademedida || '' ('' || abreviacao || '')'' as unidademedida from dominio.dbunidade_medida order by unidademedida', 1, 382);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (292, 'setSize', '100', 1, 364);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (272, 'addItems', 'select codigo,nome_razaosocial from dbpessoas where cliente=''1'' order by nome_razaosocial', 0, 333);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (273, 'setSize', '80', 1, 319);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (282, 'onblur', 'setValorTotalTransacaoDG()', 1, 355);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (291, 'setSize', '100', 1, 363);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (290, 'setSize', '250', 1, 362);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (301, 'setSize', '350;50', 1, 365);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (293, 'setSize', '100', 1, 366);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (294, 'setSize', '50', 1, 367);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (295, 'setSize', '50', 1, 368);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (296, 'setSize', '350;50', 1, 369);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (300, 'setSize', '350', 1, 371);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (272, 'setSize', '400', 1, 318);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (299, 'setSize', '250', 1, 370);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (299, 'addItems', 'select codigo,nomeunidade || '' - '' || estado || ''  (CNPJ: '' || cnpj || '')'' nomeunidade  from dbunidades', 1, 372);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (302, 'addItems', 'select codigo,descricao from tab_produto where ativo != ''9'' order by descricao ', 1, 375);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (271, 'setSize', '80', 1, 317);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (283, 'onblur', 'setValorTotalTransacaoDG()', 1, 356);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (284, 'onblur', 'setValorTotalTransacaoDG()', 1, 357);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (293, 'addItems', 'select codigo,marca from tab_marcas order by marca', 1, 383);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (280, 'onblur', 'calculaValorItem()', 1, 335);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (272, 'addItems', 'select codigo,nome_razaosocial from dbpessoas', 1, 385);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (286, 'onblur', 'calculaDescontoDG(''valormaxdesconto'',''valordesconto'');setValorTotalTransacaoDG()', 1, 358);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (307, 'addItems', 'select codigo,descricao from dbcondicoes_pagamento where ativo != ''9'' order by obs', 1, 377);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (307, 'onchange', 'populaCampo(''valorindice'',''codigocondicaopagamento'',''codigo'',''dbcondicoes_pagamento'',''indice'');setValorTotalTransacaoDG()', 1, 379);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (312, 'addItems', 'select codigo,nomeunidade || '' - '' || estado || ''  (CNPJ: '' || cnpj || '')'' nomeunidade  from dbunidades', 1, 389);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (313, 'setSize', '50', 1, 390);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (314, 'setSize', '50', 1, 391);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (315, 'setSize', '50', 1, 392);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (316, 'setSize', '350', 1, 393);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (278, 'addItems', 'select codigo,produto from view_produtos_unidade', 1, 394);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (334, 'addItems', 'select codigo,descricao from dbcondicoes_pagamento where ativo != ''9'' order by obs', 1, 395);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (322, 'addItems', 'select codigo,nome_razaosocial from dbpessoas', 1, 396);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (318, 'addItems', 'select codigo,nomeunidade || '' - '' || estado || ''  (CNPJ: '' || cnpj || '')'' nomeunidade  from dbunidades', 1, 397);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (336, 'setSize', '350;20', 1, 398);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (317, 'disabled', 'disabled', 1, 399);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (318, 'disabled', 'disabled', 1, 400);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (319, 'disabled', 'disabled', 1, 401);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (320, 'disabled', 'disabled', 1, 402);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (321, 'disabled', 'disabled', 1, 403);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (322, 'disabled', 'disabled', 1, 404);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (323, 'disabled', 'disabled', 1, 405);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (324, 'disabled', 'disabled', 1, 406);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (325, 'disabled', 'disabled', 1, 407);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (326, 'disabled', 'disabled', 1, 408);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (327, 'disabled', 'disabled', 1, 409);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (328, 'disabled', 'disabled', 1, 410);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (329, 'disabled', 'disabled', 1, 411);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (330, 'disabled', 'disabled', 1, 412);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (332, 'disabled', 'disabled', 1, 413);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (333, 'disabled', 'disabled', 1, 414);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (334, 'disabled', 'disabled', 1, 415);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (335, 'disabled', 'disabled', 1, 416);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (336, 'disabled', 'disabled', 1, 417);
INSERT INTO campos_x_propriedades (campoid, metodo, valor, ativo, id) VALUES (338, 'disabled', 'disabled', 1, 418);


--
-- TOC entry 2028 (class 0 OID 21999)
-- Dependencies: 1570
-- Data for Name: form_button; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO form_button (id, form, botao, labelbotao, confirmacao, actionjs, metodo, ordem, ativo) VALUES (1, 79, 'pedidoEfetivar', 'Efetivar', 'Deseja realmente efetivar o pedido?', 'efetivaPedido', NULL, '1 ', '1');


--
-- TOC entry 2029 (class 0 OID 22009)
-- Dependencies: 1572
-- Data for Name: form_validacao; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2030 (class 0 OID 22015)
-- Dependencies: 1574
-- Data for Name: form_x_abas; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO form_x_abas (id, formid, abaid, ativo, ordem) VALUES (1, 1, 1, '1', 1);
INSERT INTO form_x_abas (id, formid, abaid, ativo, ordem) VALUES (2, 1, 2, '1', 2);
INSERT INTO form_x_abas (id, formid, abaid, ativo, ordem) VALUES (3, 3, 3, '1', 1);
INSERT INTO form_x_abas (id, formid, abaid, ativo, ordem) VALUES (4, 3, 4, '1', 2);
INSERT INTO form_x_abas (id, formid, abaid, ativo, ordem) VALUES (5, 5, 5, '1', 1);
INSERT INTO form_x_abas (id, formid, abaid, ativo, ordem) VALUES (6, 7, 6, '1', 1);
INSERT INTO form_x_abas (id, formid, abaid, ativo, ordem) VALUES (7, 8, 7, '1', 1);
INSERT INTO form_x_abas (id, formid, abaid, ativo, ordem) VALUES (8, 9, 8, '1', 1);
INSERT INTO form_x_abas (id, formid, abaid, ativo, ordem) VALUES (9, 18, 9, '1', 2);
INSERT INTO form_x_abas (id, formid, abaid, ativo, ordem) VALUES (10, 18, 10, '1', 1);
INSERT INTO form_x_abas (id, formid, abaid, ativo, ordem) VALUES (12, 20, 12, '1', 1);
INSERT INTO form_x_abas (id, formid, abaid, ativo, ordem) VALUES (14, 22, 14, '1', 1);
INSERT INTO form_x_abas (id, formid, abaid, ativo, ordem) VALUES (24, 32, 24, '1', 1);
INSERT INTO form_x_abas (id, formid, abaid, ativo, ordem) VALUES (25, 34, 25, '1', 1);
INSERT INTO form_x_abas (id, formid, abaid, ativo, ordem) VALUES (34, 48, 34, '1', 1);
INSERT INTO form_x_abas (id, formid, abaid, ativo, ordem) VALUES (35, 50, 35, '1', 1);
INSERT INTO form_x_abas (id, formid, abaid, ativo, ordem) VALUES (36, 48, 36, '0', 2);
INSERT INTO form_x_abas (id, formid, abaid, ativo, ordem) VALUES (37, 52, 37, '0', 1);
INSERT INTO form_x_abas (id, formid, abaid, ativo, ordem) VALUES (38, 54, 38, '1', 1);
INSERT INTO form_x_abas (id, formid, abaid, ativo, ordem) VALUES (40, 58, 40, '1', 1);
INSERT INTO form_x_abas (id, formid, abaid, ativo, ordem) VALUES (41, 63, 41, '1', 1);
INSERT INTO form_x_abas (id, formid, abaid, ativo, ordem) VALUES (42, 65, 42, '1', 1);
INSERT INTO form_x_abas (id, formid, abaid, ativo, ordem) VALUES (43, 65, 43, '1', 1);
INSERT INTO form_x_abas (id, formid, abaid, ativo, ordem) VALUES (39, 9, 39, '1', 3);
INSERT INTO form_x_abas (id, formid, abaid, ativo, ordem) VALUES (44, 9, 44, '1', 2);
INSERT INTO form_x_abas (id, formid, abaid, ativo, ordem) VALUES (46, 72, 46, '1', 1);
INSERT INTO form_x_abas (id, formid, abaid, ativo, ordem) VALUES (47, 75, 47, '1', 1);
INSERT INTO form_x_abas (id, formid, abaid, ativo, ordem) VALUES (48, 77, 48, '1', 1);
INSERT INTO form_x_abas (id, formid, abaid, ativo, ordem) VALUES (49, 79, 49, '1', 1);
INSERT INTO form_x_abas (id, formid, abaid, ativo, ordem) VALUES (53, 81, 53, '1', 1);
INSERT INTO form_x_abas (id, formid, abaid, ativo, ordem) VALUES (54, 84, 54, '1', 1);
INSERT INTO form_x_abas (id, formid, abaid, ativo, ordem) VALUES (56, 85, 56, '1', 2);
INSERT INTO form_x_abas (id, formid, abaid, ativo, ordem) VALUES (55, 85, 55, '1', 1);
INSERT INTO form_x_abas (id, formid, abaid, ativo, ordem) VALUES (57, 87, 57, '1', 1);
INSERT INTO form_x_abas (id, formid, abaid, ativo, ordem) VALUES (20, 30, 20, '1', 1);
INSERT INTO form_x_abas (id, formid, abaid, ativo, ordem) VALUES (21, 30, 21, '1', 2);
INSERT INTO form_x_abas (id, formid, abaid, ativo, ordem) VALUES (22, 30, 22, '1', 3);
INSERT INTO form_x_abas (id, formid, abaid, ativo, ordem) VALUES (45, 30, 45, '1', 4);
INSERT INTO form_x_abas (id, formid, abaid, ativo, ordem) VALUES (58, 94, 59, '1', 1);
INSERT INTO form_x_abas (id, formid, abaid, ativo, ordem) VALUES (59, 96, 60, '1', 1);
INSERT INTO form_x_abas (id, formid, abaid, ativo, ordem) VALUES (50, 79, 50, '1', 2);
INSERT INTO form_x_abas (id, formid, abaid, ativo, ordem) VALUES (51, 79, 51, '1', 3);
INSERT INTO form_x_abas (id, formid, abaid, ativo, ordem) VALUES (60, 96, 61, '1', 3);
INSERT INTO form_x_abas (id, formid, abaid, ativo, ordem) VALUES (61, 96, 62, '1', 2);


--
-- TOC entry 2031 (class 0 OID 22022)
-- Dependencies: 1576
-- Data for Name: form_x_tabelas; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO form_x_tabelas (id, formid, tabelaid, ativo) VALUES (1, 1, 1, '1');
INSERT INTO form_x_tabelas (id, formid, tabelaid, ativo) VALUES (2, 3, 4, '1');
INSERT INTO form_x_tabelas (id, formid, tabelaid, ativo) VALUES (3, 5, 5, '1');
INSERT INTO form_x_tabelas (id, formid, tabelaid, ativo) VALUES (4, 7, 7, '1');
INSERT INTO form_x_tabelas (id, formid, tabelaid, ativo) VALUES (5, 8, 8, '1');
INSERT INTO form_x_tabelas (id, formid, tabelaid, ativo) VALUES (6, 9, 9, '1');
INSERT INTO form_x_tabelas (id, formid, tabelaid, ativo) VALUES (8, 18, 12, '1');
INSERT INTO form_x_tabelas (id, formid, tabelaid, ativo) VALUES (9, 18, 13, '1');
INSERT INTO form_x_tabelas (id, formid, tabelaid, ativo) VALUES (12, 20, 16, '1');
INSERT INTO form_x_tabelas (id, formid, tabelaid, ativo) VALUES (13, 22, 17, '1');
INSERT INTO form_x_tabelas (id, formid, tabelaid, ativo) VALUES (14, 24, 18, '1');
INSERT INTO form_x_tabelas (id, formid, tabelaid, ativo) VALUES (26, 30, 12, '1');
INSERT INTO form_x_tabelas (id, formid, tabelaid, ativo) VALUES (27, 30, 31, '1');
INSERT INTO form_x_tabelas (id, formid, tabelaid, ativo) VALUES (29, 32, 14, '1');
INSERT INTO form_x_tabelas (id, formid, tabelaid, ativo) VALUES (30, 34, 34, '1');
INSERT INTO form_x_tabelas (id, formid, tabelaid, ativo) VALUES (38, 48, 42, '1');
INSERT INTO form_x_tabelas (id, formid, tabelaid, ativo) VALUES (39, 48, 43, '1');
INSERT INTO form_x_tabelas (id, formid, tabelaid, ativo) VALUES (40, 48, 44, '1');
INSERT INTO form_x_tabelas (id, formid, tabelaid, ativo) VALUES (42, 50, 43, '1');
INSERT INTO form_x_tabelas (id, formid, tabelaid, ativo) VALUES (25, 30, 1, '1');
INSERT INTO form_x_tabelas (id, formid, tabelaid, ativo) VALUES (24, 30, 3, '1');
INSERT INTO form_x_tabelas (id, formid, tabelaid, ativo) VALUES (7, 18, 3, '1');
INSERT INTO form_x_tabelas (id, formid, tabelaid, ativo) VALUES (28, 30, 3, '1');
INSERT INTO form_x_tabelas (id, formid, tabelaid, ativo) VALUES (45, 58, 49, '1');
INSERT INTO form_x_tabelas (id, formid, tabelaid, ativo) VALUES (46, 63, 50, '1');
INSERT INTO form_x_tabelas (id, formid, tabelaid, ativo) VALUES (47, 65, 42, '1');
INSERT INTO form_x_tabelas (id, formid, tabelaid, ativo) VALUES (48, 9, 51, '1');
INSERT INTO form_x_tabelas (id, formid, tabelaid, ativo) VALUES (49, 72, 10, '1');
INSERT INTO form_x_tabelas (id, formid, tabelaid, ativo) VALUES (50, 75, 52, '1');
INSERT INTO form_x_tabelas (id, formid, tabelaid, ativo) VALUES (51, 77, 52, '1');
INSERT INTO form_x_tabelas (id, formid, tabelaid, ativo) VALUES (52, 84, 53, '1');


--
-- TOC entry 2032 (class 0 OID 22028)
-- Dependencies: 1578
-- Data for Name: forms; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO forms (id, form, nomeform, entidade, ativo, formpai, idlista, formainclude, dimensao, botconcluir, botcancelar, formoutcontrol, autosave) VALUES (5, 'formFotosPatrimonios', 'Fotos', '5', '1', '3', '6', 'one', '600;500', '1', '1', '0', '0');
INSERT INTO forms (id, form, nomeform, entidade, ativo, formpai, idlista, formainclude, dimensao, botconcluir, botcancelar, formoutcontrol, autosave) VALUES (8, 'formDepartamentos', 'Departamentos', '8', '1', '0', '13', 'one', '350;200', '1', '1', '0', '0');
INSERT INTO forms (id, form, nomeform, entidade, ativo, formpai, idlista, formainclude, dimensao, botconcluir, botcancelar, formoutcontrol, autosave) VALUES (24, 'histCliente-Movimentacoes', 'Histórico', '18', '1', '18', '25', 'one', '', '0', '0', '0', '0');
INSERT INTO forms (id, form, nomeform, entidade, ativo, formpai, idlista, formainclude, dimensao, botconcluir, botcancelar, formoutcontrol, autosave) VALUES (54, 'formasPagamento', 'Condições de Pagamento', '48', '1', '0', '55', 'one', '500;250', '1', '1', '0', '0');
INSERT INTO forms (id, form, nomeform, entidade, ativo, formpai, idlista, formainclude, dimensao, botconcluir, botcancelar, formoutcontrol, autosave) VALUES (58, 'produtosMarkup', 'Formulação de Preços', '49', '1', '9', '61', 'one', '500;400', '1', '1', '0', '0');
INSERT INTO forms (id, form, nomeform, entidade, ativo, formpai, idlista, formainclude, dimensao, botconcluir, botcancelar, formoutcontrol, autosave) VALUES (9, 'formProdutos', 'Produtos', '9', '1', '0', '14', 'one', NULL, '1', '1', '0', '1');
INSERT INTO forms (id, form, nomeform, entidade, ativo, formpai, idlista, formainclude, dimensao, botconcluir, botcancelar, formoutcontrol, autosave) VALUES (50, 'formprodutotransacao', 'Produtos', '43', '1', '48', '51', 'one', '900;450', '1', '1', 'TTransacao/reservaProduto', '0');
INSERT INTO forms (id, form, nomeform, entidade, ativo, formpai, idlista, formainclude, dimensao, botconcluir, botcancelar, formoutcontrol, autosave) VALUES (1, 'formUsuarios', 'Gerenciar Usuários', '1', '1', '0', '2', 'one', NULL, '1', '1', '0', '0');
INSERT INTO forms (id, form, nomeform, entidade, ativo, formpai, idlista, formainclude, dimensao, botconcluir, botcancelar, formoutcontrol, autosave) VALUES (7, 'formSalas', 'Salas', '7', '1', '0', '12', 'one', NULL, '1', '1', '0', '0');
INSERT INTO forms (id, form, nomeform, entidade, ativo, formpai, idlista, formainclude, dimensao, botconcluir, botcancelar, formoutcontrol, autosave) VALUES (3, 'formPatrimonios', 'Patrimonios', '4', '1', '0', '4', 'one', NULL, '1', '1', '0', '0');
INSERT INTO forms (id, form, nomeform, entidade, ativo, formpai, idlista, formainclude, dimensao, botconcluir, botcancelar, formoutcontrol, autosave) VALUES (69, 'itensFaturamento', 'Intens do Pedido', '43', '1', '65', '68', 'one', NULL, '1', '1', '0', '0');
INSERT INTO forms (id, form, nomeform, entidade, ativo, formpai, idlista, formainclude, dimensao, botconcluir, botcancelar, formoutcontrol, autosave) VALUES (65, 'faturamento', 'Pedidos para Faturamento', '42', '1', '0', '67', 'one', NULL, '1', '1', '0', '0');
INSERT INTO forms (id, form, nomeform, entidade, ativo, formpai, idlista, formainclude, dimensao, botconcluir, botcancelar, formoutcontrol, autosave) VALUES (63, 'condPagVendedor', 'Condições de Pagamento', '50', '1', '30', '64', 'one', NULL, '1', '1', '0', '0');
INSERT INTO forms (id, form, nomeform, entidade, ativo, formpai, idlista, formainclude, dimensao, botconcluir, botcancelar, formoutcontrol, autosave) VALUES (52, 'form_listContasTransacaoC', 'Contas', '44', '1', '48', '53', 'one', '800;550', '1', '1', '0', '0');
INSERT INTO forms (id, form, nomeform, entidade, ativo, formpai, idlista, formainclude, dimensao, botconcluir, botcancelar, formoutcontrol, autosave) VALUES (32, 'form_blocoFormacao', 'Formação', '14', '1', '30', '33', 'one', '', '1', '1', '0', '0');
INSERT INTO forms (id, form, nomeform, entidade, ativo, formpai, idlista, formainclude, dimensao, botconcluir, botcancelar, formoutcontrol, autosave) VALUES (30, 'cadFuncionario', 'Cadastro de Funcionario', '3', '1', '0', '31', 'one', '', '1', '1', '0', '0');
INSERT INTO forms (id, form, nomeform, entidade, ativo, formpai, idlista, formainclude, dimensao, botconcluir, botcancelar, formoutcontrol, autosave) VALUES (34, 'form_listTreinamento', '-', '34', '1', '30', '35', 'one', '', '1', '1', '0', '0');
INSERT INTO forms (id, form, nomeform, entidade, ativo, formpai, idlista, formainclude, dimensao, botconcluir, botcancelar, formoutcontrol, autosave) VALUES (22, 'form_blocoListaInteresses', 'Interesses', '17', '1', '18', '23', 'one', '', '1', '1', '0', '0');
INSERT INTO forms (id, form, nomeform, entidade, ativo, formpai, idlista, formainclude, dimensao, botconcluir, botcancelar, formoutcontrol, autosave) VALUES (18, 'cadclientes', 'Cadastro de Clientes', '3', '1', '0', '19', 'one', '', '1', '1', '0', '0');
INSERT INTO forms (id, form, nomeform, entidade, ativo, formpai, idlista, formainclude, dimensao, botconcluir, botcancelar, formoutcontrol, autosave) VALUES (16, 'formMovimentacoesProdutos', 'Movimentação de Produtos', '10', '1', '0', '17', 'one', '650;500', '1', '1', '0', '0');
INSERT INTO forms (id, form, nomeform, entidade, ativo, formpai, idlista, formainclude, dimensao, botconcluir, botcancelar, formoutcontrol, autosave) VALUES (70, 'viewProdutos', 'Visualização de Produtos', '9', '1', '0', '71', 'one', NULL, '0', '0', '0', '0');
INSERT INTO forms (id, form, nomeform, entidade, ativo, formpai, idlista, formainclude, dimensao, botconcluir, botcancelar, formoutcontrol, autosave) VALUES (72, 'gerMovimentoMercadoria', 'Gerenciamento de Movimento de Mercadoria', '10', '1', '0', '73', 'one', NULL, '1', '1', '0', '1');
INSERT INTO forms (id, form, nomeform, entidade, ativo, formpai, idlista, formainclude, dimensao, botconcluir, botcancelar, formoutcontrol, autosave) VALUES (84, 'formTeste', 'Teste', '53', '1', '0', '83', 'one', NULL, '1', '1', '0', '0');
INSERT INTO forms (id, form, nomeform, entidade, ativo, formpai, idlista, formainclude, dimensao, botconcluir, botcancelar, formoutcontrol, autosave) VALUES (87, 'formProdDGSimilares', 'Produtos', '55', '1', '0', '88', 'one', '500;200', '1', '1', '0', '0');
INSERT INTO forms (id, form, nomeform, entidade, ativo, formpai, idlista, formainclude, dimensao, botconcluir, botcancelar, formoutcontrol, autosave) VALUES (85, 'formProdutoDG', 'Produtos', '54', '1', '0', '86', 'one', NULL, '1', '1', '0', '0');
INSERT INTO forms (id, form, nomeform, entidade, ativo, formpai, idlista, formainclude, dimensao, botconcluir, botcancelar, formoutcontrol, autosave) VALUES (75, 'formBalancoProduto', 'Controle de Contagem', '52', '1', '0', '76', 'one', NULL, '1', '1', '0', '0');
INSERT INTO forms (id, form, nomeform, entidade, ativo, formpai, idlista, formainclude, dimensao, botconcluir, botcancelar, formoutcontrol, autosave) VALUES (77, 'formBalancoConferencia', 'Controle de Conferência', '52', '1', '0', '78', 'one', NULL, '1', '1', '0', '0');
INSERT INTO forms (id, form, nomeform, entidade, ativo, formpai, idlista, formainclude, dimensao, botconcluir, botcancelar, formoutcontrol, autosave) VALUES (2, 'formUnidade', 'Unidades', '2', '1', '0', NULL, 'one', NULL, '1', '1', '0', '0');
INSERT INTO forms (id, form, nomeform, entidade, ativo, formpai, idlista, formainclude, dimensao, botconcluir, botcancelar, formoutcontrol, autosave) VALUES (81, 'blocoTransacItens', 'Itens', '43', '1', '79', '82', 'one', '800;300', '1', '1', 'TTransacao/reservaProdutoDG', '0');
INSERT INTO forms (id, form, nomeform, entidade, ativo, formpai, idlista, formainclude, dimensao, botconcluir, botcancelar, formoutcontrol, autosave) VALUES (48, 'transacaoC', 'Pedidos', '42', '1', '0', '49', 'one', '', '0', '0', '0', '0');
INSERT INTO forms (id, form, nomeform, entidade, ativo, formpai, idlista, formainclude, dimensao, botconcluir, botcancelar, formoutcontrol, autosave) VALUES (79, 'formNFSaida', 'Nota de Saída', '42', '1', '0', '80', 'one', NULL, '1', '1', '0', '0');
INSERT INTO forms (id, form, nomeform, entidade, ativo, formpai, idlista, formainclude, dimensao, botconcluir, botcancelar, formoutcontrol, autosave) VALUES (94, 'formProdDGUnidade', 'Estoque por unidade', '56', '1', '85', '95', 'one', '600;300', '1', '1', '0', '0');
INSERT INTO forms (id, form, nomeform, entidade, ativo, formpai, idlista, formainclude, dimensao, botconcluir, botcancelar, formoutcontrol, autosave) VALUES (102, 'vendaItens', 'Itens', '43', '1', '96', '101', 'one', NULL, '1', '1', '0', '0');
INSERT INTO forms (id, form, nomeform, entidade, ativo, formpai, idlista, formainclude, dimensao, botconcluir, botcancelar, formoutcontrol, autosave) VALUES (96, 'formVenda', 'Vendas', '42', '1', '0', '93', 'one', NULL, '0', '0', '0', '0');


--
-- TOC entry 2033 (class 0 OID 22039)
-- Dependencies: 1580
-- Data for Name: info_empresa; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2034 (class 0 OID 22047)
-- Dependencies: 1582
-- Data for Name: lista_actions; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO lista_actions (id, idlista, tipocampo, "nameAction", label, actionjs, metodoexe, confirm, campoparam, img, ordem, ativo, tiporetorno) VALUES (1, 67, NULL, 'onFaturamento', 'Faturar', 'prossExe', 'onEdit', NULL, 'codigo', 'new_ico_config.png', 1, '1', 'form');
INSERT INTO lista_actions (id, idlista, tipocampo, "nameAction", label, actionjs, metodoexe, confirm, campoparam, img, ordem, ativo, tiporetorno) VALUES (2, 92, NULL, 'viewValorProduto', 'Visualizar Valores', 'showValorProduto', 'onSet', NULL, 'codigoprodutounidade', 'new_ico_view.png', 1, '1', NULL);
INSERT INTO lista_actions (id, idlista, tipocampo, "nameAction", label, actionjs, metodoexe, confirm, campoparam, img, ordem, ativo, tiporetorno) VALUES (4, 93, NULL, 'onEditVenda', 'Editar', 'prossExe', 'onEdit', NULL, 'codigo', 'new_ico_view.png', 1, '1', 'form');
INSERT INTO lista_actions (id, idlista, tipocampo, "nameAction", label, actionjs, metodoexe, confirm, campoparam, img, ordem, ativo, tiporetorno) VALUES (3, 93, NULL, 'onViewVenda', 'Imprimir Venda', 'imprimiOrcamentoList', 'onSet', NULL, 'codigo', 'new_ico_print.png', 2, '1', NULL);
INSERT INTO lista_actions (id, idlista, tipocampo, "nameAction", label, actionjs, metodoexe, confirm, campoparam, img, ordem, ativo, tiporetorno) VALUES (5, 80, NULL, 'onViewPedido', 'ImprimirPedido', 'imprimiOrcamentoList', 'onSet', NULL, 'codigo', 'new_ico_print.png', 3, '1', NULL);


--
-- TOC entry 2035 (class 0 OID 22063)
-- Dependencies: 1584
-- Data for Name: lista_bnav; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO lista_bnav (id, lista_form_id, nome, tipocampo, label, metodo, funcaojs, argumento) VALUES (1, 86, 'relEstoqueProduto', 'TAction', 'Relatório de Estoque', 'viewEstoqueProduto', 'viewEstoqueProduto', '1');


--
-- TOC entry 2036 (class 0 OID 22073)
-- Dependencies: 1586
-- Data for Name: lista_colunas; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (15, 14, 'produto', 'Produto', 'left', 'left', 300, '-', '0', 1, 0, '-', '0', 1, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (1, 2, 'nomepessoa', 'Responsável', 'left', 'left', 400, '-', '0', 1, 0, '-', '0', 1, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (2, 2, 'usuario', 'Usuário', 'center', 'center', 200, '-', '0', 1, 0, '-', '0', 2, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (4, 2, 'datacad', 'Data do Cad.', 'center', 'center', 100, '-', '0', 1, 0, '-', '0', 3, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (16, 14, 'descricao', 'Descrição', 'left', 'left', 400, '-', '0', 1, 0, '-', '0', 2, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (11, 12, 'nome', 'Sala', 'left', 'left', 200, '-', '0', 1, 0, '-', '0', 1, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (12, 12, 'endereco', 'Endereço', 'left', 'left', 400, '-', '0', 1, 0, '-', '0', 2, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (13, 13, 'label', 'Departamento', 'left', 'left', 400, '-', '0', 1, 0, '-', '0', 1, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (10, 6, 'patharquivo', 'Imagem', 'center', 'center', 400, 'TSetModel,viewThumb', '0', 1, 0, '-', '0', 0, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (17, 4, 'modelo', 'Modelo', 'left', 'left', 200, '-', '0', 1, 0, '-', '0', 3, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (5, 4, 'marca', 'Marca', 'left', 'left', 300, '-', '0', 1, 0, '-', '0', 4, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (6, 4, 'tipo', 'Tipo de Patrimônio', 'left', 'left', 200, '-', '0', 1, 0, '-', '0', 5, '0');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (7, 4, 'nomesala', 'Lotação', 'left', 'left', 200, '-', '0', 1, 0, '-', '0', 6, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (8, 4, 'nomeunidade', 'Filial', 'left', 'left', 200, '-', '0', 1, 0, '-', '0', 7, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (18, 4, 'label', 'Produto', 'left', 'left', 200, '-', '0', 1, 0, '-', '0', 2, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (9, 4, 'codigo', 'Cod.', 'center', 'center', 100, '-', '0', 1, 0, '-', '0', 1, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (19, 15, 'codigo', 'Cod.', 'center', 'center', 100, '-', '0', 1, 0, '-', '0', 1, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (20, 15, 'produto', 'Produto', 'left', 'left', 250, '-', '0', 1, 0, '-', '0', 2, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (21, 15, 'descricao', 'Descrição', 'left', 'left', 300, '-', '0', 1, 0, '-', '0', 3, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (22, 19, 'nome_razaoSocial', 'Nome', 'left', 'left', 300, '-', '0', 1, 0, '-', '0', 1, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (23, 19, 'tel1', 'Telefone', 'center', 'center', 120, 'TSetModel,setTelefone', '0', 1, 0, '-', '0', 3, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (24, 19, 'cel1', 'Celular', 'center', 'center', 120, 'TSetModel,setTelefone', '0', 1, 0, '-', '0', 4, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (25, 19, 'email1', 'E-mail', 'left', 'left', 250, '-', '0', 1, 0, '-', '0', 5, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (26, 19, 'cpf_cnpj', 'CPF / CNPJ', 'center', 'center', 150, 'TSetModel,setCpfcnpj', '0', 1, 0, '-', '0', 2, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (27, 21, 'codigo', 'Código', 'center', 'center', 100, '-', '0', 1, 0, '-', '0', 1, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (28, 21, 'tipoconvenio', 'Tipo do convênio', 'left', 'left', 110, 'TConvenios,setTipoConvenio', '0', 1, 0, '-', '0', 4, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (29, 21, 'titulo', 'Convênio', 'left', 'left', 300, '-', '0', 1, 0, '-', '0', 2, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (30, 21, 'tipotransacao', 'Tipo da transação', 'left', 'left', 110, 'TConvenios,setTipoTransacao', '0', 1, 0, '-', '0', 5, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (31, 21, 'formato', 'Formato', 'left', 'left', 100, 'TConvenios,setFormato', '0', 1, 0, '-', '0', 7, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (32, 21, 'datavirgencia', 'Data do convênio', 'center', 'center', 120, '-', '0', 1, 0, '-', '0', 8, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (33, 21, 'valor', 'Valor', 'center', 'center', 60, 'TSetModel,setValorMonetario', '0', 1, 0, '-', '0', 6, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (34, 23, 'turno', 'Turno', 'left', 'left', 200, '-', '0', 1, 0, '-', '0', 0, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (35, 23, 'nomecurso', 'Curso', 'left', 'left', 300, '-', '0', 1, 0, '-', '0', 0, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (36, 23, 'datacad', 'Data da Inclusão', 'left', 'left', 120, '-', '0', 1, 0, '-', '0', 0, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (37, 25, 'valorreal', 'Valor Nominal', 'center', 'center', 100, 'TSetModel,setValorMonetario', '0', 1, 0, '-', '0', 6, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (38, 25, 'nomepessoa', 'Cliente', 'left', 'left', 200, '-', '0', 1, 0, '-', '0', 1, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (39, 25, 'formapag', 'Forma Pag.', 'left', 'left', 70, '-', '0', 1, 0, '-', '0', 8, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (40, 25, 'nomeconta', 'Origem/Destino', 'center', 'center', 150, '-', '0', 1, 0, '-', '0', 9, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (41, 25, 'datacad', 'Data Pag.', 'center', 'center', 70, '-', '0', 1, 0, '-', '0', 5, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (42, 25, 'tipomovimentacao', 'Mov.', 'center', 'center', 40, '-', '0', 1, 0, '-', '0', 2, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (43, 25, 'valorpago', 'Valor Pago', 'right', 'right', 80, 'TSetModel,setValorMonetario', '0', 1, 0, '-', '0', 4, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (44, 25, 'nomeplanoconta', 'Plano de Contas', 'left', 'left', 150, '-', '0', 1, 0, '-', '0', 3, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (45, 25, 'vencimento', 'Data Venc.', 'left', 'left', 70, '-', '0', 1, 0, '-', '0', 7, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (55, 31, 'nomeDepartamento', 'Departamento', 'left', 'left', 100, '-', '0', 1, 0, '-', '0', 3, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (56, 31, 'dataAdmissao', 'Admissão', 'left', 'left', 100, '-', '0', 1, 0, '-', '0', 4, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (57, 31, 'cpf_cnpj', 'CPF', 'left', 'left', 120, 'TSetModel,setCpfcnpj', '0', 1, 0, '-', '0', 2, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (58, 33, 'curso', 'Curso', 'left', 'left', 300, '-', '0', 1, 0, '-', '0', 1, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (59, 33, 'instituicao', 'Instituição', 'left', 'left', 200, '-', '0', 1, 0, '-', '0', 3, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (60, 33, 'titularidade', 'Titularidade', 'left', 'left', 200, '-', '0', 1, 0, '-', '0', 2, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (61, 35, 'codigo', 'Curso', 'left', 'left', 300, '-', '0', 1, 0, '-', '0', 0, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (97, 53, 'numParcela', 'Parcela', 'left', 'left', 100, '-', '0', 1, 0, '-', '0', 0, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (98, 53, 'statusConta', 'Situação', 'left', 'left', 100, 'TSetModel,setStatusConta', '0', 1, 0, '-', '0', 0, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (99, 53, 'vencimento', 'Vencimento', 'center', 'center', 100, '-', '0', 1, 0, '-', '0', 0, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (100, 53, 'valorNominal', 'Valor', 'left', 'left', 100, 'TSetModel,setValorMonetario', '0', 1, 0, '-', '0', 0, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (96, 51, 'produto', 'Produto', 'left', 'left', 200, '-', '0', 1, 0, '-', '0', 1, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (101, 55, 'codigo', 'Cod.', 'center', 'center', 100, '-', '0', 1, 0, '-', '0', 1, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (111, 56, 'descricao', 'Descrição', 'left', 'left', 200, '-', '0', 1, 0, '-', '0', 2, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (110, 55, 'descricao', 'Descrição', 'left', 'left', 200, '-', '0', 1, 0, '-', '0', 2, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (106, 56, 'codigo', 'Cod.', 'center', 'center', 100, '-', '0', 1, 0, '-', '0', 1, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (107, 56, 'parcelas', 'Parcelas', 'center', 'center', 120, '-', '0', 1, 0, '-', '0', 3, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (108, 56, 'intervalo', 'Intervalo (dias)', 'center', 'center', 120, '-', '0', 1, 0, '-', '0', 4, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (109, 56, 'entrada', 'Entrada', 'center', 'center', 120, 'TStatus,getBoolean', '0', 1, 0, '-', '0', 5, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (102, 55, 'parcelas', 'Parcelas', 'center', 'center', 120, '-', '0', 1, 0, '-', '0', 3, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (103, 55, 'intervalo', 'Intervalo (dias)', 'center', 'center', 120, '-', '0', 1, 0, '-', '0', 4, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (104, 55, 'entrada', 'Entrada?', 'center', 'center', 120, 'TStatus,getBoolean', '0', 1, 0, '-', '0', 5, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (90, 49, 'valortotal', 'Valor Total', 'left', 'left', 120, 'TSetModel,setValorMonetario', '0', 1, 0, '-', '0', 5, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (117, 57, 'cpf_cnpj', 'CPF/CNPJ', 'center', 'center', 150, 'TSetModel,setCpfcnpj', '0', 1, 0, '-', '0', 2, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (116, 57, 'email1', 'E-mail', 'left', 'left', 250, '-', '0', 1, 0, '-', '0', 5, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (88, 49, 'cliente', 'Cliente', 'left', 'left', 300, '-', '0', 1, 0, '-', '0', 1, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (54, 31, 'nomefuncionario', 'Nome', 'left', 'left', 300, '-', '0', 1, 0, '-', '0', 1, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (89, 49, 'vendedor', 'Vendedor', 'left', 'left', 300, '-', '0', 1, 0, '-', '0', 2, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (112, 49, 'condicaopagamento', 'Condição de Pag.', 'left', 'left', 120, '-', '0', 1, 0, '-', '0', 3, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (94, 51, 'quantidade', 'Quantidade', 'center', 'center', 60, '-', '0', 1, 0, '-', '0', 2, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (95, 51, 'valorunitario', 'Valor Unitário', 'center', 'center', 100, 'TSetModel,setValorMonetario', '0', 1, 0, '-', '0', 3, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (105, 51, 'valortotal', 'Valor Total', 'center', 'center', 100, 'TSetModel,setValorMonetario', '0', 1, 0, '-', '0', 4, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (147, 71, 'valormedio', 'Custo', 'right', 'right', 100, 'TSetModel,setValorMonetario', '0', 1, 0, '-', '0', 6, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (143, 71, 'produto', 'Produto', 'left', 'left', 200, '-', '0', 1, 0, '-', '0', 2, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (151, 73, 'quantidade', 'Quantidade', 'center', 'left', 60, '-', '0', 1, 0, '-', '0', 2, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (152, 73, 'tipomovimentacao', 'Tipo de Movimentação', 'center', 'left', 200, '-', '0', 1, 0, '-', '0', 3, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (113, 57, 'nome_razaosocial', 'Nome', 'left', 'left', 300, '-', '0', 1, 0, '-', '0', 1, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (114, 57, 'tel1', 'Telefone', 'center', 'center', 120, 'TSetModel,setTelefone', '0', 1, 0, '-', '0', 3, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (115, 57, 'cel1', 'Celular', 'center', 'center', 120, 'TSetModel,setTelefone', '0', 1, 0, '-', '0', 4, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (118, 61, 'estado', 'Estado', 'left', 'left', 200, '-', '0', 1, 0, '-', '0', 0, '0');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (153, 74, 'codigo', 'Codigo', 'left', 'left', 100, '-', '0', 1, 0, '-', '0', 1, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (132, 67, 'cliente', 'Cliente', 'left', 'left', 300, '-', '0', 1, 0, '-', '0', 1, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (119, 61, 'margem', 'Margem de Lucro (%)', 'center', 'center', 160, 'TSetModel,setMoney', '0', 1, 0, '-', '0', 1, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (120, 61, 'taxaadministrativa', 'Taxas Administrativas', 'center', 'center', 160, 'TSetModel,setMoney', '0', 1, 0, '-', '0', 2, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (133, 67, 'vendedor', 'Vendedor', 'left', 'left', 300, '-', '0', 1, 0, '-', '0', 2, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (156, 74, 'estoquemaximo', 'Estoque Maximo', 'left', 'left', 100, '-', '0', 1, 0, '-', '0', 4, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (155, 74, 'estoqueminimo', 'Estoque Minimo', 'left', 'left', 100, '-', '0', 1, 0, '-', '0', 3, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (154, 74, 'produto', 'Produto', 'left', 'left', 200, '-', '0', 1, 0, '-', '0', 2, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (134, 67, 'valortotal', 'Valor Total', 'left', 'left', 120, 'TSetModel,setValorMonetario', '0', 1, 0, '-', '0', 3, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (135, 67, 'valordesconto', 'Valor do Desconto', 'left', 'left', 120, 'TSetModel,setValorMonetario', '0', 1, 0, '-', '0', 4, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (137, 67, 'datacad', 'Data', 'center', 'center', 100, '-', '0', 1, 0, '-', '0', 6, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (136, 67, 'condicaopagamento', 'Cond. Pagamento', 'left', 'left', 120, '-', '0', 1, 0, '-', '0', 5, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (138, 68, 'quantidade', 'Quantidade', 'center', 'center', 60, '-', '0', 1, 0, '-', '0', 2, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (91, 49, 'valordesconto', 'Valor do Desconto', 'left', 'left', 120, 'TSetModel,setValorMonetario', '0', 1, 0, '-', '0', 4, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (126, 64, 'codigo', 'Cod.', 'center', 'center', 100, '-', '0', 1, 0, '-', '0', 1, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (127, 64, 'nomefuncionario', 'Funcionário', 'left', 'left', 300, '-', '0', 1, 0, '-', '0', 2, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (128, 64, 'descricao', 'Condição de Pagamento', 'left', 'left', 200, '-', '0', 1, 0, '-', '0', 3, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (129, 14, 'valorminimo', 'Menor Valor de Entrada', 'center', 'center', 100, 'TSetModel,setValorMonetario', '0', 1, 0, '-', '0', 3, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (131, 14, 'valormedio', 'Valor Atual', 'center', 'center', 100, 'TSetModel,setValorMonetario', '0', 1, 0, '-', '0', 5, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (130, 14, 'valormaximo', 'Maior Valor de Entrada', 'center', 'center', 100, 'TSetModel,setValorMonetario', '0', 1, 0, '-', '0', 4, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (140, 68, 'produto', 'Produto', 'left', 'left', 200, '-', '0', 1, 0, '-', '0', 1, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (139, 68, 'valorunitario', 'Valor Unitário', 'center', 'center', 100, 'TSetModel,setValorMonetario', '0', 1, 0, '-', '0', 3, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (141, 68, 'valortotal', 'Valor Total', 'center', 'center', 100, 'TSetModel,setValorMonetario', '0', 1, 0, '-', '0', 4, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (142, 71, 'codigo', 'Codigo', 'center', 'center', 100, '-', '0', 1, 0, '-', '0', 1, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (144, 71, 'descricao', 'Descrição', 'left', 'left', 300, '-', '0', 1, 0, '-', '0', 3, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (148, 71, 'quantidadedisponivel', 'Qtde. Disponível', 'center', 'center', 100, '-', '0', 1, 0, '-', '0', 7, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (149, 71, 'quantidadereservada', 'Qtde. Reservada', 'center', 'center', 100, '-', '0', 1, 0, '-', '0', 8, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (145, 71, 'estoqueminimo', 'Estoque Mínimo', 'center', 'center', 100, '-', '0', 1, 0, '-', '0', 4, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (146, 71, 'estoquemaximo', 'Estoque Máximo', 'center', 'center', 100, '-', '0', 1, 0, '-', '0', 5, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (150, 73, 'produto', 'Produto', 'center', 'left', 350, '-', '0', 1, 0, '-', '0', 1, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (169, 78, 'cod_mer', 'Código SIT', 'center', 'center', 100, '-', '0', 1, 0, '-', '0', 1, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (157, 76, 'cod_mer', 'Código SIT', 'center', 'center', 100, '-', '0', 1, 0, '-', '0', 1, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (173, 78, 'blepstcf', 'Conferido', 'center', 'center', 100, 'TSetModel,setBool', '0', 1, 0, '-', '0', 5, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (158, 76, 'nome_mer', 'Produto', 'left', 'left', 300, '-', '0', 1, 0, '-', '0', 2, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (162, 76, 'nova_qtd', 'Nova Qtde.', 'left', 'left', 100, '-', '0', 1, 0, '-', '0', 4, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (251, 86, 'datacad', 'Data', 'center', 'center', 100, '-', '0', 1, 0, '-', '0', 20, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (181, 82, 'valorunitario', 'Valor Unitário', 'center', 'center', 100, '-', '0', 1, 0, '-', '0', 6, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (187, 86, 'descricao', 'Produto', 'left', 'left', 250, '-', '0', 1, 0, '-', '0', 3, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (183, 83, 'codigo', 'Código', 'center', 'center', 50, '-', '0', 1, 0, '-', '0', 1, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (184, 83, 'descricao', 'Descrição', 'center', 'left', 300, '-', '0', 1, 0, '-', '0', 2, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (175, 80, 'codigo', 'Nº da Nota', 'center', 'center', 100, '-', '0', 1, 0, '-', '0', 1, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (176, 80, 'cliente', 'Cliente', 'left', 'left', 300, '-', '0', 1, 0, '-', '0', 2, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (177, 80, 'vendedor', 'Vendedor', 'left', 'left', 250, '-', '0', 1, 0, '-', '0', 3, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (178, 80, 'valortotal', 'Valor Total', 'center', 'center', 100, 'TSetModel,setValorMonetario', '0', 1, 0, '-', '0', 4, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (170, 78, 'nome_mer', 'Produto', 'left', 'left', 300, '-', '0', 1, 0, '-', '0', 2, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (172, 78, 'nova_qtd', 'Nova Qtde.', 'left', 'left', 100, '-', '0', 1, 0, '-', '0', 4, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (171, 78, 'estoque_fisico', 'Estoque', 'left', 'left', 100, '-', '0', 1, 0, '-', '0', 3, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (161, 76, 'estoque_fisico', 'Estoque', 'left', 'left', 100, '-', '0', 1, 0, '-', '0', 3, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (186, 86, 'referencia', 'Referência', 'left', 'left', 100, '-', '0', 1, 0, '-', '0', 6, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (182, 82, 'valortotal', 'Valor Total', 'center', 'center', 100, '-', '0', 1, 0, '-', '0', 7, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (180, 82, 'quantidade', 'Quantidade', 'center', 'center', 80, '-', '0', 1, 0, '-', '0', 5, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (192, 86, 'sinonimos', 'Sinônimos', 'left', 'left', 350, '-', '0', 1, 0, '-', '0', 8, '0');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (188, 86, 'unidademedida', 'Un.', 'center', 'center', 25, '-', '0', 1, 0, '-', '0', 5, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (189, 86, 'marca', 'Marca', 'left', 'left', 100, '-', '0', 1, 0, '-', '0', 4, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (121, 62, 'codigo', 'Cod.', 'center', 'center', 120, '-', '0', 1, 0, '-', '0', 2, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (194, 86, 'estado', 'UF', 'center', 'center', 50, '-', '0', 1, 0, '-', '0', 10, '0');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (197, 88, 'produtosimilar', 'Produto Similar', 'left', 'left', 350, '-', '0', 1, 0, '-', '0', 2, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (196, 88, 'codigoprodutosimilar', 'Código', 'center', 'center', 100, '-', '0', 1, 0, '-', '0', 1, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (122, 62, 'produto', 'Produto', 'left', 'left', 200, '-', '0', 1, 0, '-', '0', 3, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (123, 62, 'descricao', 'Descrição', 'left', 'left', 300, '-', '0', 1, 0, '-', '0', 4, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (124, 62, 'quantidadedisponivel', 'Qtde.', 'center', 'center', 45, '-', '0', 1, 0, '-', '0', 5, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (125, 62, 'valormedio', 'Valor', 'center', 'center', 100, 'TSetModel,setValorMonetario', '0', 1, 0, '-', '0', 6, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (179, 82, 'produto', 'Produto', 'left', 'left', 300, '-', '0', 1, 0, '-', '0', 3, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (221, 92, 'preco', 'Preço Inicial', 'right', 'right', 80, 'TSetModel,setValorMonetario', '0', 1, 0, '-', '0', 6, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (203, 89, 'preco', 'Preço', 'right', 'right', 70, 'TSetModel,setValorMonetario', '0', 1, 0, '-', '0', 6, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (198, 89, 'codigoproduto', 'Codigo', 'center', 'center', 100, '-', '0', 1, 0, '-', '0', 1, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (185, 86, 'codigoproduto', 'Codigo', 'center', 'center', 100, '-', '0', 1, 0, '-', '0', 1, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (191, 86, 'preco', 'Preço', 'right', 'right', 70, '-', '0', 1, 0, '-', '0', 9, '0');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (193, 86, 'empresa', 'Empresa', 'left', 'left', 120, '-', '0', 1, 0, '-', '0', 7, '0');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (225, 82, 'codigoproduto', 'Cod.', 'left', 'left', 100, '-', '0', 1, 0, '-', '0', 2, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (226, 82, 'marca', 'Marca', 'left', 'left', 80, '-', '0', 1, 0, '-', '0', 4, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (250, 82, 'codigosit', 'Cod. Alternativo', 'center', 'center', 100, '-', '0', 1, 0, '-', '0', 1, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (252, 89, 'datacad', 'Data', 'center', 'center', 100, '-', '0', 1, 0, '-', '0', 20, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (204, 89, 'sinonimos', 'Sinônimos', 'left', 'left', 200, '-', '0', 1, 0, '-', '0', 8, '0');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (253, 92, 'datacad', 'Data', 'center', 'center', 100, '-', '0', 1, 0, '-', '0', 20, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (211, 91, 'nomeunidade', 'Empresa', 'left', 'left', 200, '-', '0', 1, 0, '-', '0', 1, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (254, 80, 'datacad', 'Data', 'center', 'center', 100, '-', '0', 1, 0, '-', '0', 20, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (210, 90, 'rg_inscest', 'RG/IE', 'center', 'center', 100, '-', '0', 1, 0, '-', '0', 3, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (209, 90, 'cpf_cnpj', 'CPF/CNPJ', 'center', 'center', 110, 'TSetModel,setCpfcnpj', '0', 1, 0, '-', '0', 2, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (208, 90, 'nome_razaosocial', 'Nome/Razão Social', 'left', 'left', 330, '-', '0', 1, 0, '-', '0', 1, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (220, 92, 'custo', 'Custo', 'right', 'right', 80, 'TSetModel,setValorMonetario', '0', 1, 0, '-', '0', 5, '0');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (202, 89, 'custo', 'Custo', 'right', 'right', 70, 'TSetModel,setValorMonetario', '0', 1, 0, '-', '0', 5, '0');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (231, 80, 'tipotransacao', 'Tipo', 'right', 'right', 100, '-', '0', 1, 0, '-', '0', 5, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (249, 92, 'quantidadereservada', 'Qtde. Reservada', 'center', 'center', 100, '-', '0', 1, 0, '-', '0', 8, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (223, 92, 'endereco', 'Endereço', 'left', 'left', 150, '-', '0', 1, 0, '-', '0', 9, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (212, 91, 'razaosocial', 'Razão Social', 'left', 'left', 300, '-', '0', 1, 0, '-', '0', 2, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (214, 91, 'inscestadual', 'IE', 'center', 'center', 120, '-', '0', 1, 0, '-', '0', 4, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (222, 92, 'quantidadedisponivel', 'Qtde. Disponivel', 'center', 'center', 100, '-', '0', 1, 0, '-', '0', 7, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (213, 91, 'cnpj', 'CNPJ', 'center', 'center', 120, 'TSetModel,setCpfcnpj', '0', 1, 0, '-', '0', 3, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (215, 91, 'estado', 'UF', 'left', 'left', 70, '-', '0', 1, 0, '-', '0', 5, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (229, 90, 'estado', 'UF', 'left', 'left', 70, '-', '0', 1, 0, '-', '0', 5, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (230, 90, 'logradouro', 'Logradouro', 'left', 'left', 200, '-', '0', 1, 0, '-', '0', 6, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (228, 90, 'cidade', 'Cidade', 'left', 'left', 150, '-', '0', 1, 0, '-', '0', 4, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (233, 86, 'codigosit', 'Cod. Alternativo', 'center', 'center', 100, '-', '0', 1, 0, '-', '0', 2, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (232, 89, 'codigosit', 'Cod. Alternativo', 'center', 'center', 100, '-', '0', 1, 0, '-', '0', 2, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (239, 93, 'codigo', 'codigo', 'center', 'center', 100, '-', '0', 1, 0, '-', '0', 1, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (240, 93, 'cliente', 'cliente', 'left', 'left', 300, '-', '0', 1, 0, '-', '0', 2, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (241, 93, 'vendedor', 'vendedor', 'left', 'left', 250, '-', '0', 1, 0, '-', '0', 3, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (242, 93, 'valortotal', 'valortotal', 'center', 'center', 100, 'TSetModel,setValorMonetario', '0', 1, 0, '-', '0', 4, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (199, 89, 'descricao', 'Produto', 'left', 'left', 250, '-', '0', 1, 0, '-', '0', 3, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (201, 89, 'marca', 'Marca', 'center', 'center', 100, '-', '0', 1, 0, '-', '0', 4, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (200, 89, 'unidademedida', 'Unid', 'center', 'center', 50, '-', '0', 1, 0, '-', '0', 5, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (243, 93, 'tipotransacao', 'Tipo', 'right', 'right', 100, '-', '0', 1, 0, '-', '0', 6, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (246, 93, 'condicaopagamento', 'Forma de Pagamento', 'center', 'center', 150, '-', '0', 1, 0, '-', '0', 5, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (234, 92, 'codigosit', 'Cod. Alternativo', 'center', 'center', 100, '-', '0', 1, 0, '-', '0', 2, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (217, 92, 'descricao', 'Produto', 'left', 'left', 300, '-', '0', 1, 0, '-', '0', 3, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (218, 92, 'unidademedida', 'Unid', 'center', 'center', 50, '-', '0', 1, 0, '-', '0', 4, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (219, 92, 'marca', 'Marca', 'center', 'center', 100, '-', '0', 1, 0, '-', '0', 5, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (255, 93, 'datacad', 'Data', 'center', 'center', 100, '-', '0', 1, 0, '-', '0', 20, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (268, 101, 'quantidade', 'Qtde.', 'center', 'center', 80, '-', '0', 1, 0, '-', '0', 2, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (271, 101, 'valorunitario', 'Valor Unit.', 'center', 'center', 100, '-', '0', 1, 0, '-', '0', 3, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (272, 101, 'valortotal', 'Valor Total', 'center', 'center', 100, '-', '0', 1, 0, '-', '0', 4, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (273, 101, 'codigoproduto', 'Cod.', 'left', 'left', 100, '-', '0', 1, 0, '-', '0', 5, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (266, 92, 'codigoprodutounidade', NULL, 'right', 'right', 20, '-', '0', 1, 0, '-', '0', 25, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (224, 86, 'quantidadedisponivel', 'Qtde. Disponivel', 'center', 'center', 120, '-', '0', 1, 0, '-', '0', 10, '0');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (263, 86, 'quantidadereservada', 'Qtde. Reservada', 'center', 'center', 120, '-', '0', 1, 0, '-', '0', 11, '0');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (190, 86, 'custo', 'Custo', 'right', 'right', 70, '-', '0', 1, 0, '-', '0', 8, '0');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (195, 86, 'endereco', 'Endereço', 'left', 'left', 70, '-', '0', 1, 0, '-', '0', 12, '0');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (227, 89, 'quantidadedisponivel', 'Qtde Disponivel', 'center', 'center', 100, '-', '0', 1, 0, '-', '0', 7, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (264, 89, 'quantidadereservada', 'Qtde. Reservada', 'center', 'center', 100, '-', '0', 1, 0, '-', '0', 8, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (265, 89, 'empresa', 'Empresa', 'center', 'center', 100, '-', '0', 1, 0, '-', '0', 10, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (256, 95, 'empresa', 'Empresa', 'left', 'left', 300, '-', '0', 1, 0, '-', '0', 1, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (205, 89, 'endereco', 'Endereço', 'left', 'left', 100, '-', '0', 1, 0, '-', '0', 9, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (258, 95, 'custo', 'Custo', 'right', 'right', 100, '-', '0', 1, 0, '-', '0', 3, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (259, 95, 'preco', 'Preço', 'right', 'right', 100, '-', '0', 1, 0, '-', '0', 4, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (260, 95, 'endereco', 'Endereço', 'left', 'left', 100, '-', '0', 1, 0, '-', '0', 5, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (257, 95, 'quantidadeinicial', 'Qtde. Inicial', 'right', 'right', 100, '-', '0', 1, 0, '-', '0', 2, '0');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (216, 92, 'codigoproduto', 'Codigo', 'center', 'center', 100, '-', '0', 1, 0, '-', '0', 1, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (274, 101, 'marca', 'marca', 'left', 'left', 80, '-', '0', 1, 0, '-', '0', 6, '1');
INSERT INTO lista_colunas (id, lista_form_id, coluna, label, alinhalabel, alinhadados, largura, colfunction, valorpadrao, tipocoluna, entidade_pai, colunaaux, link, ordem, ativo) VALUES (267, 101, 'produto', 'Produto', 'left', 'left', 300, '-', '0', 1, 0, '-', '0', 1, '1');


--
-- TOC entry 2037 (class 0 OID 22090)
-- Dependencies: 1588
-- Data for Name: lista_fields; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2038 (class 0 OID 22100)
-- Dependencies: 1590
-- Data for Name: lista_form; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO lista_form (id, tipo, forms_id, filtropai, pesquisa, lista, label, entidade, listapai, obapendice, acfiltro, acincluir, accolunas, acdeletar, aceditar, acviews, acenviar, filtro, ativo, formainclude, trigger, incontrol, acreplicar, acselecao, ordem) VALUES (73, 'form', 72, 'codigo', '0', 'movMercadoria', 'Movimentação de Mercadorias', 10, 0, '-', '1', '1', '0 ', '1', '0', '0', '0', 'ativo/!=/AND/9', '1', 'one', NULL, NULL, '0', '0', 'datacad/desc;id/desc');
INSERT INTO lista_form (id, tipo, forms_id, filtropai, pesquisa, lista, label, entidade, listapai, obapendice, acfiltro, acincluir, accolunas, acdeletar, aceditar, acviews, acenviar, filtro, ativo, formainclude, trigger, incontrol, acreplicar, acselecao, ordem) VALUES (55, 'form', 54, 'codigo', '0', 'listaFormasPagamento', 'Condições de Pagamento', 48, 55, '-', '1', '1', '0 ', '1', '1', '0', '0', 'ativo/!=/AND/9', '1', 'one', NULL, NULL, '0', '0', 'datacad/desc;id/desc');
INSERT INTO lista_form (id, tipo, forms_id, filtropai, pesquisa, lista, label, entidade, listapai, obapendice, acfiltro, acincluir, accolunas, acdeletar, aceditar, acviews, acenviar, filtro, ativo, formainclude, trigger, incontrol, acreplicar, acselecao, ordem) VALUES (57, 'pesq', 18, 'codigo', 'codigocliente=codigo', 'listaClientesPesq', 'Clientes', 3, 57, '-', '1', '0', '0 ', '0', '0', '0', '1', 'cliente/=/AND/1', '1', 'one', NULL, NULL, '0', '0', 'datacad/desc;id/desc');
INSERT INTO lista_form (id, tipo, forms_id, filtropai, pesquisa, lista, label, entidade, listapai, obapendice, acfiltro, acincluir, accolunas, acdeletar, aceditar, acviews, acenviar, filtro, ativo, formainclude, trigger, incontrol, acreplicar, acselecao, ordem) VALUES (61, 'form', 58, 'codigoproduto', '0', 'listaMarkup', 'Formulações', 49, 61, '-', '1', 'Nova Formulação', '0 ', '1', '1', '0', '0', 'ativo/!=/AND/9', '1', 'one', NULL, NULL, '0', '0', 'datacad/desc;id/desc');
INSERT INTO lista_form (id, tipo, forms_id, filtropai, pesquisa, lista, label, entidade, listapai, obapendice, acfiltro, acincluir, accolunas, acdeletar, aceditar, acviews, acenviar, filtro, ativo, formainclude, trigger, incontrol, acreplicar, acselecao, ordem) VALUES (62, 'pesq', 9, 'codigo', 'codigoproduto=codigo,valorunitario=valormedio', 'pesqProdutoTransacao', 'Produtos', 9, 62, '-', '1', '0', '0 ', '0', '0', '0', '1', 'ativo/!=/AND/9', '1', 'one', NULL, NULL, '0', '0', 'datacad/desc;id/desc');
INSERT INTO lista_form (id, tipo, forms_id, filtropai, pesquisa, lista, label, entidade, listapai, obapendice, acfiltro, acincluir, accolunas, acdeletar, aceditar, acviews, acenviar, filtro, ativo, formainclude, trigger, incontrol, acreplicar, acselecao, ordem) VALUES (64, 'form', 63, 'codigopessoa', '0', 'vendCondPagamento', 'Vendedor x Condição de Pagamento', 50, 64, '-', '1', 'Novo Relacionamento', '0 ', '1', '0', '0', '0', 'ativo/!=/AND/9', '1', 'one', NULL, NULL, '0', '0', 'datacad/desc;id/desc');
INSERT INTO lista_form (id, tipo, forms_id, filtropai, pesquisa, lista, label, entidade, listapai, obapendice, acfiltro, acincluir, accolunas, acdeletar, aceditar, acviews, acenviar, filtro, ativo, formainclude, trigger, incontrol, acreplicar, acselecao, ordem) VALUES (71, 'form', 70, 'codigo', '0', 'viewProdutos', 'Produtos', 9, 71, '-', '1', '0', '0 ', '0', '0', '0', '0', 'ativo/!=/AND/9', '1', 'one', NULL, NULL, '0', '0', 'produto/asc');
INSERT INTO lista_form (id, tipo, forms_id, filtropai, pesquisa, lista, label, entidade, listapai, obapendice, acfiltro, acincluir, accolunas, acdeletar, aceditar, acviews, acenviar, filtro, ativo, formainclude, trigger, incontrol, acreplicar, acselecao, ordem) VALUES (78, 'form', 77, 'codigo', '0', 'listaConferencia', 'Produtos', 52, 78, '-', '1', '0', '0 ', '0', '1', '0', '0', 'ativo/!=/AND/9', '1', 'one', NULL, NULL, '0', '0', 'datacad/desc;id/desc');
INSERT INTO lista_form (id, tipo, forms_id, filtropai, pesquisa, lista, label, entidade, listapai, obapendice, acfiltro, acincluir, accolunas, acdeletar, aceditar, acviews, acenviar, filtro, ativo, formainclude, trigger, incontrol, acreplicar, acselecao, ordem) VALUES (76, 'form', 75, 'codigo', '0', 'listaProdutos', 'Produtos', 52, 76, '-', '1', '0', '0 ', '0', '1', '0', '0', 'ativo/!=/AND/9', '1', 'one', NULL, NULL, '0', '0', 'datacad/desc;id/desc');
INSERT INTO lista_form (id, tipo, forms_id, filtropai, pesquisa, lista, label, entidade, listapai, obapendice, acfiltro, acincluir, accolunas, acdeletar, aceditar, acviews, acenviar, filtro, ativo, formainclude, trigger, incontrol, acreplicar, acselecao, ordem) VALUES (88, 'form', 87, 'codigoproduto', '0', 'listaProdDGSimilar', 'Produtos Similares', 55, 86, '-', '1', 'Novo Registro', '0 ', '1', '1', '0', '0', 'ativo/!=/AND/9', '1', 'one', NULL, NULL, '0', '0', 'datacad/desc;id/desc');
INSERT INTO lista_form (id, tipo, forms_id, filtropai, pesquisa, lista, label, entidade, listapai, obapendice, acfiltro, acincluir, accolunas, acdeletar, aceditar, acviews, acenviar, filtro, ativo, formainclude, trigger, incontrol, acreplicar, acselecao, ordem) VALUES (74, 'pesq', 9, 'codigo', 'codigoproduto=codigo', 'pesqProdutosMovimentacao', 'Produtos', 9, 0, '-', '1', '0', '0 ', '0', '0', '0', '1', 'ativo/!=/AND/9', '1', 'one', NULL, NULL, '0', '0', 'datacad/desc;id/desc');
INSERT INTO lista_form (id, tipo, forms_id, filtropai, pesquisa, lista, label, entidade, listapai, obapendice, acfiltro, acincluir, accolunas, acdeletar, aceditar, acviews, acenviar, filtro, ativo, formainclude, trigger, incontrol, acreplicar, acselecao, ordem) VALUES (56, 'pesq', 54, 'codigo', 'codigocondicaopagamento=codigoformapagamento,valorjuros=indice', 'listaFormaPagPesq', 'Condições de Pagamento', 50, 56, '-', '1', '0', '0 ', '0', '0', '0', '1', 'codigopessoa/=/AND/TUsuario/getCodigoPessoa', '1', 'one', NULL, NULL, '0', '0', 'datacad/desc;id/desc');
INSERT INTO lista_form (id, tipo, forms_id, filtropai, pesquisa, lista, label, entidade, listapai, obapendice, acfiltro, acincluir, accolunas, acdeletar, aceditar, acviews, acenviar, filtro, ativo, formainclude, trigger, incontrol, acreplicar, acselecao, ordem) VALUES (83, 'form', 84, 'codigo', '0', 'listateste', 'Teste', 53, 53, '-', '1', 'Novo Registro', '0 ', '1', '1', '0', '0', 'ativo/!=/AND/9', '1', 'one', NULL, NULL, '0', '0', 'datacad/desc;id/desc');
INSERT INTO lista_form (id, tipo, forms_id, filtropai, pesquisa, lista, label, entidade, listapai, obapendice, acfiltro, acincluir, accolunas, acdeletar, aceditar, acviews, acenviar, filtro, ativo, formainclude, trigger, incontrol, acreplicar, acselecao, ordem) VALUES (35, 'form', 34, 'codigofuncionario', '0', 'listaTreinFunc', 'Treinamentos', 34, 31, '-', '0', '0', '0 ', '0', '0', '0', '0', '', '1', 'one', NULL, NULL, '0', '0', 'datacad/desc;id/desc');
INSERT INTO lista_form (id, tipo, forms_id, filtropai, pesquisa, lista, label, entidade, listapai, obapendice, acfiltro, acincluir, accolunas, acdeletar, aceditar, acviews, acenviar, filtro, ativo, formainclude, trigger, incontrol, acreplicar, acselecao, ordem) VALUES (92, 'form', 85, 'codigo', '0', 'viewProdutos', 'Produtos', 54, 92, 'TProduto/viewValorProdutoDG', '1', '0', '0 ', '0', '0', '0', '0', 'ativo/!=/AND/9', '1', 'one', NULL, NULL, '0', '0', 'datacad/desc;id/desc');
INSERT INTO lista_form (id, tipo, forms_id, filtropai, pesquisa, lista, label, entidade, listapai, obapendice, acfiltro, acincluir, accolunas, acdeletar, aceditar, acviews, acenviar, filtro, ativo, formainclude, trigger, incontrol, acreplicar, acselecao, ordem) VALUES (90, 'pesq', 18, 'codigo', 'codigocliente=codigo>nome_razaosocial,ie_rgcliente=rg_inscest,ufcliente=estado,cpf_cnpjcliente=cpf_cnpj', 'pesqCliente', 'Clientes', 3, 90, '-', '1', '0', '0 ', '0', '0', '0', '1', 'ativo/!=/AND/9;cliente/=/AND/1', '1', 'one', NULL, NULL, '0', '0', 'datacad/desc;id/desc');
INSERT INTO lista_form (id, tipo, forms_id, filtropai, pesquisa, lista, label, entidade, listapai, obapendice, acfiltro, acincluir, accolunas, acdeletar, aceditar, acviews, acenviar, filtro, ativo, formainclude, trigger, incontrol, acreplicar, acselecao, ordem) VALUES (91, 'pesq', 2, 'codigo', 'codigounidade=codigo,nomeunidade=nomeunidade,cnpjunidade=cnpj,ufunidade=estado,ieunidade=inscestadual', 'pesqUnidade', 'Empresas', 2, 91, '-', '1', '0', '0 ', '0', '0', '0', '1', 'ativo/!=/AND/9', '1', 'one', NULL, NULL, '0', '0', 'datacad/desc;id/desc');
INSERT INTO lista_form (id, tipo, forms_id, filtropai, pesquisa, lista, label, entidade, listapai, obapendice, acfiltro, acincluir, accolunas, acdeletar, aceditar, acviews, acenviar, filtro, ativo, formainclude, trigger, incontrol, acreplicar, acselecao, ordem) VALUES (68, 'form', 69, 'codigotransacao', '0', 'lsitaProdutos', 'Itens do Pedido', 43, 67, '-', '0', '0', '0 ', '0', '0', '0', '0', 'ativo/!=/AND/9', '1', 'one', NULL, NULL, '0', '0', 'datacad/desc;id/desc');
INSERT INTO lista_form (id, tipo, forms_id, filtropai, pesquisa, lista, label, entidade, listapai, obapendice, acfiltro, acincluir, accolunas, acdeletar, aceditar, acviews, acenviar, filtro, ativo, formainclude, trigger, incontrol, acreplicar, acselecao, ordem) VALUES (49, 'form', 48, 'codigo', '0', 'Pedidos', 'Pedidos', 42, 49, '-', '1', 'Novo', '0 ', '0', '0', '1', '0', 'codigotipotransacao/=/AND/10000541-641', '1', 'one', NULL, NULL, '0', '0', 'datacad/desc;id/desc');
INSERT INTO lista_form (id, tipo, forms_id, filtropai, pesquisa, lista, label, entidade, listapai, obapendice, acfiltro, acincluir, accolunas, acdeletar, aceditar, acviews, acenviar, filtro, ativo, formainclude, trigger, incontrol, acreplicar, acselecao, ordem) VALUES (51, 'form', 50, 'codigotransacao', '0', 'addProdutosC', 'Itens', 43, 49, '-', '0', 'Novo Item', '0 ', '1', '0', '1', '0', '', '1', 'one', NULL, NULL, '0', '0', 'datacad/desc;id/desc');
INSERT INTO lista_form (id, tipo, forms_id, filtropai, pesquisa, lista, label, entidade, listapai, obapendice, acfiltro, acincluir, accolunas, acdeletar, aceditar, acviews, acenviar, filtro, ativo, formainclude, trigger, incontrol, acreplicar, acselecao, ordem) VALUES (67, 'form', 65, 'codigo', '0', 'faturamento', 'Faturamento', 42, 67, '-', '1', '0', '0 ', '0', '0', '1', '0', 'ativo/!=/AND/9', '1', 'one', NULL, NULL, '0', '0', 'datacad/desc;id/desc');
INSERT INTO lista_form (id, tipo, forms_id, filtropai, pesquisa, lista, label, entidade, listapai, obapendice, acfiltro, acincluir, accolunas, acdeletar, aceditar, acviews, acenviar, filtro, ativo, formainclude, trigger, incontrol, acreplicar, acselecao, ordem) VALUES (33, 'form', 32, 'codigopessoa', '0', 'blocoFormFunc', 'Formação', 14, 31, '-', '0', 'Novo Registro', '0 ', '1', '1', '0', '0', '', '1', 'one', NULL, NULL, '0', '0', 'datacad/desc;id/desc');
INSERT INTO lista_form (id, tipo, forms_id, filtropai, pesquisa, lista, label, entidade, listapai, obapendice, acfiltro, acincluir, accolunas, acdeletar, aceditar, acviews, acenviar, filtro, ativo, formainclude, trigger, incontrol, acreplicar, acselecao, ordem) VALUES (31, 'form', 30, 'codigo', '0', 'listaFuncionarios', 'Funcionários', 11, 31, '-', '1', 'Novo Registro', '0 ', '1', '1', '1', '0', NULL, '1', 'one', NULL, NULL, '0', '0', 'datacad/desc;id/desc');
INSERT INTO lista_form (id, tipo, forms_id, filtropai, pesquisa, lista, label, entidade, listapai, obapendice, acfiltro, acincluir, accolunas, acdeletar, aceditar, acviews, acenviar, filtro, ativo, formainclude, trigger, incontrol, acreplicar, acselecao, ordem) VALUES (2, 'form', 1, 'codigo', '0', 'listaUsuarios', 'Usuários', 1, 2, '-', '1', '1', '0 ', '1', '1', '0', '0', NULL, '1', 'one', NULL, NULL, '0', '0', 'datacad/desc;id/desc');
INSERT INTO lista_form (id, tipo, forms_id, filtropai, pesquisa, lista, label, entidade, listapai, obapendice, acfiltro, acincluir, accolunas, acdeletar, aceditar, acviews, acenviar, filtro, ativo, formainclude, trigger, incontrol, acreplicar, acselecao, ordem) VALUES (53, 'form', 52, 'codigotransacao', '0', 'listaTransacaoContasView', 'Contas a receber', 44, 49, '-', '0', '0', '0 ', '0', '1', '1', '0', 'tipomovimentacao/=/AND/C', '1', 'one', NULL, NULL, '0', '0', 'datacad/desc;id/desc');
INSERT INTO lista_form (id, tipo, forms_id, filtropai, pesquisa, lista, label, entidade, listapai, obapendice, acfiltro, acincluir, accolunas, acdeletar, aceditar, acviews, acenviar, filtro, ativo, formainclude, trigger, incontrol, acreplicar, acselecao, ordem) VALUES (21, 'form', 20, 'codigopessoa', '0', 'listaConvenios', 'Convênios', 16, 19, '-', '0', 'Relacionar novo convênio', '0 ', '1', '0', '0', '0', '', '1', 'one', NULL, NULL, '0', '0', 'datacad/desc;id/desc');
INSERT INTO lista_form (id, tipo, forms_id, filtropai, pesquisa, lista, label, entidade, listapai, obapendice, acfiltro, acincluir, accolunas, acdeletar, aceditar, acviews, acenviar, filtro, ativo, formainclude, trigger, incontrol, acreplicar, acselecao, ordem) VALUES (23, 'form', 22, 'codigopessoa', '0', 'listaDemandaCliente', 'Interesses', 17, 19, '-', '0', 'Novo Registro', '0 ', '1', '1', '1', '0', '', '1', 'one', NULL, NULL, '0', '0', 'datacad/desc;id/desc');
INSERT INTO lista_form (id, tipo, forms_id, filtropai, pesquisa, lista, label, entidade, listapai, obapendice, acfiltro, acincluir, accolunas, acdeletar, aceditar, acviews, acenviar, filtro, ativo, formainclude, trigger, incontrol, acreplicar, acselecao, ordem) VALUES (25, 'form', 24, 'codigopessoa', '0', 'listaMov-Cliente', 'Movimentações', 18, 25, '-', '0', '0', '0 ', '0', '0', '0', '0', 'ativo/!=/AND/9', '1', 'one', NULL, NULL, '0', '0', 'datacad/desc;id/desc');
INSERT INTO lista_form (id, tipo, forms_id, filtropai, pesquisa, lista, label, entidade, listapai, obapendice, acfiltro, acincluir, accolunas, acdeletar, aceditar, acviews, acenviar, filtro, ativo, formainclude, trigger, incontrol, acreplicar, acselecao, ordem) VALUES (4, 'form', 3, 'codigo', '0', 'listaPatrimonios', 'Patrimônios', 4, 4, '-', '1', '1', '0 ', '1', '1', '0', '0', NULL, '1', 'one', NULL, NULL, '1', '0', 'datacad/desc;id/desc');
INSERT INTO lista_form (id, tipo, forms_id, filtropai, pesquisa, lista, label, entidade, listapai, obapendice, acfiltro, acincluir, accolunas, acdeletar, aceditar, acviews, acenviar, filtro, ativo, formainclude, trigger, incontrol, acreplicar, acselecao, ordem) VALUES (6, 'form', 5, 'codigopatrimonio', '0', 'listaFotosPatrimonios', 'Fotos', 5, 4, '-', '1', '1', '0 ', '1', '1', '0', '0', 'ativo/!=/AND/9', '1', 'one', NULL, NULL, '0', '0', 'datacad/desc;id/desc');
INSERT INTO lista_form (id, tipo, forms_id, filtropai, pesquisa, lista, label, entidade, listapai, obapendice, acfiltro, acincluir, accolunas, acdeletar, aceditar, acviews, acenviar, filtro, ativo, formainclude, trigger, incontrol, acreplicar, acselecao, ordem) VALUES (12, 'form', 7, 'codigo', '0', 'listaSalas', 'Salas', 7, 12, '-', '1', '1', '0 ', '1', '1', '0', '0', 'ativo/!=/AND/9', '1', 'one', NULL, NULL, '0', '0', 'datacad/desc;id/desc');
INSERT INTO lista_form (id, tipo, forms_id, filtropai, pesquisa, lista, label, entidade, listapai, obapendice, acfiltro, acincluir, accolunas, acdeletar, aceditar, acviews, acenviar, filtro, ativo, formainclude, trigger, incontrol, acreplicar, acselecao, ordem) VALUES (13, 'form', 8, 'codigo', '0', 'listaDepartamentos', 'Departamentos', 8, 13, '-', '1', '1', '0 ', '1', '1', '0', '0', 'ativo/!=/AND/9', '1', 'one', NULL, NULL, '0', '0', 'datacad/desc;id/desc');
INSERT INTO lista_form (id, tipo, forms_id, filtropai, pesquisa, lista, label, entidade, listapai, obapendice, acfiltro, acincluir, accolunas, acdeletar, aceditar, acviews, acenviar, filtro, ativo, formainclude, trigger, incontrol, acreplicar, acselecao, ordem) VALUES (14, 'form', 9, 'codigo', '0', 'listaProdutos', 'Produtos', 9, 14, '-', '1', '1', '0 ', '1', '1', '0', '0', 'ativo/!=/AND/9', '1', 'one', NULL, NULL, '0', '0', 'datacad/desc;id/desc');
INSERT INTO lista_form (id, tipo, forms_id, filtropai, pesquisa, lista, label, entidade, listapai, obapendice, acfiltro, acincluir, accolunas, acdeletar, aceditar, acviews, acenviar, filtro, ativo, formainclude, trigger, incontrol, acreplicar, acselecao, ordem) VALUES (15, 'pesq', 9, 'codigo', 'codigoproduto=codigo,label=produto,descricao=descricao', 'pesqProdutos', 'Produtos', 9, 15, '-', '1', '1', '0 ', '0', '0', '0', '1', 'ativo/!=/AND/9', '1', 'one', NULL, NULL, '0', '0', 'datacad/desc;id/desc');
INSERT INTO lista_form (id, tipo, forms_id, filtropai, pesquisa, lista, label, entidade, listapai, obapendice, acfiltro, acincluir, accolunas, acdeletar, aceditar, acviews, acenviar, filtro, ativo, formainclude, trigger, incontrol, acreplicar, acselecao, ordem) VALUES (17, 'form', 16, 'codigo', '0', 'listaMovProdutos', 'Movimentações', 10, 17, '-', '1', '1', '0 ', '0', '0', '0', '0', 'ativo/!=/AND/9', '1', 'one', NULL, NULL, '0', '0', 'datacad/desc;id/desc');
INSERT INTO lista_form (id, tipo, forms_id, filtropai, pesquisa, lista, label, entidade, listapai, obapendice, acfiltro, acincluir, accolunas, acdeletar, aceditar, acviews, acenviar, filtro, ativo, formainclude, trigger, incontrol, acreplicar, acselecao, ordem) VALUES (19, 'form', 18, 'codigo', '0', 'listaClientes', 'Clientes', 3, 19, '-', '1', 'Novo Registro', '0 ', '1', '1', '1', '0', 'cliente/=/AND/1', '1', 'one', NULL, NULL, '0', '0', 'nome_razaosocial/asc');
INSERT INTO lista_form (id, tipo, forms_id, filtropai, pesquisa, lista, label, entidade, listapai, obapendice, acfiltro, acincluir, accolunas, acdeletar, aceditar, acviews, acenviar, filtro, ativo, formainclude, trigger, incontrol, acreplicar, acselecao, ordem) VALUES (80, 'form', 79, 'codigo', '0', 'nfSaida', 'Nota de Saída', 42, 80, '-', '1', 'Novo Registro', '0 ', '0', '1', '1', '0', 'ativo/!=/AND/9;codigotipotransacao/=/AND/10000541-641', '1', 'one', NULL, NULL, '0', '0', 'datacad/desc;id/desc');
INSERT INTO lista_form (id, tipo, forms_id, filtropai, pesquisa, lista, label, entidade, listapai, obapendice, acfiltro, acincluir, accolunas, acdeletar, aceditar, acviews, acenviar, filtro, ativo, formainclude, trigger, incontrol, acreplicar, acselecao, ordem) VALUES (82, 'form', 81, 'codigotransacao', '0', 'transacItens', 'Produtos', 43, 80, '-', '1', 'Novo Registro', '0 ', '1', '1', '0', '0', NULL, '1', 'one', 'setValorTotalProdutosDG()', NULL, '0', '0', 'datacad/desc;id/desc');
INSERT INTO lista_form (id, tipo, forms_id, filtropai, pesquisa, lista, label, entidade, listapai, obapendice, acfiltro, acincluir, accolunas, acdeletar, aceditar, acviews, acenviar, filtro, ativo, formainclude, trigger, incontrol, acreplicar, acselecao, ordem) VALUES (95, 'form', 94, 'codigoproduto', '0', 'prodEstoque', 'Estoque', 56, 89, '-', '0', 'Novo Registro', '0 ', '1', '1', '1', '0', 'ativo/!=/AND/9', '1', 'one', NULL, NULL, '0', '0', 'datacad/desc;id/desc');
INSERT INTO lista_form (id, tipo, forms_id, filtropai, pesquisa, lista, label, entidade, listapai, obapendice, acfiltro, acincluir, accolunas, acdeletar, aceditar, acviews, acenviar, filtro, ativo, formainclude, trigger, incontrol, acreplicar, acselecao, ordem) VALUES (89, 'pesq', 85, 'codigo', 'codigoprodutounidade=codigoprodutounidade>descricao,valorunitario=preco', 'listaProdutosDG', 'Produtos', 54, 89, '-', '1', '0', '0 ', '0', '0', '0', '1', 'ativo/!=/AND/9;codigounidade/=/AND/TTransacao/getUnidadeSession', '1', 'one', NULL, NULL, '0', '0', 'datacad/desc;id/desc');
INSERT INTO lista_form (id, tipo, forms_id, filtropai, pesquisa, lista, label, entidade, listapai, obapendice, acfiltro, acincluir, accolunas, acdeletar, aceditar, acviews, acenviar, filtro, ativo, formainclude, trigger, incontrol, acreplicar, acselecao, ordem) VALUES (86, 'form', 85, 'codigo', '0', 'listaProdutoDG', 'Produtos', 57, 86, '-', '1', 'Novo Registro', '0 ', '1', '1', '0', '0', 'ativo/!=/AND/9', '1', 'one', NULL, NULL, '0', '0', 'datacad/desc;id/desc');
INSERT INTO lista_form (id, tipo, forms_id, filtropai, pesquisa, lista, label, entidade, listapai, obapendice, acfiltro, acincluir, accolunas, acdeletar, aceditar, acviews, acenviar, filtro, ativo, formainclude, trigger, incontrol, acreplicar, acselecao, ordem) VALUES (93, 'form', 96, 'codigo', '0', 'nfVenda', 'Vendas', 42, 80, '-', '1', '0', '0 ', '0', '0', '0', '0', 'ativo/!=/AND/9;codigotipotransacao/=/AND/10000543-643', '1', 'one', NULL, NULL, '0', '0', 'datacad/desc;id/desc');
INSERT INTO lista_form (id, tipo, forms_id, filtropai, pesquisa, lista, label, entidade, listapai, obapendice, acfiltro, acincluir, accolunas, acdeletar, aceditar, acviews, acenviar, filtro, ativo, formainclude, trigger, incontrol, acreplicar, acselecao, ordem) VALUES (101, 'form', 102, 'codigotransacao', '0', 'vendaItens', 'Itens', 43, 93, '-', '0', '0', '0 ', '0', '0', '0', '0', 'ativo/!=/AND/9', '1', 'one', NULL, NULL, '0', '0', 'datacad/desc;id/desc');


--
-- TOC entry 2039 (class 0 OID 22124)
-- Dependencies: 1593
-- Data for Name: menu_modulos; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO menu_modulos (id, modulo, labelmodulo, metodo, argumento, form, nivel, moduloprincipal, ordem, ativo) VALUES (2, 'patrimonios', 'Gerenciar Patrimônios', 'getList', 4, 3, '1', 2, 4, '1');
INSERT INTO menu_modulos (id, modulo, labelmodulo, metodo, argumento, form, nivel, moduloprincipal, ordem, ativo) VALUES (10, 'formasPagamento', 'Formas de Pagamento', 'getList', 55, 54, '1', 1, 5, '1');
INSERT INTO menu_modulos (id, modulo, labelmodulo, metodo, argumento, form, nivel, moduloprincipal, ordem, ativo) VALUES (8, 'cliente', 'Clientes', 'getList', 19, 18, '1', 3, 3, '1');
INSERT INTO menu_modulos (id, modulo, labelmodulo, metodo, argumento, form, nivel, moduloprincipal, ordem, ativo) VALUES (1, 'usuario', 'Gerenciar Usuários', 'getList', 2, 1, '1', 1, 2, '1');
INSERT INTO menu_modulos (id, modulo, labelmodulo, metodo, argumento, form, nivel, moduloprincipal, ordem, ativo) VALUES (4, 'departamentos', 'Gerenciar Departamentos', 'getList', 13, 8, '1', 1, 3, '1');
INSERT INTO menu_modulos (id, modulo, labelmodulo, metodo, argumento, form, nivel, moduloprincipal, ordem, ativo) VALUES (3, 'salas', 'Gerenciar Salas', 'getList', 12, 7, '1', 1, 4, '1');
INSERT INTO menu_modulos (id, modulo, labelmodulo, metodo, argumento, form, nivel, moduloprincipal, ordem, ativo) VALUES (9, 'funcionarios', 'Funcionários', 'getList', 31, 30, '1', 1, 6, '1');
INSERT INTO menu_modulos (id, modulo, labelmodulo, metodo, argumento, form, nivel, moduloprincipal, ordem, ativo) VALUES (15, 'controleContagem', 'Controle Contagem', 'getList', 76, 75, '1', 6, 1, '1');
INSERT INTO menu_modulos (id, modulo, labelmodulo, metodo, argumento, form, nivel, moduloprincipal, ordem, ativo) VALUES (16, 'controleConferencia', 'Controle Conferência', 'getList', 78, 77, '1', 6, 2, '1');
INSERT INTO menu_modulos (id, modulo, labelmodulo, metodo, argumento, form, nivel, moduloprincipal, ordem, ativo) VALUES (14, 'comercial', 'Movimentação', 'getList', 73, 72, '1', 4, 5, '1');
INSERT INTO menu_modulos (id, modulo, labelmodulo, metodo, argumento, form, nivel, moduloprincipal, ordem, ativo) VALUES (18, 'teste', 'teste', 'getList', 83, 84, '1', 6, 3, '1');
INSERT INTO menu_modulos (id, modulo, labelmodulo, metodo, argumento, form, nivel, moduloprincipal, ordem, ativo) VALUES (19, 'produtoDG', 'Produtos', 'getList', 86, 85, '1', 1, 1, '1');
INSERT INTO menu_modulos (id, modulo, labelmodulo, metodo, argumento, form, nivel, moduloprincipal, ordem, ativo) VALUES (20, 'viewProdutoDG', 'Produtos', 'getList', 92, 85, '1', 3, 6, '1');
INSERT INTO menu_modulos (id, modulo, labelmodulo, metodo, argumento, form, nivel, moduloprincipal, ordem, ativo) VALUES (17, 'saidaNF', 'Pedidos', 'getList', 80, 79, '1', 3, 5, '1');
INSERT INTO menu_modulos (id, modulo, labelmodulo, metodo, argumento, form, nivel, moduloprincipal, ordem, ativo) VALUES (13, 'viewProdutos', 'Produtos', 'getList', 71, 70, '1', 11, 5, '0');
INSERT INTO menu_modulos (id, modulo, labelmodulo, metodo, argumento, form, nivel, moduloprincipal, ordem, ativo) VALUES (7, 'pedido', 'Pedidos', 'getList', 49, 48, '1', 11, 2, '0');
INSERT INTO menu_modulos (id, modulo, labelmodulo, metodo, argumento, form, nivel, moduloprincipal, ordem, ativo) VALUES (6, 'estoque', 'Controle de Estoque', 'getList', 0, 0, '1', 11, 1, '0');
INSERT INTO menu_modulos (id, modulo, labelmodulo, metodo, argumento, form, nivel, moduloprincipal, ordem, ativo) VALUES (5, 'produtos', 'Produtos', 'getList', 14, 9, '1', 11, 1, '0');
INSERT INTO menu_modulos (id, modulo, labelmodulo, metodo, argumento, form, nivel, moduloprincipal, ordem, ativo) VALUES (21, 'vendas', 'Vendas', 'getList', 93, 79, '1', 3, 6, '1');
INSERT INTO menu_modulos (id, modulo, labelmodulo, metodo, argumento, form, nivel, moduloprincipal, ordem, ativo) VALUES (12, 'faturamento', 'Faturamento', 'getList', 67, 65, '1', 11, 1, '0');


--
-- TOC entry 2040 (class 0 OID 22133)
-- Dependencies: 1594
-- Data for Name: modulos_principais; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO modulos_principais (id, modulo, labelmodulo, nivel, ordem, ativo) VALUES (2, 'patrimonios', 'Patrimônios', 1, 2, '0');
INSERT INTO modulos_principais (id, modulo, labelmodulo, nivel, ordem, ativo) VALUES (3, 'comercial', 'Comercial', 1, 1, '1');
INSERT INTO modulos_principais (id, modulo, labelmodulo, nivel, ordem, ativo) VALUES (1, 'administrativo', 'Administrativo', 1, 2, '1');
INSERT INTO modulos_principais (id, modulo, labelmodulo, nivel, ordem, ativo) VALUES (4, 'estoque', 'Estoque', 1, 3, '1');
INSERT INTO modulos_principais (id, modulo, labelmodulo, nivel, ordem, ativo) VALUES (6, 'balanco', 'Balanço', 1, 4, '1');


--
-- TOC entry 2041 (class 0 OID 22140)
-- Dependencies: 1596
-- Data for Name: tabelas; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO tabelas (id, tabela, tabela_view, tabpai, ativo, colunafilho) VALUES (1, 'dbusuarios', 'view_usuarios', '-', 1, 'codigousuario');
INSERT INTO tabelas (id, tabela, tabela_view, tabpai, ativo, colunafilho) VALUES (2, 'dbunidades', 'view_unidades', '-', 1, 'unidade');
INSERT INTO tabelas (id, tabela, tabela_view, tabpai, ativo, colunafilho) VALUES (3, 'dbpessoas', 'view_pessoas', '-', 1, 'codigopessoa');
INSERT INTO tabelas (id, tabela, tabela_view, tabpai, ativo, colunafilho) VALUES (4, 'dbpatrimonios', 'view_patrimonios', '-', 1, 'codigopatrimonio');
INSERT INTO tabelas (id, tabela, tabela_view, tabpai, ativo, colunafilho) VALUES (6, 'dbusuarios_privilegios', 'dbusuarios_privilegios', 'dbusuarios', 1, 'codigoprivilegio');
INSERT INTO tabelas (id, tabela, tabela_view, tabpai, ativo, colunafilho) VALUES (5, 'dbpatrimonios_fotos', 'dbpatrimonios_fotos', 'dbpatrimonios', 1, NULL);
INSERT INTO tabelas (id, tabela, tabela_view, tabpai, ativo, colunafilho) VALUES (7, 'dbsalas', 'dbsalas', '-', 1, 'codigosala');
INSERT INTO tabelas (id, tabela, tabela_view, tabpai, ativo, colunafilho) VALUES (8, 'dbdepartamentos', 'dbdepartamentos', '-', 1, 'codigodepartamento');
INSERT INTO tabelas (id, tabela, tabela_view, tabpai, ativo, colunafilho) VALUES (12, 'dbpessoas_complemento_pf', 'view_pessoas_complemento_pf', 'dbpessoas', 1, '');
INSERT INTO tabelas (id, tabela, tabela_view, tabpai, ativo, colunafilho) VALUES (13, 'dbpessoas_complemento_pj', 'view_pessoas_complemento_pj', 'dbpessoas', 1, '');
INSERT INTO tabelas (id, tabela, tabela_view, tabpai, ativo, colunafilho) VALUES (16, 'dbpessoas_convenios', 'view_pessoas_convenios', 'dbpessoas', 1, 'codigo');
INSERT INTO tabelas (id, tabela, tabela_view, tabpai, ativo, colunafilho) VALUES (17, 'dbpessoas_demandas', 'view_pessoas_demandas', 'dbpessoas', 1, '');
INSERT INTO tabelas (id, tabela, tabela_view, tabpai, ativo, colunafilho) VALUES (18, 'dbcaixa', 'view_caixa', '-', 1, 'codigocaixa');
INSERT INTO tabelas (id, tabela, tabela_view, tabpai, ativo, colunafilho) VALUES (31, 'dbpessoas_funcionarios', 'view_pessoas_funcionarios', 'dbpessoas', 1, 'codigofuncionario');
INSERT INTO tabelas (id, tabela, tabela_view, tabpai, ativo, colunafilho) VALUES (33, 'dbpessoas_formacoes', 'view_pessoas_formacoes', 'dbpessoas', 1, '');
INSERT INTO tabelas (id, tabela, tabela_view, tabpai, ativo, colunafilho) VALUES (34, 'dbfuncionarios_treinamentos ', 'view_funcionarios_treinamentos ', 'dbpessoas_funcionarios', 1, '');
INSERT INTO tabelas (id, tabela, tabela_view, tabpai, ativo, colunafilho) VALUES (42, 'dbtransacoes', 'view_transacoes', '-', 1, 'codigotransacao');
INSERT INTO tabelas (id, tabela, tabela_view, tabpai, ativo, colunafilho) VALUES (45, 'dbcontas_cheques', 'view_contas_cheques', '-', 1, '');
INSERT INTO tabelas (id, tabela, tabela_view, tabpai, ativo, colunafilho) VALUES (43, 'dbtransacoes_itens', 'view_transacoes_itens', 'dbtransacoes', 1, NULL);
INSERT INTO tabelas (id, tabela, tabela_view, tabpai, ativo, colunafilho) VALUES (48, 'dbcondicoes_pagamento', 'dbcondicoes_pagamento', '-', 1, 'codigocondicaopagamento');
INSERT INTO tabelas (id, tabela, tabela_view, tabpai, ativo, colunafilho) VALUES (11, 'dbpessoas', 'view_pessoas_funcionarios', '-', 1, 'codigofuncionario');
INSERT INTO tabelas (id, tabela, tabela_view, tabpai, ativo, colunafilho) VALUES (49, 'dbprodutos_markup', 'dbprodutos_markup', 'dbprodutos', 1, NULL);
INSERT INTO tabelas (id, tabela, tabela_view, tabpai, ativo, colunafilho) VALUES (9, 'dbprodutos', 'view_produtos', '-', 1, 'codigoproduto');
INSERT INTO tabelas (id, tabela, tabela_view, tabpai, ativo, colunafilho) VALUES (51, 'dbprodutos_caracteristicas', 'dbprodutos_caracteristicas', 'dbprodutos', 1, NULL);
INSERT INTO tabelas (id, tabela, tabela_view, tabpai, ativo, colunafilho) VALUES (50, 'dbcondicoes_pagamento_pessoa', 'view_condicoes_pagamento_pessoa', 'dbpessoas', 1, NULL);
INSERT INTO tabelas (id, tabela, tabela_view, tabpai, ativo, colunafilho) VALUES (10, 'dbprodutos_movimentacao', 'view_produtos_movimentacao', 'dbprodutos', 1, NULL);
INSERT INTO tabelas (id, tabela, tabela_view, tabpai, ativo, colunafilho) VALUES (52, 'tab_produtosit', 'view_tab_produtosit', '-', 1, NULL);
INSERT INTO tabelas (id, tabela, tabela_view, tabpai, ativo, colunafilho) VALUES (53, 'dbteste', 'dbteste', '-', 1, NULL);
INSERT INTO tabelas (id, tabela, tabela_view, tabpai, ativo, colunafilho) VALUES (55, 'tab_produto_similar', 'view_tab_produto_similar', 'tab_produto', 1, NULL);
INSERT INTO tabelas (id, tabela, tabela_view, tabpai, ativo, colunafilho) VALUES (54, 'tab_produto', 'view_tab_produto', '-', 1, 'codigoproduto');
INSERT INTO tabelas (id, tabela, tabela_view, tabpai, ativo, colunafilho) VALUES (56, 'dbprodutos_unidade', 'view_produtos_unidade', 'tab_produto', 1, 'codigoprodutounidade');
INSERT INTO tabelas (id, tabela, tabela_view, tabpai, ativo, colunafilho) VALUES (57, 'tab_produto', 'view_tab_cad_produto', '-', 1, NULL);


--
-- TOC entry 1974 (class 2606 OID 22166)
-- Dependencies: 1558 1558
-- Name: pk_abas; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY abas
    ADD CONSTRAINT pk_abas PRIMARY KEY (id);


--
-- TOC entry 1976 (class 2606 OID 22168)
-- Dependencies: 1560 1560
-- Name: pk_blocos; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY blocos
    ADD CONSTRAINT pk_blocos PRIMARY KEY (id);


--
-- TOC entry 1978 (class 2606 OID 22170)
-- Dependencies: 1562 1562
-- Name: pk_blocos_x_abas; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY blocos_x_abas
    ADD CONSTRAINT pk_blocos_x_abas PRIMARY KEY (id);


--
-- TOC entry 1981 (class 2606 OID 22172)
-- Dependencies: 1564 1564
-- Name: pk_campos; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY campos
    ADD CONSTRAINT pk_campos PRIMARY KEY (id);


--
-- TOC entry 1984 (class 2606 OID 22174)
-- Dependencies: 1566 1566
-- Name: pk_campos_x_blocos; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY campos_x_blocos
    ADD CONSTRAINT pk_campos_x_blocos PRIMARY KEY (id);


--
-- TOC entry 1987 (class 2606 OID 22176)
-- Dependencies: 1569 1569
-- Name: pk_campos_x_propriedades; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY campos_x_propriedades
    ADD CONSTRAINT pk_campos_x_propriedades PRIMARY KEY (id);


--
-- TOC entry 1989 (class 2606 OID 22178)
-- Dependencies: 1570 1570
-- Name: pk_form_button; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY form_button
    ADD CONSTRAINT pk_form_button PRIMARY KEY (id);


--
-- TOC entry 1991 (class 2606 OID 22180)
-- Dependencies: 1572 1572
-- Name: pk_form_validacao; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY form_validacao
    ADD CONSTRAINT pk_form_validacao PRIMARY KEY (id);


--
-- TOC entry 1993 (class 2606 OID 22182)
-- Dependencies: 1574 1574
-- Name: pk_form_x_abas; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY form_x_abas
    ADD CONSTRAINT pk_form_x_abas PRIMARY KEY (id);


--
-- TOC entry 1995 (class 2606 OID 22184)
-- Dependencies: 1576 1576
-- Name: pk_form_x_tabelas; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY form_x_tabelas
    ADD CONSTRAINT pk_form_x_tabelas PRIMARY KEY (id);


--
-- TOC entry 1997 (class 2606 OID 22186)
-- Dependencies: 1578 1578
-- Name: pk_forms; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY forms
    ADD CONSTRAINT pk_forms PRIMARY KEY (id);


--
-- TOC entry 1999 (class 2606 OID 22188)
-- Dependencies: 1580 1580
-- Name: pk_info_empresa; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY info_empresa
    ADD CONSTRAINT pk_info_empresa PRIMARY KEY (id);


--
-- TOC entry 2002 (class 2606 OID 22190)
-- Dependencies: 1582 1582
-- Name: pk_lista_actions; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lista_actions
    ADD CONSTRAINT pk_lista_actions PRIMARY KEY (id);


--
-- TOC entry 2004 (class 2606 OID 22192)
-- Dependencies: 1584 1584
-- Name: pk_lista_bnav; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lista_bnav
    ADD CONSTRAINT pk_lista_bnav PRIMARY KEY (id);


--
-- TOC entry 2007 (class 2606 OID 22194)
-- Dependencies: 1586 1586
-- Name: pk_lista_colunas; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lista_colunas
    ADD CONSTRAINT pk_lista_colunas PRIMARY KEY (id);


--
-- TOC entry 2009 (class 2606 OID 22196)
-- Dependencies: 1588 1588
-- Name: pk_lista_fields; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lista_fields
    ADD CONSTRAINT pk_lista_fields PRIMARY KEY (id);


--
-- TOC entry 2012 (class 2606 OID 22198)
-- Dependencies: 1590 1590
-- Name: pk_lista_form; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lista_form
    ADD CONSTRAINT pk_lista_form PRIMARY KEY (id);


--
-- TOC entry 2015 (class 2606 OID 22200)
-- Dependencies: 1593 1593
-- Name: pk_menu_modulos; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY menu_modulos
    ADD CONSTRAINT pk_menu_modulos PRIMARY KEY (id);


--
-- TOC entry 2017 (class 2606 OID 22202)
-- Dependencies: 1594 1594
-- Name: pk_modulos_principais; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY modulos_principais
    ADD CONSTRAINT pk_modulos_principais PRIMARY KEY (id);


--
-- TOC entry 2019 (class 2606 OID 22204)
-- Dependencies: 1596 1596
-- Name: pk_tabelas; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY tabelas
    ADD CONSTRAINT pk_tabelas PRIMARY KEY (id);


--
-- TOC entry 2000 (class 1259 OID 22205)
-- Dependencies: 1582
-- Name: fki_lista_actions__lista_form__idlista; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX fki_lista_actions__lista_form__idlista ON lista_actions USING btree (idlista);


--
-- TOC entry 2013 (class 1259 OID 22206)
-- Dependencies: 1593
-- Name: fki_menu_modulos__lista_form__lista; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX fki_menu_modulos__lista_form__lista ON menu_modulos USING btree (argumento);


--
-- TOC entry 1982 (class 1259 OID 22207)
-- Dependencies: 1566 1566
-- Name: idx_campos_blocos; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX idx_campos_blocos ON campos_x_blocos USING btree (blocoid, campoid);


--
-- TOC entry 1979 (class 1259 OID 22208)
-- Dependencies: 1564
-- Name: idx_campos_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX idx_campos_id ON campos USING btree (id);


--
-- TOC entry 1985 (class 1259 OID 22209)
-- Dependencies: 1569
-- Name: idx_campos_propriedades; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX idx_campos_propriedades ON campos_x_propriedades USING btree (campoid);


--
-- TOC entry 2005 (class 1259 OID 22210)
-- Dependencies: 1586
-- Name: lista_colunas_listacolunas_fkindex1; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX lista_colunas_listacolunas_fkindex1 ON lista_colunas USING btree (lista_form_id);


--
-- TOC entry 2010 (class 1259 OID 22211)
-- Dependencies: 1590
-- Name: lista_form_formlista_fkindex1; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX lista_form_formlista_fkindex1 ON lista_form USING btree (forms_id);


--
-- TOC entry 2020 (class 2606 OID 22212)
-- Dependencies: 1590 1582 2011
-- Name: lista_actions__lista_form__idlista; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY lista_actions
    ADD CONSTRAINT lista_actions__lista_form__idlista FOREIGN KEY (idlista) REFERENCES lista_form(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2021 (class 2606 OID 22217)
-- Dependencies: 1586 1590 2011
-- Name: lista_colunas__lista_form; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY lista_colunas
    ADD CONSTRAINT lista_colunas__lista_form FOREIGN KEY (lista_form_id) REFERENCES lista_form(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2046 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: -
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2011-01-27 11:48:36

--
-- PostgreSQL database dump complete
--

