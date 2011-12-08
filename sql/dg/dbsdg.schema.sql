--
-- PostgreSQL database dump
--

-- Dumped from database version 8.4.4
-- Dumped by pg_dump version 9.0.1
-- Started on 2011-01-27 11:48:19

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- TOC entry 5 (class 2615 OID 22228)
-- Name: dominio; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA dominio;


--
-- TOC entry 505 (class 2612 OID 16386)
-- Name: plpgsql; Type: PROCEDURAL LANGUAGE; Schema: -; Owner: -
--

CREATE OR REPLACE PROCEDURAL LANGUAGE plpgsql;


SET search_path = public, pg_catalog;

--
-- TOC entry 304 (class 1247 OID 22231)
-- Dependencies: 7 1692
-- Name: complex; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE complex AS (
	r double precision,
	i double precision
);


--
-- TOC entry 20 (class 1255 OID 22232)
-- Dependencies: 505 7
-- Name: func_tab_produtosit(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION func_tab_produtosit() RETURNS trigger
    LANGUAGE plpgsql
    AS '
BEGIN

IF (OLD.nova_qtd <> NEW.nova_qtd) THEN

   IF (TG_OP = ''INSERT'') THEN
      INSERT INTO tab_historicobalancoalteracao (codigoautor, cod_mer,  marca_mer, estoque_fisico, nova_qtd, hsbadtlg, hsbahrlg, operacao) VALUES
        (NEW.codigoautor, OLD.cod_mer, OLD.marca_mer, OLD.estoque_fisico, NEW.nova_qtd, now(), CURRENT_TIMESTAMP, TG_OP);
      RETURN NEW;

   ELSIF (TG_OP = ''UPDATE'') THEN
      INSERT INTO tab_historicobalancoalteracao (codigoautor, cod_mer,  marca_mer, estoque_fisico, nova_qtd, hsbadtlg, hsbahrlg, operacao) VALUES
        (NEW.codigoautor, OLD.cod_mer, OLD.marca_mer, OLD.estoque_fisico, NEW.nova_qtd, now(), CURRENT_TIMESTAMP, TG_OP);
      RETURN NEW;

   ELSIF (TG_OP = ''DELETE'') THEN
      INSERT INTO tab_historicobalancoalteracao (codigoautor, cod_mer,  marca_mer, estoque_fisico, nova_qtd, hsbadtlg, hsbahrlg, operacao) VALUES
        (NEW.codigoautor, OLD.cod_mer, OLD.marca_mer, OLD.estoque_fisico, OLD.nova_qtd, now(), CURRENT_TIMESTAMP, TG_OP);
      RETURN NEW;
   END IF;


END IF;  
   RETURN NULL;
END;
';


SET search_path = dominio, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 1693 (class 1259 OID 22233)
-- Dependencies: 5
-- Name: dbceps; Type: TABLE; Schema: dominio; Owner: -; Tablespace: 
--

CREATE TABLE dbceps (
    id integer NOT NULL,
    codigomunicipio character varying(200),
    codigouf character varying(30),
    faixainicial character varying(8),
    faixafinal character varying(8)
);


--
-- TOC entry 1694 (class 1259 OID 22236)
-- Dependencies: 1693 5
-- Name: dbceps_id_seq; Type: SEQUENCE; Schema: dominio; Owner: -
--

CREATE SEQUENCE dbceps_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2447 (class 0 OID 0)
-- Dependencies: 1694
-- Name: dbceps_id_seq; Type: SEQUENCE OWNED BY; Schema: dominio; Owner: -
--

ALTER SEQUENCE dbceps_id_seq OWNED BY dbceps.id;


--
-- TOC entry 1695 (class 1259 OID 22238)
-- Dependencies: 5
-- Name: dbcidades; Type: TABLE; Schema: dominio; Owner: -; Tablespace: 
--

CREATE TABLE dbcidades (
    id integer NOT NULL,
    cidade character varying(200),
    codigouf character varying(2),
    codigoibge character varying(30)
);


--
-- TOC entry 1696 (class 1259 OID 22241)
-- Dependencies: 1695 5
-- Name: dbcidades_id_seq; Type: SEQUENCE; Schema: dominio; Owner: -
--

CREATE SEQUENCE dbcidades_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2448 (class 0 OID 0)
-- Dependencies: 1696
-- Name: dbcidades_id_seq; Type: SEQUENCE OWNED BY; Schema: dominio; Owner: -
--

ALTER SEQUENCE dbcidades_id_seq OWNED BY dbcidades.id;


--
-- TOC entry 1697 (class 1259 OID 22243)
-- Dependencies: 5
-- Name: dbestados; Type: TABLE; Schema: dominio; Owner: -; Tablespace: 
--

CREATE TABLE dbestados (
    id integer NOT NULL,
    estado character varying(30),
    uf character varying(2),
    codigouf character varying(30),
    codigopais character varying(30)
);


--
-- TOC entry 1698 (class 1259 OID 22246)
-- Dependencies: 1697 5
-- Name: dbestados_id_seq; Type: SEQUENCE; Schema: dominio; Owner: -
--

CREATE SEQUENCE dbestados_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2449 (class 0 OID 0)
-- Dependencies: 1698
-- Name: dbestados_id_seq; Type: SEQUENCE OWNED BY; Schema: dominio; Owner: -
--

ALTER SEQUENCE dbestados_id_seq OWNED BY dbestados.id;


--
-- TOC entry 1699 (class 1259 OID 22248)
-- Dependencies: 5
-- Name: dbnfe_erros; Type: TABLE; Schema: dominio; Owner: -; Tablespace: 
--

CREATE TABLE dbnfe_erros (
    id integer NOT NULL,
    identificador character varying(40),
    descricao text,
    aplicacao character varying(40),
    mensagem character varying(40),
    efeito character varying(250)
);


--
-- TOC entry 1700 (class 1259 OID 22254)
-- Dependencies: 5
-- Name: dbnfe_erros_grupos; Type: TABLE; Schema: dominio; Owner: -; Tablespace: 
--

CREATE TABLE dbnfe_erros_grupos (
    id integer NOT NULL,
    grupo character varying(1),
    descricao text,
    aplicacao character varying(40)
);


--
-- TOC entry 1701 (class 1259 OID 22260)
-- Dependencies: 5 1699
-- Name: dbnfe_erros_id_seq; Type: SEQUENCE; Schema: dominio; Owner: -
--

CREATE SEQUENCE dbnfe_erros_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2450 (class 0 OID 0)
-- Dependencies: 1701
-- Name: dbnfe_erros_id_seq; Type: SEQUENCE OWNED BY; Schema: dominio; Owner: -
--

ALTER SEQUENCE dbnfe_erros_id_seq OWNED BY dbnfe_erros.id;


--
-- TOC entry 1702 (class 1259 OID 22262)
-- Dependencies: 5
-- Name: dbnfe_erros_mensagens; Type: TABLE; Schema: dominio; Owner: -; Tablespace: 
--

CREATE TABLE dbnfe_erros_mensagens (
    id integer NOT NULL,
    codigo character varying(10),
    descricao text
);


--
-- TOC entry 1703 (class 1259 OID 22268)
-- Dependencies: 5
-- Name: dbpaises; Type: TABLE; Schema: dominio; Owner: -; Tablespace: 
--

CREATE TABLE dbpaises (
    id integer NOT NULL,
    pais character varying(200),
    codigopais character varying(30),
    tributacaofavorecida character varying(30)
);


--
-- TOC entry 1704 (class 1259 OID 22271)
-- Dependencies: 5 1703
-- Name: dbpaises_id_seq; Type: SEQUENCE; Schema: dominio; Owner: -
--

CREATE SEQUENCE dbpaises_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2451 (class 0 OID 0)
-- Dependencies: 1704
-- Name: dbpaises_id_seq; Type: SEQUENCE OWNED BY; Schema: dominio; Owner: -
--

ALTER SEQUENCE dbpaises_id_seq OWNED BY dbpaises.id;


SET search_path = public, pg_catalog;

--
-- TOC entry 1705 (class 1259 OID 22273)
-- Dependencies: 7
-- Name: gerador_codigo_digito_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE gerador_codigo_digito_seq
    START WITH 100
    INCREMENT BY 1
    MINVALUE 100
    MAXVALUE 999
    CACHE 1
    CYCLE;


--
-- TOC entry 1706 (class 1259 OID 22275)
-- Dependencies: 7
-- Name: gerador_codigo_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE gerador_codigo_seq
    START WITH 10000000
    INCREMENT BY 1
    MINVALUE 10000000
    NO MAXVALUE
    CACHE 1;


SET search_path = dominio, pg_catalog;

--
-- TOC entry 1707 (class 1259 OID 22277)
-- Dependencies: 2100 2101 2102 2103 5
-- Name: dbunidade_medida; Type: TABLE; Schema: dominio; Owner: -; Tablespace: 
--

CREATE TABLE dbunidade_medida (
    id integer NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('public.gerador_codigo_seq'::regclass) || '-'::text) || nextval('public.gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying,
    unidademedida character varying(30),
    abreviacao character varying(12),
    tipounidademedida character varying(40),
    datacad date DEFAULT '2011-01-06'::date,
    ativo character varying(2) DEFAULT '9'::character varying
);


--
-- TOC entry 1708 (class 1259 OID 22284)
-- Dependencies: 5 1707
-- Name: dbunidade_medida_id_seq; Type: SEQUENCE; Schema: dominio; Owner: -
--

CREATE SEQUENCE dbunidade_medida_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2452 (class 0 OID 0)
-- Dependencies: 1708
-- Name: dbunidade_medida_id_seq; Type: SEQUENCE OWNED BY; Schema: dominio; Owner: -
--

ALTER SEQUENCE dbunidade_medida_id_seq OWNED BY dbunidade_medida.id;


--
-- TOC entry 1709 (class 1259 OID 22286)
-- Dependencies: 5
-- Name: dbwebservices; Type: TABLE; Schema: dominio; Owner: -; Tablespace: 
--

CREATE TABLE dbwebservices (
    id integer NOT NULL,
    uf character varying(10),
    servico character varying(60),
    versao character varying(30),
    url_homologacao character varying(250),
    schemaxml character varying(250),
    url_producao character varying(250)
);


--
-- TOC entry 1710 (class 1259 OID 22292)
-- Dependencies: 5
-- Name: dbwebservices_campos; Type: TABLE; Schema: dominio; Owner: -; Tablespace: 
--

CREATE TABLE dbwebservices_campos (
    id integer NOT NULL,
    schemaxml character varying(250),
    identificador character varying(80),
    campo character varying(80),
    elemento character varying(42),
    pai character varying(43),
    tipo character varying(40),
    ocorrenciamin character varying(40),
    ocorrenciamax character varying(40),
    tamanhomin character varying(40),
    tamanhomax character varying(40),
    decimais character varying(40),
    descricao text,
    metodovalidacao character varying(40),
    campopai character varying(200)
);


--
-- TOC entry 1711 (class 1259 OID 22298)
-- Dependencies: 5 1710
-- Name: dbwebservices_campos_id_seq; Type: SEQUENCE; Schema: dominio; Owner: -
--

CREATE SEQUENCE dbwebservices_campos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2453 (class 0 OID 0)
-- Dependencies: 1711
-- Name: dbwebservices_campos_id_seq; Type: SEQUENCE OWNED BY; Schema: dominio; Owner: -
--

ALTER SEQUENCE dbwebservices_campos_id_seq OWNED BY dbwebservices_campos.id;


--
-- TOC entry 1712 (class 1259 OID 22300)
-- Dependencies: 1709 5
-- Name: dbwebservices_id_seq; Type: SEQUENCE; Schema: dominio; Owner: -
--

CREATE SEQUENCE dbwebservices_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2454 (class 0 OID 0)
-- Dependencies: 1712
-- Name: dbwebservices_id_seq; Type: SEQUENCE OWNED BY; Schema: dominio; Owner: -
--

ALTER SEQUENCE dbwebservices_id_seq OWNED BY dbwebservices.id;


SET search_path = public, pg_catalog;

--
-- TOC entry 1713 (class 1259 OID 22302)
-- Dependencies: 2107 2108 2109 2110 2111 7
-- Name: dbcargos; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbcargos (
    id integer NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    nomecargo character varying(80),
    descricao text,
    conhecimentos text,
    habilidades text,
    atitudes text,
    prerequisitos text,
    cargahoraria character varying(3),
    horariotrabalho character varying(80),
    maquinasutilizadas text,
    graurisco character varying(80),
    subordinado character varying(80),
    cargoascendente text,
    cargodescendente text,
    salariobase real DEFAULT 0.00,
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 1714 (class 1259 OID 22313)
-- Dependencies: 1713 7
-- Name: dbcargos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbcargos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2455 (class 0 OID 0)
-- Dependencies: 1714
-- Name: dbcargos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dbcargos_id_seq OWNED BY dbcargos.id;


--
-- TOC entry 1715 (class 1259 OID 22315)
-- Dependencies: 2113 2114 2115 2116 7
-- Name: dbcomportamento_fiscal; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbcomportamento_fiscal (
    id integer NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying,
    titulo character varying(30),
    descricao character varying(40),
    datacad date DEFAULT '2010-11-09'::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 2456 (class 0 OID 0)
-- Dependencies: 1715
-- Name: TABLE dbcomportamento_fiscal; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE dbcomportamento_fiscal IS 'Comportamento Fiscal';


--
-- TOC entry 2457 (class 0 OID 0)
-- Dependencies: 1715
-- Name: COLUMN dbcomportamento_fiscal.titulo; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbcomportamento_fiscal.titulo IS 'Titulo para o Comportamento fiscal';


--
-- TOC entry 2458 (class 0 OID 0)
-- Dependencies: 1715
-- Name: COLUMN dbcomportamento_fiscal.descricao; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbcomportamento_fiscal.descricao IS 'Descrição do comportamento fiscal';


--
-- TOC entry 1716 (class 1259 OID 22322)
-- Dependencies: 7 1715
-- Name: dbcomportamento_fiscal_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbcomportamento_fiscal_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2459 (class 0 OID 0)
-- Dependencies: 1716
-- Name: dbcomportamento_fiscal_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dbcomportamento_fiscal_id_seq OWNED BY dbcomportamento_fiscal.id;


--
-- TOC entry 1717 (class 1259 OID 22324)
-- Dependencies: 2118 2119 2120 2121 7
-- Name: dbcondicoes_pagamento; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbcondicoes_pagamento (
    id integer NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying,
    descricao character varying(40),
    parcelas bigint,
    intervalo bigint,
    entrada smallint,
    obs text,
    datacad date DEFAULT '2010-11-10'::date,
    ativo character varying(2) DEFAULT '9'::character varying,
    juros numeric(11,2),
    indice numeric(15,5)
);


--
-- TOC entry 2460 (class 0 OID 0)
-- Dependencies: 1717
-- Name: TABLE dbcondicoes_pagamento; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE dbcondicoes_pagamento IS 'Formas de pagamentos';


--
-- TOC entry 2461 (class 0 OID 0)
-- Dependencies: 1717
-- Name: COLUMN dbcondicoes_pagamento.codigo; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbcondicoes_pagamento.codigo IS 'Identificador de referencia da tabela para o kernelsys';


--
-- TOC entry 2462 (class 0 OID 0)
-- Dependencies: 1717
-- Name: COLUMN dbcondicoes_pagamento.codigoautor; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbcondicoes_pagamento.codigoautor IS 'Identificador do usuario responsavel pelo registro';


--
-- TOC entry 2463 (class 0 OID 0)
-- Dependencies: 1717
-- Name: COLUMN dbcondicoes_pagamento.parcelas; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbcondicoes_pagamento.parcelas IS 'Número de parcelas permitidas';


--
-- TOC entry 2464 (class 0 OID 0)
-- Dependencies: 1717
-- Name: COLUMN dbcondicoes_pagamento.intervalo; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbcondicoes_pagamento.intervalo IS 'Intervalo em dias entre as parcelas';


--
-- TOC entry 2465 (class 0 OID 0)
-- Dependencies: 1717
-- Name: COLUMN dbcondicoes_pagamento.entrada; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbcondicoes_pagamento.entrada IS 'Entrada da forma de pagamento

*sim
*não';


--
-- TOC entry 1718 (class 1259 OID 22334)
-- Dependencies: 7 1717
-- Name: dbcondicoes_pagamento_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbcondicoes_pagamento_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2466 (class 0 OID 0)
-- Dependencies: 1718
-- Name: dbcondicoes_pagamento_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dbcondicoes_pagamento_id_seq OWNED BY dbcondicoes_pagamento.id;


--
-- TOC entry 1719 (class 1259 OID 22336)
-- Dependencies: 2123 2124 2125 2126 7
-- Name: dbcondicoes_pagamento_pessoa; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbcondicoes_pagamento_pessoa (
    id integer NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying,
    codigoformapagamento character varying(20),
    codigopessoa character varying(20),
    datacad date DEFAULT '2010-11-10'::date,
    ativo character varying(2) DEFAULT '9'::character varying,
    limitedesconto numeric(11,4)
);


--
-- TOC entry 2467 (class 0 OID 0)
-- Dependencies: 1719
-- Name: TABLE dbcondicoes_pagamento_pessoa; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE dbcondicoes_pagamento_pessoa IS 'Formas de pagamentos associadas ao funcionarios vendedor';


--
-- TOC entry 2468 (class 0 OID 0)
-- Dependencies: 1719
-- Name: COLUMN dbcondicoes_pagamento_pessoa.codigo; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbcondicoes_pagamento_pessoa.codigo IS 'Identificador de referencia da tabela para o kernelsys';


--
-- TOC entry 2469 (class 0 OID 0)
-- Dependencies: 1719
-- Name: COLUMN dbcondicoes_pagamento_pessoa.codigoautor; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbcondicoes_pagamento_pessoa.codigoautor IS 'Identificador do usuario responsavel pelo registro';


--
-- TOC entry 2470 (class 0 OID 0)
-- Dependencies: 1719
-- Name: COLUMN dbcondicoes_pagamento_pessoa.codigoformapagamento; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbcondicoes_pagamento_pessoa.codigoformapagamento IS 'Código da forma de pagamento';


--
-- TOC entry 2471 (class 0 OID 0)
-- Dependencies: 1719
-- Name: COLUMN dbcondicoes_pagamento_pessoa.codigopessoa; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbcondicoes_pagamento_pessoa.codigopessoa IS 'Codigo do vendedor';


--
-- TOC entry 1720 (class 1259 OID 22343)
-- Dependencies: 1719 7
-- Name: dbcondicoes_pagamento_pessoa_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbcondicoes_pagamento_pessoa_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2472 (class 0 OID 0)
-- Dependencies: 1720
-- Name: dbcondicoes_pagamento_pessoa_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dbcondicoes_pagamento_pessoa_id_seq OWNED BY dbcondicoes_pagamento_pessoa.id;


--
-- TOC entry 1721 (class 1259 OID 22345)
-- Dependencies: 2128 2129 2130 2131 7
-- Name: dbdepartamentos; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbdepartamentos (
    id integer NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    label character varying(120),
    codigoresponsavel character varying(30),
    codigosala character varying(30),
    obs text,
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 1722 (class 1259 OID 22355)
-- Dependencies: 7 1721
-- Name: dbdepartamentos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbdepartamentos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2473 (class 0 OID 0)
-- Dependencies: 1722
-- Name: dbdepartamentos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dbdepartamentos_id_seq OWNED BY dbdepartamentos.id;


--
-- TOC entry 1723 (class 1259 OID 22357)
-- Dependencies: 2133 2134 2135 2136 2137 2138 7
-- Name: dbpatrimonios; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbpatrimonios (
    id integer NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    codigofuncionario character varying(30),
    codigoproduto character varying(30),
    modelo character varying(255),
    marca character varying(255),
    label character varying(255),
    descricao character varying(250),
    tipo character varying(80),
    datafabricacao date,
    dataaquisicao date,
    valornominal real DEFAULT 0.00,
    lotacao character varying(60),
    valorcompra real DEFAULT 0.00,
    numnf character varying(80),
    dataverificacao date,
    obs text,
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 1724 (class 1259 OID 22369)
-- Dependencies: 2140 2141 2142 2143 7
-- Name: dbpatrimonios_fotos; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbpatrimonios_fotos (
    id integer NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    codigopatrimonio character varying(30),
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL,
    patharquivo character varying(250)
);


--
-- TOC entry 1725 (class 1259 OID 22376)
-- Dependencies: 1724 7
-- Name: dbpatrimonios_fotos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbpatrimonios_fotos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2474 (class 0 OID 0)
-- Dependencies: 1725
-- Name: dbpatrimonios_fotos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dbpatrimonios_fotos_id_seq OWNED BY dbpatrimonios_fotos.id;


--
-- TOC entry 1726 (class 1259 OID 22378)
-- Dependencies: 1723 7
-- Name: dbpatrimonios_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbpatrimonios_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2475 (class 0 OID 0)
-- Dependencies: 1726
-- Name: dbpatrimonios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dbpatrimonios_id_seq OWNED BY dbpatrimonios.id;


--
-- TOC entry 1727 (class 1259 OID 22380)
-- Dependencies: 2145 2146 2147 2148 2149 2150 2151 2152 2153 7
-- Name: dbpessoas; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbpessoas (
    id integer NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    tipo character varying(20) DEFAULT 'F'::character varying,
    nome_razaosocial character varying(160),
    cpf_cnpj character varying(20),
    rg_inscest character varying(30),
    titeleitor_inscmun character varying(20),
    logradouro text,
    bairro character varying(80),
    cidade character varying(80),
    estado character varying(2),
    cep character varying(10),
    caixapostal character varying(20),
    referencia character varying(80),
    tel1 character varying(20),
    tel2 character varying(20),
    cel1 character varying(20),
    cel2 character varying(20),
    email1 character varying(80),
    email2 character varying(80),
    site character varying(120),
    opcobranca character varying(20) DEFAULT '1'::character varying NOT NULL,
    cliente character varying(1) DEFAULT '0'::character varying,
    fornecedor character varying(1) DEFAULT '0'::character varying,
    funcionario character varying(1) DEFAULT '0'::character varying,
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL,
    foto text,
    numeroendereco character varying(30)
);


--
-- TOC entry 1728 (class 1259 OID 22395)
-- Dependencies: 2155 2156 2157 2158 7
-- Name: dbpessoas_complemento_pf; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbpessoas_complemento_pf (
    id integer NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    codigopessoa character varying(30),
    estadocivil character varying(100),
    etinia character varying(100),
    datanasc date,
    sexo character varying(2),
    tiposanguineo character varying(5),
    nacionalidade character varying(100),
    portadornecessidades character varying(2),
    necessidadesespeciais text,
    numerodependentes character varying(10),
    cnh character varying(40),
    carteirareservista character varying(40),
    rendamensal real,
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 1729 (class 1259 OID 22405)
-- Dependencies: 7 1728
-- Name: dbpessoas_complemento_pf_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbpessoas_complemento_pf_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2476 (class 0 OID 0)
-- Dependencies: 1729
-- Name: dbpessoas_complemento_pf_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dbpessoas_complemento_pf_id_seq OWNED BY dbpessoas_complemento_pf.id;


--
-- TOC entry 1730 (class 1259 OID 22407)
-- Dependencies: 2160 2161 2162 2163 7
-- Name: dbpessoas_complemento_pj; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbpessoas_complemento_pj (
    id integer NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    codigopessoa character varying(30),
    datafundacao date,
    gerente character varying(180),
    diretor character varying(180),
    representante character varying(180),
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 1731 (class 1259 OID 22417)
-- Dependencies: 1730 7
-- Name: dbpessoas_complemento_pj_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbpessoas_complemento_pj_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2477 (class 0 OID 0)
-- Dependencies: 1731
-- Name: dbpessoas_complemento_pj_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dbpessoas_complemento_pj_id_seq OWNED BY dbpessoas_complemento_pj.id;


--
-- TOC entry 1732 (class 1259 OID 22419)
-- Dependencies: 2165 2166 2167 2168 7
-- Name: dbpessoas_formacoes; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbpessoas_formacoes (
    id integer NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    codigopessoa character varying(30),
    codigotitularidade character varying(30),
    curso character varying(160),
    instituicao character varying(160),
    anoconclusao character varying(255),
    observacao text,
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 1733 (class 1259 OID 22429)
-- Dependencies: 1732 7
-- Name: dbpessoas_formacoes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbpessoas_formacoes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2478 (class 0 OID 0)
-- Dependencies: 1733
-- Name: dbpessoas_formacoes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dbpessoas_formacoes_id_seq OWNED BY dbpessoas_formacoes.id;


--
-- TOC entry 1734 (class 1259 OID 22431)
-- Dependencies: 2170 2171 2172 2173 7
-- Name: dbpessoas_funcionarios; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbpessoas_funcionarios (
    id integer NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    codigopessoa character varying(30),
    codigocargo character varying(20) NOT NULL,
    codigodepartamento character varying(30),
    dataadmissao date,
    relatorioexame text,
    dataexame date,
    lotacao character varying(80),
    cargo character varying(100),
    regimecontrato character varying(40),
    empterc character varying(255),
    perfil text,
    foto text,
    cbo character varying(80),
    pis_pasep character varying(30),
    salario real,
    gratificacao real,
    beneficios text,
    valorbeneficios real,
    ferias real,
    pagbanco character varying(50),
    pagagencia character varying(20),
    pagconta character varying(20),
    pagvencimento character varying(255),
    contadebito character varying(20),
    numerodependentes character varying(10),
    obs text,
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL,
    limitedesconto numeric(11,2)
);


--
-- TOC entry 1735 (class 1259 OID 22441)
-- Dependencies: 7 1734
-- Name: dbpessoas_funcionarios_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbpessoas_funcionarios_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2479 (class 0 OID 0)
-- Dependencies: 1735
-- Name: dbpessoas_funcionarios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dbpessoas_funcionarios_id_seq OWNED BY dbpessoas_funcionarios.id;


--
-- TOC entry 1736 (class 1259 OID 22443)
-- Dependencies: 1727 7
-- Name: dbpessoas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbpessoas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2480 (class 0 OID 0)
-- Dependencies: 1736
-- Name: dbpessoas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dbpessoas_id_seq OWNED BY dbpessoas.id;


--
-- TOC entry 1737 (class 1259 OID 22445)
-- Dependencies: 2175 2176 2177 2178 7
-- Name: dbpessoas_titularidades; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbpessoas_titularidades (
    id integer NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    titularidade character varying(50),
    nomeacao character varying(30),
    peso character varying(2) DEFAULT '1'::character varying NOT NULL,
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 1738 (class 1259 OID 22452)
-- Dependencies: 7 1737
-- Name: dbpessoas_titularidades_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbpessoas_titularidades_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2481 (class 0 OID 0)
-- Dependencies: 1738
-- Name: dbpessoas_titularidades_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dbpessoas_titularidades_id_seq OWNED BY dbpessoas_titularidades.id;


--
-- TOC entry 1739 (class 1259 OID 22454)
-- Dependencies: 2180 2181 2182 2183 2184 7
-- Name: dbprodutos; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbprodutos (
    id integer NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying,
    codigoprodutotipo character varying(30),
    codigocomportamentofiscal character varying(20),
    produto character varying(200),
    descricao text,
    estoqueminimo integer DEFAULT 0.00,
    estoquemaximo integer,
    obs text,
    datacad date DEFAULT '2010-11-09'::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 2482 (class 0 OID 0)
-- Dependencies: 1739
-- Name: TABLE dbprodutos; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE dbprodutos IS 'Dados principais do produto';


--
-- TOC entry 2483 (class 0 OID 0)
-- Dependencies: 1739
-- Name: COLUMN dbprodutos.codigo; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbprodutos.codigo IS 'Identificador de referencia da tabela para o kernelsys';


--
-- TOC entry 2484 (class 0 OID 0)
-- Dependencies: 1739
-- Name: COLUMN dbprodutos.codigoautor; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbprodutos.codigoautor IS 'Identificador do usuario responsavel pelo registro';


--
-- TOC entry 2485 (class 0 OID 0)
-- Dependencies: 1739
-- Name: COLUMN dbprodutos.produto; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbprodutos.produto IS 'Nome do produto';


--
-- TOC entry 2486 (class 0 OID 0)
-- Dependencies: 1739
-- Name: COLUMN dbprodutos.descricao; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbprodutos.descricao IS 'Descrição do produto';


--
-- TOC entry 2487 (class 0 OID 0)
-- Dependencies: 1739
-- Name: COLUMN dbprodutos.estoqueminimo; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbprodutos.estoqueminimo IS 'Estoque mínimo do produto';


--
-- TOC entry 2488 (class 0 OID 0)
-- Dependencies: 1739
-- Name: COLUMN dbprodutos.estoquemaximo; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbprodutos.estoquemaximo IS 'Estoque máximo do produto';


--
-- TOC entry 1740 (class 1259 OID 22465)
-- Dependencies: 7 1739
-- Name: dbprodutos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbprodutos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2489 (class 0 OID 0)
-- Dependencies: 1740
-- Name: dbprodutos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dbprodutos_id_seq OWNED BY dbprodutos.id;


--
-- TOC entry 1741 (class 1259 OID 22467)
-- Dependencies: 2186 2187 2188 2189 7
-- Name: dbprodutos_movimentacao; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbprodutos_movimentacao (
    id integer NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying,
    codigoproduto character varying(30),
    quantidade numeric,
    valorunitario numeric(15,3),
    numdocumento character varying(60),
    codigotipomovimentacao character varying(20),
    datacad date DEFAULT '2010-11-10'::date,
    ativo character varying(2) DEFAULT '9'::character varying,
    codigotransacaoitem character varying(20),
    codigoprodutounidade character varying(20)
);


--
-- TOC entry 2490 (class 0 OID 0)
-- Dependencies: 1741
-- Name: TABLE dbprodutos_movimentacao; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE dbprodutos_movimentacao IS 'Registra todas as movimentaÃ§Ãµes dos produtos no estoque';


--
-- TOC entry 2491 (class 0 OID 0)
-- Dependencies: 1741
-- Name: COLUMN dbprodutos_movimentacao.valorunitario; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbprodutos_movimentacao.valorunitario IS 'Valor unitário do produto quando entrou no estoque';


--
-- TOC entry 2492 (class 0 OID 0)
-- Dependencies: 1741
-- Name: COLUMN dbprodutos_movimentacao.numdocumento; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbprodutos_movimentacao.numdocumento IS 'NÃºmero do documento

Entrada - N. da nota de entrada
SaÃ­da - N. da nota de saida
Pedido - N. do pedido responsavel pela reserva';


--
-- TOC entry 2493 (class 0 OID 0)
-- Dependencies: 1741
-- Name: COLUMN dbprodutos_movimentacao.codigotipomovimentacao; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbprodutos_movimentacao.codigotipomovimentacao IS 'Codigo do tipo de movimentação';


--
-- TOC entry 1742 (class 1259 OID 22477)
-- Dependencies: 1741 7
-- Name: dbprodutos_movimentacao_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbprodutos_movimentacao_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2494 (class 0 OID 0)
-- Dependencies: 1742
-- Name: dbprodutos_movimentacao_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dbprodutos_movimentacao_id_seq OWNED BY dbprodutos_movimentacao.id;


--
-- TOC entry 1743 (class 1259 OID 22479)
-- Dependencies: 2191 2192 2193 2194 7
-- Name: dbprodutos_tipos; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbprodutos_tipos (
    id integer NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying,
    codigoproduto character varying(30),
    titulo character varying(200),
    obs text,
    datacad date DEFAULT '2010-11-09'::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 2495 (class 0 OID 0)
-- Dependencies: 1743
-- Name: TABLE dbprodutos_tipos; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE dbprodutos_tipos IS 'Dominio - Tipos de produto';


--
-- TOC entry 1744 (class 1259 OID 22489)
-- Dependencies: 7 1743
-- Name: dbprodutos_tipos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbprodutos_tipos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2496 (class 0 OID 0)
-- Dependencies: 1744
-- Name: dbprodutos_tipos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dbprodutos_tipos_id_seq OWNED BY dbprodutos_tipos.id;


--
-- TOC entry 1745 (class 1259 OID 22491)
-- Dependencies: 2196 2197 2198 2199 7
-- Name: dbprodutos_unidade; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbprodutos_unidade (
    id integer NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30) NOT NULL,
    codigoautor character varying(20) DEFAULT '0000'::character varying,
    codigoproduto character varying(20),
    codigounidade character varying(20),
    quantidadeinicial numeric(15,4),
    custo numeric(15,4),
    preco numeric(15,4),
    endereco character varying(60),
    obs text,
    datacad date DEFAULT '2011-01-20'::date,
    ativo character varying(2) DEFAULT '9'::character varying
);


--
-- TOC entry 2497 (class 0 OID 0)
-- Dependencies: 1745
-- Name: TABLE dbprodutos_unidade; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE dbprodutos_unidade IS 'Produtos da emprsa';


--
-- TOC entry 1746 (class 1259 OID 22501)
-- Dependencies: 1745 7
-- Name: dbprodutos_unidade_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbprodutos_unidade_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2498 (class 0 OID 0)
-- Dependencies: 1746
-- Name: dbprodutos_unidade_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dbprodutos_unidade_id_seq OWNED BY dbprodutos_unidade.id;


--
-- TOC entry 1747 (class 1259 OID 22503)
-- Dependencies: 2201 2202 2203 2204 2205 7
-- Name: dbsalas; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbsalas (
    id integer NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    nome character varying(160),
    endereco text,
    descricao text,
    salaaula integer DEFAULT 0,
    codigofuncionario character varying(30),
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL,
    capacidade character varying(4)
);


--
-- TOC entry 1748 (class 1259 OID 22514)
-- Dependencies: 1747 7
-- Name: dbsalas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbsalas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2499 (class 0 OID 0)
-- Dependencies: 1748
-- Name: dbsalas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dbsalas_id_seq OWNED BY dbsalas.id;


--
-- TOC entry 1749 (class 1259 OID 22516)
-- Dependencies: 7
-- Name: dbstatus; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbstatus (
    id integer NOT NULL,
    situacao character varying(180),
    obs text
);


--
-- TOC entry 1750 (class 1259 OID 22522)
-- Dependencies: 7 1749
-- Name: dbstatus_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbstatus_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2500 (class 0 OID 0)
-- Dependencies: 1750
-- Name: dbstatus_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dbstatus_id_seq OWNED BY dbstatus.id;


--
-- TOC entry 1751 (class 1259 OID 22524)
-- Dependencies: 2208 7
-- Name: dbteste; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbteste (
    id integer NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(20),
    codigoautor character varying(20),
    descricao character varying(80),
    datacad date,
    ativo character varying(2)
);


--
-- TOC entry 1752 (class 1259 OID 22528)
-- Dependencies: 1751 7
-- Name: dbteste_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbteste_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2501 (class 0 OID 0)
-- Dependencies: 1752
-- Name: dbteste_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dbteste_id_seq OWNED BY dbteste.id;


--
-- TOC entry 1753 (class 1259 OID 22530)
-- Dependencies: 2210 2211 2212 7
-- Name: dbtipos_movimentacao; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbtipos_movimentacao (
    id integer NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying,
    tipomovimentacao character varying(30),
    datacad date,
    ativo character varying(2) DEFAULT '9'::character varying
);


--
-- TOC entry 2502 (class 0 OID 0)
-- Dependencies: 1753
-- Name: TABLE dbtipos_movimentacao; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE dbtipos_movimentacao IS 'Domínio - Tipos de Movimentação de produtos

* Entrada
* Saida
* Transferencia
* Devolução
';


--
-- TOC entry 2503 (class 0 OID 0)
-- Dependencies: 1753
-- Name: COLUMN dbtipos_movimentacao.tipomovimentacao; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbtipos_movimentacao.tipomovimentacao IS 'Preço de vendo do produto';


--
-- TOC entry 1754 (class 1259 OID 22536)
-- Dependencies: 1753 7
-- Name: dbtipos_movimentacao_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbtipos_movimentacao_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2504 (class 0 OID 0)
-- Dependencies: 1754
-- Name: dbtipos_movimentacao_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dbtipos_movimentacao_id_seq OWNED BY dbtipos_movimentacao.id;


--
-- TOC entry 1755 (class 1259 OID 22538)
-- Dependencies: 2214 2215 2216 2217 7
-- Name: dbtransacoes; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbtransacoes (
    id integer NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying,
    codigocliente character varying(20),
    codigovendedor character varying(20),
    codigocondicaopagamento character varying(20),
    valortotal numeric(15,3),
    valordesconto numeric(15,3),
    obs text,
    datacad date DEFAULT '2010-11-10'::date,
    ativo character varying(2) DEFAULT '9'::character varying,
    codigotipotransacao character varying(20),
    valorfrete numeric(11,2),
    valordespesas numeric(11,2),
    valorjuros numeric(11,2),
    codigounidade character varying(20)
);


--
-- TOC entry 2505 (class 0 OID 0)
-- Dependencies: 1755
-- Name: TABLE dbtransacoes; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE dbtransacoes IS 'Trasações';


--
-- TOC entry 2506 (class 0 OID 0)
-- Dependencies: 1755
-- Name: COLUMN dbtransacoes.codigo; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbtransacoes.codigo IS 'Identificador de referencia da tabela para o kernelsys';


--
-- TOC entry 2507 (class 0 OID 0)
-- Dependencies: 1755
-- Name: COLUMN dbtransacoes.codigoautor; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbtransacoes.codigoautor IS 'Identificador do usuario responsavel pelo registro';


--
-- TOC entry 2508 (class 0 OID 0)
-- Dependencies: 1755
-- Name: COLUMN dbtransacoes.codigovendedor; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbtransacoes.codigovendedor IS 'Código do vendedor responsavel pelo pedido';


--
-- TOC entry 2509 (class 0 OID 0)
-- Dependencies: 1755
-- Name: COLUMN dbtransacoes.codigocondicaopagamento; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbtransacoes.codigocondicaopagamento IS 'Código da forma de pagamento do pedido';


--
-- TOC entry 2510 (class 0 OID 0)
-- Dependencies: 1755
-- Name: COLUMN dbtransacoes.valortotal; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbtransacoes.valortotal IS 'Valor total do pedido';


--
-- TOC entry 2511 (class 0 OID 0)
-- Dependencies: 1755
-- Name: COLUMN dbtransacoes.valordesconto; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbtransacoes.valordesconto IS 'Desconto a ser aplicado no valor total do pedido';


--
-- TOC entry 1756 (class 1259 OID 22548)
-- Dependencies: 7 1755
-- Name: dbtransacoes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbtransacoes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2512 (class 0 OID 0)
-- Dependencies: 1756
-- Name: dbtransacoes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dbtransacoes_id_seq OWNED BY dbtransacoes.id;


--
-- TOC entry 1757 (class 1259 OID 22550)
-- Dependencies: 2219 2220 2221 2222 7
-- Name: dbtransacoes_itens; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbtransacoes_itens (
    id integer NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying,
    codigotransacao character varying(20),
    codigoproduto character varying(20),
    quantidade bigint,
    valorunitario numeric(15,4),
    valordesconto numeric(15,3),
    valortotal numeric(15,4),
    valordescontototal numeric(15,3),
    obs text,
    datacad date DEFAULT '2010-11-10'::date,
    ativo character varying(2) DEFAULT '9'::character varying,
    codigoprodutounidade character varying(20)
);


--
-- TOC entry 2513 (class 0 OID 0)
-- Dependencies: 1757
-- Name: TABLE dbtransacoes_itens; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE dbtransacoes_itens IS 'Itens da Transação';


--
-- TOC entry 2514 (class 0 OID 0)
-- Dependencies: 1757
-- Name: COLUMN dbtransacoes_itens.codigo; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbtransacoes_itens.codigo IS 'Identificador de referencia da tabela para o kernelsys';


--
-- TOC entry 2515 (class 0 OID 0)
-- Dependencies: 1757
-- Name: COLUMN dbtransacoes_itens.codigoautor; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbtransacoes_itens.codigoautor IS 'Identificador do usuario responsavel pelo registro';


--
-- TOC entry 2516 (class 0 OID 0)
-- Dependencies: 1757
-- Name: COLUMN dbtransacoes_itens.codigotransacao; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbtransacoes_itens.codigotransacao IS 'Código do pedido';


--
-- TOC entry 2517 (class 0 OID 0)
-- Dependencies: 1757
-- Name: COLUMN dbtransacoes_itens.codigoproduto; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbtransacoes_itens.codigoproduto IS 'Código do produto';


--
-- TOC entry 2518 (class 0 OID 0)
-- Dependencies: 1757
-- Name: COLUMN dbtransacoes_itens.quantidade; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbtransacoes_itens.quantidade IS 'Quantidade do item';


--
-- TOC entry 2519 (class 0 OID 0)
-- Dependencies: 1757
-- Name: COLUMN dbtransacoes_itens.valorunitario; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbtransacoes_itens.valorunitario IS 'Valor Unitário do item (Campo não editavel)';


--
-- TOC entry 2520 (class 0 OID 0)
-- Dependencies: 1757
-- Name: COLUMN dbtransacoes_itens.valordesconto; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbtransacoes_itens.valordesconto IS 'Valor do desconto unitário';


--
-- TOC entry 2521 (class 0 OID 0)
-- Dependencies: 1757
-- Name: COLUMN dbtransacoes_itens.valortotal; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbtransacoes_itens.valortotal IS 'Valor total do item';


--
-- TOC entry 2522 (class 0 OID 0)
-- Dependencies: 1757
-- Name: COLUMN dbtransacoes_itens.valordescontototal; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbtransacoes_itens.valordescontototal IS 'Valor de desconto sobre a soma total dos valores unitários dos itens';


--
-- TOC entry 1758 (class 1259 OID 22560)
-- Dependencies: 1757 7
-- Name: dbtransacoes_itens_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbtransacoes_itens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2523 (class 0 OID 0)
-- Dependencies: 1758
-- Name: dbtransacoes_itens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dbtransacoes_itens_id_seq OWNED BY dbtransacoes_itens.id;


--
-- TOC entry 1759 (class 1259 OID 22562)
-- Dependencies: 2224 2225 2226 2227 7
-- Name: dbtransacoes_tipos; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbtransacoes_tipos (
    id integer NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    tipotransacao character varying(160),
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 1760 (class 1259 OID 22569)
-- Dependencies: 7 1759
-- Name: dbtransacoes_tipos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbtransacoes_tipos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2524 (class 0 OID 0)
-- Dependencies: 1760
-- Name: dbtransacoes_tipos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dbtransacoes_tipos_id_seq OWNED BY dbtransacoes_tipos.id;


--
-- TOC entry 1761 (class 1259 OID 22571)
-- Dependencies: 2229 2230 2231 2232 7
-- Name: dbunidades; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbunidades (
    id integer NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
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
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL,
    tipounidade character varying(2)
);


--
-- TOC entry 1762 (class 1259 OID 22581)
-- Dependencies: 7 1761
-- Name: dbunidades_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbunidades_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2525 (class 0 OID 0)
-- Dependencies: 1762
-- Name: dbunidades_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dbunidades_id_seq OWNED BY dbunidades.id;


--
-- TOC entry 1763 (class 1259 OID 22583)
-- Dependencies: 2234 2235 2236 2237 7
-- Name: dbunidades_parametros; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbunidades_parametros (
    id integer NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    parametro character varying(60),
    valor character varying(180),
    obs text,
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 1764 (class 1259 OID 22593)
-- Dependencies: 7 1763
-- Name: dbunidades_parametros_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbunidades_parametros_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2526 (class 0 OID 0)
-- Dependencies: 1764
-- Name: dbunidades_parametros_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dbunidades_parametros_id_seq OWNED BY dbunidades_parametros.id;


--
-- TOC entry 1765 (class 1259 OID 22595)
-- Dependencies: 2239 2240 2241 2242 2243 2244 7
-- Name: dbusuarios; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbusuarios (
    id integer NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    classeuser character varying(20),
    codigopessoa character varying(30),
    usuario character varying(80) DEFAULT 'user'::character varying NOT NULL,
    senha character varying(60),
    entidadepai character varying(255),
    codigotema character varying(20) DEFAULT '0'::character varying NOT NULL,
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL,
    lastip character varying(80),
    lastaccess character varying(30)
);


--
-- TOC entry 1766 (class 1259 OID 22607)
-- Dependencies: 2246 2247 2248 2249 7
-- Name: dbusuarios_erros; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbusuarios_erros (
    id integer NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    codigousuario character varying(30),
    classe character varying(250) NOT NULL,
    msg text,
    horacad time without time zone NOT NULL,
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 1767 (class 1259 OID 22617)
-- Dependencies: 1766 7
-- Name: dbusuarios_erros_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbusuarios_erros_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2527 (class 0 OID 0)
-- Dependencies: 1767
-- Name: dbusuarios_erros_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dbusuarios_erros_id_seq OWNED BY dbusuarios_erros.id;


--
-- TOC entry 1768 (class 1259 OID 22619)
-- Dependencies: 2251 2252 2253 2254 7
-- Name: dbusuarios_historico; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbusuarios_historico (
    id integer NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    codigousuario character varying(30),
    dataac character varying(10),
    horaac character varying(8),
    acao text,
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 1769 (class 1259 OID 22629)
-- Dependencies: 7 1768
-- Name: dbusuarios_historico_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbusuarios_historico_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2528 (class 0 OID 0)
-- Dependencies: 1769
-- Name: dbusuarios_historico_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dbusuarios_historico_id_seq OWNED BY dbusuarios_historico.id;


--
-- TOC entry 1770 (class 1259 OID 22631)
-- Dependencies: 1765 7
-- Name: dbusuarios_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbusuarios_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2529 (class 0 OID 0)
-- Dependencies: 1770
-- Name: dbusuarios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dbusuarios_id_seq OWNED BY dbusuarios.id;


--
-- TOC entry 1771 (class 1259 OID 22633)
-- Dependencies: 2256 2257 2258 2259 2260 2261 7
-- Name: dbusuarios_privilegios; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbusuarios_privilegios (
    id integer NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    codigousuario character varying(30),
    funcionalidade integer DEFAULT 0,
    modulo integer,
    nivel integer DEFAULT 0 NOT NULL,
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 2530 (class 0 OID 0)
-- Dependencies: 1771
-- Name: COLUMN dbusuarios_privilegios.funcionalidade; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbusuarios_privilegios.funcionalidade IS 'Id da funcionalidade sobre a qual o privilegio se associa.
Caso a funcionalidade seja o modulo principal o valor padrão é [0]';


--
-- TOC entry 2531 (class 0 OID 0)
-- Dependencies: 1771
-- Name: COLUMN dbusuarios_privilegios.nivel; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbusuarios_privilegios.nivel IS 'Nivel de acesso na hierarquia do sistema

0 = módulo principal
1 = módulos secundários
2 = opções da lista
       1 = adicionar
       2 = editar
       3 = excluir

9 = Opções de sublista
       1 = adicionar
       2 = editar
       3 = excluir


';


--
-- TOC entry 1772 (class 1259 OID 22642)
-- Dependencies: 1771 7
-- Name: dbusuarios_privilegios_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbusuarios_privilegios_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2532 (class 0 OID 0)
-- Dependencies: 1772
-- Name: dbusuarios_privilegios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dbusuarios_privilegios_id_seq OWNED BY dbusuarios_privilegios.id;


--
-- TOC entry 1773 (class 1259 OID 22644)
-- Dependencies: 2263 2264 2265 2266 7
-- Name: tab_balancocontadorconferente; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE tab_balancocontadorconferente (
    id integer NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    blccseq bigint,
    balaseq bigint,
    pesscont bigint,
    pessconf bigint,
    blccapel character varying(12),
    contador character varying(60),
    conferente character varying(60),
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 1774 (class 1259 OID 22651)
-- Dependencies: 7 1773
-- Name: tab_balancocontadorconferente_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE tab_balancocontadorconferente_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2533 (class 0 OID 0)
-- Dependencies: 1774
-- Name: tab_balancocontadorconferente_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE tab_balancocontadorconferente_id_seq OWNED BY tab_balancocontadorconferente.id;


--
-- TOC entry 1775 (class 1259 OID 22653)
-- Dependencies: 2268 2269 2270 2271 7
-- Name: tab_historicobalancoalteracao; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE tab_historicobalancoalteracao (
    id integer NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    hsbaseq integer NOT NULL,
    cod_mer character varying(20) NOT NULL,
    marca_mer character varying(80) NOT NULL,
    estoque_fisico numeric(14,2) NOT NULL,
    nova_qtd numeric(14,2) NOT NULL,
    blepseq bigint,
    hsbadtlg date,
    hsbahrlg time with time zone,
    usuario bigint,
    operacao character varying(20),
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 1776 (class 1259 OID 22660)
-- Dependencies: 1775 7
-- Name: tab_historicobalancoalteracao_hsbaseq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE tab_historicobalancoalteracao_hsbaseq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2534 (class 0 OID 0)
-- Dependencies: 1776
-- Name: tab_historicobalancoalteracao_hsbaseq_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE tab_historicobalancoalteracao_hsbaseq_seq OWNED BY tab_historicobalancoalteracao.hsbaseq;


--
-- TOC entry 1777 (class 1259 OID 22662)
-- Dependencies: 7 1775
-- Name: tab_historicobalancoalteracao_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE tab_historicobalancoalteracao_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2535 (class 0 OID 0)
-- Dependencies: 1777
-- Name: tab_historicobalancoalteracao_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE tab_historicobalancoalteracao_id_seq OWNED BY tab_historicobalancoalteracao.id;


--
-- TOC entry 1778 (class 1259 OID 22664)
-- Dependencies: 7
-- Name: tab_marcas; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE tab_marcas (
    codigo character varying(3),
    marca character varying(20)
);


--
-- TOC entry 1779 (class 1259 OID 22667)
-- Dependencies: 2274 2275 2276 2277 7
-- Name: tab_produto; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE tab_produto (
    id integer NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying,
    descricao character varying(80),
    referencia character varying(80),
    unidademedida character varying(80),
    observacao text,
    marca character varying(80),
    custo numeric(11,4),
    preco numeric(11,4),
    codigounidade character varying(30),
    endereco character varying(160),
    sinonimos text,
    datacad date DEFAULT '2010-11-09'::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL,
    quantidadedisponivel numeric(11,4),
    quantidadereservada numeric(11,4),
    codigosit character varying(20),
    codigomarca character varying(3),
    codigosdg character varying(30),
    ref character varying(30)
);


--
-- TOC entry 1780 (class 1259 OID 22677)
-- Dependencies: 7 1779
-- Name: tab_produto_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE tab_produto_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2536 (class 0 OID 0)
-- Dependencies: 1780
-- Name: tab_produto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE tab_produto_id_seq OWNED BY tab_produto.id;


--
-- TOC entry 1781 (class 1259 OID 22679)
-- Dependencies: 2279 2280 2281 2282 7
-- Name: tab_produto_similar; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE tab_produto_similar (
    id integer NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying,
    codigoproduto character varying(30),
    codigoprodutosimilar character varying(30),
    datacad date DEFAULT '2010-11-09'::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 1782 (class 1259 OID 22686)
-- Dependencies: 1781 7
-- Name: tab_produto_similar_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE tab_produto_similar_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2537 (class 0 OID 0)
-- Dependencies: 1782
-- Name: tab_produto_similar_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE tab_produto_similar_id_seq OWNED BY tab_produto_similar.id;


--
-- TOC entry 1783 (class 1259 OID 22688)
-- Dependencies: 7
-- Name: tm; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE tm (
    codigo_sit character varying(8),
    codigo_marca character varying(3),
    preco numeric(14,2),
    referencia character varying(16),
    unidade character varying(3),
    endereco character varying(6)
);


--
-- TOC entry 1784 (class 1259 OID 22691)
-- Dependencies: 1887 7
-- Name: view_condicoes_pagamento_pessoa; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_condicoes_pagamento_pessoa AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigoformapagamento)::text AS codigoformapagamento, (t1.codigopessoa)::text AS codigopessoa, (t2.nome_razaosocial)::text AS nomefuncionario, (t3.descricao)::text AS descricao, (t3.parcelas)::text AS parcelas, (t3.intervalo)::text AS intervalo, (t3.entrada)::text AS entrada, t3.obs, (t3.juros)::text AS juros, (t3.indice)::text AS indice, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (((dbcondicoes_pagamento_pessoa t1 LEFT JOIN dbcondicoes_pagamento t3 ON (((t3.codigo)::text = (t1.codigoformapagamento)::text))) LEFT JOIN dbpessoas t2 ON (((t2.codigo)::text = (t1.codigopessoa)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 1785 (class 1259 OID 22696)
-- Dependencies: 1888 7
-- Name: view_patrimonios; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_patrimonios AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigofuncionario)::text AS codigofuncionario, (t1.codigoproduto)::text AS codigoproduto, (t1.modelo)::text AS modelo, (t1.marca)::text AS marca, (t1.label)::text AS label, (t1.descricao)::text AS descricao, (t1.tipo)::text AS tipo, (t1.datafabricacao)::text AS datafabricacao, (t1.dataaquisicao)::text AS dataaquisicao, (t1.valornominal)::text AS valornominal, (t1.lotacao)::text AS lotacao, (t1.valorcompra)::text AS valorcompra, (t1.numnf)::text AS numnf, (t1.dataverificacao)::text AS dataverificacao, t1.obs, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t2.nomeunidade)::text AS nomeunidade, (t3.nome)::text AS nomesala FROM (((dbpatrimonios t1 LEFT JOIN dbunidades t2 ON (((t2.codigo)::text = (t1.unidade)::text))) LEFT JOIN dbsalas t3 ON (((t3.codigo)::text = (t1.lotacao)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 1786 (class 1259 OID 22701)
-- Dependencies: 1889 7
-- Name: view_pessoas; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_pessoas AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.tipo)::text AS tipo, (t1.nome_razaosocial)::text AS nome_razaosocial, (t1.cpf_cnpj)::text AS cpf_cnpj, (t1.rg_inscest)::text AS rg_inscest, (t1.titeleitor_inscmun)::text AS titeleitor_inscmun, t1.logradouro, (t1.bairro)::text AS bairro, (t1.cidade)::text AS cidade, (t1.estado)::text AS estado, (t1.cep)::text AS cep, (t1.caixapostal)::text AS caixapostal, (t1.referencia)::text AS referencia, (t1.tel1)::text AS tel1, (t1.tel2)::text AS tel2, (t1.cel1)::text AS cel1, (t1.cel2)::text AS cel2, (t1.email1)::text AS email1, (t1.email2)::text AS email2, (t1.site)::text AS site, (t1.opcobranca)::text AS opcobranca, (t1.cliente)::text AS cliente, (t1.fornecedor)::text AS fornecedor, (t1.funcionario)::text AS funcionario, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbpessoas t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 1787 (class 1259 OID 22706)
-- Dependencies: 1890 7
-- Name: view_pessoas_complemento_pf; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_pessoas_complemento_pf AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigopessoa)::text AS codigopessoa, (t1.estadocivil)::text AS estadocivil, (t1.etinia)::text AS etinia, (t1.datanasc)::text AS datanasc, (t1.sexo)::text AS sexo, (t1.tiposanguineo)::text AS tiposanguineo, (t1.nacionalidade)::text AS nacionalidade, (t1.portadornecessidades)::text AS portadornecessidades, t1.necessidadesespeciais, (t1.numerodependentes)::text AS numerodependentes, (t1.cnh)::text AS cnh, (t1.carteirareservista)::text AS carteirareservista, (t1.rendamensal)::text AS rendamensal, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbpessoas_complemento_pf t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 1788 (class 1259 OID 22711)
-- Dependencies: 1891 7
-- Name: view_pessoas_complemento_pj; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_pessoas_complemento_pj AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigopessoa)::text AS codigopessoa, (t1.datafundacao)::text AS datafundacao, (t1.gerente)::text AS gerente, (t1.diretor)::text AS diretor, (t1.representante)::text AS representante, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbpessoas_complemento_pj t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 1789 (class 1259 OID 22715)
-- Dependencies: 1892 7
-- Name: view_pessoas_formacoes; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_pessoas_formacoes AS
    SELECT t0.id, (t0.codigo)::text AS codigo, (t0.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, (t0.codigopessoa)::text AS codigopessoa, (t0.codigotitularidade)::text AS codigotitularidade, (t0.curso)::text AS curso, (t0.instituicao)::text AS instituicao, (t0.anoconclusao)::text AS anoconclusao, t0.observacao, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t3.nome_razaosocial)::text AS nomepessoa, (t2.titularidade)::text AS titularidade, (t2.nomeacao)::text AS nomeacao, (t2.peso)::text AS peso FROM (((dbpessoas_formacoes t0 LEFT JOIN dbpessoas_titularidades t2 ON (((t2.codigo)::text = (t0.codigotitularidade)::text))) LEFT JOIN dbpessoas t3 ON (((t3.codigo)::text = (t0.codigopessoa)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t0.ativo)::text)));


--
-- TOC entry 1790 (class 1259 OID 22720)
-- Dependencies: 1893 7
-- Name: view_pessoas_funcionarios; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_pessoas_funcionarios AS
    SELECT t0.id, (t2.codigo)::text AS codigofuncionario, (t0.unidade)::text AS unidade, (t0.codigo)::text AS codigo, (t0.nome_razaosocial)::text AS nomefuncionario, (t0.cpf_cnpj)::text AS cpf_cnpj, (t2.codigocargo)::text AS codigocargo, (t3.nomecargo)::text AS nomecargo, (t2.codigodepartamento)::text AS codigodepartamento, (t4.label)::text AS nomedepartamento, (t2.lotacao)::text AS lotacao, (t5.nome)::text AS nomesala, to_char((t2.dataadmissao)::timestamp with time zone, 'DD/MM/YYYY'::text) AS dataadmissao, (t2.ativo)::text AS situacao, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (((((dbpessoas t0 LEFT JOIN dbpessoas_funcionarios t2 ON (((t2.codigopessoa)::text = (t0.codigo)::text))) LEFT JOIN dbcargos t3 ON (((t3.codigo)::text = (t2.codigocargo)::text))) LEFT JOIN dbdepartamentos t4 ON (((t4.codigo)::text = (t2.codigodepartamento)::text))) LEFT JOIN dbsalas t5 ON (((t5.codigo)::text = (t2.lotacao)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t0.ativo)::text))) WHERE ((t0.codigo)::text = (t2.codigopessoa)::text);


--
-- TOC entry 1791 (class 1259 OID 22725)
-- Dependencies: 1894 7
-- Name: view_produtos; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_produtos AS
    SELECT t0.id, (t0.codigo)::text AS codigo, (t0.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, t0.codigoprodutotipo, t0.codigocomportamentofiscal, t0.produto, t0.descricao, t0.estoqueminimo, t0.estoquemaximo, t0.obs, (SELECT min(temp1.valorunitario) AS min FROM dbprodutos_movimentacao temp1 WHERE (((temp1.codigoproduto)::text = (t0.codigo)::text) AND ((temp1.codigotipomovimentacao)::text = '10000158-258'::text))) AS valorminimo, (SELECT max(temp2.valorunitario) AS max FROM dbprodutos_movimentacao temp2 WHERE (((temp2.codigoproduto)::text = (t0.codigo)::text) AND ((temp2.codigotipomovimentacao)::text = '10000158-258'::text))) AS valormaximo, round((SELECT avg(temp3.valorunitario) AS max FROM dbprodutos_movimentacao temp3 WHERE (((temp3.codigoproduto)::text = (t0.codigo)::text) AND ((temp3.codigotipomovimentacao)::text = '10000158-258'::text))), 2) AS valormedio, (GREATEST((0)::numeric, (SELECT sum(dbprodutos_movimentacao.quantidade) AS sum FROM dbprodutos_movimentacao WHERE (((dbprodutos_movimentacao.codigotipomovimentacao)::text = '10000160-260'::text) AND ((dbprodutos_movimentacao.codigoproduto)::text = (t0.codigo)::text)))))::bigint AS quantidadereservada, ((((GREATEST((0)::numeric, (SELECT sum(dbprodutos_movimentacao.quantidade) AS sum FROM dbprodutos_movimentacao WHERE (((dbprodutos_movimentacao.codigotipomovimentacao)::text = '10000158-258'::text) AND ((dbprodutos_movimentacao.codigoproduto)::text = (t0.codigo)::text)))))::bigint - (GREATEST((0)::numeric, (SELECT sum(dbprodutos_movimentacao.quantidade) AS sum FROM dbprodutos_movimentacao WHERE (((dbprodutos_movimentacao.codigotipomovimentacao)::text = '10000159-259'::text) AND ((dbprodutos_movimentacao.codigoproduto)::text = (t0.codigo)::text)))))::bigint) + (GREATEST((0)::numeric, (SELECT sum(dbprodutos_movimentacao.quantidade) AS sum FROM dbprodutos_movimentacao WHERE (((dbprodutos_movimentacao.codigotipomovimentacao)::text = '10000162-262'::text) AND ((dbprodutos_movimentacao.codigoproduto)::text = (t0.codigo)::text)))))::bigint) - (GREATEST((0)::numeric, (SELECT sum(dbprodutos_movimentacao.quantidade) AS sum FROM dbprodutos_movimentacao WHERE (((dbprodutos_movimentacao.codigotipomovimentacao)::text = '10000160-260'::text) AND ((dbprodutos_movimentacao.codigoproduto)::text = (t0.codigo)::text)))))::bigint) AS quantidadedisponivel, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbprodutos t0 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t0.ativo)::text)));


--
-- TOC entry 1792 (class 1259 OID 22730)
-- Dependencies: 1895 7
-- Name: view_produtos_movimentacao; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_produtos_movimentacao AS
    SELECT (t0.id)::text AS id, (t0.codigo)::text AS codigo, (t0.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, (t0.codigoproduto)::text AS codigoproduto, (t1.descricao)::text AS produto, (t0.quantidade)::text AS quantidade, (t0.codigotipomovimentacao)::text AS codigotipomovimentacao, (t2.tipomovimentacao)::text AS tipomovimentacao, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, t0.codigoprodutounidade FROM (((dbprodutos_movimentacao t0 LEFT JOIN tab_produto t1 ON (((t1.codigo)::text = ((SELECT dbprodutos_unidade.codigoproduto FROM dbprodutos_unidade WHERE ((dbprodutos_unidade.codigo)::text = (t0.codigoprodutounidade)::text)))::text))) LEFT JOIN dbtipos_movimentacao t2 ON (((t2.codigo)::text = (t0.codigotipomovimentacao)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t0.ativo)::text)));


--
-- TOC entry 1793 (class 1259 OID 22735)
-- Dependencies: 1896 7
-- Name: view_produtos_unidade; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_produtos_unidade AS
    SELECT (t0.id)::text AS id, (t0.codigo)::text AS codigo, (t0.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, (t0.codigoproduto)::text AS codigoproduto, (t1.descricao)::text AS produto, (t0.codigounidade)::text AS codigounidade, (t20.nomeunidade)::text AS empresa, (t0.quantidadeinicial)::text AS quantidadeinicial, (t0.custo)::text AS custo, (t0.preco)::text AS preco, (t0.endereco)::text AS endereco, t0.obs, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (((dbprodutos_unidade t0 LEFT JOIN tab_produto t1 ON (((t1.codigo)::text = (t0.codigoproduto)::text))) LEFT JOIN dbunidades t20 ON (((t20.codigo)::text = (t0.codigounidade)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t0.ativo)::text)));


--
-- TOC entry 1794 (class 1259 OID 22740)
-- Dependencies: 1897 7
-- Name: view_tab_cad_produto; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_tab_cad_produto AS
    SELECT (t0.id)::text AS id, (t0.codigo)::text AS codigo, (t0.codigo)::text AS codigoproduto, (t0.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, (t0.descricao)::text AS descricao, (t0.referencia)::text AS referencia, (t7.unidademedida)::text AS unidademedida, t0.observacao, t0.sinonimos, (t0.codigosit)::text AS codigosit, (t0.codigomarca)::text AS codigomarca, (t8.marca)::text AS marca, (t0.codigosdg)::text AS codigosdg, (t0.ref)::text AS ref, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (((tab_produto t0 LEFT JOIN tab_marcas t8 ON (((t8.codigo)::text = (t0.codigomarca)::text))) LEFT JOIN dominio.dbunidade_medida t7 ON (((t7.codigo)::text = (t0.unidademedida)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t0.ativo)::text)));


--
-- TOC entry 1795 (class 1259 OID 22745)
-- Dependencies: 1898 7
-- Name: view_tab_produto; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_tab_produto AS
    SELECT (t0.id)::text AS id, (t0.codigo)::text AS codigo, (t0.codigo)::text AS codigoproduto, (t0.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, (t0.descricao)::text AS descricao, (t0.referencia)::text AS referencia, (t7.unidademedida)::text AS unidademedida, t0.observacao, (t1.custo)::text AS custo, (t1.preco)::text AS preco, (t1.codigounidade)::text AS codigounidade, (t20.nomeunidade)::text AS empresa, (t1.endereco)::text AS endereco, t0.sinonimos, (t0.codigosit)::text AS codigosit, (t0.codigomarca)::text AS codigomarca, (t8.marca)::text AS marca, (t0.codigosdg)::text AS codigosdg, (t0.ref)::text AS ref, (round((SELECT avg(temp3.valorunitario) AS max FROM dbprodutos_movimentacao temp3 WHERE (((temp3.codigoprodutounidade)::text = (t1.codigo)::text) AND ((temp3.codigotipomovimentacao)::text = '10000158-258'::text))), 3))::text AS valormedio, ((GREATEST((0)::numeric, (SELECT sum(dbprodutos_movimentacao.quantidade) AS sum FROM dbprodutos_movimentacao WHERE (((dbprodutos_movimentacao.codigotipomovimentacao)::text = '10000160-260'::text) AND ((dbprodutos_movimentacao.codigoprodutounidade)::text = (t1.codigo)::text)))))::bigint)::text AS quantidadereservada, ((((((GREATEST((0)::numeric, (SELECT sum(dbprodutos_movimentacao.quantidade) AS sum FROM dbprodutos_movimentacao WHERE (((dbprodutos_movimentacao.codigotipomovimentacao)::text = '10000158-258'::text) AND ((dbprodutos_movimentacao.codigoprodutounidade)::text = (t1.codigo)::text)))))::bigint - (GREATEST((0)::numeric, (SELECT sum(dbprodutos_movimentacao.quantidade) AS sum FROM dbprodutos_movimentacao WHERE (((dbprodutos_movimentacao.codigotipomovimentacao)::text = '10000159-259'::text) AND ((dbprodutos_movimentacao.codigoprodutounidade)::text = (t1.codigo)::text)))))::bigint) + (GREATEST((0)::numeric, (SELECT sum(dbprodutos_movimentacao.quantidade) AS sum FROM dbprodutos_movimentacao WHERE (((dbprodutos_movimentacao.codigotipomovimentacao)::text = '10000162-262'::text) AND ((dbprodutos_movimentacao.codigoprodutounidade)::text = (t1.codigo)::text)))))::bigint) - (GREATEST((0)::numeric, (SELECT sum(dbprodutos_movimentacao.quantidade) AS sum FROM dbprodutos_movimentacao WHERE (((dbprodutos_movimentacao.codigotipomovimentacao)::text = '10000160-260'::text) AND ((dbprodutos_movimentacao.codigoprodutounidade)::text = (t1.codigo)::text)))))::bigint) + (t1.quantidadeinicial)::bigint))::text AS quantidadedisponivel, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, ((t0.preco - t0.custo))::text AS lucro, (t1.codigo)::text AS codigoprodutounidade FROM (((((dbprodutos_unidade t1 LEFT JOIN tab_produto t0 ON (((t0.codigo)::text = (t1.codigoproduto)::text))) LEFT JOIN tab_marcas t8 ON (((t8.codigo)::text = (t0.codigomarca)::text))) LEFT JOIN dominio.dbunidade_medida t7 ON (((t7.codigo)::text = (t0.unidademedida)::text))) LEFT JOIN dbunidades t20 ON (((t20.codigo)::text = (t1.codigounidade)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t0.ativo)::text)));


--
-- TOC entry 1796 (class 1259 OID 22750)
-- Dependencies: 1899 7
-- Name: view_tab_produto_similar; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_tab_produto_similar AS
    SELECT t0.id, (t0.codigo)::text AS codigo, (t0.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, (t0.codigoproduto)::text AS codigoproduto, (t0.codigoprodutosimilar)::text AS codigoprodutosimilar, (t1.descricao)::text AS produto, (t2.descricao)::text AS produtosimilar, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (((tab_produto_similar t0 LEFT JOIN tab_produto t1 ON (((t1.codigo)::text = (t0.codigoproduto)::text))) LEFT JOIN tab_produto t2 ON (((t2.codigo)::text = (t0.codigoprodutosimilar)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t0.ativo)::text)));


--
-- TOC entry 1797 (class 1259 OID 22755)
-- Dependencies: 1900 7
-- Name: view_transacoes; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_transacoes AS
    SELECT t0.id, (t0.codigo)::text AS codigo, (t0.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, (t0.codigocliente)::text AS codigocliente, (t0.codigocondicaopagamento)::text AS codigoformapagamento, (t0.valortotal)::text AS valortotal, (t0.valordesconto)::text AS valordesconto, t0.obs, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t2.nome_razaosocial)::text AS cliente, (t3.nome_razaosocial)::text AS vendedor, (t1.descricao)::text AS condicaopagamento, (t0.codigotipotransacao)::text AS codigotipotransacao, (t4.tipotransacao)::text AS tipotransacao, (t0.valordespesas)::text AS valordespesas, (t1.indice)::text AS indice, t0.valorfrete FROM (((((dbtransacoes t0 LEFT JOIN dbcondicoes_pagamento t1 ON (((t1.codigo)::text = (t0.codigocondicaopagamento)::text))) LEFT JOIN dbpessoas t2 ON (((t2.codigo)::text = (t0.codigocliente)::text))) LEFT JOIN dbpessoas t3 ON (((t3.codigo)::text = ((SELECT dbpessoas_funcionarios.codigopessoa FROM dbpessoas_funcionarios WHERE ((dbpessoas_funcionarios.codigo)::text = (t0.codigovendedor)::text)))::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t0.ativo)::text))) LEFT JOIN dbtransacoes_tipos t4 ON (((t4.codigo)::text = (t0.codigotipotransacao)::text)));


--
-- TOC entry 1798 (class 1259 OID 22760)
-- Dependencies: 1901 7
-- Name: view_transacoes_itens; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_transacoes_itens AS
    SELECT t0.id, (t0.codigo)::text AS codigo, (t0.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, (t0.codigotransacao)::text AS codigotransacao, (t2.codigo)::text AS codigoproduto, (t2.descricao)::text AS produto, (t0.quantidade)::text AS quantidade, (t0.valorunitario)::text AS valorunitario, (t0.valordesconto)::text AS valordesconto, (t0.valortotal)::text AS valortotal, (t0.valordescontototal)::text AS valordescontototal, t0.obs, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t3.abreviacao)::text AS unidademedida, (t2.marca)::text AS marca, (t2.codigosit)::text AS codigosit, t0.codigoprodutounidade FROM (((dbtransacoes_itens t0 LEFT JOIN tab_produto t2 ON (((t2.codigo)::text = ((SELECT dbprodutos_unidade.codigoproduto FROM dbprodutos_unidade WHERE ((dbprodutos_unidade.codigo)::text = (t0.codigoprodutounidade)::text)))::text))) LEFT JOIN dominio.dbunidade_medida t3 ON (((t3.codigo)::text = (t2.unidademedida)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t0.ativo)::text)));


--
-- TOC entry 1799 (class 1259 OID 22765)
-- Dependencies: 1902 7
-- Name: view_unidades; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_unidades AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.nomeunidade)::text AS nomeunidade, (t1.razaosocial)::text AS razaosocial, (t1.cnpj)::text AS cnpj, (t1.inscestadual)::text AS inscestadual, (t1.inscmunicipal)::text AS inscmunicipal, (t1.gerente)::text AS gerente, (t1.diretor)::text AS diretor, (t1.representante)::text AS representante, (t1.logradouro)::text AS logradouro, (t1.bairro)::text AS bairro, (t1.cidade)::text AS cidade, (t1.estado)::text AS estado, (t1.cep)::text AS cep, (t1.email)::text AS email, (t1.telefone)::text AS telefone, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbunidades t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 1800 (class 1259 OID 22770)
-- Dependencies: 1903 7
-- Name: view_usuarios; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_usuarios AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.classeuser)::text AS classeuser, (t1.codigopessoa)::text AS codigopessoa, (t2.nome_razaosocial)::text AS nomepessoa, (t1.usuario)::text AS usuario, (t1.senha)::text AS senha, (t1.entidadepai)::text AS entidadepai, (t1.codigotema)::text AS codigotema, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM ((dbusuarios t1 LEFT JOIN dbpessoas t2 ON (((t2.codigo)::text = (t1.codigopessoa)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


SET search_path = dominio, pg_catalog;

--
-- TOC entry 2095 (class 2604 OID 22775)
-- Dependencies: 1694 1693
-- Name: id; Type: DEFAULT; Schema: dominio; Owner: -
--

ALTER TABLE dbceps ALTER COLUMN id SET DEFAULT nextval('dbceps_id_seq'::regclass);


--
-- TOC entry 2096 (class 2604 OID 22776)
-- Dependencies: 1696 1695
-- Name: id; Type: DEFAULT; Schema: dominio; Owner: -
--

ALTER TABLE dbcidades ALTER COLUMN id SET DEFAULT nextval('dbcidades_id_seq'::regclass);


--
-- TOC entry 2097 (class 2604 OID 22777)
-- Dependencies: 1698 1697
-- Name: id; Type: DEFAULT; Schema: dominio; Owner: -
--

ALTER TABLE dbestados ALTER COLUMN id SET DEFAULT nextval('dbestados_id_seq'::regclass);


--
-- TOC entry 2098 (class 2604 OID 22778)
-- Dependencies: 1701 1699
-- Name: id; Type: DEFAULT; Schema: dominio; Owner: -
--

ALTER TABLE dbnfe_erros ALTER COLUMN id SET DEFAULT nextval('dbnfe_erros_id_seq'::regclass);


--
-- TOC entry 2099 (class 2604 OID 22779)
-- Dependencies: 1704 1703
-- Name: id; Type: DEFAULT; Schema: dominio; Owner: -
--

ALTER TABLE dbpaises ALTER COLUMN id SET DEFAULT nextval('dbpaises_id_seq'::regclass);


--
-- TOC entry 2104 (class 2604 OID 22780)
-- Dependencies: 1708 1707
-- Name: id; Type: DEFAULT; Schema: dominio; Owner: -
--

ALTER TABLE dbunidade_medida ALTER COLUMN id SET DEFAULT nextval('dbunidade_medida_id_seq'::regclass);


--
-- TOC entry 2105 (class 2604 OID 22781)
-- Dependencies: 1712 1709
-- Name: id; Type: DEFAULT; Schema: dominio; Owner: -
--

ALTER TABLE dbwebservices ALTER COLUMN id SET DEFAULT nextval('dbwebservices_id_seq'::regclass);


--
-- TOC entry 2106 (class 2604 OID 22782)
-- Dependencies: 1711 1710
-- Name: id; Type: DEFAULT; Schema: dominio; Owner: -
--

ALTER TABLE dbwebservices_campos ALTER COLUMN id SET DEFAULT nextval('dbwebservices_campos_id_seq'::regclass);


SET search_path = public, pg_catalog;

--
-- TOC entry 2112 (class 2604 OID 22783)
-- Dependencies: 1714 1713
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE dbcargos ALTER COLUMN id SET DEFAULT nextval('dbcargos_id_seq'::regclass);


--
-- TOC entry 2117 (class 2604 OID 22784)
-- Dependencies: 1716 1715
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE dbcomportamento_fiscal ALTER COLUMN id SET DEFAULT nextval('dbcomportamento_fiscal_id_seq'::regclass);


--
-- TOC entry 2122 (class 2604 OID 22785)
-- Dependencies: 1718 1717
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE dbcondicoes_pagamento ALTER COLUMN id SET DEFAULT nextval('dbcondicoes_pagamento_id_seq'::regclass);


--
-- TOC entry 2127 (class 2604 OID 22786)
-- Dependencies: 1720 1719
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE dbcondicoes_pagamento_pessoa ALTER COLUMN id SET DEFAULT nextval('dbcondicoes_pagamento_pessoa_id_seq'::regclass);


--
-- TOC entry 2132 (class 2604 OID 22787)
-- Dependencies: 1722 1721
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE dbdepartamentos ALTER COLUMN id SET DEFAULT nextval('dbdepartamentos_id_seq'::regclass);


--
-- TOC entry 2139 (class 2604 OID 22788)
-- Dependencies: 1726 1723
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE dbpatrimonios ALTER COLUMN id SET DEFAULT nextval('dbpatrimonios_id_seq'::regclass);


--
-- TOC entry 2144 (class 2604 OID 22789)
-- Dependencies: 1725 1724
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE dbpatrimonios_fotos ALTER COLUMN id SET DEFAULT nextval('dbpatrimonios_fotos_id_seq'::regclass);


--
-- TOC entry 2154 (class 2604 OID 22790)
-- Dependencies: 1736 1727
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE dbpessoas ALTER COLUMN id SET DEFAULT nextval('dbpessoas_id_seq'::regclass);


--
-- TOC entry 2159 (class 2604 OID 22791)
-- Dependencies: 1729 1728
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE dbpessoas_complemento_pf ALTER COLUMN id SET DEFAULT nextval('dbpessoas_complemento_pf_id_seq'::regclass);


--
-- TOC entry 2164 (class 2604 OID 22792)
-- Dependencies: 1731 1730
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE dbpessoas_complemento_pj ALTER COLUMN id SET DEFAULT nextval('dbpessoas_complemento_pj_id_seq'::regclass);


--
-- TOC entry 2169 (class 2604 OID 22793)
-- Dependencies: 1733 1732
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE dbpessoas_formacoes ALTER COLUMN id SET DEFAULT nextval('dbpessoas_formacoes_id_seq'::regclass);


--
-- TOC entry 2174 (class 2604 OID 22794)
-- Dependencies: 1735 1734
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE dbpessoas_funcionarios ALTER COLUMN id SET DEFAULT nextval('dbpessoas_funcionarios_id_seq'::regclass);


--
-- TOC entry 2179 (class 2604 OID 22795)
-- Dependencies: 1738 1737
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE dbpessoas_titularidades ALTER COLUMN id SET DEFAULT nextval('dbpessoas_titularidades_id_seq'::regclass);


--
-- TOC entry 2185 (class 2604 OID 22796)
-- Dependencies: 1740 1739
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE dbprodutos ALTER COLUMN id SET DEFAULT nextval('dbprodutos_id_seq'::regclass);


--
-- TOC entry 2190 (class 2604 OID 22797)
-- Dependencies: 1742 1741
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE dbprodutos_movimentacao ALTER COLUMN id SET DEFAULT nextval('dbprodutos_movimentacao_id_seq'::regclass);


--
-- TOC entry 2195 (class 2604 OID 22798)
-- Dependencies: 1744 1743
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE dbprodutos_tipos ALTER COLUMN id SET DEFAULT nextval('dbprodutos_tipos_id_seq'::regclass);


--
-- TOC entry 2200 (class 2604 OID 22799)
-- Dependencies: 1746 1745
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE dbprodutos_unidade ALTER COLUMN id SET DEFAULT nextval('dbprodutos_unidade_id_seq'::regclass);


--
-- TOC entry 2206 (class 2604 OID 22800)
-- Dependencies: 1748 1747
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE dbsalas ALTER COLUMN id SET DEFAULT nextval('dbsalas_id_seq'::regclass);


--
-- TOC entry 2207 (class 2604 OID 22801)
-- Dependencies: 1750 1749
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE dbstatus ALTER COLUMN id SET DEFAULT nextval('dbstatus_id_seq'::regclass);


--
-- TOC entry 2209 (class 2604 OID 22802)
-- Dependencies: 1752 1751
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE dbteste ALTER COLUMN id SET DEFAULT nextval('dbteste_id_seq'::regclass);


--
-- TOC entry 2213 (class 2604 OID 22803)
-- Dependencies: 1754 1753
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE dbtipos_movimentacao ALTER COLUMN id SET DEFAULT nextval('dbtipos_movimentacao_id_seq'::regclass);


--
-- TOC entry 2218 (class 2604 OID 22804)
-- Dependencies: 1756 1755
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE dbtransacoes ALTER COLUMN id SET DEFAULT nextval('dbtransacoes_id_seq'::regclass);


--
-- TOC entry 2223 (class 2604 OID 22805)
-- Dependencies: 1758 1757
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE dbtransacoes_itens ALTER COLUMN id SET DEFAULT nextval('dbtransacoes_itens_id_seq'::regclass);


--
-- TOC entry 2228 (class 2604 OID 22806)
-- Dependencies: 1760 1759
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE dbtransacoes_tipos ALTER COLUMN id SET DEFAULT nextval('dbtransacoes_tipos_id_seq'::regclass);


--
-- TOC entry 2233 (class 2604 OID 22807)
-- Dependencies: 1762 1761
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE dbunidades ALTER COLUMN id SET DEFAULT nextval('dbunidades_id_seq'::regclass);


--
-- TOC entry 2238 (class 2604 OID 22808)
-- Dependencies: 1764 1763
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE dbunidades_parametros ALTER COLUMN id SET DEFAULT nextval('dbunidades_parametros_id_seq'::regclass);


--
-- TOC entry 2245 (class 2604 OID 22809)
-- Dependencies: 1770 1765
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE dbusuarios ALTER COLUMN id SET DEFAULT nextval('dbusuarios_id_seq'::regclass);


--
-- TOC entry 2250 (class 2604 OID 22810)
-- Dependencies: 1767 1766
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE dbusuarios_erros ALTER COLUMN id SET DEFAULT nextval('dbusuarios_erros_id_seq'::regclass);


--
-- TOC entry 2255 (class 2604 OID 22811)
-- Dependencies: 1769 1768
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE dbusuarios_historico ALTER COLUMN id SET DEFAULT nextval('dbusuarios_historico_id_seq'::regclass);


--
-- TOC entry 2262 (class 2604 OID 22812)
-- Dependencies: 1772 1771
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE dbusuarios_privilegios ALTER COLUMN id SET DEFAULT nextval('dbusuarios_privilegios_id_seq'::regclass);


--
-- TOC entry 2267 (class 2604 OID 22813)
-- Dependencies: 1774 1773
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE tab_balancocontadorconferente ALTER COLUMN id SET DEFAULT nextval('tab_balancocontadorconferente_id_seq'::regclass);


--
-- TOC entry 2272 (class 2604 OID 22814)
-- Dependencies: 1777 1775
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE tab_historicobalancoalteracao ALTER COLUMN id SET DEFAULT nextval('tab_historicobalancoalteracao_id_seq'::regclass);


--
-- TOC entry 2273 (class 2604 OID 22815)
-- Dependencies: 1776 1775
-- Name: hsbaseq; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE tab_historicobalancoalteracao ALTER COLUMN hsbaseq SET DEFAULT nextval('tab_historicobalancoalteracao_hsbaseq_seq'::regclass);


--
-- TOC entry 2278 (class 2604 OID 22816)
-- Dependencies: 1780 1779
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE tab_produto ALTER COLUMN id SET DEFAULT nextval('tab_produto_id_seq'::regclass);


--
-- TOC entry 2283 (class 2604 OID 22817)
-- Dependencies: 1782 1781
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE tab_produto_similar ALTER COLUMN id SET DEFAULT nextval('tab_produto_similar_id_seq'::regclass);


SET search_path = dominio, pg_catalog;

--
-- TOC entry 2285 (class 2606 OID 22819)
-- Dependencies: 1693 1693
-- Name: pk_dbceps; Type: CONSTRAINT; Schema: dominio; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbceps
    ADD CONSTRAINT pk_dbceps PRIMARY KEY (id);


--
-- TOC entry 2287 (class 2606 OID 22821)
-- Dependencies: 1695 1695
-- Name: pk_dbcidades; Type: CONSTRAINT; Schema: dominio; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbcidades
    ADD CONSTRAINT pk_dbcidades PRIMARY KEY (id);


--
-- TOC entry 2289 (class 2606 OID 22823)
-- Dependencies: 1697 1697
-- Name: pk_dbestados; Type: CONSTRAINT; Schema: dominio; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbestados
    ADD CONSTRAINT pk_dbestados PRIMARY KEY (id);


--
-- TOC entry 2291 (class 2606 OID 22825)
-- Dependencies: 1699 1699
-- Name: pk_dbnfe_erros; Type: CONSTRAINT; Schema: dominio; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbnfe_erros
    ADD CONSTRAINT pk_dbnfe_erros PRIMARY KEY (id);


--
-- TOC entry 2293 (class 2606 OID 22827)
-- Dependencies: 1700 1700
-- Name: pk_dbnfe_erros_grupos; Type: CONSTRAINT; Schema: dominio; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbnfe_erros_grupos
    ADD CONSTRAINT pk_dbnfe_erros_grupos PRIMARY KEY (id);


--
-- TOC entry 2295 (class 2606 OID 22829)
-- Dependencies: 1702 1702
-- Name: pk_dbnfe_erros_mensagens; Type: CONSTRAINT; Schema: dominio; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbnfe_erros_mensagens
    ADD CONSTRAINT pk_dbnfe_erros_mensagens PRIMARY KEY (id);


--
-- TOC entry 2297 (class 2606 OID 22831)
-- Dependencies: 1703 1703
-- Name: pk_dbpaises; Type: CONSTRAINT; Schema: dominio; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbpaises
    ADD CONSTRAINT pk_dbpaises PRIMARY KEY (id);


--
-- TOC entry 2299 (class 2606 OID 22833)
-- Dependencies: 1707 1707
-- Name: pk_dbunidade_medida; Type: CONSTRAINT; Schema: dominio; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbunidade_medida
    ADD CONSTRAINT pk_dbunidade_medida PRIMARY KEY (codigo);


--
-- TOC entry 2301 (class 2606 OID 22835)
-- Dependencies: 1709 1709
-- Name: pk_dbwebservices; Type: CONSTRAINT; Schema: dominio; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbwebservices
    ADD CONSTRAINT pk_dbwebservices PRIMARY KEY (id);


--
-- TOC entry 2303 (class 2606 OID 22837)
-- Dependencies: 1710 1710
-- Name: pk_dbwebservices_campos; Type: CONSTRAINT; Schema: dominio; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbwebservices_campos
    ADD CONSTRAINT pk_dbwebservices_campos PRIMARY KEY (id);


SET search_path = public, pg_catalog;

--
-- TOC entry 2361 (class 2606 OID 22839)
-- Dependencies: 1751 1751
-- Name: id; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbteste
    ADD CONSTRAINT id PRIMARY KEY (id);


--
-- TOC entry 2305 (class 2606 OID 22841)
-- Dependencies: 1713 1713
-- Name: pk_dbcargos; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbcargos
    ADD CONSTRAINT pk_dbcargos PRIMARY KEY (codigo);


--
-- TOC entry 2309 (class 2606 OID 22843)
-- Dependencies: 1715 1715
-- Name: pk_dbcomportamento_fiscal; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbcomportamento_fiscal
    ADD CONSTRAINT pk_dbcomportamento_fiscal PRIMARY KEY (codigo);


--
-- TOC entry 2311 (class 2606 OID 22845)
-- Dependencies: 1717 1717
-- Name: pk_dbcondicoes_pagamento; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbcondicoes_pagamento
    ADD CONSTRAINT pk_dbcondicoes_pagamento PRIMARY KEY (codigo);


--
-- TOC entry 2313 (class 2606 OID 22847)
-- Dependencies: 1719 1719
-- Name: pk_dbcondicoes_pagamento_funcion; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbcondicoes_pagamento_pessoa
    ADD CONSTRAINT pk_dbcondicoes_pagamento_funcion PRIMARY KEY (codigo);


--
-- TOC entry 2315 (class 2606 OID 22849)
-- Dependencies: 1721 1721
-- Name: pk_dbdepartamentos; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbdepartamentos
    ADD CONSTRAINT pk_dbdepartamentos PRIMARY KEY (codigo);


--
-- TOC entry 2319 (class 2606 OID 22851)
-- Dependencies: 1723 1723
-- Name: pk_dbpatrimonios; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbpatrimonios
    ADD CONSTRAINT pk_dbpatrimonios PRIMARY KEY (codigo);


--
-- TOC entry 2321 (class 2606 OID 22853)
-- Dependencies: 1724 1724
-- Name: pk_dbpatrimonios_fotos; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbpatrimonios_fotos
    ADD CONSTRAINT pk_dbpatrimonios_fotos PRIMARY KEY (codigo);


--
-- TOC entry 2323 (class 2606 OID 22855)
-- Dependencies: 1727 1727
-- Name: pk_dbpessoas; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbpessoas
    ADD CONSTRAINT pk_dbpessoas PRIMARY KEY (codigo);


--
-- TOC entry 2327 (class 2606 OID 22857)
-- Dependencies: 1728 1728
-- Name: pk_dbpessoas_complemento_pf; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbpessoas_complemento_pf
    ADD CONSTRAINT pk_dbpessoas_complemento_pf PRIMARY KEY (codigo);


--
-- TOC entry 2331 (class 2606 OID 22859)
-- Dependencies: 1730 1730
-- Name: pk_dbpessoas_complemento_pj; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbpessoas_complemento_pj
    ADD CONSTRAINT pk_dbpessoas_complemento_pj PRIMARY KEY (codigo);


--
-- TOC entry 2335 (class 2606 OID 22861)
-- Dependencies: 1732 1732
-- Name: pk_dbpessoas_formacoes; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbpessoas_formacoes
    ADD CONSTRAINT pk_dbpessoas_formacoes PRIMARY KEY (codigo);


--
-- TOC entry 2339 (class 2606 OID 22863)
-- Dependencies: 1734 1734
-- Name: pk_dbpessoas_funcionarios; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbpessoas_funcionarios
    ADD CONSTRAINT pk_dbpessoas_funcionarios PRIMARY KEY (codigo);


--
-- TOC entry 2343 (class 2606 OID 22865)
-- Dependencies: 1737 1737
-- Name: pk_dbpessoas_titularidades; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbpessoas_titularidades
    ADD CONSTRAINT pk_dbpessoas_titularidades PRIMARY KEY (codigo);


--
-- TOC entry 2347 (class 2606 OID 22867)
-- Dependencies: 1739 1739
-- Name: pk_dbprodutos; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbprodutos
    ADD CONSTRAINT pk_dbprodutos PRIMARY KEY (codigo);


--
-- TOC entry 2351 (class 2606 OID 22869)
-- Dependencies: 1741 1741
-- Name: pk_dbprodutos_movimentacao; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbprodutos_movimentacao
    ADD CONSTRAINT pk_dbprodutos_movimentacao PRIMARY KEY (codigo);


--
-- TOC entry 2353 (class 2606 OID 22871)
-- Dependencies: 1743 1743
-- Name: pk_dbprodutos_tipos; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbprodutos_tipos
    ADD CONSTRAINT pk_dbprodutos_tipos PRIMARY KEY (codigo);


--
-- TOC entry 2355 (class 2606 OID 22873)
-- Dependencies: 1745 1745
-- Name: pk_dbprodutos_unidade; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbprodutos_unidade
    ADD CONSTRAINT pk_dbprodutos_unidade PRIMARY KEY (codigo);


--
-- TOC entry 2357 (class 2606 OID 22875)
-- Dependencies: 1747 1747
-- Name: pk_dbsalas; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbsalas
    ADD CONSTRAINT pk_dbsalas PRIMARY KEY (codigo);


--
-- TOC entry 2363 (class 2606 OID 22877)
-- Dependencies: 1753 1753
-- Name: pk_dbtipos_movimentacao; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbtipos_movimentacao
    ADD CONSTRAINT pk_dbtipos_movimentacao PRIMARY KEY (codigo);


--
-- TOC entry 2366 (class 2606 OID 22879)
-- Dependencies: 1755 1755
-- Name: pk_dbtransacoes; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbtransacoes
    ADD CONSTRAINT pk_dbtransacoes PRIMARY KEY (codigo);


--
-- TOC entry 2368 (class 2606 OID 22881)
-- Dependencies: 1757 1757
-- Name: pk_dbtransacoes_itens; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbtransacoes_itens
    ADD CONSTRAINT pk_dbtransacoes_itens PRIMARY KEY (codigo);


--
-- TOC entry 2370 (class 2606 OID 22883)
-- Dependencies: 1759 1759
-- Name: pk_dbtransacoes_tipos; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbtransacoes_tipos
    ADD CONSTRAINT pk_dbtransacoes_tipos PRIMARY KEY (codigo);


--
-- TOC entry 2374 (class 2606 OID 22885)
-- Dependencies: 1761 1761
-- Name: pk_dbunidades; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbunidades
    ADD CONSTRAINT pk_dbunidades PRIMARY KEY (codigo);


--
-- TOC entry 2376 (class 2606 OID 22887)
-- Dependencies: 1763 1763
-- Name: pk_dbunidades_parametros; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbunidades_parametros
    ADD CONSTRAINT pk_dbunidades_parametros PRIMARY KEY (codigo);


--
-- TOC entry 2378 (class 2606 OID 22889)
-- Dependencies: 1765 1765
-- Name: pk_dbusuarios; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbusuarios
    ADD CONSTRAINT pk_dbusuarios PRIMARY KEY (codigo);


--
-- TOC entry 2380 (class 2606 OID 22891)
-- Dependencies: 1766 1766
-- Name: pk_dbusuarios_erros; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbusuarios_erros
    ADD CONSTRAINT pk_dbusuarios_erros PRIMARY KEY (codigo);


--
-- TOC entry 2382 (class 2606 OID 22893)
-- Dependencies: 1768 1768
-- Name: pk_dbusuarios_historico; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbusuarios_historico
    ADD CONSTRAINT pk_dbusuarios_historico PRIMARY KEY (codigo);


--
-- TOC entry 2384 (class 2606 OID 22895)
-- Dependencies: 1771 1771
-- Name: pk_dbusuarios_privilegios; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbusuarios_privilegios
    ADD CONSTRAINT pk_dbusuarios_privilegios PRIMARY KEY (codigo);


--
-- TOC entry 2307 (class 2606 OID 22897)
-- Dependencies: 1713 1713
-- Name: pk_id_dbcargos; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbcargos
    ADD CONSTRAINT pk_id_dbcargos UNIQUE (id);


--
-- TOC entry 2317 (class 2606 OID 22899)
-- Dependencies: 1721 1721
-- Name: pk_id_dbdepartamentos; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbdepartamentos
    ADD CONSTRAINT pk_id_dbdepartamentos UNIQUE (id);


--
-- TOC entry 2325 (class 2606 OID 22901)
-- Dependencies: 1727 1727
-- Name: pk_id_dbpessoas; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbpessoas
    ADD CONSTRAINT pk_id_dbpessoas UNIQUE (id);


--
-- TOC entry 2333 (class 2606 OID 22903)
-- Dependencies: 1730 1730
-- Name: pk_id_dbpessoas_complemento_pj; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbpessoas_complemento_pj
    ADD CONSTRAINT pk_id_dbpessoas_complemento_pj UNIQUE (id);


--
-- TOC entry 2337 (class 2606 OID 22905)
-- Dependencies: 1732 1732
-- Name: pk_id_dbpessoas_formacoes; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbpessoas_formacoes
    ADD CONSTRAINT pk_id_dbpessoas_formacoes UNIQUE (id);


--
-- TOC entry 2341 (class 2606 OID 22907)
-- Dependencies: 1734 1734
-- Name: pk_id_dbpessoas_funcionarios; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbpessoas_funcionarios
    ADD CONSTRAINT pk_id_dbpessoas_funcionarios UNIQUE (id);


--
-- TOC entry 2345 (class 2606 OID 22909)
-- Dependencies: 1737 1737
-- Name: pk_id_dbpessoas_titularidades; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbpessoas_titularidades
    ADD CONSTRAINT pk_id_dbpessoas_titularidades UNIQUE (id);


--
-- TOC entry 2329 (class 2606 OID 22911)
-- Dependencies: 1728 1728
-- Name: pk_id_dbpessos_complemento_pf; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbpessoas_complemento_pf
    ADD CONSTRAINT pk_id_dbpessos_complemento_pf UNIQUE (id);


--
-- TOC entry 2359 (class 2606 OID 22913)
-- Dependencies: 1747 1747
-- Name: pk_id_dbsalas; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbsalas
    ADD CONSTRAINT pk_id_dbsalas UNIQUE (id);


--
-- TOC entry 2372 (class 2606 OID 22915)
-- Dependencies: 1759 1759
-- Name: pk_id_dbtransacoes_tipos; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbtransacoes_tipos
    ADD CONSTRAINT pk_id_dbtransacoes_tipos UNIQUE (id);


--
-- TOC entry 2386 (class 2606 OID 22917)
-- Dependencies: 1773 1773
-- Name: pk_tab_balancocontadorconferente; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY tab_balancocontadorconferente
    ADD CONSTRAINT pk_tab_balancocontadorconferente PRIMARY KEY (codigo);


--
-- TOC entry 2388 (class 2606 OID 22919)
-- Dependencies: 1775 1775
-- Name: pk_tab_historicobalancoalterac; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY tab_historicobalancoalteracao
    ADD CONSTRAINT pk_tab_historicobalancoalterac PRIMARY KEY (hsbaseq);


--
-- TOC entry 2390 (class 2606 OID 22921)
-- Dependencies: 1779 1779
-- Name: pk_tab_produto; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY tab_produto
    ADD CONSTRAINT pk_tab_produto PRIMARY KEY (codigo);


--
-- TOC entry 2392 (class 2606 OID 22923)
-- Dependencies: 1781 1781
-- Name: pk_tab_produto_similar; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY tab_produto_similar
    ADD CONSTRAINT pk_tab_produto_similar PRIMARY KEY (codigo);


--
-- TOC entry 2348 (class 1259 OID 22924)
-- Dependencies: 1741
-- Name: fki__dbprodutos_unidade__dbprodutos__codigounidade; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX fki__dbprodutos_unidade__dbprodutos__codigounidade ON dbprodutos_movimentacao USING btree (codigoprodutounidade);


--
-- TOC entry 2364 (class 1259 OID 22925)
-- Dependencies: 1755
-- Name: fki_tran_tptrcodigo; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX fki_tran_tptrcodigo ON dbtransacoes USING btree (codigotipotransacao);


--
-- TOC entry 2349 (class 1259 OID 22926)
-- Dependencies: 1741
-- Name: fki_trit_tritemmov; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX fki_trit_tritemmov ON dbprodutos_movimentacao USING btree (codigotransacaoitem);


--
-- TOC entry 2412 (class 2606 OID 22927)
-- Dependencies: 1713 1734 2304
-- Name: fk_dbcargos__dbpessoas_funcionarios__codigocargo; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_funcionarios
    ADD CONSTRAINT fk_dbcargos__dbpessoas_funcionarios__codigocargo FOREIGN KEY (codigocargo) REFERENCES dbcargos(codigo);


--
-- TOC entry 2413 (class 2606 OID 22932)
-- Dependencies: 2314 1734 1721
-- Name: fk_dbdepartamentos__dbpessoas_funcionarios__codigodepartamento; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_funcionarios
    ADD CONSTRAINT fk_dbdepartamentos__dbpessoas_funcionarios__codigodepartamento FOREIGN KEY (codigodepartamento) REFERENCES dbdepartamentos(codigo);


--
-- TOC entry 2402 (class 2606 OID 22937)
-- Dependencies: 2318 1723 1724
-- Name: fk_dbpatrimonios__dbpatrimonios_fotos__codigopatrimonio; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpatrimonios_fotos
    ADD CONSTRAINT fk_dbpatrimonios__dbpatrimonios_fotos__codigopatrimonio FOREIGN KEY (codigopatrimonio) REFERENCES dbpatrimonios(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2405 (class 2606 OID 22942)
-- Dependencies: 1728 1727 2322
-- Name: fk_dbpessoas__dbpessoas_complemento_pf__codigopessoa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_complemento_pf
    ADD CONSTRAINT fk_dbpessoas__dbpessoas_complemento_pf__codigopessoa FOREIGN KEY (codigopessoa) REFERENCES dbpessoas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2407 (class 2606 OID 22947)
-- Dependencies: 1730 2322 1727
-- Name: fk_dbpessoas__dbpessoas_complemento_pj__codigopessoa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_complemento_pj
    ADD CONSTRAINT fk_dbpessoas__dbpessoas_complemento_pj__codigopessoa FOREIGN KEY (codigopessoa) REFERENCES dbpessoas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2409 (class 2606 OID 22952)
-- Dependencies: 1727 1732 2322
-- Name: fk_dbpessoas__dbpessoas_formacoes__codigopessoa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_formacoes
    ADD CONSTRAINT fk_dbpessoas__dbpessoas_formacoes__codigopessoa FOREIGN KEY (codigopessoa) REFERENCES dbpessoas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2410 (class 2606 OID 22957)
-- Dependencies: 1737 2342 1732
-- Name: fk_dbpessoas__dbpessoas_formacoes__codigotitularidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_formacoes
    ADD CONSTRAINT fk_dbpessoas__dbpessoas_formacoes__codigotitularidade FOREIGN KEY (codigotitularidade) REFERENCES dbpessoas_titularidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2414 (class 2606 OID 22962)
-- Dependencies: 1734 1727 2322
-- Name: fk_dbpessoas__dbpessoas_funcionarios__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_funcionarios
    ADD CONSTRAINT fk_dbpessoas__dbpessoas_funcionarios__unidade FOREIGN KEY (codigopessoa) REFERENCES dbpessoas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2399 (class 2606 OID 22967)
-- Dependencies: 1723 1734 2338
-- Name: fk_dbpessoas_funcionarios__dbpatrimonios__codigofuncionario; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpatrimonios
    ADD CONSTRAINT fk_dbpessoas_funcionarios__dbpatrimonios__codigofuncionario FOREIGN KEY (codigofuncionario) REFERENCES dbpessoas_funcionarios(codigo);


--
-- TOC entry 2400 (class 2606 OID 22972)
-- Dependencies: 2346 1723 1739
-- Name: fk_dbprodutos__dbpatrimonios__codigoproduto; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpatrimonios
    ADD CONSTRAINT fk_dbprodutos__dbpatrimonios__codigoproduto FOREIGN KEY (codigoproduto) REFERENCES dbprodutos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2421 (class 2606 OID 22977)
-- Dependencies: 1739 1743 2346
-- Name: fk_dbprodutos__dbprodutos_tipos__codigoproduto; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprodutos_tipos
    ADD CONSTRAINT fk_dbprodutos__dbprodutos_tipos__codigoproduto FOREIGN KEY (codigoproduto) REFERENCES dbprodutos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2397 (class 2606 OID 22982)
-- Dependencies: 1747 1721 2356
-- Name: fk_dbsalas__dbdepartamentos__codigosala; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbdepartamentos
    ADD CONSTRAINT fk_dbsalas__dbdepartamentos__codigosala FOREIGN KEY (codigosala) REFERENCES dbsalas(codigo);


--
-- TOC entry 2393 (class 2606 OID 22987)
-- Dependencies: 2373 1761 1713
-- Name: fk_dbunidades__dbcargos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcargos
    ADD CONSTRAINT fk_dbunidades__dbcargos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2394 (class 2606 OID 22992)
-- Dependencies: 1761 2373 1715
-- Name: fk_dbunidades__dbcomportamento_fiscal__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcomportamento_fiscal
    ADD CONSTRAINT fk_dbunidades__dbcomportamento_fiscal__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2398 (class 2606 OID 22997)
-- Dependencies: 2373 1761 1721
-- Name: fk_dbunidades__dbdepartamentos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbdepartamentos
    ADD CONSTRAINT fk_dbunidades__dbdepartamentos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2401 (class 2606 OID 23002)
-- Dependencies: 2373 1723 1761
-- Name: fk_dbunidades__dbpatrimonios__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpatrimonios
    ADD CONSTRAINT fk_dbunidades__dbpatrimonios__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2403 (class 2606 OID 23007)
-- Dependencies: 1761 1724 2373
-- Name: fk_dbunidades__dbpatrimonios_fotos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpatrimonios_fotos
    ADD CONSTRAINT fk_dbunidades__dbpatrimonios_fotos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2404 (class 2606 OID 23012)
-- Dependencies: 1727 1761 2373
-- Name: fk_dbunidades__dbpessoas__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas
    ADD CONSTRAINT fk_dbunidades__dbpessoas__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2406 (class 2606 OID 23017)
-- Dependencies: 1728 1761 2373
-- Name: fk_dbunidades__dbpessoas_complemento_pf__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_complemento_pf
    ADD CONSTRAINT fk_dbunidades__dbpessoas_complemento_pf__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2408 (class 2606 OID 23022)
-- Dependencies: 1730 1761 2373
-- Name: fk_dbunidades__dbpessoas_complemento_pj__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_complemento_pj
    ADD CONSTRAINT fk_dbunidades__dbpessoas_complemento_pj__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2411 (class 2606 OID 23027)
-- Dependencies: 2373 1761 1732
-- Name: fk_dbunidades__dbpessoas_formacoes__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_formacoes
    ADD CONSTRAINT fk_dbunidades__dbpessoas_formacoes__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2415 (class 2606 OID 23032)
-- Dependencies: 1761 2373 1734
-- Name: fk_dbunidades__dbpessoas_funcionarios__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_funcionarios
    ADD CONSTRAINT fk_dbunidades__dbpessoas_funcionarios__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2416 (class 2606 OID 23037)
-- Dependencies: 2373 1761 1737
-- Name: fk_dbunidades__dbpessoas_titularidades__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_titularidades
    ADD CONSTRAINT fk_dbunidades__dbpessoas_titularidades__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2417 (class 2606 OID 23042)
-- Dependencies: 1739 2373 1761
-- Name: fk_dbunidades__dbprodutos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprodutos
    ADD CONSTRAINT fk_dbunidades__dbprodutos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2422 (class 2606 OID 23047)
-- Dependencies: 1761 1743 2373
-- Name: fk_dbunidades__dbprodutos_tipos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprodutos_tipos
    ADD CONSTRAINT fk_dbunidades__dbprodutos_tipos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2423 (class 2606 OID 23052)
-- Dependencies: 1761 1747 2373
-- Name: fk_dbunidades__dbsalas__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbsalas
    ADD CONSTRAINT fk_dbunidades__dbsalas__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2429 (class 2606 OID 23057)
-- Dependencies: 2373 1761 1759
-- Name: fk_dbunidades__dbtransacoes_tipos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes_tipos
    ADD CONSTRAINT fk_dbunidades__dbtransacoes_tipos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2430 (class 2606 OID 23062)
-- Dependencies: 2373 1763 1761
-- Name: fk_dbunidades__dbunidades_parametros__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbunidades_parametros
    ADD CONSTRAINT fk_dbunidades__dbunidades_parametros__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2431 (class 2606 OID 23067)
-- Dependencies: 1765 2373 1761
-- Name: fk_dbunidades__dbusuarios__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbusuarios
    ADD CONSTRAINT fk_dbunidades__dbusuarios__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2432 (class 2606 OID 23072)
-- Dependencies: 1761 1766 2373
-- Name: fk_dbunidades__dbusuarios_erros__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbusuarios_erros
    ADD CONSTRAINT fk_dbunidades__dbusuarios_erros__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2434 (class 2606 OID 23077)
-- Dependencies: 2373 1768 1761
-- Name: fk_dbunidades__dbusuarios_historico__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbusuarios_historico
    ADD CONSTRAINT fk_dbunidades__dbusuarios_historico__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2436 (class 2606 OID 23082)
-- Dependencies: 1761 1771 2373
-- Name: fk_dbunidades__dbusuarios_privilegios__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbusuarios_privilegios
    ADD CONSTRAINT fk_dbunidades__dbusuarios_privilegios__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2438 (class 2606 OID 23087)
-- Dependencies: 1761 1779 2373
-- Name: fk_dbunidades__tab_produto__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tab_produto
    ADD CONSTRAINT fk_dbunidades__tab_produto__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2439 (class 2606 OID 23092)
-- Dependencies: 1761 1781 2373
-- Name: fk_dbunidades__tab_produto_similar__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tab_produto_similar
    ADD CONSTRAINT fk_dbunidades__tab_produto_similar__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2433 (class 2606 OID 23097)
-- Dependencies: 1765 1766 2377
-- Name: fk_dbusuarios__dbusuarios_erros__codigousuario; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbusuarios_erros
    ADD CONSTRAINT fk_dbusuarios__dbusuarios_erros__codigousuario FOREIGN KEY (codigousuario) REFERENCES dbusuarios(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2435 (class 2606 OID 23102)
-- Dependencies: 1765 1768 2377
-- Name: fk_dbusuarios__dbusuarios_historico__codigousuario; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbusuarios_historico
    ADD CONSTRAINT fk_dbusuarios__dbusuarios_historico__codigousuario FOREIGN KEY (codigousuario) REFERENCES dbusuarios(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2437 (class 2606 OID 23107)
-- Dependencies: 1765 1771 2377
-- Name: fk_dbusuarios__dbusuarios_privilegios__codigousuario; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbusuarios_privilegios
    ADD CONSTRAINT fk_dbusuarios__dbusuarios_privilegios__codigousuario FOREIGN KEY (codigousuario) REFERENCES dbusuarios(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2440 (class 2606 OID 23112)
-- Dependencies: 1779 1781 2389
-- Name: fk_tab_produto__tab_produto_similar__codigoproduto; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tab_produto_similar
    ADD CONSTRAINT fk_tab_produto__tab_produto_similar__codigoproduto FOREIGN KEY (codigoproduto) REFERENCES tab_produto(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2441 (class 2606 OID 23117)
-- Dependencies: 1779 2389 1781
-- Name: fk_tab_produto__tab_produto_similar__codigoprodutosimilar; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tab_produto_similar
    ADD CONSTRAINT fk_tab_produto__tab_produto_similar__codigoprodutosimilar FOREIGN KEY (codigoprodutosimilar) REFERENCES tab_produto(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2395 (class 2606 OID 23122)
-- Dependencies: 2310 1719 1717
-- Name: fpfn_frpgcodigo; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcondicoes_pagamento_pessoa
    ADD CONSTRAINT fpfn_frpgcodigo FOREIGN KEY (codigoformapagamento) REFERENCES dbcondicoes_pagamento(codigo) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2396 (class 2606 OID 23127)
-- Dependencies: 2322 1727 1719
-- Name: fpps_pesscodigo; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcondicoes_pagamento_pessoa
    ADD CONSTRAINT fpps_pesscodigo FOREIGN KEY (codigopessoa) REFERENCES dbpessoas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2424 (class 2606 OID 23132)
-- Dependencies: 2310 1755 1717
-- Name: pddo_cdpgcodigo; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes
    ADD CONSTRAINT pddo_cdpgcodigo FOREIGN KEY (codigocondicaopagamento) REFERENCES dbcondicoes_pagamento(codigo) ON UPDATE CASCADE;


--
-- TOC entry 2425 (class 2606 OID 23137)
-- Dependencies: 1727 2322 1755
-- Name: pddo_pesscodigo; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes
    ADD CONSTRAINT pddo_pesscodigo FOREIGN KEY (codigocliente) REFERENCES dbpessoas(codigo) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2418 (class 2606 OID 23142)
-- Dependencies: 1779 1741 2389
-- Name: prmv_cdproduto; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprodutos_movimentacao
    ADD CONSTRAINT prmv_cdproduto FOREIGN KEY (codigoproduto) REFERENCES tab_produto(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2419 (class 2606 OID 23147)
-- Dependencies: 1741 2362 1753
-- Name: prmv_tpmvcodigo; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprodutos_movimentacao
    ADD CONSTRAINT prmv_tpmvcodigo FOREIGN KEY (codigotipomovimentacao) REFERENCES dbtipos_movimentacao(codigo) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2428 (class 2606 OID 23152)
-- Dependencies: 1757 1755 2365
-- Name: tran_pdocodigo; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes_itens
    ADD CONSTRAINT tran_pdocodigo FOREIGN KEY (codigotransacao) REFERENCES dbtransacoes(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2426 (class 2606 OID 23157)
-- Dependencies: 1755 1734 2338
-- Name: tran_pefncodigo; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes
    ADD CONSTRAINT tran_pefncodigo FOREIGN KEY (codigovendedor) REFERENCES dbpessoas_funcionarios(codigo) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2427 (class 2606 OID 23162)
-- Dependencies: 1755 1759 2369
-- Name: tran_tptrcodigo; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes
    ADD CONSTRAINT tran_tptrcodigo FOREIGN KEY (codigotipotransacao) REFERENCES dbtransacoes_tipos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2420 (class 2606 OID 23167)
-- Dependencies: 2367 1757 1741
-- Name: trit_tritemmov; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprodutos_movimentacao
    ADD CONSTRAINT trit_tritemmov FOREIGN KEY (codigotransacaoitem) REFERENCES dbtransacoes_itens(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2446 (class 0 OID 0)
-- Dependencies: 7
-- Name: public; Type: ACL; Schema: -; Owner: -
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2011-01-27 11:48:20

--
-- PostgreSQL database dump complete
--

