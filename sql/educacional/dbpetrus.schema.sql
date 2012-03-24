--
-- PostgreSQL database dump
--

-- Started on 2011-04-16 12:01:08

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- TOC entry 5 (class 2615 OID 16688)
-- Name: dominio; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA dominio;


--
-- TOC entry 884 (class 2612 OID 16386)
-- Name: plpgsql; Type: PROCEDURAL LANGUAGE; Schema: -; Owner: -
--

CREATE PROCEDURAL LANGUAGE plpgsql;


SET search_path = dominio, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 2071 (class 1259 OID 16689)
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
-- TOC entry 2072 (class 1259 OID 16692)
-- Dependencies: 2071 5
-- Name: dbceps_id_seq; Type: SEQUENCE; Schema: dominio; Owner: -
--

CREATE SEQUENCE dbceps_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 4065 (class 0 OID 0)
-- Dependencies: 2072
-- Name: dbceps_id_seq; Type: SEQUENCE OWNED BY; Schema: dominio; Owner: -
--

ALTER SEQUENCE dbceps_id_seq OWNED BY dbceps.id;


--
-- TOC entry 2073 (class 1259 OID 16694)
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
-- TOC entry 2074 (class 1259 OID 16697)
-- Dependencies: 2073 5
-- Name: dbcidades_id_seq; Type: SEQUENCE; Schema: dominio; Owner: -
--

CREATE SEQUENCE dbcidades_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 4066 (class 0 OID 0)
-- Dependencies: 2074
-- Name: dbcidades_id_seq; Type: SEQUENCE OWNED BY; Schema: dominio; Owner: -
--

ALTER SEQUENCE dbcidades_id_seq OWNED BY dbcidades.id;


--
-- TOC entry 2075 (class 1259 OID 16699)
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
-- TOC entry 2076 (class 1259 OID 16702)
-- Dependencies: 2075 5
-- Name: dbestados_id_seq; Type: SEQUENCE; Schema: dominio; Owner: -
--

CREATE SEQUENCE dbestados_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 4067 (class 0 OID 0)
-- Dependencies: 2076
-- Name: dbestados_id_seq; Type: SEQUENCE OWNED BY; Schema: dominio; Owner: -
--

ALTER SEQUENCE dbestados_id_seq OWNED BY dbestados.id;


--
-- TOC entry 2077 (class 1259 OID 16704)
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
-- TOC entry 2078 (class 1259 OID 16710)
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
-- TOC entry 2079 (class 1259 OID 16716)
-- Dependencies: 2077 5
-- Name: dbnfe_erros_id_seq; Type: SEQUENCE; Schema: dominio; Owner: -
--

CREATE SEQUENCE dbnfe_erros_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 4068 (class 0 OID 0)
-- Dependencies: 2079
-- Name: dbnfe_erros_id_seq; Type: SEQUENCE OWNED BY; Schema: dominio; Owner: -
--

ALTER SEQUENCE dbnfe_erros_id_seq OWNED BY dbnfe_erros.id;


--
-- TOC entry 2080 (class 1259 OID 16718)
-- Dependencies: 5
-- Name: dbnfe_erros_mensagens; Type: TABLE; Schema: dominio; Owner: -; Tablespace: 
--

CREATE TABLE dbnfe_erros_mensagens (
    id integer NOT NULL,
    codigo character varying(10),
    descricao text
);


--
-- TOC entry 2081 (class 1259 OID 16724)
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
-- TOC entry 2082 (class 1259 OID 16727)
-- Dependencies: 2081 5
-- Name: dbpaises_id_seq; Type: SEQUENCE; Schema: dominio; Owner: -
--

CREATE SEQUENCE dbpaises_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 4069 (class 0 OID 0)
-- Dependencies: 2082
-- Name: dbpaises_id_seq; Type: SEQUENCE OWNED BY; Schema: dominio; Owner: -
--

ALTER SEQUENCE dbpaises_id_seq OWNED BY dbpaises.id;


--
-- TOC entry 2083 (class 1259 OID 16729)
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
-- TOC entry 2084 (class 1259 OID 16735)
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
-- TOC entry 2085 (class 1259 OID 16741)
-- Dependencies: 2084 5
-- Name: dbwebservices_campos_id_seq; Type: SEQUENCE; Schema: dominio; Owner: -
--

CREATE SEQUENCE dbwebservices_campos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 4070 (class 0 OID 0)
-- Dependencies: 2085
-- Name: dbwebservices_campos_id_seq; Type: SEQUENCE OWNED BY; Schema: dominio; Owner: -
--

ALTER SEQUENCE dbwebservices_campos_id_seq OWNED BY dbwebservices_campos.id;


--
-- TOC entry 2086 (class 1259 OID 16743)
-- Dependencies: 2083 5
-- Name: dbwebservices_id_seq; Type: SEQUENCE; Schema: dominio; Owner: -
--

CREATE SEQUENCE dbwebservices_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 4071 (class 0 OID 0)
-- Dependencies: 2086
-- Name: dbwebservices_id_seq; Type: SEQUENCE OWNED BY; Schema: dominio; Owner: -
--

ALTER SEQUENCE dbwebservices_id_seq OWNED BY dbwebservices.id;


SET search_path = public, pg_catalog;

--
-- TOC entry 2087 (class 1259 OID 16745)
-- Dependencies: 7
-- Name: dbalunos_disciplinas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbalunos_disciplinas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2088 (class 1259 OID 16747)
-- Dependencies: 7
-- Name: gerador_codigo_digito_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE gerador_codigo_digito_seq
    START WITH 100
    INCREMENT BY 1
    MAXVALUE 999
    MINVALUE 100
    CACHE 1
    CYCLE;


--
-- TOC entry 2089 (class 1259 OID 16749)
-- Dependencies: 7
-- Name: gerador_codigo_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE gerador_codigo_seq
    START WITH 10000000
    INCREMENT BY 1
    NO MAXVALUE
    MINVALUE 10000000
    CACHE 1;


--
-- TOC entry 2090 (class 1259 OID 16751)
-- Dependencies: 2746 2747 2748 2749 2750 2751 7
-- Name: dbalunos_disciplinas; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbalunos_disciplinas (
    id integer DEFAULT nextval('dbalunos_disciplinas_id_seq'::regclass) NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    codigoaluno character varying(30),
    codigodisciplina character varying(30),
    codigoturmadisciplina character varying(30),
    situacao character varying(40) DEFAULT '1'::character varying,
    obs text,
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL,
    datamod date
);


--
-- TOC entry 4072 (class 0 OID 0)
-- Dependencies: 2090
-- Name: COLUMN dbalunos_disciplinas.situacao; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbalunos_disciplinas.situacao IS '1 - A Cursar
2 - Cursando
3 - Aprovado por Mérito
4 - Reprovado
5 - Trancado
6 - Evadido
7 - Aprovado por Reconhecimento';


--
-- TOC entry 2091 (class 1259 OID 16763)
-- Dependencies: 7
-- Name: dbalunos_disciplinas_aproveitamentos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbalunos_disciplinas_aproveitamentos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2092 (class 1259 OID 16765)
-- Dependencies: 2752 2753 2754 2755 2756 7
-- Name: dbalunos_disciplinas_aproveitamentos; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbalunos_disciplinas_aproveitamentos (
    id integer DEFAULT nextval('dbalunos_disciplinas_aproveitamentos_id_seq'::regclass) NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    codigoalunodisciplina character varying(30),
    nomedisciplina character varying(200),
    cargahoraria character varying(30),
    ementa text,
    nota character varying(30),
    frequencia character varying(30),
    obs text,
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL,
    instituicao character varying(255),
    ano character varying(4)
);


--
-- TOC entry 2093 (class 1259 OID 16776)
-- Dependencies: 7
-- Name: dbalunos_faltas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbalunos_faltas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2094 (class 1259 OID 16778)
-- Dependencies: 2757 2758 2759 2760 2761 2762 2763 7
-- Name: dbalunos_faltas; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbalunos_faltas (
    id integer DEFAULT nextval('dbalunos_faltas_id_seq'::regclass) NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    codigoaluno character varying(30) NOT NULL,
    codigoturmadisciplina character varying(30),
    codigoaula character varying(30),
    datafalta date,
    numaula integer DEFAULT 0,
    justificativa text,
    obs text,
    situacao character varying(2) DEFAULT 'P'::character varying NOT NULL,
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 2095 (class 1259 OID 16791)
-- Dependencies: 7
-- Name: dbalunos_notas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbalunos_notas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2096 (class 1259 OID 16793)
-- Dependencies: 2764 2765 2766 2767 2768 7
-- Name: dbalunos_notas; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbalunos_notas (
    id integer DEFAULT nextval('dbalunos_notas_id_seq'::regclass) NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    codigoaluno character varying(30),
    codigoturmadisciplina character varying(30),
    codigoavaliacao character varying(30),
    nota numeric(15,2),
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL,
    ordemavaliacao character varying(20),
    codigograde character varying(20)
);


--
-- TOC entry 2097 (class 1259 OID 16801)
-- Dependencies: 7
-- Name: dbalunos_requisitos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbalunos_requisitos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2098 (class 1259 OID 16803)
-- Dependencies: 2769 2770 2771 2772 2773 7
-- Name: dbalunos_requisitos; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbalunos_requisitos (
    id integer DEFAULT nextval('dbalunos_requisitos_id_seq'::regclass) NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    codigoaluno character varying(30),
    codigorequisito character varying(30),
    obs text,
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 2099 (class 1259 OID 16814)
-- Dependencies: 7
-- Name: dbalunos_solicitacoes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbalunos_solicitacoes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2100 (class 1259 OID 16816)
-- Dependencies: 2774 2775 2776 2777 2778 7
-- Name: dbalunos_solicitacoes; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbalunos_solicitacoes (
    id integer DEFAULT nextval('dbalunos_solicitacoes_id_seq'::regclass) NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    codigoaluno character varying(30),
    codigosolicitacao character varying(30),
    data date,
    justificativa text,
    atendimento text,
    codigofuncionario character varying(30),
    codigodepartamento character varying(30),
    status character varying(2),
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 2101 (class 1259 OID 16827)
-- Dependencies: 7
-- Name: dbalunos_transacoes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbalunos_transacoes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2102 (class 1259 OID 16829)
-- Dependencies: 2779 2780 2781 2782 2783 7
-- Name: dbalunos_transacoes; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbalunos_transacoes (
    id integer DEFAULT nextval('dbalunos_transacoes_id_seq'::regclass) NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    codigoaluno character varying(30),
    codigotransacao character varying(30),
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 2103 (class 1259 OID 16837)
-- Dependencies: 2785 2786 2787 2788 2789 2790 2791 7
-- Name: dbavaliacoes; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbavaliacoes (
    id integer NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(20),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    avaliacao character varying(50),
    peso integer DEFAULT 1,
    ordem integer DEFAULT 1,
    codigoregra character varying(20),
    incontrol text,
    referencia character varying(50),
    condicao text DEFAULT '1'::text,
    codigograde character varying(20),
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 2104 (class 1259 OID 16847)
-- Dependencies: 2103 7
-- Name: dbavaliacoes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbavaliacoes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 4073 (class 0 OID 0)
-- Dependencies: 2104
-- Name: dbavaliacoes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dbavaliacoes_id_seq OWNED BY dbavaliacoes.id;


--
-- TOC entry 2105 (class 1259 OID 16849)
-- Dependencies: 2793 2794 2795 2796 7
-- Name: dbavaliacoes_regras; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbavaliacoes_regras (
    id integer NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(20),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    titulo character varying(100),
    observacoes text,
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 2106 (class 1259 OID 16859)
-- Dependencies: 2105 7
-- Name: dbavaliacoes_regras_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbavaliacoes_regras_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 4074 (class 0 OID 0)
-- Dependencies: 2106
-- Name: dbavaliacoes_regras_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dbavaliacoes_regras_id_seq OWNED BY dbavaliacoes_regras.id;


--
-- TOC entry 2107 (class 1259 OID 16861)
-- Dependencies: 7
-- Name: dbbalanco_patrimonial_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbbalanco_patrimonial_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2108 (class 1259 OID 16863)
-- Dependencies: 2797 2798 2799 2800 2801 2802 2803 2804 2805 2806 2807 2808 2809 2810 2811 2812 2813 2814 2815 2816 2817 2818 2819 2820 2821 2822 2823 7
-- Name: dbbalanco_patrimonial; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbbalanco_patrimonial (
    id integer DEFAULT nextval('dbbalanco_patrimonial_id_seq'::regclass) NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    totcirculanteativo real DEFAULT 0.00,
    totcaixaativo real DEFAULT 0.00,
    totreceberativo real DEFAULT 0.00,
    estoqueativo real DEFAULT 0.00,
    despantecipadasativo real DEFAULT 0.00,
    realizavelativo real DEFAULT 0.00,
    totpermaneteativo real DEFAULT 0.00,
    maquinarioativo real DEFAULT 0.00,
    prediosativo real DEFAULT 0.00,
    moveisativo real DEFAULT 0.00,
    veiculosativo real DEFAULT 0.00,
    totalativo real DEFAULT 0.00,
    totpermanentepassivo real DEFAULT 0.00,
    funcionariospassivo real DEFAULT 0.00,
    tributospassivo real DEFAULT 0.00,
    fornecedorespassivo real DEFAULT 0.00,
    exigivelpassivo real DEFAULT 0.00,
    totcirculantepassivo real DEFAULT 0.00,
    patrimonioliquidopassivo real DEFAULT 0.00,
    capitalsocialpassivo real DEFAULT 0.00,
    lucroprejuizopassivo real DEFAULT 0.00,
    totalpassivo real DEFAULT 0.00,
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 2109 (class 1259 OID 16893)
-- Dependencies: 7
-- Name: dbbiblioteca_cdu_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbbiblioteca_cdu_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2110 (class 1259 OID 16895)
-- Dependencies: 2824 2825 2826 2827 2828 7
-- Name: dbbiblioteca_cdu; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbbiblioteca_cdu (
    id integer DEFAULT nextval('dbbiblioteca_cdu_id_seq'::regclass) NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    cdu character varying(30),
    titulo character varying(200),
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 2111 (class 1259 OID 16903)
-- Dependencies: 7
-- Name: dbcaixa_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbcaixa_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2112 (class 1259 OID 16905)
-- Dependencies: 2829 2830 2831 2832 2833 2834 2835 2836 2837 2838 7
-- Name: dbcaixa; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbcaixa (
    id integer DEFAULT nextval('dbcaixa_id_seq'::regclass) NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    codigoconta character varying(30),
    codigoplanoconta character varying(30),
    codigocontacaixa character varying(30),
    codigopessoa character varying(30),
    codigotransacao character varying(30),
    numdoc character varying(40),
    datadocumento date,
    tipomovimentacao character varying(20),
    tipoduplicata character varying(20),
    valorreal real,
    vencimento date,
    formadesconto character varying(4) DEFAULT 'vl'::character varying NOT NULL,
    desconto real DEFAULT 0 NOT NULL,
    multaacrecimo real DEFAULT 0 NOT NULL,
    valorpago real,
    valorentrada real,
    codigofuncionario character varying(30),
    datapag date,
    formapag character varying(20),
    mora real,
    obs text,
    statusmovimento character varying(20) DEFAULT '1'::character varying,
    statusconta character varying(2) DEFAULT '2'::character varying NOT NULL,
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL,
    codigohistorico character varying(30)
);


--
-- TOC entry 4075 (class 0 OID 0)
-- Dependencies: 2112
-- Name: COLUMN dbcaixa.valorreal; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbcaixa.valorreal IS 'Valor real da conta, sem acresciomos e descontos. Esse valor é o valor atual da conta que pode ser diferente do valor nominal inicial.';


--
-- TOC entry 4076 (class 0 OID 0)
-- Dependencies: 2112
-- Name: COLUMN dbcaixa.statusmovimento; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbcaixa.statusmovimento IS 'Status do movimento do caixa

1 = Movimento em aberto
2 = Movimento conferido
3 = Movimento programado
4 = Movimento extornado
5 = Movimento Consolidado';


--
-- TOC entry 2113 (class 1259 OID 16921)
-- Dependencies: 7
-- Name: dbcaixa_fechamentos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbcaixa_fechamentos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2114 (class 1259 OID 16923)
-- Dependencies: 2839 2840 2841 2842 2843 7
-- Name: dbcaixa_fechamentos; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbcaixa_fechamentos (
    id integer DEFAULT nextval('dbcaixa_fechamentos_id_seq'::regclass) NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    valorprevisto real,
    receitatotal real,
    despesatotal real,
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 2115 (class 1259 OID 16931)
-- Dependencies: 7
-- Name: dbcaixa_funcionarios_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbcaixa_funcionarios_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2116 (class 1259 OID 16933)
-- Dependencies: 2844 2845 2846 2847 2848 2849 7
-- Name: dbcaixa_funcionarios; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbcaixa_funcionarios (
    id integer DEFAULT nextval('dbcaixa_funcionarios_id_seq'::regclass) NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    codigofuncionario character varying(30),
    obs text,
    titulo character varying(120),
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL,
    situacao character varying(10) DEFAULT '1'::character varying,
    codigocontacaixa character varying(30)
);


--
-- TOC entry 4077 (class 0 OID 0)
-- Dependencies: 2116
-- Name: COLUMN dbcaixa_funcionarios.situacao; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbcaixa_funcionarios.situacao IS '1 = Liberado para Movimentações
2 = Aguardando Liberação';


--
-- TOC entry 2117 (class 1259 OID 16945)
-- Dependencies: 7
-- Name: dbcargos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbcargos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2118 (class 1259 OID 16947)
-- Dependencies: 2850 2851 2852 2853 2854 2855 7
-- Name: dbcargos; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbcargos (
    id integer DEFAULT nextval('dbcargos_id_seq'::regclass) NOT NULL,
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
-- TOC entry 2119 (class 1259 OID 16959)
-- Dependencies: 7
-- Name: dbceps_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbceps_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2120 (class 1259 OID 16961)
-- Dependencies: 7
-- Name: dbcidades_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbcidades_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2121 (class 1259 OID 16963)
-- Dependencies: 7
-- Name: dbcompras_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbcompras_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2122 (class 1259 OID 16965)
-- Dependencies: 2856 2857 2858 2859 2860 2861 7
-- Name: dbcompras; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbcompras (
    id integer DEFAULT nextval('dbcompras_id_seq'::regclass) NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    codigoproduto character varying(30),
    valorunitario real DEFAULT 0.00,
    tempoentrega character varying(20),
    quantidade character varying(20),
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 2123 (class 1259 OID 16974)
-- Dependencies: 7
-- Name: dbcontas_caixa_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbcontas_caixa_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2124 (class 1259 OID 16976)
-- Dependencies: 2862 2863 2864 2865 2866 2867 2868 2869 7
-- Name: dbcontas_caixa; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbcontas_caixa (
    id integer DEFAULT nextval('dbcontas_caixa_id_seq'::regclass) NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    nomeconta character varying(80),
    tipoconta character varying(25),
    banco character varying(60) DEFAULT '-'::character varying NOT NULL,
    numconta character varying(12) DEFAULT '-'::character varying NOT NULL,
    agencia character varying(8) DEFAULT '-'::character varying NOT NULL,
    saldoinicial real,
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL,
    situacao character varying(10)
);


--
-- TOC entry 4078 (class 0 OID 0)
-- Dependencies: 2124
-- Name: COLUMN dbcontas_caixa.situacao; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbcontas_caixa.situacao IS '1 = Liberado para Movimentações.
2 = Aguardando liberação.';


--
-- TOC entry 2125 (class 1259 OID 16987)
-- Dependencies: 7
-- Name: dbcontas_caixa_historico_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbcontas_caixa_historico_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2126 (class 1259 OID 16989)
-- Dependencies: 2870 2871 2872 2873 2874 7
-- Name: dbcontas_caixa_historico; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbcontas_caixa_historico (
    id integer DEFAULT nextval('dbcontas_caixa_historico_id_seq'::regclass) NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    codigocontacaixa character varying(30),
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL,
    datainicio date,
    datafim date
);


--
-- TOC entry 2127 (class 1259 OID 16997)
-- Dependencies: 7
-- Name: dbcontas_cheques_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbcontas_cheques_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2128 (class 1259 OID 16999)
-- Dependencies: 2875 2876 2877 2878 2879 7
-- Name: dbcontas_cheques; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbcontas_cheques (
    id integer DEFAULT nextval('dbcontas_cheques_id_seq'::regclass) NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    codigopessoa character varying(30),
    nometitular character varying(180),
    banco character varying(120),
    agencia character varying(45),
    numconta character varying(45),
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL,
    obs text,
    codigocaixa character varying(30),
    codigoconta character varying(30),
    numcheque character varying(240),
    cpf_cnpj character varying(20),
    valor real
);


--
-- TOC entry 2129 (class 1259 OID 17010)
-- Dependencies: 7
-- Name: dbcontratos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbcontratos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2130 (class 1259 OID 17012)
-- Dependencies: 2880 2881 2882 2883 2884 7
-- Name: dbcontratos; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbcontratos (
    id integer DEFAULT nextval('dbcontratos_id_seq'::regclass) NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    codigopessoa character varying(30),
    tipodocumento character varying(20),
    dataassinatura date,
    datatermino date,
    arquivo text,
    codigoproduto character varying(30),
    tipoassinatura character varying(1),
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 2131 (class 1259 OID 17023)
-- Dependencies: 7
-- Name: dbconvenios_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbconvenios_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2132 (class 1259 OID 17025)
-- Dependencies: 2885 2886 2887 7
-- Name: dbconvenios; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbconvenios (
    id integer DEFAULT nextval('dbconvenios_id_seq'::regclass) NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(20) NOT NULL,
    codigoautor character varying(20) NOT NULL,
    codigopessoa character varying(20),
    titulo character varying(100),
    descricao text,
    tipoconvenio character varying(1),
    tipotransacao integer,
    valor real,
    formato integer,
    datavigencia date,
    datacad date,
    ativo character varying(2) DEFAULT 9 NOT NULL,
    codigoplanoconta character varying(20)
);


--
-- TOC entry 4079 (class 0 OID 0)
-- Dependencies: 2132
-- Name: COLUMN dbconvenios.tipoconvenio; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbconvenios.tipoconvenio IS 'Tipo de convênio.

1 = Desconto
2 = Bolsa
3 = Parceria';


--
-- TOC entry 4080 (class 0 OID 0)
-- Dependencies: 2132
-- Name: COLUMN dbconvenios.tipotransacao; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbconvenios.tipotransacao IS 'tipo da transação a ser gerada pela associação do convênio a uma pessoa

1 = crédito
2 = débito';


--
-- TOC entry 4081 (class 0 OID 0)
-- Dependencies: 2132
-- Name: COLUMN dbconvenios.valor; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbconvenios.valor IS 'valor do crédito/débito a ser gerado em função do escobo do convênio';


--
-- TOC entry 4082 (class 0 OID 0)
-- Dependencies: 2132
-- Name: COLUMN dbconvenios.formato; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbconvenios.formato IS 'formato do valor

1 = valor
2 = percentual';


--
-- TOC entry 4083 (class 0 OID 0)
-- Dependencies: 2132
-- Name: COLUMN dbconvenios.datavigencia; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbconvenios.datavigencia IS 'data em que o convênio entra em vigor.';


--
-- TOC entry 2133 (class 1259 OID 17034)
-- Dependencies: 2889 2890 2891 2892 7
-- Name: dbconvenios_descontos; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbconvenios_descontos (
    id integer NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    codigoconvenio character varying(20),
    dialimite character varying(2),
    valor double precision,
    obs text,
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 2134 (class 1259 OID 17044)
-- Dependencies: 2133 7
-- Name: dbconvenios_descontos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbconvenios_descontos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 4084 (class 0 OID 0)
-- Dependencies: 2134
-- Name: dbconvenios_descontos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dbconvenios_descontos_id_seq OWNED BY dbconvenios_descontos.id;


--
-- TOC entry 2135 (class 1259 OID 17046)
-- Dependencies: 7
-- Name: dbcotacoes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbcotacoes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2136 (class 1259 OID 17048)
-- Dependencies: 2893 2894 2895 2896 2897 7
-- Name: dbcotacoes; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbcotacoes (
    id integer DEFAULT nextval('dbcotacoes_id_seq'::regclass) NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    codigoproduto character varying(30),
    codigofornecedor character varying(30),
    preco real,
    entrega character varying(10),
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 2137 (class 1259 OID 17056)
-- Dependencies: 7
-- Name: dbcrm_demandas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbcrm_demandas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2138 (class 1259 OID 17058)
-- Dependencies: 2898 2899 2900 2901 2902 7
-- Name: dbcrm_demandas; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbcrm_demandas (
    id integer DEFAULT nextval('dbcrm_demandas_id_seq'::regclass) NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    nome character varying(180),
    curso character varying(180),
    email character varying(180),
    telefone character varying(180),
    turno character varying(100),
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 2139 (class 1259 OID 17069)
-- Dependencies: 7
-- Name: dbcurriculos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbcurriculos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2140 (class 1259 OID 17071)
-- Dependencies: 2903 2904 2905 2906 2907 7
-- Name: dbcurriculos; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbcurriculos (
    id integer DEFAULT nextval('dbcurriculos_id_seq'::regclass) NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    nome character varying(60),
    sexo character varying(1),
    datanasc date,
    cpf character varying(15),
    logadouro character varying(80),
    cidade character varying(60),
    estado character varying(2),
    bairro character varying(10),
    telefone character varying(20),
    celular character varying(20),
    email character varying(40),
    estadocivil character varying(20),
    cnh character varying(20),
    dependentes character varying(2),
    idiomas text,
    areainteresse character varying(200),
    areainteresse2 character varying(200),
    areainteresse3 character varying(200),
    escolaridade character varying(35),
    cursos text,
    experiencia text,
    obs text,
    resumo text,
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 2141 (class 1259 OID 17082)
-- Dependencies: 7
-- Name: dbcursos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbcursos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2142 (class 1259 OID 17084)
-- Dependencies: 2908 2909 2910 2911 2912 7
-- Name: dbcursos; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbcursos (
    id integer DEFAULT nextval('dbcursos_id_seq'::regclass) NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    nome character varying(200),
    codigotipocurso character varying(30),
    codigoareacurso character varying(30),
    objetivocurso text,
    publicoalvo text,
    cargahortotal character varying(15),
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL,
    mercadodetrabalho text,
    codigograde character varying(20)
);


--
-- TOC entry 2143 (class 1259 OID 17095)
-- Dependencies: 7
-- Name: dbcursos_areas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbcursos_areas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2144 (class 1259 OID 17097)
-- Dependencies: 2913 2914 2915 2916 2917 7
-- Name: dbcursos_areas; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbcursos_areas (
    id integer DEFAULT nextval('dbcursos_areas_id_seq'::regclass) NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    titulo character varying(200),
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL,
    descricao text
);


--
-- TOC entry 2145 (class 1259 OID 17108)
-- Dependencies: 7
-- Name: dbcursos_ativos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbcursos_ativos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2146 (class 1259 OID 17110)
-- Dependencies: 2918 2919 2920 2921 2922 7
-- Name: dbcursos_ativos; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbcursos_ativos (
    id integer DEFAULT nextval('dbcursos_ativos_id_seq'::regclass) NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    titulo character varying(200),
    codigocurso character varying(20),
    obs text,
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 2147 (class 1259 OID 17121)
-- Dependencies: 7
-- Name: dbcursos_avaliacoes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbcursos_avaliacoes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2148 (class 1259 OID 17123)
-- Dependencies: 2923 2924 2925 2926 2927 7
-- Name: dbcursos_avaliacoes; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbcursos_avaliacoes (
    id integer DEFAULT nextval('dbcursos_avaliacoes_id_seq'::regclass) NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    codigocurso character varying(30),
    avaliacao character varying(80),
    notamax real,
    peso integer,
    codigopai character varying(20),
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL,
    ordem character varying(5)
);


--
-- TOC entry 2149 (class 1259 OID 17131)
-- Dependencies: 7
-- Name: dbcursos_disciplinas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbcursos_disciplinas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2150 (class 1259 OID 17133)
-- Dependencies: 2928 2929 2930 2931 2932 7
-- Name: dbcursos_disciplinas; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbcursos_disciplinas (
    id integer DEFAULT nextval('dbcursos_disciplinas_id_seq'::regclass) NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    codigocurso character varying(30),
    codigodisciplina character varying(30),
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 2151 (class 1259 OID 17141)
-- Dependencies: 7
-- Name: dbcursos_tipos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbcursos_tipos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2152 (class 1259 OID 17143)
-- Dependencies: 2933 2934 2935 2936 2937 7
-- Name: dbcursos_tipos; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbcursos_tipos (
    id integer DEFAULT nextval('dbcursos_tipos_id_seq'::regclass) NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    titulo character varying(200),
    obs text,
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 2153 (class 1259 OID 17154)
-- Dependencies: 7
-- Name: dbdados_boleto_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbdados_boleto_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2154 (class 1259 OID 17156)
-- Dependencies: 2938 2939 2940 2941 2942 2943 7
-- Name: dbdados_boleto; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbdados_boleto (
    id integer DEFAULT nextval('dbdados_boleto_id_seq'::regclass) NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    codigocontacaixa character varying(20),
    agencia character varying(10),
    conta character varying(10),
    digito character varying(5),
    carteira character varying(4),
    identificacao character varying(60),
    cpf_cnpj character varying(30),
    endereco character varying(120),
    cidade_uf character varying(80),
    cedente character varying(60),
    taxa_administrativa character varying(60),
    moeda character varying(4),
    dias_prazo character varying(4),
    instrucao1 character varying(120),
    instrucao2 character varying(120),
    instrucao3 character varying(80),
    instrucao4 character varying(80),
    inst_cliente1 character varying(80),
    inst_cliente2 character varying(80),
    tipoduplicata character varying(2) DEFAULT '-'::bpchar NOT NULL,
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 2155 (class 1259 OID 17168)
-- Dependencies: 7
-- Name: dbdepartamentos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbdepartamentos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2156 (class 1259 OID 17170)
-- Dependencies: 2944 2945 2946 2947 2948 7
-- Name: dbdepartamentos; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbdepartamentos (
    id integer DEFAULT nextval('dbdepartamentos_id_seq'::regclass) NOT NULL,
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
-- TOC entry 2157 (class 1259 OID 17181)
-- Dependencies: 7
-- Name: dbdisciplinas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbdisciplinas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2158 (class 1259 OID 17183)
-- Dependencies: 2949 2950 2951 2952 2953 7
-- Name: dbdisciplinas; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbdisciplinas (
    id integer DEFAULT nextval('dbdisciplinas_id_seq'::regclass) NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    titulo character varying(200),
    ementa text,
    programa text,
    competencias text,
    cargahoraria integer,
    biografia text,
    metodologia text,
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 2159 (class 1259 OID 17194)
-- Dependencies: 7
-- Name: dbdisciplinas_semelhantes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbdisciplinas_semelhantes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2160 (class 1259 OID 17196)
-- Dependencies: 2954 2955 2956 2957 2958 7
-- Name: dbdisciplinas_semelhantes; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbdisciplinas_semelhantes (
    id integer DEFAULT nextval('dbdisciplinas_semelhantes_id_seq'::regclass) NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    codigodisciplina character varying(30),
    codigodisciplinasemelhante character varying(30),
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 2161 (class 1259 OID 17204)
-- Dependencies: 7
-- Name: dbdocumentos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbdocumentos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2162 (class 1259 OID 17206)
-- Dependencies: 2959 2960 2961 2962 2963 7
-- Name: dbdocumentos; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbdocumentos (
    id integer DEFAULT nextval('dbdocumentos_id_seq'::regclass) NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    titulo character varying(80),
    tipo character varying(20),
    modelodocumento text,
    modeloassinaturadigital text,
    modeloassinaturareal text,
    modelotestemunha text,
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 2163 (class 1259 OID 17217)
-- Dependencies: 7
-- Name: dbestados_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbestados_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2164 (class 1259 OID 17219)
-- Dependencies: 7
-- Name: dbfuncionarios_ferias_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbfuncionarios_ferias_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2165 (class 1259 OID 17221)
-- Dependencies: 2964 2965 2966 2967 2968 7
-- Name: dbfuncionarios_ferias; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbfuncionarios_ferias (
    id integer DEFAULT nextval('dbfuncionarios_ferias_id_seq'::regclass) NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    codigofuncionario character varying(30),
    dataferiasprevisao date,
    diasferiasprevisao character varying(10),
    retornoferiasprevisao date,
    dataferiasreal date,
    diasferiasreal character varying(10),
    retornoferiasreal date,
    datalimite date,
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 2166 (class 1259 OID 17229)
-- Dependencies: 7
-- Name: dbfuncionarios_folhapagamento_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbfuncionarios_folhapagamento_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2167 (class 1259 OID 17231)
-- Dependencies: 2969 2970 2971 2972 2973 2974 2975 2976 2977 2978 2979 2980 2981 2982 2983 2984 2985 2986 2987 2988 2989 2990 2991 2992 7
-- Name: dbfuncionarios_folhapagamento; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbfuncionarios_folhapagamento (
    id integer DEFAULT nextval('dbfuncionarios_folhapagamento_id_seq'::regclass) NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    codigofuncionario character varying(30),
    nomecargo character varying(255),
    codcontadebito character varying(255),
    referencia character varying(10),
    salariobase real DEFAULT 0.00,
    comissao real DEFAULT 0.00,
    salariofamilia real DEFAULT 0.00,
    adpericulosidade real DEFAULT 0.00,
    adsalubridade real DEFAULT 0.00,
    horaextra real DEFAULT 0.00,
    ferias real DEFAULT 0.00,
    decimoterceiro real DEFAULT 0.00,
    licensamaternidade real DEFAULT 0.00,
    licensapaternidade real DEFAULT 0.00,
    licensacasamento real DEFAULT 0.00,
    licensaobito real DEFAULT 0.00,
    licensainvalidez real DEFAULT 0.00,
    valetransporte real DEFAULT 0.00,
    irpf real DEFAULT 0.00,
    inss real DEFAULT 0.00,
    contrsindical real DEFAULT 0.00,
    totalbruto real DEFAULT 0.00,
    totalliquido real DEFAULT 0.00,
    diastrabalhados character varying(2),
    vencimento character varying(10),
    datapag date,
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 2168 (class 1259 OID 17261)
-- Dependencies: 7
-- Name: dbfuncionarios_ocorrencias_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbfuncionarios_ocorrencias_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2169 (class 1259 OID 17263)
-- Dependencies: 2993 2994 2995 2996 2997 7
-- Name: dbfuncionarios_ocorrencias; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbfuncionarios_ocorrencias (
    id integer DEFAULT nextval('dbfuncionarios_ocorrencias_id_seq'::regclass) NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    codigofuncionario character varying(30),
    titulo character varying(180),
    descricao text,
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 2170 (class 1259 OID 17274)
-- Dependencies: 7
-- Name: dbfuncionarios_professores_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbfuncionarios_professores_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2171 (class 1259 OID 17276)
-- Dependencies: 2998 2999 3000 3001 3002 7
-- Name: dbfuncionarios_professores; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbfuncionarios_professores (
    id integer DEFAULT nextval('dbfuncionarios_professores_id_seq'::regclass) NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    codigofuncionario character varying(30),
    curriculo text,
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 2172 (class 1259 OID 17287)
-- Dependencies: 7
-- Name: dbfuncionarios_treinamentos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbfuncionarios_treinamentos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2173 (class 1259 OID 17289)
-- Dependencies: 3003 3004 3005 3006 3007 7
-- Name: dbfuncionarios_treinamentos; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbfuncionarios_treinamentos (
    id integer DEFAULT nextval('dbfuncionarios_treinamentos_id_seq'::regclass) NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    codigotreinamento character varying(30),
    codigofuncionario character varying(30),
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 2174 (class 1259 OID 17297)
-- Dependencies: 3009 3010 3011 3012 7
-- Name: dbgrade_avaliacoes; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbgrade_avaliacoes (
    id integer NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(20),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    titulo character varying(100),
    observacoes text,
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 2175 (class 1259 OID 17307)
-- Dependencies: 2174 7
-- Name: dbgrade_avaliacoes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbgrade_avaliacoes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 4085 (class 0 OID 0)
-- Dependencies: 2175
-- Name: dbgrade_avaliacoes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dbgrade_avaliacoes_id_seq OWNED BY dbgrade_avaliacoes.id;


--
-- TOC entry 2176 (class 1259 OID 17309)
-- Dependencies: 7
-- Name: dbpaises_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbpaises_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2177 (class 1259 OID 17311)
-- Dependencies: 7
-- Name: dbpatrimonios_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbpatrimonios_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2178 (class 1259 OID 17313)
-- Dependencies: 3013 3014 3015 3016 3017 3018 3019 3020 7
-- Name: dbpatrimonios; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbpatrimonios (
    id integer DEFAULT nextval('dbpatrimonios_id_seq'::regclass) NOT NULL,
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
    foto character varying(255) DEFAULT '../app.view/app.images/imgnotfound.jpg'::character varying,
    obs text,
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 2179 (class 1259 OID 17327)
-- Dependencies: 7
-- Name: dbpatrimonios_livros_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbpatrimonios_livros_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2180 (class 1259 OID 17329)
-- Dependencies: 3021 3022 3023 3024 3025 7
-- Name: dbpatrimonios_livros; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbpatrimonios_livros (
    id integer DEFAULT nextval('dbpatrimonios_livros_id_seq'::regclass) NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    codigopatrimonio character varying(30),
    autor character varying(200),
    outrosautores text,
    ano smallint,
    isbn character varying(80),
    idioma character varying(80),
    paginas character varying(60),
    codigopha character varying(30),
    codigocdu character varying(30),
    tradutor character varying(180),
    sinopse text,
    sumario text,
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL,
    volume character varying(40),
    exemplar character varying(40)
);


--
-- TOC entry 2181 (class 1259 OID 17340)
-- Dependencies: 7
-- Name: dbpessoas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbpessoas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2182 (class 1259 OID 17342)
-- Dependencies: 3026 3027 3028 3029 3030 3031 3032 3033 3034 3035 7
-- Name: dbpessoas; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbpessoas (
    id integer DEFAULT nextval('dbpessoas_id_seq'::regclass) NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    tipo character varying(20) DEFAULT 'F'::character varying,
    nome_razaosocial character varying(160),
    cpf_cnpj character varying(20),
    rg_inscest character varying(20),
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
    foto text
);


--
-- TOC entry 2183 (class 1259 OID 17358)
-- Dependencies: 7
-- Name: dbpessoas_alunos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbpessoas_alunos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2184 (class 1259 OID 17360)
-- Dependencies: 3036 3037 3038 3039 3040 7
-- Name: dbpessoas_alunos; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbpessoas_alunos (
    id integer DEFAULT nextval('dbpessoas_alunos_id_seq'::regclass) NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    codigopessoa character varying(30),
    codigotransacao character varying(30),
    codigoturma character varying(30),
    codigocurso character varying(30),
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 2185 (class 1259 OID 17368)
-- Dependencies: 7
-- Name: dbpessoas_complemento_pf_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbpessoas_complemento_pf_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2186 (class 1259 OID 17370)
-- Dependencies: 3041 3042 3043 3044 3045 7
-- Name: dbpessoas_complemento_pf; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbpessoas_complemento_pf (
    id integer DEFAULT nextval('dbpessoas_complemento_pf_id_seq'::regclass) NOT NULL,
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
    portadornecessidades character varying(20),
    necessidadesespeciais text,
    numerodependentes character varying(10),
    cnh character varying(40),
    carteirareservista character varying(40),
    rendamensal real,
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 2187 (class 1259 OID 17381)
-- Dependencies: 7
-- Name: dbpessoas_complemento_pj_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbpessoas_complemento_pj_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2188 (class 1259 OID 17383)
-- Dependencies: 3046 3047 3048 3049 3050 7
-- Name: dbpessoas_complemento_pj; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbpessoas_complemento_pj (
    id integer DEFAULT nextval('dbpessoas_complemento_pj_id_seq'::regclass) NOT NULL,
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
-- TOC entry 2189 (class 1259 OID 17394)
-- Dependencies: 7
-- Name: dbpessoas_convenios_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbpessoas_convenios_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2190 (class 1259 OID 17396)
-- Dependencies: 3051 3052 3053 3054 3055 7
-- Name: dbpessoas_convenios; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbpessoas_convenios (
    id integer DEFAULT nextval('dbpessoas_convenios_id_seq'::regclass) NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    codigopessoa character varying(30),
    codigoconvenio character varying(30),
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 2191 (class 1259 OID 17404)
-- Dependencies: 7
-- Name: dbpessoas_demandas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbpessoas_demandas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2192 (class 1259 OID 17406)
-- Dependencies: 3056 3057 3058 3059 3060 7
-- Name: dbpessoas_demandas; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbpessoas_demandas (
    id integer DEFAULT nextval('dbpessoas_demandas_id_seq'::regclass) NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    codigopessoa character varying(30),
    codigocurso character varying(30),
    turno character varying(100),
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 2193 (class 1259 OID 17414)
-- Dependencies: 7
-- Name: dbpessoas_enderecoscobrancas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbpessoas_enderecoscobrancas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2194 (class 1259 OID 17416)
-- Dependencies: 3061 3062 3063 3064 3065 7
-- Name: dbpessoas_enderecoscobrancas; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbpessoas_enderecoscobrancas (
    id integer DEFAULT nextval('dbpessoas_enderecoscobrancas_id_seq'::regclass) NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    codigopessoa character varying(30),
    nomecobranca character varying(160),
    cpf_cnpjcobranca character varying(255),
    logradourocobranca character varying(255),
    cidadecobranca character varying(255),
    estadocobranca character varying(255),
    cepcobranca character varying(255),
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 2195 (class 1259 OID 17427)
-- Dependencies: 7
-- Name: dbpessoas_formacoes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbpessoas_formacoes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2196 (class 1259 OID 17429)
-- Dependencies: 3066 3067 3068 3069 3070 7
-- Name: dbpessoas_formacoes; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbpessoas_formacoes (
    id integer DEFAULT nextval('dbpessoas_formacoes_id_seq'::regclass) NOT NULL,
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
-- TOC entry 2197 (class 1259 OID 17440)
-- Dependencies: 7
-- Name: dbpessoas_funcionarios_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbpessoas_funcionarios_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2198 (class 1259 OID 17442)
-- Dependencies: 3071 3072 3073 3074 3075 7
-- Name: dbpessoas_funcionarios; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbpessoas_funcionarios (
    id integer DEFAULT nextval('dbpessoas_funcionarios_id_seq'::regclass) NOT NULL,
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
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 2199 (class 1259 OID 17453)
-- Dependencies: 7
-- Name: dbpessoas_inscricoes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbpessoas_inscricoes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2200 (class 1259 OID 17455)
-- Dependencies: 3076 3077 3078 3079 3080 3081 7
-- Name: dbpessoas_inscricoes; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbpessoas_inscricoes (
    id integer DEFAULT nextval('dbpessoas_inscricoes_id_seq'::regclass) NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    codigopessoa character varying(30),
    codigotransacao character varying(30),
    opcobranca character varying(20) DEFAULT '1'::character varying,
    codigoturma character varying(30),
    codigocurso character varying(30),
    vencimentomatricula date,
    vencimentotaxa date,
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 2201 (class 1259 OID 17464)
-- Dependencies: 7
-- Name: dbpessoas_livros_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbpessoas_livros_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2202 (class 1259 OID 17466)
-- Dependencies: 3082 3083 3084 3085 3086 3087 3088 3089 3090 3091 7
-- Name: dbpessoas_livros; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbpessoas_livros (
    id integer DEFAULT nextval('dbpessoas_livros_id_seq'::regclass) NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    codigopessoa character varying(30),
    codigolivro character varying(30),
    previsaosaida date DEFAULT ('now'::text)::date,
    previsaoentrada date DEFAULT ('now'::text)::date,
    confirmacaosaida date DEFAULT ('now'::text)::date,
    confirmacaoentrada date DEFAULT ('now'::text)::date,
    situacao character varying(2) DEFAULT '9'::character varying NOT NULL,
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 2203 (class 1259 OID 17479)
-- Dependencies: 7
-- Name: dbpessoas_solicitacoes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbpessoas_solicitacoes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2204 (class 1259 OID 17481)
-- Dependencies: 3092 3093 3094 3095 3096 7
-- Name: dbpessoas_solicitacoes; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbpessoas_solicitacoes (
    id integer DEFAULT nextval('dbpessoas_solicitacoes_id_seq'::regclass) NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    codigopessoa character varying(30),
    solicitacao character varying(255),
    data date,
    justificativa text,
    atendimento text,
    codigofuncionario character varying(30),
    codigodepartamento character varying(30),
    status character varying(2),
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 2205 (class 1259 OID 17492)
-- Dependencies: 7
-- Name: dbpessoas_titularidades_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbpessoas_titularidades_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2206 (class 1259 OID 17494)
-- Dependencies: 3097 3098 3099 3100 3101 7
-- Name: dbpessoas_titularidades; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbpessoas_titularidades (
    id integer DEFAULT nextval('dbpessoas_titularidades_id_seq'::regclass) NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    titularidade character varying(50),
    nomeacao character varying(30),
    peso character varying(2) DEFAULT '1'::character varying NOT NULL,
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 2207 (class 1259 OID 17502)
-- Dependencies: 7
-- Name: dbplano_contas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbplano_contas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2208 (class 1259 OID 17504)
-- Dependencies: 3102 3103 3104 3105 3106 3107 3108 7
-- Name: dbplano_contas; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbplano_contas (
    id integer DEFAULT nextval('dbplano_contas_id_seq'::regclass) NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    nomeconta character varying(60),
    tipoconta character varying(15) DEFAULT '-'::character varying NOT NULL,
    categoria character varying(20),
    tipocusto character varying(10) DEFAULT '-'::character varying NOT NULL,
    obs text,
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL,
    codigodescricao character varying(80)
);


--
-- TOC entry 2209 (class 1259 OID 17517)
-- Dependencies: 7
-- Name: dbprocessos_academicos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbprocessos_academicos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2210 (class 1259 OID 17519)
-- Dependencies: 3109 3110 3111 3112 3113 7
-- Name: dbprocessos_academicos; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbprocessos_academicos (
    id integer DEFAULT nextval('dbprocessos_academicos_id_seq'::regclass) NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    titulo character varying(200),
    procedimento text,
    requisitos text,
    alteratransacao character varying(2),
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL,
    formulario character varying(10)
);


--
-- TOC entry 2211 (class 1259 OID 17530)
-- Dependencies: 7
-- Name: dbprodutos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbprodutos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2212 (class 1259 OID 17532)
-- Dependencies: 3114 3115 3116 3117 3118 3119 3120 7
-- Name: dbprodutos; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbprodutos (
    id integer DEFAULT nextval('dbprodutos_id_seq'::regclass) NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    label character varying(200),
    descricao text,
    valor real DEFAULT 0.00,
    valoralteravel character varying(2) DEFAULT '1'::character varying NOT NULL,
    tabela character varying(30),
    obs text,
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL,
    codigotipoproduto character varying(30)
);


--
-- TOC entry 2213 (class 1259 OID 17545)
-- Dependencies: 7
-- Name: dbprodutos_caracteristicas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbprodutos_caracteristicas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2214 (class 1259 OID 17547)
-- Dependencies: 3121 3122 3123 3124 3125 7
-- Name: dbprodutos_caracteristicas; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbprodutos_caracteristicas (
    id integer DEFAULT nextval('dbprodutos_caracteristicas_id_seq'::regclass) NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    codigoproduto character varying(30),
    beneficios text,
    limitacoes text,
    mododeuso text,
    unid character varying(50),
    qtde character varying(20),
    cor character varying(20),
    tamanho character varying(20),
    peso character varying(20),
    altura character varying(20),
    largura character varying(20),
    comprimento character varying(20),
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 2215 (class 1259 OID 17558)
-- Dependencies: 7
-- Name: dbprodutos_financeiro_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbprodutos_financeiro_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2216 (class 1259 OID 17560)
-- Dependencies: 7
-- Name: dbprodutos_formulacao_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbprodutos_formulacao_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2217 (class 1259 OID 17562)
-- Dependencies: 7
-- Name: dbprodutos_midia_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbprodutos_midia_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2218 (class 1259 OID 17564)
-- Dependencies: 7
-- Name: dbprodutos_parametros_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbprodutos_parametros_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2219 (class 1259 OID 17566)
-- Dependencies: 3126 3127 3128 3129 3130 7
-- Name: dbprodutos_parametros; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbprodutos_parametros (
    id integer DEFAULT nextval('dbprodutos_parametros_id_seq'::regclass) NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    codigoproduto character varying(30),
    tabela character varying(60),
    collabel character varying(60),
    colvalor character varying(200),
    coldesc character varying(80),
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL,
    codigotipoproduto character varying(30)
);


--
-- TOC entry 2220 (class 1259 OID 17577)
-- Dependencies: 7
-- Name: dbprodutos_tabelapreco_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbprodutos_tabelapreco_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2221 (class 1259 OID 17579)
-- Dependencies: 3131 3132 3133 3134 3135 7
-- Name: dbprodutos_tabelapreco; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbprodutos_tabelapreco (
    id integer DEFAULT nextval('dbprodutos_tabelapreco_id_seq'::regclass) NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    codigoproduto character varying(30),
    nometabela character varying(60) NOT NULL,
    tipotabela character varying(2) NOT NULL,
    fator real NOT NULL,
    tipofator character varying(1) NOT NULL,
    entrada real,
    numparcelas integer,
    comissao real,
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 2222 (class 1259 OID 17587)
-- Dependencies: 7
-- Name: dbprodutos_tipos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbprodutos_tipos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2223 (class 1259 OID 17589)
-- Dependencies: 3136 3137 3138 3139 3140 7
-- Name: dbprodutos_tipos; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbprodutos_tipos (
    id integer DEFAULT nextval('dbprodutos_tipos_id_seq'::regclass) NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    titulo character varying(200),
    obs text,
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 2224 (class 1259 OID 17600)
-- Dependencies: 7
-- Name: dbprodutos_tributos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbprodutos_tributos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2225 (class 1259 OID 17602)
-- Dependencies: 3141 3142 3143 3144 3145 7
-- Name: dbprodutos_tributos; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbprodutos_tributos (
    id integer DEFAULT nextval('dbprodutos_tributos_id_seq'::regclass) NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    codigoproduto character varying(30),
    codigotributo character varying(30),
    nometributo character varying(70),
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 2226 (class 1259 OID 17610)
-- Dependencies: 7
-- Name: dbprofessores_areas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbprofessores_areas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2227 (class 1259 OID 17612)
-- Dependencies: 3146 3147 3148 3149 3150 7
-- Name: dbprofessores_areas; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbprofessores_areas (
    id integer DEFAULT nextval('dbprofessores_areas_id_seq'::regclass) NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    codigoprofessor character varying(30),
    codigoareacurso character varying(30),
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 2228 (class 1259 OID 17620)
-- Dependencies: 7
-- Name: dbprojetos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbprojetos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2229 (class 1259 OID 17622)
-- Dependencies: 3151 3152 3153 3154 3155 7
-- Name: dbprojetos; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbprojetos (
    id integer DEFAULT nextval('dbprojetos_id_seq'::regclass) NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    codigoproduto character varying(30),
    titulo character varying(180),
    responsavelnome character varying(180),
    responsavelfuncao character varying(180),
    objetivo text,
    prazo character varying(10),
    resumo text,
    descrisco text,
    medidasrisco text,
    descresultado text,
    receitapropria real,
    receitaclientes real,
    receitaparceiros real,
    receitafornecedores real,
    receitatotal real,
    recursostotal real,
    custostotal real,
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 2230 (class 1259 OID 17633)
-- Dependencies: 7
-- Name: dbprojetos_colaboradores_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbprojetos_colaboradores_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2231 (class 1259 OID 17635)
-- Dependencies: 3156 3157 3158 3159 3160 7
-- Name: dbprojetos_colaboradores; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbprojetos_colaboradores (
    id integer DEFAULT nextval('dbprojetos_colaboradores_id_seq'::regclass) NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    codigoprojeto character varying(30),
    codigopessoa character varying(30),
    funcao character varying(20),
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 2232 (class 1259 OID 17643)
-- Dependencies: 7
-- Name: dbprojetos_custos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbprojetos_custos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2233 (class 1259 OID 17645)
-- Dependencies: 3161 3162 3163 3164 3165 7
-- Name: dbprojetos_custos; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbprojetos_custos (
    id integer DEFAULT nextval('dbprojetos_custos_id_seq'::regclass) NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    codigoprojeto character varying(30),
    item character varying(180),
    valor real,
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 2234 (class 1259 OID 17653)
-- Dependencies: 7
-- Name: dbprojetos_recursos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbprojetos_recursos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2235 (class 1259 OID 17655)
-- Dependencies: 3166 3167 3168 3169 3170 7
-- Name: dbprojetos_recursos; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbprojetos_recursos (
    id integer DEFAULT nextval('dbprojetos_recursos_id_seq'::regclass) NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    codigoprojeto character varying(30),
    recurso character varying(180),
    quantidade character varying(10),
    tempo character varying(10),
    tipouso character varying(50),
    custounitario real,
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 2236 (class 1259 OID 17663)
-- Dependencies: 7
-- Name: dbquestionarios_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbquestionarios_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2237 (class 1259 OID 17665)
-- Dependencies: 3171 3172 3173 3174 3175 7
-- Name: dbquestionarios; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbquestionarios (
    id integer DEFAULT nextval('dbquestionarios_id_seq'::regclass) NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    titulo character varying(200),
    datainicio date,
    datafim date,
    numquestoes integer,
    numquestoesmax integer,
    numtentativas integer,
    obs text,
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 2238 (class 1259 OID 17676)
-- Dependencies: 7
-- Name: dbquestoes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbquestoes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2239 (class 1259 OID 17678)
-- Dependencies: 3176 3177 3178 3179 3180 7
-- Name: dbquestoes; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbquestoes (
    id integer DEFAULT nextval('dbquestoes_id_seq'::regclass) NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    codigoquestionario character varying(30),
    enunciado text,
    tipoquestao character varying(2),
    valorquestao integer,
    obs text,
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 2240 (class 1259 OID 17689)
-- Dependencies: 7
-- Name: dbquestoes_itens_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbquestoes_itens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2241 (class 1259 OID 17691)
-- Dependencies: 3181 3182 3183 3184 3185 7
-- Name: dbquestoes_itens; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbquestoes_itens (
    id integer DEFAULT nextval('dbquestoes_itens_id_seq'::regclass) NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    codigoquestao character varying(30),
    enunciado text,
    valoritem integer,
    obs text,
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 2242 (class 1259 OID 17702)
-- Dependencies: 7
-- Name: dbrecados_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbrecados_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2243 (class 1259 OID 17704)
-- Dependencies: 3186 3187 3188 3189 3190 3191 7
-- Name: dbrecados; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbrecados (
    id integer DEFAULT nextval('dbrecados_id_seq'::regclass) NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying,
    nomepessoa character varying(255),
    referencia character varying(255),
    interessado character varying(255),
    obs text,
    tel1 character varying(20),
    tel2 character varying(20),
    email character varying(255),
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL,
    situacao character varying(40) DEFAULT 'Aberto'::character varying,
    retorno date
);


--
-- TOC entry 2244 (class 1259 OID 17716)
-- Dependencies: 7
-- Name: dbsalas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbsalas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2245 (class 1259 OID 17718)
-- Dependencies: 3192 3193 3194 3195 3196 3197 7
-- Name: dbsalas; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbsalas (
    id integer DEFAULT nextval('dbsalas_id_seq'::regclass) NOT NULL,
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
-- TOC entry 2246 (class 1259 OID 17730)
-- Dependencies: 7
-- Name: dbscorecard_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbscorecard_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2247 (class 1259 OID 17732)
-- Dependencies: 3198 3199 3200 3201 3202 7
-- Name: dbscorecard; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbscorecard (
    id integer DEFAULT nextval('dbscorecard_id_seq'::regclass) NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    titulo character varying(200),
    meta double precision,
    pareto double precision,
    codigomodulo character varying(30),
    agrupamentoperiodico character varying(30),
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 2248 (class 1259 OID 17740)
-- Dependencies: 7
-- Name: dbscorecard_sentencas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbscorecard_sentencas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2249 (class 1259 OID 17742)
-- Dependencies: 3203 3204 3205 3206 3207 7
-- Name: dbscorecard_sentencas; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbscorecard_sentencas (
    id integer DEFAULT nextval('dbscorecard_sentencas_id_seq'::regclass) NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    codigoscorecard character varying(30),
    tabela character varying(200),
    colunax character varying(200),
    agrupamentox character varying(200),
    colunay character varying(200),
    agrupamentoy character varying(200),
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 2250 (class 1259 OID 17753)
-- Dependencies: 7
-- Name: dbstatus; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbstatus (
    id integer NOT NULL,
    situacao character varying(180),
    obs text
);


--
-- TOC entry 2251 (class 1259 OID 17759)
-- Dependencies: 2250 7
-- Name: dbstatus_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbstatus_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 4086 (class 0 OID 0)
-- Dependencies: 2251
-- Name: dbstatus_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dbstatus_id_seq OWNED BY dbstatus.id;


--
-- TOC entry 2252 (class 1259 OID 17761)
-- Dependencies: 7
-- Name: dbtransacoes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbtransacoes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2253 (class 1259 OID 17763)
-- Dependencies: 3209 3210 3211 3212 3213 3214 3215 3216 3217 3218 3219 3220 7
-- Name: dbtransacoes; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbtransacoes (
    id integer DEFAULT nextval('dbtransacoes_id_seq'::regclass) NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    codigopessoa character varying(30),
    tipomovimentacao character varying(20),
    valortotal real,
    desconto real DEFAULT 0.00,
    acrescimo real DEFAULT 0.00,
    valorcorrigido real DEFAULT 0.00,
    formapag character varying(255),
    codigoplanoconta character varying(30),
    numparcelas character varying(20) DEFAULT '0'::character varying,
    intervaloparcelas integer DEFAULT 0,
    datafixavencimento integer DEFAULT 0,
    vencimento date,
    efetivada character varying(2) DEFAULT '0'::character varying NOT NULL,
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL,
    obs text
);


--
-- TOC entry 2254 (class 1259 OID 17781)
-- Dependencies: 7
-- Name: dbtransacoes_contas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbtransacoes_contas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2255 (class 1259 OID 17783)
-- Dependencies: 3221 3222 3223 3224 3225 3226 3227 3228 7
-- Name: dbtransacoes_contas; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbtransacoes_contas (
    id integer DEFAULT nextval('dbtransacoes_contas_id_seq'::regclass) NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    codigotransacao character varying(30),
    codigopessoa character varying(30),
    codigoplanoconta character varying(30),
    tipomovimentacao character varying(3),
    valornominal real NOT NULL,
    numparcela integer,
    desconto real DEFAULT 0.00,
    vencimento date NOT NULL,
    obs text,
    statusconta integer DEFAULT 1 NOT NULL,
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL,
    valorreal real DEFAULT 0 NOT NULL,
    instrucoespagamento text
);


--
-- TOC entry 4087 (class 0 OID 0)
-- Dependencies: 2255
-- Name: COLUMN dbtransacoes_contas.statusconta; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbtransacoes_contas.statusconta IS 'Status da conta
1 = conta em aberto
2 = conta paga
3 = conta parcialmente paga
4 = conta extornada
5 = conta programada
6 = conta negociada
7 = conta anulada (sob regras de negócio)';


--
-- TOC entry 4088 (class 0 OID 0)
-- Dependencies: 2255
-- Name: COLUMN dbtransacoes_contas.valorreal; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbtransacoes_contas.valorreal IS 'Valor real da conta, considerando pagamentos parciais da conta.';


--
-- TOC entry 2256 (class 1259 OID 17797)
-- Dependencies: 7
-- Name: dbtransacoes_contas_duplicatas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbtransacoes_contas_duplicatas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2257 (class 1259 OID 17799)
-- Dependencies: 3229 3230 3231 3232 3233 3234 3235 7
-- Name: dbtransacoes_contas_duplicatas; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbtransacoes_contas_duplicatas (
    id integer DEFAULT nextval('dbtransacoes_contas_duplicatas_id_seq'::regclass) NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    codigoconta character varying(30),
    codigopessoa character varying(30),
    ndocumento character varying(60),
    dataprocesso date,
    cpfsacado character varying(15) DEFAULT '0'::character varying NOT NULL,
    valordoc real,
    vencimento date,
    databaixa date,
    statusduplicata integer DEFAULT 1,
    tipoduplicata character varying(2),
    classificacao character varying(30),
    bkp text,
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 2258 (class 1259 OID 17812)
-- Dependencies: 7
-- Name: dbtransacoes_contas_extornos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbtransacoes_contas_extornos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2259 (class 1259 OID 17814)
-- Dependencies: 3236 3237 3238 3239 3240 3241 7
-- Name: dbtransacoes_contas_extornos; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbtransacoes_contas_extornos (
    id integer DEFAULT nextval('dbtransacoes_contas_extornos_id_seq'::regclass) NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    codigocontaorigem character varying(30),
    codigocontadestino character varying(30),
    tipoextorno character varying(20),
    valor real DEFAULT 0.00,
    dataextorno date,
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 2382 (class 1259 OID 20275)
-- Dependencies: 3385 3386 3387 3388 7
-- Name: dbtransacoes_contas_situacao; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbtransacoes_contas_situacao (
    id integer NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    titulo character varying(200),
    obs text,
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 2381 (class 1259 OID 20273)
-- Dependencies: 2382 7
-- Name: dbtransacoes_contas_situacao_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbtransacoes_contas_situacao_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 4089 (class 0 OID 0)
-- Dependencies: 2381
-- Name: dbtransacoes_contas_situacao_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dbtransacoes_contas_situacao_id_seq OWNED BY dbtransacoes_contas_situacao.id;


--
-- TOC entry 2260 (class 1259 OID 17823)
-- Dependencies: 3243 3244 3245 3246 7
-- Name: dbtransacoes_convenios; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbtransacoes_convenios (
    id integer NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    codigotransacao character varying(30),
    codigoconvenio character varying(30),
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 2261 (class 1259 OID 17830)
-- Dependencies: 2260 7
-- Name: dbtransacoes_convenios_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbtransacoes_convenios_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 4090 (class 0 OID 0)
-- Dependencies: 2261
-- Name: dbtransacoes_convenios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dbtransacoes_convenios_id_seq OWNED BY dbtransacoes_convenios.id;


--
-- TOC entry 2262 (class 1259 OID 17832)
-- Dependencies: 7
-- Name: dbtransacoes_produtos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbtransacoes_produtos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2263 (class 1259 OID 17834)
-- Dependencies: 3247 3248 3249 3250 3251 3252 3253 7
-- Name: dbtransacoes_produtos; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbtransacoes_produtos (
    id integer DEFAULT nextval('dbtransacoes_produtos_id_seq'::regclass) NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    codigotransacao character varying(30),
    codigoproduto character varying(30),
    tabelaproduto character varying(30),
    valornominal real DEFAULT 0.00 NOT NULL,
    quantidade numeric DEFAULT 1.00 NOT NULL,
    obs text,
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 2264 (class 1259 OID 17847)
-- Dependencies: 7
-- Name: dbtreinamentos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbtreinamentos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2265 (class 1259 OID 17849)
-- Dependencies: 3254 3255 3256 3257 3258 7
-- Name: dbtreinamentos; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbtreinamentos (
    id integer DEFAULT nextval('dbtreinamentos_id_seq'::regclass) NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    nomecurso character varying(80),
    ementa text,
    cargahoraria character varying(5),
    ministrante character varying(80),
    codigotitularidade character varying(60),
    curriculoministrante text,
    instituicaocertificadora character varying(160),
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 2266 (class 1259 OID 17860)
-- Dependencies: 7
-- Name: dbtributos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbtributos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2267 (class 1259 OID 17862)
-- Dependencies: 3259 3260 3261 3262 3263 7
-- Name: dbtributos; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbtributos (
    id integer DEFAULT nextval('dbtributos_id_seq'::regclass) NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    tributo character varying(70),
    alicota real NOT NULL,
    operacaocfop character varying(30),
    tipo character varying(1),
    fatorgerador character varying(200),
    descricao text,
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 2268 (class 1259 OID 17873)
-- Dependencies: 7
-- Name: dbturmas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbturmas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2269 (class 1259 OID 17875)
-- Dependencies: 3264 3265 3266 3267 3268 3269 3270 3271 3272 3273 3274 3275 3276 3277 3278 3279 3280 3281 3282 3283 3284 3285 3286 3287 3288 7
-- Name: dbturmas; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbturmas (
    id integer DEFAULT nextval('dbturmas_id_seq'::regclass) NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    codigoproduto character varying(30),
    titulo character varying(150) DEFAULT '-'::character varying NOT NULL,
    codigocurso character varying(30),
    codigocursoativo character varying(30),
    cargahoraria integer,
    codigoplanoconta character varying(30),
    datainicio date,
    datafim date,
    frequenciaaula character varying(80),
    horainicio time without time zone,
    horafim time without time zone,
    diasaula character varying(20),
    localaulas character varying(255),
    valortotal real DEFAULT 0.00 NOT NULL,
    valortaxa real DEFAULT 0.00 NOT NULL,
    valormatricula real DEFAULT 0.00 NOT NULL,
    valormensal real DEFAULT 0.00 NOT NULL,
    valordescontado real DEFAULT 0.00 NOT NULL,
    numparcelas integer DEFAULT 1 NOT NULL,
    datavencimento date DEFAULT ('now'::text)::date NOT NULL,
    custolanche real DEFAULT 0.00,
    custovt real DEFAULT 0.00,
    custoapostila real DEFAULT 0.00,
    custobrinde real DEFAULT 0.00,
    custoparceiro real DEFAULT 0.00,
    custoaluguel real DEFAULT 0.00,
    custocertificado real DEFAULT 0.00,
    custodiversos real DEFAULT 0.00,
    coordenador character varying(20) DEFAULT '0'::character varying NOT NULL,
    status character varying(1) DEFAULT '0'::character varying,
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL,
    padraovencimento character varying(30) DEFAULT 0,
    acinscricao character varying(2) DEFAULT 1,
    vagas character varying(4),
    codigograde character varying(20)
);


--
-- TOC entry 2270 (class 1259 OID 17906)
-- Dependencies: 3290 3291 3292 3293 7
-- Name: dbturmas_convenios; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbturmas_convenios (
    id integer NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    codigoturma character varying(30),
    codigoconvenio character varying(30),
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 2271 (class 1259 OID 17913)
-- Dependencies: 2270 7
-- Name: dbturmas_convenios_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbturmas_convenios_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 4091 (class 0 OID 0)
-- Dependencies: 2271
-- Name: dbturmas_convenios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dbturmas_convenios_id_seq OWNED BY dbturmas_convenios.id;


--
-- TOC entry 2272 (class 1259 OID 17915)
-- Dependencies: 7
-- Name: dbturmas_descontos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbturmas_descontos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2273 (class 1259 OID 17917)
-- Dependencies: 3294 3295 3296 3297 3298 7
-- Name: dbturmas_descontos; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbturmas_descontos (
    id integer DEFAULT nextval('dbturmas_descontos_id_seq'::regclass) NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    codigoturma character varying(30),
    dialimite character varying(2),
    valordescontado double precision,
    tipodesconto character varying(1),
    obs text,
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 4092 (class 0 OID 0)
-- Dependencies: 2273
-- Name: COLUMN dbturmas_descontos.tipodesconto; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbturmas_descontos.tipodesconto IS '1 = Desconto Percentual / 2 = Desconto Fixo';


--
-- TOC entry 2274 (class 1259 OID 17928)
-- Dependencies: 7
-- Name: dbturmas_disciplinas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbturmas_disciplinas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2275 (class 1259 OID 17930)
-- Dependencies: 3299 3300 3301 3302 3303 3304 3305 3306 3307 3308 3309 3310 7
-- Name: dbturmas_disciplinas; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbturmas_disciplinas (
    id integer DEFAULT nextval('dbturmas_disciplinas_id_seq'::regclass) NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    codigoturma character varying(30),
    codigodisciplina character varying(30),
    codigoprofessor character varying(30),
    codigosala character varying(30),
    datarealizacao date DEFAULT ('now'::text)::date NOT NULL,
    dataatualizacao date DEFAULT ('now'::text)::date NOT NULL,
    frequencia character varying(10),
    datas text,
    custohoraaula real DEFAULT 0.00,
    regimetrabalho character varying(80),
    custohospedagem real DEFAULT 0.00,
    custodeslocamento real DEFAULT 0.00,
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL,
    codigograde character varying(20),
    custoalimentacao numeric(15,4) DEFAULT 0,
    custoextra numeric(15,4) DEFAULT 0
);


--
-- TOC entry 2276 (class 1259 OID 17946)
-- Dependencies: 7
-- Name: dbturmas_disciplinas_arquivos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbturmas_disciplinas_arquivos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2277 (class 1259 OID 17948)
-- Dependencies: 3311 3312 3313 3314 3315 3316 7
-- Name: dbturmas_disciplinas_arquivos; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbturmas_disciplinas_arquivos (
    id integer DEFAULT nextval('dbturmas_disciplinas_arquivos_id_seq'::regclass) NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    tipo character varying(2) DEFAULT '1'::character varying,
    codigoturmadisciplina character varying(30),
    codigoprofessor character varying(30),
    titulo character varying(200),
    obs text,
    arquivo text,
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 2278 (class 1259 OID 17960)
-- Dependencies: 7
-- Name: dbturmas_disciplinas_aulas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbturmas_disciplinas_aulas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2279 (class 1259 OID 17962)
-- Dependencies: 3317 3318 3319 3320 3321 3322 7
-- Name: dbturmas_disciplinas_aulas; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbturmas_disciplinas_aulas (
    id integer DEFAULT nextval('dbturmas_disciplinas_aulas_id_seq'::regclass) NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    codigoturmadisciplina character varying(30),
    dataaula date,
    conteudo text,
    frequencia character varying(20) DEFAULT 1 NOT NULL,
    obs text,
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 2280 (class 1259 OID 17974)
-- Dependencies: 3324 3325 3326 3327 7
-- Name: dbturmas_disciplinas_avaliacao_detalhamento; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbturmas_disciplinas_avaliacao_detalhamento (
    id integer NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    codigoturmadisciplina character varying(30),
    codigoavaliacao character varying(30),
    descricao text,
    porcentagem numeric(15,2),
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 2281 (class 1259 OID 17984)
-- Dependencies: 2280 7
-- Name: dbturmas_disciplinas_avaliacao_detalhamento_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbturmas_disciplinas_avaliacao_detalhamento_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 4093 (class 0 OID 0)
-- Dependencies: 2281
-- Name: dbturmas_disciplinas_avaliacao_detalhamento_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dbturmas_disciplinas_avaliacao_detalhamento_id_seq OWNED BY dbturmas_disciplinas_avaliacao_detalhamento.id;


--
-- TOC entry 2282 (class 1259 OID 17986)
-- Dependencies: 7
-- Name: dbturmas_disciplinas_avaliacoes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbturmas_disciplinas_avaliacoes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2283 (class 1259 OID 17988)
-- Dependencies: 3328 3329 3330 3331 3332 7
-- Name: dbturmas_disciplinas_avaliacoes; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbturmas_disciplinas_avaliacoes (
    id integer DEFAULT nextval('dbturmas_disciplinas_avaliacoes_id_seq'::regclass) NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    codigoturmadisciplina character varying(30),
    avaliacao character varying(80),
    notamax real,
    peso integer,
    codigopai character varying(20),
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL,
    ordem character varying(5)
);


--
-- TOC entry 2284 (class 1259 OID 17996)
-- Dependencies: 7
-- Name: dbturmas_disciplinas_materiais_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbturmas_disciplinas_materiais_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2285 (class 1259 OID 17998)
-- Dependencies: 3333 3334 3335 3336 3337 3338 7
-- Name: dbturmas_disciplinas_materiais; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbturmas_disciplinas_materiais (
    id integer DEFAULT nextval('dbturmas_disciplinas_materiais_id_seq'::regclass) NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    codigoturmadisciplina character varying(30),
    material character varying(180),
    descricao text,
    custo real DEFAULT 0.00,
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 2286 (class 1259 OID 18010)
-- Dependencies: 7
-- Name: dbturmas_disciplinas_planoaulas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbturmas_disciplinas_planoaulas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2287 (class 1259 OID 18012)
-- Dependencies: 3339 3340 3341 3342 3343 7
-- Name: dbturmas_disciplinas_planoaulas; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbturmas_disciplinas_planoaulas (
    id integer DEFAULT nextval('dbturmas_disciplinas_planoaulas_id_seq'::regclass) NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    codigoturmadisciplina character varying(30),
    codigoprofessor character varying(30),
    dataaula date,
    conteudo text,
    recursos text,
    metodologia text,
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 2288 (class 1259 OID 18023)
-- Dependencies: 7
-- Name: dbturmas_requisitos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbturmas_requisitos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2289 (class 1259 OID 18025)
-- Dependencies: 3344 3345 3346 3347 3348 3349 7
-- Name: dbturmas_requisitos; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbturmas_requisitos (
    id integer DEFAULT nextval('dbturmas_requisitos_id_seq'::regclass) NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    codigoturma character varying(30),
    requisito character varying(60),
    situacao character varying(2) DEFAULT 0 NOT NULL,
    obs text,
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL,
    codigograde character varying(30)
);


--
-- TOC entry 2290 (class 1259 OID 18037)
-- Dependencies: 7
-- Name: dbunidades_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbunidades_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2291 (class 1259 OID 18039)
-- Dependencies: 3350 3351 3352 3353 3354 7
-- Name: dbunidades; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbunidades (
    id integer DEFAULT nextval('dbunidades_id_seq'::regclass) NOT NULL,
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
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- TOC entry 2292 (class 1259 OID 18050)
-- Dependencies: 7
-- Name: dbunidades_parametros_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbunidades_parametros_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2293 (class 1259 OID 18052)
-- Dependencies: 3355 3356 3357 3358 3359 7
-- Name: dbunidades_parametros; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbunidades_parametros (
    id integer DEFAULT nextval('dbunidades_parametros_id_seq'::regclass) NOT NULL,
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
-- TOC entry 2294 (class 1259 OID 18063)
-- Dependencies: 7
-- Name: dbusuarios_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbusuarios_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2295 (class 1259 OID 18065)
-- Dependencies: 3360 3361 3362 3363 3364 3365 3366 7
-- Name: dbusuarios; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbusuarios (
    id integer DEFAULT nextval('dbusuarios_id_seq'::regclass) NOT NULL,
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
    lastaccess character varying(30),
    lastpass character varying(30)
);


--
-- TOC entry 2296 (class 1259 OID 18078)
-- Dependencies: 7
-- Name: dbusuarios_erros_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbusuarios_erros_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2297 (class 1259 OID 18080)
-- Dependencies: 3367 3368 3369 3370 3371 7
-- Name: dbusuarios_erros; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbusuarios_erros (
    id integer DEFAULT nextval('dbusuarios_erros_id_seq'::regclass) NOT NULL,
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
-- TOC entry 2298 (class 1259 OID 18091)
-- Dependencies: 7
-- Name: dbusuarios_historico_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbusuarios_historico_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2299 (class 1259 OID 18093)
-- Dependencies: 3372 3373 3374 3375 3376 7
-- Name: dbusuarios_historico; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbusuarios_historico (
    id integer DEFAULT nextval('dbusuarios_historico_id_seq'::regclass) NOT NULL,
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
-- TOC entry 2300 (class 1259 OID 18104)
-- Dependencies: 7
-- Name: dbusuarios_privilegios_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbusuarios_privilegios_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2301 (class 1259 OID 18106)
-- Dependencies: 3377 3378 3379 3380 3381 3382 3383 7
-- Name: dbusuarios_privilegios; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dbusuarios_privilegios (
    id integer DEFAULT nextval('dbusuarios_privilegios_id_seq'::regclass) NOT NULL,
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
-- TOC entry 4094 (class 0 OID 0)
-- Dependencies: 2301
-- Name: COLUMN dbusuarios_privilegios.funcionalidade; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbusuarios_privilegios.funcionalidade IS 'Id da funcionalidade sobre a qual o privilegio se associa.
Caso a funcionalidade seja o modulo principal o valor padrão é [0]';


--
-- TOC entry 4095 (class 0 OID 0)
-- Dependencies: 2301
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
-- TOC entry 2302 (class 1259 OID 18116)
-- Dependencies: 2469 7
-- Name: view_turmas_disciplinas; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_turmas_disciplinas AS
    SELECT t0.id, (t0.codigo)::text AS codigo, (t0.unidade)::text AS unidade, (t0.codigoturma)::text AS codigoturma, (t3.codigocurso)::text AS codigocurso, (t0.codigodisciplina)::text AS codigodisciplina, (t0.codigoprofessor)::text AS codigoprofessor, to_char((t0.datarealizacao)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datarealizacao, to_char((t0.dataatualizacao)::timestamp with time zone, 'DD/MM/YYYY'::text) AS dataatualizacao, (t0.frequencia)::text AS frequencia, t0.datas, (t0.custohoraaula)::text AS custohoraaula, (t0.regimetrabalho)::text AS regimetrabalho, (t0.custohospedagem)::text AS custohospedagem, (t0.custodeslocamento)::text AS custodeslocamento, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t6.nome)::text AS sala, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t2.nome)::text AS nomecurso, (t3.titulo)::text AS nometurma, (t4.titulo)::text AS nomedisciplina, (t4.cargahoraria)::text AS cargahoraria, (t5.nome_razaosocial)::text AS nomeprofessor, ((SELECT count(dbalunos_disciplinas.codigo) AS count FROM dbalunos_disciplinas WHERE (((dbalunos_disciplinas.codigoturmadisciplina)::text = (t0.codigo)::text) AND ((dbalunos_disciplinas.situacao)::text = '2'::text))))::text AS alunos, (t0.codigosala)::text AS codigosala, (t3.codigograde)::text AS codigograde, t3.status, t0.custoalimentacao, t0.custoextra FROM ((((((dbturmas_disciplinas t0 LEFT JOIN dbturmas t3 ON (((t3.codigo)::text = (t0.codigoturma)::text))) LEFT JOIN dbcursos t2 ON (((t2.codigo)::text = (t3.codigocurso)::text))) LEFT JOIN dbdisciplinas t4 ON (((t4.codigo)::text = (t0.codigodisciplina)::text))) LEFT JOIN dbpessoas t5 ON (((t5.codigo)::text = ((SELECT t8.codigopessoa FROM dbpessoas_funcionarios t8 WHERE ((t8.codigo)::text = ((SELECT t9.codigofuncionario FROM dbfuncionarios_professores t9 WHERE ((t9.codigo)::text = (t0.codigoprofessor)::text)))::text)))::text))) LEFT JOIN dbsalas t6 ON (((t6.codigo)::text = (t0.codigosala)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t0.ativo)::text)));


--
-- TOC entry 2303 (class 1259 OID 18121)
-- Dependencies: 2470 7
-- Name: view_alunos_disciplinas; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_alunos_disciplinas AS
    SELECT t0.id, (t0.codigo)::text AS codigo, (t0.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, (t0.codigoaluno)::text AS codigoaluno, (t0.codigodisciplina)::text AS codigodisciplina, (t0.codigoturmadisciplina)::text AS codigoturmadisciplina, (t0.situacao)::text AS situacao, t0.obs, (t3.nome_razaosocial)::text AS nomepessoa, t4.nometurma, (t5.titulo)::text AS nomedisciplina, t4.codigocurso, t4.codigoturma, t4.nomecurso, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, t4.codigograde FROM (((((dbalunos_disciplinas t0 LEFT JOIN dbpessoas_alunos t2 ON (((t2.codigo)::text = (t0.codigoaluno)::text))) LEFT JOIN dbpessoas t3 ON (((t3.codigo)::text = (t2.codigopessoa)::text))) LEFT JOIN view_turmas_disciplinas t4 ON ((t4.codigo = (t0.codigoturmadisciplina)::text))) LEFT JOIN dbdisciplinas t5 ON (((t5.codigo)::text = (t0.codigodisciplina)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t0.ativo)::text)));


--
-- TOC entry 2304 (class 1259 OID 18126)
-- Dependencies: 2471 7
-- Name: view_alunos_faltas; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_alunos_faltas AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigoaluno)::text AS codigoaluno, (t1.codigoturmadisciplina)::text AS codigoturmadisciplina, (t1.codigoaula)::text AS codigoaula, to_char((t1.datafalta)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datafalta, (t1.numaula)::text AS numaula, t1.justificativa, t1.obs, (t1.situacao)::text AS situacao, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, t2.titulo AS nomedisciplina FROM ((dbalunos_faltas t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text))) LEFT JOIN dbdisciplinas t2 ON (((t2.codigo)::text = ((SELECT t90.codigodisciplina FROM dbturmas_disciplinas t90 WHERE ((t90.codigo)::text = (t1.codigoturmadisciplina)::text)))::text)));


--
-- TOC entry 2305 (class 1259 OID 18131)
-- Dependencies: 2472 7
-- Name: view_alunos_notas; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_alunos_notas AS
    SELECT t0.id, (t0.codigo)::text AS codigo, (t0.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, (t0.codigoaluno)::text AS codigoaluno, (t0.codigoturmadisciplina)::text AS codigoturmadisciplina, (t0.codigoavaliacao)::text AS codigoavaliacao, (t0.nota)::text AS nota, (t0.ordemavaliacao)::text AS ordemavaliacao, (t3.nome_razaosocial)::text AS nomepessoa, t4.nometurma, t4.nomedisciplina, t4.codigocurso, t4.codigoturma, t4.nomecurso, t6.avaliacao, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, t4.codigograde FROM (((((dbalunos_notas t0 LEFT JOIN dbpessoas_alunos t2 ON (((t2.codigo)::text = (t0.codigoaluno)::text))) LEFT JOIN dbpessoas t3 ON (((t3.codigo)::text = (t2.codigopessoa)::text))) LEFT JOIN view_turmas_disciplinas t4 ON ((t4.codigo = (t0.codigoturmadisciplina)::text))) LEFT JOIN dbavaliacoes t6 ON (((t6.codigo)::text = (t0.codigoavaliacao)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t0.ativo)::text)));


--
-- TOC entry 2306 (class 1259 OID 18136)
-- Dependencies: 2473 7
-- Name: view_alunos_solicitacoes; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_alunos_solicitacoes AS
    SELECT t0.id, (t0.codigo)::text AS codigo, (t0.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, (t0.codigoaluno)::text AS codigoaluno, (t0.codigosolicitacao)::text AS codigosolicitacao, (t0.data)::text AS data, t0.justificativa, t0.atendimento, (t0.codigofuncionario)::text AS codigofuncionario, (t0.codigodepartamento)::text AS codigodepartamento, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t0.status)::text AS status, (t4.nome_razaosocial)::text AS nomealuno, (t3.nome_razaosocial)::text AS nomefuncionario, (t5.label)::text AS nomedepartamento, (t6.titulo)::text AS solicitacao FROM ((((((dbalunos_solicitacoes t0 LEFT JOIN dbpessoas_alunos t2 ON (((t2.codigo)::text = (t0.codigoaluno)::text))) LEFT JOIN dbpessoas t4 ON (((t4.codigo)::text = (t2.codigopessoa)::text))) LEFT JOIN dbpessoas t3 ON (((t3.codigo)::text = ((SELECT t5.codigopessoa FROM dbpessoas_funcionarios t5 WHERE ((t5.codigo)::text = (t0.codigofuncionario)::text)))::text))) LEFT JOIN dbprocessos_academicos t6 ON (((t6.codigo)::text = (t0.codigosolicitacao)::text))) LEFT JOIN dbdepartamentos t5 ON (((t5.codigo)::text = (t0.codigodepartamento)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t0.ativo)::text)));


--
-- TOC entry 2307 (class 1259 OID 18141)
-- Dependencies: 2474 7
-- Name: view_biblioteca_cdu; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_biblioteca_cdu AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.cdu)::text AS cdu, (t1.titulo)::text AS titulo, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbbiblioteca_cdu t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 2308 (class 1259 OID 18145)
-- Dependencies: 2475 7
-- Name: view_caixa; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_caixa AS
    SELECT t0.id, (t0.codigo)::text AS codigo, (t0.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, (t0.codigoconta)::text AS codigoconta, (t0.codigoplanoconta)::text AS codigoplanoconta, (t0.codigocontacaixa)::text AS codigocontacaixa, (t5.nomeconta)::text AS nomeconta, (t0.codigopessoa)::text AS codigopessoa, (t0.codigotransacao)::text AS codigotransacao, (t0.numdoc)::text AS numdoc, to_char((t0.datadocumento)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datadocumento, (t0.tipomovimentacao)::text AS tipomovimentacao, (t0.tipoduplicata)::text AS tipoduplicata, (t0.valorreal)::text AS valorreal, to_char((t0.vencimento)::timestamp with time zone, 'DD/MM/YYYY'::text) AS vencimento, (t0.formadesconto)::text AS formadesconto, (t0.desconto)::text AS desconto, (t0.multaacrecimo)::text AS multaacrecimo, (t0.valorpago)::text AS valorpago, (t0.valorentrada)::text AS valorentrada, (t0.codigofuncionario)::text AS codigofuncionario, (t0.datapag)::text AS datapag, (t0.formapag)::text AS formapag, (t0.mora)::text AS mora, t0.obs, (t0.statusmovimento)::text AS statusmovimento, (t0.statusconta)::text AS statusconta, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t2.nomeconta)::text AS nomeplanoconta, (t3.nome_razaosocial)::text AS nomepessoa, (t0.codigohistorico)::text AS codigohistorico FROM ((((dbcaixa t0 LEFT JOIN dbcontas_caixa t5 ON (((t5.codigo)::text = (t0.codigocontacaixa)::text))) LEFT JOIN dbplano_contas t2 ON (((t2.codigo)::text = (t0.codigoplanoconta)::text))) LEFT JOIN dbpessoas t3 ON (((t3.codigo)::text = (t0.codigopessoa)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t0.ativo)::text)));


--
-- TOC entry 2309 (class 1259 OID 18150)
-- Dependencies: 2476 7
-- Name: view_caixa_fechamentos; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_caixa_fechamentos AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.valorprevisto)::text AS valorprevisto, (t1.receitatotal)::text AS receitatotal, (t1.despesatotal)::text AS despesatotal, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbcaixa_fechamentos t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 2310 (class 1259 OID 18154)
-- Dependencies: 2477 7
-- Name: view_pessoas_funcionarios; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_pessoas_funcionarios AS
    SELECT t0.id, (t2.codigo)::text AS codigofuncionario, (t0.unidade)::text AS unidade, (t0.codigo)::text AS codigo, (t0.nome_razaosocial)::text AS nomefuncionario, (t0.cpf_cnpj)::text AS cpf_cnpj, (t2.codigocargo)::text AS codigocargo, (t3.nomecargo)::text AS nomecargo, (t2.codigodepartamento)::text AS codigodepartamento, (t4.label)::text AS nomedepartamento, (t2.lotacao)::text AS lotacao, (t5.nome)::text AS nomesala, to_char((t2.dataadmissao)::timestamp with time zone, 'DD/MM/YYYY'::text) AS dataadmissao, (t2.ativo)::text AS situacao, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (((((dbpessoas t0 LEFT JOIN dbpessoas_funcionarios t2 ON (((t2.codigopessoa)::text = (t0.codigo)::text))) LEFT JOIN dbcargos t3 ON (((t3.codigo)::text = (t2.codigocargo)::text))) LEFT JOIN dbdepartamentos t4 ON (((t4.codigo)::text = (t2.codigodepartamento)::text))) LEFT JOIN dbsalas t5 ON (((t5.codigo)::text = (t2.lotacao)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t0.ativo)::text))) WHERE ((t0.codigo)::text = (t2.codigopessoa)::text);


--
-- TOC entry 2311 (class 1259 OID 18159)
-- Dependencies: 2478 7
-- Name: view_caixa_funcionarios; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_caixa_funcionarios AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigofuncionario)::text AS codigofuncionario, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, t1.obs, t2.nomefuncionario, t2.cpf_cnpj, t2.codigocargo, t2.nomecargo, (t1.situacao)::text AS situacao, (t1.codigocontacaixa)::text AS codigocontacaixa, (((t3.tipoconta)::text || ' - '::text) || (t3.nomeconta)::text) AS nomecontacaixa FROM (((dbcaixa_funcionarios t1 LEFT JOIN view_pessoas_funcionarios t2 ON ((t2.codigofuncionario = (t1.codigofuncionario)::text))) LEFT JOIN dbcontas_caixa t3 ON (((t3.codigo)::text = (t1.codigocontacaixa)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 2312 (class 1259 OID 18164)
-- Dependencies: 2479 7
-- Name: view_cargos; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_cargos AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.nomecargo)::text AS nomecargo, t1.descricao, t1.conhecimentos, t1.habilidades, t1.atitudes, t1.prerequisitos, (t1.cargahoraria)::text AS cargahoraria, (t1.horariotrabalho)::text AS horariotrabalho, t1.maquinasutilizadas, (t1.graurisco)::text AS graurisco, (t1.subordinado)::text AS subordinado, t1.cargoascendente, t1.cargodescendente, (t1.salariobase)::text AS salariobase, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbcargos t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 2313 (class 1259 OID 18169)
-- Dependencies: 2480 7
-- Name: view_compras; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_compras AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigoproduto)::text AS codigoproduto, (t1.valorunitario)::text AS valorunitario, (t1.tempoentrega)::text AS tempoentrega, (t1.quantidade)::text AS quantidade, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbcompras t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 2314 (class 1259 OID 18173)
-- Dependencies: 2481 7
-- Name: view_contas_caixa; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_contas_caixa AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.nomeconta)::text AS nomeconta, (t1.tipoconta)::text AS tipoconta, (t1.banco)::text AS banco, (t1.numconta)::text AS numconta, (t1.agencia)::text AS agencia, (t1.saldoinicial)::text AS saldoinicial, ((SELECT sum(dbcaixa.valorpago) AS sum FROM dbcaixa WHERE (((dbcaixa.codigocontacaixa)::text = (t1.codigo)::text) AND ((dbcaixa.tipomovimentacao)::text = 'C'::text))))::text AS entrada, ((SELECT sum(dbcaixa.valorpago) AS sum FROM dbcaixa WHERE (((dbcaixa.codigocontacaixa)::text = (t1.codigo)::text) AND ((dbcaixa.tipomovimentacao)::text = 'D'::text))))::text AS saida, (((t1.saldoinicial)::double precision + ((SELECT sum(temp1.valorpago) AS sum FROM dbcaixa temp1 WHERE (((temp1.codigocontacaixa)::text = (t1.codigo)::text) AND ((temp1.tipomovimentacao)::text = 'C'::text))))::double precision))::text AS saldo, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbcontas_caixa t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 2315 (class 1259 OID 18178)
-- Dependencies: 2482 7
-- Name: view_contas_caixa_historico; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_contas_caixa_historico AS
    SELECT t1.id, (t2.codigo)::text AS codigo, (t2.unidade)::text AS unidade, (t2.codigoautor)::text AS codigoautor, (t2.codigocontacaixa)::text AS codigocontacaixa, (t1.nomeconta)::text AS nomeconta, (t1.tipoconta)::text AS tipoconta, (t1.banco)::text AS banco, (t1.numconta)::text AS numconta, (t1.agencia)::text AS agencia, ((SELECT sum(dbcaixa.valorpago) AS sum FROM dbcaixa WHERE ((((dbcaixa.codigohistorico)::text = (t2.codigo)::text) AND ((dbcaixa.tipomovimentacao)::text = 'C'::text)) AND ((dbcaixa.formapag)::text = 'Dinheiro'::text))))::text AS entrada_dinheiro, ((SELECT sum(dbcaixa.valorpago) AS sum FROM dbcaixa WHERE ((((dbcaixa.codigohistorico)::text = (t2.codigo)::text) AND ((dbcaixa.tipomovimentacao)::text = 'D'::text)) AND ((dbcaixa.formapag)::text = 'Dinheiro'::text))))::text AS saida_dinheiro, ((SELECT sum(dbcaixa.valorpago) AS sum FROM dbcaixa WHERE ((((dbcaixa.codigohistorico)::text = (t2.codigo)::text) AND ((dbcaixa.tipomovimentacao)::text = 'C'::text)) AND ((dbcaixa.formapag)::text = 'Cheque'::text))))::text AS entrada_cheque, ((SELECT sum(dbcaixa.valorpago) AS sum FROM dbcaixa WHERE ((((dbcaixa.codigohistorico)::text = (t2.codigo)::text) AND ((dbcaixa.tipomovimentacao)::text = 'D'::text)) AND ((dbcaixa.formapag)::text = 'Cheque'::text))))::text AS saida_cheque, ((SELECT sum(dbcaixa.valorpago) AS sum FROM dbcaixa WHERE ((((dbcaixa.codigohistorico)::text = (t2.codigo)::text) AND ((dbcaixa.tipomovimentacao)::text = 'C'::text)) AND ((dbcaixa.formapag)::text = 'Cartão'::text))))::text AS entrada_cartao, ((SELECT sum(dbcaixa.valorpago) AS sum FROM dbcaixa WHERE ((((dbcaixa.codigohistorico)::text = (t2.codigo)::text) AND ((dbcaixa.tipomovimentacao)::text = 'D'::text)) AND ((dbcaixa.formapag)::text = 'Cartão'::text))))::text AS saida_cartao, to_char((t2.datainicio)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datainicio, to_char((t2.datafim)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datafim, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM ((dbcontas_caixa_historico t2 LEFT JOIN dbcontas_caixa t1 ON (((t1.codigo)::text = (t2.codigocontacaixa)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t2.ativo)::text))) WHERE ((t2.ativo)::text = '1'::text);


--
-- TOC entry 2316 (class 1259 OID 18183)
-- Dependencies: 2483 7
-- Name: view_contas_cheques; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_contas_cheques AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigopessoa)::text AS codigopessoa, (t1.nometitular)::text AS nometitular, (t1.banco)::text AS banco, (t1.agencia)::text AS agencia, (t1.numconta)::text AS numconta, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, t1.obs, (t1.codigocaixa)::text AS codigocaixa, (t1.codigoconta)::text AS codigoconta, (t1.numcheque)::text AS numcheque, (t1.valor)::text AS valor, (t1.cpf_cnpj)::text AS cpf_cnpj FROM (dbcontas_cheques t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 2317 (class 1259 OID 18188)
-- Dependencies: 2484 7
-- Name: view_contratos; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_contratos AS
    SELECT t0.id, (t0.codigo)::text AS codigo, (t0.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, (t0.codigopessoa)::text AS codigopessoa, (t0.tipodocumento)::text AS tipodocumento, to_char((t0.dataassinatura)::timestamp with time zone, 'DD/MM/YYYY'::text) AS dataassinatura, to_char((t0.datatermino)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datatermino, t0.arquivo, (t0.codigoproduto)::text AS codigoproduto, (t0.tipoassinatura)::text AS tipoassinatura, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t2.nome_razaosocial)::text AS nomepessoa, (t3.titulo)::text AS nomedocumento, (t4.label)::text AS nomeproduto FROM ((((dbcontratos t0 LEFT JOIN dbpessoas t2 ON (((t2.codigo)::text = (t0.codigopessoa)::text))) LEFT JOIN dbdocumentos t3 ON (((t3.codigo)::text = (t0.tipodocumento)::text))) LEFT JOIN dbprodutos t4 ON (((t4.codigo)::text = (t0.codigoproduto)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t0.ativo)::text)));


--
-- TOC entry 2318 (class 1259 OID 18193)
-- Dependencies: 2485 7
-- Name: view_convenios; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_convenios AS
    SELECT t0.id, (t0.codigo)::text AS codigo, (t0.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, (t0.codigopessoa)::text AS codigopessoa, (t0.titulo)::text AS titulo, t0.descricao, (t0.tipoconvenio)::text AS tipoconvenio, (t0.tipotransacao)::text AS tipotransacao, (t0.datavigencia)::text AS datavigencia, t0.codigoplanoconta, t3.nomeconta AS nomeplanoconta, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t1.nome_razaosocial)::text AS concedente FROM (((dbconvenios t0 LEFT JOIN dbplano_contas t3 ON (((t3.codigo)::text = (t0.codigoplanoconta)::text))) LEFT JOIN dbpessoas t1 ON (((t1.codigo)::text = (t0.codigopessoa)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 2319 (class 1259 OID 18198)
-- Dependencies: 2486 7
-- Name: view_cotacoes; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_cotacoes AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigoproduto)::text AS codigoproduto, (t1.codigofornecedor)::text AS codigofornecedor, (t1.preco)::text AS preco, (t1.entrega)::text AS entrega, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbcotacoes t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 2320 (class 1259 OID 18202)
-- Dependencies: 2487 7
-- Name: view_curriculos; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_curriculos AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.nome)::text AS nome, (t1.sexo)::text AS sexo, (t1.datanasc)::text AS datanasc, (t1.cpf)::text AS cpf, (t1.logadouro)::text AS logadouro, (t1.cidade)::text AS cidade, (t1.estado)::text AS estado, (t1.bairro)::text AS bairro, (t1.telefone)::text AS telefone, (t1.celular)::text AS celular, (t1.email)::text AS email, (t1.estadocivil)::text AS estadocivil, (t1.cnh)::text AS cnh, (t1.dependentes)::text AS dependentes, t1.idiomas, (t1.areainteresse)::text AS areainteresse, (t1.areainteresse2)::text AS areainteresse2, (t1.areainteresse3)::text AS areainteresse3, (t1.escolaridade)::text AS escolaridade, t1.cursos, t1.experiencia, t1.obs, t1.resumo, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbcurriculos t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 2321 (class 1259 OID 18207)
-- Dependencies: 2488 7
-- Name: view_cursos; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_cursos AS
    SELECT t0.id, (t0.codigo)::text AS codigo, (t0.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, (t0.nome)::text AS nome, (t0.codigotipocurso)::text AS codigotipocurso, (t0.codigoareacurso)::text AS codigoareacurso, t0.objetivocurso, t0.publicoalvo, (t0.cargahortotal)::text AS cargahortotal, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t2.titulo)::text AS areacurso, ((SELECT sum(t4.cargahoraria) AS sum FROM dbdisciplinas t4 WHERE ((t4.codigo)::text IN (SELECT t5.codigodisciplina FROM dbcursos_disciplinas t5 WHERE ((t5.codigocurso)::text = (t0.codigo)::text)))))::text AS cargahoraria, (t3.titulo)::text AS tipocurso, ((SELECT count(t5.codigocurso) AS count FROM dbturmas t5 WHERE ((t5.codigocurso)::text = (t0.codigo)::text)))::text AS turmas, (t0.codigograde)::text AS codigograde FROM (((dbcursos t0 LEFT JOIN dbcursos_areas t2 ON (((t2.codigo)::text = (t0.codigoareacurso)::text))) LEFT JOIN dbcursos_tipos t3 ON (((t3.codigo)::text = (t0.codigotipocurso)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t0.ativo)::text)));


--
-- TOC entry 2322 (class 1259 OID 18212)
-- Dependencies: 2489 7
-- Name: view_cursos_areas; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_cursos_areas AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.titulo)::text AS titulo, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbcursos_areas t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 2323 (class 1259 OID 18216)
-- Dependencies: 2490 7
-- Name: view_cursos_ativos; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_cursos_ativos AS
    SELECT t4.id, (t4.codigo)::text AS codigo, (t4.unidade)::text AS unidade, (t4.codigoautor)::text AS codigoautor, (t4.titulo)::text AS titulo, (t4.codigocurso)::text AS codigocurso, t4.obs, to_char((t4.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t0.nome)::text AS nome, (t0.codigotipocurso)::text AS codigotipocurso, (t0.codigoareacurso)::text AS codigoareacurso, t0.objetivocurso, t0.publicoalvo, (t0.cargahortotal)::text AS cargahortotal, (t2.titulo)::text AS areacurso, (t3.titulo)::text AS tipocurso FROM ((((dbcursos_ativos t4 LEFT JOIN dbcursos t0 ON (((t0.codigo)::text = (t4.codigocurso)::text))) LEFT JOIN dbcursos_areas t2 ON (((t2.codigo)::text = (t0.codigoareacurso)::text))) LEFT JOIN dbcursos_tipos t3 ON (((t3.codigo)::text = (t0.codigotipocurso)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t4.ativo)::text)));


--
-- TOC entry 2324 (class 1259 OID 18221)
-- Dependencies: 2491 7
-- Name: view_cursos_disciplinas; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_cursos_disciplinas AS
    SELECT t0.id, (t0.codigo)::text AS codigo, (t0.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, (t0.codigocurso)::text AS codigocurso, (t0.codigodisciplina)::text AS codigodisciplina, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t2.nome)::text AS nomecurso, (t3.titulo)::text AS nomedisciplina, (t3.cargahoraria)::text AS cargahoraria FROM (((dbcursos_disciplinas t0 LEFT JOIN dbcursos t2 ON (((t2.codigo)::text = (t0.codigocurso)::text))) LEFT JOIN dbdisciplinas t3 ON (((t3.codigo)::text = (t0.codigodisciplina)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t0.ativo)::text)));


--
-- TOC entry 2325 (class 1259 OID 18226)
-- Dependencies: 2492 7
-- Name: view_cursos_tipos; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_cursos_tipos AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.titulo)::text AS titulo, t1.obs, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbcursos_tipos t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 2326 (class 1259 OID 18230)
-- Dependencies: 2493 7
-- Name: view_departamentos; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_departamentos AS
    SELECT t0.id, (t0.codigo)::text AS codigo, (t0.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, (t0.label)::text AS label, (t0.codigoresponsavel)::text AS codigoresponsavel, (t0.codigosala)::text AS codigosala, t0.obs, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t2.nome_razaosocial)::text AS nomeresponsavel, (t3.nome)::text AS nomesala FROM (((dbdepartamentos t0 LEFT JOIN dbpessoas t2 ON (((t2.codigo)::text = (t0.codigoresponsavel)::text))) LEFT JOIN dbsalas t3 ON (((t3.codigo)::text = (t0.codigosala)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t0.ativo)::text)));


--
-- TOC entry 2327 (class 1259 OID 18235)
-- Dependencies: 2494 7
-- Name: view_disciplinas; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_disciplinas AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.titulo)::text AS titulo, t1.ementa, t1.programa, t1.competencias, (t1.cargahoraria)::text AS cargahoraria, t1.biografia, t1.metodologia, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbdisciplinas t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 2328 (class 1259 OID 18240)
-- Dependencies: 2495 7
-- Name: view_disciplinas_semelhantes; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_disciplinas_semelhantes AS
    SELECT t0.id, (t0.codigo)::text AS codigo, (t0.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, (t0.codigodisciplina)::text AS codigodisciplina, (t0.codigodisciplinasemelhante)::text AS codigodisciplinasemelhante, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t3.titulo)::text AS nomedisciplina, (t3.cargahoraria)::text AS cargahoraria, (t4.titulo)::text AS nomedisciplinasemelhante, (t4.cargahoraria)::text AS cargahorariasemelhante FROM (((dbdisciplinas_semelhantes t0 LEFT JOIN dbdisciplinas t3 ON (((t3.codigo)::text = (t0.codigodisciplina)::text))) LEFT JOIN dbdisciplinas t4 ON (((t3.codigo)::text = (t0.codigodisciplinasemelhante)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t0.ativo)::text)));


--
-- TOC entry 2329 (class 1259 OID 18245)
-- Dependencies: 2496 7
-- Name: view_funcionarios_ferias; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_funcionarios_ferias AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigofuncionario)::text AS codigofuncionario, (t1.dataferiasprevisao)::text AS dataferiasprevisao, (t1.diasferiasprevisao)::text AS diasferiasprevisao, (t1.retornoferiasprevisao)::text AS retornoferiasprevisao, (t1.dataferiasreal)::text AS dataferiasreal, (t1.diasferiasreal)::text AS diasferiasreal, (t1.retornoferiasreal)::text AS retornoferiasreal, (t1.datalimite)::text AS datalimite, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbfuncionarios_ferias t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 2330 (class 1259 OID 18250)
-- Dependencies: 2497 7
-- Name: view_funcionarios_folhapagamento; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_funcionarios_folhapagamento AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigofuncionario)::text AS codigofuncionario, (t1.nomecargo)::text AS nomecargo, (t1.codcontadebito)::text AS codcontadebito, (t1.referencia)::text AS referencia, (t1.salariobase)::text AS salariobase, (t1.comissao)::text AS comissao, (t1.salariofamilia)::text AS salariofamilia, (t1.adpericulosidade)::text AS adpericulosidade, (t1.adsalubridade)::text AS adsalubridade, (t1.horaextra)::text AS horaextra, (t1.ferias)::text AS ferias, (t1.decimoterceiro)::text AS decimoterceiro, (t1.licensamaternidade)::text AS licensamaternidade, (t1.licensapaternidade)::text AS licensapaternidade, (t1.licensacasamento)::text AS licensacasamento, (t1.licensaobito)::text AS licensaobito, (t1.licensainvalidez)::text AS licensainvalidez, (t1.valetransporte)::text AS valetransporte, (t1.irpf)::text AS irpf, (t1.inss)::text AS inss, (t1.contrsindical)::text AS contrsindical, (t1.totalbruto)::text AS totalbruto, (t1.totalliquido)::text AS totalliquido, (t1.diastrabalhados)::text AS diastrabalhados, (t1.vencimento)::text AS vencimento, (t1.datapag)::text AS datapag, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbfuncionarios_folhapagamento t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 2331 (class 1259 OID 18255)
-- Dependencies: 2498 7
-- Name: view_funcionarios_ocorrencias; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_funcionarios_ocorrencias AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigofuncionario)::text AS codigofuncionario, (t1.titulo)::text AS titulo, t1.descricao, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbfuncionarios_ocorrencias t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 2332 (class 1259 OID 18259)
-- Dependencies: 2499 7
-- Name: view_funcionarios_professores; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_funcionarios_professores AS
    SELECT t0.id, (t0.codigo)::text AS codigo, (t0.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, (t0.codigofuncionario)::text AS codigofuncionario, t0.curriculo, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t3.nome_razaosocial)::text AS nomeprofessor, (t3.codigo)::text AS codigopessoa, ((SELECT t4.titularidade FROM dbpessoas_titularidades t4 WHERE ((t4.peso)::text = (SELECT max((t6.peso)::text) AS max FROM dbpessoas_titularidades t6 WHERE ((t6.codigo)::text IN (SELECT t5.codigotitularidade FROM dbpessoas_formacoes t5 WHERE ((t5.codigopessoa)::text = (t2.codigopessoa)::text)))))))::text AS titularidade, ((SELECT t4.nomeacao FROM dbpessoas_titularidades t4 WHERE ((t4.peso)::text = (SELECT max((t6.peso)::text) AS max FROM dbpessoas_titularidades t6 WHERE ((t6.codigo)::text IN (SELECT t5.codigotitularidade FROM dbpessoas_formacoes t5 WHERE ((t5.codigopessoa)::text = (t2.codigopessoa)::text)))))))::text AS nomeacao FROM (((dbfuncionarios_professores t0 LEFT JOIN dbpessoas_funcionarios t2 ON (((t2.codigo)::text = (t0.codigofuncionario)::text))) LEFT JOIN dbpessoas t3 ON (((t3.codigo)::text = (t2.codigopessoa)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t0.ativo)::text)));


--
-- TOC entry 2333 (class 1259 OID 18264)
-- Dependencies: 2500 7
-- Name: view_funcionarios_treinamentos; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_funcionarios_treinamentos AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigotreinamento)::text AS codigotreinamento, (t1.codigofuncionario)::text AS codigofuncionario, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbfuncionarios_treinamentos t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 2334 (class 1259 OID 18268)
-- Dependencies: 2501 7
-- Name: view_patrimonios; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_patrimonios AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigofuncionario)::text AS codigofuncionario, (t1.codigoproduto)::text AS codigoproduto, (t1.modelo)::text AS modelo, (t1.marca)::text AS marca, (t1.label)::text AS label, (t1.descricao)::text AS descricao, (t1.tipo)::text AS tipo, (t1.datafabricacao)::text AS datafabricacao, (t1.dataaquisicao)::text AS dataaquisicao, (t1.valornominal)::text AS valornominal, (t1.lotacao)::text AS lotacao, (t1.valorcompra)::text AS valorcompra, (t1.numnf)::text AS numnf, (t1.dataverificacao)::text AS dataverificacao, (t1.foto)::text AS foto, t1.obs, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t2.nomeunidade)::text AS nomeunidade, (t3.nome)::text AS nomesala FROM (((dbpatrimonios t1 LEFT JOIN dbunidades t2 ON (((t2.codigo)::text = (t1.unidade)::text))) LEFT JOIN dbsalas t3 ON (((t3.codigo)::text = (t1.lotacao)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 2335 (class 1259 OID 18273)
-- Dependencies: 2502 7
-- Name: view_patrimonios_livros; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_patrimonios_livros AS
    SELECT t0.id, (t0.codigo)::text AS codigolivro, (t0.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, (t0.codigopatrimonio)::text AS codigopatrimonio, (t0.codigopatrimonio)::text AS codigo, (t0.autor)::text AS autor, t0.outrosautores, (t0.ano)::text AS ano, (t0.isbn)::text AS isbn, (t0.idioma)::text AS idioma, (t0.paginas)::text AS paginas, (t1.modelo)::text AS edicao, (t1.marca)::text AS editora, (t1.label)::text AS titulo, (t2.cdu)::text AS cdu, (t2.titulo)::text AS titulocdu, (t0.codigopha)::text AS codigopha, (t0.codigocdu)::text AS codigocdu, (t0.tradutor)::text AS tradutor, t0.sinopse, (t0.volume)::text AS volume, t0.sumario, (t1.foto)::text AS foto, ((SELECT count(t3.codigo) AS count FROM dbpessoas_livros t3 WHERE (((t3.codigolivro)::text = (t0.codigo)::text) AND ((t3.situacao)::text = '3'::text))))::text AS locacoes, ((SELECT count(t3.codigo) AS count FROM dbpessoas_livros t3 WHERE (((t3.codigolivro)::text = (t0.codigo)::text) AND ((t3.situacao)::text = '2'::text))))::text AS reservas, ((SELECT t3.codigopessoa FROM dbpessoas_livros t3 WHERE (((t3.codigolivro)::text = (t0.codigo)::text) AND ((t3.situacao)::text = '1'::text))))::text AS codigolocador, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t0.exemplar)::text AS exemplar FROM (((dbpatrimonios_livros t0 LEFT JOIN dbpatrimonios t1 ON (((t1.codigo)::text = (t0.codigopatrimonio)::text))) LEFT JOIN dbbiblioteca_cdu t2 ON (((t2.codigo)::text = (t0.codigocdu)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 2336 (class 1259 OID 18278)
-- Dependencies: 2503 7
-- Name: view_pessoas; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_pessoas AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.tipo)::text AS tipo, (t1.nome_razaosocial)::text AS nome_razaosocial, (t1.cpf_cnpj)::text AS cpf_cnpj, (t1.rg_inscest)::text AS rg_inscest, (t1.titeleitor_inscmun)::text AS titeleitor_inscmun, t1.logradouro, (t1.bairro)::text AS bairro, (t1.cidade)::text AS cidade, (t1.estado)::text AS estado, (t1.cep)::text AS cep, (t1.caixapostal)::text AS caixapostal, (t1.referencia)::text AS referencia, (t1.tel1)::text AS tel1, (t1.tel2)::text AS tel2, (t1.cel1)::text AS cel1, (t1.cel2)::text AS cel2, (t1.email1)::text AS email1, (t1.email2)::text AS email2, (t1.site)::text AS site, (t1.opcobranca)::text AS opcobranca, (t1.cliente)::text AS cliente, (t1.fornecedor)::text AS fornecedor, (t1.funcionario)::text AS funcionario, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbpessoas t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 2337 (class 1259 OID 18283)
-- Dependencies: 2504 7
-- Name: view_pessoas_alunos; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_pessoas_alunos AS
    SELECT t0.id, (t0.codigo)::text AS codigo, (t0.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, (t0.codigopessoa)::text AS codigopessoa, (t0.codigotransacao)::text AS codigotransacao, (t0.codigoturma)::text AS codigoturma, (t0.codigocurso)::text AS codigocurso, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t2.titulo)::text AS nometurma, (t3.nomeunidade)::text AS nomeunidade, (t6.nome_razaosocial)::text AS nomepessoa, (t4.nome)::text AS nomecurso FROM (((((dbpessoas_alunos t0 LEFT JOIN dbturmas t2 ON (((t2.codigo)::text = (t0.codigoturma)::text))) LEFT JOIN dbunidades t3 ON (((t3.codigo)::text = (t0.unidade)::text))) LEFT JOIN dbcursos t4 ON (((t4.codigo)::text = ((SELECT t5.codigocurso FROM dbturmas t5 WHERE ((t5.codigo)::text = (t0.codigoturma)::text)))::text))) LEFT JOIN dbpessoas t6 ON (((t6.codigo)::text = (t0.codigopessoa)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t0.ativo)::text)));


--
-- TOC entry 2338 (class 1259 OID 18288)
-- Dependencies: 2505 7
-- Name: view_pessoas_complemento_pf; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_pessoas_complemento_pf AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigopessoa)::text AS codigopessoa, (t1.estadocivil)::text AS estadocivil, (t1.etinia)::text AS etinia, (t1.datanasc)::text AS datanasc, (t1.sexo)::text AS sexo, (t1.tiposanguineo)::text AS tiposanguineo, (t1.nacionalidade)::text AS nacionalidade, (t1.portadornecessidades)::text AS portadornecessidades, t1.necessidadesespeciais, (t1.numerodependentes)::text AS numerodependentes, (t1.cnh)::text AS cnh, (t1.carteirareservista)::text AS carteirareservista, (t1.rendamensal)::text AS rendamensal, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbpessoas_complemento_pf t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 2339 (class 1259 OID 18293)
-- Dependencies: 2506 7
-- Name: view_pessoas_complemento_pj; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_pessoas_complemento_pj AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigopessoa)::text AS codigopessoa, (t1.datafundacao)::text AS datafundacao, (t1.gerente)::text AS gerente, (t1.diretor)::text AS diretor, (t1.representante)::text AS representante, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbpessoas_complemento_pj t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 2340 (class 1259 OID 18297)
-- Dependencies: 2507 7
-- Name: view_pessoas_convenios; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_pessoas_convenios AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, (t1.codigopessoa)::text AS codigopessoa, (t1.codigoconvenio)::text AS codigoconvenio, (t0.titulo)::text AS titulo, t0.descricao, (t0.tipoconvenio)::text AS tipoconvenio, (t0.tipotransacao)::text AS tipotransacao, (t0.valor)::text AS valor, (t0.formato)::text AS formato, (t0.datavigencia)::text AS datavirgencia, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM ((dbpessoas_convenios t1 LEFT JOIN dbconvenios t0 ON (((t1.codigoconvenio)::text = (t0.codigo)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 2341 (class 1259 OID 18302)
-- Dependencies: 2508 7
-- Name: view_pessoas_demandas; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_pessoas_demandas AS
    SELECT t0.id, (t0.codigo)::text AS codigo, (t0.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, (t0.codigopessoa)::text AS codigopessoa, (t0.codigocurso)::text AS codigocurso, (t0.turno)::text AS turno, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t3.nome)::text AS nomecurso, (t2.nome_razaosocial)::text AS nomepessoa, (t2.tel1)::text AS tel1, (t2.cel1)::text AS cel1, (t2.email1)::text AS email1 FROM (((dbpessoas_demandas t0 LEFT JOIN dbpessoas t2 ON (((t2.codigo)::text = (t0.codigopessoa)::text))) LEFT JOIN dbcursos t3 ON (((t3.codigo)::text = (t0.codigocurso)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t0.ativo)::text)));


--
-- TOC entry 2342 (class 1259 OID 18307)
-- Dependencies: 2509 7
-- Name: view_pessoas_enderecoscobrancas; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_pessoas_enderecoscobrancas AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigopessoa)::text AS codigopessoa, (t1.nomecobranca)::text AS nomecobranca, (t1.cpf_cnpjcobranca)::text AS cpf_cnpjcobranca, (t1.logradourocobranca)::text AS logradourocobranca, (t1.cidadecobranca)::text AS cidadecobranca, (t1.estadocobranca)::text AS estadocobranca, (t1.cepcobranca)::text AS cepcobranca, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbpessoas_enderecoscobrancas t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 2343 (class 1259 OID 18312)
-- Dependencies: 2510 7
-- Name: view_pessoas_formacoes; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_pessoas_formacoes AS
    SELECT t0.id, (t0.codigo)::text AS codigo, (t0.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, (t0.codigopessoa)::text AS codigopessoa, (t0.codigotitularidade)::text AS codigotitularidade, (t0.curso)::text AS curso, (t0.instituicao)::text AS instituicao, (t0.anoconclusao)::text AS anoconclusao, t0.observacao, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t3.nome_razaosocial)::text AS nomepessoa, (t2.titularidade)::text AS titularidade, (t2.nomeacao)::text AS nomeacao, (t2.peso)::text AS peso FROM (((dbpessoas_formacoes t0 LEFT JOIN dbpessoas_titularidades t2 ON (((t2.codigo)::text = (t0.codigotitularidade)::text))) LEFT JOIN dbpessoas t3 ON (((t3.codigo)::text = (t0.codigopessoa)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t0.ativo)::text)));


--
-- TOC entry 2344 (class 1259 OID 18317)
-- Dependencies: 2511 7
-- Name: view_pessoas_inscricoes; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_pessoas_inscricoes AS
    SELECT t0.id, (t0.codigo)::text AS codigo, (t0.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, (t0.codigopessoa)::text AS codigopessoa, (t0.codigotransacao)::text AS codigotransacao, (t0.opcobranca)::text AS opcobranca, (t0.codigoturma)::text AS codigoturma, (t0.codigocurso)::text AS codigocurso, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t2.nome_razaosocial)::text AS nomepessoa, (t2.cpf_cnpj)::text AS cpf_cnpj, (t2.tel1)::text AS telefone, (t2.email1)::text AS email, (t3.titulo)::text AS nometurma, (t3.datainicio)::text AS datainicio, (t3.valortaxa)::text AS valortaxa, (t3.numparcelas)::text AS numparcelas, (t3.valormensal)::text AS valormatricula, (t3.valormensal)::text AS valorparcelas, (t3.valordescontado)::text AS valordescontado, (t4.nome)::text AS nomecurso FROM ((((dbpessoas_inscricoes t0 LEFT JOIN dbpessoas t2 ON (((t2.codigo)::text = (t0.codigopessoa)::text))) LEFT JOIN dbturmas t3 ON (((t3.codigo)::text = (t0.codigoturma)::text))) LEFT JOIN dbcursos t4 ON (((t4.codigo)::text = (t0.codigocurso)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t0.ativo)::text)));


--
-- TOC entry 2345 (class 1259 OID 18322)
-- Dependencies: 2512 7
-- Name: view_pessoas_livros; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_pessoas_livros AS
    SELECT t0.id, (t0.codigo)::text AS codigo, (t0.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, (t0.codigopessoa)::text AS codigopessoa, (t0.codigolivro)::text AS codigolivro, (t0.previsaosaida)::text AS previsaosaida, (t0.previsaoentrada)::text AS previsaoentrada, (t0.confirmacaosaida)::text AS confirmacaosaida, (t0.confirmacaoentrada)::text AS confirmacaoentrada, (t0.situacao)::text AS situacao, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t1.nome_razaosocial)::text AS nomepessoa, (t3.label)::text AS titulolivro, (t2.autor)::text AS autorlivro, (t3.codigo)::text AS codigopatrimonio FROM ((((dbpessoas_livros t0 LEFT JOIN dbpessoas t1 ON (((t1.codigo)::text = (t0.codigopessoa)::text))) LEFT JOIN dbpatrimonios_livros t2 ON (((t2.codigo)::text = (t0.codigolivro)::text))) LEFT JOIN dbpatrimonios t3 ON (((t3.codigo)::text = (t2.codigopatrimonio)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 2346 (class 1259 OID 18327)
-- Dependencies: 2513 7
-- Name: view_pessoas_solicitacoes; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_pessoas_solicitacoes AS
    SELECT t0.id, (t0.codigo)::text AS codigo, (t0.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, (t0.codigopessoa)::text AS codigopessoa, (t0.solicitacao)::text AS solicitacao, (t0.data)::text AS data, t0.justificativa, t0.atendimento, (t0.codigofuncionario)::text AS codigofuncionario, (t0.codigodepartamento)::text AS codigodepartamento, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t0.status)::text AS status, (t2.nome_razaosocial)::text AS nomepessoa, (t3.nome_razaosocial)::text AS nomefuncionario, (t4.label)::text AS nomedepartamento FROM ((((dbpessoas_solicitacoes t0 LEFT JOIN dbpessoas t2 ON (((t2.codigo)::text = (t0.codigopessoa)::text))) LEFT JOIN dbpessoas t3 ON (((t3.codigo)::text = ((SELECT t5.codigopessoa FROM dbpessoas_funcionarios t5 WHERE ((t5.codigo)::text = (t0.codigofuncionario)::text)))::text))) LEFT JOIN dbdepartamentos t4 ON (((t4.codigo)::text = (t0.codigodepartamento)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t0.ativo)::text)));


--
-- TOC entry 2347 (class 1259 OID 18332)
-- Dependencies: 2514 7
-- Name: view_plano_contas; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_plano_contas AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.nomeconta)::text AS nomeconta, (t1.tipoconta)::text AS tipoconta, (t1.categoria)::text AS categoria, (t1.tipocusto)::text AS tipocusto, t1.obs, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbplano_contas t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 2348 (class 1259 OID 18336)
-- Dependencies: 2515 7
-- Name: view_produtos; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_produtos AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.label)::text AS label, t1.descricao, (t1.valor)::text AS valor, (t1.valoralteravel)::text AS valoralteravel, (t1.tabela)::text AS tabela, t1.obs, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t1.codigotipoproduto)::text AS codigotipoproduto, (t2.titulo)::text AS tipoproduto FROM ((dbprodutos t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text))) LEFT JOIN dbprodutos_tipos t2 ON (((t2.codigo)::text = (t1.codigotipoproduto)::text)));


--
-- TOC entry 2349 (class 1259 OID 18341)
-- Dependencies: 2516 7
-- Name: view_produtos_caracteristicas; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_produtos_caracteristicas AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigoproduto)::text AS codigoproduto, t1.beneficios, t1.limitacoes, t1.mododeuso, (t1.unid)::text AS unid, (t1.qtde)::text AS qtde, (t1.cor)::text AS cor, (t1.tamanho)::text AS tamanho, (t1.peso)::text AS peso, (t1.altura)::text AS altura, (t1.largura)::text AS largura, (t1.comprimento)::text AS comprimento, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbprodutos_caracteristicas t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 2350 (class 1259 OID 18346)
-- Dependencies: 2517 7
-- Name: view_produtos_parametros; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_produtos_parametros AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigoproduto)::text AS codigoproduto, (t1.tabela)::text AS tabela, (t1.collabel)::text AS collabel, (t1.colvalor)::text AS colvalor, (t1.coldesc)::text AS coldesc, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t1.codigotipoproduto)::text AS codigotipoproduto, (t2.titulo)::text AS tipoproduto FROM ((dbprodutos_parametros t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text))) LEFT JOIN dbprodutos_tipos t2 ON (((t2.codigo)::text = (t1.codigotipoproduto)::text)));


--
-- TOC entry 2351 (class 1259 OID 18351)
-- Dependencies: 2518 7
-- Name: view_produtos_turmas; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_produtos_turmas AS
    SELECT t0.id, (t0.codigo)::text AS codigo, (t0.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, (t0.label)::text AS label, t0.descricao, (t0.valor)::text AS valor, (t0.valoralteravel)::text AS valoralteravel, (t0.tabela)::text AS tabela, t0.obs, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t3.nome)::text AS nomecurso, (t2.titulo)::text AS nometurma, (t2.codigoplanoconta)::text AS codigoplanoconta, (t2.datainicio)::text AS datainicio, (t2.datafim)::text AS datafim, (t2.frequenciaaula)::text AS frequenciaaula, (t2.horainicio)::text AS horainicio, (t2.horafim)::text AS horafim, (t2.diasaula)::text AS diasaula, (t2.localaulas)::text AS localaulas, (t2.valortotal)::text AS valortotal, (t2.valortaxa)::text AS valortaxa, (t2.valormatricula)::text AS valormatricula, (t2.valormensal)::text AS valormensal, (t2.valordescontado)::text AS valordescontado, (t2.numparcelas)::text AS numparcelas, (t2.datavencimento)::text AS datavencimento, (t0.codigotipoproduto)::text AS codigotipoproduto, (t5.titulo)::text AS tipoproduto FROM ((((dbprodutos t0 LEFT JOIN dbturmas t2 ON (((t2.codigoproduto)::text = (t0.codigo)::text))) LEFT JOIN dbcursos t3 ON (((t3.codigo)::text = (t2.codigocurso)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t0.ativo)::text))) LEFT JOIN dbprodutos_tipos t5 ON (((t5.codigo)::text = (t0.codigotipoproduto)::text))) WHERE ((t0.tabela)::text = 'dbturma'::text);


--
-- TOC entry 2352 (class 1259 OID 18356)
-- Dependencies: 2519 7
-- Name: view_professores_areas; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_professores_areas AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigoprofessor)::text AS codigoprofessor, (t1.codigoareacurso)::text AS codigoareacurso, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t2.titulo)::text AS nomeareacurso FROM ((dbprofessores_areas t1 LEFT JOIN dbcursos_areas t2 ON (((t2.codigo)::text = (t1.codigoareacurso)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 2353 (class 1259 OID 18361)
-- Dependencies: 2520 7
-- Name: view_projetos; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_projetos AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigoproduto)::text AS codigoproduto, (t1.titulo)::text AS titulo, (t1.responsavelnome)::text AS responsavelnome, (t1.responsavelfuncao)::text AS responsavelfuncao, t1.objetivo, (t1.prazo)::text AS prazo, t1.resumo, t1.descrisco, t1.medidasrisco, t1.descresultado, (t1.receitapropria)::text AS receitapropria, (t1.receitaclientes)::text AS receitaclientes, (t1.receitaparceiros)::text AS receitaparceiros, (t1.receitafornecedores)::text AS receitafornecedores, (t1.receitatotal)::text AS receitatotal, (t1.recursostotal)::text AS recursostotal, (t1.custostotal)::text AS custostotal, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbprojetos t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 2354 (class 1259 OID 18366)
-- Dependencies: 2521 7
-- Name: view_projetos_colaboradores; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_projetos_colaboradores AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigoprojeto)::text AS codigoprojeto, (t1.codigopessoa)::text AS codigopessoa, (t1.funcao)::text AS funcao, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbprojetos_colaboradores t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 2355 (class 1259 OID 18370)
-- Dependencies: 2522 7
-- Name: view_projetos_custos; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_projetos_custos AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigoprojeto)::text AS codigoprojeto, (t1.item)::text AS item, (t1.valor)::text AS valor, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbprojetos_custos t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 2356 (class 1259 OID 18374)
-- Dependencies: 2523 7
-- Name: view_projetos_recursos; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_projetos_recursos AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigoprojeto)::text AS codigoprojeto, (t1.recurso)::text AS recurso, (t1.quantidade)::text AS quantidade, (t1.tempo)::text AS tempo, (t1.tipouso)::text AS tipouso, (t1.custounitario)::text AS custounitario, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbprojetos_recursos t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 2357 (class 1259 OID 18378)
-- Dependencies: 2524 7
-- Name: view_questionarios; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_questionarios AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.titulo)::text AS titulo, (t1.datainicio)::text AS datainicio, (t1.datafim)::text AS datafim, (t1.numquestoes)::text AS numquestoes, (t1.numquestoesmax)::text AS numquestoesmax, (t1.numtentativas)::text AS numtentativas, t1.obs, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbquestionarios t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 2358 (class 1259 OID 18382)
-- Dependencies: 2525 7
-- Name: view_questoes; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_questoes AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigoquestionario)::text AS codigoquestionario, t1.enunciado, (t1.tipoquestao)::text AS tipoquestao, (t1.valorquestao)::text AS valorquestao, t1.obs, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbquestoes t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 2359 (class 1259 OID 18386)
-- Dependencies: 2526 7
-- Name: view_questoes_itens; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_questoes_itens AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigoquestao)::text AS codigoquestao, t1.enunciado, (t1.valoritem)::text AS valoritem, t1.obs, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbquestoes_itens t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 2360 (class 1259 OID 18390)
-- Dependencies: 2527 7
-- Name: view_recados; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_recados AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.nomepessoa)::text AS nomepessoa, (t1.referencia)::text AS referencia, (t1.interessado)::text AS interessado, t1.obs, (t1.tel1)::text AS tel1, (t1.tel2)::text AS tel2, (t1.email)::text AS email, (t1.situacao)::text AS situacao, to_char((t1.retorno)::timestamp with time zone, 'DD/MM/YYYY'::text) AS retorno, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbrecados t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 2361 (class 1259 OID 18395)
-- Dependencies: 2528 7
-- Name: view_salas; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_salas AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.nome)::text AS nome, t1.endereco, t1.descricao, (t1.salaaula)::text AS salaaula, (t1.codigofuncionario)::text AS codigofuncionario, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t3.nome_razaosocial)::text AS nomefuncionario, (t2.nomeunidade)::text AS nomeunidade FROM (((dbsalas t1 LEFT JOIN dbunidades t2 ON (((t2.codigo)::text = (t1.unidade)::text))) LEFT JOIN dbpessoas t3 ON (((t3.codigo)::text = ((SELECT t4.codigopessoa FROM dbpessoas_funcionarios t4 WHERE ((t4.codigo)::text = (t1.codigofuncionario)::text)))::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 2362 (class 1259 OID 18400)
-- Dependencies: 2529 7
-- Name: view_scorecard; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_scorecard AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.titulo)::text AS titulo, (t1.meta)::text AS meta, (t1.pareto)::text AS pareto, (t1.codigomodulo)::text AS codigomodulo, (t1.agrupamentoperiodico)::text AS agrupamentoperiodico, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbscorecard t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 2363 (class 1259 OID 18404)
-- Dependencies: 2530 7
-- Name: view_scorecard_sentencas; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_scorecard_sentencas AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigoscorecard)::text AS codigoscorecard, (t1.tabela)::text AS tabela, (t1.colunax)::text AS colunax, (t1.agrupamentox)::text AS agrupamentox, (t1.colunay)::text AS colunay, (t1.agrupamentoy)::text AS agrupamentoy, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbscorecard_sentencas t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 2364 (class 1259 OID 18408)
-- Dependencies: 2531 7
-- Name: view_transacoes; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_transacoes AS
    SELECT t0.id, (t0.codigo)::text AS codigo, (t0.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, (t0.codigopessoa)::text AS codigopessoa, (t0.tipomovimentacao)::text AS tipomovimentacao, (t0.valortotal)::text AS valortotal, (t0.desconto)::text AS desconto, (t0.acrescimo)::text AS acrescimo, (t0.valorcorrigido)::text AS valorcorrigido, (t0.formapag)::text AS formapag, (t0.codigoplanoconta)::text AS codigoplanoconta, (t0.numparcelas)::text AS numparcelas, (t0.intervaloparcelas)::text AS intervaloparcelas, (t0.datafixavencimento)::text AS datafixavencimento, (t0.vencimento)::text AS vencimento, (t0.efetivada)::text AS efetivada, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t2.nome_razaosocial)::text AS cliente, (t3.nomeconta)::text AS planoconta, ((SELECT count(dbtransacoes_contas.codigo) AS count FROM dbtransacoes_contas WHERE (((dbtransacoes_contas.codigotransacao)::text = (t0.codigo)::text) AND (dbtransacoes_contas.statusconta = 2))))::text AS numparcelaspagas, ((SELECT sum(dbtransacoes_contas.valorreal) AS sum FROM dbtransacoes_contas WHERE (((dbtransacoes_contas.codigotransacao)::text = (t0.codigo)::text) AND (dbtransacoes_contas.statusconta = 1))))::text AS valorreal, ((SELECT count(dbtransacoes_contas.codigo) AS count FROM dbtransacoes_contas WHERE (((dbtransacoes_contas.codigotransacao)::text = (t0.codigo)::text) AND (dbtransacoes_contas.statusconta = 1))))::text AS numparcelasabertas FROM (((dbtransacoes t0 LEFT JOIN dbpessoas t2 ON (((t2.codigo)::text = (t0.codigopessoa)::text))) LEFT JOIN dbplano_contas t3 ON (((t3.codigo)::text = (t0.codigoplanoconta)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t0.ativo)::text)));


--
-- TOC entry 2365 (class 1259 OID 18413)
-- Dependencies: 2532 7
-- Name: view_transacoes_contas; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_transacoes_contas AS
    SELECT t0.id, (t0.codigo)::text AS codigo, (t0.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, (t0.codigotransacao)::text AS codigotransacao, (t0.codigopessoa)::text AS codigopessoa, (t0.codigoplanoconta)::text AS codigoplanoconta, (t0.tipomovimentacao)::text AS tipomovimentacao, (t0.valornominal)::text AS valornominal, (t0.valorreal)::text AS valorreal, (t0.numparcela)::text AS numparcela, (t0.desconto)::text AS desconto, to_char((t0.vencimento)::timestamp with time zone, 'DD/MM/YYYY'::text) AS vencimento, t0.obs, (t0.statusconta)::text AS statusconta, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t2.nome_razaosocial)::text AS nomepessoa, (t3.nomeconta)::text AS nomeplanoconta, t0.instrucoespagamento, ((SELECT sum(t4.valorpago) AS sum FROM dbcaixa t4 WHERE ((t4.codigoconta)::text = (t0.codigo)::text)))::text AS valorpago, (t4.codigocontacaixa)::text AS codigocontacaixa, (t4.numdoc)::text AS numdoc, (t4.datadocumento)::text AS datadocumento, (t4.tipoduplicata)::text AS tipoduplicata, (t4.valorreal)::text AS valorrealmovimento, (t4.formadesconto)::text AS formadesconto, (t4.desconto)::text AS descontomovimento, (t4.multaacrecimo)::text AS multaacrecimo, (t4.valorpago)::text AS valorpagomovimento, (t4.valorentrada)::text AS valorentrada, (t4.codigofuncionario)::text AS codigofuncionario, to_char((t4.datapag)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datapag, (t4.formapag)::text AS formapag, (t4.mora)::text AS mora, t4.obs AS obsmovimento, (t4.statusmovimento)::text AS statusmovimento, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, to_char((t4.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datamovimentacao FROM ((((dbtransacoes_contas t0 LEFT JOIN dbpessoas t2 ON (((t2.codigo)::text = (t0.codigopessoa)::text))) LEFT JOIN dbplano_contas t3 ON (((t3.codigo)::text = (t0.codigoplanoconta)::text))) LEFT JOIN dbcaixa t4 ON (((t4.codigoconta)::text = (t0.codigo)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t0.ativo)::text)));


--
-- TOC entry 2366 (class 1259 OID 18418)
-- Dependencies: 2533 7
-- Name: view_transacoes_contas_duplicatas; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_transacoes_contas_duplicatas AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigoconta)::text AS codigoconta, (t1.codigopessoa)::text AS codigopessoa, (t1.ndocumento)::text AS ndocumento, (t1.dataprocesso)::text AS dataprocesso, (t1.cpfsacado)::text AS cpfsacado, (t1.valordoc)::text AS valordoc, (t1.vencimento)::text AS vencimento, (t1.databaixa)::text AS databaixa, (t1.statusduplicata)::text AS statusduplicata, (t1.tipoduplicata)::text AS tipoduplicata, (t1.classificacao)::text AS classificacao, t1.bkp, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbtransacoes_contas_duplicatas t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 2367 (class 1259 OID 18423)
-- Dependencies: 2534 7
-- Name: view_transacoes_convenios; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_transacoes_convenios AS
    SELECT t0.id, (t0.codigo)::text AS codigo, (t0.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, (t0.codigotransacao)::text AS codigotransacao, (t0.codigoconvenio)::text AS codigoconvenio, (t2.titulo)::text AS nomeconvenio, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM ((dbtransacoes_convenios t0 LEFT JOIN dbconvenios t2 ON (((t2.codigo)::text = (t0.codigoconvenio)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t0.ativo)::text)));


--
-- TOC entry 2368 (class 1259 OID 18428)
-- Dependencies: 2535 7
-- Name: view_transacoes_produtos; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_transacoes_produtos AS
    SELECT t0.id, (t0.codigo)::text AS codigo, (t0.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, (t0.codigotransacao)::text AS codigotransacao, (t0.codigoproduto)::text AS codigoproduto, (t0.tabelaproduto)::text AS tabelaproduto, (t0.valornominal)::text AS valornominal, ((t0.valornominal * (t0.quantidade)::double precision))::text AS valortotal, (t0.quantidade)::text AS quantidade, t0.obs, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, t2.descricao, (t2.label)::text AS label FROM ((dbtransacoes_produtos t0 LEFT JOIN dbprodutos t2 ON (((t2.codigo)::text = (t0.codigoproduto)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t0.ativo)::text)));


--
-- TOC entry 2369 (class 1259 OID 18433)
-- Dependencies: 2536 7
-- Name: view_treinamentos; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_treinamentos AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.nomecurso)::text AS nomecurso, t1.ementa, (t1.cargahoraria)::text AS cargahoraria, (t1.ministrante)::text AS ministrante, (t1.codigotitularidade)::text AS codigotitularidade, t1.curriculoministrante, (t1.instituicaocertificadora)::text AS instituicaocertificadora, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbtreinamentos t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 2370 (class 1259 OID 18438)
-- Dependencies: 2537 7
-- Name: view_turmas; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_turmas AS
    SELECT (t2.nome)::text AS nomecurso, t0.id, (t0.codigo)::text AS codigo, (t0.unidade)::text AS unidade, (t0.titulo)::text AS titulo, ((SELECT sum(t4.cargahoraria) AS sum FROM dbdisciplinas t4 WHERE ((t4.codigo)::text IN (SELECT t5.codigodisciplina FROM dbturmas_disciplinas t5 WHERE ((t5.codigoturma)::text = (t0.codigo)::text)))))::text AS cargahoraria, (t0.valortaxa)::text AS valortaxa, (t0.valormatricula)::text AS valormatricula, (t0.valormensal)::text AS valormensal, (t0.valordescontado)::text AS valordescontado, (t0.vagas)::text AS vagas, (t0.numparcelas)::text AS numparcelas, (t0.status)::text AS status, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t0.datainicio)::text AS datainicio, (t0.codigoproduto)::text AS codigoproduto, (t3.nomeunidade)::text AS nomeunidade, (t0.codigocurso)::text AS codigocurso, (t4.titulo)::text AS nomecursoativo, ((SELECT count(t5.codigoturma) AS count FROM dbpessoas_inscricoes t5 WHERE ((t5.codigoturma)::text = (t0.codigo)::text)))::text AS inscritos, ((SELECT count(t6.codigoturma) AS count FROM dbpessoas_alunos t6 WHERE ((t6.codigoturma)::text = (t0.codigo)::text)))::text AS matriculados, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t0.codigograde)::text AS codigograde FROM ((((dbturmas t0 LEFT JOIN dbcursos t2 ON (((t2.codigo)::text = (t0.codigocurso)::text))) LEFT JOIN dbcursos_ativos t4 ON (((t4.codigo)::text = (t0.codigocursoativo)::text))) LEFT JOIN dbunidades t3 ON (((t3.codigo)::text = (t0.unidade)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t0.ativo)::text)));


--
-- TOC entry 2371 (class 1259 OID 18443)
-- Dependencies: 2538 7
-- Name: view_turmas_convenios; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_turmas_convenios AS
    SELECT t0.id, (t0.codigo)::text AS codigo, (t0.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, (t0.codigoturma)::text AS codigoturma, (t0.codigoconvenio)::text AS codigoconvenio, (t2.titulo)::text AS nomeconvenio, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM ((dbturmas_convenios t0 LEFT JOIN dbconvenios t2 ON (((t2.codigo)::text = (t0.codigoconvenio)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t0.ativo)::text)));


--
-- TOC entry 2372 (class 1259 OID 18448)
-- Dependencies: 2539 7
-- Name: view_turmas_descontos; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_turmas_descontos AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigoturma)::text AS codigoturma, (t1.dialimite)::text AS dialimite, (t1.valordescontado)::text AS valordescontado, t1.obs, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t1.tipodesconto)::text AS tipodesconto FROM (dbturmas_descontos t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 2373 (class 1259 OID 18452)
-- Dependencies: 2540 7
-- Name: view_turmas_disciplinas_arquivos; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_turmas_disciplinas_arquivos AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.tipo)::text AS tipo, (t1.codigoturmadisciplina)::text AS codigoturmadisciplina, (t1.codigoprofessor)::text AS codigoprofessor, (t1.titulo)::text AS titulo, t1.obs, t1.arquivo, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbturmas_disciplinas_arquivos t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 2374 (class 1259 OID 18456)
-- Dependencies: 2541 7
-- Name: view_turmas_disciplinas_aulas; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_turmas_disciplinas_aulas AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigoturmadisciplina)::text AS codigoturmadisciplina, (t1.dataaula)::text AS dataaula, t1.conteudo, (t1.frequencia)::text AS frequencia, t1.obs, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbturmas_disciplinas_aulas t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 2375 (class 1259 OID 18460)
-- Dependencies: 2542 7
-- Name: view_turmas_disciplinas_avaliacoes; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_turmas_disciplinas_avaliacoes AS
    SELECT t2.id, (t2.codigo)::text AS codigo, (t2.unidade)::text AS unidade, (t2.codigoautor)::text AS codigoautor, (t2.avaliacao)::text AS avaliacao, (t2.peso)::text AS peso, (t2.ordem)::text AS ordem, (t2.codigoregra)::text AS codigoregra, t2.incontrol, (t2.referencia)::text AS referencia, t2.condicao, (t2.codigograde)::text AS codigograde, to_char((t2.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, t1.codigoturma, t1.codigo AS codigoturmadisciplina FROM ((dbturmas_disciplinas t1 JOIN dbavaliacoes t2 ON (((t2.codigograde)::text = ((SELECT dbturmas.codigograde FROM dbturmas WHERE ((dbturmas.codigo)::text = (t1.codigoturma)::text)))::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t2.ativo)::text)));


--
-- TOC entry 2376 (class 1259 OID 18465)
-- Dependencies: 2543 7
-- Name: view_turmas_disciplinas_materiais; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_turmas_disciplinas_materiais AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigoturmadisciplina)::text AS codigoturmadisciplina, (t1.material)::text AS material, t1.descricao, (t1.custo)::text AS custo, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbturmas_disciplinas_materiais t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 2377 (class 1259 OID 18469)
-- Dependencies: 2544 7
-- Name: view_turmas_disciplinas_planoaulas; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_turmas_disciplinas_planoaulas AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigoturmadisciplina)::text AS codigoturmadisciplina, (t1.codigoprofessor)::text AS codigoprofessor, (t1.dataaula)::text AS dataaula, t1.conteudo, t1.recursos, t1.metodologia, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbturmas_disciplinas_planoaulas t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 2378 (class 1259 OID 18473)
-- Dependencies: 2545 7
-- Name: view_turmas_requisitos; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_turmas_requisitos AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigoturma)::text AS codigoturma, (t1.requisito)::text AS requisito, (t1.situacao)::text AS situacao, t1.obs, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbturmas_requisitos t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 2379 (class 1259 OID 18477)
-- Dependencies: 2546 7
-- Name: view_unidades; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_unidades AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.nomeunidade)::text AS nomeunidade, (t1.razaosocial)::text AS razaosocial, (t1.cnpj)::text AS cnpj, (t1.inscestadual)::text AS inscestadual, (t1.inscmunicipal)::text AS inscmunicipal, (t1.gerente)::text AS gerente, (t1.diretor)::text AS diretor, (t1.representante)::text AS representante, (t1.logradouro)::text AS logradouro, (t1.bairro)::text AS bairro, (t1.cidade)::text AS cidade, (t1.estado)::text AS estado, (t1.cep)::text AS cep, (t1.email)::text AS email, (t1.telefone)::text AS telefone, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbunidades t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 2380 (class 1259 OID 18482)
-- Dependencies: 2547 7
-- Name: view_usuarios; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_usuarios AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.classeuser)::text AS classeuser, (t1.codigopessoa)::text AS codigopessoa, (t2.nome_razaosocial)::text AS nomepessoa, (t1.usuario)::text AS usuario, (t1.senha)::text AS senha, (t1.entidadepai)::text AS entidadepai, (t1.codigotema)::text AS codigotema, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM ((dbusuarios t1 LEFT JOIN dbpessoas t2 ON (((t2.codigo)::text = (t1.codigopessoa)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


SET search_path = dominio, pg_catalog;

--
-- TOC entry 2739 (class 2604 OID 18487)
-- Dependencies: 2072 2071
-- Name: id; Type: DEFAULT; Schema: dominio; Owner: -
--

ALTER TABLE dbceps ALTER COLUMN id SET DEFAULT nextval('dbceps_id_seq'::regclass);


--
-- TOC entry 2740 (class 2604 OID 18488)
-- Dependencies: 2074 2073
-- Name: id; Type: DEFAULT; Schema: dominio; Owner: -
--

ALTER TABLE dbcidades ALTER COLUMN id SET DEFAULT nextval('dbcidades_id_seq'::regclass);


--
-- TOC entry 2741 (class 2604 OID 18489)
-- Dependencies: 2076 2075
-- Name: id; Type: DEFAULT; Schema: dominio; Owner: -
--

ALTER TABLE dbestados ALTER COLUMN id SET DEFAULT nextval('dbestados_id_seq'::regclass);


--
-- TOC entry 2742 (class 2604 OID 18490)
-- Dependencies: 2079 2077
-- Name: id; Type: DEFAULT; Schema: dominio; Owner: -
--

ALTER TABLE dbnfe_erros ALTER COLUMN id SET DEFAULT nextval('dbnfe_erros_id_seq'::regclass);


--
-- TOC entry 2743 (class 2604 OID 18491)
-- Dependencies: 2082 2081
-- Name: id; Type: DEFAULT; Schema: dominio; Owner: -
--

ALTER TABLE dbpaises ALTER COLUMN id SET DEFAULT nextval('dbpaises_id_seq'::regclass);


--
-- TOC entry 2744 (class 2604 OID 18492)
-- Dependencies: 2086 2083
-- Name: id; Type: DEFAULT; Schema: dominio; Owner: -
--

ALTER TABLE dbwebservices ALTER COLUMN id SET DEFAULT nextval('dbwebservices_id_seq'::regclass);


--
-- TOC entry 2745 (class 2604 OID 18493)
-- Dependencies: 2085 2084
-- Name: id; Type: DEFAULT; Schema: dominio; Owner: -
--

ALTER TABLE dbwebservices_campos ALTER COLUMN id SET DEFAULT nextval('dbwebservices_campos_id_seq'::regclass);


SET search_path = public, pg_catalog;

--
-- TOC entry 2784 (class 2604 OID 18494)
-- Dependencies: 2104 2103
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE dbavaliacoes ALTER COLUMN id SET DEFAULT nextval('dbavaliacoes_id_seq'::regclass);


--
-- TOC entry 2792 (class 2604 OID 18495)
-- Dependencies: 2106 2105
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE dbavaliacoes_regras ALTER COLUMN id SET DEFAULT nextval('dbavaliacoes_regras_id_seq'::regclass);


--
-- TOC entry 2888 (class 2604 OID 18496)
-- Dependencies: 2134 2133
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE dbconvenios_descontos ALTER COLUMN id SET DEFAULT nextval('dbconvenios_descontos_id_seq'::regclass);


--
-- TOC entry 3008 (class 2604 OID 18497)
-- Dependencies: 2175 2174
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE dbgrade_avaliacoes ALTER COLUMN id SET DEFAULT nextval('dbgrade_avaliacoes_id_seq'::regclass);


--
-- TOC entry 3208 (class 2604 OID 18498)
-- Dependencies: 2251 2250
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE dbstatus ALTER COLUMN id SET DEFAULT nextval('dbstatus_id_seq'::regclass);


--
-- TOC entry 3384 (class 2604 OID 20278)
-- Dependencies: 2381 2382 2382
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE dbtransacoes_contas_situacao ALTER COLUMN id SET DEFAULT nextval('dbtransacoes_contas_situacao_id_seq'::regclass);


--
-- TOC entry 3242 (class 2604 OID 18499)
-- Dependencies: 2261 2260
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE dbtransacoes_convenios ALTER COLUMN id SET DEFAULT nextval('dbtransacoes_convenios_id_seq'::regclass);


--
-- TOC entry 3289 (class 2604 OID 18500)
-- Dependencies: 2271 2270
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE dbturmas_convenios ALTER COLUMN id SET DEFAULT nextval('dbturmas_convenios_id_seq'::regclass);


--
-- TOC entry 3323 (class 2604 OID 18501)
-- Dependencies: 2281 2280
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE dbturmas_disciplinas_avaliacao_detalhamento ALTER COLUMN id SET DEFAULT nextval('dbturmas_disciplinas_avaliacao_detalhamento_id_seq'::regclass);


SET search_path = dominio, pg_catalog;

--
-- TOC entry 3390 (class 2606 OID 18681)
-- Dependencies: 2071 2071
-- Name: pk_dbceps; Type: CONSTRAINT; Schema: dominio; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbceps
    ADD CONSTRAINT pk_dbceps PRIMARY KEY (id);


--
-- TOC entry 3392 (class 2606 OID 18683)
-- Dependencies: 2073 2073
-- Name: pk_dbcidades; Type: CONSTRAINT; Schema: dominio; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbcidades
    ADD CONSTRAINT pk_dbcidades PRIMARY KEY (id);


--
-- TOC entry 3394 (class 2606 OID 18685)
-- Dependencies: 2075 2075
-- Name: pk_dbestados; Type: CONSTRAINT; Schema: dominio; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbestados
    ADD CONSTRAINT pk_dbestados PRIMARY KEY (id);


--
-- TOC entry 3396 (class 2606 OID 18687)
-- Dependencies: 2077 2077
-- Name: pk_dbnfe_erros; Type: CONSTRAINT; Schema: dominio; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbnfe_erros
    ADD CONSTRAINT pk_dbnfe_erros PRIMARY KEY (id);


--
-- TOC entry 3398 (class 2606 OID 18689)
-- Dependencies: 2078 2078
-- Name: pk_dbnfe_erros_grupos; Type: CONSTRAINT; Schema: dominio; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbnfe_erros_grupos
    ADD CONSTRAINT pk_dbnfe_erros_grupos PRIMARY KEY (id);


--
-- TOC entry 3400 (class 2606 OID 18691)
-- Dependencies: 2080 2080
-- Name: pk_dbnfe_erros_mensagens; Type: CONSTRAINT; Schema: dominio; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbnfe_erros_mensagens
    ADD CONSTRAINT pk_dbnfe_erros_mensagens PRIMARY KEY (id);


--
-- TOC entry 3402 (class 2606 OID 18693)
-- Dependencies: 2081 2081
-- Name: pk_dbpaises; Type: CONSTRAINT; Schema: dominio; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbpaises
    ADD CONSTRAINT pk_dbpaises PRIMARY KEY (id);


--
-- TOC entry 3404 (class 2606 OID 18695)
-- Dependencies: 2083 2083
-- Name: pk_dbwebservices; Type: CONSTRAINT; Schema: dominio; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbwebservices
    ADD CONSTRAINT pk_dbwebservices PRIMARY KEY (id);


--
-- TOC entry 3406 (class 2606 OID 18697)
-- Dependencies: 2084 2084
-- Name: pk_dbwebservices_campos; Type: CONSTRAINT; Schema: dominio; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbwebservices_campos
    ADD CONSTRAINT pk_dbwebservices_campos PRIMARY KEY (id);


SET search_path = public, pg_catalog;

--
-- TOC entry 3567 (class 2606 OID 18699)
-- Dependencies: 2171 2171
-- Name: dbfuncionarios_professores_uk_codigofuncionario; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbfuncionarios_professores
    ADD CONSTRAINT dbfuncionarios_professores_uk_codigofuncionario UNIQUE (codigofuncionario);


--
-- TOC entry 3810 (class 2606 OID 18701)
-- Dependencies: 2295 2295
-- Name: dbusuarios_uk_usuario; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbusuarios
    ADD CONSTRAINT dbusuarios_uk_usuario UNIQUE (usuario);


--
-- TOC entry 3408 (class 2606 OID 18703)
-- Dependencies: 2090 2090
-- Name: pk_dbalunos_disciplinas; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbalunos_disciplinas
    ADD CONSTRAINT pk_dbalunos_disciplinas PRIMARY KEY (codigo);


--
-- TOC entry 3412 (class 2606 OID 18714)
-- Dependencies: 2092 2092
-- Name: pk_dbalunos_disciplinas_aproveitamentos; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbalunos_disciplinas_aproveitamentos
    ADD CONSTRAINT pk_dbalunos_disciplinas_aproveitamentos PRIMARY KEY (codigo);


--
-- TOC entry 3416 (class 2606 OID 18716)
-- Dependencies: 2094 2094
-- Name: pk_dbalunos_faltas; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbalunos_faltas
    ADD CONSTRAINT pk_dbalunos_faltas PRIMARY KEY (codigo);


--
-- TOC entry 3420 (class 2606 OID 18718)
-- Dependencies: 2096 2096
-- Name: pk_dbalunos_notas; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbalunos_notas
    ADD CONSTRAINT pk_dbalunos_notas PRIMARY KEY (codigo);


--
-- TOC entry 3424 (class 2606 OID 18720)
-- Dependencies: 2098 2098
-- Name: pk_dbalunos_requisitos; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbalunos_requisitos
    ADD CONSTRAINT pk_dbalunos_requisitos PRIMARY KEY (codigo);


--
-- TOC entry 3428 (class 2606 OID 18722)
-- Dependencies: 2100 2100
-- Name: pk_dbalunos_solicitacoes; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbalunos_solicitacoes
    ADD CONSTRAINT pk_dbalunos_solicitacoes PRIMARY KEY (codigo);


--
-- TOC entry 3432 (class 2606 OID 18725)
-- Dependencies: 2102 2102
-- Name: pk_dbalunos_transacoes; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbalunos_transacoes
    ADD CONSTRAINT pk_dbalunos_transacoes PRIMARY KEY (codigo);


--
-- TOC entry 3436 (class 2606 OID 18727)
-- Dependencies: 2103 2103
-- Name: pk_dbavaliacoes; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbavaliacoes
    ADD CONSTRAINT pk_dbavaliacoes PRIMARY KEY (codigo);


--
-- TOC entry 3440 (class 2606 OID 18729)
-- Dependencies: 2105 2105
-- Name: pk_dbavaliacoes_regras; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbavaliacoes_regras
    ADD CONSTRAINT pk_dbavaliacoes_regras PRIMARY KEY (codigo);


--
-- TOC entry 3444 (class 2606 OID 18731)
-- Dependencies: 2108 2108
-- Name: pk_dbbalanco_patrimonial; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbbalanco_patrimonial
    ADD CONSTRAINT pk_dbbalanco_patrimonial PRIMARY KEY (codigo);


--
-- TOC entry 3448 (class 2606 OID 18733)
-- Dependencies: 2110 2110
-- Name: pk_dbbiblioteca_cdu; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbbiblioteca_cdu
    ADD CONSTRAINT pk_dbbiblioteca_cdu PRIMARY KEY (codigo);


--
-- TOC entry 3454 (class 2606 OID 18735)
-- Dependencies: 2112 2112
-- Name: pk_dbcaixa; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbcaixa
    ADD CONSTRAINT pk_dbcaixa PRIMARY KEY (codigo);


--
-- TOC entry 3458 (class 2606 OID 18737)
-- Dependencies: 2114 2114
-- Name: pk_dbcaixa_fechamentos; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbcaixa_fechamentos
    ADD CONSTRAINT pk_dbcaixa_fechamentos PRIMARY KEY (codigo);


--
-- TOC entry 3462 (class 2606 OID 18739)
-- Dependencies: 2116 2116
-- Name: pk_dbcaixa_funcionarios; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbcaixa_funcionarios
    ADD CONSTRAINT pk_dbcaixa_funcionarios PRIMARY KEY (codigo);


--
-- TOC entry 3466 (class 2606 OID 18741)
-- Dependencies: 2118 2118
-- Name: pk_dbcargos; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbcargos
    ADD CONSTRAINT pk_dbcargos PRIMARY KEY (codigo);


--
-- TOC entry 3484 (class 2606 OID 18743)
-- Dependencies: 2128 2128
-- Name: pk_dbcheques; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbcontas_cheques
    ADD CONSTRAINT pk_dbcheques PRIMARY KEY (codigo);


--
-- TOC entry 3470 (class 2606 OID 18745)
-- Dependencies: 2122 2122
-- Name: pk_dbcompras; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbcompras
    ADD CONSTRAINT pk_dbcompras PRIMARY KEY (codigo);


--
-- TOC entry 3474 (class 2606 OID 18747)
-- Dependencies: 2124 2124
-- Name: pk_dbcontas_caixa; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbcontas_caixa
    ADD CONSTRAINT pk_dbcontas_caixa PRIMARY KEY (codigo);


--
-- TOC entry 3478 (class 2606 OID 18749)
-- Dependencies: 2126 2126
-- Name: pk_dbcontas_caixa_historico; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbcontas_caixa_historico
    ADD CONSTRAINT pk_dbcontas_caixa_historico PRIMARY KEY (codigo);


--
-- TOC entry 3488 (class 2606 OID 18751)
-- Dependencies: 2130 2130
-- Name: pk_dbcontratos; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbcontratos
    ADD CONSTRAINT pk_dbcontratos PRIMARY KEY (codigo);


--
-- TOC entry 3493 (class 2606 OID 18753)
-- Dependencies: 2132 2132
-- Name: pk_dbconvenios; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbconvenios
    ADD CONSTRAINT pk_dbconvenios PRIMARY KEY (codigo);


--
-- TOC entry 3495 (class 2606 OID 18755)
-- Dependencies: 2133 2133
-- Name: pk_dbconvenios_descontos; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbconvenios_descontos
    ADD CONSTRAINT pk_dbconvenios_descontos PRIMARY KEY (codigo);


--
-- TOC entry 3499 (class 2606 OID 18757)
-- Dependencies: 2136 2136
-- Name: pk_dbcotacoes; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbcotacoes
    ADD CONSTRAINT pk_dbcotacoes PRIMARY KEY (codigo);


--
-- TOC entry 3503 (class 2606 OID 18759)
-- Dependencies: 2138 2138
-- Name: pk_dbcrm_demandas; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbcrm_demandas
    ADD CONSTRAINT pk_dbcrm_demandas PRIMARY KEY (codigo);


--
-- TOC entry 3507 (class 2606 OID 18761)
-- Dependencies: 2140 2140
-- Name: pk_dbcurriculos; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbcurriculos
    ADD CONSTRAINT pk_dbcurriculos PRIMARY KEY (codigo);


--
-- TOC entry 3511 (class 2606 OID 18763)
-- Dependencies: 2142 2142
-- Name: pk_dbcursos; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbcursos
    ADD CONSTRAINT pk_dbcursos PRIMARY KEY (codigo);


--
-- TOC entry 3515 (class 2606 OID 18765)
-- Dependencies: 2144 2144
-- Name: pk_dbcursos_areas; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbcursos_areas
    ADD CONSTRAINT pk_dbcursos_areas PRIMARY KEY (codigo);


--
-- TOC entry 3519 (class 2606 OID 18767)
-- Dependencies: 2146 2146
-- Name: pk_dbcursos_ativos; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbcursos_ativos
    ADD CONSTRAINT pk_dbcursos_ativos PRIMARY KEY (codigo);


--
-- TOC entry 3523 (class 2606 OID 18769)
-- Dependencies: 2148 2148
-- Name: pk_dbcursos_avaliacoes; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbcursos_avaliacoes
    ADD CONSTRAINT pk_dbcursos_avaliacoes PRIMARY KEY (codigo);


--
-- TOC entry 3527 (class 2606 OID 18771)
-- Dependencies: 2150 2150
-- Name: pk_dbcursos_disciplinas; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbcursos_disciplinas
    ADD CONSTRAINT pk_dbcursos_disciplinas PRIMARY KEY (codigo);


--
-- TOC entry 3531 (class 2606 OID 18773)
-- Dependencies: 2152 2152
-- Name: pk_dbcursos_tipos; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbcursos_tipos
    ADD CONSTRAINT pk_dbcursos_tipos PRIMARY KEY (codigo);


--
-- TOC entry 3535 (class 2606 OID 18775)
-- Dependencies: 2154 2154
-- Name: pk_dbdados_boleto; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbdados_boleto
    ADD CONSTRAINT pk_dbdados_boleto PRIMARY KEY (codigo);


--
-- TOC entry 3539 (class 2606 OID 18777)
-- Dependencies: 2156 2156
-- Name: pk_dbdepartamentos; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbdepartamentos
    ADD CONSTRAINT pk_dbdepartamentos PRIMARY KEY (codigo);


--
-- TOC entry 3543 (class 2606 OID 18779)
-- Dependencies: 2158 2158
-- Name: pk_dbdisciplinas; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbdisciplinas
    ADD CONSTRAINT pk_dbdisciplinas PRIMARY KEY (codigo);


--
-- TOC entry 3547 (class 2606 OID 18781)
-- Dependencies: 2160 2160
-- Name: pk_dbdisciplinas_semelhantes; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbdisciplinas_semelhantes
    ADD CONSTRAINT pk_dbdisciplinas_semelhantes PRIMARY KEY (codigo);


--
-- TOC entry 3551 (class 2606 OID 18783)
-- Dependencies: 2162 2162
-- Name: pk_dbdocumentos; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbdocumentos
    ADD CONSTRAINT pk_dbdocumentos PRIMARY KEY (codigo);


--
-- TOC entry 3555 (class 2606 OID 18785)
-- Dependencies: 2165 2165
-- Name: pk_dbfuncionarios_ferias; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbfuncionarios_ferias
    ADD CONSTRAINT pk_dbfuncionarios_ferias PRIMARY KEY (codigo);


--
-- TOC entry 3559 (class 2606 OID 18787)
-- Dependencies: 2167 2167
-- Name: pk_dbfuncionarios_folhapagamento; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbfuncionarios_folhapagamento
    ADD CONSTRAINT pk_dbfuncionarios_folhapagamento PRIMARY KEY (codigo);


--
-- TOC entry 3563 (class 2606 OID 18789)
-- Dependencies: 2169 2169
-- Name: pk_dbfuncionarios_ocorrencias; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbfuncionarios_ocorrencias
    ADD CONSTRAINT pk_dbfuncionarios_ocorrencias PRIMARY KEY (codigo);


--
-- TOC entry 3569 (class 2606 OID 18791)
-- Dependencies: 2171 2171
-- Name: pk_dbfuncionarios_professores; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbfuncionarios_professores
    ADD CONSTRAINT pk_dbfuncionarios_professores PRIMARY KEY (codigo);


--
-- TOC entry 3573 (class 2606 OID 18793)
-- Dependencies: 2173 2173
-- Name: pk_dbfuncionarios_treinamentos; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbfuncionarios_treinamentos
    ADD CONSTRAINT pk_dbfuncionarios_treinamentos PRIMARY KEY (codigo);


--
-- TOC entry 3577 (class 2606 OID 18795)
-- Dependencies: 2174 2174
-- Name: pk_dbgrade_avaliacoes; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbgrade_avaliacoes
    ADD CONSTRAINT pk_dbgrade_avaliacoes PRIMARY KEY (codigo);


--
-- TOC entry 3581 (class 2606 OID 18797)
-- Dependencies: 2178 2178
-- Name: pk_dbpatrimonios; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbpatrimonios
    ADD CONSTRAINT pk_dbpatrimonios PRIMARY KEY (codigo);


--
-- TOC entry 3585 (class 2606 OID 18799)
-- Dependencies: 2180 2180
-- Name: pk_dbpatrimonios_livros; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbpatrimonios_livros
    ADD CONSTRAINT pk_dbpatrimonios_livros PRIMARY KEY (codigo);


--
-- TOC entry 3589 (class 2606 OID 18801)
-- Dependencies: 2182 2182
-- Name: pk_dbpessoas; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbpessoas
    ADD CONSTRAINT pk_dbpessoas PRIMARY KEY (codigo);


--
-- TOC entry 3593 (class 2606 OID 18803)
-- Dependencies: 2184 2184
-- Name: pk_dbpessoas_alunos; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbpessoas_alunos
    ADD CONSTRAINT pk_dbpessoas_alunos PRIMARY KEY (codigo);


--
-- TOC entry 3597 (class 2606 OID 18805)
-- Dependencies: 2186 2186
-- Name: pk_dbpessoas_complemento_pf; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbpessoas_complemento_pf
    ADD CONSTRAINT pk_dbpessoas_complemento_pf PRIMARY KEY (codigo);


--
-- TOC entry 3601 (class 2606 OID 18807)
-- Dependencies: 2188 2188
-- Name: pk_dbpessoas_complemento_pj; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbpessoas_complemento_pj
    ADD CONSTRAINT pk_dbpessoas_complemento_pj PRIMARY KEY (codigo);


--
-- TOC entry 3606 (class 2606 OID 18809)
-- Dependencies: 2190 2190
-- Name: pk_dbpessoas_convenios; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbpessoas_convenios
    ADD CONSTRAINT pk_dbpessoas_convenios PRIMARY KEY (codigo);


--
-- TOC entry 3610 (class 2606 OID 18811)
-- Dependencies: 2192 2192
-- Name: pk_dbpessoas_demandas; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbpessoas_demandas
    ADD CONSTRAINT pk_dbpessoas_demandas PRIMARY KEY (codigo);


--
-- TOC entry 3614 (class 2606 OID 18813)
-- Dependencies: 2194 2194
-- Name: pk_dbpessoas_enderecoscobrancas; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbpessoas_enderecoscobrancas
    ADD CONSTRAINT pk_dbpessoas_enderecoscobrancas PRIMARY KEY (codigo);


--
-- TOC entry 3618 (class 2606 OID 18815)
-- Dependencies: 2196 2196
-- Name: pk_dbpessoas_formacoes; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbpessoas_formacoes
    ADD CONSTRAINT pk_dbpessoas_formacoes PRIMARY KEY (codigo);


--
-- TOC entry 3622 (class 2606 OID 18817)
-- Dependencies: 2198 2198
-- Name: pk_dbpessoas_funcionarios; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbpessoas_funcionarios
    ADD CONSTRAINT pk_dbpessoas_funcionarios PRIMARY KEY (codigo);


--
-- TOC entry 3626 (class 2606 OID 18819)
-- Dependencies: 2200 2200
-- Name: pk_dbpessoas_inscricoes; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbpessoas_inscricoes
    ADD CONSTRAINT pk_dbpessoas_inscricoes PRIMARY KEY (codigo);


--
-- TOC entry 3630 (class 2606 OID 18821)
-- Dependencies: 2202 2202
-- Name: pk_dbpessoas_livros; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbpessoas_livros
    ADD CONSTRAINT pk_dbpessoas_livros PRIMARY KEY (codigo);


--
-- TOC entry 3634 (class 2606 OID 18823)
-- Dependencies: 2204 2204
-- Name: pk_dbpessoas_solicitacoes; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbpessoas_solicitacoes
    ADD CONSTRAINT pk_dbpessoas_solicitacoes PRIMARY KEY (codigo);


--
-- TOC entry 3638 (class 2606 OID 18825)
-- Dependencies: 2206 2206
-- Name: pk_dbpessoas_titularidades; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbpessoas_titularidades
    ADD CONSTRAINT pk_dbpessoas_titularidades PRIMARY KEY (codigo);


--
-- TOC entry 3642 (class 2606 OID 18827)
-- Dependencies: 2208 2208
-- Name: pk_dbplano_contas; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbplano_contas
    ADD CONSTRAINT pk_dbplano_contas PRIMARY KEY (codigo);


--
-- TOC entry 3646 (class 2606 OID 18829)
-- Dependencies: 2210 2210
-- Name: pk_dbprocessos_academicos; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbprocessos_academicos
    ADD CONSTRAINT pk_dbprocessos_academicos PRIMARY KEY (codigo);


--
-- TOC entry 3651 (class 2606 OID 18831)
-- Dependencies: 2212 2212
-- Name: pk_dbprodutos; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbprodutos
    ADD CONSTRAINT pk_dbprodutos PRIMARY KEY (codigo);


--
-- TOC entry 3655 (class 2606 OID 18833)
-- Dependencies: 2214 2214
-- Name: pk_dbprodutos_insumos; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbprodutos_caracteristicas
    ADD CONSTRAINT pk_dbprodutos_insumos PRIMARY KEY (codigo);


--
-- TOC entry 3660 (class 2606 OID 18835)
-- Dependencies: 2219 2219
-- Name: pk_dbprodutos_parametros; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbprodutos_parametros
    ADD CONSTRAINT pk_dbprodutos_parametros PRIMARY KEY (codigo);


--
-- TOC entry 3664 (class 2606 OID 18837)
-- Dependencies: 2221 2221
-- Name: pk_dbprodutos_tabelapreco; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbprodutos_tabelapreco
    ADD CONSTRAINT pk_dbprodutos_tabelapreco PRIMARY KEY (codigo);


--
-- TOC entry 3668 (class 2606 OID 18839)
-- Dependencies: 2223 2223
-- Name: pk_dbprodutos_tipos; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbprodutos_tipos
    ADD CONSTRAINT pk_dbprodutos_tipos PRIMARY KEY (codigo);


--
-- TOC entry 3672 (class 2606 OID 18841)
-- Dependencies: 2225 2225
-- Name: pk_dbprodutos_tributos; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbprodutos_tributos
    ADD CONSTRAINT pk_dbprodutos_tributos PRIMARY KEY (codigo);


--
-- TOC entry 3676 (class 2606 OID 18843)
-- Dependencies: 2227 2227
-- Name: pk_dbprofessores_areas; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbprofessores_areas
    ADD CONSTRAINT pk_dbprofessores_areas PRIMARY KEY (codigo);


--
-- TOC entry 3680 (class 2606 OID 18845)
-- Dependencies: 2229 2229
-- Name: pk_dbprojetos; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbprojetos
    ADD CONSTRAINT pk_dbprojetos PRIMARY KEY (codigo);


--
-- TOC entry 3684 (class 2606 OID 18847)
-- Dependencies: 2231 2231
-- Name: pk_dbprojetos_colaboradores; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbprojetos_colaboradores
    ADD CONSTRAINT pk_dbprojetos_colaboradores PRIMARY KEY (codigo);


--
-- TOC entry 3688 (class 2606 OID 18849)
-- Dependencies: 2233 2233
-- Name: pk_dbprojetos_custos; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbprojetos_custos
    ADD CONSTRAINT pk_dbprojetos_custos PRIMARY KEY (codigo);


--
-- TOC entry 3692 (class 2606 OID 18851)
-- Dependencies: 2235 2235
-- Name: pk_dbprojetos_recursos; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbprojetos_recursos
    ADD CONSTRAINT pk_dbprojetos_recursos PRIMARY KEY (codigo);


--
-- TOC entry 3696 (class 2606 OID 18853)
-- Dependencies: 2237 2237
-- Name: pk_dbquestionarios; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbquestionarios
    ADD CONSTRAINT pk_dbquestionarios PRIMARY KEY (codigo);


--
-- TOC entry 3700 (class 2606 OID 18855)
-- Dependencies: 2239 2239
-- Name: pk_dbquestoes; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbquestoes
    ADD CONSTRAINT pk_dbquestoes PRIMARY KEY (codigo);


--
-- TOC entry 3704 (class 2606 OID 18857)
-- Dependencies: 2241 2241
-- Name: pk_dbquestoes_itens; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbquestoes_itens
    ADD CONSTRAINT pk_dbquestoes_itens PRIMARY KEY (codigo);


--
-- TOC entry 3708 (class 2606 OID 18859)
-- Dependencies: 2243 2243
-- Name: pk_dbrecados; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbrecados
    ADD CONSTRAINT pk_dbrecados PRIMARY KEY (codigo);


--
-- TOC entry 3712 (class 2606 OID 18861)
-- Dependencies: 2245 2245
-- Name: pk_dbsalas; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbsalas
    ADD CONSTRAINT pk_dbsalas PRIMARY KEY (codigo);


--
-- TOC entry 3716 (class 2606 OID 18863)
-- Dependencies: 2247 2247
-- Name: pk_dbscorecard; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbscorecard
    ADD CONSTRAINT pk_dbscorecard PRIMARY KEY (codigo);


--
-- TOC entry 3720 (class 2606 OID 18865)
-- Dependencies: 2249 2249
-- Name: pk_dbscorecard_sentencas; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbscorecard_sentencas
    ADD CONSTRAINT pk_dbscorecard_sentencas PRIMARY KEY (codigo);


--
-- TOC entry 3724 (class 2606 OID 18867)
-- Dependencies: 2250 2250
-- Name: pk_dbstatus; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbstatus
    ADD CONSTRAINT pk_dbstatus PRIMARY KEY (id);


--
-- TOC entry 3726 (class 2606 OID 18869)
-- Dependencies: 2253 2253
-- Name: pk_dbtransacoes; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbtransacoes
    ADD CONSTRAINT pk_dbtransacoes PRIMARY KEY (codigo);


--
-- TOC entry 3730 (class 2606 OID 18871)
-- Dependencies: 2255 2255
-- Name: pk_dbtransacoes_contas; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbtransacoes_contas
    ADD CONSTRAINT pk_dbtransacoes_contas PRIMARY KEY (codigo);


--
-- TOC entry 3734 (class 2606 OID 18873)
-- Dependencies: 2257 2257
-- Name: pk_dbtransacoes_contas_duplicatas; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbtransacoes_contas_duplicatas
    ADD CONSTRAINT pk_dbtransacoes_contas_duplicatas PRIMARY KEY (codigo);


--
-- TOC entry 3738 (class 2606 OID 18875)
-- Dependencies: 2259 2259
-- Name: pk_dbtransacoes_contas_extornos; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbtransacoes_contas_extornos
    ADD CONSTRAINT pk_dbtransacoes_contas_extornos PRIMARY KEY (codigo);


--
-- TOC entry 3829 (class 2606 OID 20287)
-- Dependencies: 2382 2382
-- Name: pk_dbtransacoes_contas_situacao; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbtransacoes_contas_situacao
    ADD CONSTRAINT pk_dbtransacoes_contas_situacao PRIMARY KEY (codigo);


--
-- TOC entry 3742 (class 2606 OID 18877)
-- Dependencies: 2260 2260
-- Name: pk_dbtransacoes_convenios; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbtransacoes_convenios
    ADD CONSTRAINT pk_dbtransacoes_convenios PRIMARY KEY (codigo);


--
-- TOC entry 3746 (class 2606 OID 18879)
-- Dependencies: 2263 2263
-- Name: pk_dbtransacoes_produtos; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbtransacoes_produtos
    ADD CONSTRAINT pk_dbtransacoes_produtos PRIMARY KEY (codigo);


--
-- TOC entry 3750 (class 2606 OID 18881)
-- Dependencies: 2265 2265
-- Name: pk_dbtreinamentos; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbtreinamentos
    ADD CONSTRAINT pk_dbtreinamentos PRIMARY KEY (codigo);


--
-- TOC entry 3754 (class 2606 OID 18883)
-- Dependencies: 2267 2267
-- Name: pk_dbtributos; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbtributos
    ADD CONSTRAINT pk_dbtributos PRIMARY KEY (codigo);


--
-- TOC entry 3758 (class 2606 OID 18885)
-- Dependencies: 2269 2269
-- Name: pk_dbturmas; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbturmas
    ADD CONSTRAINT pk_dbturmas PRIMARY KEY (codigo);


--
-- TOC entry 3762 (class 2606 OID 18887)
-- Dependencies: 2270 2270
-- Name: pk_dbturmas_convenios; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbturmas_convenios
    ADD CONSTRAINT pk_dbturmas_convenios PRIMARY KEY (codigo);


--
-- TOC entry 3766 (class 2606 OID 18889)
-- Dependencies: 2273 2273
-- Name: pk_dbturmas_descontos; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbturmas_descontos
    ADD CONSTRAINT pk_dbturmas_descontos PRIMARY KEY (codigo);


--
-- TOC entry 3770 (class 2606 OID 18891)
-- Dependencies: 2275 2275
-- Name: pk_dbturmas_disciplinas; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbturmas_disciplinas
    ADD CONSTRAINT pk_dbturmas_disciplinas PRIMARY KEY (codigo);


--
-- TOC entry 3774 (class 2606 OID 18893)
-- Dependencies: 2277 2277
-- Name: pk_dbturmas_disciplinas_arquivos; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbturmas_disciplinas_arquivos
    ADD CONSTRAINT pk_dbturmas_disciplinas_arquivos PRIMARY KEY (codigo);


--
-- TOC entry 3778 (class 2606 OID 18895)
-- Dependencies: 2279 2279
-- Name: pk_dbturmas_disciplinas_aulas; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbturmas_disciplinas_aulas
    ADD CONSTRAINT pk_dbturmas_disciplinas_aulas PRIMARY KEY (codigo);


--
-- TOC entry 3782 (class 2606 OID 18897)
-- Dependencies: 2280 2280
-- Name: pk_dbturmas_disciplinas_avaliacao_detalhamento; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbturmas_disciplinas_avaliacao_detalhamento
    ADD CONSTRAINT pk_dbturmas_disciplinas_avaliacao_detalhamento PRIMARY KEY (codigo);


--
-- TOC entry 3786 (class 2606 OID 18899)
-- Dependencies: 2283 2283
-- Name: pk_dbturmas_disciplinas_avaliacoes; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbturmas_disciplinas_avaliacoes
    ADD CONSTRAINT pk_dbturmas_disciplinas_avaliacoes PRIMARY KEY (codigo);


--
-- TOC entry 3790 (class 2606 OID 18901)
-- Dependencies: 2285 2285
-- Name: pk_dbturmas_disciplinas_materiais; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbturmas_disciplinas_materiais
    ADD CONSTRAINT pk_dbturmas_disciplinas_materiais PRIMARY KEY (codigo);


--
-- TOC entry 3794 (class 2606 OID 18903)
-- Dependencies: 2287 2287
-- Name: pk_dbturmas_disciplinas_planoaulas; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbturmas_disciplinas_planoaulas
    ADD CONSTRAINT pk_dbturmas_disciplinas_planoaulas PRIMARY KEY (codigo);


--
-- TOC entry 3798 (class 2606 OID 18905)
-- Dependencies: 2289 2289
-- Name: pk_dbturmas_requisitos; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbturmas_requisitos
    ADD CONSTRAINT pk_dbturmas_requisitos PRIMARY KEY (codigo);


--
-- TOC entry 3802 (class 2606 OID 18907)
-- Dependencies: 2291 2291
-- Name: pk_dbunidades; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbunidades
    ADD CONSTRAINT pk_dbunidades PRIMARY KEY (codigo);


--
-- TOC entry 3806 (class 2606 OID 18909)
-- Dependencies: 2293 2293
-- Name: pk_dbunidades_parametros; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbunidades_parametros
    ADD CONSTRAINT pk_dbunidades_parametros PRIMARY KEY (codigo);


--
-- TOC entry 3812 (class 2606 OID 18911)
-- Dependencies: 2295 2295
-- Name: pk_dbusuarios; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbusuarios
    ADD CONSTRAINT pk_dbusuarios PRIMARY KEY (codigo);


--
-- TOC entry 3816 (class 2606 OID 18913)
-- Dependencies: 2297 2297
-- Name: pk_dbusuarios_erros; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbusuarios_erros
    ADD CONSTRAINT pk_dbusuarios_erros PRIMARY KEY (codigo);


--
-- TOC entry 3820 (class 2606 OID 18915)
-- Dependencies: 2299 2299
-- Name: pk_dbusuarios_historico; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbusuarios_historico
    ADD CONSTRAINT pk_dbusuarios_historico PRIMARY KEY (codigo);


--
-- TOC entry 3825 (class 2606 OID 18917)
-- Dependencies: 2301 2301
-- Name: pk_dbusuarios_privilegios; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbusuarios_privilegios
    ADD CONSTRAINT pk_dbusuarios_privilegios PRIMARY KEY (codigo);


--
-- TOC entry 3410 (class 2606 OID 18919)
-- Dependencies: 2090 2090
-- Name: pk_id_dbalunos_disciplinas; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbalunos_disciplinas
    ADD CONSTRAINT pk_id_dbalunos_disciplinas UNIQUE (id);


--
-- TOC entry 3414 (class 2606 OID 18921)
-- Dependencies: 2092 2092
-- Name: pk_id_dbalunos_disciplinas_aproveitamentos; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbalunos_disciplinas_aproveitamentos
    ADD CONSTRAINT pk_id_dbalunos_disciplinas_aproveitamentos UNIQUE (id);


--
-- TOC entry 3418 (class 2606 OID 18923)
-- Dependencies: 2094 2094
-- Name: pk_id_dbalunos_faltas; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbalunos_faltas
    ADD CONSTRAINT pk_id_dbalunos_faltas UNIQUE (id);


--
-- TOC entry 3422 (class 2606 OID 18925)
-- Dependencies: 2096 2096
-- Name: pk_id_dbalunos_notas; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbalunos_notas
    ADD CONSTRAINT pk_id_dbalunos_notas UNIQUE (id);


--
-- TOC entry 3426 (class 2606 OID 18927)
-- Dependencies: 2098 2098
-- Name: pk_id_dbalunos_requisitos; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbalunos_requisitos
    ADD CONSTRAINT pk_id_dbalunos_requisitos UNIQUE (id);


--
-- TOC entry 3430 (class 2606 OID 18929)
-- Dependencies: 2100 2100
-- Name: pk_id_dbalunos_solicitacoes; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbalunos_solicitacoes
    ADD CONSTRAINT pk_id_dbalunos_solicitacoes UNIQUE (id);


--
-- TOC entry 3434 (class 2606 OID 18931)
-- Dependencies: 2102 2102
-- Name: pk_id_dbalunos_transacoes; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbalunos_transacoes
    ADD CONSTRAINT pk_id_dbalunos_transacoes UNIQUE (id);


--
-- TOC entry 3438 (class 2606 OID 18933)
-- Dependencies: 2103 2103
-- Name: pk_id_dbavaliacoes; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbavaliacoes
    ADD CONSTRAINT pk_id_dbavaliacoes UNIQUE (id);


--
-- TOC entry 3442 (class 2606 OID 18935)
-- Dependencies: 2105 2105
-- Name: pk_id_dbavaliacoes_regras; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbavaliacoes_regras
    ADD CONSTRAINT pk_id_dbavaliacoes_regras UNIQUE (id);


--
-- TOC entry 3446 (class 2606 OID 18937)
-- Dependencies: 2108 2108
-- Name: pk_id_dbbalanco_patrimonial; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbbalanco_patrimonial
    ADD CONSTRAINT pk_id_dbbalanco_patrimonial UNIQUE (id);


--
-- TOC entry 3450 (class 2606 OID 18939)
-- Dependencies: 2110 2110
-- Name: pk_id_dbbiblioteca_cdu; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbbiblioteca_cdu
    ADD CONSTRAINT pk_id_dbbiblioteca_cdu UNIQUE (id);


--
-- TOC entry 3456 (class 2606 OID 18941)
-- Dependencies: 2112 2112
-- Name: pk_id_dbcaixa; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbcaixa
    ADD CONSTRAINT pk_id_dbcaixa UNIQUE (id);


--
-- TOC entry 3460 (class 2606 OID 18943)
-- Dependencies: 2114 2114
-- Name: pk_id_dbcaixa_fechamentos; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbcaixa_fechamentos
    ADD CONSTRAINT pk_id_dbcaixa_fechamentos UNIQUE (id);


--
-- TOC entry 3464 (class 2606 OID 18945)
-- Dependencies: 2116 2116
-- Name: pk_id_dbcaixa_funcionarios; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbcaixa_funcionarios
    ADD CONSTRAINT pk_id_dbcaixa_funcionarios UNIQUE (id);


--
-- TOC entry 3480 (class 2606 OID 18947)
-- Dependencies: 2126 2126
-- Name: pk_id_dbcaixa_historico; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbcontas_caixa_historico
    ADD CONSTRAINT pk_id_dbcaixa_historico UNIQUE (id);


--
-- TOC entry 3468 (class 2606 OID 18949)
-- Dependencies: 2118 2118
-- Name: pk_id_dbcargos; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbcargos
    ADD CONSTRAINT pk_id_dbcargos UNIQUE (id);


--
-- TOC entry 3486 (class 2606 OID 18951)
-- Dependencies: 2128 2128
-- Name: pk_id_dbcheques; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbcontas_cheques
    ADD CONSTRAINT pk_id_dbcheques UNIQUE (id);


--
-- TOC entry 3472 (class 2606 OID 18953)
-- Dependencies: 2122 2122
-- Name: pk_id_dbcompras; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbcompras
    ADD CONSTRAINT pk_id_dbcompras UNIQUE (id);


--
-- TOC entry 3476 (class 2606 OID 18955)
-- Dependencies: 2124 2124
-- Name: pk_id_dbcontas_caixa; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbcontas_caixa
    ADD CONSTRAINT pk_id_dbcontas_caixa UNIQUE (id);


--
-- TOC entry 3740 (class 2606 OID 18957)
-- Dependencies: 2259 2259
-- Name: pk_id_dbcontas_extornos; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbtransacoes_contas_extornos
    ADD CONSTRAINT pk_id_dbcontas_extornos UNIQUE (id);


--
-- TOC entry 3490 (class 2606 OID 18959)
-- Dependencies: 2130 2130
-- Name: pk_id_dbcontratos; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbcontratos
    ADD CONSTRAINT pk_id_dbcontratos UNIQUE (id);


--
-- TOC entry 3497 (class 2606 OID 18961)
-- Dependencies: 2133 2133
-- Name: pk_id_dbconvenios_descontos; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbconvenios_descontos
    ADD CONSTRAINT pk_id_dbconvenios_descontos UNIQUE (id);


--
-- TOC entry 3501 (class 2606 OID 18963)
-- Dependencies: 2136 2136
-- Name: pk_id_dbcotacoes; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbcotacoes
    ADD CONSTRAINT pk_id_dbcotacoes UNIQUE (id);


--
-- TOC entry 3505 (class 2606 OID 18965)
-- Dependencies: 2138 2138
-- Name: pk_id_dbcrm_demandas; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbcrm_demandas
    ADD CONSTRAINT pk_id_dbcrm_demandas UNIQUE (id);


--
-- TOC entry 3509 (class 2606 OID 18967)
-- Dependencies: 2140 2140
-- Name: pk_id_dbcurriculos; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbcurriculos
    ADD CONSTRAINT pk_id_dbcurriculos UNIQUE (id);


--
-- TOC entry 3513 (class 2606 OID 18969)
-- Dependencies: 2142 2142
-- Name: pk_id_dbcursos; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbcursos
    ADD CONSTRAINT pk_id_dbcursos UNIQUE (id);


--
-- TOC entry 3517 (class 2606 OID 18971)
-- Dependencies: 2144 2144
-- Name: pk_id_dbcursos_areas; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbcursos_areas
    ADD CONSTRAINT pk_id_dbcursos_areas UNIQUE (id);


--
-- TOC entry 3521 (class 2606 OID 18973)
-- Dependencies: 2146 2146
-- Name: pk_id_dbcursos_ativos; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbcursos_ativos
    ADD CONSTRAINT pk_id_dbcursos_ativos UNIQUE (id);


--
-- TOC entry 3525 (class 2606 OID 18975)
-- Dependencies: 2148 2148
-- Name: pk_id_dbcursos_avaliacoes; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbcursos_avaliacoes
    ADD CONSTRAINT pk_id_dbcursos_avaliacoes UNIQUE (id);


--
-- TOC entry 3529 (class 2606 OID 18977)
-- Dependencies: 2150 2150
-- Name: pk_id_dbcursos_disciplinas; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbcursos_disciplinas
    ADD CONSTRAINT pk_id_dbcursos_disciplinas UNIQUE (id);


--
-- TOC entry 3533 (class 2606 OID 18979)
-- Dependencies: 2152 2152
-- Name: pk_id_dbcursos_tipos; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbcursos_tipos
    ADD CONSTRAINT pk_id_dbcursos_tipos UNIQUE (id);


--
-- TOC entry 3537 (class 2606 OID 18981)
-- Dependencies: 2154 2154
-- Name: pk_id_dbdados_boleto; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbdados_boleto
    ADD CONSTRAINT pk_id_dbdados_boleto UNIQUE (id);


--
-- TOC entry 3541 (class 2606 OID 18983)
-- Dependencies: 2156 2156
-- Name: pk_id_dbdepartamentos; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbdepartamentos
    ADD CONSTRAINT pk_id_dbdepartamentos UNIQUE (id);


--
-- TOC entry 3545 (class 2606 OID 18985)
-- Dependencies: 2158 2158
-- Name: pk_id_dbdisciplinas; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbdisciplinas
    ADD CONSTRAINT pk_id_dbdisciplinas UNIQUE (id);


--
-- TOC entry 3549 (class 2606 OID 18987)
-- Dependencies: 2160 2160
-- Name: pk_id_dbdisciplinas_semelhantes; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbdisciplinas_semelhantes
    ADD CONSTRAINT pk_id_dbdisciplinas_semelhantes UNIQUE (id);


--
-- TOC entry 3553 (class 2606 OID 18989)
-- Dependencies: 2162 2162
-- Name: pk_id_dbdocumentos; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbdocumentos
    ADD CONSTRAINT pk_id_dbdocumentos UNIQUE (id);


--
-- TOC entry 3557 (class 2606 OID 18991)
-- Dependencies: 2165 2165
-- Name: pk_id_dbfuncionarios_ferias; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbfuncionarios_ferias
    ADD CONSTRAINT pk_id_dbfuncionarios_ferias UNIQUE (id);


--
-- TOC entry 3561 (class 2606 OID 18993)
-- Dependencies: 2167 2167
-- Name: pk_id_dbfuncionarios_folhapagamento; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbfuncionarios_folhapagamento
    ADD CONSTRAINT pk_id_dbfuncionarios_folhapagamento UNIQUE (id);


--
-- TOC entry 3565 (class 2606 OID 18995)
-- Dependencies: 2169 2169
-- Name: pk_id_dbfuncionarios_ocorrencias; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbfuncionarios_ocorrencias
    ADD CONSTRAINT pk_id_dbfuncionarios_ocorrencias UNIQUE (id);


--
-- TOC entry 3571 (class 2606 OID 18997)
-- Dependencies: 2171 2171
-- Name: pk_id_dbfuncionarios_professores; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbfuncionarios_professores
    ADD CONSTRAINT pk_id_dbfuncionarios_professores UNIQUE (id);


--
-- TOC entry 3575 (class 2606 OID 18999)
-- Dependencies: 2173 2173
-- Name: pk_id_dbfuncionarios_treinamentos; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbfuncionarios_treinamentos
    ADD CONSTRAINT pk_id_dbfuncionarios_treinamentos UNIQUE (id);


--
-- TOC entry 3579 (class 2606 OID 19001)
-- Dependencies: 2174 2174
-- Name: pk_id_dbgrade_avaliacoes; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbgrade_avaliacoes
    ADD CONSTRAINT pk_id_dbgrade_avaliacoes UNIQUE (id);


--
-- TOC entry 3587 (class 2606 OID 19003)
-- Dependencies: 2180 2180
-- Name: pk_id_dbpatrimonios_livros; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbpatrimonios_livros
    ADD CONSTRAINT pk_id_dbpatrimonios_livros UNIQUE (id);


--
-- TOC entry 3591 (class 2606 OID 19005)
-- Dependencies: 2182 2182
-- Name: pk_id_dbpessoas; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbpessoas
    ADD CONSTRAINT pk_id_dbpessoas UNIQUE (id);


--
-- TOC entry 3595 (class 2606 OID 19007)
-- Dependencies: 2184 2184
-- Name: pk_id_dbpessoas_alunos; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbpessoas_alunos
    ADD CONSTRAINT pk_id_dbpessoas_alunos UNIQUE (id);


--
-- TOC entry 3603 (class 2606 OID 19009)
-- Dependencies: 2188 2188
-- Name: pk_id_dbpessoas_complemento_pj; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbpessoas_complemento_pj
    ADD CONSTRAINT pk_id_dbpessoas_complemento_pj UNIQUE (id);


--
-- TOC entry 3608 (class 2606 OID 19011)
-- Dependencies: 2190 2190
-- Name: pk_id_dbpessoas_convenios; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbpessoas_convenios
    ADD CONSTRAINT pk_id_dbpessoas_convenios UNIQUE (id);


--
-- TOC entry 3612 (class 2606 OID 19013)
-- Dependencies: 2192 2192
-- Name: pk_id_dbpessoas_demandas; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbpessoas_demandas
    ADD CONSTRAINT pk_id_dbpessoas_demandas UNIQUE (id);


--
-- TOC entry 3620 (class 2606 OID 19015)
-- Dependencies: 2196 2196
-- Name: pk_id_dbpessoas_formacoes; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbpessoas_formacoes
    ADD CONSTRAINT pk_id_dbpessoas_formacoes UNIQUE (id);


--
-- TOC entry 3624 (class 2606 OID 19017)
-- Dependencies: 2198 2198
-- Name: pk_id_dbpessoas_funcionarios; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbpessoas_funcionarios
    ADD CONSTRAINT pk_id_dbpessoas_funcionarios UNIQUE (id);


--
-- TOC entry 3628 (class 2606 OID 19019)
-- Dependencies: 2200 2200
-- Name: pk_id_dbpessoas_inscricoes; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbpessoas_inscricoes
    ADD CONSTRAINT pk_id_dbpessoas_inscricoes UNIQUE (id);


--
-- TOC entry 3632 (class 2606 OID 19021)
-- Dependencies: 2202 2202
-- Name: pk_id_dbpessoas_livros; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbpessoas_livros
    ADD CONSTRAINT pk_id_dbpessoas_livros UNIQUE (id);


--
-- TOC entry 3636 (class 2606 OID 19023)
-- Dependencies: 2204 2204
-- Name: pk_id_dbpessoas_solicitacoes; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbpessoas_solicitacoes
    ADD CONSTRAINT pk_id_dbpessoas_solicitacoes UNIQUE (id);


--
-- TOC entry 3640 (class 2606 OID 19025)
-- Dependencies: 2206 2206
-- Name: pk_id_dbpessoas_titularidades; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbpessoas_titularidades
    ADD CONSTRAINT pk_id_dbpessoas_titularidades UNIQUE (id);


--
-- TOC entry 3599 (class 2606 OID 19027)
-- Dependencies: 2186 2186
-- Name: pk_id_dbpessos_complemento_pf; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbpessoas_complemento_pf
    ADD CONSTRAINT pk_id_dbpessos_complemento_pf UNIQUE (id);


--
-- TOC entry 3616 (class 2606 OID 19029)
-- Dependencies: 2194 2194
-- Name: pk_id_dbpesssoas_enderecoscobrancas; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbpessoas_enderecoscobrancas
    ADD CONSTRAINT pk_id_dbpesssoas_enderecoscobrancas UNIQUE (id);


--
-- TOC entry 3644 (class 2606 OID 19031)
-- Dependencies: 2208 2208
-- Name: pk_id_dbplano_contas; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbplano_contas
    ADD CONSTRAINT pk_id_dbplano_contas UNIQUE (id);


--
-- TOC entry 3648 (class 2606 OID 19033)
-- Dependencies: 2210 2210
-- Name: pk_id_dbprocessos_academicos; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbprocessos_academicos
    ADD CONSTRAINT pk_id_dbprocessos_academicos UNIQUE (id);


--
-- TOC entry 3653 (class 2606 OID 19035)
-- Dependencies: 2212 2212
-- Name: pk_id_dbprodutos; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbprodutos
    ADD CONSTRAINT pk_id_dbprodutos UNIQUE (id);


--
-- TOC entry 3657 (class 2606 OID 19037)
-- Dependencies: 2214 2214
-- Name: pk_id_dbprodutos_insumos; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbprodutos_caracteristicas
    ADD CONSTRAINT pk_id_dbprodutos_insumos UNIQUE (id);


--
-- TOC entry 3662 (class 2606 OID 19039)
-- Dependencies: 2219 2219
-- Name: pk_id_dbprodutos_parametros; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbprodutos_parametros
    ADD CONSTRAINT pk_id_dbprodutos_parametros UNIQUE (id);


--
-- TOC entry 3583 (class 2606 OID 19041)
-- Dependencies: 2178 2178
-- Name: pk_id_dbprodutos_patrimonios; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbpatrimonios
    ADD CONSTRAINT pk_id_dbprodutos_patrimonios UNIQUE (id);


--
-- TOC entry 3666 (class 2606 OID 19043)
-- Dependencies: 2221 2221
-- Name: pk_id_dbprodutos_tabelapreco; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbprodutos_tabelapreco
    ADD CONSTRAINT pk_id_dbprodutos_tabelapreco UNIQUE (id);


--
-- TOC entry 3670 (class 2606 OID 19045)
-- Dependencies: 2223 2223
-- Name: pk_id_dbprodutos_tipos; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbprodutos_tipos
    ADD CONSTRAINT pk_id_dbprodutos_tipos UNIQUE (id);


--
-- TOC entry 3674 (class 2606 OID 19047)
-- Dependencies: 2225 2225
-- Name: pk_id_dbprodutos_tributos; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbprodutos_tributos
    ADD CONSTRAINT pk_id_dbprodutos_tributos UNIQUE (id);


--
-- TOC entry 3678 (class 2606 OID 19049)
-- Dependencies: 2227 2227
-- Name: pk_id_dbprofessores_areas; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbprofessores_areas
    ADD CONSTRAINT pk_id_dbprofessores_areas UNIQUE (id);


--
-- TOC entry 3682 (class 2606 OID 19051)
-- Dependencies: 2229 2229
-- Name: pk_id_dbprojetos; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbprojetos
    ADD CONSTRAINT pk_id_dbprojetos UNIQUE (id);


--
-- TOC entry 3686 (class 2606 OID 19053)
-- Dependencies: 2231 2231
-- Name: pk_id_dbprojetos_colaboradores; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbprojetos_colaboradores
    ADD CONSTRAINT pk_id_dbprojetos_colaboradores UNIQUE (id);


--
-- TOC entry 3690 (class 2606 OID 19055)
-- Dependencies: 2233 2233
-- Name: pk_id_dbprojetos_custos; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbprojetos_custos
    ADD CONSTRAINT pk_id_dbprojetos_custos UNIQUE (id);


--
-- TOC entry 3694 (class 2606 OID 19057)
-- Dependencies: 2235 2235
-- Name: pk_id_dbprojetos_recursos; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbprojetos_recursos
    ADD CONSTRAINT pk_id_dbprojetos_recursos UNIQUE (id);


--
-- TOC entry 3698 (class 2606 OID 19059)
-- Dependencies: 2237 2237
-- Name: pk_id_dbquestionarios; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbquestionarios
    ADD CONSTRAINT pk_id_dbquestionarios UNIQUE (id);


--
-- TOC entry 3702 (class 2606 OID 19061)
-- Dependencies: 2239 2239
-- Name: pk_id_dbquestoes; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbquestoes
    ADD CONSTRAINT pk_id_dbquestoes UNIQUE (id);


--
-- TOC entry 3706 (class 2606 OID 19063)
-- Dependencies: 2241 2241
-- Name: pk_id_dbquestoes_itens; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbquestoes_itens
    ADD CONSTRAINT pk_id_dbquestoes_itens UNIQUE (id);


--
-- TOC entry 3710 (class 2606 OID 19065)
-- Dependencies: 2243 2243
-- Name: pk_id_dbrecados; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbrecados
    ADD CONSTRAINT pk_id_dbrecados UNIQUE (id);


--
-- TOC entry 3714 (class 2606 OID 19067)
-- Dependencies: 2245 2245
-- Name: pk_id_dbsalas; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbsalas
    ADD CONSTRAINT pk_id_dbsalas UNIQUE (id);


--
-- TOC entry 3718 (class 2606 OID 19069)
-- Dependencies: 2247 2247
-- Name: pk_id_dbscorecard; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbscorecard
    ADD CONSTRAINT pk_id_dbscorecard UNIQUE (id);


--
-- TOC entry 3722 (class 2606 OID 19071)
-- Dependencies: 2249 2249
-- Name: pk_id_dbscorecard_sentecas; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbscorecard_sentencas
    ADD CONSTRAINT pk_id_dbscorecard_sentecas UNIQUE (id);


--
-- TOC entry 3728 (class 2606 OID 19073)
-- Dependencies: 2253 2253
-- Name: pk_id_dbtransacoes; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbtransacoes
    ADD CONSTRAINT pk_id_dbtransacoes UNIQUE (id);


--
-- TOC entry 3732 (class 2606 OID 19075)
-- Dependencies: 2255 2255
-- Name: pk_id_dbtransacoes_contas; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbtransacoes_contas
    ADD CONSTRAINT pk_id_dbtransacoes_contas UNIQUE (id);


--
-- TOC entry 3736 (class 2606 OID 19077)
-- Dependencies: 2257 2257
-- Name: pk_id_dbtransacoes_contas_duplicatas; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbtransacoes_contas_duplicatas
    ADD CONSTRAINT pk_id_dbtransacoes_contas_duplicatas UNIQUE (id);


--
-- TOC entry 3831 (class 2606 OID 20289)
-- Dependencies: 2382 2382
-- Name: pk_id_dbtransacoes_contas_situacao; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbtransacoes_contas_situacao
    ADD CONSTRAINT pk_id_dbtransacoes_contas_situacao UNIQUE (id);


--
-- TOC entry 3744 (class 2606 OID 19079)
-- Dependencies: 2260 2260
-- Name: pk_id_dbtransacoes_convenios; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbtransacoes_convenios
    ADD CONSTRAINT pk_id_dbtransacoes_convenios UNIQUE (id);


--
-- TOC entry 3748 (class 2606 OID 19081)
-- Dependencies: 2263 2263
-- Name: pk_id_dbtransacoes_produtos; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbtransacoes_produtos
    ADD CONSTRAINT pk_id_dbtransacoes_produtos UNIQUE (id);


--
-- TOC entry 3752 (class 2606 OID 19083)
-- Dependencies: 2265 2265
-- Name: pk_id_dbtreinamentos; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbtreinamentos
    ADD CONSTRAINT pk_id_dbtreinamentos UNIQUE (id);


--
-- TOC entry 3756 (class 2606 OID 19085)
-- Dependencies: 2267 2267
-- Name: pk_id_dbtributos; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbtributos
    ADD CONSTRAINT pk_id_dbtributos UNIQUE (id);


--
-- TOC entry 3760 (class 2606 OID 19087)
-- Dependencies: 2269 2269
-- Name: pk_id_dbturmas; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbturmas
    ADD CONSTRAINT pk_id_dbturmas UNIQUE (id);


--
-- TOC entry 3764 (class 2606 OID 19089)
-- Dependencies: 2270 2270
-- Name: pk_id_dbturmas_convenios; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbturmas_convenios
    ADD CONSTRAINT pk_id_dbturmas_convenios UNIQUE (id);


--
-- TOC entry 3768 (class 2606 OID 19091)
-- Dependencies: 2273 2273
-- Name: pk_id_dbturmas_descontos; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbturmas_descontos
    ADD CONSTRAINT pk_id_dbturmas_descontos UNIQUE (id);


--
-- TOC entry 3772 (class 2606 OID 19093)
-- Dependencies: 2275 2275
-- Name: pk_id_dbturmas_disciplinas; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbturmas_disciplinas
    ADD CONSTRAINT pk_id_dbturmas_disciplinas UNIQUE (id);


--
-- TOC entry 3776 (class 2606 OID 19095)
-- Dependencies: 2277 2277
-- Name: pk_id_dbturmas_disciplinas_arquivos; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbturmas_disciplinas_arquivos
    ADD CONSTRAINT pk_id_dbturmas_disciplinas_arquivos UNIQUE (id);


--
-- TOC entry 3780 (class 2606 OID 19097)
-- Dependencies: 2279 2279
-- Name: pk_id_dbturmas_disciplinas_aulas; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbturmas_disciplinas_aulas
    ADD CONSTRAINT pk_id_dbturmas_disciplinas_aulas UNIQUE (id);


--
-- TOC entry 3784 (class 2606 OID 19099)
-- Dependencies: 2280 2280
-- Name: pk_id_dbturmas_disciplinas_avaliacao_detalhamento; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbturmas_disciplinas_avaliacao_detalhamento
    ADD CONSTRAINT pk_id_dbturmas_disciplinas_avaliacao_detalhamento UNIQUE (id);


--
-- TOC entry 3788 (class 2606 OID 19101)
-- Dependencies: 2283 2283
-- Name: pk_id_dbturmas_disciplinas_avaliacoes; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbturmas_disciplinas_avaliacoes
    ADD CONSTRAINT pk_id_dbturmas_disciplinas_avaliacoes UNIQUE (id);


--
-- TOC entry 3792 (class 2606 OID 19103)
-- Dependencies: 2285 2285
-- Name: pk_id_dbturmas_disciplinas_materiais; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbturmas_disciplinas_materiais
    ADD CONSTRAINT pk_id_dbturmas_disciplinas_materiais UNIQUE (id);


--
-- TOC entry 3796 (class 2606 OID 19105)
-- Dependencies: 2287 2287
-- Name: pk_id_dbturmas_disciplinas_planoaulas; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbturmas_disciplinas_planoaulas
    ADD CONSTRAINT pk_id_dbturmas_disciplinas_planoaulas UNIQUE (id);


--
-- TOC entry 3800 (class 2606 OID 19107)
-- Dependencies: 2289 2289
-- Name: pk_id_dbturmas_requisitos; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbturmas_requisitos
    ADD CONSTRAINT pk_id_dbturmas_requisitos UNIQUE (id);


--
-- TOC entry 3804 (class 2606 OID 19109)
-- Dependencies: 2291 2291
-- Name: pk_id_dbunidades; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbunidades
    ADD CONSTRAINT pk_id_dbunidades UNIQUE (id);


--
-- TOC entry 3808 (class 2606 OID 19111)
-- Dependencies: 2293 2293
-- Name: pk_id_dbunidades_parametros; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbunidades_parametros
    ADD CONSTRAINT pk_id_dbunidades_parametros UNIQUE (id);


--
-- TOC entry 3814 (class 2606 OID 19113)
-- Dependencies: 2295 2295
-- Name: pk_id_dbusuarios; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbusuarios
    ADD CONSTRAINT pk_id_dbusuarios UNIQUE (id);


--
-- TOC entry 3818 (class 2606 OID 19115)
-- Dependencies: 2297 2297
-- Name: pk_id_dbusuarios_erros; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbusuarios_erros
    ADD CONSTRAINT pk_id_dbusuarios_erros UNIQUE (id);


--
-- TOC entry 3822 (class 2606 OID 19117)
-- Dependencies: 2299 2299
-- Name: pk_id_dbusuarios_historico; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbusuarios_historico
    ADD CONSTRAINT pk_id_dbusuarios_historico UNIQUE (id);


--
-- TOC entry 3827 (class 2606 OID 19119)
-- Dependencies: 2301 2301
-- Name: pk_id_dbusuarios_privilegios; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dbusuarios_privilegios
    ADD CONSTRAINT pk_id_dbusuarios_privilegios UNIQUE (id);


--
-- TOC entry 3481 (class 1259 OID 19120)
-- Dependencies: 2128
-- Name: fki__dbtransacoes_contas__dbcontas_cheques; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX fki__dbtransacoes_contas__dbcontas_cheques ON dbcontas_cheques USING btree (codigoconta);


--
-- TOC entry 3482 (class 1259 OID 19121)
-- Dependencies: 2128
-- Name: fki_dbcaixa__dbpessoas_cheques__codigocaixa; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX fki_dbcaixa__dbpessoas_cheques__codigocaixa ON dbcontas_cheques USING btree (codigocaixa);


--
-- TOC entry 3451 (class 1259 OID 19122)
-- Dependencies: 2112
-- Name: fki_dbcaixa_funcionarios__dbcaixa__codigocaixafuncionario; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX fki_dbcaixa_funcionarios__dbcaixa__codigocaixafuncionario ON dbcaixa USING btree (codigofuncionario);


--
-- TOC entry 3452 (class 1259 OID 19123)
-- Dependencies: 2112
-- Name: fki_dbcontas_caixa_historico__dbcaixa__codigohistorico; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX fki_dbcontas_caixa_historico__dbcaixa__codigohistorico ON dbcaixa USING btree (codigohistorico);


--
-- TOC entry 3604 (class 1259 OID 19124)
-- Dependencies: 2190
-- Name: fki_dbcontratos__dbpessoas_convenios__codigoconvenio; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX fki_dbcontratos__dbpessoas_convenios__codigoconvenio ON dbpessoas_convenios USING btree (codigoconvenio);


--
-- TOC entry 3491 (class 1259 OID 19125)
-- Dependencies: 2132
-- Name: fki_dbplano_contas_dbconvenios_codigoplanoconta; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX fki_dbplano_contas_dbconvenios_codigoplanoconta ON dbconvenios USING btree (codigoplanoconta);


--
-- TOC entry 3658 (class 1259 OID 19126)
-- Dependencies: 2219
-- Name: fki_dbprodutos_tipos__dbprodutos__codigotipoproduto; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX fki_dbprodutos_tipos__dbprodutos__codigotipoproduto ON dbprodutos_parametros USING btree (codigotipoproduto);


--
-- TOC entry 3649 (class 1259 OID 19127)
-- Dependencies: 2212
-- Name: fki_dbprodutos_tipos__dbprodutos_codigotipoproduto; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX fki_dbprodutos_tipos__dbprodutos_codigotipoproduto ON dbprodutos USING btree (codigotipoproduto);


--
-- TOC entry 3823 (class 1259 OID 19128)
-- Dependencies: 2301 2301
-- Name: idx_usuarios_privilegios; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX idx_usuarios_privilegios ON dbusuarios_privilegios USING btree (codigousuario, funcionalidade);


--
-- TOC entry 3875 (class 2606 OID 19129)
-- Dependencies: 3729 2255 2128
-- Name: fk__dbtransacoes_contas__dbcontas_cheques; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcontas_cheques
    ADD CONSTRAINT fk__dbtransacoes_contas__dbcontas_cheques FOREIGN KEY (codigoconta) REFERENCES dbtransacoes_contas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3832 (class 2606 OID 19134)
-- Dependencies: 3592 2184 2090
-- Name: fk_dbalunos__dbalunos_disciplinas__codigoaluno; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_disciplinas
    ADD CONSTRAINT fk_dbalunos__dbalunos_disciplinas__codigoaluno FOREIGN KEY (codigoaluno) REFERENCES dbpessoas_alunos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3838 (class 2606 OID 19139)
-- Dependencies: 3592 2184 2094
-- Name: fk_dbalunos__dbalunos_faltas__codigoaluno; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_faltas
    ADD CONSTRAINT fk_dbalunos__dbalunos_faltas__codigoaluno FOREIGN KEY (codigoaluno) REFERENCES dbpessoas_alunos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3842 (class 2606 OID 19144)
-- Dependencies: 3592 2184 2096
-- Name: fk_dbalunos__dbalunos_notas__codigoaluno; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_notas
    ADD CONSTRAINT fk_dbalunos__dbalunos_notas__codigoaluno FOREIGN KEY (codigoaluno) REFERENCES dbpessoas_alunos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3836 (class 2606 OID 19149)
-- Dependencies: 3407 2090 2092
-- Name: fk_dbalunos_disciplinas__dbalunos_disciplinas_aproveitamentos__; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_disciplinas_aproveitamentos
    ADD CONSTRAINT fk_dbalunos_disciplinas__dbalunos_disciplinas_aproveitamentos__ FOREIGN KEY (codigoalunodisciplina) REFERENCES dbalunos_disciplinas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3855 (class 2606 OID 19154)
-- Dependencies: 3576 2174 2103
-- Name: fk_dbavalia_fk_dbgrad_dbgrade_; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbavaliacoes
    ADD CONSTRAINT fk_dbavalia_fk_dbgrad_dbgrade_ FOREIGN KEY (codigograde) REFERENCES dbgrade_avaliacoes(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3923 (class 2606 OID 19159)
-- Dependencies: 3447 2110 2180
-- Name: fk_dbbiblioteca_cdu__dbpatrimonios_livros__codigocdu; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpatrimonios_livros
    ADD CONSTRAINT fk_dbbiblioteca_cdu__dbpatrimonios_livros__codigocdu FOREIGN KEY (codigocdu) REFERENCES dbbiblioteca_cdu(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3876 (class 2606 OID 19164)
-- Dependencies: 3453 2112 2128
-- Name: fk_dbcaixa__dbpessoas_cheques__codigocaixa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcontas_cheques
    ADD CONSTRAINT fk_dbcaixa__dbpessoas_cheques__codigocaixa FOREIGN KEY (codigocaixa) REFERENCES dbcaixa(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3947 (class 2606 OID 19169)
-- Dependencies: 3465 2118 2198
-- Name: fk_dbcargos__dbpessoas_funcionarios__codigocargo; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_funcionarios
    ADD CONSTRAINT fk_dbcargos__dbpessoas_funcionarios__codigocargo FOREIGN KEY (codigocargo) REFERENCES dbcargos(codigo);


--
-- TOC entry 3858 (class 2606 OID 19174)
-- Dependencies: 3473 2124 2112
-- Name: fk_dbcontas_caixa__dbcaixa__codigocontacaixa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcaixa
    ADD CONSTRAINT fk_dbcontas_caixa__dbcaixa__codigocontacaixa FOREIGN KEY (codigocontacaixa) REFERENCES dbcontas_caixa(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3866 (class 2606 OID 19179)
-- Dependencies: 3473 2124 2116
-- Name: fk_dbcontas_caixa__dbcaixa__codigocontacaixa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcaixa_funcionarios
    ADD CONSTRAINT fk_dbcontas_caixa__dbcaixa__codigocontacaixa FOREIGN KEY (codigocontacaixa) REFERENCES dbcontas_caixa(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3873 (class 2606 OID 19184)
-- Dependencies: 3473 2124 2126
-- Name: fk_dbcontas_caixa__dbcontas_caixa_historico__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcontas_caixa_historico
    ADD CONSTRAINT fk_dbcontas_caixa__dbcontas_caixa_historico__unidade FOREIGN KEY (codigocontacaixa) REFERENCES dbcontas_caixa(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3859 (class 2606 OID 19189)
-- Dependencies: 3477 2126 2112
-- Name: fk_dbcontas_caixa_historico__dbcaixa__codigohistorico; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcaixa
    ADD CONSTRAINT fk_dbcontas_caixa_historico__dbcaixa__codigohistorico FOREIGN KEY (codigohistorico) REFERENCES dbcontas_caixa_historico(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3936 (class 2606 OID 19194)
-- Dependencies: 3492 2132 2190
-- Name: fk_dbcontratos__dbpessoas_convenios__codigoconvenio; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_convenios
    ADD CONSTRAINT fk_dbcontratos__dbpessoas_convenios__codigoconvenio FOREIGN KEY (codigoconvenio) REFERENCES dbconvenios(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3881 (class 2606 OID 19199)
-- Dependencies: 3492 2132 2133
-- Name: fk_dbconvenios__dbconvenios_descontos__codigoconvenio; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbconvenios_descontos
    ADD CONSTRAINT fk_dbconvenios__dbconvenios_descontos__codigoconvenio FOREIGN KEY (codigoconvenio) REFERENCES dbconvenios(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4011 (class 2606 OID 19204)
-- Dependencies: 3492 2132 2260
-- Name: fk_dbconvenios__dbtransacoes_convenios__codigoconvenio; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes_convenios
    ADD CONSTRAINT fk_dbconvenios__dbtransacoes_convenios__codigoconvenio FOREIGN KEY (codigoconvenio) REFERENCES dbconvenios(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4023 (class 2606 OID 19209)
-- Dependencies: 3492 2132 2270
-- Name: fk_dbconvenios__dbturmas_convenios__codigoconvenio; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_convenios
    ADD CONSTRAINT fk_dbconvenios__dbturmas_convenios__codigoconvenio FOREIGN KEY (codigoconvenio) REFERENCES dbconvenios(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3893 (class 2606 OID 19214)
-- Dependencies: 3510 2142 2146
-- Name: fk_dbcursos__dbcursos_ativos__codigocurso; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcursos_ativos
    ADD CONSTRAINT fk_dbcursos__dbcursos_ativos__codigocurso FOREIGN KEY (codigocurso) REFERENCES dbcursos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3895 (class 2606 OID 19219)
-- Dependencies: 3510 2142 2148
-- Name: fk_dbcursos__dbcursos_avaliacoes__codigocurso; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcursos_avaliacoes
    ADD CONSTRAINT fk_dbcursos__dbcursos_avaliacoes__codigocurso FOREIGN KEY (codigocurso) REFERENCES dbcursos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3897 (class 2606 OID 19224)
-- Dependencies: 3510 2142 2150
-- Name: fk_dbcursos__dbcursos_disciplinas__codigocurso; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcursos_disciplinas
    ADD CONSTRAINT fk_dbcursos__dbcursos_disciplinas__codigocurso FOREIGN KEY (codigocurso) REFERENCES dbcursos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3905 (class 2606 OID 19229)
-- Dependencies: 3542 2158 2160
-- Name: fk_dbcursos__dbdisciplinas_semelhantes__codigodisciplinasemelha; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbdisciplinas_semelhantes
    ADD CONSTRAINT fk_dbcursos__dbdisciplinas_semelhantes__codigodisciplinasemelha FOREIGN KEY (codigodisciplina) REFERENCES dbdisciplinas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3927 (class 2606 OID 19234)
-- Dependencies: 3510 2142 2184
-- Name: fk_dbcursos__dbpessoas_alunos__codigocurso; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_alunos
    ADD CONSTRAINT fk_dbcursos__dbpessoas_alunos__codigocurso FOREIGN KEY (codigocurso) REFERENCES dbcursos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3939 (class 2606 OID 19239)
-- Dependencies: 3510 2142 2192
-- Name: fk_dbcursos__dbpessoas_demandas__codigocurso; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_demandas
    ADD CONSTRAINT fk_dbcursos__dbpessoas_demandas__codigocurso FOREIGN KEY (codigocurso) REFERENCES dbcursos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3951 (class 2606 OID 19244)
-- Dependencies: 3510 2142 2200
-- Name: fk_dbcursos__dbpessoas_inscricoes__codigocurso; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_inscricoes
    ADD CONSTRAINT fk_dbcursos__dbpessoas_inscricoes__codigocurso FOREIGN KEY (codigocurso) REFERENCES dbcursos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4019 (class 2606 OID 19249)
-- Dependencies: 3510 2142 2269
-- Name: fk_dbcursos__dbturmas__codigocurso; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas
    ADD CONSTRAINT fk_dbcursos__dbturmas__codigocurso FOREIGN KEY (codigocurso) REFERENCES dbcursos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3888 (class 2606 OID 19254)
-- Dependencies: 3514 2144 2142
-- Name: fk_dbcursos_areas__dbcursos__codigoareacurso; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcursos
    ADD CONSTRAINT fk_dbcursos_areas__dbcursos__codigoareacurso FOREIGN KEY (codigoareacurso) REFERENCES dbcursos_areas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3978 (class 2606 OID 19259)
-- Dependencies: 3514 2144 2227
-- Name: fk_dbcursos_areas__dbprofessores_areas__codigoareacurso; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprofessores_areas
    ADD CONSTRAINT fk_dbcursos_areas__dbprofessores_areas__codigoareacurso FOREIGN KEY (codigoareacurso) REFERENCES dbcursos_areas(codigo);


--
-- TOC entry 4020 (class 2606 OID 19264)
-- Dependencies: 3518 2146 2269
-- Name: fk_dbcursos_ativos__dbturmas__codigocursoativo; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas
    ADD CONSTRAINT fk_dbcursos_ativos__dbturmas__codigocursoativo FOREIGN KEY (codigocursoativo) REFERENCES dbcursos_ativos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3889 (class 2606 OID 19269)
-- Dependencies: 3530 2152 2142
-- Name: fk_dbcursos_tipos__dbcursos__codigotipocurso; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcursos
    ADD CONSTRAINT fk_dbcursos_tipos__dbcursos__codigotipocurso FOREIGN KEY (codigotipocurso) REFERENCES dbcursos_tipos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3848 (class 2606 OID 19274)
-- Dependencies: 3538 2156 2100
-- Name: fk_dbdepartamentos__dbalunos_solicitacoes__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_solicitacoes
    ADD CONSTRAINT fk_dbdepartamentos__dbalunos_solicitacoes__unidade FOREIGN KEY (codigodepartamento) REFERENCES dbdepartamentos(codigo);


--
-- TOC entry 3948 (class 2606 OID 19279)
-- Dependencies: 3538 2156 2198
-- Name: fk_dbdepartamentos__dbpessoas_funcionarios__codigodepartamento; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_funcionarios
    ADD CONSTRAINT fk_dbdepartamentos__dbpessoas_funcionarios__codigodepartamento FOREIGN KEY (codigodepartamento) REFERENCES dbdepartamentos(codigo);


--
-- TOC entry 3959 (class 2606 OID 19284)
-- Dependencies: 3538 2156 2204
-- Name: fk_dbdepartamentos__dbpessoas_solicitacoes__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_solicitacoes
    ADD CONSTRAINT fk_dbdepartamentos__dbpessoas_solicitacoes__unidade FOREIGN KEY (codigodepartamento) REFERENCES dbdepartamentos(codigo);


--
-- TOC entry 3898 (class 2606 OID 19289)
-- Dependencies: 3542 2158 2150
-- Name: fk_dbdisciplinas__dbcursos_disciplinas__codigodisciplina; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcursos_disciplinas
    ADD CONSTRAINT fk_dbdisciplinas__dbcursos_disciplinas__codigodisciplina FOREIGN KEY (codigodisciplina) REFERENCES dbdisciplinas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3906 (class 2606 OID 19294)
-- Dependencies: 3542 2158 2160
-- Name: fk_dbdisciplinas__dbdisciplinas_semelhantes__codigodisciplina; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbdisciplinas_semelhantes
    ADD CONSTRAINT fk_dbdisciplinas__dbdisciplinas_semelhantes__codigodisciplina FOREIGN KEY (codigodisciplina) REFERENCES dbdisciplinas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4028 (class 2606 OID 19299)
-- Dependencies: 3542 2158 2275
-- Name: fk_dbdisciplinas__dbturmas_disciplinas__codigodisciplina; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas
    ADD CONSTRAINT fk_dbdisciplinas__dbturmas_disciplinas__codigodisciplina FOREIGN KEY (codigodisciplina) REFERENCES dbdisciplinas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3979 (class 2606 OID 19304)
-- Dependencies: 3568 2171 2227
-- Name: fk_dbfuncionarios_professores__dbprofessores_areas__codigoprofe; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprofessores_areas
    ADD CONSTRAINT fk_dbfuncionarios_professores__dbprofessores_areas__codigoprofe FOREIGN KEY (codigoprofessor) REFERENCES dbfuncionarios_professores(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4029 (class 2606 OID 19309)
-- Dependencies: 3568 2171 2275
-- Name: fk_dbfuncionarios_professores__dbturmas_disciplinas__codigoprof; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas
    ADD CONSTRAINT fk_dbfuncionarios_professores__dbturmas_disciplinas__codigoprof FOREIGN KEY (codigoprofessor) REFERENCES dbfuncionarios_professores(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4034 (class 2606 OID 19314)
-- Dependencies: 3568 2171 2277
-- Name: fk_dbfuncionarios_professores__dbturmas_disciplinas_arquivos__c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas_arquivos
    ADD CONSTRAINT fk_dbfuncionarios_professores__dbturmas_disciplinas_arquivos__c FOREIGN KEY (codigoprofessor) REFERENCES dbfuncionarios_professores(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4046 (class 2606 OID 19319)
-- Dependencies: 3568 2171 2287
-- Name: fk_dbfuncionarios_professores__dbturmas_disciplinas_planoaulas_; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas_planoaulas
    ADD CONSTRAINT fk_dbfuncionarios_professores__dbturmas_disciplinas_planoaulas_ FOREIGN KEY (codigoprofessor) REFERENCES dbfuncionarios_professores(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3890 (class 2606 OID 19324)
-- Dependencies: 3576 2174 2142
-- Name: fk_dbgrade_avaliacoes__dbcursos_codigograde; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcursos
    ADD CONSTRAINT fk_dbgrade_avaliacoes__dbcursos_codigograde FOREIGN KEY (codigograde) REFERENCES dbgrade_avaliacoes(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4030 (class 2606 OID 19329)
-- Dependencies: 3576 2174 2275
-- Name: fk_dbgrade_avaliacoes_dbturmas_disciplinas__CODIGOGRADE; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas
    ADD CONSTRAINT "fk_dbgrade_avaliacoes_dbturmas_disciplinas__CODIGOGRADE" FOREIGN KEY (codigograde) REFERENCES dbgrade_avaliacoes(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3924 (class 2606 OID 19334)
-- Dependencies: 3580 2178 2180
-- Name: fk_dbpatrimonios__dbpatrimonios_livros__codigopatrimonio; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpatrimonios_livros
    ADD CONSTRAINT fk_dbpatrimonios__dbpatrimonios_livros__codigopatrimonio FOREIGN KEY (codigopatrimonio) REFERENCES dbpatrimonios(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3956 (class 2606 OID 19339)
-- Dependencies: 3584 2180 2202
-- Name: fk_dbpatrimonios_livros__dbpessoas_livros__codigolivro; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_livros
    ADD CONSTRAINT fk_dbpatrimonios_livros__dbpessoas_livros__codigolivro FOREIGN KEY (codigolivro) REFERENCES dbpatrimonios_livros(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3849 (class 2606 OID 19344)
-- Dependencies: 3592 2184 2100
-- Name: fk_dbpessoas__dbalunos_solicitacoes__codigoaluno; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_solicitacoes
    ADD CONSTRAINT fk_dbpessoas__dbalunos_solicitacoes__codigoaluno FOREIGN KEY (codigoaluno) REFERENCES dbpessoas_alunos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3860 (class 2606 OID 19349)
-- Dependencies: 3588 2182 2112
-- Name: fk_dbpessoas__dbcaixa__codigopessoa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcaixa
    ADD CONSTRAINT fk_dbpessoas__dbcaixa__codigopessoa FOREIGN KEY (codigopessoa) REFERENCES dbpessoas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3878 (class 2606 OID 19354)
-- Dependencies: 3588 2182 2130
-- Name: fk_dbpessoas__dbcontratos__codigopessoa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcontratos
    ADD CONSTRAINT fk_dbpessoas__dbcontratos__codigopessoa FOREIGN KEY (codigopessoa) REFERENCES dbpessoas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3883 (class 2606 OID 19359)
-- Dependencies: 3588 2182 2136
-- Name: fk_dbpessoas__dbcotacoes__codigofornecedor; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcotacoes
    ADD CONSTRAINT fk_dbpessoas__dbcotacoes__codigofornecedor FOREIGN KEY (codigofornecedor) REFERENCES dbpessoas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3928 (class 2606 OID 19364)
-- Dependencies: 3588 2182 2184
-- Name: fk_dbpessoas__dbpessoas_alunos__codigopessoa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_alunos
    ADD CONSTRAINT fk_dbpessoas__dbpessoas_alunos__codigopessoa FOREIGN KEY (codigopessoa) REFERENCES dbpessoas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3932 (class 2606 OID 19369)
-- Dependencies: 3588 2182 2186
-- Name: fk_dbpessoas__dbpessoas_complemento_pf__codigopessoa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_complemento_pf
    ADD CONSTRAINT fk_dbpessoas__dbpessoas_complemento_pf__codigopessoa FOREIGN KEY (codigopessoa) REFERENCES dbpessoas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3934 (class 2606 OID 19374)
-- Dependencies: 3588 2182 2188
-- Name: fk_dbpessoas__dbpessoas_complemento_pj__codigopessoa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_complemento_pj
    ADD CONSTRAINT fk_dbpessoas__dbpessoas_complemento_pj__codigopessoa FOREIGN KEY (codigopessoa) REFERENCES dbpessoas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3937 (class 2606 OID 19379)
-- Dependencies: 3588 2182 2190
-- Name: fk_dbpessoas__dbpessoas_convenios__codigopessoa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_convenios
    ADD CONSTRAINT fk_dbpessoas__dbpessoas_convenios__codigopessoa FOREIGN KEY (codigopessoa) REFERENCES dbpessoas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3940 (class 2606 OID 19384)
-- Dependencies: 3588 2182 2192
-- Name: fk_dbpessoas__dbpessoas_demandas__codigopessoa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_demandas
    ADD CONSTRAINT fk_dbpessoas__dbpessoas_demandas__codigopessoa FOREIGN KEY (codigopessoa) REFERENCES dbpessoas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3942 (class 2606 OID 19389)
-- Dependencies: 3588 2182 2194
-- Name: fk_dbpessoas__dbpessoas_enderecoscobrancas__codigopessoa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_enderecoscobrancas
    ADD CONSTRAINT fk_dbpessoas__dbpessoas_enderecoscobrancas__codigopessoa FOREIGN KEY (codigopessoa) REFERENCES dbpessoas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3944 (class 2606 OID 19394)
-- Dependencies: 3588 2182 2196
-- Name: fk_dbpessoas__dbpessoas_formacoes__codigopessoa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_formacoes
    ADD CONSTRAINT fk_dbpessoas__dbpessoas_formacoes__codigopessoa FOREIGN KEY (codigopessoa) REFERENCES dbpessoas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3945 (class 2606 OID 19399)
-- Dependencies: 3637 2206 2196
-- Name: fk_dbpessoas__dbpessoas_formacoes__codigotitularidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_formacoes
    ADD CONSTRAINT fk_dbpessoas__dbpessoas_formacoes__codigotitularidade FOREIGN KEY (codigotitularidade) REFERENCES dbpessoas_titularidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3949 (class 2606 OID 19404)
-- Dependencies: 3588 2182 2198
-- Name: fk_dbpessoas__dbpessoas_funcionarios__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_funcionarios
    ADD CONSTRAINT fk_dbpessoas__dbpessoas_funcionarios__unidade FOREIGN KEY (codigopessoa) REFERENCES dbpessoas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3952 (class 2606 OID 19409)
-- Dependencies: 3588 2182 2200
-- Name: fk_dbpessoas__dbpessoas_inscricoes__codigopessoa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_inscricoes
    ADD CONSTRAINT fk_dbpessoas__dbpessoas_inscricoes__codigopessoa FOREIGN KEY (codigopessoa) REFERENCES dbpessoas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3957 (class 2606 OID 19414)
-- Dependencies: 3588 2182 2202
-- Name: fk_dbpessoas__dbpessoas_livros__codigopessoa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_livros
    ADD CONSTRAINT fk_dbpessoas__dbpessoas_livros__codigopessoa FOREIGN KEY (codigopessoa) REFERENCES dbpessoas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3960 (class 2606 OID 19419)
-- Dependencies: 3588 2182 2204
-- Name: fk_dbpessoas__dbpessoas_solicitacoes__codigopessoa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_solicitacoes
    ADD CONSTRAINT fk_dbpessoas__dbpessoas_solicitacoes__codigopessoa FOREIGN KEY (codigopessoa) REFERENCES dbpessoas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3982 (class 2606 OID 19424)
-- Dependencies: 3588 2182 2231
-- Name: fk_dbpessoas__dbprojetos_colaboradores__codigopessoa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprojetos_colaboradores
    ADD CONSTRAINT fk_dbpessoas__dbprojetos_colaboradores__codigopessoa FOREIGN KEY (codigopessoa) REFERENCES dbpessoas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3998 (class 2606 OID 19429)
-- Dependencies: 3588 2182 2253
-- Name: fk_dbpessoas__dbtransacoes__codigopessoa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes
    ADD CONSTRAINT fk_dbpessoas__dbtransacoes__codigopessoa FOREIGN KEY (codigopessoa) REFERENCES dbpessoas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4001 (class 2606 OID 19434)
-- Dependencies: 3588 2182 2255
-- Name: fk_dbpessoas__dbtransacoes_contas__codigopessoa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes_contas
    ADD CONSTRAINT fk_dbpessoas__dbtransacoes_contas__codigopessoa FOREIGN KEY (codigopessoa) REFERENCES dbpessoas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4005 (class 2606 OID 19439)
-- Dependencies: 3588 2182 2257
-- Name: fk_dbpessoas__dbtransacoes_contas_duplicatas__codigopessoa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes_contas_duplicatas
    ADD CONSTRAINT fk_dbpessoas__dbtransacoes_contas_duplicatas__codigopessoa FOREIGN KEY (codigopessoa) REFERENCES dbpessoas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4052 (class 2606 OID 19444)
-- Dependencies: 3588 2182 2295
-- Name: fk_dbpessoas__dbusuarios__codigousuario; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbusuarios
    ADD CONSTRAINT fk_dbpessoas__dbusuarios__codigousuario FOREIGN KEY (codigopessoa) REFERENCES dbpessoas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3852 (class 2606 OID 19449)
-- Dependencies: 3592 2184 2102
-- Name: fk_dbpessoas_alunos__dbalunos_transacoes__codigoaluno; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_transacoes
    ADD CONSTRAINT fk_dbpessoas_alunos__dbalunos_transacoes__codigoaluno FOREIGN KEY (codigoaluno) REFERENCES dbpessoas_alunos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3850 (class 2606 OID 19454)
-- Dependencies: 3621 2198 2100
-- Name: fk_dbpessoas_funcionarios__dbalunos_solicitacoes__codigofuncio; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_solicitacoes
    ADD CONSTRAINT fk_dbpessoas_funcionarios__dbalunos_solicitacoes__codigofuncio FOREIGN KEY (codigofuncionario) REFERENCES dbpessoas_funcionarios(codigo);


--
-- TOC entry 3861 (class 2606 OID 19459)
-- Dependencies: 3621 2198 2112
-- Name: fk_dbpessoas_funcionarios__dbcaixa__codigofuncionario; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcaixa
    ADD CONSTRAINT fk_dbpessoas_funcionarios__dbcaixa__codigofuncionario FOREIGN KEY (codigofuncionario) REFERENCES dbpessoas_funcionarios(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3867 (class 2606 OID 19464)
-- Dependencies: 3621 2198 2116
-- Name: fk_dbpessoas_funcionarios__dbcaixa_funcionarios__codigofunciona; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcaixa_funcionarios
    ADD CONSTRAINT fk_dbpessoas_funcionarios__dbcaixa_funcionarios__codigofunciona FOREIGN KEY (codigofuncionario) REFERENCES dbpessoas_funcionarios(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3909 (class 2606 OID 19469)
-- Dependencies: 3621 2198 2165
-- Name: fk_dbpessoas_funcionarios__dbfuncionarios_ferias__codigofuncion; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfuncionarios_ferias
    ADD CONSTRAINT fk_dbpessoas_funcionarios__dbfuncionarios_ferias__codigofuncion FOREIGN KEY (codigofuncionario) REFERENCES dbpessoas_funcionarios(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3911 (class 2606 OID 19474)
-- Dependencies: 3621 2198 2167
-- Name: fk_dbpessoas_funcionarios__dbfuncionarios_folhapagamento__codig; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfuncionarios_folhapagamento
    ADD CONSTRAINT fk_dbpessoas_funcionarios__dbfuncionarios_folhapagamento__codig FOREIGN KEY (codigofuncionario) REFERENCES dbpessoas_funcionarios(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3913 (class 2606 OID 19479)
-- Dependencies: 3621 2198 2169
-- Name: fk_dbpessoas_funcionarios__dbfuncionarios_ocorrencias__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfuncionarios_ocorrencias
    ADD CONSTRAINT fk_dbpessoas_funcionarios__dbfuncionarios_ocorrencias__unidade FOREIGN KEY (codigofuncionario) REFERENCES dbpessoas_funcionarios(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3915 (class 2606 OID 19484)
-- Dependencies: 3621 2198 2171
-- Name: fk_dbpessoas_funcionarios__dbfuncionarios_professores__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfuncionarios_professores
    ADD CONSTRAINT fk_dbpessoas_funcionarios__dbfuncionarios_professores__unidade FOREIGN KEY (codigofuncionario) REFERENCES dbpessoas_funcionarios(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3917 (class 2606 OID 19489)
-- Dependencies: 3621 2198 2173
-- Name: fk_dbpessoas_funcionarios__dbfuncionarios_treinamentos__codigof; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfuncionarios_treinamentos
    ADD CONSTRAINT fk_dbpessoas_funcionarios__dbfuncionarios_treinamentos__codigof FOREIGN KEY (codigofuncionario) REFERENCES dbpessoas_funcionarios(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3920 (class 2606 OID 19494)
-- Dependencies: 3621 2198 2178
-- Name: fk_dbpessoas_funcionarios__dbpatrimonios__codigofuncionario; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpatrimonios
    ADD CONSTRAINT fk_dbpessoas_funcionarios__dbpatrimonios__codigofuncionario FOREIGN KEY (codigofuncionario) REFERENCES dbpessoas_funcionarios(codigo);


--
-- TOC entry 3961 (class 2606 OID 19499)
-- Dependencies: 3621 2198 2204
-- Name: fk_dbpessoas_funcionarios__dbpessoas_solicitacoes__codigofuncio; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_solicitacoes
    ADD CONSTRAINT fk_dbpessoas_funcionarios__dbpessoas_solicitacoes__codigofuncio FOREIGN KEY (codigofuncionario) REFERENCES dbpessoas_funcionarios(codigo);


--
-- TOC entry 3999 (class 2606 OID 19504)
-- Dependencies: 3641 2208 2253
-- Name: fk_dbplano_contas__dbtransacoes__codigoplanoconta; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes
    ADD CONSTRAINT fk_dbplano_contas__dbtransacoes__codigoplanoconta FOREIGN KEY (codigoplanoconta) REFERENCES dbplano_contas(codigo);


--
-- TOC entry 4002 (class 2606 OID 19509)
-- Dependencies: 3641 2208 2255
-- Name: fk_dbplano_contas__dbtransacoes_contas__codigoplanoconta; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes_contas
    ADD CONSTRAINT fk_dbplano_contas__dbtransacoes_contas__codigoplanoconta FOREIGN KEY (codigoplanoconta) REFERENCES dbplano_contas(codigo);


--
-- TOC entry 3880 (class 2606 OID 19514)
-- Dependencies: 3641 2208 2132
-- Name: fk_dbplano_contas_dbconvenios_codigoplanoconta; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbconvenios
    ADD CONSTRAINT fk_dbplano_contas_dbconvenios_codigoplanoconta FOREIGN KEY (codigoplanoconta) REFERENCES dbplano_contas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3973 (class 2606 OID 19519)
-- Dependencies: 3650 2212 2221
-- Name: fk_dbproduto__dbprodutos_tabelapreco__codigoproduto; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprodutos_tabelapreco
    ADD CONSTRAINT fk_dbproduto__dbprodutos_tabelapreco__codigoproduto FOREIGN KEY (codigoproduto) REFERENCES dbprodutos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3976 (class 2606 OID 19524)
-- Dependencies: 3650 2212 2225
-- Name: fk_dbproduto__dbprodutos_tributos__codigoproduto; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprodutos_tributos
    ADD CONSTRAINT fk_dbproduto__dbprodutos_tributos__codigoproduto FOREIGN KEY (codigoproduto) REFERENCES dbprodutos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3870 (class 2606 OID 19529)
-- Dependencies: 3650 2212 2122
-- Name: fk_dbprodutos__dbcompras__codigoproduto; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcompras
    ADD CONSTRAINT fk_dbprodutos__dbcompras__codigoproduto FOREIGN KEY (codigoproduto) REFERENCES dbprodutos(codigo);


--
-- TOC entry 3884 (class 2606 OID 19534)
-- Dependencies: 3650 2212 2136
-- Name: fk_dbprodutos__dbcotacoes__codigoproduto; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcotacoes
    ADD CONSTRAINT fk_dbprodutos__dbcotacoes__codigoproduto FOREIGN KEY (codigoproduto) REFERENCES dbprodutos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3921 (class 2606 OID 19539)
-- Dependencies: 3650 2212 2178
-- Name: fk_dbprodutos__dbpatrimonios__codigoproduto; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpatrimonios
    ADD CONSTRAINT fk_dbprodutos__dbpatrimonios__codigoproduto FOREIGN KEY (codigoproduto) REFERENCES dbprodutos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3968 (class 2606 OID 19544)
-- Dependencies: 3650 2212 2214
-- Name: fk_dbprodutos__dbprodutos_insumos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprodutos_caracteristicas
    ADD CONSTRAINT fk_dbprodutos__dbprodutos_insumos__unidade FOREIGN KEY (codigoproduto) REFERENCES dbprodutos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3970 (class 2606 OID 19549)
-- Dependencies: 3650 2212 2219
-- Name: fk_dbprodutos__dbprodutos_parametros__codigoproduto; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprodutos_parametros
    ADD CONSTRAINT fk_dbprodutos__dbprodutos_parametros__codigoproduto FOREIGN KEY (codigoproduto) REFERENCES dbprodutos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4014 (class 2606 OID 19554)
-- Dependencies: 3650 2212 2263
-- Name: fk_dbprodutos__dbtransacoes_produtos__codigoproduto; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes_produtos
    ADD CONSTRAINT fk_dbprodutos__dbtransacoes_produtos__codigoproduto FOREIGN KEY (codigoproduto) REFERENCES dbprodutos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4021 (class 2606 OID 19559)
-- Dependencies: 3650 2212 2269
-- Name: fk_dbprodutos__dbturmas__codigoproduto; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas
    ADD CONSTRAINT fk_dbprodutos__dbturmas__codigoproduto FOREIGN KEY (codigoproduto) REFERENCES dbprodutos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3966 (class 2606 OID 19564)
-- Dependencies: 3667 2223 2212
-- Name: fk_dbprodutos_tipos__dbprodutos__codigotipoproduto; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprodutos
    ADD CONSTRAINT fk_dbprodutos_tipos__dbprodutos__codigotipoproduto FOREIGN KEY (codigotipoproduto) REFERENCES dbprodutos_tipos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3971 (class 2606 OID 19569)
-- Dependencies: 3667 2223 2219
-- Name: fk_dbprodutos_tipos__dbprodutos_parametros__codigotipoproduto; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprodutos_parametros
    ADD CONSTRAINT fk_dbprodutos_tipos__dbprodutos_parametros__codigotipoproduto FOREIGN KEY (codigotipoproduto) REFERENCES dbprodutos_tipos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3983 (class 2606 OID 19574)
-- Dependencies: 3679 2229 2231
-- Name: fk_dbprojetos__dbprojetos_colaboradores__codigoprojeto; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprojetos_colaboradores
    ADD CONSTRAINT fk_dbprojetos__dbprojetos_colaboradores__codigoprojeto FOREIGN KEY (codigoprojeto) REFERENCES dbprojetos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3985 (class 2606 OID 19579)
-- Dependencies: 3679 2229 2233
-- Name: fk_dbprojetos__dbprojetos_custos__codigoprojeto; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprojetos_custos
    ADD CONSTRAINT fk_dbprojetos__dbprojetos_custos__codigoprojeto FOREIGN KEY (codigoprojeto) REFERENCES dbprojetos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3987 (class 2606 OID 19584)
-- Dependencies: 3679 2229 2235
-- Name: fk_dbprojetos__dbprojetos_custos__codigoprojeto; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprojetos_recursos
    ADD CONSTRAINT fk_dbprojetos__dbprojetos_custos__codigoprojeto FOREIGN KEY (codigoprojeto) REFERENCES dbprojetos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3990 (class 2606 OID 19589)
-- Dependencies: 3695 2237 2239
-- Name: fk_dbquestionarios__dbquestoes__codigoquestionario; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbquestoes
    ADD CONSTRAINT fk_dbquestionarios__dbquestoes__codigoquestionario FOREIGN KEY (codigoquestionario) REFERENCES dbquestionarios(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3992 (class 2606 OID 19594)
-- Dependencies: 3699 2239 2241
-- Name: fk_dbquestoes__dbquestoes_itens__codigoquestao; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbquestoes_itens
    ADD CONSTRAINT fk_dbquestoes__dbquestoes_itens__codigoquestao FOREIGN KEY (codigoquestao) REFERENCES dbquestoes(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3902 (class 2606 OID 19599)
-- Dependencies: 3711 2245 2156
-- Name: fk_dbsalas__dbdepartamentos__codigosala; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbdepartamentos
    ADD CONSTRAINT fk_dbsalas__dbdepartamentos__codigosala FOREIGN KEY (codigosala) REFERENCES dbsalas(codigo);


--
-- TOC entry 4031 (class 2606 OID 19604)
-- Dependencies: 3711 2245 2275
-- Name: fk_dbsalas__dbturmas_disciplinas__codigosala; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas
    ADD CONSTRAINT fk_dbsalas__dbturmas_disciplinas__codigosala FOREIGN KEY (codigosala) REFERENCES dbsalas(codigo);


--
-- TOC entry 3996 (class 2606 OID 19609)
-- Dependencies: 3715 2247 2249
-- Name: fk_dbscorecard__dbscorecard_sentencas__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbscorecard_sentencas
    ADD CONSTRAINT fk_dbscorecard__dbscorecard_sentencas__unidade FOREIGN KEY (codigoscorecard) REFERENCES dbscorecard(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3853 (class 2606 OID 19614)
-- Dependencies: 3725 2253 2102
-- Name: fk_dbtransacoes__dbalunos_transacoes__codigotransacao; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_transacoes
    ADD CONSTRAINT fk_dbtransacoes__dbalunos_transacoes__codigotransacao FOREIGN KEY (codigotransacao) REFERENCES dbtransacoes(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3862 (class 2606 OID 19619)
-- Dependencies: 3725 2253 2112
-- Name: fk_dbtransacoes__dbcaixa__codigotransacao; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcaixa
    ADD CONSTRAINT fk_dbtransacoes__dbcaixa__codigotransacao FOREIGN KEY (codigotransacao) REFERENCES dbtransacoes(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3929 (class 2606 OID 19624)
-- Dependencies: 3725 2253 2184
-- Name: fk_dbtransacoes__dbpessoas_alunos__codigotransacao; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_alunos
    ADD CONSTRAINT fk_dbtransacoes__dbpessoas_alunos__codigotransacao FOREIGN KEY (codigotransacao) REFERENCES dbtransacoes(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3953 (class 2606 OID 19629)
-- Dependencies: 3725 2253 2200
-- Name: fk_dbtransacoes__dbpessoas_inscricoes__codigotransacao; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_inscricoes
    ADD CONSTRAINT fk_dbtransacoes__dbpessoas_inscricoes__codigotransacao FOREIGN KEY (codigotransacao) REFERENCES dbtransacoes(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4003 (class 2606 OID 19634)
-- Dependencies: 3725 2253 2255
-- Name: fk_dbtransacoes__dbtransacoes_contas__codigotransacao; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes_contas
    ADD CONSTRAINT fk_dbtransacoes__dbtransacoes_contas__codigotransacao FOREIGN KEY (codigotransacao) REFERENCES dbtransacoes(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4012 (class 2606 OID 19639)
-- Dependencies: 3725 2253 2260
-- Name: fk_dbtransacoes__dbtransacoes_convenios__codigotransacao; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes_convenios
    ADD CONSTRAINT fk_dbtransacoes__dbtransacoes_convenios__codigotransacao FOREIGN KEY (codigotransacao) REFERENCES dbtransacoes(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4015 (class 2606 OID 19644)
-- Dependencies: 3725 2253 2263
-- Name: fk_dbtransacoes__dbtransacoes_produtos__codigotransacao; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes_produtos
    ADD CONSTRAINT fk_dbtransacoes__dbtransacoes_produtos__codigotransacao FOREIGN KEY (codigotransacao) REFERENCES dbtransacoes(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4008 (class 2606 OID 19649)
-- Dependencies: 3729 2255 2259
-- Name: fk_dbtransacoes_contas__db_contas_extornos__codigocontadestino; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes_contas_extornos
    ADD CONSTRAINT fk_dbtransacoes_contas__db_contas_extornos__codigocontadestino FOREIGN KEY (codigocontadestino) REFERENCES dbtransacoes_contas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4009 (class 2606 OID 19654)
-- Dependencies: 3729 2255 2259
-- Name: fk_dbtransacoes_contas__db_contas_extornos__codigocontaorigem; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes_contas_extornos
    ADD CONSTRAINT fk_dbtransacoes_contas__db_contas_extornos__codigocontaorigem FOREIGN KEY (codigocontaorigem) REFERENCES dbtransacoes_contas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3863 (class 2606 OID 19659)
-- Dependencies: 3729 2255 2112
-- Name: fk_dbtransacoes_contas__dbcaixa__codigoconta; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcaixa
    ADD CONSTRAINT fk_dbtransacoes_contas__dbcaixa__codigoconta FOREIGN KEY (codigoconta) REFERENCES dbtransacoes_contas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4006 (class 2606 OID 19664)
-- Dependencies: 3729 2255 2257
-- Name: fk_dbtransacoes_contas__dbtransacoes_contas_duplicatas__codigoc; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes_contas_duplicatas
    ADD CONSTRAINT fk_dbtransacoes_contas__dbtransacoes_contas_duplicatas__codigoc FOREIGN KEY (codigoconta) REFERENCES dbtransacoes_contas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3918 (class 2606 OID 19669)
-- Dependencies: 3749 2265 2173
-- Name: fk_dbtreinamentos_dbfuncionarios_treinamentos__codigotreinament; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfuncionarios_treinamentos
    ADD CONSTRAINT fk_dbtreinamentos_dbfuncionarios_treinamentos__codigotreinament FOREIGN KEY (codigotreinamento) REFERENCES dbtreinamentos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3930 (class 2606 OID 19674)
-- Dependencies: 3757 2269 2184
-- Name: fk_dbturmas__dbpessoas_alunos__codigoturma; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_alunos
    ADD CONSTRAINT fk_dbturmas__dbpessoas_alunos__codigoturma FOREIGN KEY (codigoturma) REFERENCES dbturmas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3954 (class 2606 OID 19679)
-- Dependencies: 3757 2269 2200
-- Name: fk_dbturmas__dbpessoas_inscricoes__codigoturma; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_inscricoes
    ADD CONSTRAINT fk_dbturmas__dbpessoas_inscricoes__codigoturma FOREIGN KEY (codigoturma) REFERENCES dbturmas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4024 (class 2606 OID 19684)
-- Dependencies: 3757 2269 2270
-- Name: fk_dbturmas__dbturmas_convenios__codigoturma; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_convenios
    ADD CONSTRAINT fk_dbturmas__dbturmas_convenios__codigoturma FOREIGN KEY (codigoturma) REFERENCES dbturmas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4026 (class 2606 OID 19689)
-- Dependencies: 3757 2269 2273
-- Name: fk_dbturmas__dbturmas_descontos__codigoturma; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_descontos
    ADD CONSTRAINT fk_dbturmas__dbturmas_descontos__codigoturma FOREIGN KEY (codigoturma) REFERENCES dbturmas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4032 (class 2606 OID 19694)
-- Dependencies: 3757 2269 2275
-- Name: fk_dbturmas__dbturmas_disciplinas__codigoturma; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas
    ADD CONSTRAINT fk_dbturmas__dbturmas_disciplinas__codigoturma FOREIGN KEY (codigoturma) REFERENCES dbturmas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4049 (class 2606 OID 19699)
-- Dependencies: 3757 2269 2289
-- Name: fk_dbturmas__dbturmas_requisitos__codigoturma; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_requisitos
    ADD CONSTRAINT fk_dbturmas__dbturmas_requisitos__codigoturma FOREIGN KEY (codigoturma) REFERENCES dbturmas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3833 (class 2606 OID 19704)
-- Dependencies: 3542 2158 2090
-- Name: fk_dbturmas_disciplinas__dbalunos_disciplinas__codisciplina; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_disciplinas
    ADD CONSTRAINT fk_dbturmas_disciplinas__dbalunos_disciplinas__codisciplina FOREIGN KEY (codigodisciplina) REFERENCES dbdisciplinas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3834 (class 2606 OID 19709)
-- Dependencies: 3769 2275 2090
-- Name: fk_dbturmas_disciplinas__dbalunos_disciplinas__codturmadisc; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_disciplinas
    ADD CONSTRAINT fk_dbturmas_disciplinas__dbalunos_disciplinas__codturmadisc FOREIGN KEY (codigoturmadisciplina) REFERENCES dbturmas_disciplinas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3839 (class 2606 OID 19714)
-- Dependencies: 3769 2275 2094
-- Name: fk_dbturmas_disciplinas__dbalunos_faltas__codigoturmadisciplina; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_faltas
    ADD CONSTRAINT fk_dbturmas_disciplinas__dbalunos_faltas__codigoturmadisciplina FOREIGN KEY (codigoturmadisciplina) REFERENCES dbturmas_disciplinas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3843 (class 2606 OID 19719)
-- Dependencies: 3769 2275 2096
-- Name: fk_dbturmas_disciplinas__dbalunos_notas__codigoturmadisciplina; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_notas
    ADD CONSTRAINT fk_dbturmas_disciplinas__dbalunos_notas__codigoturmadisciplina FOREIGN KEY (codigoturmadisciplina) REFERENCES dbturmas_disciplinas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4035 (class 2606 OID 19724)
-- Dependencies: 3769 2275 2277
-- Name: fk_dbturmas_disciplinas__dbturmas_disciplinas_arquivos__codigot; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas_arquivos
    ADD CONSTRAINT fk_dbturmas_disciplinas__dbturmas_disciplinas_arquivos__codigot FOREIGN KEY (codigoturmadisciplina) REFERENCES dbturmas_disciplinas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4037 (class 2606 OID 19729)
-- Dependencies: 3769 2275 2279
-- Name: fk_dbturmas_disciplinas__dbturmas_disciplinas_aulas__codigoturm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas_aulas
    ADD CONSTRAINT fk_dbturmas_disciplinas__dbturmas_disciplinas_aulas__codigoturm FOREIGN KEY (codigoturmadisciplina) REFERENCES dbturmas_disciplinas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4039 (class 2606 OID 19734)
-- Dependencies: 3769 2275 2280
-- Name: fk_dbturmas_disciplinas__dbturmas_disciplinas_avaliacao_detalha; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas_avaliacao_detalhamento
    ADD CONSTRAINT fk_dbturmas_disciplinas__dbturmas_disciplinas_avaliacao_detalha FOREIGN KEY (codigoturmadisciplina) REFERENCES dbturmas_disciplinas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4041 (class 2606 OID 19739)
-- Dependencies: 3769 2275 2283
-- Name: fk_dbturmas_disciplinas__dbturmas_disciplinas_avaliacoes__codig; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas_avaliacoes
    ADD CONSTRAINT fk_dbturmas_disciplinas__dbturmas_disciplinas_avaliacoes__codig FOREIGN KEY (codigoturmadisciplina) REFERENCES dbturmas_disciplinas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4044 (class 2606 OID 19744)
-- Dependencies: 3769 2275 2285
-- Name: fk_dbturmas_disciplinas__dbturmas_disciplinas_materiais__codigo; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas_materiais
    ADD CONSTRAINT fk_dbturmas_disciplinas__dbturmas_disciplinas_materiais__codigo FOREIGN KEY (codigoturmadisciplina) REFERENCES dbturmas_disciplinas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4047 (class 2606 OID 19749)
-- Dependencies: 3769 2275 2287
-- Name: fk_dbturmas_disciplinas__dbturmas_disciplinas_planoaulas__codig; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas_planoaulas
    ADD CONSTRAINT fk_dbturmas_disciplinas__dbturmas_disciplinas_planoaulas__codig FOREIGN KEY (codigoturmadisciplina) REFERENCES dbturmas_disciplinas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3840 (class 2606 OID 19754)
-- Dependencies: 3777 2279 2094
-- Name: fk_dbturmas_disciplinas_aulas__dbalunos_faltas__codigoaula; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_faltas
    ADD CONSTRAINT fk_dbturmas_disciplinas_aulas__dbalunos_faltas__codigoaula FOREIGN KEY (codigoaula) REFERENCES dbturmas_disciplinas_aulas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4042 (class 2606 OID 19759)
-- Dependencies: 3785 2283 2283
-- Name: fk_dbturmas_disciplinas_avaliacoes; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas_avaliacoes
    ADD CONSTRAINT fk_dbturmas_disciplinas_avaliacoes FOREIGN KEY (codigopai) REFERENCES dbturmas_disciplinas_avaliacoes(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3846 (class 2606 OID 19764)
-- Dependencies: 3797 2289 2098
-- Name: fk_dbturmas_requisitos__dbalunos_requisitos_codigoaula; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_requisitos
    ADD CONSTRAINT fk_dbturmas_requisitos__dbalunos_requisitos_codigoaula FOREIGN KEY (codigorequisito) REFERENCES dbturmas_requisitos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3835 (class 2606 OID 19769)
-- Dependencies: 3801 2291 2090
-- Name: fk_dbunidades__dbalunos_disciplinas__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_disciplinas
    ADD CONSTRAINT fk_dbunidades__dbalunos_disciplinas__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3837 (class 2606 OID 19774)
-- Dependencies: 3801 2291 2092
-- Name: fk_dbunidades__dbalunos_disciplinas_aproveitamentos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_disciplinas_aproveitamentos
    ADD CONSTRAINT fk_dbunidades__dbalunos_disciplinas_aproveitamentos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3841 (class 2606 OID 19779)
-- Dependencies: 3801 2291 2094
-- Name: fk_dbunidades__dbalunos_faltas__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_faltas
    ADD CONSTRAINT fk_dbunidades__dbalunos_faltas__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3844 (class 2606 OID 19784)
-- Dependencies: 3801 2291 2096
-- Name: fk_dbunidades__dbalunos_notas__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_notas
    ADD CONSTRAINT fk_dbunidades__dbalunos_notas__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3847 (class 2606 OID 19789)
-- Dependencies: 3801 2291 2098
-- Name: fk_dbunidades__dbalunos_requisitos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_requisitos
    ADD CONSTRAINT fk_dbunidades__dbalunos_requisitos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3851 (class 2606 OID 19794)
-- Dependencies: 3801 2291 2100
-- Name: fk_dbunidades__dbalunos_solicitacoes__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_solicitacoes
    ADD CONSTRAINT fk_dbunidades__dbalunos_solicitacoes__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3854 (class 2606 OID 19799)
-- Dependencies: 3801 2291 2102
-- Name: fk_dbunidades__dbalunos_transacoes__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_transacoes
    ADD CONSTRAINT fk_dbunidades__dbalunos_transacoes__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3856 (class 2606 OID 19804)
-- Dependencies: 3801 2291 2108
-- Name: fk_dbunidades__dbbalanco_patrimonial__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbbalanco_patrimonial
    ADD CONSTRAINT fk_dbunidades__dbbalanco_patrimonial__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3857 (class 2606 OID 19809)
-- Dependencies: 3801 2291 2110
-- Name: fk_dbunidades__dbbiblioteca_cdu__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbbiblioteca_cdu
    ADD CONSTRAINT fk_dbunidades__dbbiblioteca_cdu__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3864 (class 2606 OID 19814)
-- Dependencies: 3801 2291 2112
-- Name: fk_dbunidades__dbcaixa__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcaixa
    ADD CONSTRAINT fk_dbunidades__dbcaixa__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3865 (class 2606 OID 19819)
-- Dependencies: 3801 2291 2114
-- Name: fk_dbunidades__dbcaixa_fechamentos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcaixa_fechamentos
    ADD CONSTRAINT fk_dbunidades__dbcaixa_fechamentos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3868 (class 2606 OID 19824)
-- Dependencies: 3801 2291 2116
-- Name: fk_dbunidades__dbcaixa_funcionarios__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcaixa_funcionarios
    ADD CONSTRAINT fk_dbunidades__dbcaixa_funcionarios__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3869 (class 2606 OID 19829)
-- Dependencies: 3801 2291 2118
-- Name: fk_dbunidades__dbcargos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcargos
    ADD CONSTRAINT fk_dbunidades__dbcargos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3877 (class 2606 OID 19834)
-- Dependencies: 3801 2291 2128
-- Name: fk_dbunidades__dbcheques__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcontas_cheques
    ADD CONSTRAINT fk_dbunidades__dbcheques__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3871 (class 2606 OID 19839)
-- Dependencies: 3801 2291 2122
-- Name: fk_dbunidades__dbcompras__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcompras
    ADD CONSTRAINT fk_dbunidades__dbcompras__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3872 (class 2606 OID 19844)
-- Dependencies: 3801 2291 2124
-- Name: fk_dbunidades__dbcontas_caixa__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcontas_caixa
    ADD CONSTRAINT fk_dbunidades__dbcontas_caixa__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3874 (class 2606 OID 19849)
-- Dependencies: 3801 2291 2126
-- Name: fk_dbunidades__dbcontas_caixa_historico__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcontas_caixa_historico
    ADD CONSTRAINT fk_dbunidades__dbcontas_caixa_historico__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3879 (class 2606 OID 19854)
-- Dependencies: 3801 2291 2130
-- Name: fk_dbunidades__dbcontratos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcontratos
    ADD CONSTRAINT fk_dbunidades__dbcontratos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3882 (class 2606 OID 19859)
-- Dependencies: 3801 2291 2133
-- Name: fk_dbunidades__dbconvenios_descontos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbconvenios_descontos
    ADD CONSTRAINT fk_dbunidades__dbconvenios_descontos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3885 (class 2606 OID 19864)
-- Dependencies: 3801 2291 2136
-- Name: fk_dbunidades__dbcotacoes__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcotacoes
    ADD CONSTRAINT fk_dbunidades__dbcotacoes__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3886 (class 2606 OID 19869)
-- Dependencies: 3801 2291 2138
-- Name: fk_dbunidades__dbcrm_demandas__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcrm_demandas
    ADD CONSTRAINT fk_dbunidades__dbcrm_demandas__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3887 (class 2606 OID 19874)
-- Dependencies: 3801 2291 2140
-- Name: fk_dbunidades__dbcurriculos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcurriculos
    ADD CONSTRAINT fk_dbunidades__dbcurriculos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3891 (class 2606 OID 19879)
-- Dependencies: 3801 2291 2142
-- Name: fk_dbunidades__dbcursos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcursos
    ADD CONSTRAINT fk_dbunidades__dbcursos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3892 (class 2606 OID 19884)
-- Dependencies: 3801 2291 2144
-- Name: fk_dbunidades__dbcursos_areas__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcursos_areas
    ADD CONSTRAINT fk_dbunidades__dbcursos_areas__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3894 (class 2606 OID 19889)
-- Dependencies: 3801 2291 2146
-- Name: fk_dbunidades__dbcursos_ativos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcursos_ativos
    ADD CONSTRAINT fk_dbunidades__dbcursos_ativos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3896 (class 2606 OID 19894)
-- Dependencies: 3801 2291 2148
-- Name: fk_dbunidades__dbcursos_avaliacoes__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcursos_avaliacoes
    ADD CONSTRAINT fk_dbunidades__dbcursos_avaliacoes__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3899 (class 2606 OID 19899)
-- Dependencies: 3801 2291 2150
-- Name: fk_dbunidades__dbcursos_disciplinas__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcursos_disciplinas
    ADD CONSTRAINT fk_dbunidades__dbcursos_disciplinas__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3900 (class 2606 OID 19904)
-- Dependencies: 3801 2291 2152
-- Name: fk_dbunidades__dbcursos_tipos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcursos_tipos
    ADD CONSTRAINT fk_dbunidades__dbcursos_tipos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3901 (class 2606 OID 19909)
-- Dependencies: 3801 2291 2154
-- Name: fk_dbunidades__dbdados_boleto__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbdados_boleto
    ADD CONSTRAINT fk_dbunidades__dbdados_boleto__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3903 (class 2606 OID 19914)
-- Dependencies: 3801 2291 2156
-- Name: fk_dbunidades__dbdepartamentos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbdepartamentos
    ADD CONSTRAINT fk_dbunidades__dbdepartamentos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3904 (class 2606 OID 19919)
-- Dependencies: 3801 2291 2158
-- Name: fk_dbunidades__dbdisciplinas__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbdisciplinas
    ADD CONSTRAINT fk_dbunidades__dbdisciplinas__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3907 (class 2606 OID 19924)
-- Dependencies: 3801 2291 2160
-- Name: fk_dbunidades__dbdisciplinas_semelhantes__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbdisciplinas_semelhantes
    ADD CONSTRAINT fk_dbunidades__dbdisciplinas_semelhantes__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3908 (class 2606 OID 19929)
-- Dependencies: 3801 2291 2162
-- Name: fk_dbunidades__dbdocumentos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbdocumentos
    ADD CONSTRAINT fk_dbunidades__dbdocumentos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3910 (class 2606 OID 19934)
-- Dependencies: 3801 2291 2165
-- Name: fk_dbunidades__dbfuncionarios_ferias__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfuncionarios_ferias
    ADD CONSTRAINT fk_dbunidades__dbfuncionarios_ferias__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3912 (class 2606 OID 19939)
-- Dependencies: 3801 2291 2167
-- Name: fk_dbunidades__dbfuncionarios_folhapagamento__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfuncionarios_folhapagamento
    ADD CONSTRAINT fk_dbunidades__dbfuncionarios_folhapagamento__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3914 (class 2606 OID 19944)
-- Dependencies: 3801 2291 2169
-- Name: fk_dbunidades__dbfuncionarios_ocorrencias__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfuncionarios_ocorrencias
    ADD CONSTRAINT fk_dbunidades__dbfuncionarios_ocorrencias__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3916 (class 2606 OID 19949)
-- Dependencies: 3801 2291 2171
-- Name: fk_dbunidades__dbfuncionarios_professores__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfuncionarios_professores
    ADD CONSTRAINT fk_dbunidades__dbfuncionarios_professores__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3919 (class 2606 OID 19954)
-- Dependencies: 3801 2291 2173
-- Name: fk_dbunidades__dbfuncionarios_treinamentos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfuncionarios_treinamentos
    ADD CONSTRAINT fk_dbunidades__dbfuncionarios_treinamentos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3922 (class 2606 OID 19959)
-- Dependencies: 3801 2291 2178
-- Name: fk_dbunidades__dbpatrimonios__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpatrimonios
    ADD CONSTRAINT fk_dbunidades__dbpatrimonios__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3925 (class 2606 OID 19964)
-- Dependencies: 3801 2291 2180
-- Name: fk_dbunidades__dbpatrimonios_livros__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpatrimonios_livros
    ADD CONSTRAINT fk_dbunidades__dbpatrimonios_livros__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3926 (class 2606 OID 19969)
-- Dependencies: 3801 2291 2182
-- Name: fk_dbunidades__dbpessoas__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas
    ADD CONSTRAINT fk_dbunidades__dbpessoas__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3931 (class 2606 OID 19974)
-- Dependencies: 3801 2291 2184
-- Name: fk_dbunidades__dbpessoas_alunos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_alunos
    ADD CONSTRAINT fk_dbunidades__dbpessoas_alunos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3933 (class 2606 OID 19979)
-- Dependencies: 3801 2291 2186
-- Name: fk_dbunidades__dbpessoas_complemento_pf__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_complemento_pf
    ADD CONSTRAINT fk_dbunidades__dbpessoas_complemento_pf__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3935 (class 2606 OID 19984)
-- Dependencies: 3801 2291 2188
-- Name: fk_dbunidades__dbpessoas_complemento_pj__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_complemento_pj
    ADD CONSTRAINT fk_dbunidades__dbpessoas_complemento_pj__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3938 (class 2606 OID 19989)
-- Dependencies: 3801 2291 2190
-- Name: fk_dbunidades__dbpessoas_convenios__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_convenios
    ADD CONSTRAINT fk_dbunidades__dbpessoas_convenios__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3941 (class 2606 OID 19994)
-- Dependencies: 3801 2291 2192
-- Name: fk_dbunidades__dbpessoas_demandas__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_demandas
    ADD CONSTRAINT fk_dbunidades__dbpessoas_demandas__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3943 (class 2606 OID 19999)
-- Dependencies: 3801 2291 2194
-- Name: fk_dbunidades__dbpessoas_enderecoscobrancas__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_enderecoscobrancas
    ADD CONSTRAINT fk_dbunidades__dbpessoas_enderecoscobrancas__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3946 (class 2606 OID 20004)
-- Dependencies: 3801 2291 2196
-- Name: fk_dbunidades__dbpessoas_formacoes__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_formacoes
    ADD CONSTRAINT fk_dbunidades__dbpessoas_formacoes__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3950 (class 2606 OID 20009)
-- Dependencies: 3801 2291 2198
-- Name: fk_dbunidades__dbpessoas_funcionarios__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_funcionarios
    ADD CONSTRAINT fk_dbunidades__dbpessoas_funcionarios__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3955 (class 2606 OID 20014)
-- Dependencies: 3801 2291 2200
-- Name: fk_dbunidades__dbpessoas_inscricoes__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_inscricoes
    ADD CONSTRAINT fk_dbunidades__dbpessoas_inscricoes__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3958 (class 2606 OID 20019)
-- Dependencies: 3801 2291 2202
-- Name: fk_dbunidades__dbpessoas_livros__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_livros
    ADD CONSTRAINT fk_dbunidades__dbpessoas_livros__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3962 (class 2606 OID 20024)
-- Dependencies: 3801 2291 2204
-- Name: fk_dbunidades__dbpessoas_solicitacoes__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_solicitacoes
    ADD CONSTRAINT fk_dbunidades__dbpessoas_solicitacoes__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3963 (class 2606 OID 20029)
-- Dependencies: 3801 2291 2206
-- Name: fk_dbunidades__dbpessoas_titularidades__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_titularidades
    ADD CONSTRAINT fk_dbunidades__dbpessoas_titularidades__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3964 (class 2606 OID 20034)
-- Dependencies: 3801 2291 2208
-- Name: fk_dbunidades__dbplano_contas__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbplano_contas
    ADD CONSTRAINT fk_dbunidades__dbplano_contas__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3965 (class 2606 OID 20039)
-- Dependencies: 3801 2291 2210
-- Name: fk_dbunidades__dbprocessos_academicos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprocessos_academicos
    ADD CONSTRAINT fk_dbunidades__dbprocessos_academicos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3967 (class 2606 OID 20044)
-- Dependencies: 3801 2291 2212
-- Name: fk_dbunidades__dbprodutos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprodutos
    ADD CONSTRAINT fk_dbunidades__dbprodutos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3969 (class 2606 OID 20049)
-- Dependencies: 3801 2291 2214
-- Name: fk_dbunidades__dbprodutos_insumos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprodutos_caracteristicas
    ADD CONSTRAINT fk_dbunidades__dbprodutos_insumos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3972 (class 2606 OID 20054)
-- Dependencies: 3801 2291 2219
-- Name: fk_dbunidades__dbprodutos_parametros__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprodutos_parametros
    ADD CONSTRAINT fk_dbunidades__dbprodutos_parametros__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3974 (class 2606 OID 20059)
-- Dependencies: 3801 2291 2221
-- Name: fk_dbunidades__dbprodutos_tabelapreco__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprodutos_tabelapreco
    ADD CONSTRAINT fk_dbunidades__dbprodutos_tabelapreco__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3975 (class 2606 OID 20064)
-- Dependencies: 3801 2291 2223
-- Name: fk_dbunidades__dbprodutos_tipos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprodutos_tipos
    ADD CONSTRAINT fk_dbunidades__dbprodutos_tipos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3977 (class 2606 OID 20069)
-- Dependencies: 3801 2291 2225
-- Name: fk_dbunidades__dbprodutos_tributos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprodutos_tributos
    ADD CONSTRAINT fk_dbunidades__dbprodutos_tributos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3980 (class 2606 OID 20074)
-- Dependencies: 3801 2291 2227
-- Name: fk_dbunidades__dbprofessores_areas__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprofessores_areas
    ADD CONSTRAINT fk_dbunidades__dbprofessores_areas__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3981 (class 2606 OID 20079)
-- Dependencies: 3801 2291 2229
-- Name: fk_dbunidades__dbprojetos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprojetos
    ADD CONSTRAINT fk_dbunidades__dbprojetos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3984 (class 2606 OID 20084)
-- Dependencies: 3801 2291 2231
-- Name: fk_dbunidades__dbprojetos_colaboradores__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprojetos_colaboradores
    ADD CONSTRAINT fk_dbunidades__dbprojetos_colaboradores__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3986 (class 2606 OID 20089)
-- Dependencies: 3801 2291 2233
-- Name: fk_dbunidades__dbprojetos_custos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprojetos_custos
    ADD CONSTRAINT fk_dbunidades__dbprojetos_custos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3988 (class 2606 OID 20094)
-- Dependencies: 3801 2291 2235
-- Name: fk_dbunidades__dbprojetos_recursos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprojetos_recursos
    ADD CONSTRAINT fk_dbunidades__dbprojetos_recursos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3989 (class 2606 OID 20099)
-- Dependencies: 3801 2291 2237
-- Name: fk_dbunidades__dbquestionarios__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbquestionarios
    ADD CONSTRAINT fk_dbunidades__dbquestionarios__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3991 (class 2606 OID 20104)
-- Dependencies: 3801 2291 2239
-- Name: fk_dbunidades__dbquestoes__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbquestoes
    ADD CONSTRAINT fk_dbunidades__dbquestoes__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3993 (class 2606 OID 20109)
-- Dependencies: 3801 2291 2241
-- Name: fk_dbunidades__dbquestoes_itens__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbquestoes_itens
    ADD CONSTRAINT fk_dbunidades__dbquestoes_itens__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3994 (class 2606 OID 20114)
-- Dependencies: 3801 2291 2245
-- Name: fk_dbunidades__dbsalas__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbsalas
    ADD CONSTRAINT fk_dbunidades__dbsalas__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3995 (class 2606 OID 20119)
-- Dependencies: 3801 2291 2247
-- Name: fk_dbunidades__dbscorecard__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbscorecard
    ADD CONSTRAINT fk_dbunidades__dbscorecard__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3997 (class 2606 OID 20124)
-- Dependencies: 3801 2291 2249
-- Name: fk_dbunidades__dbscorecard_sentencas__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbscorecard_sentencas
    ADD CONSTRAINT fk_dbunidades__dbscorecard_sentencas__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4000 (class 2606 OID 20129)
-- Dependencies: 3801 2291 2253
-- Name: fk_dbunidades__dbtransacoes__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes
    ADD CONSTRAINT fk_dbunidades__dbtransacoes__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4004 (class 2606 OID 20134)
-- Dependencies: 3801 2291 2255
-- Name: fk_dbunidades__dbtransacoes_contas__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes_contas
    ADD CONSTRAINT fk_dbunidades__dbtransacoes_contas__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4010 (class 2606 OID 20139)
-- Dependencies: 3801 2291 2259
-- Name: fk_dbunidades__dbtransacoes_contas_extornos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes_contas_extornos
    ADD CONSTRAINT fk_dbunidades__dbtransacoes_contas_extornos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4013 (class 2606 OID 20144)
-- Dependencies: 3801 2291 2260
-- Name: fk_dbunidades__dbtransacoes_convenios__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes_convenios
    ADD CONSTRAINT fk_dbunidades__dbtransacoes_convenios__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4016 (class 2606 OID 20149)
-- Dependencies: 3801 2291 2263
-- Name: fk_dbunidades__dbtransacoes_produtos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes_produtos
    ADD CONSTRAINT fk_dbunidades__dbtransacoes_produtos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4017 (class 2606 OID 20154)
-- Dependencies: 3801 2291 2265
-- Name: fk_dbunidades__dbtreinamentos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtreinamentos
    ADD CONSTRAINT fk_dbunidades__dbtreinamentos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4018 (class 2606 OID 20159)
-- Dependencies: 3801 2291 2267
-- Name: fk_dbunidades__dbtributos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtributos
    ADD CONSTRAINT fk_dbunidades__dbtributos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4022 (class 2606 OID 20164)
-- Dependencies: 3801 2291 2269
-- Name: fk_dbunidades__dbturmas__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas
    ADD CONSTRAINT fk_dbunidades__dbturmas__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4025 (class 2606 OID 20169)
-- Dependencies: 3801 2291 2270
-- Name: fk_dbunidades__dbturmas_convenios__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_convenios
    ADD CONSTRAINT fk_dbunidades__dbturmas_convenios__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4027 (class 2606 OID 20174)
-- Dependencies: 3801 2291 2273
-- Name: fk_dbunidades__dbturmas_descontos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_descontos
    ADD CONSTRAINT fk_dbunidades__dbturmas_descontos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4033 (class 2606 OID 20179)
-- Dependencies: 3801 2291 2275
-- Name: fk_dbunidades__dbturmas_disciplinas__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas
    ADD CONSTRAINT fk_dbunidades__dbturmas_disciplinas__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4036 (class 2606 OID 20184)
-- Dependencies: 3801 2291 2277
-- Name: fk_dbunidades__dbturmas_disciplinas_arquivos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas_arquivos
    ADD CONSTRAINT fk_dbunidades__dbturmas_disciplinas_arquivos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4038 (class 2606 OID 20189)
-- Dependencies: 3801 2291 2279
-- Name: fk_dbunidades__dbturmas_disciplinas_aulas__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas_aulas
    ADD CONSTRAINT fk_dbunidades__dbturmas_disciplinas_aulas__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4040 (class 2606 OID 20194)
-- Dependencies: 3801 2291 2280
-- Name: fk_dbunidades__dbturmas_disciplinas_avaliacao_detalhamento__uni; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas_avaliacao_detalhamento
    ADD CONSTRAINT fk_dbunidades__dbturmas_disciplinas_avaliacao_detalhamento__uni FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4043 (class 2606 OID 20199)
-- Dependencies: 3801 2291 2283
-- Name: fk_dbunidades__dbturmas_disciplinas_avaliacoes__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas_avaliacoes
    ADD CONSTRAINT fk_dbunidades__dbturmas_disciplinas_avaliacoes__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4045 (class 2606 OID 20204)
-- Dependencies: 3801 2291 2285
-- Name: fk_dbunidades__dbturmas_disciplinas_materiais__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas_materiais
    ADD CONSTRAINT fk_dbunidades__dbturmas_disciplinas_materiais__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4048 (class 2606 OID 20209)
-- Dependencies: 3801 2291 2287
-- Name: fk_dbunidades__dbturmas_disciplinas_planoaulas__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas_planoaulas
    ADD CONSTRAINT fk_dbunidades__dbturmas_disciplinas_planoaulas__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4050 (class 2606 OID 20214)
-- Dependencies: 3801 2291 2289
-- Name: fk_dbunidades__dbturmas_requisitos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_requisitos
    ADD CONSTRAINT fk_dbunidades__dbturmas_requisitos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4051 (class 2606 OID 20219)
-- Dependencies: 3801 2291 2293
-- Name: fk_dbunidades__dbunidades_parametros__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbunidades_parametros
    ADD CONSTRAINT fk_dbunidades__dbunidades_parametros__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4053 (class 2606 OID 20224)
-- Dependencies: 3801 2291 2295
-- Name: fk_dbunidades__dbusuarios__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbusuarios
    ADD CONSTRAINT fk_dbunidades__dbusuarios__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4054 (class 2606 OID 20229)
-- Dependencies: 3801 2291 2297
-- Name: fk_dbunidades__dbusuarios_erros__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbusuarios_erros
    ADD CONSTRAINT fk_dbunidades__dbusuarios_erros__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4056 (class 2606 OID 20234)
-- Dependencies: 3801 2291 2299
-- Name: fk_dbunidades__dbusuarios_historico__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbusuarios_historico
    ADD CONSTRAINT fk_dbunidades__dbusuarios_historico__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4058 (class 2606 OID 20239)
-- Dependencies: 3801 2291 2301
-- Name: fk_dbunidades__dbusuarios_privilegios__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbusuarios_privilegios
    ADD CONSTRAINT fk_dbunidades__dbusuarios_privilegios__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4007 (class 2606 OID 20244)
-- Dependencies: 3801 2291 2257
-- Name: fk_dbunidades_dbtransacoes_contas_duplicatas__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes_contas_duplicatas
    ADD CONSTRAINT fk_dbunidades_dbtransacoes_contas_duplicatas__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4055 (class 2606 OID 20249)
-- Dependencies: 3811 2295 2297
-- Name: fk_dbusuarios__dbusuarios_erros__codigousuario; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbusuarios_erros
    ADD CONSTRAINT fk_dbusuarios__dbusuarios_erros__codigousuario FOREIGN KEY (codigousuario) REFERENCES dbusuarios(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4057 (class 2606 OID 20254)
-- Dependencies: 3811 2295 2299
-- Name: fk_dbusuarios__dbusuarios_historico__codigousuario; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbusuarios_historico
    ADD CONSTRAINT fk_dbusuarios__dbusuarios_historico__codigousuario FOREIGN KEY (codigousuario) REFERENCES dbusuarios(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4059 (class 2606 OID 20259)
-- Dependencies: 3811 2295 2301
-- Name: fk_dbusuarios__dbusuarios_privilegios__codigousuario; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbusuarios_privilegios
    ADD CONSTRAINT fk_dbusuarios__dbusuarios_privilegios__codigousuario FOREIGN KEY (codigousuario) REFERENCES dbusuarios(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3845 (class 2606 OID 20264)
-- Dependencies: 3435 2103 2096
-- Name: pk_dbavaliacoes__dbalunos_notas_codigoavaliacao; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_notas
    ADD CONSTRAINT pk_dbavaliacoes__dbalunos_notas_codigoavaliacao FOREIGN KEY (codigoavaliacao) REFERENCES dbavaliacoes(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4064 (class 0 OID 0)
-- Dependencies: 7
-- Name: public; Type: ACL; Schema: -; Owner: -
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2011-04-16 12:01:09

--
-- PostgreSQL database dump complete
--

