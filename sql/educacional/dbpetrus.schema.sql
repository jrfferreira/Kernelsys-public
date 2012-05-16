--
-- PostgreSQL database dump
--

-- Dumped from database version 8.3.17
-- Dumped by pg_dump version 9.1.2
-- Started on 2012-05-16 00:00:06

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- TOC entry 7 (class 2615 OID 28202216)
-- Name: dominio; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA dominio;


SET search_path = public, pg_catalog;

--
-- TOC entry 457 (class 1255 OID 37189719)
-- Dependencies: 8 1506
-- Name: atualiza_pessoa_funcionario(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION atualiza_pessoa_funcionario() RETURNS trigger
    LANGUAGE plpgsql
    AS 'DECLARE
	codigos INTEGER;
    BEGIN
        --
        -- Cria uma linha na tabela emp_audit para refletir a operação
        -- realizada na tabela emp. Utiliza a variável especial TG_OP
        -- para descobrir a operação sendo realizada.
        --
        IF (TG_OP = ''DELETE'') THEN
            DELETE FROM dbpessoas_funcionarios WHERE codigopessoa = OLD.codigo;
            RETURN OLD;
        ELSIF (TG_OP = ''UPDATE'') THEN
            IF (NEW.funcionario = ''1'') THEN
		    select count(codigo) into codigos from dbpessoas_funcionarios where codigopessoa = NEW.codigo;
		    IF codigos > 0 THEN
		      RETURN NULL;
		    ELSE
		       INSERT INTO dbpessoas_funcionarios (codigopessoa,unidade,codigoautor,ativo) values (NEW.codigo,NEW.unidade,NEW.codigoautor,''8'');
		    END IF;
            ELSE
		DELETE FROM dbpessoas_funcionarios WHERE codigopessoa = NEW.codigo;
            END IF;
            RETURN NEW;
        ELSIF (TG_OP = ''INSERT'') THEN
            IF (NEW.funcionario = ''1'') THEN
		    select codigo from dbpessoas_funcionarios where codigopessoa = NEW.codigo;
		    IF FOUND THEN
			RETURN NULL;
		    ELSE
		       INSERT INTO dbpessoas_funcionarios (codigopessoa,unidade,codigoautor,ativo) values (NEW.codigo,NEW.unidade,NEW.codigoautor,''8'');
		    END IF;
            ELSE            
		    RETURN NULL;
            END IF;
            RETURN NEW;
        END IF;
        RETURN NULL; -- o resultado é ignorado uma vez que este é um gatilho AFTER
    END;';


--
-- TOC entry 199 (class 1259 OID 28202613)
-- Dependencies: 8
-- Name: dbcursos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbcursos_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 146 (class 1259 OID 28202275)
-- Dependencies: 8
-- Name: gerador_codigo_digito_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE gerador_codigo_digito_seq
    INCREMENT BY 1
    MINVALUE 100
    MAXVALUE 999
    CACHE 1
    CYCLE;


--
-- TOC entry 147 (class 1259 OID 28202277)
-- Dependencies: 8
-- Name: gerador_codigo_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE gerador_codigo_seq
    INCREMENT BY 1
    MINVALUE 10000000
    NO MAXVALUE
    CACHE 1;


SET default_with_oids = false;

--
-- TOC entry 200 (class 1259 OID 28202615)
-- Dependencies: 3074 3075 3076 3077 3078 8
-- Name: dbcursos; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 239 (class 1259 OID 28202871)
-- Dependencies: 8
-- Name: dbpessoas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbpessoas_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 240 (class 1259 OID 28202873)
-- Dependencies: 3192 3193 3194 3195 3196 3197 3198 3199 3200 3201 8
-- Name: dbpessoas; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 241 (class 1259 OID 28202889)
-- Dependencies: 8
-- Name: dbpessoas_alunos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbpessoas_alunos_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 242 (class 1259 OID 28202891)
-- Dependencies: 3202 3203 3204 3205 3206 8
-- Name: dbpessoas_alunos; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 308 (class 1259 OID 28203284)
-- Dependencies: 8
-- Name: dbstatus; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbstatus (
    id integer NOT NULL,
    situacao character varying(180),
    obs text
);


--
-- TOC entry 328 (class 1259 OID 28203416)
-- Dependencies: 8
-- Name: dbturmas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbturmas_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 329 (class 1259 OID 28203418)
-- Dependencies: 3435 3436 3437 3438 3439 3440 3441 3442 3443 3444 3445 3446 3447 3448 3449 3450 3451 3452 3453 3454 3455 3456 3457 3458 3459 8
-- Name: dbturmas; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 350 (class 1259 OID 28203582)
-- Dependencies: 8
-- Name: dbunidades_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbunidades_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 351 (class 1259 OID 28203584)
-- Dependencies: 3521 3522 3523 3524 3525 8
-- Name: dbunidades; Type: TABLE; Schema: public; Owner: -
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


SET search_path = dominio, pg_catalog;

--
-- TOC entry 129 (class 1259 OID 28202217)
-- Dependencies: 7
-- Name: dbceps; Type: TABLE; Schema: dominio; Owner: -
--

CREATE TABLE dbceps (
    id integer NOT NULL,
    codigomunicipio character varying(200),
    codigouf character varying(30),
    faixainicial character varying(8),
    faixafinal character varying(8)
);


--
-- TOC entry 130 (class 1259 OID 28202220)
-- Dependencies: 129 7
-- Name: dbceps_id_seq; Type: SEQUENCE; Schema: dominio; Owner: -
--

CREATE SEQUENCE dbceps_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4229 (class 0 OID 0)
-- Dependencies: 130
-- Name: dbceps_id_seq; Type: SEQUENCE OWNED BY; Schema: dominio; Owner: -
--

ALTER SEQUENCE dbceps_id_seq OWNED BY dbceps.id;


--
-- TOC entry 131 (class 1259 OID 28202222)
-- Dependencies: 7
-- Name: dbcidades; Type: TABLE; Schema: dominio; Owner: -
--

CREATE TABLE dbcidades (
    id integer NOT NULL,
    cidade character varying(200),
    codigouf character varying(2),
    codigoibge character varying(30)
);


--
-- TOC entry 132 (class 1259 OID 28202225)
-- Dependencies: 131 7
-- Name: dbcidades_id_seq; Type: SEQUENCE; Schema: dominio; Owner: -
--

CREATE SEQUENCE dbcidades_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4230 (class 0 OID 0)
-- Dependencies: 132
-- Name: dbcidades_id_seq; Type: SEQUENCE OWNED BY; Schema: dominio; Owner: -
--

ALTER SEQUENCE dbcidades_id_seq OWNED BY dbcidades.id;


--
-- TOC entry 133 (class 1259 OID 28202227)
-- Dependencies: 7
-- Name: dbestados; Type: TABLE; Schema: dominio; Owner: -
--

CREATE TABLE dbestados (
    id integer NOT NULL,
    estado character varying(30),
    uf character varying(2),
    codigouf character varying(30),
    codigopais character varying(30)
);


--
-- TOC entry 134 (class 1259 OID 28202230)
-- Dependencies: 7 133
-- Name: dbestados_id_seq; Type: SEQUENCE; Schema: dominio; Owner: -
--

CREATE SEQUENCE dbestados_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4231 (class 0 OID 0)
-- Dependencies: 134
-- Name: dbestados_id_seq; Type: SEQUENCE OWNED BY; Schema: dominio; Owner: -
--

ALTER SEQUENCE dbestados_id_seq OWNED BY dbestados.id;


--
-- TOC entry 135 (class 1259 OID 28202232)
-- Dependencies: 7
-- Name: dbnfe_erros; Type: TABLE; Schema: dominio; Owner: -
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
-- TOC entry 136 (class 1259 OID 28202238)
-- Dependencies: 7
-- Name: dbnfe_erros_grupos; Type: TABLE; Schema: dominio; Owner: -
--

CREATE TABLE dbnfe_erros_grupos (
    id integer NOT NULL,
    grupo character varying(1),
    descricao text,
    aplicacao character varying(40)
);


--
-- TOC entry 137 (class 1259 OID 28202244)
-- Dependencies: 135 7
-- Name: dbnfe_erros_id_seq; Type: SEQUENCE; Schema: dominio; Owner: -
--

CREATE SEQUENCE dbnfe_erros_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4232 (class 0 OID 0)
-- Dependencies: 137
-- Name: dbnfe_erros_id_seq; Type: SEQUENCE OWNED BY; Schema: dominio; Owner: -
--

ALTER SEQUENCE dbnfe_erros_id_seq OWNED BY dbnfe_erros.id;


--
-- TOC entry 138 (class 1259 OID 28202246)
-- Dependencies: 7
-- Name: dbnfe_erros_mensagens; Type: TABLE; Schema: dominio; Owner: -
--

CREATE TABLE dbnfe_erros_mensagens (
    id integer NOT NULL,
    codigo character varying(10),
    descricao text
);


--
-- TOC entry 139 (class 1259 OID 28202252)
-- Dependencies: 7
-- Name: dbpaises; Type: TABLE; Schema: dominio; Owner: -
--

CREATE TABLE dbpaises (
    id integer NOT NULL,
    pais character varying(200),
    codigopais character varying(30),
    tributacaofavorecida character varying(30)
);


--
-- TOC entry 140 (class 1259 OID 28202255)
-- Dependencies: 7 139
-- Name: dbpaises_id_seq; Type: SEQUENCE; Schema: dominio; Owner: -
--

CREATE SEQUENCE dbpaises_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4233 (class 0 OID 0)
-- Dependencies: 140
-- Name: dbpaises_id_seq; Type: SEQUENCE OWNED BY; Schema: dominio; Owner: -
--

ALTER SEQUENCE dbpaises_id_seq OWNED BY dbpaises.id;


--
-- TOC entry 141 (class 1259 OID 28202257)
-- Dependencies: 7
-- Name: dbwebservices; Type: TABLE; Schema: dominio; Owner: -
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
-- TOC entry 142 (class 1259 OID 28202263)
-- Dependencies: 7
-- Name: dbwebservices_campos; Type: TABLE; Schema: dominio; Owner: -
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
-- TOC entry 143 (class 1259 OID 28202269)
-- Dependencies: 142 7
-- Name: dbwebservices_campos_id_seq; Type: SEQUENCE; Schema: dominio; Owner: -
--

CREATE SEQUENCE dbwebservices_campos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4234 (class 0 OID 0)
-- Dependencies: 143
-- Name: dbwebservices_campos_id_seq; Type: SEQUENCE OWNED BY; Schema: dominio; Owner: -
--

ALTER SEQUENCE dbwebservices_campos_id_seq OWNED BY dbwebservices_campos.id;


--
-- TOC entry 144 (class 1259 OID 28202271)
-- Dependencies: 141 7
-- Name: dbwebservices_id_seq; Type: SEQUENCE; Schema: dominio; Owner: -
--

CREATE SEQUENCE dbwebservices_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4235 (class 0 OID 0)
-- Dependencies: 144
-- Name: dbwebservices_id_seq; Type: SEQUENCE OWNED BY; Schema: dominio; Owner: -
--

ALTER SEQUENCE dbwebservices_id_seq OWNED BY dbwebservices.id;


SET search_path = public, pg_catalog;

--
-- TOC entry 145 (class 1259 OID 28202273)
-- Dependencies: 8
-- Name: dbalunos_disciplinas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbalunos_disciplinas_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 148 (class 1259 OID 28202279)
-- Dependencies: 2912 2913 2914 2915 2916 2917 8
-- Name: dbalunos_disciplinas; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 4236 (class 0 OID 0)
-- Dependencies: 148
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
-- TOC entry 149 (class 1259 OID 28202291)
-- Dependencies: 8
-- Name: dbalunos_disciplinas_aproveitamentos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbalunos_disciplinas_aproveitamentos_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 150 (class 1259 OID 28202293)
-- Dependencies: 2918 2919 2920 2921 2922 8
-- Name: dbalunos_disciplinas_aproveitamentos; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 151 (class 1259 OID 28202304)
-- Dependencies: 8
-- Name: dbalunos_faltas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbalunos_faltas_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 152 (class 1259 OID 28202306)
-- Dependencies: 2923 2924 2925 2926 2927 2928 2929 8
-- Name: dbalunos_faltas; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 153 (class 1259 OID 28202319)
-- Dependencies: 8
-- Name: dbalunos_notas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbalunos_notas_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 154 (class 1259 OID 28202321)
-- Dependencies: 2930 2931 2932 2933 2934 8
-- Name: dbalunos_notas; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 155 (class 1259 OID 28202329)
-- Dependencies: 8
-- Name: dbalunos_requisitos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbalunos_requisitos_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 156 (class 1259 OID 28202331)
-- Dependencies: 2935 2936 2937 2938 2939 8
-- Name: dbalunos_requisitos; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 157 (class 1259 OID 28202342)
-- Dependencies: 8
-- Name: dbalunos_solicitacoes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbalunos_solicitacoes_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 158 (class 1259 OID 28202344)
-- Dependencies: 2940 2941 2942 2943 2944 8
-- Name: dbalunos_solicitacoes; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 159 (class 1259 OID 28202355)
-- Dependencies: 8
-- Name: dbalunos_transacoes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbalunos_transacoes_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 160 (class 1259 OID 28202357)
-- Dependencies: 2945 2946 2947 2948 2949 8
-- Name: dbalunos_transacoes; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 161 (class 1259 OID 28202365)
-- Dependencies: 2951 2952 2953 2954 2955 2956 2957 8
-- Name: dbavaliacoes; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 162 (class 1259 OID 28202378)
-- Dependencies: 161 8
-- Name: dbavaliacoes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbavaliacoes_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4237 (class 0 OID 0)
-- Dependencies: 162
-- Name: dbavaliacoes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dbavaliacoes_id_seq OWNED BY dbavaliacoes.id;


--
-- TOC entry 163 (class 1259 OID 28202380)
-- Dependencies: 2959 2960 2961 2962 8
-- Name: dbavaliacoes_regras; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 164 (class 1259 OID 28202390)
-- Dependencies: 8 163
-- Name: dbavaliacoes_regras_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbavaliacoes_regras_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4238 (class 0 OID 0)
-- Dependencies: 164
-- Name: dbavaliacoes_regras_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dbavaliacoes_regras_id_seq OWNED BY dbavaliacoes_regras.id;


--
-- TOC entry 165 (class 1259 OID 28202392)
-- Dependencies: 8
-- Name: dbbalanco_patrimonial_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbbalanco_patrimonial_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 166 (class 1259 OID 28202394)
-- Dependencies: 2963 2964 2965 2966 2967 2968 2969 2970 2971 2972 2973 2974 2975 2976 2977 2978 2979 2980 2981 2982 2983 2984 2985 2986 2987 2988 2989 8
-- Name: dbbalanco_patrimonial; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 167 (class 1259 OID 28202424)
-- Dependencies: 8
-- Name: dbbiblioteca_cdu_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbbiblioteca_cdu_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 168 (class 1259 OID 28202426)
-- Dependencies: 2990 2991 2992 2993 2994 8
-- Name: dbbiblioteca_cdu; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 169 (class 1259 OID 28202434)
-- Dependencies: 8
-- Name: dbcaixa_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbcaixa_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 170 (class 1259 OID 28202436)
-- Dependencies: 2995 2996 2997 2998 2999 3000 3001 3002 3003 3004 8
-- Name: dbcaixa; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 4239 (class 0 OID 0)
-- Dependencies: 170
-- Name: COLUMN dbcaixa.valorreal; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbcaixa.valorreal IS 'Valor real da conta, sem acresciomos e descontos. Esse valor é o valor atual da conta que pode ser diferente do valor nominal inicial.';


--
-- TOC entry 4240 (class 0 OID 0)
-- Dependencies: 170
-- Name: COLUMN dbcaixa.statusmovimento; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbcaixa.statusmovimento IS 'Status do movimento do caixa

1 = Movimento em aberto
2 = Movimento conferido
3 = Movimento programado
4 = Movimento extornado
5 = Movimento Consolidado';


--
-- TOC entry 171 (class 1259 OID 28202452)
-- Dependencies: 8
-- Name: dbcaixa_fechamentos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbcaixa_fechamentos_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 172 (class 1259 OID 28202454)
-- Dependencies: 3005 3006 3007 3008 3009 8
-- Name: dbcaixa_fechamentos; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 173 (class 1259 OID 28202462)
-- Dependencies: 8
-- Name: dbcaixa_funcionarios_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbcaixa_funcionarios_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 174 (class 1259 OID 28202464)
-- Dependencies: 3010 3011 3012 3013 3014 3015 8
-- Name: dbcaixa_funcionarios; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 4241 (class 0 OID 0)
-- Dependencies: 174
-- Name: COLUMN dbcaixa_funcionarios.situacao; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbcaixa_funcionarios.situacao IS '1 = Liberado para Movimentações
2 = Aguardando Liberação';


--
-- TOC entry 175 (class 1259 OID 28202476)
-- Dependencies: 8
-- Name: dbcargos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbcargos_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 176 (class 1259 OID 28202478)
-- Dependencies: 3016 3017 3018 3019 3020 3021 8
-- Name: dbcargos; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 177 (class 1259 OID 28202490)
-- Dependencies: 8
-- Name: dbceps_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbceps_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 178 (class 1259 OID 28202492)
-- Dependencies: 8
-- Name: dbcidades_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbcidades_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 179 (class 1259 OID 28202494)
-- Dependencies: 8
-- Name: dbcompras_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbcompras_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 180 (class 1259 OID 28202496)
-- Dependencies: 3022 3023 3024 3025 3026 3027 8
-- Name: dbcompras; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 181 (class 1259 OID 28202505)
-- Dependencies: 8
-- Name: dbcontas_caixa_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbcontas_caixa_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 182 (class 1259 OID 28202507)
-- Dependencies: 3028 3029 3030 3031 3032 3033 3034 3035 8
-- Name: dbcontas_caixa; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 4242 (class 0 OID 0)
-- Dependencies: 182
-- Name: COLUMN dbcontas_caixa.situacao; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbcontas_caixa.situacao IS '1 = Liberado para Movimentações.
2 = Aguardando liberação.';


--
-- TOC entry 183 (class 1259 OID 28202518)
-- Dependencies: 8
-- Name: dbcontas_caixa_historico_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbcontas_caixa_historico_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 184 (class 1259 OID 28202520)
-- Dependencies: 3036 3037 3038 3039 3040 8
-- Name: dbcontas_caixa_historico; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 185 (class 1259 OID 28202528)
-- Dependencies: 8
-- Name: dbcontas_cheques_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbcontas_cheques_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 186 (class 1259 OID 28202530)
-- Dependencies: 3041 3042 3043 3044 3045 8
-- Name: dbcontas_cheques; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 187 (class 1259 OID 28202541)
-- Dependencies: 8
-- Name: dbcontratos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbcontratos_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 188 (class 1259 OID 28202543)
-- Dependencies: 3046 3047 3048 3049 3050 8
-- Name: dbcontratos; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 189 (class 1259 OID 28202554)
-- Dependencies: 8
-- Name: dbconvenios_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbconvenios_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 190 (class 1259 OID 28202556)
-- Dependencies: 3051 3052 3053 8
-- Name: dbconvenios; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 4243 (class 0 OID 0)
-- Dependencies: 190
-- Name: COLUMN dbconvenios.tipoconvenio; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbconvenios.tipoconvenio IS 'Tipo de convênio.

1 = Desconto
2 = Bolsa
3 = Parceria';


--
-- TOC entry 4244 (class 0 OID 0)
-- Dependencies: 190
-- Name: COLUMN dbconvenios.tipotransacao; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbconvenios.tipotransacao IS 'tipo da transação a ser gerada pela associação do convênio a uma pessoa

1 = crédito
2 = débito';


--
-- TOC entry 4245 (class 0 OID 0)
-- Dependencies: 190
-- Name: COLUMN dbconvenios.valor; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbconvenios.valor IS 'valor do crédito/débito a ser gerado em função do escobo do convênio';


--
-- TOC entry 4246 (class 0 OID 0)
-- Dependencies: 190
-- Name: COLUMN dbconvenios.formato; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbconvenios.formato IS 'formato do valor

1 = valor
2 = percentual';


--
-- TOC entry 4247 (class 0 OID 0)
-- Dependencies: 190
-- Name: COLUMN dbconvenios.datavigencia; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbconvenios.datavigencia IS 'data em que o convênio entra em vigor.';


--
-- TOC entry 191 (class 1259 OID 28202565)
-- Dependencies: 3055 3056 3057 3058 8
-- Name: dbconvenios_descontos; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 192 (class 1259 OID 28202575)
-- Dependencies: 191 8
-- Name: dbconvenios_descontos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbconvenios_descontos_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4248 (class 0 OID 0)
-- Dependencies: 192
-- Name: dbconvenios_descontos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dbconvenios_descontos_id_seq OWNED BY dbconvenios_descontos.id;


--
-- TOC entry 193 (class 1259 OID 28202577)
-- Dependencies: 8
-- Name: dbcotacoes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbcotacoes_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 194 (class 1259 OID 28202579)
-- Dependencies: 3059 3060 3061 3062 3063 8
-- Name: dbcotacoes; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 195 (class 1259 OID 28202587)
-- Dependencies: 8
-- Name: dbcrm_demandas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbcrm_demandas_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 196 (class 1259 OID 28202589)
-- Dependencies: 3064 3065 3066 3067 3068 8
-- Name: dbcrm_demandas; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 197 (class 1259 OID 28202600)
-- Dependencies: 8
-- Name: dbcurriculos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbcurriculos_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 198 (class 1259 OID 28202602)
-- Dependencies: 3069 3070 3071 3072 3073 8
-- Name: dbcurriculos; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 201 (class 1259 OID 28202626)
-- Dependencies: 8
-- Name: dbcursos_areas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbcursos_areas_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 202 (class 1259 OID 28202628)
-- Dependencies: 3079 3080 3081 3082 3083 8
-- Name: dbcursos_areas; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 203 (class 1259 OID 28202639)
-- Dependencies: 8
-- Name: dbcursos_ativos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbcursos_ativos_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 204 (class 1259 OID 28202641)
-- Dependencies: 3084 3085 3086 3087 3088 8
-- Name: dbcursos_ativos; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 205 (class 1259 OID 28202652)
-- Dependencies: 8
-- Name: dbcursos_avaliacoes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbcursos_avaliacoes_id_seq
    START WITH 33
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 206 (class 1259 OID 28202654)
-- Dependencies: 3089 3090 3091 3092 3093 8
-- Name: dbcursos_avaliacoes; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 207 (class 1259 OID 28202662)
-- Dependencies: 8
-- Name: dbcursos_disciplinas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbcursos_disciplinas_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 208 (class 1259 OID 28202664)
-- Dependencies: 3094 3095 3096 3097 3098 8
-- Name: dbcursos_disciplinas; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 209 (class 1259 OID 28202672)
-- Dependencies: 8
-- Name: dbcursos_tipos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbcursos_tipos_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 210 (class 1259 OID 28202674)
-- Dependencies: 3099 3100 3101 3102 3103 8
-- Name: dbcursos_tipos; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 211 (class 1259 OID 28202685)
-- Dependencies: 8
-- Name: dbdados_boleto_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbdados_boleto_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 212 (class 1259 OID 28202687)
-- Dependencies: 3104 3105 3106 3107 3108 3109 8
-- Name: dbdados_boleto; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 213 (class 1259 OID 28202699)
-- Dependencies: 8
-- Name: dbdepartamentos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbdepartamentos_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 214 (class 1259 OID 28202701)
-- Dependencies: 3110 3111 3112 3113 3114 8
-- Name: dbdepartamentos; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 215 (class 1259 OID 28202712)
-- Dependencies: 8
-- Name: dbdisciplinas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbdisciplinas_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 216 (class 1259 OID 28202714)
-- Dependencies: 3115 3116 3117 3118 3119 8
-- Name: dbdisciplinas; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 217 (class 1259 OID 28202725)
-- Dependencies: 8
-- Name: dbdisciplinas_semelhantes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbdisciplinas_semelhantes_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 218 (class 1259 OID 28202727)
-- Dependencies: 3120 3121 3122 3123 3124 8
-- Name: dbdisciplinas_semelhantes; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 219 (class 1259 OID 28202735)
-- Dependencies: 8
-- Name: dbdocumentos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbdocumentos_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 220 (class 1259 OID 28202737)
-- Dependencies: 3125 3126 3127 3128 3129 8
-- Name: dbdocumentos; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 221 (class 1259 OID 28202748)
-- Dependencies: 8
-- Name: dbestados_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbestados_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 222 (class 1259 OID 28202750)
-- Dependencies: 8
-- Name: dbfuncionarios_ferias_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbfuncionarios_ferias_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 223 (class 1259 OID 28202752)
-- Dependencies: 3130 3131 3132 3133 3134 8
-- Name: dbfuncionarios_ferias; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 224 (class 1259 OID 28202760)
-- Dependencies: 8
-- Name: dbfuncionarios_folhapagamento_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbfuncionarios_folhapagamento_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 225 (class 1259 OID 28202762)
-- Dependencies: 3135 3136 3137 3138 3139 3140 3141 3142 3143 3144 3145 3146 3147 3148 3149 3150 3151 3152 3153 3154 3155 3156 3157 3158 8
-- Name: dbfuncionarios_folhapagamento; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 226 (class 1259 OID 28202792)
-- Dependencies: 8
-- Name: dbfuncionarios_ocorrencias_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbfuncionarios_ocorrencias_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 227 (class 1259 OID 28202794)
-- Dependencies: 3159 3160 3161 3162 3163 8
-- Name: dbfuncionarios_ocorrencias; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 228 (class 1259 OID 28202805)
-- Dependencies: 8
-- Name: dbfuncionarios_professores_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbfuncionarios_professores_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 229 (class 1259 OID 28202807)
-- Dependencies: 3164 3165 3166 3167 3168 8
-- Name: dbfuncionarios_professores; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 230 (class 1259 OID 28202818)
-- Dependencies: 8
-- Name: dbfuncionarios_treinamentos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbfuncionarios_treinamentos_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 231 (class 1259 OID 28202820)
-- Dependencies: 3169 3170 3171 3172 3173 8
-- Name: dbfuncionarios_treinamentos; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 232 (class 1259 OID 28202828)
-- Dependencies: 3175 3176 3177 3178 8
-- Name: dbgrade_avaliacoes; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 233 (class 1259 OID 28202838)
-- Dependencies: 8 232
-- Name: dbgrade_avaliacoes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbgrade_avaliacoes_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4249 (class 0 OID 0)
-- Dependencies: 233
-- Name: dbgrade_avaliacoes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dbgrade_avaliacoes_id_seq OWNED BY dbgrade_avaliacoes.id;


--
-- TOC entry 234 (class 1259 OID 28202840)
-- Dependencies: 8
-- Name: dbpaises_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbpaises_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 235 (class 1259 OID 28202842)
-- Dependencies: 8
-- Name: dbpatrimonios_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbpatrimonios_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 236 (class 1259 OID 28202844)
-- Dependencies: 3179 3180 3181 3182 3183 3184 3185 3186 8
-- Name: dbpatrimonios; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 237 (class 1259 OID 28202858)
-- Dependencies: 8
-- Name: dbpatrimonios_livros_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbpatrimonios_livros_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 238 (class 1259 OID 28202860)
-- Dependencies: 3187 3188 3189 3190 3191 8
-- Name: dbpatrimonios_livros; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 243 (class 1259 OID 28202899)
-- Dependencies: 8
-- Name: dbpessoas_complemento_pf_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbpessoas_complemento_pf_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 244 (class 1259 OID 28202901)
-- Dependencies: 3207 3208 3209 3210 3211 8
-- Name: dbpessoas_complemento_pf; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 245 (class 1259 OID 28202912)
-- Dependencies: 8
-- Name: dbpessoas_complemento_pj_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbpessoas_complemento_pj_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 246 (class 1259 OID 28202914)
-- Dependencies: 3212 3213 3214 3215 3216 8
-- Name: dbpessoas_complemento_pj; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 247 (class 1259 OID 28202925)
-- Dependencies: 8
-- Name: dbpessoas_convenios_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbpessoas_convenios_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 248 (class 1259 OID 28202927)
-- Dependencies: 3217 3218 3219 3220 3221 8
-- Name: dbpessoas_convenios; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 249 (class 1259 OID 28202935)
-- Dependencies: 8
-- Name: dbpessoas_demandas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbpessoas_demandas_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 250 (class 1259 OID 28202937)
-- Dependencies: 3222 3223 3224 3225 3226 8
-- Name: dbpessoas_demandas; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 251 (class 1259 OID 28202945)
-- Dependencies: 8
-- Name: dbpessoas_enderecoscobrancas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbpessoas_enderecoscobrancas_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 252 (class 1259 OID 28202947)
-- Dependencies: 3227 3228 3229 3230 3231 8
-- Name: dbpessoas_enderecoscobrancas; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 253 (class 1259 OID 28202958)
-- Dependencies: 8
-- Name: dbpessoas_formacoes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbpessoas_formacoes_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 254 (class 1259 OID 28202960)
-- Dependencies: 3232 3233 3234 3235 3236 8
-- Name: dbpessoas_formacoes; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 255 (class 1259 OID 28202971)
-- Dependencies: 8
-- Name: dbpessoas_funcionarios_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbpessoas_funcionarios_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 256 (class 1259 OID 28202973)
-- Dependencies: 3237 3238 3239 3240 3241 8
-- Name: dbpessoas_funcionarios; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbpessoas_funcionarios (
    id integer DEFAULT nextval('dbpessoas_funcionarios_id_seq'::regclass) NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    codigopessoa character varying(30),
    codigocargo character varying(20),
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
-- TOC entry 257 (class 1259 OID 28202984)
-- Dependencies: 8
-- Name: dbpessoas_inscricoes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbpessoas_inscricoes_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 258 (class 1259 OID 28202986)
-- Dependencies: 3242 3243 3244 3245 3246 3247 8
-- Name: dbpessoas_inscricoes; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 259 (class 1259 OID 28202995)
-- Dependencies: 8
-- Name: dbpessoas_livros_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbpessoas_livros_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 260 (class 1259 OID 28202997)
-- Dependencies: 3248 3249 3250 3251 3252 3253 3254 3255 3256 3257 8
-- Name: dbpessoas_livros; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 261 (class 1259 OID 28203010)
-- Dependencies: 8
-- Name: dbpessoas_solicitacoes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbpessoas_solicitacoes_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 262 (class 1259 OID 28203012)
-- Dependencies: 3258 3259 3260 3261 3262 8
-- Name: dbpessoas_solicitacoes; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 263 (class 1259 OID 28203023)
-- Dependencies: 8
-- Name: dbpessoas_titularidades_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbpessoas_titularidades_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 264 (class 1259 OID 28203025)
-- Dependencies: 3263 3264 3265 3266 3267 8
-- Name: dbpessoas_titularidades; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 265 (class 1259 OID 28203033)
-- Dependencies: 8
-- Name: dbplano_contas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbplano_contas_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 266 (class 1259 OID 28203035)
-- Dependencies: 3268 3269 3270 3271 3272 3273 3274 8
-- Name: dbplano_contas; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 267 (class 1259 OID 28203048)
-- Dependencies: 8
-- Name: dbprocessos_academicos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbprocessos_academicos_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 268 (class 1259 OID 28203050)
-- Dependencies: 3275 3276 3277 3278 3279 8
-- Name: dbprocessos_academicos; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 269 (class 1259 OID 28203061)
-- Dependencies: 8
-- Name: dbprodutos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbprodutos_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 270 (class 1259 OID 28203063)
-- Dependencies: 3280 3281 3282 3283 3284 3285 3286 8
-- Name: dbprodutos; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 271 (class 1259 OID 28203076)
-- Dependencies: 8
-- Name: dbprodutos_caracteristicas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbprodutos_caracteristicas_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 272 (class 1259 OID 28203078)
-- Dependencies: 3287 3288 3289 3290 3291 8
-- Name: dbprodutos_caracteristicas; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 273 (class 1259 OID 28203089)
-- Dependencies: 8
-- Name: dbprodutos_financeiro_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbprodutos_financeiro_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 274 (class 1259 OID 28203091)
-- Dependencies: 8
-- Name: dbprodutos_formulacao_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbprodutos_formulacao_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 275 (class 1259 OID 28203093)
-- Dependencies: 8
-- Name: dbprodutos_midia_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbprodutos_midia_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 276 (class 1259 OID 28203095)
-- Dependencies: 8
-- Name: dbprodutos_parametros_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbprodutos_parametros_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 277 (class 1259 OID 28203097)
-- Dependencies: 3292 3293 3294 3295 3296 8
-- Name: dbprodutos_parametros; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 278 (class 1259 OID 28203108)
-- Dependencies: 8
-- Name: dbprodutos_tabelapreco_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbprodutos_tabelapreco_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 279 (class 1259 OID 28203110)
-- Dependencies: 3297 3298 3299 3300 3301 8
-- Name: dbprodutos_tabelapreco; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 280 (class 1259 OID 28203118)
-- Dependencies: 8
-- Name: dbprodutos_tipos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbprodutos_tipos_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 281 (class 1259 OID 28203120)
-- Dependencies: 3302 3303 3304 3305 3306 8
-- Name: dbprodutos_tipos; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 282 (class 1259 OID 28203131)
-- Dependencies: 8
-- Name: dbprodutos_tributos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbprodutos_tributos_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 283 (class 1259 OID 28203133)
-- Dependencies: 3307 3308 3309 3310 3311 8
-- Name: dbprodutos_tributos; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 284 (class 1259 OID 28203141)
-- Dependencies: 8
-- Name: dbprofessores_areas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbprofessores_areas_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 285 (class 1259 OID 28203143)
-- Dependencies: 3312 3313 3314 3315 3316 8
-- Name: dbprofessores_areas; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 286 (class 1259 OID 28203151)
-- Dependencies: 8
-- Name: dbprojetos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbprojetos_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 287 (class 1259 OID 28203153)
-- Dependencies: 3317 3318 3319 3320 3321 8
-- Name: dbprojetos; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 288 (class 1259 OID 28203164)
-- Dependencies: 8
-- Name: dbprojetos_colaboradores_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbprojetos_colaboradores_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 289 (class 1259 OID 28203166)
-- Dependencies: 3322 3323 3324 3325 3326 8
-- Name: dbprojetos_colaboradores; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 290 (class 1259 OID 28203174)
-- Dependencies: 8
-- Name: dbprojetos_custos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbprojetos_custos_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 291 (class 1259 OID 28203176)
-- Dependencies: 3327 3328 3329 3330 3331 8
-- Name: dbprojetos_custos; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 292 (class 1259 OID 28203184)
-- Dependencies: 8
-- Name: dbprojetos_recursos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbprojetos_recursos_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 293 (class 1259 OID 28203186)
-- Dependencies: 3332 3333 3334 3335 3336 8
-- Name: dbprojetos_recursos; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 294 (class 1259 OID 28203194)
-- Dependencies: 8
-- Name: dbquestionarios_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbquestionarios_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 295 (class 1259 OID 28203196)
-- Dependencies: 3337 3338 3339 3340 3341 8
-- Name: dbquestionarios; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 296 (class 1259 OID 28203207)
-- Dependencies: 8
-- Name: dbquestoes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbquestoes_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 297 (class 1259 OID 28203209)
-- Dependencies: 3342 3343 3344 3345 3346 8
-- Name: dbquestoes; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 298 (class 1259 OID 28203220)
-- Dependencies: 8
-- Name: dbquestoes_itens_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbquestoes_itens_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 299 (class 1259 OID 28203222)
-- Dependencies: 3347 3348 3349 3350 3351 8
-- Name: dbquestoes_itens; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 300 (class 1259 OID 28203233)
-- Dependencies: 8
-- Name: dbrecados_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbrecados_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 301 (class 1259 OID 28203235)
-- Dependencies: 3352 3353 3354 3355 3356 3357 8
-- Name: dbrecados; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 302 (class 1259 OID 28203247)
-- Dependencies: 8
-- Name: dbsalas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbsalas_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 303 (class 1259 OID 28203249)
-- Dependencies: 3358 3359 3360 3361 3362 3363 8
-- Name: dbsalas; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 304 (class 1259 OID 28203261)
-- Dependencies: 8
-- Name: dbscorecard_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbscorecard_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 305 (class 1259 OID 28203263)
-- Dependencies: 3364 3365 3366 3367 3368 8
-- Name: dbscorecard; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 306 (class 1259 OID 28203271)
-- Dependencies: 8
-- Name: dbscorecard_sentencas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbscorecard_sentencas_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 307 (class 1259 OID 28203273)
-- Dependencies: 3369 3370 3371 3372 3373 8
-- Name: dbscorecard_sentencas; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 309 (class 1259 OID 28203290)
-- Dependencies: 308 8
-- Name: dbstatus_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbstatus_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4250 (class 0 OID 0)
-- Dependencies: 309
-- Name: dbstatus_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dbstatus_id_seq OWNED BY dbstatus.id;


--
-- TOC entry 310 (class 1259 OID 28203292)
-- Dependencies: 8
-- Name: dbtransacoes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbtransacoes_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 311 (class 1259 OID 28203294)
-- Dependencies: 3375 3376 3377 3378 3379 3380 3381 3382 3383 3384 3385 3386 8
-- Name: dbtransacoes; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 312 (class 1259 OID 28203312)
-- Dependencies: 8
-- Name: dbtransacoes_contas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbtransacoes_contas_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 313 (class 1259 OID 28203314)
-- Dependencies: 3387 3388 3389 3390 3391 3392 3393 3394 8
-- Name: dbtransacoes_contas; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 4251 (class 0 OID 0)
-- Dependencies: 313
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
-- TOC entry 4252 (class 0 OID 0)
-- Dependencies: 313
-- Name: COLUMN dbtransacoes_contas.valorreal; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbtransacoes_contas.valorreal IS 'Valor real da conta, considerando pagamentos parciais da conta.';


--
-- TOC entry 314 (class 1259 OID 28203328)
-- Dependencies: 8
-- Name: dbtransacoes_contas_duplicatas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbtransacoes_contas_duplicatas_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 315 (class 1259 OID 28203330)
-- Dependencies: 3395 3396 3397 3398 3399 3400 3401 8
-- Name: dbtransacoes_contas_duplicatas; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 4253 (class 0 OID 0)
-- Dependencies: 315
-- Name: COLUMN dbtransacoes_contas_duplicatas.statusduplicata; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbtransacoes_contas_duplicatas.statusduplicata IS '1 => Ativa
2 => Baixada
9 => Inativo';


--
-- TOC entry 316 (class 1259 OID 28203343)
-- Dependencies: 8
-- Name: dbtransacoes_contas_extornos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbtransacoes_contas_extornos_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 317 (class 1259 OID 28203345)
-- Dependencies: 3402 3403 3404 3405 3406 3407 8
-- Name: dbtransacoes_contas_extornos; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 318 (class 1259 OID 28203354)
-- Dependencies: 3409 3410 3411 3412 8
-- Name: dbtransacoes_contas_situacao; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 319 (class 1259 OID 28203364)
-- Dependencies: 318 8
-- Name: dbtransacoes_contas_situacao_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbtransacoes_contas_situacao_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4254 (class 0 OID 0)
-- Dependencies: 319
-- Name: dbtransacoes_contas_situacao_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dbtransacoes_contas_situacao_id_seq OWNED BY dbtransacoes_contas_situacao.id;


--
-- TOC entry 320 (class 1259 OID 28203366)
-- Dependencies: 3414 3415 3416 3417 8
-- Name: dbtransacoes_convenios; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 321 (class 1259 OID 28203373)
-- Dependencies: 320 8
-- Name: dbtransacoes_convenios_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbtransacoes_convenios_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4255 (class 0 OID 0)
-- Dependencies: 321
-- Name: dbtransacoes_convenios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dbtransacoes_convenios_id_seq OWNED BY dbtransacoes_convenios.id;


--
-- TOC entry 322 (class 1259 OID 28203375)
-- Dependencies: 8
-- Name: dbtransacoes_produtos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbtransacoes_produtos_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 323 (class 1259 OID 28203377)
-- Dependencies: 3418 3419 3420 3421 3422 3423 3424 8
-- Name: dbtransacoes_produtos; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 324 (class 1259 OID 28203390)
-- Dependencies: 8
-- Name: dbtreinamentos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbtreinamentos_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 325 (class 1259 OID 28203392)
-- Dependencies: 3425 3426 3427 3428 3429 8
-- Name: dbtreinamentos; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 326 (class 1259 OID 28203403)
-- Dependencies: 8
-- Name: dbtributos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbtributos_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 327 (class 1259 OID 28203405)
-- Dependencies: 3430 3431 3432 3433 3434 8
-- Name: dbtributos; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 330 (class 1259 OID 28203449)
-- Dependencies: 3461 3462 3463 3464 8
-- Name: dbturmas_convenios; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 331 (class 1259 OID 28203456)
-- Dependencies: 330 8
-- Name: dbturmas_convenios_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbturmas_convenios_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4256 (class 0 OID 0)
-- Dependencies: 331
-- Name: dbturmas_convenios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dbturmas_convenios_id_seq OWNED BY dbturmas_convenios.id;


--
-- TOC entry 332 (class 1259 OID 28203458)
-- Dependencies: 8
-- Name: dbturmas_descontos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbturmas_descontos_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 333 (class 1259 OID 28203460)
-- Dependencies: 3465 3466 3467 3468 3469 8
-- Name: dbturmas_descontos; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 4257 (class 0 OID 0)
-- Dependencies: 333
-- Name: COLUMN dbturmas_descontos.tipodesconto; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbturmas_descontos.tipodesconto IS '1 = Desconto Percentual / 2 = Desconto Fixo';


--
-- TOC entry 334 (class 1259 OID 28203471)
-- Dependencies: 8
-- Name: dbturmas_disciplinas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbturmas_disciplinas_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 335 (class 1259 OID 28203473)
-- Dependencies: 3470 3471 3472 3473 3474 3475 3476 3477 3478 3479 3480 3481 8
-- Name: dbturmas_disciplinas; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 336 (class 1259 OID 28203491)
-- Dependencies: 8
-- Name: dbturmas_disciplinas_arquivos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbturmas_disciplinas_arquivos_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 337 (class 1259 OID 28203493)
-- Dependencies: 3482 3483 3484 3485 3486 3487 8
-- Name: dbturmas_disciplinas_arquivos; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 338 (class 1259 OID 28203505)
-- Dependencies: 8
-- Name: dbturmas_disciplinas_aulas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbturmas_disciplinas_aulas_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 339 (class 1259 OID 28203507)
-- Dependencies: 3488 3489 3490 3491 3492 3493 8
-- Name: dbturmas_disciplinas_aulas; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 340 (class 1259 OID 28203519)
-- Dependencies: 3495 3496 3497 3498 8
-- Name: dbturmas_disciplinas_avaliacao_detalhamento; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 341 (class 1259 OID 28203529)
-- Dependencies: 8 340
-- Name: dbturmas_disciplinas_avaliacao_detalhamento_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbturmas_disciplinas_avaliacao_detalhamento_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4258 (class 0 OID 0)
-- Dependencies: 341
-- Name: dbturmas_disciplinas_avaliacao_detalhamento_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dbturmas_disciplinas_avaliacao_detalhamento_id_seq OWNED BY dbturmas_disciplinas_avaliacao_detalhamento.id;


--
-- TOC entry 342 (class 1259 OID 28203531)
-- Dependencies: 8
-- Name: dbturmas_disciplinas_avaliacoes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbturmas_disciplinas_avaliacoes_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 343 (class 1259 OID 28203533)
-- Dependencies: 3499 3500 3501 3502 3503 8
-- Name: dbturmas_disciplinas_avaliacoes; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 344 (class 1259 OID 28203541)
-- Dependencies: 8
-- Name: dbturmas_disciplinas_materiais_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbturmas_disciplinas_materiais_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 345 (class 1259 OID 28203543)
-- Dependencies: 3504 3505 3506 3507 3508 3509 8
-- Name: dbturmas_disciplinas_materiais; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 346 (class 1259 OID 28203555)
-- Dependencies: 8
-- Name: dbturmas_disciplinas_planoaulas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbturmas_disciplinas_planoaulas_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 347 (class 1259 OID 28203557)
-- Dependencies: 3510 3511 3512 3513 3514 8
-- Name: dbturmas_disciplinas_planoaulas; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 348 (class 1259 OID 28203568)
-- Dependencies: 8
-- Name: dbturmas_requisitos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbturmas_requisitos_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 349 (class 1259 OID 28203570)
-- Dependencies: 3515 3516 3517 3518 3519 3520 8
-- Name: dbturmas_requisitos; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 352 (class 1259 OID 28203595)
-- Dependencies: 8
-- Name: dbunidades_parametros_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbunidades_parametros_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 353 (class 1259 OID 28203597)
-- Dependencies: 3526 3527 3528 3529 3530 8
-- Name: dbunidades_parametros; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 354 (class 1259 OID 28203608)
-- Dependencies: 8
-- Name: dbusuarios_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbusuarios_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 355 (class 1259 OID 28203610)
-- Dependencies: 3531 3532 3533 3534 3535 3536 3537 8
-- Name: dbusuarios; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 356 (class 1259 OID 28203623)
-- Dependencies: 8
-- Name: dbusuarios_erros_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbusuarios_erros_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 357 (class 1259 OID 28203625)
-- Dependencies: 3538 3539 3540 3541 3542 8
-- Name: dbusuarios_erros; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 358 (class 1259 OID 28203636)
-- Dependencies: 8
-- Name: dbusuarios_historico_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbusuarios_historico_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 359 (class 1259 OID 28203638)
-- Dependencies: 3543 3544 3545 3546 3547 8
-- Name: dbusuarios_historico; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 360 (class 1259 OID 28203649)
-- Dependencies: 8
-- Name: dbusuarios_privilegios_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbusuarios_privilegios_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 361 (class 1259 OID 28203651)
-- Dependencies: 3548 3549 3550 3551 3552 3553 3554 8
-- Name: dbusuarios_privilegios; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 4259 (class 0 OID 0)
-- Dependencies: 361
-- Name: COLUMN dbusuarios_privilegios.funcionalidade; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbusuarios_privilegios.funcionalidade IS 'Id da funcionalidade sobre a qual o privilegio se associa.
Caso a funcionalidade seja o modulo principal o valor padrão é [0]';


--
-- TOC entry 4260 (class 0 OID 0)
-- Dependencies: 361
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
-- TOC entry 362 (class 1259 OID 28203661)
-- Dependencies: 2825 8
-- Name: view_turmas_disciplinas; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_turmas_disciplinas AS
    SELECT t0.id, (t0.codigo)::text AS codigo, (t0.unidade)::text AS unidade, (t0.codigoturma)::text AS codigoturma, (t3.codigocurso)::text AS codigocurso, (t0.codigodisciplina)::text AS codigodisciplina, (t0.codigoprofessor)::text AS codigoprofessor, to_char((t0.datarealizacao)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datarealizacao, to_char((t0.dataatualizacao)::timestamp with time zone, 'DD/MM/YYYY'::text) AS dataatualizacao, (t0.frequencia)::text AS frequencia, t0.datas, (t0.custohoraaula)::text AS custohoraaula, (t0.regimetrabalho)::text AS regimetrabalho, (t0.custohospedagem)::text AS custohospedagem, (t0.custodeslocamento)::text AS custodeslocamento, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t6.nome)::text AS sala, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t2.nome)::text AS nomecurso, (t3.titulo)::text AS nometurma, (t4.titulo)::text AS nomedisciplina, (t4.cargahoraria)::text AS cargahoraria, (t5.nome_razaosocial)::text AS nomeprofessor, ((SELECT count(dbalunos_disciplinas.codigo) AS count FROM dbalunos_disciplinas WHERE (((dbalunos_disciplinas.codigoturmadisciplina)::text = (t0.codigo)::text) AND ((dbalunos_disciplinas.situacao)::text = '2'::text))))::text AS alunos, (t0.codigosala)::text AS codigosala, (t3.codigograde)::text AS codigograde, t3.status, t0.custoalimentacao, t0.custoextra FROM ((((((dbturmas_disciplinas t0 LEFT JOIN dbturmas t3 ON (((t3.codigo)::text = (t0.codigoturma)::text))) LEFT JOIN dbcursos t2 ON (((t2.codigo)::text = (t3.codigocurso)::text))) LEFT JOIN dbdisciplinas t4 ON (((t4.codigo)::text = (t0.codigodisciplina)::text))) LEFT JOIN dbpessoas t5 ON (((t5.codigo)::text = ((SELECT t8.codigopessoa FROM dbpessoas_funcionarios t8 WHERE ((t8.codigo)::text = ((SELECT t9.codigofuncionario FROM dbfuncionarios_professores t9 WHERE ((t9.codigo)::text = (t0.codigoprofessor)::text)))::text)))::text))) LEFT JOIN dbsalas t6 ON (((t6.codigo)::text = (t0.codigosala)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t0.ativo)::text)));


--
-- TOC entry 363 (class 1259 OID 28203666)
-- Dependencies: 2826 8
-- Name: view_alunos_disciplinas; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_alunos_disciplinas AS
    SELECT t0.id, (t0.codigo)::text AS codigo, (t0.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, (t0.codigoaluno)::text AS codigoaluno, (t0.codigodisciplina)::text AS codigodisciplina, (t0.codigoturmadisciplina)::text AS codigoturmadisciplina, (t0.situacao)::text AS situacao, t0.obs, (t3.nome_razaosocial)::text AS nomepessoa, t4.nometurma, (t5.titulo)::text AS nomedisciplina, t4.codigocurso, t4.codigoturma, t4.nomecurso, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, t4.codigograde FROM (((((dbalunos_disciplinas t0 LEFT JOIN dbpessoas_alunos t2 ON (((t2.codigo)::text = (t0.codigoaluno)::text))) LEFT JOIN dbpessoas t3 ON (((t3.codigo)::text = (t2.codigopessoa)::text))) LEFT JOIN view_turmas_disciplinas t4 ON ((t4.codigo = (t0.codigoturmadisciplina)::text))) LEFT JOIN dbdisciplinas t5 ON (((t5.codigo)::text = (t0.codigodisciplina)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t0.ativo)::text)));


--
-- TOC entry 364 (class 1259 OID 28203671)
-- Dependencies: 2827 8
-- Name: view_alunos_faltas; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_alunos_faltas AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigoaluno)::text AS codigoaluno, (t1.codigoturmadisciplina)::text AS codigoturmadisciplina, (t1.codigoaula)::text AS codigoaula, to_char((t1.datafalta)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datafalta, (t1.numaula)::text AS numaula, t1.justificativa, t1.obs, (t1.situacao)::text AS situacao, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, t2.titulo AS nomedisciplina FROM ((dbalunos_faltas t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text))) LEFT JOIN dbdisciplinas t2 ON (((t2.codigo)::text = ((SELECT t90.codigodisciplina FROM dbturmas_disciplinas t90 WHERE ((t90.codigo)::text = (t1.codigoturmadisciplina)::text)))::text)));


--
-- TOC entry 365 (class 1259 OID 28203676)
-- Dependencies: 2828 8
-- Name: view_alunos_notas; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_alunos_notas AS
    SELECT t0.id, (t0.codigo)::text AS codigo, (t0.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, (t0.codigoaluno)::text AS codigoaluno, (t0.codigoturmadisciplina)::text AS codigoturmadisciplina, (t0.codigoavaliacao)::text AS codigoavaliacao, (t0.nota)::text AS nota, (t0.ordemavaliacao)::text AS ordemavaliacao, (t3.nome_razaosocial)::text AS nomepessoa, t4.nometurma, t4.nomedisciplina, t4.codigocurso, t4.codigoturma, t4.nomecurso, t6.avaliacao, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, t4.codigograde FROM (((((dbalunos_notas t0 LEFT JOIN dbpessoas_alunos t2 ON (((t2.codigo)::text = (t0.codigoaluno)::text))) LEFT JOIN dbpessoas t3 ON (((t3.codigo)::text = (t2.codigopessoa)::text))) LEFT JOIN view_turmas_disciplinas t4 ON ((t4.codigo = (t0.codigoturmadisciplina)::text))) LEFT JOIN dbavaliacoes t6 ON (((t6.codigo)::text = (t0.codigoavaliacao)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t0.ativo)::text)));


--
-- TOC entry 366 (class 1259 OID 28203681)
-- Dependencies: 2829 8
-- Name: view_alunos_solicitacoes; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_alunos_solicitacoes AS
    SELECT t0.id, (t0.codigo)::text AS codigo, (t0.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, (t0.codigoaluno)::text AS codigoaluno, (t0.codigosolicitacao)::text AS codigosolicitacao, (t0.data)::text AS data, t0.justificativa, t0.atendimento, (t0.codigofuncionario)::text AS codigofuncionario, (t0.codigodepartamento)::text AS codigodepartamento, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t0.status)::text AS status, (t4.nome_razaosocial)::text AS nomealuno, (t3.nome_razaosocial)::text AS nomefuncionario, (t5.label)::text AS nomedepartamento, (t6.titulo)::text AS solicitacao FROM ((((((dbalunos_solicitacoes t0 LEFT JOIN dbpessoas_alunos t2 ON (((t2.codigo)::text = (t0.codigoaluno)::text))) LEFT JOIN dbpessoas t4 ON (((t4.codigo)::text = (t2.codigopessoa)::text))) LEFT JOIN dbpessoas t3 ON (((t3.codigo)::text = ((SELECT t5.codigopessoa FROM dbpessoas_funcionarios t5 WHERE ((t5.codigo)::text = (t0.codigofuncionario)::text)))::text))) LEFT JOIN dbprocessos_academicos t6 ON (((t6.codigo)::text = (t0.codigosolicitacao)::text))) LEFT JOIN dbdepartamentos t5 ON (((t5.codigo)::text = (t0.codigodepartamento)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t0.ativo)::text)));


--
-- TOC entry 367 (class 1259 OID 28203686)
-- Dependencies: 2830 8
-- Name: view_biblioteca_cdu; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_biblioteca_cdu AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.cdu)::text AS cdu, (t1.titulo)::text AS titulo, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbbiblioteca_cdu t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 368 (class 1259 OID 28203690)
-- Dependencies: 2831 8
-- Name: view_caixa; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_caixa AS
    SELECT t0.id, (t0.codigo)::text AS codigo, (t0.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, (t0.codigoconta)::text AS codigoconta, (t0.codigoplanoconta)::text AS codigoplanoconta, (t0.codigocontacaixa)::text AS codigocontacaixa, (t5.nomeconta)::text AS nomeconta, (t0.codigopessoa)::text AS codigopessoa, (t0.codigotransacao)::text AS codigotransacao, (t0.numdoc)::text AS numdoc, to_char((t0.datadocumento)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datadocumento, (t0.tipomovimentacao)::text AS tipomovimentacao, (t0.tipoduplicata)::text AS tipoduplicata, (t0.valorreal)::text AS valorreal, to_char((t0.vencimento)::timestamp with time zone, 'DD/MM/YYYY'::text) AS vencimento, (t0.formadesconto)::text AS formadesconto, (t0.desconto)::text AS desconto, (t0.multaacrecimo)::text AS multaacrecimo, (t0.valorpago)::text AS valorpago, (t0.valorentrada)::text AS valorentrada, (t0.codigofuncionario)::text AS codigofuncionario, (t0.datapag)::text AS datapag, (t0.formapag)::text AS formapag, (t0.mora)::text AS mora, t0.obs, (t0.statusmovimento)::text AS statusmovimento, (t0.statusconta)::text AS statusconta, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t2.nomeconta)::text AS nomeplanoconta, (t3.nome_razaosocial)::text AS nomepessoa, (t0.codigohistorico)::text AS codigohistorico FROM ((((dbcaixa t0 LEFT JOIN dbcontas_caixa t5 ON (((t5.codigo)::text = (t0.codigocontacaixa)::text))) LEFT JOIN dbplano_contas t2 ON (((t2.codigo)::text = (t0.codigoplanoconta)::text))) LEFT JOIN dbpessoas t3 ON (((t3.codigo)::text = (t0.codigopessoa)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t0.ativo)::text)));


--
-- TOC entry 369 (class 1259 OID 28203695)
-- Dependencies: 2832 8
-- Name: view_caixa_fechamentos; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_caixa_fechamentos AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.valorprevisto)::text AS valorprevisto, (t1.receitatotal)::text AS receitatotal, (t1.despesatotal)::text AS despesatotal, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbcaixa_fechamentos t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 370 (class 1259 OID 28203699)
-- Dependencies: 2833 8
-- Name: view_pessoas_funcionarios; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_pessoas_funcionarios AS
    SELECT t0.id, (t2.codigo)::text AS codigofuncionario, (t0.unidade)::text AS unidade, (t0.codigo)::text AS codigo, (t0.nome_razaosocial)::text AS nomefuncionario, (t0.cpf_cnpj)::text AS cpf_cnpj, (t2.codigocargo)::text AS codigocargo, (t3.nomecargo)::text AS nomecargo, (t2.codigodepartamento)::text AS codigodepartamento, (t4.label)::text AS nomedepartamento, (t2.lotacao)::text AS lotacao, (t5.nome)::text AS nomesala, to_char((t2.dataadmissao)::timestamp with time zone, 'DD/MM/YYYY'::text) AS dataadmissao, (t2.ativo)::text AS situacao, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (((((dbpessoas t0 LEFT JOIN dbpessoas_funcionarios t2 ON (((t2.codigopessoa)::text = (t0.codigo)::text))) LEFT JOIN dbcargos t3 ON (((t3.codigo)::text = (t2.codigocargo)::text))) LEFT JOIN dbdepartamentos t4 ON (((t4.codigo)::text = (t2.codigodepartamento)::text))) LEFT JOIN dbsalas t5 ON (((t5.codigo)::text = (t2.lotacao)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t0.ativo)::text))) WHERE ((t0.codigo)::text = (t2.codigopessoa)::text);


--
-- TOC entry 371 (class 1259 OID 28203704)
-- Dependencies: 2834 8
-- Name: view_caixa_funcionarios; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_caixa_funcionarios AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigofuncionario)::text AS codigofuncionario, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, t1.obs, t2.nomefuncionario, t2.cpf_cnpj, t2.codigocargo, t2.nomecargo, (t1.situacao)::text AS situacao, (t1.codigocontacaixa)::text AS codigocontacaixa, (((t3.tipoconta)::text || ' - '::text) || (t3.nomeconta)::text) AS nomecontacaixa FROM (((dbcaixa_funcionarios t1 LEFT JOIN view_pessoas_funcionarios t2 ON ((t2.codigofuncionario = (t1.codigofuncionario)::text))) LEFT JOIN dbcontas_caixa t3 ON (((t3.codigo)::text = (t1.codigocontacaixa)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 372 (class 1259 OID 28203709)
-- Dependencies: 2835 8
-- Name: view_cargos; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_cargos AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.nomecargo)::text AS nomecargo, t1.descricao, t1.conhecimentos, t1.habilidades, t1.atitudes, t1.prerequisitos, (t1.cargahoraria)::text AS cargahoraria, (t1.horariotrabalho)::text AS horariotrabalho, t1.maquinasutilizadas, (t1.graurisco)::text AS graurisco, (t1.subordinado)::text AS subordinado, t1.cargoascendente, t1.cargodescendente, (t1.salariobase)::text AS salariobase, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbcargos t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 373 (class 1259 OID 28203714)
-- Dependencies: 2836 8
-- Name: view_compras; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_compras AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigoproduto)::text AS codigoproduto, (t1.valorunitario)::text AS valorunitario, (t1.tempoentrega)::text AS tempoentrega, (t1.quantidade)::text AS quantidade, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbcompras t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 374 (class 1259 OID 28203718)
-- Dependencies: 2837 8
-- Name: view_contas_caixa; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_contas_caixa AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.nomeconta)::text AS nomeconta, (t1.tipoconta)::text AS tipoconta, (t1.banco)::text AS banco, (t1.numconta)::text AS numconta, (t1.agencia)::text AS agencia, (t1.saldoinicial)::text AS saldoinicial, ((SELECT sum(dbcaixa.valorpago) AS sum FROM dbcaixa WHERE (((dbcaixa.codigocontacaixa)::text = (t1.codigo)::text) AND ((dbcaixa.tipomovimentacao)::text = 'C'::text))))::text AS entrada, ((SELECT sum(dbcaixa.valorpago) AS sum FROM dbcaixa WHERE (((dbcaixa.codigocontacaixa)::text = (t1.codigo)::text) AND ((dbcaixa.tipomovimentacao)::text = 'D'::text))))::text AS saida, (((t1.saldoinicial)::double precision + ((SELECT sum(temp1.valorpago) AS sum FROM dbcaixa temp1 WHERE (((temp1.codigocontacaixa)::text = (t1.codigo)::text) AND ((temp1.tipomovimentacao)::text = 'C'::text))))::double precision))::text AS saldo, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbcontas_caixa t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 375 (class 1259 OID 28203723)
-- Dependencies: 2838 8
-- Name: view_contas_caixa_historico; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_contas_caixa_historico AS
    SELECT t1.id, (t2.codigo)::text AS codigo, (t2.unidade)::text AS unidade, (t2.codigoautor)::text AS codigoautor, (t2.codigocontacaixa)::text AS codigocontacaixa, (t1.nomeconta)::text AS nomeconta, (t1.tipoconta)::text AS tipoconta, (t1.banco)::text AS banco, (t1.numconta)::text AS numconta, (t1.agencia)::text AS agencia, ((SELECT sum(dbcaixa.valorpago) AS sum FROM dbcaixa WHERE ((((dbcaixa.codigohistorico)::text = (t2.codigo)::text) AND ((dbcaixa.tipomovimentacao)::text = 'C'::text)) AND ((dbcaixa.formapag)::text = 'Dinheiro'::text))))::text AS entrada_dinheiro, ((SELECT sum(dbcaixa.valorpago) AS sum FROM dbcaixa WHERE ((((dbcaixa.codigohistorico)::text = (t2.codigo)::text) AND ((dbcaixa.tipomovimentacao)::text = 'D'::text)) AND ((dbcaixa.formapag)::text = 'Dinheiro'::text))))::text AS saida_dinheiro, ((SELECT sum(dbcaixa.valorpago) AS sum FROM dbcaixa WHERE ((((dbcaixa.codigohistorico)::text = (t2.codigo)::text) AND ((dbcaixa.tipomovimentacao)::text = 'C'::text)) AND ((dbcaixa.formapag)::text = 'Cheque'::text))))::text AS entrada_cheque, ((SELECT sum(dbcaixa.valorpago) AS sum FROM dbcaixa WHERE ((((dbcaixa.codigohistorico)::text = (t2.codigo)::text) AND ((dbcaixa.tipomovimentacao)::text = 'D'::text)) AND ((dbcaixa.formapag)::text = 'Cheque'::text))))::text AS saida_cheque, ((SELECT sum(dbcaixa.valorpago) AS sum FROM dbcaixa WHERE ((((dbcaixa.codigohistorico)::text = (t2.codigo)::text) AND ((dbcaixa.tipomovimentacao)::text = 'C'::text)) AND ((dbcaixa.formapag)::text = 'Cartão'::text))))::text AS entrada_cartao, ((SELECT sum(dbcaixa.valorpago) AS sum FROM dbcaixa WHERE ((((dbcaixa.codigohistorico)::text = (t2.codigo)::text) AND ((dbcaixa.tipomovimentacao)::text = 'D'::text)) AND ((dbcaixa.formapag)::text = 'Cartão'::text))))::text AS saida_cartao, to_char((t2.datainicio)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datainicio, to_char((t2.datafim)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datafim, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM ((dbcontas_caixa_historico t2 LEFT JOIN dbcontas_caixa t1 ON (((t1.codigo)::text = (t2.codigocontacaixa)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t2.ativo)::text))) WHERE ((t2.ativo)::text = '1'::text);


--
-- TOC entry 376 (class 1259 OID 28203728)
-- Dependencies: 2839 8
-- Name: view_contas_cheques; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_contas_cheques AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigopessoa)::text AS codigopessoa, (t1.nometitular)::text AS nometitular, (t1.banco)::text AS banco, (t1.agencia)::text AS agencia, (t1.numconta)::text AS numconta, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, t1.obs, (t1.codigocaixa)::text AS codigocaixa, (t1.codigoconta)::text AS codigoconta, (t1.numcheque)::text AS numcheque, (t1.valor)::text AS valor, (t1.cpf_cnpj)::text AS cpf_cnpj FROM (dbcontas_cheques t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 377 (class 1259 OID 28203732)
-- Dependencies: 2840 8
-- Name: view_contratos; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_contratos AS
    SELECT t0.id, (t0.codigo)::text AS codigo, (t0.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, (t0.codigopessoa)::text AS codigopessoa, (t0.tipodocumento)::text AS tipodocumento, to_char((t0.dataassinatura)::timestamp with time zone, 'DD/MM/YYYY'::text) AS dataassinatura, to_char((t0.datatermino)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datatermino, t0.arquivo, (t0.codigoproduto)::text AS codigoproduto, (t0.tipoassinatura)::text AS tipoassinatura, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t2.nome_razaosocial)::text AS nomepessoa, (t3.titulo)::text AS nomedocumento, (t4.label)::text AS nomeproduto FROM ((((dbcontratos t0 LEFT JOIN dbpessoas t2 ON (((t2.codigo)::text = (t0.codigopessoa)::text))) LEFT JOIN dbdocumentos t3 ON (((t3.codigo)::text = (t0.tipodocumento)::text))) LEFT JOIN dbprodutos t4 ON (((t4.codigo)::text = (t0.codigoproduto)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t0.ativo)::text)));


--
-- TOC entry 378 (class 1259 OID 28203737)
-- Dependencies: 2841 8
-- Name: view_convenios; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_convenios AS
    SELECT t0.id, (t0.codigo)::text AS codigo, (t0.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, (t0.codigopessoa)::text AS codigopessoa, (t0.titulo)::text AS titulo, t0.descricao, (t0.tipoconvenio)::text AS tipoconvenio, (t0.tipotransacao)::text AS tipotransacao, (t0.datavigencia)::text AS datavigencia, t0.codigoplanoconta, t3.nomeconta AS nomeplanoconta, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t1.nome_razaosocial)::text AS concedente FROM (((dbconvenios t0 LEFT JOIN dbplano_contas t3 ON (((t3.codigo)::text = (t0.codigoplanoconta)::text))) LEFT JOIN dbpessoas t1 ON (((t1.codigo)::text = (t0.codigopessoa)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 379 (class 1259 OID 28203742)
-- Dependencies: 2842 8
-- Name: view_cotacoes; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_cotacoes AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigoproduto)::text AS codigoproduto, (t1.codigofornecedor)::text AS codigofornecedor, (t1.preco)::text AS preco, (t1.entrega)::text AS entrega, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbcotacoes t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 380 (class 1259 OID 28203746)
-- Dependencies: 2843 8
-- Name: view_curriculos; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_curriculos AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.nome)::text AS nome, (t1.sexo)::text AS sexo, (t1.datanasc)::text AS datanasc, (t1.cpf)::text AS cpf, (t1.logadouro)::text AS logadouro, (t1.cidade)::text AS cidade, (t1.estado)::text AS estado, (t1.bairro)::text AS bairro, (t1.telefone)::text AS telefone, (t1.celular)::text AS celular, (t1.email)::text AS email, (t1.estadocivil)::text AS estadocivil, (t1.cnh)::text AS cnh, (t1.dependentes)::text AS dependentes, t1.idiomas, (t1.areainteresse)::text AS areainteresse, (t1.areainteresse2)::text AS areainteresse2, (t1.areainteresse3)::text AS areainteresse3, (t1.escolaridade)::text AS escolaridade, t1.cursos, t1.experiencia, t1.obs, t1.resumo, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbcurriculos t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 381 (class 1259 OID 28203751)
-- Dependencies: 2844 8
-- Name: view_cursos; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_cursos AS
    SELECT t0.id, (t0.codigo)::text AS codigo, (t0.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, (t0.nome)::text AS nome, (t0.codigotipocurso)::text AS codigotipocurso, (t0.codigoareacurso)::text AS codigoareacurso, t0.objetivocurso, t0.publicoalvo, (t0.cargahortotal)::text AS cargahortotal, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t2.titulo)::text AS areacurso, ((SELECT sum(t4.cargahoraria) AS sum FROM dbdisciplinas t4 WHERE ((t4.codigo)::text IN (SELECT t5.codigodisciplina FROM dbcursos_disciplinas t5 WHERE ((t5.codigocurso)::text = (t0.codigo)::text)))))::text AS cargahoraria, (t3.titulo)::text AS tipocurso, ((SELECT count(t5.codigocurso) AS count FROM dbturmas t5 WHERE ((t5.codigocurso)::text = (t0.codigo)::text)))::text AS turmas, (t0.codigograde)::text AS codigograde FROM (((dbcursos t0 LEFT JOIN dbcursos_areas t2 ON (((t2.codigo)::text = (t0.codigoareacurso)::text))) LEFT JOIN dbcursos_tipos t3 ON (((t3.codigo)::text = (t0.codigotipocurso)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t0.ativo)::text)));


--
-- TOC entry 382 (class 1259 OID 28203756)
-- Dependencies: 2845 8
-- Name: view_cursos_areas; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_cursos_areas AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.titulo)::text AS titulo, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbcursos_areas t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 383 (class 1259 OID 28203760)
-- Dependencies: 2846 8
-- Name: view_cursos_ativos; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_cursos_ativos AS
    SELECT t4.id, (t4.codigo)::text AS codigo, (t4.unidade)::text AS unidade, (t4.codigoautor)::text AS codigoautor, (t4.titulo)::text AS titulo, (t4.codigocurso)::text AS codigocurso, t4.obs, to_char((t4.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t0.nome)::text AS nome, (t0.codigotipocurso)::text AS codigotipocurso, (t0.codigoareacurso)::text AS codigoareacurso, t0.objetivocurso, t0.publicoalvo, (t0.cargahortotal)::text AS cargahortotal, (t2.titulo)::text AS areacurso, (t3.titulo)::text AS tipocurso FROM ((((dbcursos_ativos t4 LEFT JOIN dbcursos t0 ON (((t0.codigo)::text = (t4.codigocurso)::text))) LEFT JOIN dbcursos_areas t2 ON (((t2.codigo)::text = (t0.codigoareacurso)::text))) LEFT JOIN dbcursos_tipos t3 ON (((t3.codigo)::text = (t0.codigotipocurso)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t4.ativo)::text)));


--
-- TOC entry 384 (class 1259 OID 28203765)
-- Dependencies: 2847 8
-- Name: view_cursos_disciplinas; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_cursos_disciplinas AS
    SELECT t0.id, (t0.codigo)::text AS codigo, (t0.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, (t0.codigocurso)::text AS codigocurso, (t0.codigodisciplina)::text AS codigodisciplina, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t2.nome)::text AS nomecurso, (t3.titulo)::text AS nomedisciplina, (t3.cargahoraria)::text AS cargahoraria FROM (((dbcursos_disciplinas t0 LEFT JOIN dbcursos t2 ON (((t2.codigo)::text = (t0.codigocurso)::text))) LEFT JOIN dbdisciplinas t3 ON (((t3.codigo)::text = (t0.codigodisciplina)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t0.ativo)::text)));


--
-- TOC entry 385 (class 1259 OID 28203770)
-- Dependencies: 2848 8
-- Name: view_cursos_tipos; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_cursos_tipos AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.titulo)::text AS titulo, t1.obs, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbcursos_tipos t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 386 (class 1259 OID 28203774)
-- Dependencies: 2849 8
-- Name: view_departamentos; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_departamentos AS
    SELECT t0.id, (t0.codigo)::text AS codigo, (t0.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, (t0.label)::text AS label, (t0.codigoresponsavel)::text AS codigoresponsavel, (t0.codigosala)::text AS codigosala, t0.obs, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t2.nome_razaosocial)::text AS nomeresponsavel, (t3.nome)::text AS nomesala FROM (((dbdepartamentos t0 LEFT JOIN dbpessoas t2 ON (((t2.codigo)::text = (t0.codigoresponsavel)::text))) LEFT JOIN dbsalas t3 ON (((t3.codigo)::text = (t0.codigosala)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t0.ativo)::text)));


--
-- TOC entry 387 (class 1259 OID 28203779)
-- Dependencies: 2850 8
-- Name: view_disciplinas; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_disciplinas AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.titulo)::text AS titulo, t1.ementa, t1.programa, t1.competencias, (t1.cargahoraria)::text AS cargahoraria, t1.biografia, t1.metodologia, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbdisciplinas t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 388 (class 1259 OID 28203783)
-- Dependencies: 2851 8
-- Name: view_disciplinas_semelhantes; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_disciplinas_semelhantes AS
    SELECT t0.id, (t0.codigo)::text AS codigo, (t0.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, (t0.codigodisciplina)::text AS codigodisciplina, (t0.codigodisciplinasemelhante)::text AS codigodisciplinasemelhante, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t3.titulo)::text AS nomedisciplina, (t3.cargahoraria)::text AS cargahoraria, (t4.titulo)::text AS nomedisciplinasemelhante, (t4.cargahoraria)::text AS cargahorariasemelhante FROM (((dbdisciplinas_semelhantes t0 LEFT JOIN dbdisciplinas t3 ON (((t3.codigo)::text = (t0.codigodisciplina)::text))) LEFT JOIN dbdisciplinas t4 ON (((t3.codigo)::text = (t0.codigodisciplinasemelhante)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t0.ativo)::text)));


--
-- TOC entry 389 (class 1259 OID 28203788)
-- Dependencies: 2852 8
-- Name: view_funcionarios_ferias; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_funcionarios_ferias AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigofuncionario)::text AS codigofuncionario, (t1.dataferiasprevisao)::text AS dataferiasprevisao, (t1.diasferiasprevisao)::text AS diasferiasprevisao, (t1.retornoferiasprevisao)::text AS retornoferiasprevisao, (t1.dataferiasreal)::text AS dataferiasreal, (t1.diasferiasreal)::text AS diasferiasreal, (t1.retornoferiasreal)::text AS retornoferiasreal, (t1.datalimite)::text AS datalimite, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbfuncionarios_ferias t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 390 (class 1259 OID 28203792)
-- Dependencies: 2853 8
-- Name: view_funcionarios_folhapagamento; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_funcionarios_folhapagamento AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigofuncionario)::text AS codigofuncionario, (t1.nomecargo)::text AS nomecargo, (t1.codcontadebito)::text AS codcontadebito, (t1.referencia)::text AS referencia, (t1.salariobase)::text AS salariobase, (t1.comissao)::text AS comissao, (t1.salariofamilia)::text AS salariofamilia, (t1.adpericulosidade)::text AS adpericulosidade, (t1.adsalubridade)::text AS adsalubridade, (t1.horaextra)::text AS horaextra, (t1.ferias)::text AS ferias, (t1.decimoterceiro)::text AS decimoterceiro, (t1.licensamaternidade)::text AS licensamaternidade, (t1.licensapaternidade)::text AS licensapaternidade, (t1.licensacasamento)::text AS licensacasamento, (t1.licensaobito)::text AS licensaobito, (t1.licensainvalidez)::text AS licensainvalidez, (t1.valetransporte)::text AS valetransporte, (t1.irpf)::text AS irpf, (t1.inss)::text AS inss, (t1.contrsindical)::text AS contrsindical, (t1.totalbruto)::text AS totalbruto, (t1.totalliquido)::text AS totalliquido, (t1.diastrabalhados)::text AS diastrabalhados, (t1.vencimento)::text AS vencimento, (t1.datapag)::text AS datapag, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbfuncionarios_folhapagamento t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 391 (class 1259 OID 28203797)
-- Dependencies: 2854 8
-- Name: view_funcionarios_ocorrencias; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_funcionarios_ocorrencias AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigofuncionario)::text AS codigofuncionario, (t1.titulo)::text AS titulo, t1.descricao, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbfuncionarios_ocorrencias t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 392 (class 1259 OID 28203801)
-- Dependencies: 2855 8
-- Name: view_funcionarios_professores; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_funcionarios_professores AS
    SELECT t0.id, (t0.codigo)::text AS codigo, (t0.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, (t0.codigofuncionario)::text AS codigofuncionario, t0.curriculo, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t3.nome_razaosocial)::text AS nomeprofessor, (t3.codigo)::text AS codigopessoa, ((SELECT t4.titularidade FROM dbpessoas_titularidades t4 WHERE ((t4.peso)::text = (SELECT max((t6.peso)::text) AS max FROM dbpessoas_titularidades t6 WHERE ((t6.codigo)::text IN (SELECT t5.codigotitularidade FROM dbpessoas_formacoes t5 WHERE ((t5.codigopessoa)::text = (t2.codigopessoa)::text)))))))::text AS titularidade, ((SELECT t4.nomeacao FROM dbpessoas_titularidades t4 WHERE ((t4.peso)::text = (SELECT max((t6.peso)::text) AS max FROM dbpessoas_titularidades t6 WHERE ((t6.codigo)::text IN (SELECT t5.codigotitularidade FROM dbpessoas_formacoes t5 WHERE ((t5.codigopessoa)::text = (t2.codigopessoa)::text)))))))::text AS nomeacao FROM (((dbfuncionarios_professores t0 LEFT JOIN dbpessoas_funcionarios t2 ON (((t2.codigo)::text = (t0.codigofuncionario)::text))) LEFT JOIN dbpessoas t3 ON (((t3.codigo)::text = (t2.codigopessoa)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t0.ativo)::text)));


--
-- TOC entry 393 (class 1259 OID 28203806)
-- Dependencies: 2856 8
-- Name: view_funcionarios_treinamentos; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_funcionarios_treinamentos AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigotreinamento)::text AS codigotreinamento, (t1.codigofuncionario)::text AS codigofuncionario, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbfuncionarios_treinamentos t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 394 (class 1259 OID 28203810)
-- Dependencies: 2857 8
-- Name: view_patrimonios; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_patrimonios AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigofuncionario)::text AS codigofuncionario, (t1.codigoproduto)::text AS codigoproduto, (t1.modelo)::text AS modelo, (t1.marca)::text AS marca, (t1.label)::text AS label, (t1.descricao)::text AS descricao, (t1.tipo)::text AS tipo, (t1.datafabricacao)::text AS datafabricacao, (t1.dataaquisicao)::text AS dataaquisicao, (t1.valornominal)::text AS valornominal, (t1.lotacao)::text AS lotacao, (t1.valorcompra)::text AS valorcompra, (t1.numnf)::text AS numnf, (t1.dataverificacao)::text AS dataverificacao, (t1.foto)::text AS foto, t1.obs, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t2.nomeunidade)::text AS nomeunidade, (t3.nome)::text AS nomesala FROM (((dbpatrimonios t1 LEFT JOIN dbunidades t2 ON (((t2.codigo)::text = (t1.unidade)::text))) LEFT JOIN dbsalas t3 ON (((t3.codigo)::text = (t1.lotacao)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 395 (class 1259 OID 28203815)
-- Dependencies: 2858 8
-- Name: view_patrimonios_livros; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_patrimonios_livros AS
    SELECT t0.id, (t0.codigo)::text AS codigolivro, (t0.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, (t0.codigopatrimonio)::text AS codigopatrimonio, (t0.codigopatrimonio)::text AS codigo, (t0.autor)::text AS autor, t0.outrosautores, (t0.ano)::text AS ano, (t0.isbn)::text AS isbn, (t0.idioma)::text AS idioma, (t0.paginas)::text AS paginas, (t1.modelo)::text AS edicao, (t1.marca)::text AS editora, (t1.label)::text AS titulo, (t2.cdu)::text AS cdu, (t2.titulo)::text AS titulocdu, (t0.codigopha)::text AS codigopha, (t0.codigocdu)::text AS codigocdu, (t0.tradutor)::text AS tradutor, t0.sinopse, (t0.volume)::text AS volume, t0.sumario, (t1.foto)::text AS foto, ((SELECT count(t3.codigo) AS count FROM dbpessoas_livros t3 WHERE (((t3.codigolivro)::text = (t0.codigo)::text) AND ((t3.situacao)::text = '3'::text))))::text AS locacoes, ((SELECT count(t3.codigo) AS count FROM dbpessoas_livros t3 WHERE (((t3.codigolivro)::text = (t0.codigo)::text) AND ((t3.situacao)::text = '2'::text))))::text AS reservas, ((SELECT t3.codigopessoa FROM dbpessoas_livros t3 WHERE (((t3.codigolivro)::text = (t0.codigo)::text) AND ((t3.situacao)::text = '1'::text))))::text AS codigolocador, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t0.exemplar)::text AS exemplar FROM (((dbpatrimonios_livros t0 LEFT JOIN dbpatrimonios t1 ON (((t1.codigo)::text = (t0.codigopatrimonio)::text))) LEFT JOIN dbbiblioteca_cdu t2 ON (((t2.codigo)::text = (t0.codigocdu)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 396 (class 1259 OID 28203820)
-- Dependencies: 2859 8
-- Name: view_pessoas; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_pessoas AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.tipo)::text AS tipo, (t1.nome_razaosocial)::text AS nome_razaosocial, (t1.cpf_cnpj)::text AS cpf_cnpj, (t1.rg_inscest)::text AS rg_inscest, (t1.titeleitor_inscmun)::text AS titeleitor_inscmun, t1.logradouro, (t1.bairro)::text AS bairro, (t1.cidade)::text AS cidade, (t1.estado)::text AS estado, (t1.cep)::text AS cep, (t1.caixapostal)::text AS caixapostal, (t1.referencia)::text AS referencia, (t1.tel1)::text AS tel1, (t1.tel2)::text AS tel2, (t1.cel1)::text AS cel1, (t1.cel2)::text AS cel2, (t1.email1)::text AS email1, (t1.email2)::text AS email2, (t1.site)::text AS site, (t1.opcobranca)::text AS opcobranca, (t1.cliente)::text AS cliente, (t1.fornecedor)::text AS fornecedor, (t1.funcionario)::text AS funcionario, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbpessoas t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 397 (class 1259 OID 28203825)
-- Dependencies: 2860 8
-- Name: view_pessoas_alunos; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_pessoas_alunos AS
    SELECT t0.id, (t0.codigo)::text AS codigo, (t0.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, (t0.codigopessoa)::text AS codigopessoa, (t0.codigotransacao)::text AS codigotransacao, (t0.codigoturma)::text AS codigoturma, (t0.codigocurso)::text AS codigocurso, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t2.titulo)::text AS nometurma, (t3.nomeunidade)::text AS nomeunidade, (t6.nome_razaosocial)::text AS nomepessoa, (t4.nome)::text AS nomecurso FROM (((((dbpessoas_alunos t0 LEFT JOIN dbturmas t2 ON (((t2.codigo)::text = (t0.codigoturma)::text))) LEFT JOIN dbunidades t3 ON (((t3.codigo)::text = (t0.unidade)::text))) LEFT JOIN dbcursos t4 ON (((t4.codigo)::text = ((SELECT t5.codigocurso FROM dbturmas t5 WHERE ((t5.codigo)::text = (t0.codigoturma)::text)))::text))) LEFT JOIN dbpessoas t6 ON (((t6.codigo)::text = (t0.codigopessoa)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t0.ativo)::text)));


--
-- TOC entry 398 (class 1259 OID 28203830)
-- Dependencies: 2861 8
-- Name: view_pessoas_complemento_pf; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_pessoas_complemento_pf AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigopessoa)::text AS codigopessoa, (t1.estadocivil)::text AS estadocivil, (t1.etinia)::text AS etinia, (t1.datanasc)::text AS datanasc, (t1.sexo)::text AS sexo, (t1.tiposanguineo)::text AS tiposanguineo, (t1.nacionalidade)::text AS nacionalidade, (t1.portadornecessidades)::text AS portadornecessidades, t1.necessidadesespeciais, (t1.numerodependentes)::text AS numerodependentes, (t1.cnh)::text AS cnh, (t1.carteirareservista)::text AS carteirareservista, (t1.rendamensal)::text AS rendamensal, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbpessoas_complemento_pf t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 399 (class 1259 OID 28203835)
-- Dependencies: 2862 8
-- Name: view_pessoas_complemento_pj; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_pessoas_complemento_pj AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigopessoa)::text AS codigopessoa, (t1.datafundacao)::text AS datafundacao, (t1.gerente)::text AS gerente, (t1.diretor)::text AS diretor, (t1.representante)::text AS representante, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbpessoas_complemento_pj t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 400 (class 1259 OID 28203839)
-- Dependencies: 2863 8
-- Name: view_pessoas_convenios; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_pessoas_convenios AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, (t1.codigopessoa)::text AS codigopessoa, (t1.codigoconvenio)::text AS codigoconvenio, (t0.titulo)::text AS titulo, t0.descricao, (t0.tipoconvenio)::text AS tipoconvenio, (t0.tipotransacao)::text AS tipotransacao, (t0.valor)::text AS valor, (t0.formato)::text AS formato, (t0.datavigencia)::text AS datavirgencia, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM ((dbpessoas_convenios t1 LEFT JOIN dbconvenios t0 ON (((t1.codigoconvenio)::text = (t0.codigo)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 401 (class 1259 OID 28203844)
-- Dependencies: 2864 8
-- Name: view_pessoas_demandas; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_pessoas_demandas AS
    SELECT t0.id, (t0.codigo)::text AS codigo, (t0.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, (t0.codigopessoa)::text AS codigopessoa, (t0.codigocurso)::text AS codigocurso, (t0.turno)::text AS turno, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t3.nome)::text AS nomecurso, (t2.nome_razaosocial)::text AS nomepessoa, (t2.tel1)::text AS tel1, (t2.cel1)::text AS cel1, (t2.email1)::text AS email1 FROM (((dbpessoas_demandas t0 LEFT JOIN dbpessoas t2 ON (((t2.codigo)::text = (t0.codigopessoa)::text))) LEFT JOIN dbcursos t3 ON (((t3.codigo)::text = (t0.codigocurso)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t0.ativo)::text)));


--
-- TOC entry 402 (class 1259 OID 28203849)
-- Dependencies: 2865 8
-- Name: view_pessoas_enderecoscobrancas; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_pessoas_enderecoscobrancas AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigopessoa)::text AS codigopessoa, (t1.nomecobranca)::text AS nomecobranca, (t1.cpf_cnpjcobranca)::text AS cpf_cnpjcobranca, (t1.logradourocobranca)::text AS logradourocobranca, (t1.cidadecobranca)::text AS cidadecobranca, (t1.estadocobranca)::text AS estadocobranca, (t1.cepcobranca)::text AS cepcobranca, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbpessoas_enderecoscobrancas t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 403 (class 1259 OID 28203853)
-- Dependencies: 2866 8
-- Name: view_pessoas_formacoes; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_pessoas_formacoes AS
    SELECT t0.id, (t0.codigo)::text AS codigo, (t0.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, (t0.codigopessoa)::text AS codigopessoa, (t0.codigotitularidade)::text AS codigotitularidade, (t0.curso)::text AS curso, (t0.instituicao)::text AS instituicao, (t0.anoconclusao)::text AS anoconclusao, t0.observacao, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t3.nome_razaosocial)::text AS nomepessoa, (t2.titularidade)::text AS titularidade, (t2.nomeacao)::text AS nomeacao, (t2.peso)::text AS peso FROM (((dbpessoas_formacoes t0 LEFT JOIN dbpessoas_titularidades t2 ON (((t2.codigo)::text = (t0.codigotitularidade)::text))) LEFT JOIN dbpessoas t3 ON (((t3.codigo)::text = (t0.codigopessoa)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t0.ativo)::text)));


--
-- TOC entry 404 (class 1259 OID 28203858)
-- Dependencies: 2867 8
-- Name: view_pessoas_inscricoes; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_pessoas_inscricoes AS
    SELECT t0.id, (t0.codigo)::text AS codigo, (t0.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, (t0.codigopessoa)::text AS codigopessoa, (t0.codigotransacao)::text AS codigotransacao, (t0.opcobranca)::text AS opcobranca, (t0.codigoturma)::text AS codigoturma, (t0.codigocurso)::text AS codigocurso, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t2.nome_razaosocial)::text AS nomepessoa, (t2.cpf_cnpj)::text AS cpf_cnpj, (t2.tel1)::text AS telefone, (t2.email1)::text AS email, (t3.titulo)::text AS nometurma, (t3.datainicio)::text AS datainicio, (t3.valortaxa)::text AS valortaxa, (t3.numparcelas)::text AS numparcelas, (t3.valormensal)::text AS valormatricula, (t3.valormensal)::text AS valorparcelas, (t3.valordescontado)::text AS valordescontado, (t4.nome)::text AS nomecurso FROM ((((dbpessoas_inscricoes t0 LEFT JOIN dbpessoas t2 ON (((t2.codigo)::text = (t0.codigopessoa)::text))) LEFT JOIN dbturmas t3 ON (((t3.codigo)::text = (t0.codigoturma)::text))) LEFT JOIN dbcursos t4 ON (((t4.codigo)::text = (t0.codigocurso)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t0.ativo)::text)));


--
-- TOC entry 405 (class 1259 OID 28203863)
-- Dependencies: 2868 8
-- Name: view_pessoas_livros; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_pessoas_livros AS
    SELECT t0.id, (t0.codigo)::text AS codigo, (t0.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, (t0.codigopessoa)::text AS codigopessoa, (t0.codigolivro)::text AS codigolivro, (t0.previsaosaida)::text AS previsaosaida, (t0.previsaoentrada)::text AS previsaoentrada, (t0.confirmacaosaida)::text AS confirmacaosaida, (t0.confirmacaoentrada)::text AS confirmacaoentrada, (t0.situacao)::text AS situacao, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t1.nome_razaosocial)::text AS nomepessoa, (t3.label)::text AS titulolivro, (t2.autor)::text AS autorlivro, (t3.codigo)::text AS codigopatrimonio FROM ((((dbpessoas_livros t0 LEFT JOIN dbpessoas t1 ON (((t1.codigo)::text = (t0.codigopessoa)::text))) LEFT JOIN dbpatrimonios_livros t2 ON (((t2.codigo)::text = (t0.codigolivro)::text))) LEFT JOIN dbpatrimonios t3 ON (((t3.codigo)::text = (t2.codigopatrimonio)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 406 (class 1259 OID 28203868)
-- Dependencies: 2869 8
-- Name: view_pessoas_solicitacoes; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_pessoas_solicitacoes AS
    SELECT t0.id, (t0.codigo)::text AS codigo, (t0.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, (t0.codigopessoa)::text AS codigopessoa, (t0.solicitacao)::text AS solicitacao, (t0.data)::text AS data, t0.justificativa, t0.atendimento, (t0.codigofuncionario)::text AS codigofuncionario, (t0.codigodepartamento)::text AS codigodepartamento, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t0.status)::text AS status, (t2.nome_razaosocial)::text AS nomepessoa, (t3.nome_razaosocial)::text AS nomefuncionario, (t4.label)::text AS nomedepartamento FROM ((((dbpessoas_solicitacoes t0 LEFT JOIN dbpessoas t2 ON (((t2.codigo)::text = (t0.codigopessoa)::text))) LEFT JOIN dbpessoas t3 ON (((t3.codigo)::text = ((SELECT t5.codigopessoa FROM dbpessoas_funcionarios t5 WHERE ((t5.codigo)::text = (t0.codigofuncionario)::text)))::text))) LEFT JOIN dbdepartamentos t4 ON (((t4.codigo)::text = (t0.codigodepartamento)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t0.ativo)::text)));


--
-- TOC entry 407 (class 1259 OID 28203873)
-- Dependencies: 2870 8
-- Name: view_plano_contas; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_plano_contas AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.nomeconta)::text AS nomeconta, (t1.tipoconta)::text AS tipoconta, (t1.categoria)::text AS categoria, (t1.tipocusto)::text AS tipocusto, t1.obs, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbplano_contas t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 408 (class 1259 OID 28203877)
-- Dependencies: 2871 8
-- Name: view_produtos; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_produtos AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.label)::text AS label, t1.descricao, (t1.valor)::text AS valor, (t1.valoralteravel)::text AS valoralteravel, (t1.tabela)::text AS tabela, t1.obs, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t1.codigotipoproduto)::text AS codigotipoproduto, (t2.titulo)::text AS tipoproduto FROM ((dbprodutos t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text))) LEFT JOIN dbprodutos_tipos t2 ON (((t2.codigo)::text = (t1.codigotipoproduto)::text)));


--
-- TOC entry 409 (class 1259 OID 28203882)
-- Dependencies: 2872 8
-- Name: view_produtos_caracteristicas; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_produtos_caracteristicas AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigoproduto)::text AS codigoproduto, t1.beneficios, t1.limitacoes, t1.mododeuso, (t1.unid)::text AS unid, (t1.qtde)::text AS qtde, (t1.cor)::text AS cor, (t1.tamanho)::text AS tamanho, (t1.peso)::text AS peso, (t1.altura)::text AS altura, (t1.largura)::text AS largura, (t1.comprimento)::text AS comprimento, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbprodutos_caracteristicas t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 410 (class 1259 OID 28203886)
-- Dependencies: 2873 8
-- Name: view_produtos_parametros; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_produtos_parametros AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigoproduto)::text AS codigoproduto, (t1.tabela)::text AS tabela, (t1.collabel)::text AS collabel, (t1.colvalor)::text AS colvalor, (t1.coldesc)::text AS coldesc, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t1.codigotipoproduto)::text AS codigotipoproduto, (t2.titulo)::text AS tipoproduto FROM ((dbprodutos_parametros t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text))) LEFT JOIN dbprodutos_tipos t2 ON (((t2.codigo)::text = (t1.codigotipoproduto)::text)));


--
-- TOC entry 411 (class 1259 OID 28203891)
-- Dependencies: 2874 8
-- Name: view_produtos_turmas; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_produtos_turmas AS
    SELECT t0.id, (t0.codigo)::text AS codigo, (t0.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, (t0.label)::text AS label, t0.descricao, (t0.valor)::text AS valor, (t0.valoralteravel)::text AS valoralteravel, (t0.tabela)::text AS tabela, t0.obs, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t3.nome)::text AS nomecurso, (t2.titulo)::text AS nometurma, (t2.codigoplanoconta)::text AS codigoplanoconta, (t2.datainicio)::text AS datainicio, (t2.datafim)::text AS datafim, (t2.frequenciaaula)::text AS frequenciaaula, (t2.horainicio)::text AS horainicio, (t2.horafim)::text AS horafim, (t2.diasaula)::text AS diasaula, (t2.localaulas)::text AS localaulas, (t2.valortotal)::text AS valortotal, (t2.valortaxa)::text AS valortaxa, (t2.valormatricula)::text AS valormatricula, (t2.valormensal)::text AS valormensal, (t2.valordescontado)::text AS valordescontado, (t2.numparcelas)::text AS numparcelas, (t2.datavencimento)::text AS datavencimento, (t0.codigotipoproduto)::text AS codigotipoproduto, (t5.titulo)::text AS tipoproduto FROM ((((dbprodutos t0 LEFT JOIN dbturmas t2 ON (((t2.codigoproduto)::text = (t0.codigo)::text))) LEFT JOIN dbcursos t3 ON (((t3.codigo)::text = (t2.codigocurso)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t0.ativo)::text))) LEFT JOIN dbprodutos_tipos t5 ON (((t5.codigo)::text = (t0.codigotipoproduto)::text))) WHERE ((t0.tabela)::text = 'dbturma'::text);


--
-- TOC entry 412 (class 1259 OID 28203896)
-- Dependencies: 2875 8
-- Name: view_professores_areas; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_professores_areas AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigoprofessor)::text AS codigoprofessor, (t1.codigoareacurso)::text AS codigoareacurso, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t2.titulo)::text AS nomeareacurso FROM ((dbprofessores_areas t1 LEFT JOIN dbcursos_areas t2 ON (((t2.codigo)::text = (t1.codigoareacurso)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 413 (class 1259 OID 28203900)
-- Dependencies: 2876 8
-- Name: view_projetos; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_projetos AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigoproduto)::text AS codigoproduto, (t1.titulo)::text AS titulo, (t1.responsavelnome)::text AS responsavelnome, (t1.responsavelfuncao)::text AS responsavelfuncao, t1.objetivo, (t1.prazo)::text AS prazo, t1.resumo, t1.descrisco, t1.medidasrisco, t1.descresultado, (t1.receitapropria)::text AS receitapropria, (t1.receitaclientes)::text AS receitaclientes, (t1.receitaparceiros)::text AS receitaparceiros, (t1.receitafornecedores)::text AS receitafornecedores, (t1.receitatotal)::text AS receitatotal, (t1.recursostotal)::text AS recursostotal, (t1.custostotal)::text AS custostotal, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbprojetos t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 414 (class 1259 OID 28203905)
-- Dependencies: 2877 8
-- Name: view_projetos_colaboradores; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_projetos_colaboradores AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigoprojeto)::text AS codigoprojeto, (t1.codigopessoa)::text AS codigopessoa, (t1.funcao)::text AS funcao, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbprojetos_colaboradores t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 415 (class 1259 OID 28203909)
-- Dependencies: 2878 8
-- Name: view_projetos_custos; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_projetos_custos AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigoprojeto)::text AS codigoprojeto, (t1.item)::text AS item, (t1.valor)::text AS valor, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbprojetos_custos t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 416 (class 1259 OID 28203913)
-- Dependencies: 2879 8
-- Name: view_projetos_recursos; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_projetos_recursos AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigoprojeto)::text AS codigoprojeto, (t1.recurso)::text AS recurso, (t1.quantidade)::text AS quantidade, (t1.tempo)::text AS tempo, (t1.tipouso)::text AS tipouso, (t1.custounitario)::text AS custounitario, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbprojetos_recursos t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 417 (class 1259 OID 28203917)
-- Dependencies: 2880 8
-- Name: view_questionarios; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_questionarios AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.titulo)::text AS titulo, (t1.datainicio)::text AS datainicio, (t1.datafim)::text AS datafim, (t1.numquestoes)::text AS numquestoes, (t1.numquestoesmax)::text AS numquestoesmax, (t1.numtentativas)::text AS numtentativas, t1.obs, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbquestionarios t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 418 (class 1259 OID 28203921)
-- Dependencies: 2881 8
-- Name: view_questoes; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_questoes AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigoquestionario)::text AS codigoquestionario, t1.enunciado, (t1.tipoquestao)::text AS tipoquestao, (t1.valorquestao)::text AS valorquestao, t1.obs, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbquestoes t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 419 (class 1259 OID 28203925)
-- Dependencies: 2882 8
-- Name: view_questoes_itens; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_questoes_itens AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigoquestao)::text AS codigoquestao, t1.enunciado, (t1.valoritem)::text AS valoritem, t1.obs, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbquestoes_itens t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 420 (class 1259 OID 28203929)
-- Dependencies: 2883 8
-- Name: view_recados; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_recados AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.nomepessoa)::text AS nomepessoa, (t1.referencia)::text AS referencia, (t1.interessado)::text AS interessado, t1.obs, (t1.tel1)::text AS tel1, (t1.tel2)::text AS tel2, (t1.email)::text AS email, (t1.situacao)::text AS situacao, to_char((t1.retorno)::timestamp with time zone, 'DD/MM/YYYY'::text) AS retorno, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbrecados t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 421 (class 1259 OID 28203933)
-- Dependencies: 2884 8
-- Name: view_salas; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_salas AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.nome)::text AS nome, t1.endereco, t1.descricao, (t1.salaaula)::text AS salaaula, (t1.codigofuncionario)::text AS codigofuncionario, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t3.nome_razaosocial)::text AS nomefuncionario, (t2.nomeunidade)::text AS nomeunidade FROM (((dbsalas t1 LEFT JOIN dbunidades t2 ON (((t2.codigo)::text = (t1.unidade)::text))) LEFT JOIN dbpessoas t3 ON (((t3.codigo)::text = ((SELECT t4.codigopessoa FROM dbpessoas_funcionarios t4 WHERE ((t4.codigo)::text = (t1.codigofuncionario)::text)))::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 422 (class 1259 OID 28203938)
-- Dependencies: 2885 8
-- Name: view_scorecard; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_scorecard AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.titulo)::text AS titulo, (t1.meta)::text AS meta, (t1.pareto)::text AS pareto, (t1.codigomodulo)::text AS codigomodulo, (t1.agrupamentoperiodico)::text AS agrupamentoperiodico, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbscorecard t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 423 (class 1259 OID 28203942)
-- Dependencies: 2886 8
-- Name: view_scorecard_sentencas; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_scorecard_sentencas AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigoscorecard)::text AS codigoscorecard, (t1.tabela)::text AS tabela, (t1.colunax)::text AS colunax, (t1.agrupamentox)::text AS agrupamentox, (t1.colunay)::text AS colunay, (t1.agrupamentoy)::text AS agrupamentoy, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbscorecard_sentencas t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 424 (class 1259 OID 28203946)
-- Dependencies: 2887 8
-- Name: view_transacoes; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_transacoes AS
    SELECT t0.id, (t0.codigo)::text AS codigo, (t0.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, (t0.codigopessoa)::text AS codigopessoa, (t0.tipomovimentacao)::text AS tipomovimentacao, (t0.valortotal)::text AS valortotal, (t0.desconto)::text AS desconto, (t0.acrescimo)::text AS acrescimo, (t0.valorcorrigido)::text AS valorcorrigido, (t0.formapag)::text AS formapag, (t0.codigoplanoconta)::text AS codigoplanoconta, (t0.numparcelas)::text AS numparcelas, (t0.intervaloparcelas)::text AS intervaloparcelas, (t0.datafixavencimento)::text AS datafixavencimento, (t0.vencimento)::text AS vencimento, (t0.efetivada)::text AS efetivada, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t2.nome_razaosocial)::text AS cliente, (t3.nomeconta)::text AS planoconta, ((SELECT count(dbtransacoes_contas.codigo) AS count FROM dbtransacoes_contas WHERE (((dbtransacoes_contas.codigotransacao)::text = (t0.codigo)::text) AND (dbtransacoes_contas.statusconta = 2))))::text AS numparcelaspagas, ((SELECT sum(dbtransacoes_contas.valorreal) AS sum FROM dbtransacoes_contas WHERE (((dbtransacoes_contas.codigotransacao)::text = (t0.codigo)::text) AND (dbtransacoes_contas.statusconta = 1))))::text AS valorreal, ((SELECT count(dbtransacoes_contas.codigo) AS count FROM dbtransacoes_contas WHERE (((dbtransacoes_contas.codigotransacao)::text = (t0.codigo)::text) AND (dbtransacoes_contas.statusconta = 1))))::text AS numparcelasabertas FROM (((dbtransacoes t0 LEFT JOIN dbpessoas t2 ON (((t2.codigo)::text = (t0.codigopessoa)::text))) LEFT JOIN dbplano_contas t3 ON (((t3.codigo)::text = (t0.codigoplanoconta)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t0.ativo)::text)));


--
-- TOC entry 425 (class 1259 OID 28203951)
-- Dependencies: 2888 8
-- Name: view_transacoes_contas; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_transacoes_contas AS
    SELECT t0.id, (t0.codigo)::text AS codigo, (t0.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, (t0.codigotransacao)::text AS codigotransacao, (t0.codigopessoa)::text AS codigopessoa, (t0.codigoplanoconta)::text AS codigoplanoconta, (t0.tipomovimentacao)::text AS tipomovimentacao, (t0.valornominal)::text AS valornominal, (t0.valorreal)::text AS valorreal, (t0.numparcela)::text AS numparcela, (t0.desconto)::text AS desconto, to_char((t0.vencimento)::timestamp with time zone, 'DD/MM/YYYY'::text) AS vencimento, t0.obs, (t0.statusconta)::text AS statusconta, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t2.nome_razaosocial)::text AS nomepessoa, (t3.nomeconta)::text AS nomeplanoconta, t0.instrucoespagamento, ((SELECT sum(t4.valorpago) AS sum FROM dbcaixa t4 WHERE ((t4.codigoconta)::text = (t0.codigo)::text)))::text AS valorpago, (t4.codigocontacaixa)::text AS codigocontacaixa, (t4.numdoc)::text AS numdoc, (t4.datadocumento)::text AS datadocumento, (t4.tipoduplicata)::text AS tipoduplicata, (t4.valorreal)::text AS valorrealmovimento, (t4.formadesconto)::text AS formadesconto, (t4.desconto)::text AS descontomovimento, (t4.multaacrecimo)::text AS multaacrecimo, (t4.valorpago)::text AS valorpagomovimento, (t4.valorentrada)::text AS valorentrada, (t4.codigofuncionario)::text AS codigofuncionario, to_char((t4.datapag)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datapag, (t4.formapag)::text AS formapag, (t4.mora)::text AS mora, t4.obs AS obsmovimento, (t4.statusmovimento)::text AS statusmovimento, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, to_char((t4.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datamovimentacao FROM ((((dbtransacoes_contas t0 LEFT JOIN dbpessoas t2 ON (((t2.codigo)::text = (t0.codigopessoa)::text))) LEFT JOIN dbplano_contas t3 ON (((t3.codigo)::text = (t0.codigoplanoconta)::text))) LEFT JOIN dbcaixa t4 ON (((t4.codigoconta)::text = (t0.codigo)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t0.ativo)::text)));


--
-- TOC entry 426 (class 1259 OID 28203956)
-- Dependencies: 2889 8
-- Name: view_transacoes_contas_duplicatas; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_transacoes_contas_duplicatas AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigoconta)::text AS codigoconta, (t1.codigopessoa)::text AS codigopessoa, (t1.ndocumento)::text AS ndocumento, (t1.dataprocesso)::text AS dataprocesso, (t1.cpfsacado)::text AS cpfsacado, (t1.valordoc)::text AS valordoc, (t1.vencimento)::text AS vencimento, (t1.databaixa)::text AS databaixa, (t1.statusduplicata)::text AS statusduplicata, (t1.tipoduplicata)::text AS tipoduplicata, (t1.classificacao)::text AS classificacao, t1.bkp, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbtransacoes_contas_duplicatas t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 427 (class 1259 OID 28203961)
-- Dependencies: 2890 8
-- Name: view_transacoes_convenios; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_transacoes_convenios AS
    SELECT t0.id, (t0.codigo)::text AS codigo, (t0.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, (t0.codigotransacao)::text AS codigotransacao, (t0.codigoconvenio)::text AS codigoconvenio, (t2.titulo)::text AS nomeconvenio, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM ((dbtransacoes_convenios t0 LEFT JOIN dbconvenios t2 ON (((t2.codigo)::text = (t0.codigoconvenio)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t0.ativo)::text)));


--
-- TOC entry 428 (class 1259 OID 28203966)
-- Dependencies: 2891 8
-- Name: view_transacoes_produtos; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_transacoes_produtos AS
    SELECT t0.id, (t0.codigo)::text AS codigo, (t0.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, (t0.codigotransacao)::text AS codigotransacao, (t0.codigoproduto)::text AS codigoproduto, (t0.tabelaproduto)::text AS tabelaproduto, (t0.valornominal)::text AS valornominal, ((t0.valornominal * (t0.quantidade)::double precision))::text AS valortotal, (t0.quantidade)::text AS quantidade, t0.obs, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, t2.descricao, (t2.label)::text AS label FROM ((dbtransacoes_produtos t0 LEFT JOIN dbprodutos t2 ON (((t2.codigo)::text = (t0.codigoproduto)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t0.ativo)::text)));


--
-- TOC entry 429 (class 1259 OID 28203971)
-- Dependencies: 2892 8
-- Name: view_treinamentos; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_treinamentos AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.nomecurso)::text AS nomecurso, t1.ementa, (t1.cargahoraria)::text AS cargahoraria, (t1.ministrante)::text AS ministrante, (t1.codigotitularidade)::text AS codigotitularidade, t1.curriculoministrante, (t1.instituicaocertificadora)::text AS instituicaocertificadora, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbtreinamentos t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 443 (class 1259 OID 34925963)
-- Dependencies: 2904 8
-- Name: view_turmas; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_turmas AS
    SELECT (t2.nome)::text AS nomecurso, t0.id, (t0.codigo)::text AS codigo, (t0.unidade)::text AS unidade, (t0.titulo)::text AS titulo, t0.acinscricao, ((SELECT sum(t4.cargahoraria) AS sum FROM dbdisciplinas t4 WHERE ((t4.codigo)::text IN (SELECT t5.codigodisciplina FROM dbturmas_disciplinas t5 WHERE ((t5.codigoturma)::text = (t0.codigo)::text)))))::text AS cargahoraria, (t0.valortaxa)::text AS valortaxa, (t0.valormatricula)::text AS valormatricula, (t0.valormensal)::text AS valormensal, (t0.valordescontado)::text AS valordescontado, (t0.vagas)::text AS vagas, (t0.numparcelas)::text AS numparcelas, (t0.status)::text AS status, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t0.datainicio)::text AS datainicio, (t0.codigoproduto)::text AS codigoproduto, (t3.nomeunidade)::text AS nomeunidade, (t0.codigocurso)::text AS codigocurso, (t4.titulo)::text AS nomecursoativo, ((SELECT count(t5.codigoturma) AS count FROM dbpessoas_inscricoes t5 WHERE ((t5.codigoturma)::text = (t0.codigo)::text)))::text AS inscritos, ((SELECT count(t6.codigoturma) AS count FROM dbpessoas_alunos t6 WHERE ((t6.codigoturma)::text = (t0.codigo)::text)))::text AS matriculados, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t0.codigograde)::text AS codigograde FROM ((((dbturmas t0 LEFT JOIN dbcursos t2 ON (((t2.codigo)::text = (t0.codigocurso)::text))) LEFT JOIN dbcursos_ativos t4 ON (((t4.codigo)::text = (t0.codigocursoativo)::text))) LEFT JOIN dbunidades t3 ON (((t3.codigo)::text = (t0.unidade)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t0.ativo)::text)));


--
-- TOC entry 430 (class 1259 OID 28203980)
-- Dependencies: 2893 8
-- Name: view_turmas_convenios; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_turmas_convenios AS
    SELECT t0.id, (t0.codigo)::text AS codigo, (t0.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, (t0.codigoturma)::text AS codigoturma, (t0.codigoconvenio)::text AS codigoconvenio, (t2.titulo)::text AS nomeconvenio, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM ((dbturmas_convenios t0 LEFT JOIN dbconvenios t2 ON (((t2.codigo)::text = (t0.codigoconvenio)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t0.ativo)::text)));


--
-- TOC entry 431 (class 1259 OID 28203985)
-- Dependencies: 2894 8
-- Name: view_turmas_descontos; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_turmas_descontos AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigoturma)::text AS codigoturma, (t1.dialimite)::text AS dialimite, (t1.valordescontado)::text AS valordescontado, t1.obs, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t1.tipodesconto)::text AS tipodesconto FROM (dbturmas_descontos t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 432 (class 1259 OID 28203989)
-- Dependencies: 2895 8
-- Name: view_turmas_disciplinas_arquivos; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_turmas_disciplinas_arquivos AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.tipo)::text AS tipo, (t1.codigoturmadisciplina)::text AS codigoturmadisciplina, (t1.codigoprofessor)::text AS codigoprofessor, (t1.titulo)::text AS titulo, t1.obs, t1.arquivo, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbturmas_disciplinas_arquivos t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 433 (class 1259 OID 28203993)
-- Dependencies: 2896 8
-- Name: view_turmas_disciplinas_aulas; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_turmas_disciplinas_aulas AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigoturmadisciplina)::text AS codigoturmadisciplina, (t1.dataaula)::text AS dataaula, t1.conteudo, (t1.frequencia)::text AS frequencia, t1.obs, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbturmas_disciplinas_aulas t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 434 (class 1259 OID 28203997)
-- Dependencies: 2897 8
-- Name: view_turmas_disciplinas_avaliacoes; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_turmas_disciplinas_avaliacoes AS
    SELECT t2.id, (t2.codigo)::text AS codigo, (t2.unidade)::text AS unidade, (t2.codigoautor)::text AS codigoautor, (t2.avaliacao)::text AS avaliacao, (t2.peso)::text AS peso, (t2.ordem)::text AS ordem, (t2.codigoregra)::text AS codigoregra, t2.incontrol, (t2.referencia)::text AS referencia, t2.condicao, (t2.codigograde)::text AS codigograde, to_char((t2.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, t1.codigoturma, t1.codigo AS codigoturmadisciplina FROM ((dbturmas_disciplinas t1 JOIN dbavaliacoes t2 ON (((t2.codigograde)::text = ((SELECT dbturmas.codigograde FROM dbturmas WHERE ((dbturmas.codigo)::text = (t1.codigoturma)::text)))::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t2.ativo)::text)));


--
-- TOC entry 435 (class 1259 OID 28204002)
-- Dependencies: 2898 8
-- Name: view_turmas_disciplinas_materiais; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_turmas_disciplinas_materiais AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigoturmadisciplina)::text AS codigoturmadisciplina, (t1.material)::text AS material, t1.descricao, (t1.custo)::text AS custo, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbturmas_disciplinas_materiais t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 436 (class 1259 OID 28204006)
-- Dependencies: 2899 8
-- Name: view_turmas_disciplinas_planoaulas; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_turmas_disciplinas_planoaulas AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigoturmadisciplina)::text AS codigoturmadisciplina, (t1.codigoprofessor)::text AS codigoprofessor, (t1.dataaula)::text AS dataaula, t1.conteudo, t1.recursos, t1.metodologia, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbturmas_disciplinas_planoaulas t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 437 (class 1259 OID 28204010)
-- Dependencies: 2900 8
-- Name: view_turmas_requisitos; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_turmas_requisitos AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigoturma)::text AS codigoturma, (t1.requisito)::text AS requisito, (t1.situacao)::text AS situacao, t1.obs, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbturmas_requisitos t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 438 (class 1259 OID 28204014)
-- Dependencies: 2901 8
-- Name: view_unidades; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_unidades AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.nomeunidade)::text AS nomeunidade, (t1.razaosocial)::text AS razaosocial, (t1.cnpj)::text AS cnpj, (t1.inscestadual)::text AS inscestadual, (t1.inscmunicipal)::text AS inscmunicipal, (t1.gerente)::text AS gerente, (t1.diretor)::text AS diretor, (t1.representante)::text AS representante, (t1.logradouro)::text AS logradouro, (t1.bairro)::text AS bairro, (t1.cidade)::text AS cidade, (t1.estado)::text AS estado, (t1.cep)::text AS cep, (t1.email)::text AS email, (t1.telefone)::text AS telefone, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbunidades t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- TOC entry 439 (class 1259 OID 28204019)
-- Dependencies: 2902 8
-- Name: view_usuarios; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_usuarios AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.classeuser)::text AS classeuser, (t1.codigopessoa)::text AS codigopessoa, (t2.nome_razaosocial)::text AS nomepessoa, (t1.usuario)::text AS usuario, (t1.senha)::text AS senha, (t1.entidadepai)::text AS entidadepai, (t1.codigotema)::text AS codigotema, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM ((dbusuarios t1 LEFT JOIN dbpessoas t2 ON (((t2.codigo)::text = (t1.codigopessoa)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


SET search_path = dominio, pg_catalog;

--
-- TOC entry 2905 (class 2604 OID 28204024)
-- Dependencies: 130 129
-- Name: id; Type: DEFAULT; Schema: dominio; Owner: -
--

ALTER TABLE dbceps ALTER COLUMN id SET DEFAULT nextval('dbceps_id_seq'::regclass);


--
-- TOC entry 2906 (class 2604 OID 28204025)
-- Dependencies: 132 131
-- Name: id; Type: DEFAULT; Schema: dominio; Owner: -
--

ALTER TABLE dbcidades ALTER COLUMN id SET DEFAULT nextval('dbcidades_id_seq'::regclass);


--
-- TOC entry 2907 (class 2604 OID 28204026)
-- Dependencies: 134 133
-- Name: id; Type: DEFAULT; Schema: dominio; Owner: -
--

ALTER TABLE dbestados ALTER COLUMN id SET DEFAULT nextval('dbestados_id_seq'::regclass);


--
-- TOC entry 2908 (class 2604 OID 28204027)
-- Dependencies: 137 135
-- Name: id; Type: DEFAULT; Schema: dominio; Owner: -
--

ALTER TABLE dbnfe_erros ALTER COLUMN id SET DEFAULT nextval('dbnfe_erros_id_seq'::regclass);


--
-- TOC entry 2909 (class 2604 OID 28204028)
-- Dependencies: 140 139
-- Name: id; Type: DEFAULT; Schema: dominio; Owner: -
--

ALTER TABLE dbpaises ALTER COLUMN id SET DEFAULT nextval('dbpaises_id_seq'::regclass);


--
-- TOC entry 2910 (class 2604 OID 28204029)
-- Dependencies: 144 141
-- Name: id; Type: DEFAULT; Schema: dominio; Owner: -
--

ALTER TABLE dbwebservices ALTER COLUMN id SET DEFAULT nextval('dbwebservices_id_seq'::regclass);


--
-- TOC entry 2911 (class 2604 OID 28204030)
-- Dependencies: 143 142
-- Name: id; Type: DEFAULT; Schema: dominio; Owner: -
--

ALTER TABLE dbwebservices_campos ALTER COLUMN id SET DEFAULT nextval('dbwebservices_campos_id_seq'::regclass);


SET search_path = public, pg_catalog;

--
-- TOC entry 2950 (class 2604 OID 28204031)
-- Dependencies: 162 161
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE dbavaliacoes ALTER COLUMN id SET DEFAULT nextval('dbavaliacoes_id_seq'::regclass);


--
-- TOC entry 2958 (class 2604 OID 28204032)
-- Dependencies: 164 163
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE dbavaliacoes_regras ALTER COLUMN id SET DEFAULT nextval('dbavaliacoes_regras_id_seq'::regclass);


--
-- TOC entry 3054 (class 2604 OID 28204033)
-- Dependencies: 192 191
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE dbconvenios_descontos ALTER COLUMN id SET DEFAULT nextval('dbconvenios_descontos_id_seq'::regclass);


--
-- TOC entry 3174 (class 2604 OID 28204034)
-- Dependencies: 233 232
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE dbgrade_avaliacoes ALTER COLUMN id SET DEFAULT nextval('dbgrade_avaliacoes_id_seq'::regclass);


--
-- TOC entry 3374 (class 2604 OID 28204035)
-- Dependencies: 309 308
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE dbstatus ALTER COLUMN id SET DEFAULT nextval('dbstatus_id_seq'::regclass);


--
-- TOC entry 3408 (class 2604 OID 28204036)
-- Dependencies: 319 318
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE dbtransacoes_contas_situacao ALTER COLUMN id SET DEFAULT nextval('dbtransacoes_contas_situacao_id_seq'::regclass);


--
-- TOC entry 3413 (class 2604 OID 28204037)
-- Dependencies: 321 320
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE dbtransacoes_convenios ALTER COLUMN id SET DEFAULT nextval('dbtransacoes_convenios_id_seq'::regclass);


--
-- TOC entry 3460 (class 2604 OID 28204038)
-- Dependencies: 331 330
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE dbturmas_convenios ALTER COLUMN id SET DEFAULT nextval('dbturmas_convenios_id_seq'::regclass);


--
-- TOC entry 3494 (class 2604 OID 28204039)
-- Dependencies: 341 340
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE dbturmas_disciplinas_avaliacao_detalhamento ALTER COLUMN id SET DEFAULT nextval('dbturmas_disciplinas_avaliacao_detalhamento_id_seq'::regclass);


SET search_path = dominio, pg_catalog;

--
-- TOC entry 3556 (class 2606 OID 28204041)
-- Dependencies: 129 129
-- Name: pk_dbceps; Type: CONSTRAINT; Schema: dominio; Owner: -
--

ALTER TABLE ONLY dbceps
    ADD CONSTRAINT pk_dbceps PRIMARY KEY (id);


--
-- TOC entry 3558 (class 2606 OID 28204043)
-- Dependencies: 131 131
-- Name: pk_dbcidades; Type: CONSTRAINT; Schema: dominio; Owner: -
--

ALTER TABLE ONLY dbcidades
    ADD CONSTRAINT pk_dbcidades PRIMARY KEY (id);


--
-- TOC entry 3560 (class 2606 OID 28204045)
-- Dependencies: 133 133
-- Name: pk_dbestados; Type: CONSTRAINT; Schema: dominio; Owner: -
--

ALTER TABLE ONLY dbestados
    ADD CONSTRAINT pk_dbestados PRIMARY KEY (id);


--
-- TOC entry 3562 (class 2606 OID 28204047)
-- Dependencies: 135 135
-- Name: pk_dbnfe_erros; Type: CONSTRAINT; Schema: dominio; Owner: -
--

ALTER TABLE ONLY dbnfe_erros
    ADD CONSTRAINT pk_dbnfe_erros PRIMARY KEY (id);


--
-- TOC entry 3564 (class 2606 OID 28204049)
-- Dependencies: 136 136
-- Name: pk_dbnfe_erros_grupos; Type: CONSTRAINT; Schema: dominio; Owner: -
--

ALTER TABLE ONLY dbnfe_erros_grupos
    ADD CONSTRAINT pk_dbnfe_erros_grupos PRIMARY KEY (id);


--
-- TOC entry 3566 (class 2606 OID 28204051)
-- Dependencies: 138 138
-- Name: pk_dbnfe_erros_mensagens; Type: CONSTRAINT; Schema: dominio; Owner: -
--

ALTER TABLE ONLY dbnfe_erros_mensagens
    ADD CONSTRAINT pk_dbnfe_erros_mensagens PRIMARY KEY (id);


--
-- TOC entry 3568 (class 2606 OID 28204053)
-- Dependencies: 139 139
-- Name: pk_dbpaises; Type: CONSTRAINT; Schema: dominio; Owner: -
--

ALTER TABLE ONLY dbpaises
    ADD CONSTRAINT pk_dbpaises PRIMARY KEY (id);


--
-- TOC entry 3570 (class 2606 OID 28204055)
-- Dependencies: 141 141
-- Name: pk_dbwebservices; Type: CONSTRAINT; Schema: dominio; Owner: -
--

ALTER TABLE ONLY dbwebservices
    ADD CONSTRAINT pk_dbwebservices PRIMARY KEY (id);


--
-- TOC entry 3572 (class 2606 OID 28204057)
-- Dependencies: 142 142
-- Name: pk_dbwebservices_campos; Type: CONSTRAINT; Schema: dominio; Owner: -
--

ALTER TABLE ONLY dbwebservices_campos
    ADD CONSTRAINT pk_dbwebservices_campos PRIMARY KEY (id);


SET search_path = public, pg_catalog;

--
-- TOC entry 3733 (class 2606 OID 28204059)
-- Dependencies: 229 229
-- Name: dbfuncionarios_professores_uk_codigofuncionario; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfuncionarios_professores
    ADD CONSTRAINT dbfuncionarios_professores_uk_codigofuncionario UNIQUE (codigofuncionario);


--
-- TOC entry 3574 (class 2606 OID 28204063)
-- Dependencies: 148 148
-- Name: pk_dbalunos_disciplinas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_disciplinas
    ADD CONSTRAINT pk_dbalunos_disciplinas PRIMARY KEY (codigo);


--
-- TOC entry 3578 (class 2606 OID 28204065)
-- Dependencies: 150 150
-- Name: pk_dbalunos_disciplinas_aproveitamentos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_disciplinas_aproveitamentos
    ADD CONSTRAINT pk_dbalunos_disciplinas_aproveitamentos PRIMARY KEY (codigo);


--
-- TOC entry 3582 (class 2606 OID 28204067)
-- Dependencies: 152 152
-- Name: pk_dbalunos_faltas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_faltas
    ADD CONSTRAINT pk_dbalunos_faltas PRIMARY KEY (codigo);


--
-- TOC entry 3586 (class 2606 OID 28204069)
-- Dependencies: 154 154
-- Name: pk_dbalunos_notas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_notas
    ADD CONSTRAINT pk_dbalunos_notas PRIMARY KEY (codigo);


--
-- TOC entry 3590 (class 2606 OID 28204071)
-- Dependencies: 156 156
-- Name: pk_dbalunos_requisitos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_requisitos
    ADD CONSTRAINT pk_dbalunos_requisitos PRIMARY KEY (codigo);


--
-- TOC entry 3594 (class 2606 OID 28204073)
-- Dependencies: 158 158
-- Name: pk_dbalunos_solicitacoes; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_solicitacoes
    ADD CONSTRAINT pk_dbalunos_solicitacoes PRIMARY KEY (codigo);


--
-- TOC entry 3598 (class 2606 OID 28204075)
-- Dependencies: 160 160
-- Name: pk_dbalunos_transacoes; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_transacoes
    ADD CONSTRAINT pk_dbalunos_transacoes PRIMARY KEY (codigo);


--
-- TOC entry 3602 (class 2606 OID 28204077)
-- Dependencies: 161 161
-- Name: pk_dbavaliacoes; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbavaliacoes
    ADD CONSTRAINT pk_dbavaliacoes PRIMARY KEY (codigo);


--
-- TOC entry 3606 (class 2606 OID 28204079)
-- Dependencies: 163 163
-- Name: pk_dbavaliacoes_regras; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbavaliacoes_regras
    ADD CONSTRAINT pk_dbavaliacoes_regras PRIMARY KEY (codigo);


--
-- TOC entry 3610 (class 2606 OID 28204081)
-- Dependencies: 166 166
-- Name: pk_dbbalanco_patrimonial; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbbalanco_patrimonial
    ADD CONSTRAINT pk_dbbalanco_patrimonial PRIMARY KEY (codigo);


--
-- TOC entry 3614 (class 2606 OID 28204083)
-- Dependencies: 168 168
-- Name: pk_dbbiblioteca_cdu; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbbiblioteca_cdu
    ADD CONSTRAINT pk_dbbiblioteca_cdu PRIMARY KEY (codigo);


--
-- TOC entry 3620 (class 2606 OID 28204085)
-- Dependencies: 170 170
-- Name: pk_dbcaixa; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcaixa
    ADD CONSTRAINT pk_dbcaixa PRIMARY KEY (codigo);


--
-- TOC entry 3624 (class 2606 OID 28204087)
-- Dependencies: 172 172
-- Name: pk_dbcaixa_fechamentos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcaixa_fechamentos
    ADD CONSTRAINT pk_dbcaixa_fechamentos PRIMARY KEY (codigo);


--
-- TOC entry 3628 (class 2606 OID 28204089)
-- Dependencies: 174 174
-- Name: pk_dbcaixa_funcionarios; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcaixa_funcionarios
    ADD CONSTRAINT pk_dbcaixa_funcionarios PRIMARY KEY (codigo);


--
-- TOC entry 3632 (class 2606 OID 28204091)
-- Dependencies: 176 176
-- Name: pk_dbcargos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcargos
    ADD CONSTRAINT pk_dbcargos PRIMARY KEY (codigo);


--
-- TOC entry 3650 (class 2606 OID 28204093)
-- Dependencies: 186 186
-- Name: pk_dbcheques; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcontas_cheques
    ADD CONSTRAINT pk_dbcheques PRIMARY KEY (codigo);


--
-- TOC entry 3636 (class 2606 OID 28204095)
-- Dependencies: 180 180
-- Name: pk_dbcompras; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcompras
    ADD CONSTRAINT pk_dbcompras PRIMARY KEY (codigo);


--
-- TOC entry 3640 (class 2606 OID 28204097)
-- Dependencies: 182 182
-- Name: pk_dbcontas_caixa; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcontas_caixa
    ADD CONSTRAINT pk_dbcontas_caixa PRIMARY KEY (codigo);


--
-- TOC entry 3644 (class 2606 OID 28204099)
-- Dependencies: 184 184
-- Name: pk_dbcontas_caixa_historico; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcontas_caixa_historico
    ADD CONSTRAINT pk_dbcontas_caixa_historico PRIMARY KEY (codigo);


--
-- TOC entry 3654 (class 2606 OID 28204101)
-- Dependencies: 188 188
-- Name: pk_dbcontratos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcontratos
    ADD CONSTRAINT pk_dbcontratos PRIMARY KEY (codigo);


--
-- TOC entry 3659 (class 2606 OID 28204103)
-- Dependencies: 190 190
-- Name: pk_dbconvenios; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbconvenios
    ADD CONSTRAINT pk_dbconvenios PRIMARY KEY (codigo);


--
-- TOC entry 3661 (class 2606 OID 28204105)
-- Dependencies: 191 191
-- Name: pk_dbconvenios_descontos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbconvenios_descontos
    ADD CONSTRAINT pk_dbconvenios_descontos PRIMARY KEY (codigo);


--
-- TOC entry 3665 (class 2606 OID 28204107)
-- Dependencies: 194 194
-- Name: pk_dbcotacoes; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcotacoes
    ADD CONSTRAINT pk_dbcotacoes PRIMARY KEY (codigo);


--
-- TOC entry 3669 (class 2606 OID 28204109)
-- Dependencies: 196 196
-- Name: pk_dbcrm_demandas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcrm_demandas
    ADD CONSTRAINT pk_dbcrm_demandas PRIMARY KEY (codigo);


--
-- TOC entry 3673 (class 2606 OID 28204111)
-- Dependencies: 198 198
-- Name: pk_dbcurriculos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcurriculos
    ADD CONSTRAINT pk_dbcurriculos PRIMARY KEY (codigo);


--
-- TOC entry 3677 (class 2606 OID 28204113)
-- Dependencies: 200 200
-- Name: pk_dbcursos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcursos
    ADD CONSTRAINT pk_dbcursos PRIMARY KEY (codigo);


--
-- TOC entry 3681 (class 2606 OID 28204115)
-- Dependencies: 202 202
-- Name: pk_dbcursos_areas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcursos_areas
    ADD CONSTRAINT pk_dbcursos_areas PRIMARY KEY (codigo);


--
-- TOC entry 3685 (class 2606 OID 28204117)
-- Dependencies: 204 204
-- Name: pk_dbcursos_ativos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcursos_ativos
    ADD CONSTRAINT pk_dbcursos_ativos PRIMARY KEY (codigo);


--
-- TOC entry 3689 (class 2606 OID 28204119)
-- Dependencies: 206 206
-- Name: pk_dbcursos_avaliacoes; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcursos_avaliacoes
    ADD CONSTRAINT pk_dbcursos_avaliacoes PRIMARY KEY (codigo);


--
-- TOC entry 3693 (class 2606 OID 28204121)
-- Dependencies: 208 208
-- Name: pk_dbcursos_disciplinas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcursos_disciplinas
    ADD CONSTRAINT pk_dbcursos_disciplinas PRIMARY KEY (codigo);


--
-- TOC entry 3697 (class 2606 OID 28204123)
-- Dependencies: 210 210
-- Name: pk_dbcursos_tipos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcursos_tipos
    ADD CONSTRAINT pk_dbcursos_tipos PRIMARY KEY (codigo);


--
-- TOC entry 3701 (class 2606 OID 28204125)
-- Dependencies: 212 212
-- Name: pk_dbdados_boleto; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbdados_boleto
    ADD CONSTRAINT pk_dbdados_boleto PRIMARY KEY (codigo);


--
-- TOC entry 3705 (class 2606 OID 28204127)
-- Dependencies: 214 214
-- Name: pk_dbdepartamentos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbdepartamentos
    ADD CONSTRAINT pk_dbdepartamentos PRIMARY KEY (codigo);


--
-- TOC entry 3709 (class 2606 OID 28204129)
-- Dependencies: 216 216
-- Name: pk_dbdisciplinas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbdisciplinas
    ADD CONSTRAINT pk_dbdisciplinas PRIMARY KEY (codigo);


--
-- TOC entry 3713 (class 2606 OID 28204131)
-- Dependencies: 218 218
-- Name: pk_dbdisciplinas_semelhantes; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbdisciplinas_semelhantes
    ADD CONSTRAINT pk_dbdisciplinas_semelhantes PRIMARY KEY (codigo);


--
-- TOC entry 3717 (class 2606 OID 28204133)
-- Dependencies: 220 220
-- Name: pk_dbdocumentos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbdocumentos
    ADD CONSTRAINT pk_dbdocumentos PRIMARY KEY (codigo);


--
-- TOC entry 3721 (class 2606 OID 28204135)
-- Dependencies: 223 223
-- Name: pk_dbfuncionarios_ferias; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfuncionarios_ferias
    ADD CONSTRAINT pk_dbfuncionarios_ferias PRIMARY KEY (codigo);


--
-- TOC entry 3725 (class 2606 OID 28204137)
-- Dependencies: 225 225
-- Name: pk_dbfuncionarios_folhapagamento; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfuncionarios_folhapagamento
    ADD CONSTRAINT pk_dbfuncionarios_folhapagamento PRIMARY KEY (codigo);


--
-- TOC entry 3729 (class 2606 OID 28204139)
-- Dependencies: 227 227
-- Name: pk_dbfuncionarios_ocorrencias; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfuncionarios_ocorrencias
    ADD CONSTRAINT pk_dbfuncionarios_ocorrencias PRIMARY KEY (codigo);


--
-- TOC entry 3735 (class 2606 OID 28204141)
-- Dependencies: 229 229
-- Name: pk_dbfuncionarios_professores; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfuncionarios_professores
    ADD CONSTRAINT pk_dbfuncionarios_professores PRIMARY KEY (codigo);


--
-- TOC entry 3739 (class 2606 OID 28204143)
-- Dependencies: 231 231
-- Name: pk_dbfuncionarios_treinamentos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfuncionarios_treinamentos
    ADD CONSTRAINT pk_dbfuncionarios_treinamentos PRIMARY KEY (codigo);


--
-- TOC entry 3743 (class 2606 OID 28204145)
-- Dependencies: 232 232
-- Name: pk_dbgrade_avaliacoes; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbgrade_avaliacoes
    ADD CONSTRAINT pk_dbgrade_avaliacoes PRIMARY KEY (codigo);


--
-- TOC entry 3747 (class 2606 OID 28204147)
-- Dependencies: 236 236
-- Name: pk_dbpatrimonios; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpatrimonios
    ADD CONSTRAINT pk_dbpatrimonios PRIMARY KEY (codigo);


--
-- TOC entry 3751 (class 2606 OID 28204149)
-- Dependencies: 238 238
-- Name: pk_dbpatrimonios_livros; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpatrimonios_livros
    ADD CONSTRAINT pk_dbpatrimonios_livros PRIMARY KEY (codigo);


--
-- TOC entry 3755 (class 2606 OID 28204151)
-- Dependencies: 240 240
-- Name: pk_dbpessoas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas
    ADD CONSTRAINT pk_dbpessoas PRIMARY KEY (codigo);


--
-- TOC entry 3759 (class 2606 OID 28204153)
-- Dependencies: 242 242
-- Name: pk_dbpessoas_alunos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_alunos
    ADD CONSTRAINT pk_dbpessoas_alunos PRIMARY KEY (codigo);


--
-- TOC entry 3763 (class 2606 OID 28204155)
-- Dependencies: 244 244
-- Name: pk_dbpessoas_complemento_pf; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_complemento_pf
    ADD CONSTRAINT pk_dbpessoas_complemento_pf PRIMARY KEY (codigo);


--
-- TOC entry 3767 (class 2606 OID 28204157)
-- Dependencies: 246 246
-- Name: pk_dbpessoas_complemento_pj; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_complemento_pj
    ADD CONSTRAINT pk_dbpessoas_complemento_pj PRIMARY KEY (codigo);


--
-- TOC entry 3772 (class 2606 OID 28204159)
-- Dependencies: 248 248
-- Name: pk_dbpessoas_convenios; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_convenios
    ADD CONSTRAINT pk_dbpessoas_convenios PRIMARY KEY (codigo);


--
-- TOC entry 3776 (class 2606 OID 28204161)
-- Dependencies: 250 250
-- Name: pk_dbpessoas_demandas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_demandas
    ADD CONSTRAINT pk_dbpessoas_demandas PRIMARY KEY (codigo);


--
-- TOC entry 3780 (class 2606 OID 28204163)
-- Dependencies: 252 252
-- Name: pk_dbpessoas_enderecoscobrancas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_enderecoscobrancas
    ADD CONSTRAINT pk_dbpessoas_enderecoscobrancas PRIMARY KEY (codigo);


--
-- TOC entry 3784 (class 2606 OID 28204165)
-- Dependencies: 254 254
-- Name: pk_dbpessoas_formacoes; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_formacoes
    ADD CONSTRAINT pk_dbpessoas_formacoes PRIMARY KEY (codigo);


--
-- TOC entry 3788 (class 2606 OID 28204167)
-- Dependencies: 256 256
-- Name: pk_dbpessoas_funcionarios; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_funcionarios
    ADD CONSTRAINT pk_dbpessoas_funcionarios PRIMARY KEY (codigo);


--
-- TOC entry 3792 (class 2606 OID 28204169)
-- Dependencies: 258 258
-- Name: pk_dbpessoas_inscricoes; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_inscricoes
    ADD CONSTRAINT pk_dbpessoas_inscricoes PRIMARY KEY (codigo);


--
-- TOC entry 3796 (class 2606 OID 28204171)
-- Dependencies: 260 260
-- Name: pk_dbpessoas_livros; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_livros
    ADD CONSTRAINT pk_dbpessoas_livros PRIMARY KEY (codigo);


--
-- TOC entry 3800 (class 2606 OID 28204173)
-- Dependencies: 262 262
-- Name: pk_dbpessoas_solicitacoes; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_solicitacoes
    ADD CONSTRAINT pk_dbpessoas_solicitacoes PRIMARY KEY (codigo);


--
-- TOC entry 3804 (class 2606 OID 28204175)
-- Dependencies: 264 264
-- Name: pk_dbpessoas_titularidades; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_titularidades
    ADD CONSTRAINT pk_dbpessoas_titularidades PRIMARY KEY (codigo);


--
-- TOC entry 3808 (class 2606 OID 28204177)
-- Dependencies: 266 266
-- Name: pk_dbplano_contas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbplano_contas
    ADD CONSTRAINT pk_dbplano_contas PRIMARY KEY (codigo);


--
-- TOC entry 3812 (class 2606 OID 28204179)
-- Dependencies: 268 268
-- Name: pk_dbprocessos_academicos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprocessos_academicos
    ADD CONSTRAINT pk_dbprocessos_academicos PRIMARY KEY (codigo);


--
-- TOC entry 3817 (class 2606 OID 28204181)
-- Dependencies: 270 270
-- Name: pk_dbprodutos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprodutos
    ADD CONSTRAINT pk_dbprodutos PRIMARY KEY (codigo);


--
-- TOC entry 3821 (class 2606 OID 28204183)
-- Dependencies: 272 272
-- Name: pk_dbprodutos_insumos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprodutos_caracteristicas
    ADD CONSTRAINT pk_dbprodutos_insumos PRIMARY KEY (codigo);


--
-- TOC entry 3826 (class 2606 OID 28204185)
-- Dependencies: 277 277
-- Name: pk_dbprodutos_parametros; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprodutos_parametros
    ADD CONSTRAINT pk_dbprodutos_parametros PRIMARY KEY (codigo);


--
-- TOC entry 3830 (class 2606 OID 28204187)
-- Dependencies: 279 279
-- Name: pk_dbprodutos_tabelapreco; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprodutos_tabelapreco
    ADD CONSTRAINT pk_dbprodutos_tabelapreco PRIMARY KEY (codigo);


--
-- TOC entry 3834 (class 2606 OID 28204189)
-- Dependencies: 281 281
-- Name: pk_dbprodutos_tipos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprodutos_tipos
    ADD CONSTRAINT pk_dbprodutos_tipos PRIMARY KEY (codigo);


--
-- TOC entry 3838 (class 2606 OID 28204191)
-- Dependencies: 283 283
-- Name: pk_dbprodutos_tributos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprodutos_tributos
    ADD CONSTRAINT pk_dbprodutos_tributos PRIMARY KEY (codigo);


--
-- TOC entry 3842 (class 2606 OID 28204193)
-- Dependencies: 285 285
-- Name: pk_dbprofessores_areas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprofessores_areas
    ADD CONSTRAINT pk_dbprofessores_areas PRIMARY KEY (codigo);


--
-- TOC entry 3846 (class 2606 OID 28204195)
-- Dependencies: 287 287
-- Name: pk_dbprojetos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprojetos
    ADD CONSTRAINT pk_dbprojetos PRIMARY KEY (codigo);


--
-- TOC entry 3850 (class 2606 OID 28204197)
-- Dependencies: 289 289
-- Name: pk_dbprojetos_colaboradores; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprojetos_colaboradores
    ADD CONSTRAINT pk_dbprojetos_colaboradores PRIMARY KEY (codigo);


--
-- TOC entry 3854 (class 2606 OID 28204199)
-- Dependencies: 291 291
-- Name: pk_dbprojetos_custos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprojetos_custos
    ADD CONSTRAINT pk_dbprojetos_custos PRIMARY KEY (codigo);


--
-- TOC entry 3858 (class 2606 OID 28204201)
-- Dependencies: 293 293
-- Name: pk_dbprojetos_recursos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprojetos_recursos
    ADD CONSTRAINT pk_dbprojetos_recursos PRIMARY KEY (codigo);


--
-- TOC entry 3862 (class 2606 OID 28204203)
-- Dependencies: 295 295
-- Name: pk_dbquestionarios; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbquestionarios
    ADD CONSTRAINT pk_dbquestionarios PRIMARY KEY (codigo);


--
-- TOC entry 3866 (class 2606 OID 28204205)
-- Dependencies: 297 297
-- Name: pk_dbquestoes; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbquestoes
    ADD CONSTRAINT pk_dbquestoes PRIMARY KEY (codigo);


--
-- TOC entry 3870 (class 2606 OID 28204207)
-- Dependencies: 299 299
-- Name: pk_dbquestoes_itens; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbquestoes_itens
    ADD CONSTRAINT pk_dbquestoes_itens PRIMARY KEY (codigo);


--
-- TOC entry 3874 (class 2606 OID 28204209)
-- Dependencies: 301 301
-- Name: pk_dbrecados; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbrecados
    ADD CONSTRAINT pk_dbrecados PRIMARY KEY (codigo);


--
-- TOC entry 3878 (class 2606 OID 28204211)
-- Dependencies: 303 303
-- Name: pk_dbsalas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbsalas
    ADD CONSTRAINT pk_dbsalas PRIMARY KEY (codigo);


--
-- TOC entry 3882 (class 2606 OID 28204213)
-- Dependencies: 305 305
-- Name: pk_dbscorecard; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbscorecard
    ADD CONSTRAINT pk_dbscorecard PRIMARY KEY (codigo);


--
-- TOC entry 3886 (class 2606 OID 28204215)
-- Dependencies: 307 307
-- Name: pk_dbscorecard_sentencas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbscorecard_sentencas
    ADD CONSTRAINT pk_dbscorecard_sentencas PRIMARY KEY (codigo);


--
-- TOC entry 3890 (class 2606 OID 28204217)
-- Dependencies: 308 308
-- Name: pk_dbstatus; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbstatus
    ADD CONSTRAINT pk_dbstatus PRIMARY KEY (id);


--
-- TOC entry 3892 (class 2606 OID 28204219)
-- Dependencies: 311 311
-- Name: pk_dbtransacoes; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes
    ADD CONSTRAINT pk_dbtransacoes PRIMARY KEY (codigo);


--
-- TOC entry 3896 (class 2606 OID 28204221)
-- Dependencies: 313 313
-- Name: pk_dbtransacoes_contas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes_contas
    ADD CONSTRAINT pk_dbtransacoes_contas PRIMARY KEY (codigo);


--
-- TOC entry 3901 (class 2606 OID 28204223)
-- Dependencies: 315 315
-- Name: pk_dbtransacoes_contas_duplicatas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes_contas_duplicatas
    ADD CONSTRAINT pk_dbtransacoes_contas_duplicatas PRIMARY KEY (codigo);


--
-- TOC entry 3905 (class 2606 OID 28204225)
-- Dependencies: 317 317
-- Name: pk_dbtransacoes_contas_extornos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes_contas_extornos
    ADD CONSTRAINT pk_dbtransacoes_contas_extornos PRIMARY KEY (codigo);


--
-- TOC entry 3909 (class 2606 OID 28204227)
-- Dependencies: 318 318
-- Name: pk_dbtransacoes_contas_situacao; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes_contas_situacao
    ADD CONSTRAINT pk_dbtransacoes_contas_situacao PRIMARY KEY (codigo);


--
-- TOC entry 3913 (class 2606 OID 28204229)
-- Dependencies: 320 320
-- Name: pk_dbtransacoes_convenios; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes_convenios
    ADD CONSTRAINT pk_dbtransacoes_convenios PRIMARY KEY (codigo);


--
-- TOC entry 3917 (class 2606 OID 28204231)
-- Dependencies: 323 323
-- Name: pk_dbtransacoes_produtos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes_produtos
    ADD CONSTRAINT pk_dbtransacoes_produtos PRIMARY KEY (codigo);


--
-- TOC entry 3921 (class 2606 OID 28204233)
-- Dependencies: 325 325
-- Name: pk_dbtreinamentos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtreinamentos
    ADD CONSTRAINT pk_dbtreinamentos PRIMARY KEY (codigo);


--
-- TOC entry 3925 (class 2606 OID 28204235)
-- Dependencies: 327 327
-- Name: pk_dbtributos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtributos
    ADD CONSTRAINT pk_dbtributos PRIMARY KEY (codigo);


--
-- TOC entry 3929 (class 2606 OID 28204237)
-- Dependencies: 329 329
-- Name: pk_dbturmas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas
    ADD CONSTRAINT pk_dbturmas PRIMARY KEY (codigo);


--
-- TOC entry 3933 (class 2606 OID 28204239)
-- Dependencies: 330 330
-- Name: pk_dbturmas_convenios; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_convenios
    ADD CONSTRAINT pk_dbturmas_convenios PRIMARY KEY (codigo);


--
-- TOC entry 3937 (class 2606 OID 28204241)
-- Dependencies: 333 333
-- Name: pk_dbturmas_descontos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_descontos
    ADD CONSTRAINT pk_dbturmas_descontos PRIMARY KEY (codigo);


--
-- TOC entry 3941 (class 2606 OID 28204243)
-- Dependencies: 335 335
-- Name: pk_dbturmas_disciplinas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas
    ADD CONSTRAINT pk_dbturmas_disciplinas PRIMARY KEY (codigo);


--
-- TOC entry 3945 (class 2606 OID 28204245)
-- Dependencies: 337 337
-- Name: pk_dbturmas_disciplinas_arquivos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas_arquivos
    ADD CONSTRAINT pk_dbturmas_disciplinas_arquivos PRIMARY KEY (codigo);


--
-- TOC entry 3949 (class 2606 OID 28204247)
-- Dependencies: 339 339
-- Name: pk_dbturmas_disciplinas_aulas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas_aulas
    ADD CONSTRAINT pk_dbturmas_disciplinas_aulas PRIMARY KEY (codigo);


--
-- TOC entry 3953 (class 2606 OID 28204249)
-- Dependencies: 340 340
-- Name: pk_dbturmas_disciplinas_avaliacao_detalhamento; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas_avaliacao_detalhamento
    ADD CONSTRAINT pk_dbturmas_disciplinas_avaliacao_detalhamento PRIMARY KEY (codigo);


--
-- TOC entry 3957 (class 2606 OID 28204251)
-- Dependencies: 343 343
-- Name: pk_dbturmas_disciplinas_avaliacoes; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas_avaliacoes
    ADD CONSTRAINT pk_dbturmas_disciplinas_avaliacoes PRIMARY KEY (codigo);


--
-- TOC entry 3961 (class 2606 OID 28204253)
-- Dependencies: 345 345
-- Name: pk_dbturmas_disciplinas_materiais; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas_materiais
    ADD CONSTRAINT pk_dbturmas_disciplinas_materiais PRIMARY KEY (codigo);


--
-- TOC entry 3965 (class 2606 OID 28204255)
-- Dependencies: 347 347
-- Name: pk_dbturmas_disciplinas_planoaulas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas_planoaulas
    ADD CONSTRAINT pk_dbturmas_disciplinas_planoaulas PRIMARY KEY (codigo);


--
-- TOC entry 3969 (class 2606 OID 28204257)
-- Dependencies: 349 349
-- Name: pk_dbturmas_requisitos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_requisitos
    ADD CONSTRAINT pk_dbturmas_requisitos PRIMARY KEY (codigo);


--
-- TOC entry 3973 (class 2606 OID 28204259)
-- Dependencies: 351 351
-- Name: pk_dbunidades; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbunidades
    ADD CONSTRAINT pk_dbunidades PRIMARY KEY (codigo);


--
-- TOC entry 3977 (class 2606 OID 28204261)
-- Dependencies: 353 353
-- Name: pk_dbunidades_parametros; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbunidades_parametros
    ADD CONSTRAINT pk_dbunidades_parametros PRIMARY KEY (codigo);


--
-- TOC entry 3981 (class 2606 OID 28204263)
-- Dependencies: 355 355
-- Name: pk_dbusuarios; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbusuarios
    ADD CONSTRAINT pk_dbusuarios PRIMARY KEY (codigo);


--
-- TOC entry 3985 (class 2606 OID 28204265)
-- Dependencies: 357 357
-- Name: pk_dbusuarios_erros; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbusuarios_erros
    ADD CONSTRAINT pk_dbusuarios_erros PRIMARY KEY (codigo);


--
-- TOC entry 3989 (class 2606 OID 28204267)
-- Dependencies: 359 359
-- Name: pk_dbusuarios_historico; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbusuarios_historico
    ADD CONSTRAINT pk_dbusuarios_historico PRIMARY KEY (codigo);


--
-- TOC entry 3994 (class 2606 OID 28204269)
-- Dependencies: 361 361
-- Name: pk_dbusuarios_privilegios; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbusuarios_privilegios
    ADD CONSTRAINT pk_dbusuarios_privilegios PRIMARY KEY (codigo);


--
-- TOC entry 3576 (class 2606 OID 28204271)
-- Dependencies: 148 148
-- Name: pk_id_dbalunos_disciplinas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_disciplinas
    ADD CONSTRAINT pk_id_dbalunos_disciplinas UNIQUE (id);


--
-- TOC entry 3580 (class 2606 OID 28204273)
-- Dependencies: 150 150
-- Name: pk_id_dbalunos_disciplinas_aproveitamentos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_disciplinas_aproveitamentos
    ADD CONSTRAINT pk_id_dbalunos_disciplinas_aproveitamentos UNIQUE (id);


--
-- TOC entry 3584 (class 2606 OID 28204275)
-- Dependencies: 152 152
-- Name: pk_id_dbalunos_faltas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_faltas
    ADD CONSTRAINT pk_id_dbalunos_faltas UNIQUE (id);


--
-- TOC entry 3588 (class 2606 OID 28204277)
-- Dependencies: 154 154
-- Name: pk_id_dbalunos_notas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_notas
    ADD CONSTRAINT pk_id_dbalunos_notas UNIQUE (id);


--
-- TOC entry 3592 (class 2606 OID 28204279)
-- Dependencies: 156 156
-- Name: pk_id_dbalunos_requisitos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_requisitos
    ADD CONSTRAINT pk_id_dbalunos_requisitos UNIQUE (id);


--
-- TOC entry 3596 (class 2606 OID 28204281)
-- Dependencies: 158 158
-- Name: pk_id_dbalunos_solicitacoes; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_solicitacoes
    ADD CONSTRAINT pk_id_dbalunos_solicitacoes UNIQUE (id);


--
-- TOC entry 3600 (class 2606 OID 28204283)
-- Dependencies: 160 160
-- Name: pk_id_dbalunos_transacoes; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_transacoes
    ADD CONSTRAINT pk_id_dbalunos_transacoes UNIQUE (id);


--
-- TOC entry 3604 (class 2606 OID 28204285)
-- Dependencies: 161 161
-- Name: pk_id_dbavaliacoes; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbavaliacoes
    ADD CONSTRAINT pk_id_dbavaliacoes UNIQUE (id);


--
-- TOC entry 3608 (class 2606 OID 28204287)
-- Dependencies: 163 163
-- Name: pk_id_dbavaliacoes_regras; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbavaliacoes_regras
    ADD CONSTRAINT pk_id_dbavaliacoes_regras UNIQUE (id);


--
-- TOC entry 3612 (class 2606 OID 28204289)
-- Dependencies: 166 166
-- Name: pk_id_dbbalanco_patrimonial; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbbalanco_patrimonial
    ADD CONSTRAINT pk_id_dbbalanco_patrimonial UNIQUE (id);


--
-- TOC entry 3616 (class 2606 OID 28204291)
-- Dependencies: 168 168
-- Name: pk_id_dbbiblioteca_cdu; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbbiblioteca_cdu
    ADD CONSTRAINT pk_id_dbbiblioteca_cdu UNIQUE (id);


--
-- TOC entry 3622 (class 2606 OID 28204293)
-- Dependencies: 170 170
-- Name: pk_id_dbcaixa; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcaixa
    ADD CONSTRAINT pk_id_dbcaixa UNIQUE (id);


--
-- TOC entry 3626 (class 2606 OID 28204295)
-- Dependencies: 172 172
-- Name: pk_id_dbcaixa_fechamentos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcaixa_fechamentos
    ADD CONSTRAINT pk_id_dbcaixa_fechamentos UNIQUE (id);


--
-- TOC entry 3630 (class 2606 OID 28204297)
-- Dependencies: 174 174
-- Name: pk_id_dbcaixa_funcionarios; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcaixa_funcionarios
    ADD CONSTRAINT pk_id_dbcaixa_funcionarios UNIQUE (id);


--
-- TOC entry 3646 (class 2606 OID 28204299)
-- Dependencies: 184 184
-- Name: pk_id_dbcaixa_historico; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcontas_caixa_historico
    ADD CONSTRAINT pk_id_dbcaixa_historico UNIQUE (id);


--
-- TOC entry 3634 (class 2606 OID 28204301)
-- Dependencies: 176 176
-- Name: pk_id_dbcargos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcargos
    ADD CONSTRAINT pk_id_dbcargos UNIQUE (id);


--
-- TOC entry 3652 (class 2606 OID 28204303)
-- Dependencies: 186 186
-- Name: pk_id_dbcheques; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcontas_cheques
    ADD CONSTRAINT pk_id_dbcheques UNIQUE (id);


--
-- TOC entry 3638 (class 2606 OID 28204305)
-- Dependencies: 180 180
-- Name: pk_id_dbcompras; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcompras
    ADD CONSTRAINT pk_id_dbcompras UNIQUE (id);


--
-- TOC entry 3642 (class 2606 OID 28204307)
-- Dependencies: 182 182
-- Name: pk_id_dbcontas_caixa; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcontas_caixa
    ADD CONSTRAINT pk_id_dbcontas_caixa UNIQUE (id);


--
-- TOC entry 3907 (class 2606 OID 28204309)
-- Dependencies: 317 317
-- Name: pk_id_dbcontas_extornos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes_contas_extornos
    ADD CONSTRAINT pk_id_dbcontas_extornos UNIQUE (id);


--
-- TOC entry 3656 (class 2606 OID 28204311)
-- Dependencies: 188 188
-- Name: pk_id_dbcontratos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcontratos
    ADD CONSTRAINT pk_id_dbcontratos UNIQUE (id);


--
-- TOC entry 3663 (class 2606 OID 28204313)
-- Dependencies: 191 191
-- Name: pk_id_dbconvenios_descontos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbconvenios_descontos
    ADD CONSTRAINT pk_id_dbconvenios_descontos UNIQUE (id);


--
-- TOC entry 3667 (class 2606 OID 28204315)
-- Dependencies: 194 194
-- Name: pk_id_dbcotacoes; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcotacoes
    ADD CONSTRAINT pk_id_dbcotacoes UNIQUE (id);


--
-- TOC entry 3671 (class 2606 OID 28204317)
-- Dependencies: 196 196
-- Name: pk_id_dbcrm_demandas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcrm_demandas
    ADD CONSTRAINT pk_id_dbcrm_demandas UNIQUE (id);


--
-- TOC entry 3675 (class 2606 OID 28204319)
-- Dependencies: 198 198
-- Name: pk_id_dbcurriculos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcurriculos
    ADD CONSTRAINT pk_id_dbcurriculos UNIQUE (id);


--
-- TOC entry 3679 (class 2606 OID 28204321)
-- Dependencies: 200 200
-- Name: pk_id_dbcursos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcursos
    ADD CONSTRAINT pk_id_dbcursos UNIQUE (id);


--
-- TOC entry 3683 (class 2606 OID 28204323)
-- Dependencies: 202 202
-- Name: pk_id_dbcursos_areas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcursos_areas
    ADD CONSTRAINT pk_id_dbcursos_areas UNIQUE (id);


--
-- TOC entry 3687 (class 2606 OID 28204325)
-- Dependencies: 204 204
-- Name: pk_id_dbcursos_ativos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcursos_ativos
    ADD CONSTRAINT pk_id_dbcursos_ativos UNIQUE (id);


--
-- TOC entry 3691 (class 2606 OID 28204327)
-- Dependencies: 206 206
-- Name: pk_id_dbcursos_avaliacoes; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcursos_avaliacoes
    ADD CONSTRAINT pk_id_dbcursos_avaliacoes UNIQUE (id);


--
-- TOC entry 3695 (class 2606 OID 28204329)
-- Dependencies: 208 208
-- Name: pk_id_dbcursos_disciplinas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcursos_disciplinas
    ADD CONSTRAINT pk_id_dbcursos_disciplinas UNIQUE (id);


--
-- TOC entry 3699 (class 2606 OID 28204331)
-- Dependencies: 210 210
-- Name: pk_id_dbcursos_tipos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcursos_tipos
    ADD CONSTRAINT pk_id_dbcursos_tipos UNIQUE (id);


--
-- TOC entry 3703 (class 2606 OID 28204333)
-- Dependencies: 212 212
-- Name: pk_id_dbdados_boleto; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbdados_boleto
    ADD CONSTRAINT pk_id_dbdados_boleto UNIQUE (id);


--
-- TOC entry 3707 (class 2606 OID 28204335)
-- Dependencies: 214 214
-- Name: pk_id_dbdepartamentos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbdepartamentos
    ADD CONSTRAINT pk_id_dbdepartamentos UNIQUE (id);


--
-- TOC entry 3711 (class 2606 OID 28204337)
-- Dependencies: 216 216
-- Name: pk_id_dbdisciplinas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbdisciplinas
    ADD CONSTRAINT pk_id_dbdisciplinas UNIQUE (id);


--
-- TOC entry 3715 (class 2606 OID 28204339)
-- Dependencies: 218 218
-- Name: pk_id_dbdisciplinas_semelhantes; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbdisciplinas_semelhantes
    ADD CONSTRAINT pk_id_dbdisciplinas_semelhantes UNIQUE (id);


--
-- TOC entry 3719 (class 2606 OID 28204341)
-- Dependencies: 220 220
-- Name: pk_id_dbdocumentos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbdocumentos
    ADD CONSTRAINT pk_id_dbdocumentos UNIQUE (id);


--
-- TOC entry 3723 (class 2606 OID 28204343)
-- Dependencies: 223 223
-- Name: pk_id_dbfuncionarios_ferias; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfuncionarios_ferias
    ADD CONSTRAINT pk_id_dbfuncionarios_ferias UNIQUE (id);


--
-- TOC entry 3727 (class 2606 OID 28204345)
-- Dependencies: 225 225
-- Name: pk_id_dbfuncionarios_folhapagamento; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfuncionarios_folhapagamento
    ADD CONSTRAINT pk_id_dbfuncionarios_folhapagamento UNIQUE (id);


--
-- TOC entry 3731 (class 2606 OID 28204347)
-- Dependencies: 227 227
-- Name: pk_id_dbfuncionarios_ocorrencias; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfuncionarios_ocorrencias
    ADD CONSTRAINT pk_id_dbfuncionarios_ocorrencias UNIQUE (id);


--
-- TOC entry 3737 (class 2606 OID 28204349)
-- Dependencies: 229 229
-- Name: pk_id_dbfuncionarios_professores; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfuncionarios_professores
    ADD CONSTRAINT pk_id_dbfuncionarios_professores UNIQUE (id);


--
-- TOC entry 3741 (class 2606 OID 28204351)
-- Dependencies: 231 231
-- Name: pk_id_dbfuncionarios_treinamentos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfuncionarios_treinamentos
    ADD CONSTRAINT pk_id_dbfuncionarios_treinamentos UNIQUE (id);


--
-- TOC entry 3745 (class 2606 OID 28204353)
-- Dependencies: 232 232
-- Name: pk_id_dbgrade_avaliacoes; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbgrade_avaliacoes
    ADD CONSTRAINT pk_id_dbgrade_avaliacoes UNIQUE (id);


--
-- TOC entry 3753 (class 2606 OID 28204355)
-- Dependencies: 238 238
-- Name: pk_id_dbpatrimonios_livros; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpatrimonios_livros
    ADD CONSTRAINT pk_id_dbpatrimonios_livros UNIQUE (id);


--
-- TOC entry 3757 (class 2606 OID 28204357)
-- Dependencies: 240 240
-- Name: pk_id_dbpessoas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas
    ADD CONSTRAINT pk_id_dbpessoas UNIQUE (id);


--
-- TOC entry 3761 (class 2606 OID 28204359)
-- Dependencies: 242 242
-- Name: pk_id_dbpessoas_alunos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_alunos
    ADD CONSTRAINT pk_id_dbpessoas_alunos UNIQUE (id);


--
-- TOC entry 3769 (class 2606 OID 28204361)
-- Dependencies: 246 246
-- Name: pk_id_dbpessoas_complemento_pj; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_complemento_pj
    ADD CONSTRAINT pk_id_dbpessoas_complemento_pj UNIQUE (id);


--
-- TOC entry 3774 (class 2606 OID 28204363)
-- Dependencies: 248 248
-- Name: pk_id_dbpessoas_convenios; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_convenios
    ADD CONSTRAINT pk_id_dbpessoas_convenios UNIQUE (id);


--
-- TOC entry 3778 (class 2606 OID 28204365)
-- Dependencies: 250 250
-- Name: pk_id_dbpessoas_demandas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_demandas
    ADD CONSTRAINT pk_id_dbpessoas_demandas UNIQUE (id);


--
-- TOC entry 3786 (class 2606 OID 28204367)
-- Dependencies: 254 254
-- Name: pk_id_dbpessoas_formacoes; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_formacoes
    ADD CONSTRAINT pk_id_dbpessoas_formacoes UNIQUE (id);


--
-- TOC entry 3790 (class 2606 OID 28204369)
-- Dependencies: 256 256
-- Name: pk_id_dbpessoas_funcionarios; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_funcionarios
    ADD CONSTRAINT pk_id_dbpessoas_funcionarios UNIQUE (id);


--
-- TOC entry 3794 (class 2606 OID 28204371)
-- Dependencies: 258 258
-- Name: pk_id_dbpessoas_inscricoes; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_inscricoes
    ADD CONSTRAINT pk_id_dbpessoas_inscricoes UNIQUE (id);


--
-- TOC entry 3798 (class 2606 OID 28204373)
-- Dependencies: 260 260
-- Name: pk_id_dbpessoas_livros; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_livros
    ADD CONSTRAINT pk_id_dbpessoas_livros UNIQUE (id);


--
-- TOC entry 3802 (class 2606 OID 28204375)
-- Dependencies: 262 262
-- Name: pk_id_dbpessoas_solicitacoes; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_solicitacoes
    ADD CONSTRAINT pk_id_dbpessoas_solicitacoes UNIQUE (id);


--
-- TOC entry 3806 (class 2606 OID 28204377)
-- Dependencies: 264 264
-- Name: pk_id_dbpessoas_titularidades; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_titularidades
    ADD CONSTRAINT pk_id_dbpessoas_titularidades UNIQUE (id);


--
-- TOC entry 3765 (class 2606 OID 28204379)
-- Dependencies: 244 244
-- Name: pk_id_dbpessos_complemento_pf; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_complemento_pf
    ADD CONSTRAINT pk_id_dbpessos_complemento_pf UNIQUE (id);


--
-- TOC entry 3782 (class 2606 OID 28204381)
-- Dependencies: 252 252
-- Name: pk_id_dbpesssoas_enderecoscobrancas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_enderecoscobrancas
    ADD CONSTRAINT pk_id_dbpesssoas_enderecoscobrancas UNIQUE (id);


--
-- TOC entry 3810 (class 2606 OID 28204383)
-- Dependencies: 266 266
-- Name: pk_id_dbplano_contas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbplano_contas
    ADD CONSTRAINT pk_id_dbplano_contas UNIQUE (id);


--
-- TOC entry 3814 (class 2606 OID 28204385)
-- Dependencies: 268 268
-- Name: pk_id_dbprocessos_academicos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprocessos_academicos
    ADD CONSTRAINT pk_id_dbprocessos_academicos UNIQUE (id);


--
-- TOC entry 3819 (class 2606 OID 28204387)
-- Dependencies: 270 270
-- Name: pk_id_dbprodutos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprodutos
    ADD CONSTRAINT pk_id_dbprodutos UNIQUE (id);


--
-- TOC entry 3823 (class 2606 OID 28204389)
-- Dependencies: 272 272
-- Name: pk_id_dbprodutos_insumos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprodutos_caracteristicas
    ADD CONSTRAINT pk_id_dbprodutos_insumos UNIQUE (id);


--
-- TOC entry 3828 (class 2606 OID 28204391)
-- Dependencies: 277 277
-- Name: pk_id_dbprodutos_parametros; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprodutos_parametros
    ADD CONSTRAINT pk_id_dbprodutos_parametros UNIQUE (id);


--
-- TOC entry 3749 (class 2606 OID 28204393)
-- Dependencies: 236 236
-- Name: pk_id_dbprodutos_patrimonios; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpatrimonios
    ADD CONSTRAINT pk_id_dbprodutos_patrimonios UNIQUE (id);


--
-- TOC entry 3832 (class 2606 OID 28204395)
-- Dependencies: 279 279
-- Name: pk_id_dbprodutos_tabelapreco; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprodutos_tabelapreco
    ADD CONSTRAINT pk_id_dbprodutos_tabelapreco UNIQUE (id);


--
-- TOC entry 3836 (class 2606 OID 28204397)
-- Dependencies: 281 281
-- Name: pk_id_dbprodutos_tipos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprodutos_tipos
    ADD CONSTRAINT pk_id_dbprodutos_tipos UNIQUE (id);


--
-- TOC entry 3840 (class 2606 OID 28204399)
-- Dependencies: 283 283
-- Name: pk_id_dbprodutos_tributos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprodutos_tributos
    ADD CONSTRAINT pk_id_dbprodutos_tributos UNIQUE (id);


--
-- TOC entry 3844 (class 2606 OID 28204401)
-- Dependencies: 285 285
-- Name: pk_id_dbprofessores_areas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprofessores_areas
    ADD CONSTRAINT pk_id_dbprofessores_areas UNIQUE (id);


--
-- TOC entry 3848 (class 2606 OID 28204403)
-- Dependencies: 287 287
-- Name: pk_id_dbprojetos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprojetos
    ADD CONSTRAINT pk_id_dbprojetos UNIQUE (id);


--
-- TOC entry 3852 (class 2606 OID 28204405)
-- Dependencies: 289 289
-- Name: pk_id_dbprojetos_colaboradores; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprojetos_colaboradores
    ADD CONSTRAINT pk_id_dbprojetos_colaboradores UNIQUE (id);


--
-- TOC entry 3856 (class 2606 OID 28204407)
-- Dependencies: 291 291
-- Name: pk_id_dbprojetos_custos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprojetos_custos
    ADD CONSTRAINT pk_id_dbprojetos_custos UNIQUE (id);


--
-- TOC entry 3860 (class 2606 OID 28204409)
-- Dependencies: 293 293
-- Name: pk_id_dbprojetos_recursos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprojetos_recursos
    ADD CONSTRAINT pk_id_dbprojetos_recursos UNIQUE (id);


--
-- TOC entry 3864 (class 2606 OID 28204411)
-- Dependencies: 295 295
-- Name: pk_id_dbquestionarios; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbquestionarios
    ADD CONSTRAINT pk_id_dbquestionarios UNIQUE (id);


--
-- TOC entry 3868 (class 2606 OID 28204413)
-- Dependencies: 297 297
-- Name: pk_id_dbquestoes; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbquestoes
    ADD CONSTRAINT pk_id_dbquestoes UNIQUE (id);


--
-- TOC entry 3872 (class 2606 OID 28204415)
-- Dependencies: 299 299
-- Name: pk_id_dbquestoes_itens; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbquestoes_itens
    ADD CONSTRAINT pk_id_dbquestoes_itens UNIQUE (id);


--
-- TOC entry 3876 (class 2606 OID 28204417)
-- Dependencies: 301 301
-- Name: pk_id_dbrecados; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbrecados
    ADD CONSTRAINT pk_id_dbrecados UNIQUE (id);


--
-- TOC entry 3880 (class 2606 OID 28204419)
-- Dependencies: 303 303
-- Name: pk_id_dbsalas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbsalas
    ADD CONSTRAINT pk_id_dbsalas UNIQUE (id);


--
-- TOC entry 3884 (class 2606 OID 28204421)
-- Dependencies: 305 305
-- Name: pk_id_dbscorecard; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbscorecard
    ADD CONSTRAINT pk_id_dbscorecard UNIQUE (id);


--
-- TOC entry 3888 (class 2606 OID 28204423)
-- Dependencies: 307 307
-- Name: pk_id_dbscorecard_sentecas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbscorecard_sentencas
    ADD CONSTRAINT pk_id_dbscorecard_sentecas UNIQUE (id);


--
-- TOC entry 3894 (class 2606 OID 28204425)
-- Dependencies: 311 311
-- Name: pk_id_dbtransacoes; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes
    ADD CONSTRAINT pk_id_dbtransacoes UNIQUE (id);


--
-- TOC entry 3898 (class 2606 OID 28204427)
-- Dependencies: 313 313
-- Name: pk_id_dbtransacoes_contas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes_contas
    ADD CONSTRAINT pk_id_dbtransacoes_contas UNIQUE (id);


--
-- TOC entry 3903 (class 2606 OID 28204429)
-- Dependencies: 315 315
-- Name: pk_id_dbtransacoes_contas_duplicatas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes_contas_duplicatas
    ADD CONSTRAINT pk_id_dbtransacoes_contas_duplicatas UNIQUE (id);


--
-- TOC entry 3911 (class 2606 OID 28204431)
-- Dependencies: 318 318
-- Name: pk_id_dbtransacoes_contas_situacao; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes_contas_situacao
    ADD CONSTRAINT pk_id_dbtransacoes_contas_situacao UNIQUE (id);


--
-- TOC entry 3915 (class 2606 OID 28204433)
-- Dependencies: 320 320
-- Name: pk_id_dbtransacoes_convenios; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes_convenios
    ADD CONSTRAINT pk_id_dbtransacoes_convenios UNIQUE (id);


--
-- TOC entry 3919 (class 2606 OID 28204435)
-- Dependencies: 323 323
-- Name: pk_id_dbtransacoes_produtos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes_produtos
    ADD CONSTRAINT pk_id_dbtransacoes_produtos UNIQUE (id);


--
-- TOC entry 3923 (class 2606 OID 28204437)
-- Dependencies: 325 325
-- Name: pk_id_dbtreinamentos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtreinamentos
    ADD CONSTRAINT pk_id_dbtreinamentos UNIQUE (id);


--
-- TOC entry 3927 (class 2606 OID 28204439)
-- Dependencies: 327 327
-- Name: pk_id_dbtributos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtributos
    ADD CONSTRAINT pk_id_dbtributos UNIQUE (id);


--
-- TOC entry 3931 (class 2606 OID 28204441)
-- Dependencies: 329 329
-- Name: pk_id_dbturmas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas
    ADD CONSTRAINT pk_id_dbturmas UNIQUE (id);


--
-- TOC entry 3935 (class 2606 OID 28204443)
-- Dependencies: 330 330
-- Name: pk_id_dbturmas_convenios; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_convenios
    ADD CONSTRAINT pk_id_dbturmas_convenios UNIQUE (id);


--
-- TOC entry 3939 (class 2606 OID 28204445)
-- Dependencies: 333 333
-- Name: pk_id_dbturmas_descontos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_descontos
    ADD CONSTRAINT pk_id_dbturmas_descontos UNIQUE (id);


--
-- TOC entry 3943 (class 2606 OID 28204447)
-- Dependencies: 335 335
-- Name: pk_id_dbturmas_disciplinas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas
    ADD CONSTRAINT pk_id_dbturmas_disciplinas UNIQUE (id);


--
-- TOC entry 3947 (class 2606 OID 28204449)
-- Dependencies: 337 337
-- Name: pk_id_dbturmas_disciplinas_arquivos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas_arquivos
    ADD CONSTRAINT pk_id_dbturmas_disciplinas_arquivos UNIQUE (id);


--
-- TOC entry 3951 (class 2606 OID 28204451)
-- Dependencies: 339 339
-- Name: pk_id_dbturmas_disciplinas_aulas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas_aulas
    ADD CONSTRAINT pk_id_dbturmas_disciplinas_aulas UNIQUE (id);


--
-- TOC entry 3955 (class 2606 OID 28204453)
-- Dependencies: 340 340
-- Name: pk_id_dbturmas_disciplinas_avaliacao_detalhamento; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas_avaliacao_detalhamento
    ADD CONSTRAINT pk_id_dbturmas_disciplinas_avaliacao_detalhamento UNIQUE (id);


--
-- TOC entry 3959 (class 2606 OID 28204455)
-- Dependencies: 343 343
-- Name: pk_id_dbturmas_disciplinas_avaliacoes; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas_avaliacoes
    ADD CONSTRAINT pk_id_dbturmas_disciplinas_avaliacoes UNIQUE (id);


--
-- TOC entry 3963 (class 2606 OID 28204457)
-- Dependencies: 345 345
-- Name: pk_id_dbturmas_disciplinas_materiais; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas_materiais
    ADD CONSTRAINT pk_id_dbturmas_disciplinas_materiais UNIQUE (id);


--
-- TOC entry 3967 (class 2606 OID 28204459)
-- Dependencies: 347 347
-- Name: pk_id_dbturmas_disciplinas_planoaulas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas_planoaulas
    ADD CONSTRAINT pk_id_dbturmas_disciplinas_planoaulas UNIQUE (id);


--
-- TOC entry 3971 (class 2606 OID 28204461)
-- Dependencies: 349 349
-- Name: pk_id_dbturmas_requisitos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_requisitos
    ADD CONSTRAINT pk_id_dbturmas_requisitos UNIQUE (id);


--
-- TOC entry 3975 (class 2606 OID 28204463)
-- Dependencies: 351 351
-- Name: pk_id_dbunidades; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbunidades
    ADD CONSTRAINT pk_id_dbunidades UNIQUE (id);


--
-- TOC entry 3979 (class 2606 OID 28204465)
-- Dependencies: 353 353
-- Name: pk_id_dbunidades_parametros; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbunidades_parametros
    ADD CONSTRAINT pk_id_dbunidades_parametros UNIQUE (id);


--
-- TOC entry 3983 (class 2606 OID 28204467)
-- Dependencies: 355 355
-- Name: pk_id_dbusuarios; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbusuarios
    ADD CONSTRAINT pk_id_dbusuarios UNIQUE (id);


--
-- TOC entry 3987 (class 2606 OID 28204469)
-- Dependencies: 357 357
-- Name: pk_id_dbusuarios_erros; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbusuarios_erros
    ADD CONSTRAINT pk_id_dbusuarios_erros UNIQUE (id);


--
-- TOC entry 3991 (class 2606 OID 28204471)
-- Dependencies: 359 359
-- Name: pk_id_dbusuarios_historico; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbusuarios_historico
    ADD CONSTRAINT pk_id_dbusuarios_historico UNIQUE (id);


--
-- TOC entry 3996 (class 2606 OID 28204473)
-- Dependencies: 361 361
-- Name: pk_id_dbusuarios_privilegios; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbusuarios_privilegios
    ADD CONSTRAINT pk_id_dbusuarios_privilegios UNIQUE (id);


--
-- TOC entry 3647 (class 1259 OID 28204474)
-- Dependencies: 186
-- Name: fki__dbtransacoes_contas__dbcontas_cheques; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki__dbtransacoes_contas__dbcontas_cheques ON dbcontas_cheques USING btree (codigoconta);


--
-- TOC entry 3648 (class 1259 OID 28204475)
-- Dependencies: 186
-- Name: fki_dbcaixa__dbpessoas_cheques__codigocaixa; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_dbcaixa__dbpessoas_cheques__codigocaixa ON dbcontas_cheques USING btree (codigocaixa);


--
-- TOC entry 3617 (class 1259 OID 28204476)
-- Dependencies: 170
-- Name: fki_dbcaixa_funcionarios__dbcaixa__codigocaixafuncionario; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_dbcaixa_funcionarios__dbcaixa__codigocaixafuncionario ON dbcaixa USING btree (codigofuncionario);


--
-- TOC entry 3618 (class 1259 OID 28204477)
-- Dependencies: 170
-- Name: fki_dbcontas_caixa_historico__dbcaixa__codigohistorico; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_dbcontas_caixa_historico__dbcaixa__codigohistorico ON dbcaixa USING btree (codigohistorico);


--
-- TOC entry 3770 (class 1259 OID 28204478)
-- Dependencies: 248
-- Name: fki_dbcontratos__dbpessoas_convenios__codigoconvenio; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_dbcontratos__dbpessoas_convenios__codigoconvenio ON dbpessoas_convenios USING btree (codigoconvenio);


--
-- TOC entry 3657 (class 1259 OID 28204479)
-- Dependencies: 190
-- Name: fki_dbplano_contas_dbconvenios_codigoplanoconta; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_dbplano_contas_dbconvenios_codigoplanoconta ON dbconvenios USING btree (codigoplanoconta);


--
-- TOC entry 3824 (class 1259 OID 28204480)
-- Dependencies: 277
-- Name: fki_dbprodutos_tipos__dbprodutos__codigotipoproduto; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_dbprodutos_tipos__dbprodutos__codigotipoproduto ON dbprodutos_parametros USING btree (codigotipoproduto);


--
-- TOC entry 3815 (class 1259 OID 28204481)
-- Dependencies: 270
-- Name: fki_dbprodutos_tipos__dbprodutos_codigotipoproduto; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_dbprodutos_tipos__dbprodutos_codigotipoproduto ON dbprodutos USING btree (codigotipoproduto);


--
-- TOC entry 3992 (class 1259 OID 28204482)
-- Dependencies: 361 361
-- Name: idx_usuarios_privilegios; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_usuarios_privilegios ON dbusuarios_privilegios USING btree (codigousuario, funcionalidade);


--
-- TOC entry 3899 (class 1259 OID 38736033)
-- Dependencies: 315 315 315
-- Name: index_dbtransacoes_contas_duplicatas; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_dbtransacoes_contas_duplicatas ON dbtransacoes_contas_duplicatas USING btree (codigoconta, ndocumento, codigopessoa);


--
-- TOC entry 4225 (class 2620 OID 37189720)
-- Dependencies: 457 240
-- Name: atualiza_pessoa_funcionario; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER atualiza_pessoa_funcionario
    AFTER INSERT OR DELETE OR UPDATE ON dbpessoas
    FOR EACH ROW
    EXECUTE PROCEDURE atualiza_pessoa_funcionario();


--
-- TOC entry 4040 (class 2606 OID 28204483)
-- Dependencies: 313 186 3895
-- Name: fk__dbtransacoes_contas__dbcontas_cheques; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcontas_cheques
    ADD CONSTRAINT fk__dbtransacoes_contas__dbcontas_cheques FOREIGN KEY (codigoconta) REFERENCES dbtransacoes_contas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3997 (class 2606 OID 28204488)
-- Dependencies: 148 3758 242
-- Name: fk_dbalunos__dbalunos_disciplinas__codigoaluno; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_disciplinas
    ADD CONSTRAINT fk_dbalunos__dbalunos_disciplinas__codigoaluno FOREIGN KEY (codigoaluno) REFERENCES dbpessoas_alunos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4003 (class 2606 OID 28204493)
-- Dependencies: 152 3758 242
-- Name: fk_dbalunos__dbalunos_faltas__codigoaluno; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_faltas
    ADD CONSTRAINT fk_dbalunos__dbalunos_faltas__codigoaluno FOREIGN KEY (codigoaluno) REFERENCES dbpessoas_alunos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4007 (class 2606 OID 28204498)
-- Dependencies: 154 3758 242
-- Name: fk_dbalunos__dbalunos_notas__codigoaluno; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_notas
    ADD CONSTRAINT fk_dbalunos__dbalunos_notas__codigoaluno FOREIGN KEY (codigoaluno) REFERENCES dbpessoas_alunos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4001 (class 2606 OID 28204503)
-- Dependencies: 150 3573 148
-- Name: fk_dbalunos_disciplinas__dbalunos_disciplinas_aproveitamentos__; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_disciplinas_aproveitamentos
    ADD CONSTRAINT fk_dbalunos_disciplinas__dbalunos_disciplinas_aproveitamentos__ FOREIGN KEY (codigoalunodisciplina) REFERENCES dbalunos_disciplinas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4020 (class 2606 OID 28204508)
-- Dependencies: 3742 232 161
-- Name: fk_dbavalia_fk_dbgrad_dbgrade_; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbavaliacoes
    ADD CONSTRAINT fk_dbavalia_fk_dbgrad_dbgrade_ FOREIGN KEY (codigograde) REFERENCES dbgrade_avaliacoes(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4088 (class 2606 OID 28204513)
-- Dependencies: 168 3613 238
-- Name: fk_dbbiblioteca_cdu__dbpatrimonios_livros__codigocdu; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpatrimonios_livros
    ADD CONSTRAINT fk_dbbiblioteca_cdu__dbpatrimonios_livros__codigocdu FOREIGN KEY (codigocdu) REFERENCES dbbiblioteca_cdu(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4041 (class 2606 OID 28204518)
-- Dependencies: 170 3619 186
-- Name: fk_dbcaixa__dbpessoas_cheques__codigocaixa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcontas_cheques
    ADD CONSTRAINT fk_dbcaixa__dbpessoas_cheques__codigocaixa FOREIGN KEY (codigocaixa) REFERENCES dbcaixa(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4112 (class 2606 OID 28204523)
-- Dependencies: 176 3631 256
-- Name: fk_dbcargos__dbpessoas_funcionarios__codigocargo; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_funcionarios
    ADD CONSTRAINT fk_dbcargos__dbpessoas_funcionarios__codigocargo FOREIGN KEY (codigocargo) REFERENCES dbcargos(codigo);


--
-- TOC entry 4023 (class 2606 OID 28204528)
-- Dependencies: 182 3639 170
-- Name: fk_dbcontas_caixa__dbcaixa__codigocontacaixa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcaixa
    ADD CONSTRAINT fk_dbcontas_caixa__dbcaixa__codigocontacaixa FOREIGN KEY (codigocontacaixa) REFERENCES dbcontas_caixa(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4031 (class 2606 OID 28204533)
-- Dependencies: 174 3639 182
-- Name: fk_dbcontas_caixa__dbcaixa__codigocontacaixa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcaixa_funcionarios
    ADD CONSTRAINT fk_dbcontas_caixa__dbcaixa__codigocontacaixa FOREIGN KEY (codigocontacaixa) REFERENCES dbcontas_caixa(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4038 (class 2606 OID 28204538)
-- Dependencies: 182 184 3639
-- Name: fk_dbcontas_caixa__dbcontas_caixa_historico__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcontas_caixa_historico
    ADD CONSTRAINT fk_dbcontas_caixa__dbcontas_caixa_historico__unidade FOREIGN KEY (codigocontacaixa) REFERENCES dbcontas_caixa(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4024 (class 2606 OID 28204543)
-- Dependencies: 184 170 3643
-- Name: fk_dbcontas_caixa_historico__dbcaixa__codigohistorico; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcaixa
    ADD CONSTRAINT fk_dbcontas_caixa_historico__dbcaixa__codigohistorico FOREIGN KEY (codigohistorico) REFERENCES dbcontas_caixa_historico(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4101 (class 2606 OID 28204548)
-- Dependencies: 3658 248 190
-- Name: fk_dbcontratos__dbpessoas_convenios__codigoconvenio; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_convenios
    ADD CONSTRAINT fk_dbcontratos__dbpessoas_convenios__codigoconvenio FOREIGN KEY (codigoconvenio) REFERENCES dbconvenios(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4046 (class 2606 OID 28204553)
-- Dependencies: 190 191 3658
-- Name: fk_dbconvenios__dbconvenios_descontos__codigoconvenio; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbconvenios_descontos
    ADD CONSTRAINT fk_dbconvenios__dbconvenios_descontos__codigoconvenio FOREIGN KEY (codigoconvenio) REFERENCES dbconvenios(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4176 (class 2606 OID 28204558)
-- Dependencies: 320 190 3658
-- Name: fk_dbconvenios__dbtransacoes_convenios__codigoconvenio; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes_convenios
    ADD CONSTRAINT fk_dbconvenios__dbtransacoes_convenios__codigoconvenio FOREIGN KEY (codigoconvenio) REFERENCES dbconvenios(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4188 (class 2606 OID 28204563)
-- Dependencies: 330 190 3658
-- Name: fk_dbconvenios__dbturmas_convenios__codigoconvenio; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_convenios
    ADD CONSTRAINT fk_dbconvenios__dbturmas_convenios__codigoconvenio FOREIGN KEY (codigoconvenio) REFERENCES dbconvenios(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4058 (class 2606 OID 28204568)
-- Dependencies: 200 3676 204
-- Name: fk_dbcursos__dbcursos_ativos__codigocurso; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcursos_ativos
    ADD CONSTRAINT fk_dbcursos__dbcursos_ativos__codigocurso FOREIGN KEY (codigocurso) REFERENCES dbcursos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4060 (class 2606 OID 28204573)
-- Dependencies: 200 3676 206
-- Name: fk_dbcursos__dbcursos_avaliacoes__codigocurso; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcursos_avaliacoes
    ADD CONSTRAINT fk_dbcursos__dbcursos_avaliacoes__codigocurso FOREIGN KEY (codigocurso) REFERENCES dbcursos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4062 (class 2606 OID 28204578)
-- Dependencies: 3676 200 208
-- Name: fk_dbcursos__dbcursos_disciplinas__codigocurso; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcursos_disciplinas
    ADD CONSTRAINT fk_dbcursos__dbcursos_disciplinas__codigocurso FOREIGN KEY (codigocurso) REFERENCES dbcursos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4070 (class 2606 OID 28204583)
-- Dependencies: 218 216 3708
-- Name: fk_dbcursos__dbdisciplinas_semelhantes__codigodisciplinasemelha; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbdisciplinas_semelhantes
    ADD CONSTRAINT fk_dbcursos__dbdisciplinas_semelhantes__codigodisciplinasemelha FOREIGN KEY (codigodisciplina) REFERENCES dbdisciplinas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4092 (class 2606 OID 28204588)
-- Dependencies: 3676 200 242
-- Name: fk_dbcursos__dbpessoas_alunos__codigocurso; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_alunos
    ADD CONSTRAINT fk_dbcursos__dbpessoas_alunos__codigocurso FOREIGN KEY (codigocurso) REFERENCES dbcursos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4104 (class 2606 OID 28204593)
-- Dependencies: 200 250 3676
-- Name: fk_dbcursos__dbpessoas_demandas__codigocurso; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_demandas
    ADD CONSTRAINT fk_dbcursos__dbpessoas_demandas__codigocurso FOREIGN KEY (codigocurso) REFERENCES dbcursos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4116 (class 2606 OID 28204598)
-- Dependencies: 200 3676 258
-- Name: fk_dbcursos__dbpessoas_inscricoes__codigocurso; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_inscricoes
    ADD CONSTRAINT fk_dbcursos__dbpessoas_inscricoes__codigocurso FOREIGN KEY (codigocurso) REFERENCES dbcursos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4184 (class 2606 OID 28204603)
-- Dependencies: 329 3676 200
-- Name: fk_dbcursos__dbturmas__codigocurso; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas
    ADD CONSTRAINT fk_dbcursos__dbturmas__codigocurso FOREIGN KEY (codigocurso) REFERENCES dbcursos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4053 (class 2606 OID 28204608)
-- Dependencies: 3680 200 202
-- Name: fk_dbcursos_areas__dbcursos__codigoareacurso; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcursos
    ADD CONSTRAINT fk_dbcursos_areas__dbcursos__codigoareacurso FOREIGN KEY (codigoareacurso) REFERENCES dbcursos_areas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4143 (class 2606 OID 28204613)
-- Dependencies: 3680 202 285
-- Name: fk_dbcursos_areas__dbprofessores_areas__codigoareacurso; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprofessores_areas
    ADD CONSTRAINT fk_dbcursos_areas__dbprofessores_areas__codigoareacurso FOREIGN KEY (codigoareacurso) REFERENCES dbcursos_areas(codigo);


--
-- TOC entry 4185 (class 2606 OID 28204618)
-- Dependencies: 3684 329 204
-- Name: fk_dbcursos_ativos__dbturmas__codigocursoativo; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas
    ADD CONSTRAINT fk_dbcursos_ativos__dbturmas__codigocursoativo FOREIGN KEY (codigocursoativo) REFERENCES dbcursos_ativos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4054 (class 2606 OID 28204623)
-- Dependencies: 210 200 3696
-- Name: fk_dbcursos_tipos__dbcursos__codigotipocurso; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcursos
    ADD CONSTRAINT fk_dbcursos_tipos__dbcursos__codigotipocurso FOREIGN KEY (codigotipocurso) REFERENCES dbcursos_tipos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4013 (class 2606 OID 28204628)
-- Dependencies: 158 214 3704
-- Name: fk_dbdepartamentos__dbalunos_solicitacoes__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_solicitacoes
    ADD CONSTRAINT fk_dbdepartamentos__dbalunos_solicitacoes__unidade FOREIGN KEY (codigodepartamento) REFERENCES dbdepartamentos(codigo);


--
-- TOC entry 4113 (class 2606 OID 28204633)
-- Dependencies: 3704 214 256
-- Name: fk_dbdepartamentos__dbpessoas_funcionarios__codigodepartamento; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_funcionarios
    ADD CONSTRAINT fk_dbdepartamentos__dbpessoas_funcionarios__codigodepartamento FOREIGN KEY (codigodepartamento) REFERENCES dbdepartamentos(codigo);


--
-- TOC entry 4124 (class 2606 OID 28204638)
-- Dependencies: 3704 214 262
-- Name: fk_dbdepartamentos__dbpessoas_solicitacoes__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_solicitacoes
    ADD CONSTRAINT fk_dbdepartamentos__dbpessoas_solicitacoes__unidade FOREIGN KEY (codigodepartamento) REFERENCES dbdepartamentos(codigo);


--
-- TOC entry 4063 (class 2606 OID 28204643)
-- Dependencies: 208 216 3708
-- Name: fk_dbdisciplinas__dbcursos_disciplinas__codigodisciplina; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcursos_disciplinas
    ADD CONSTRAINT fk_dbdisciplinas__dbcursos_disciplinas__codigodisciplina FOREIGN KEY (codigodisciplina) REFERENCES dbdisciplinas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4071 (class 2606 OID 28204648)
-- Dependencies: 218 216 3708
-- Name: fk_dbdisciplinas__dbdisciplinas_semelhantes__codigodisciplina; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbdisciplinas_semelhantes
    ADD CONSTRAINT fk_dbdisciplinas__dbdisciplinas_semelhantes__codigodisciplina FOREIGN KEY (codigodisciplina) REFERENCES dbdisciplinas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4193 (class 2606 OID 28204653)
-- Dependencies: 335 216 3708
-- Name: fk_dbdisciplinas__dbturmas_disciplinas__codigodisciplina; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas
    ADD CONSTRAINT fk_dbdisciplinas__dbturmas_disciplinas__codigodisciplina FOREIGN KEY (codigodisciplina) REFERENCES dbdisciplinas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4144 (class 2606 OID 28204658)
-- Dependencies: 285 229 3734
-- Name: fk_dbfuncionarios_professores__dbprofessores_areas__codigoprofe; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprofessores_areas
    ADD CONSTRAINT fk_dbfuncionarios_professores__dbprofessores_areas__codigoprofe FOREIGN KEY (codigoprofessor) REFERENCES dbfuncionarios_professores(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4194 (class 2606 OID 28204663)
-- Dependencies: 335 229 3734
-- Name: fk_dbfuncionarios_professores__dbturmas_disciplinas__codigoprof; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas
    ADD CONSTRAINT fk_dbfuncionarios_professores__dbturmas_disciplinas__codigoprof FOREIGN KEY (codigoprofessor) REFERENCES dbfuncionarios_professores(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4199 (class 2606 OID 28204668)
-- Dependencies: 337 229 3734
-- Name: fk_dbfuncionarios_professores__dbturmas_disciplinas_arquivos__c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas_arquivos
    ADD CONSTRAINT fk_dbfuncionarios_professores__dbturmas_disciplinas_arquivos__c FOREIGN KEY (codigoprofessor) REFERENCES dbfuncionarios_professores(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4211 (class 2606 OID 28204673)
-- Dependencies: 347 229 3734
-- Name: fk_dbfuncionarios_professores__dbturmas_disciplinas_planoaulas_; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas_planoaulas
    ADD CONSTRAINT fk_dbfuncionarios_professores__dbturmas_disciplinas_planoaulas_ FOREIGN KEY (codigoprofessor) REFERENCES dbfuncionarios_professores(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4055 (class 2606 OID 28204678)
-- Dependencies: 232 200 3742
-- Name: fk_dbgrade_avaliacoes__dbcursos_codigograde; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcursos
    ADD CONSTRAINT fk_dbgrade_avaliacoes__dbcursos_codigograde FOREIGN KEY (codigograde) REFERENCES dbgrade_avaliacoes(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4195 (class 2606 OID 28204683)
-- Dependencies: 335 232 3742
-- Name: fk_dbgrade_avaliacoes_dbturmas_disciplinas__CODIGOGRADE; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas
    ADD CONSTRAINT "fk_dbgrade_avaliacoes_dbturmas_disciplinas__CODIGOGRADE" FOREIGN KEY (codigograde) REFERENCES dbgrade_avaliacoes(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4089 (class 2606 OID 28204688)
-- Dependencies: 238 236 3746
-- Name: fk_dbpatrimonios__dbpatrimonios_livros__codigopatrimonio; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpatrimonios_livros
    ADD CONSTRAINT fk_dbpatrimonios__dbpatrimonios_livros__codigopatrimonio FOREIGN KEY (codigopatrimonio) REFERENCES dbpatrimonios(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4121 (class 2606 OID 28204693)
-- Dependencies: 260 238 3750
-- Name: fk_dbpatrimonios_livros__dbpessoas_livros__codigolivro; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_livros
    ADD CONSTRAINT fk_dbpatrimonios_livros__dbpessoas_livros__codigolivro FOREIGN KEY (codigolivro) REFERENCES dbpatrimonios_livros(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4014 (class 2606 OID 28204698)
-- Dependencies: 158 242 3758
-- Name: fk_dbpessoas__dbalunos_solicitacoes__codigoaluno; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_solicitacoes
    ADD CONSTRAINT fk_dbpessoas__dbalunos_solicitacoes__codigoaluno FOREIGN KEY (codigoaluno) REFERENCES dbpessoas_alunos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4025 (class 2606 OID 28204703)
-- Dependencies: 170 240 3754
-- Name: fk_dbpessoas__dbcaixa__codigopessoa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcaixa
    ADD CONSTRAINT fk_dbpessoas__dbcaixa__codigopessoa FOREIGN KEY (codigopessoa) REFERENCES dbpessoas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4043 (class 2606 OID 28204708)
-- Dependencies: 188 240 3754
-- Name: fk_dbpessoas__dbcontratos__codigopessoa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcontratos
    ADD CONSTRAINT fk_dbpessoas__dbcontratos__codigopessoa FOREIGN KEY (codigopessoa) REFERENCES dbpessoas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4048 (class 2606 OID 28204713)
-- Dependencies: 194 240 3754
-- Name: fk_dbpessoas__dbcotacoes__codigofornecedor; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcotacoes
    ADD CONSTRAINT fk_dbpessoas__dbcotacoes__codigofornecedor FOREIGN KEY (codigofornecedor) REFERENCES dbpessoas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4093 (class 2606 OID 28204718)
-- Dependencies: 242 240 3754
-- Name: fk_dbpessoas__dbpessoas_alunos__codigopessoa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_alunos
    ADD CONSTRAINT fk_dbpessoas__dbpessoas_alunos__codigopessoa FOREIGN KEY (codigopessoa) REFERENCES dbpessoas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4097 (class 2606 OID 28204723)
-- Dependencies: 240 244 3754
-- Name: fk_dbpessoas__dbpessoas_complemento_pf__codigopessoa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_complemento_pf
    ADD CONSTRAINT fk_dbpessoas__dbpessoas_complemento_pf__codigopessoa FOREIGN KEY (codigopessoa) REFERENCES dbpessoas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4099 (class 2606 OID 28204728)
-- Dependencies: 246 240 3754
-- Name: fk_dbpessoas__dbpessoas_complemento_pj__codigopessoa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_complemento_pj
    ADD CONSTRAINT fk_dbpessoas__dbpessoas_complemento_pj__codigopessoa FOREIGN KEY (codigopessoa) REFERENCES dbpessoas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4102 (class 2606 OID 28204733)
-- Dependencies: 248 240 3754
-- Name: fk_dbpessoas__dbpessoas_convenios__codigopessoa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_convenios
    ADD CONSTRAINT fk_dbpessoas__dbpessoas_convenios__codigopessoa FOREIGN KEY (codigopessoa) REFERENCES dbpessoas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4105 (class 2606 OID 28204738)
-- Dependencies: 3754 240 250
-- Name: fk_dbpessoas__dbpessoas_demandas__codigopessoa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_demandas
    ADD CONSTRAINT fk_dbpessoas__dbpessoas_demandas__codigopessoa FOREIGN KEY (codigopessoa) REFERENCES dbpessoas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4107 (class 2606 OID 28204743)
-- Dependencies: 3754 240 252
-- Name: fk_dbpessoas__dbpessoas_enderecoscobrancas__codigopessoa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_enderecoscobrancas
    ADD CONSTRAINT fk_dbpessoas__dbpessoas_enderecoscobrancas__codigopessoa FOREIGN KEY (codigopessoa) REFERENCES dbpessoas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4109 (class 2606 OID 28204748)
-- Dependencies: 3754 254 240
-- Name: fk_dbpessoas__dbpessoas_formacoes__codigopessoa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_formacoes
    ADD CONSTRAINT fk_dbpessoas__dbpessoas_formacoes__codigopessoa FOREIGN KEY (codigopessoa) REFERENCES dbpessoas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4110 (class 2606 OID 28204753)
-- Dependencies: 264 254 3803
-- Name: fk_dbpessoas__dbpessoas_formacoes__codigotitularidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_formacoes
    ADD CONSTRAINT fk_dbpessoas__dbpessoas_formacoes__codigotitularidade FOREIGN KEY (codigotitularidade) REFERENCES dbpessoas_titularidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4114 (class 2606 OID 28204758)
-- Dependencies: 256 3754 240
-- Name: fk_dbpessoas__dbpessoas_funcionarios__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_funcionarios
    ADD CONSTRAINT fk_dbpessoas__dbpessoas_funcionarios__unidade FOREIGN KEY (codigopessoa) REFERENCES dbpessoas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4117 (class 2606 OID 28204763)
-- Dependencies: 258 3754 240
-- Name: fk_dbpessoas__dbpessoas_inscricoes__codigopessoa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_inscricoes
    ADD CONSTRAINT fk_dbpessoas__dbpessoas_inscricoes__codigopessoa FOREIGN KEY (codigopessoa) REFERENCES dbpessoas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4122 (class 2606 OID 28204768)
-- Dependencies: 260 3754 240
-- Name: fk_dbpessoas__dbpessoas_livros__codigopessoa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_livros
    ADD CONSTRAINT fk_dbpessoas__dbpessoas_livros__codigopessoa FOREIGN KEY (codigopessoa) REFERENCES dbpessoas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4125 (class 2606 OID 28204773)
-- Dependencies: 262 3754 240
-- Name: fk_dbpessoas__dbpessoas_solicitacoes__codigopessoa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_solicitacoes
    ADD CONSTRAINT fk_dbpessoas__dbpessoas_solicitacoes__codigopessoa FOREIGN KEY (codigopessoa) REFERENCES dbpessoas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4147 (class 2606 OID 28204778)
-- Dependencies: 289 240 3754
-- Name: fk_dbpessoas__dbprojetos_colaboradores__codigopessoa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprojetos_colaboradores
    ADD CONSTRAINT fk_dbpessoas__dbprojetos_colaboradores__codigopessoa FOREIGN KEY (codigopessoa) REFERENCES dbpessoas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4163 (class 2606 OID 28204783)
-- Dependencies: 3754 311 240
-- Name: fk_dbpessoas__dbtransacoes__codigopessoa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes
    ADD CONSTRAINT fk_dbpessoas__dbtransacoes__codigopessoa FOREIGN KEY (codigopessoa) REFERENCES dbpessoas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4166 (class 2606 OID 28204788)
-- Dependencies: 313 240 3754
-- Name: fk_dbpessoas__dbtransacoes_contas__codigopessoa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes_contas
    ADD CONSTRAINT fk_dbpessoas__dbtransacoes_contas__codigopessoa FOREIGN KEY (codigopessoa) REFERENCES dbpessoas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4170 (class 2606 OID 28204793)
-- Dependencies: 3754 315 240
-- Name: fk_dbpessoas__dbtransacoes_contas_duplicatas__codigopessoa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes_contas_duplicatas
    ADD CONSTRAINT fk_dbpessoas__dbtransacoes_contas_duplicatas__codigopessoa FOREIGN KEY (codigopessoa) REFERENCES dbpessoas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4217 (class 2606 OID 28204798)
-- Dependencies: 3754 240 355
-- Name: fk_dbpessoas__dbusuarios__codigousuario; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbusuarios
    ADD CONSTRAINT fk_dbpessoas__dbusuarios__codigousuario FOREIGN KEY (codigopessoa) REFERENCES dbpessoas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4017 (class 2606 OID 28204803)
-- Dependencies: 3758 242 160
-- Name: fk_dbpessoas_alunos__dbalunos_transacoes__codigoaluno; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_transacoes
    ADD CONSTRAINT fk_dbpessoas_alunos__dbalunos_transacoes__codigoaluno FOREIGN KEY (codigoaluno) REFERENCES dbpessoas_alunos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4015 (class 2606 OID 28204808)
-- Dependencies: 256 158 3787
-- Name: fk_dbpessoas_funcionarios__dbalunos_solicitacoes__codigofuncio; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_solicitacoes
    ADD CONSTRAINT fk_dbpessoas_funcionarios__dbalunos_solicitacoes__codigofuncio FOREIGN KEY (codigofuncionario) REFERENCES dbpessoas_funcionarios(codigo);


--
-- TOC entry 4026 (class 2606 OID 28204813)
-- Dependencies: 170 3787 256
-- Name: fk_dbpessoas_funcionarios__dbcaixa__codigofuncionario; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcaixa
    ADD CONSTRAINT fk_dbpessoas_funcionarios__dbcaixa__codigofuncionario FOREIGN KEY (codigofuncionario) REFERENCES dbpessoas_funcionarios(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4032 (class 2606 OID 28204818)
-- Dependencies: 256 174 3787
-- Name: fk_dbpessoas_funcionarios__dbcaixa_funcionarios__codigofunciona; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcaixa_funcionarios
    ADD CONSTRAINT fk_dbpessoas_funcionarios__dbcaixa_funcionarios__codigofunciona FOREIGN KEY (codigofuncionario) REFERENCES dbpessoas_funcionarios(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4074 (class 2606 OID 28204823)
-- Dependencies: 223 3787 256
-- Name: fk_dbpessoas_funcionarios__dbfuncionarios_ferias__codigofuncion; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfuncionarios_ferias
    ADD CONSTRAINT fk_dbpessoas_funcionarios__dbfuncionarios_ferias__codigofuncion FOREIGN KEY (codigofuncionario) REFERENCES dbpessoas_funcionarios(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4076 (class 2606 OID 28204828)
-- Dependencies: 3787 256 225
-- Name: fk_dbpessoas_funcionarios__dbfuncionarios_folhapagamento__codig; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfuncionarios_folhapagamento
    ADD CONSTRAINT fk_dbpessoas_funcionarios__dbfuncionarios_folhapagamento__codig FOREIGN KEY (codigofuncionario) REFERENCES dbpessoas_funcionarios(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4078 (class 2606 OID 28204833)
-- Dependencies: 256 227 3787
-- Name: fk_dbpessoas_funcionarios__dbfuncionarios_ocorrencias__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfuncionarios_ocorrencias
    ADD CONSTRAINT fk_dbpessoas_funcionarios__dbfuncionarios_ocorrencias__unidade FOREIGN KEY (codigofuncionario) REFERENCES dbpessoas_funcionarios(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4080 (class 2606 OID 28204838)
-- Dependencies: 3787 229 256
-- Name: fk_dbpessoas_funcionarios__dbfuncionarios_professores__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfuncionarios_professores
    ADD CONSTRAINT fk_dbpessoas_funcionarios__dbfuncionarios_professores__unidade FOREIGN KEY (codigofuncionario) REFERENCES dbpessoas_funcionarios(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4082 (class 2606 OID 28204843)
-- Dependencies: 3787 231 256
-- Name: fk_dbpessoas_funcionarios__dbfuncionarios_treinamentos__codigof; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfuncionarios_treinamentos
    ADD CONSTRAINT fk_dbpessoas_funcionarios__dbfuncionarios_treinamentos__codigof FOREIGN KEY (codigofuncionario) REFERENCES dbpessoas_funcionarios(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4085 (class 2606 OID 28204848)
-- Dependencies: 3787 256 236
-- Name: fk_dbpessoas_funcionarios__dbpatrimonios__codigofuncionario; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpatrimonios
    ADD CONSTRAINT fk_dbpessoas_funcionarios__dbpatrimonios__codigofuncionario FOREIGN KEY (codigofuncionario) REFERENCES dbpessoas_funcionarios(codigo);


--
-- TOC entry 4126 (class 2606 OID 28204853)
-- Dependencies: 3787 256 262
-- Name: fk_dbpessoas_funcionarios__dbpessoas_solicitacoes__codigofuncio; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_solicitacoes
    ADD CONSTRAINT fk_dbpessoas_funcionarios__dbpessoas_solicitacoes__codigofuncio FOREIGN KEY (codigofuncionario) REFERENCES dbpessoas_funcionarios(codigo);


--
-- TOC entry 4164 (class 2606 OID 28204858)
-- Dependencies: 3807 266 311
-- Name: fk_dbplano_contas__dbtransacoes__codigoplanoconta; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes
    ADD CONSTRAINT fk_dbplano_contas__dbtransacoes__codigoplanoconta FOREIGN KEY (codigoplanoconta) REFERENCES dbplano_contas(codigo);


--
-- TOC entry 4167 (class 2606 OID 28204863)
-- Dependencies: 3807 266 313
-- Name: fk_dbplano_contas__dbtransacoes_contas__codigoplanoconta; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes_contas
    ADD CONSTRAINT fk_dbplano_contas__dbtransacoes_contas__codigoplanoconta FOREIGN KEY (codigoplanoconta) REFERENCES dbplano_contas(codigo);


--
-- TOC entry 4045 (class 2606 OID 28204868)
-- Dependencies: 190 3807 266
-- Name: fk_dbplano_contas_dbconvenios_codigoplanoconta; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbconvenios
    ADD CONSTRAINT fk_dbplano_contas_dbconvenios_codigoplanoconta FOREIGN KEY (codigoplanoconta) REFERENCES dbplano_contas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4138 (class 2606 OID 28204873)
-- Dependencies: 279 3816 270
-- Name: fk_dbproduto__dbprodutos_tabelapreco__codigoproduto; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprodutos_tabelapreco
    ADD CONSTRAINT fk_dbproduto__dbprodutos_tabelapreco__codigoproduto FOREIGN KEY (codigoproduto) REFERENCES dbprodutos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4141 (class 2606 OID 28204878)
-- Dependencies: 3816 270 283
-- Name: fk_dbproduto__dbprodutos_tributos__codigoproduto; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprodutos_tributos
    ADD CONSTRAINT fk_dbproduto__dbprodutos_tributos__codigoproduto FOREIGN KEY (codigoproduto) REFERENCES dbprodutos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4035 (class 2606 OID 28204883)
-- Dependencies: 270 180 3816
-- Name: fk_dbprodutos__dbcompras__codigoproduto; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcompras
    ADD CONSTRAINT fk_dbprodutos__dbcompras__codigoproduto FOREIGN KEY (codigoproduto) REFERENCES dbprodutos(codigo);


--
-- TOC entry 4049 (class 2606 OID 28204888)
-- Dependencies: 270 194 3816
-- Name: fk_dbprodutos__dbcotacoes__codigoproduto; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcotacoes
    ADD CONSTRAINT fk_dbprodutos__dbcotacoes__codigoproduto FOREIGN KEY (codigoproduto) REFERENCES dbprodutos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4086 (class 2606 OID 28204893)
-- Dependencies: 236 270 3816
-- Name: fk_dbprodutos__dbpatrimonios__codigoproduto; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpatrimonios
    ADD CONSTRAINT fk_dbprodutos__dbpatrimonios__codigoproduto FOREIGN KEY (codigoproduto) REFERENCES dbprodutos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4133 (class 2606 OID 28204898)
-- Dependencies: 270 3816 272
-- Name: fk_dbprodutos__dbprodutos_insumos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprodutos_caracteristicas
    ADD CONSTRAINT fk_dbprodutos__dbprodutos_insumos__unidade FOREIGN KEY (codigoproduto) REFERENCES dbprodutos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4135 (class 2606 OID 28204903)
-- Dependencies: 277 270 3816
-- Name: fk_dbprodutos__dbprodutos_parametros__codigoproduto; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprodutos_parametros
    ADD CONSTRAINT fk_dbprodutos__dbprodutos_parametros__codigoproduto FOREIGN KEY (codigoproduto) REFERENCES dbprodutos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4179 (class 2606 OID 28204908)
-- Dependencies: 270 3816 323
-- Name: fk_dbprodutos__dbtransacoes_produtos__codigoproduto; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes_produtos
    ADD CONSTRAINT fk_dbprodutos__dbtransacoes_produtos__codigoproduto FOREIGN KEY (codigoproduto) REFERENCES dbprodutos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4186 (class 2606 OID 28204913)
-- Dependencies: 3816 270 329
-- Name: fk_dbprodutos__dbturmas__codigoproduto; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas
    ADD CONSTRAINT fk_dbprodutos__dbturmas__codigoproduto FOREIGN KEY (codigoproduto) REFERENCES dbprodutos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4131 (class 2606 OID 28204918)
-- Dependencies: 270 281 3833
-- Name: fk_dbprodutos_tipos__dbprodutos__codigotipoproduto; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprodutos
    ADD CONSTRAINT fk_dbprodutos_tipos__dbprodutos__codigotipoproduto FOREIGN KEY (codigotipoproduto) REFERENCES dbprodutos_tipos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4136 (class 2606 OID 28204923)
-- Dependencies: 281 3833 277
-- Name: fk_dbprodutos_tipos__dbprodutos_parametros__codigotipoproduto; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprodutos_parametros
    ADD CONSTRAINT fk_dbprodutos_tipos__dbprodutos_parametros__codigotipoproduto FOREIGN KEY (codigotipoproduto) REFERENCES dbprodutos_tipos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4148 (class 2606 OID 28204928)
-- Dependencies: 3845 289 287
-- Name: fk_dbprojetos__dbprojetos_colaboradores__codigoprojeto; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprojetos_colaboradores
    ADD CONSTRAINT fk_dbprojetos__dbprojetos_colaboradores__codigoprojeto FOREIGN KEY (codigoprojeto) REFERENCES dbprojetos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4150 (class 2606 OID 28204933)
-- Dependencies: 291 3845 287
-- Name: fk_dbprojetos__dbprojetos_custos__codigoprojeto; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprojetos_custos
    ADD CONSTRAINT fk_dbprojetos__dbprojetos_custos__codigoprojeto FOREIGN KEY (codigoprojeto) REFERENCES dbprojetos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4152 (class 2606 OID 28204938)
-- Dependencies: 3845 293 287
-- Name: fk_dbprojetos__dbprojetos_custos__codigoprojeto; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprojetos_recursos
    ADD CONSTRAINT fk_dbprojetos__dbprojetos_custos__codigoprojeto FOREIGN KEY (codigoprojeto) REFERENCES dbprojetos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4155 (class 2606 OID 28204943)
-- Dependencies: 3861 297 295
-- Name: fk_dbquestionarios__dbquestoes__codigoquestionario; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbquestoes
    ADD CONSTRAINT fk_dbquestionarios__dbquestoes__codigoquestionario FOREIGN KEY (codigoquestionario) REFERENCES dbquestionarios(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4157 (class 2606 OID 28204948)
-- Dependencies: 299 297 3865
-- Name: fk_dbquestoes__dbquestoes_itens__codigoquestao; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbquestoes_itens
    ADD CONSTRAINT fk_dbquestoes__dbquestoes_itens__codigoquestao FOREIGN KEY (codigoquestao) REFERENCES dbquestoes(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4067 (class 2606 OID 28204953)
-- Dependencies: 303 214 3877
-- Name: fk_dbsalas__dbdepartamentos__codigosala; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbdepartamentos
    ADD CONSTRAINT fk_dbsalas__dbdepartamentos__codigosala FOREIGN KEY (codigosala) REFERENCES dbsalas(codigo);


--
-- TOC entry 4196 (class 2606 OID 28204958)
-- Dependencies: 303 335 3877
-- Name: fk_dbsalas__dbturmas_disciplinas__codigosala; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas
    ADD CONSTRAINT fk_dbsalas__dbturmas_disciplinas__codigosala FOREIGN KEY (codigosala) REFERENCES dbsalas(codigo);


--
-- TOC entry 4161 (class 2606 OID 28204963)
-- Dependencies: 305 3881 307
-- Name: fk_dbscorecard__dbscorecard_sentencas__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbscorecard_sentencas
    ADD CONSTRAINT fk_dbscorecard__dbscorecard_sentencas__unidade FOREIGN KEY (codigoscorecard) REFERENCES dbscorecard(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4018 (class 2606 OID 28204968)
-- Dependencies: 311 160 3891
-- Name: fk_dbtransacoes__dbalunos_transacoes__codigotransacao; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_transacoes
    ADD CONSTRAINT fk_dbtransacoes__dbalunos_transacoes__codigotransacao FOREIGN KEY (codigotransacao) REFERENCES dbtransacoes(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4027 (class 2606 OID 28204973)
-- Dependencies: 170 3891 311
-- Name: fk_dbtransacoes__dbcaixa__codigotransacao; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcaixa
    ADD CONSTRAINT fk_dbtransacoes__dbcaixa__codigotransacao FOREIGN KEY (codigotransacao) REFERENCES dbtransacoes(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4094 (class 2606 OID 28204978)
-- Dependencies: 3891 311 242
-- Name: fk_dbtransacoes__dbpessoas_alunos__codigotransacao; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_alunos
    ADD CONSTRAINT fk_dbtransacoes__dbpessoas_alunos__codigotransacao FOREIGN KEY (codigotransacao) REFERENCES dbtransacoes(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4118 (class 2606 OID 28204983)
-- Dependencies: 258 311 3891
-- Name: fk_dbtransacoes__dbpessoas_inscricoes__codigotransacao; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_inscricoes
    ADD CONSTRAINT fk_dbtransacoes__dbpessoas_inscricoes__codigotransacao FOREIGN KEY (codigotransacao) REFERENCES dbtransacoes(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4168 (class 2606 OID 28204988)
-- Dependencies: 3891 313 311
-- Name: fk_dbtransacoes__dbtransacoes_contas__codigotransacao; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes_contas
    ADD CONSTRAINT fk_dbtransacoes__dbtransacoes_contas__codigotransacao FOREIGN KEY (codigotransacao) REFERENCES dbtransacoes(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4177 (class 2606 OID 28204993)
-- Dependencies: 3891 311 320
-- Name: fk_dbtransacoes__dbtransacoes_convenios__codigotransacao; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes_convenios
    ADD CONSTRAINT fk_dbtransacoes__dbtransacoes_convenios__codigotransacao FOREIGN KEY (codigotransacao) REFERENCES dbtransacoes(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4180 (class 2606 OID 28204998)
-- Dependencies: 311 323 3891
-- Name: fk_dbtransacoes__dbtransacoes_produtos__codigotransacao; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes_produtos
    ADD CONSTRAINT fk_dbtransacoes__dbtransacoes_produtos__codigotransacao FOREIGN KEY (codigotransacao) REFERENCES dbtransacoes(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4173 (class 2606 OID 28205003)
-- Dependencies: 317 3895 313
-- Name: fk_dbtransacoes_contas__db_contas_extornos__codigocontadestino; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes_contas_extornos
    ADD CONSTRAINT fk_dbtransacoes_contas__db_contas_extornos__codigocontadestino FOREIGN KEY (codigocontadestino) REFERENCES dbtransacoes_contas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4174 (class 2606 OID 28205008)
-- Dependencies: 313 3895 317
-- Name: fk_dbtransacoes_contas__db_contas_extornos__codigocontaorigem; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes_contas_extornos
    ADD CONSTRAINT fk_dbtransacoes_contas__db_contas_extornos__codigocontaorigem FOREIGN KEY (codigocontaorigem) REFERENCES dbtransacoes_contas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4028 (class 2606 OID 28205013)
-- Dependencies: 3895 313 170
-- Name: fk_dbtransacoes_contas__dbcaixa__codigoconta; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcaixa
    ADD CONSTRAINT fk_dbtransacoes_contas__dbcaixa__codigoconta FOREIGN KEY (codigoconta) REFERENCES dbtransacoes_contas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4171 (class 2606 OID 28205018)
-- Dependencies: 315 3895 313
-- Name: fk_dbtransacoes_contas__dbtransacoes_contas_duplicatas__codigoc; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes_contas_duplicatas
    ADD CONSTRAINT fk_dbtransacoes_contas__dbtransacoes_contas_duplicatas__codigoc FOREIGN KEY (codigoconta) REFERENCES dbtransacoes_contas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4083 (class 2606 OID 28205023)
-- Dependencies: 231 3920 325
-- Name: fk_dbtreinamentos_dbfuncionarios_treinamentos__codigotreinament; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfuncionarios_treinamentos
    ADD CONSTRAINT fk_dbtreinamentos_dbfuncionarios_treinamentos__codigotreinament FOREIGN KEY (codigotreinamento) REFERENCES dbtreinamentos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4095 (class 2606 OID 28205028)
-- Dependencies: 329 3928 242
-- Name: fk_dbturmas__dbpessoas_alunos__codigoturma; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_alunos
    ADD CONSTRAINT fk_dbturmas__dbpessoas_alunos__codigoturma FOREIGN KEY (codigoturma) REFERENCES dbturmas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4119 (class 2606 OID 28205033)
-- Dependencies: 329 258 3928
-- Name: fk_dbturmas__dbpessoas_inscricoes__codigoturma; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_inscricoes
    ADD CONSTRAINT fk_dbturmas__dbpessoas_inscricoes__codigoturma FOREIGN KEY (codigoturma) REFERENCES dbturmas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4189 (class 2606 OID 28205038)
-- Dependencies: 329 330 3928
-- Name: fk_dbturmas__dbturmas_convenios__codigoturma; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_convenios
    ADD CONSTRAINT fk_dbturmas__dbturmas_convenios__codigoturma FOREIGN KEY (codigoturma) REFERENCES dbturmas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4191 (class 2606 OID 28205043)
-- Dependencies: 333 3928 329
-- Name: fk_dbturmas__dbturmas_descontos__codigoturma; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_descontos
    ADD CONSTRAINT fk_dbturmas__dbturmas_descontos__codigoturma FOREIGN KEY (codigoturma) REFERENCES dbturmas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4197 (class 2606 OID 28205048)
-- Dependencies: 3928 329 335
-- Name: fk_dbturmas__dbturmas_disciplinas__codigoturma; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas
    ADD CONSTRAINT fk_dbturmas__dbturmas_disciplinas__codigoturma FOREIGN KEY (codigoturma) REFERENCES dbturmas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4214 (class 2606 OID 28205053)
-- Dependencies: 329 3928 349
-- Name: fk_dbturmas__dbturmas_requisitos__codigoturma; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_requisitos
    ADD CONSTRAINT fk_dbturmas__dbturmas_requisitos__codigoturma FOREIGN KEY (codigoturma) REFERENCES dbturmas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3998 (class 2606 OID 28205058)
-- Dependencies: 148 3708 216
-- Name: fk_dbturmas_disciplinas__dbalunos_disciplinas__codisciplina; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_disciplinas
    ADD CONSTRAINT fk_dbturmas_disciplinas__dbalunos_disciplinas__codisciplina FOREIGN KEY (codigodisciplina) REFERENCES dbdisciplinas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3999 (class 2606 OID 28205063)
-- Dependencies: 3940 335 148
-- Name: fk_dbturmas_disciplinas__dbalunos_disciplinas__codturmadisc; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_disciplinas
    ADD CONSTRAINT fk_dbturmas_disciplinas__dbalunos_disciplinas__codturmadisc FOREIGN KEY (codigoturmadisciplina) REFERENCES dbturmas_disciplinas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4004 (class 2606 OID 28205068)
-- Dependencies: 3940 335 152
-- Name: fk_dbturmas_disciplinas__dbalunos_faltas__codigoturmadisciplina; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_faltas
    ADD CONSTRAINT fk_dbturmas_disciplinas__dbalunos_faltas__codigoturmadisciplina FOREIGN KEY (codigoturmadisciplina) REFERENCES dbturmas_disciplinas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4008 (class 2606 OID 28205073)
-- Dependencies: 3940 154 335
-- Name: fk_dbturmas_disciplinas__dbalunos_notas__codigoturmadisciplina; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_notas
    ADD CONSTRAINT fk_dbturmas_disciplinas__dbalunos_notas__codigoturmadisciplina FOREIGN KEY (codigoturmadisciplina) REFERENCES dbturmas_disciplinas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4200 (class 2606 OID 28205078)
-- Dependencies: 337 3940 335
-- Name: fk_dbturmas_disciplinas__dbturmas_disciplinas_arquivos__codigot; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas_arquivos
    ADD CONSTRAINT fk_dbturmas_disciplinas__dbturmas_disciplinas_arquivos__codigot FOREIGN KEY (codigoturmadisciplina) REFERENCES dbturmas_disciplinas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4202 (class 2606 OID 28205083)
-- Dependencies: 339 3940 335
-- Name: fk_dbturmas_disciplinas__dbturmas_disciplinas_aulas__codigoturm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas_aulas
    ADD CONSTRAINT fk_dbturmas_disciplinas__dbturmas_disciplinas_aulas__codigoturm FOREIGN KEY (codigoturmadisciplina) REFERENCES dbturmas_disciplinas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4204 (class 2606 OID 28205088)
-- Dependencies: 340 3940 335
-- Name: fk_dbturmas_disciplinas__dbturmas_disciplinas_avaliacao_detalha; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas_avaliacao_detalhamento
    ADD CONSTRAINT fk_dbturmas_disciplinas__dbturmas_disciplinas_avaliacao_detalha FOREIGN KEY (codigoturmadisciplina) REFERENCES dbturmas_disciplinas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4206 (class 2606 OID 28205093)
-- Dependencies: 335 343 3940
-- Name: fk_dbturmas_disciplinas__dbturmas_disciplinas_avaliacoes__codig; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas_avaliacoes
    ADD CONSTRAINT fk_dbturmas_disciplinas__dbturmas_disciplinas_avaliacoes__codig FOREIGN KEY (codigoturmadisciplina) REFERENCES dbturmas_disciplinas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4209 (class 2606 OID 28205098)
-- Dependencies: 345 335 3940
-- Name: fk_dbturmas_disciplinas__dbturmas_disciplinas_materiais__codigo; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas_materiais
    ADD CONSTRAINT fk_dbturmas_disciplinas__dbturmas_disciplinas_materiais__codigo FOREIGN KEY (codigoturmadisciplina) REFERENCES dbturmas_disciplinas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4212 (class 2606 OID 28205103)
-- Dependencies: 3940 347 335
-- Name: fk_dbturmas_disciplinas__dbturmas_disciplinas_planoaulas__codig; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas_planoaulas
    ADD CONSTRAINT fk_dbturmas_disciplinas__dbturmas_disciplinas_planoaulas__codig FOREIGN KEY (codigoturmadisciplina) REFERENCES dbturmas_disciplinas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4005 (class 2606 OID 28205108)
-- Dependencies: 339 3948 152
-- Name: fk_dbturmas_disciplinas_aulas__dbalunos_faltas__codigoaula; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_faltas
    ADD CONSTRAINT fk_dbturmas_disciplinas_aulas__dbalunos_faltas__codigoaula FOREIGN KEY (codigoaula) REFERENCES dbturmas_disciplinas_aulas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4207 (class 2606 OID 28205113)
-- Dependencies: 3956 343 343
-- Name: fk_dbturmas_disciplinas_avaliacoes; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas_avaliacoes
    ADD CONSTRAINT fk_dbturmas_disciplinas_avaliacoes FOREIGN KEY (codigopai) REFERENCES dbturmas_disciplinas_avaliacoes(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4011 (class 2606 OID 28205118)
-- Dependencies: 349 3968 156
-- Name: fk_dbturmas_requisitos__dbalunos_requisitos_codigoaula; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_requisitos
    ADD CONSTRAINT fk_dbturmas_requisitos__dbalunos_requisitos_codigoaula FOREIGN KEY (codigorequisito) REFERENCES dbturmas_requisitos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4000 (class 2606 OID 28205123)
-- Dependencies: 148 3972 351
-- Name: fk_dbunidades__dbalunos_disciplinas__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_disciplinas
    ADD CONSTRAINT fk_dbunidades__dbalunos_disciplinas__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4002 (class 2606 OID 28205128)
-- Dependencies: 351 3972 150
-- Name: fk_dbunidades__dbalunos_disciplinas_aproveitamentos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_disciplinas_aproveitamentos
    ADD CONSTRAINT fk_dbunidades__dbalunos_disciplinas_aproveitamentos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4006 (class 2606 OID 28205133)
-- Dependencies: 351 152 3972
-- Name: fk_dbunidades__dbalunos_faltas__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_faltas
    ADD CONSTRAINT fk_dbunidades__dbalunos_faltas__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4009 (class 2606 OID 28205138)
-- Dependencies: 3972 154 351
-- Name: fk_dbunidades__dbalunos_notas__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_notas
    ADD CONSTRAINT fk_dbunidades__dbalunos_notas__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4012 (class 2606 OID 28205143)
-- Dependencies: 351 156 3972
-- Name: fk_dbunidades__dbalunos_requisitos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_requisitos
    ADD CONSTRAINT fk_dbunidades__dbalunos_requisitos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4016 (class 2606 OID 28205148)
-- Dependencies: 351 3972 158
-- Name: fk_dbunidades__dbalunos_solicitacoes__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_solicitacoes
    ADD CONSTRAINT fk_dbunidades__dbalunos_solicitacoes__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4019 (class 2606 OID 28205153)
-- Dependencies: 160 351 3972
-- Name: fk_dbunidades__dbalunos_transacoes__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_transacoes
    ADD CONSTRAINT fk_dbunidades__dbalunos_transacoes__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4021 (class 2606 OID 28205158)
-- Dependencies: 351 166 3972
-- Name: fk_dbunidades__dbbalanco_patrimonial__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbbalanco_patrimonial
    ADD CONSTRAINT fk_dbunidades__dbbalanco_patrimonial__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4022 (class 2606 OID 28205163)
-- Dependencies: 351 168 3972
-- Name: fk_dbunidades__dbbiblioteca_cdu__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbbiblioteca_cdu
    ADD CONSTRAINT fk_dbunidades__dbbiblioteca_cdu__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4029 (class 2606 OID 28205168)
-- Dependencies: 3972 170 351
-- Name: fk_dbunidades__dbcaixa__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcaixa
    ADD CONSTRAINT fk_dbunidades__dbcaixa__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4030 (class 2606 OID 28205173)
-- Dependencies: 351 3972 172
-- Name: fk_dbunidades__dbcaixa_fechamentos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcaixa_fechamentos
    ADD CONSTRAINT fk_dbunidades__dbcaixa_fechamentos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4033 (class 2606 OID 28205178)
-- Dependencies: 3972 351 174
-- Name: fk_dbunidades__dbcaixa_funcionarios__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcaixa_funcionarios
    ADD CONSTRAINT fk_dbunidades__dbcaixa_funcionarios__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4034 (class 2606 OID 28205183)
-- Dependencies: 3972 176 351
-- Name: fk_dbunidades__dbcargos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcargos
    ADD CONSTRAINT fk_dbunidades__dbcargos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4042 (class 2606 OID 28205188)
-- Dependencies: 351 3972 186
-- Name: fk_dbunidades__dbcheques__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcontas_cheques
    ADD CONSTRAINT fk_dbunidades__dbcheques__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4036 (class 2606 OID 28205193)
-- Dependencies: 3972 351 180
-- Name: fk_dbunidades__dbcompras__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcompras
    ADD CONSTRAINT fk_dbunidades__dbcompras__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4037 (class 2606 OID 28205198)
-- Dependencies: 351 3972 182
-- Name: fk_dbunidades__dbcontas_caixa__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcontas_caixa
    ADD CONSTRAINT fk_dbunidades__dbcontas_caixa__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4039 (class 2606 OID 28205203)
-- Dependencies: 3972 184 351
-- Name: fk_dbunidades__dbcontas_caixa_historico__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcontas_caixa_historico
    ADD CONSTRAINT fk_dbunidades__dbcontas_caixa_historico__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4044 (class 2606 OID 28205208)
-- Dependencies: 3972 351 188
-- Name: fk_dbunidades__dbcontratos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcontratos
    ADD CONSTRAINT fk_dbunidades__dbcontratos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4047 (class 2606 OID 28205213)
-- Dependencies: 191 3972 351
-- Name: fk_dbunidades__dbconvenios_descontos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbconvenios_descontos
    ADD CONSTRAINT fk_dbunidades__dbconvenios_descontos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4050 (class 2606 OID 28205218)
-- Dependencies: 3972 351 194
-- Name: fk_dbunidades__dbcotacoes__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcotacoes
    ADD CONSTRAINT fk_dbunidades__dbcotacoes__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4051 (class 2606 OID 28205223)
-- Dependencies: 3972 196 351
-- Name: fk_dbunidades__dbcrm_demandas__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcrm_demandas
    ADD CONSTRAINT fk_dbunidades__dbcrm_demandas__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4052 (class 2606 OID 28205228)
-- Dependencies: 351 198 3972
-- Name: fk_dbunidades__dbcurriculos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcurriculos
    ADD CONSTRAINT fk_dbunidades__dbcurriculos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4056 (class 2606 OID 28205233)
-- Dependencies: 3972 200 351
-- Name: fk_dbunidades__dbcursos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcursos
    ADD CONSTRAINT fk_dbunidades__dbcursos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4057 (class 2606 OID 28205238)
-- Dependencies: 3972 351 202
-- Name: fk_dbunidades__dbcursos_areas__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcursos_areas
    ADD CONSTRAINT fk_dbunidades__dbcursos_areas__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4059 (class 2606 OID 28205243)
-- Dependencies: 3972 204 351
-- Name: fk_dbunidades__dbcursos_ativos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcursos_ativos
    ADD CONSTRAINT fk_dbunidades__dbcursos_ativos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4061 (class 2606 OID 28205248)
-- Dependencies: 3972 351 206
-- Name: fk_dbunidades__dbcursos_avaliacoes__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcursos_avaliacoes
    ADD CONSTRAINT fk_dbunidades__dbcursos_avaliacoes__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4064 (class 2606 OID 28205253)
-- Dependencies: 351 208 3972
-- Name: fk_dbunidades__dbcursos_disciplinas__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcursos_disciplinas
    ADD CONSTRAINT fk_dbunidades__dbcursos_disciplinas__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4065 (class 2606 OID 28205258)
-- Dependencies: 210 351 3972
-- Name: fk_dbunidades__dbcursos_tipos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcursos_tipos
    ADD CONSTRAINT fk_dbunidades__dbcursos_tipos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4066 (class 2606 OID 28205263)
-- Dependencies: 212 351 3972
-- Name: fk_dbunidades__dbdados_boleto__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbdados_boleto
    ADD CONSTRAINT fk_dbunidades__dbdados_boleto__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4068 (class 2606 OID 28205268)
-- Dependencies: 3972 214 351
-- Name: fk_dbunidades__dbdepartamentos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbdepartamentos
    ADD CONSTRAINT fk_dbunidades__dbdepartamentos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4069 (class 2606 OID 28205273)
-- Dependencies: 351 3972 216
-- Name: fk_dbunidades__dbdisciplinas__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbdisciplinas
    ADD CONSTRAINT fk_dbunidades__dbdisciplinas__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4072 (class 2606 OID 28205278)
-- Dependencies: 3972 218 351
-- Name: fk_dbunidades__dbdisciplinas_semelhantes__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbdisciplinas_semelhantes
    ADD CONSTRAINT fk_dbunidades__dbdisciplinas_semelhantes__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4073 (class 2606 OID 28205283)
-- Dependencies: 3972 351 220
-- Name: fk_dbunidades__dbdocumentos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbdocumentos
    ADD CONSTRAINT fk_dbunidades__dbdocumentos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4075 (class 2606 OID 28205288)
-- Dependencies: 3972 351 223
-- Name: fk_dbunidades__dbfuncionarios_ferias__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfuncionarios_ferias
    ADD CONSTRAINT fk_dbunidades__dbfuncionarios_ferias__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4077 (class 2606 OID 28205293)
-- Dependencies: 3972 225 351
-- Name: fk_dbunidades__dbfuncionarios_folhapagamento__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfuncionarios_folhapagamento
    ADD CONSTRAINT fk_dbunidades__dbfuncionarios_folhapagamento__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4079 (class 2606 OID 28205298)
-- Dependencies: 351 227 3972
-- Name: fk_dbunidades__dbfuncionarios_ocorrencias__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfuncionarios_ocorrencias
    ADD CONSTRAINT fk_dbunidades__dbfuncionarios_ocorrencias__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4081 (class 2606 OID 28205303)
-- Dependencies: 3972 229 351
-- Name: fk_dbunidades__dbfuncionarios_professores__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfuncionarios_professores
    ADD CONSTRAINT fk_dbunidades__dbfuncionarios_professores__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4084 (class 2606 OID 28205308)
-- Dependencies: 231 351 3972
-- Name: fk_dbunidades__dbfuncionarios_treinamentos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfuncionarios_treinamentos
    ADD CONSTRAINT fk_dbunidades__dbfuncionarios_treinamentos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4087 (class 2606 OID 28205313)
-- Dependencies: 236 3972 351
-- Name: fk_dbunidades__dbpatrimonios__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpatrimonios
    ADD CONSTRAINT fk_dbunidades__dbpatrimonios__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4090 (class 2606 OID 28205318)
-- Dependencies: 3972 238 351
-- Name: fk_dbunidades__dbpatrimonios_livros__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpatrimonios_livros
    ADD CONSTRAINT fk_dbunidades__dbpatrimonios_livros__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4091 (class 2606 OID 28205323)
-- Dependencies: 351 3972 240
-- Name: fk_dbunidades__dbpessoas__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas
    ADD CONSTRAINT fk_dbunidades__dbpessoas__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4096 (class 2606 OID 28205328)
-- Dependencies: 3972 351 242
-- Name: fk_dbunidades__dbpessoas_alunos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_alunos
    ADD CONSTRAINT fk_dbunidades__dbpessoas_alunos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4098 (class 2606 OID 28205333)
-- Dependencies: 3972 244 351
-- Name: fk_dbunidades__dbpessoas_complemento_pf__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_complemento_pf
    ADD CONSTRAINT fk_dbunidades__dbpessoas_complemento_pf__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4100 (class 2606 OID 28205338)
-- Dependencies: 3972 351 246
-- Name: fk_dbunidades__dbpessoas_complemento_pj__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_complemento_pj
    ADD CONSTRAINT fk_dbunidades__dbpessoas_complemento_pj__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4103 (class 2606 OID 28205343)
-- Dependencies: 3972 248 351
-- Name: fk_dbunidades__dbpessoas_convenios__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_convenios
    ADD CONSTRAINT fk_dbunidades__dbpessoas_convenios__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4106 (class 2606 OID 28205348)
-- Dependencies: 351 3972 250
-- Name: fk_dbunidades__dbpessoas_demandas__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_demandas
    ADD CONSTRAINT fk_dbunidades__dbpessoas_demandas__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4108 (class 2606 OID 28205353)
-- Dependencies: 252 3972 351
-- Name: fk_dbunidades__dbpessoas_enderecoscobrancas__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_enderecoscobrancas
    ADD CONSTRAINT fk_dbunidades__dbpessoas_enderecoscobrancas__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4111 (class 2606 OID 28205358)
-- Dependencies: 3972 254 351
-- Name: fk_dbunidades__dbpessoas_formacoes__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_formacoes
    ADD CONSTRAINT fk_dbunidades__dbpessoas_formacoes__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4115 (class 2606 OID 28205363)
-- Dependencies: 3972 256 351
-- Name: fk_dbunidades__dbpessoas_funcionarios__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_funcionarios
    ADD CONSTRAINT fk_dbunidades__dbpessoas_funcionarios__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4120 (class 2606 OID 28205368)
-- Dependencies: 351 3972 258
-- Name: fk_dbunidades__dbpessoas_inscricoes__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_inscricoes
    ADD CONSTRAINT fk_dbunidades__dbpessoas_inscricoes__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4123 (class 2606 OID 28205373)
-- Dependencies: 260 3972 351
-- Name: fk_dbunidades__dbpessoas_livros__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_livros
    ADD CONSTRAINT fk_dbunidades__dbpessoas_livros__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4127 (class 2606 OID 28205378)
-- Dependencies: 262 351 3972
-- Name: fk_dbunidades__dbpessoas_solicitacoes__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_solicitacoes
    ADD CONSTRAINT fk_dbunidades__dbpessoas_solicitacoes__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4128 (class 2606 OID 28205383)
-- Dependencies: 264 3972 351
-- Name: fk_dbunidades__dbpessoas_titularidades__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_titularidades
    ADD CONSTRAINT fk_dbunidades__dbpessoas_titularidades__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4129 (class 2606 OID 28205388)
-- Dependencies: 3972 266 351
-- Name: fk_dbunidades__dbplano_contas__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbplano_contas
    ADD CONSTRAINT fk_dbunidades__dbplano_contas__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4130 (class 2606 OID 28205393)
-- Dependencies: 268 351 3972
-- Name: fk_dbunidades__dbprocessos_academicos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprocessos_academicos
    ADD CONSTRAINT fk_dbunidades__dbprocessos_academicos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4132 (class 2606 OID 28205398)
-- Dependencies: 3972 270 351
-- Name: fk_dbunidades__dbprodutos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprodutos
    ADD CONSTRAINT fk_dbunidades__dbprodutos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4134 (class 2606 OID 28205403)
-- Dependencies: 3972 272 351
-- Name: fk_dbunidades__dbprodutos_insumos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprodutos_caracteristicas
    ADD CONSTRAINT fk_dbunidades__dbprodutos_insumos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4137 (class 2606 OID 28205408)
-- Dependencies: 277 351 3972
-- Name: fk_dbunidades__dbprodutos_parametros__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprodutos_parametros
    ADD CONSTRAINT fk_dbunidades__dbprodutos_parametros__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4139 (class 2606 OID 28205413)
-- Dependencies: 279 351 3972
-- Name: fk_dbunidades__dbprodutos_tabelapreco__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprodutos_tabelapreco
    ADD CONSTRAINT fk_dbunidades__dbprodutos_tabelapreco__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4140 (class 2606 OID 28205418)
-- Dependencies: 3972 281 351
-- Name: fk_dbunidades__dbprodutos_tipos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprodutos_tipos
    ADD CONSTRAINT fk_dbunidades__dbprodutos_tipos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4142 (class 2606 OID 28205423)
-- Dependencies: 351 3972 283
-- Name: fk_dbunidades__dbprodutos_tributos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprodutos_tributos
    ADD CONSTRAINT fk_dbunidades__dbprodutos_tributos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4145 (class 2606 OID 28205428)
-- Dependencies: 3972 285 351
-- Name: fk_dbunidades__dbprofessores_areas__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprofessores_areas
    ADD CONSTRAINT fk_dbunidades__dbprofessores_areas__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4146 (class 2606 OID 28205433)
-- Dependencies: 3972 351 287
-- Name: fk_dbunidades__dbprojetos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprojetos
    ADD CONSTRAINT fk_dbunidades__dbprojetos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4149 (class 2606 OID 28205438)
-- Dependencies: 3972 351 289
-- Name: fk_dbunidades__dbprojetos_colaboradores__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprojetos_colaboradores
    ADD CONSTRAINT fk_dbunidades__dbprojetos_colaboradores__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4151 (class 2606 OID 28205443)
-- Dependencies: 351 3972 291
-- Name: fk_dbunidades__dbprojetos_custos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprojetos_custos
    ADD CONSTRAINT fk_dbunidades__dbprojetos_custos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4153 (class 2606 OID 28205448)
-- Dependencies: 351 3972 293
-- Name: fk_dbunidades__dbprojetos_recursos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprojetos_recursos
    ADD CONSTRAINT fk_dbunidades__dbprojetos_recursos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4154 (class 2606 OID 28205453)
-- Dependencies: 295 3972 351
-- Name: fk_dbunidades__dbquestionarios__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbquestionarios
    ADD CONSTRAINT fk_dbunidades__dbquestionarios__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4156 (class 2606 OID 28205458)
-- Dependencies: 297 3972 351
-- Name: fk_dbunidades__dbquestoes__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbquestoes
    ADD CONSTRAINT fk_dbunidades__dbquestoes__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4158 (class 2606 OID 28205463)
-- Dependencies: 3972 299 351
-- Name: fk_dbunidades__dbquestoes_itens__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbquestoes_itens
    ADD CONSTRAINT fk_dbunidades__dbquestoes_itens__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4159 (class 2606 OID 28205468)
-- Dependencies: 3972 351 303
-- Name: fk_dbunidades__dbsalas__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbsalas
    ADD CONSTRAINT fk_dbunidades__dbsalas__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4160 (class 2606 OID 28205473)
-- Dependencies: 351 305 3972
-- Name: fk_dbunidades__dbscorecard__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbscorecard
    ADD CONSTRAINT fk_dbunidades__dbscorecard__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4162 (class 2606 OID 28205478)
-- Dependencies: 351 307 3972
-- Name: fk_dbunidades__dbscorecard_sentencas__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbscorecard_sentencas
    ADD CONSTRAINT fk_dbunidades__dbscorecard_sentencas__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4165 (class 2606 OID 28205483)
-- Dependencies: 311 3972 351
-- Name: fk_dbunidades__dbtransacoes__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes
    ADD CONSTRAINT fk_dbunidades__dbtransacoes__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4169 (class 2606 OID 28205488)
-- Dependencies: 351 3972 313
-- Name: fk_dbunidades__dbtransacoes_contas__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes_contas
    ADD CONSTRAINT fk_dbunidades__dbtransacoes_contas__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4175 (class 2606 OID 28205493)
-- Dependencies: 317 351 3972
-- Name: fk_dbunidades__dbtransacoes_contas_extornos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes_contas_extornos
    ADD CONSTRAINT fk_dbunidades__dbtransacoes_contas_extornos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4178 (class 2606 OID 28205498)
-- Dependencies: 320 3972 351
-- Name: fk_dbunidades__dbtransacoes_convenios__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes_convenios
    ADD CONSTRAINT fk_dbunidades__dbtransacoes_convenios__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4181 (class 2606 OID 28205503)
-- Dependencies: 3972 351 323
-- Name: fk_dbunidades__dbtransacoes_produtos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes_produtos
    ADD CONSTRAINT fk_dbunidades__dbtransacoes_produtos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4182 (class 2606 OID 28205508)
-- Dependencies: 325 351 3972
-- Name: fk_dbunidades__dbtreinamentos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtreinamentos
    ADD CONSTRAINT fk_dbunidades__dbtreinamentos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4183 (class 2606 OID 28205513)
-- Dependencies: 351 327 3972
-- Name: fk_dbunidades__dbtributos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtributos
    ADD CONSTRAINT fk_dbunidades__dbtributos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4187 (class 2606 OID 28205518)
-- Dependencies: 3972 351 329
-- Name: fk_dbunidades__dbturmas__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas
    ADD CONSTRAINT fk_dbunidades__dbturmas__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4190 (class 2606 OID 28205523)
-- Dependencies: 351 330 3972
-- Name: fk_dbunidades__dbturmas_convenios__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_convenios
    ADD CONSTRAINT fk_dbunidades__dbturmas_convenios__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4192 (class 2606 OID 28205528)
-- Dependencies: 3972 333 351
-- Name: fk_dbunidades__dbturmas_descontos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_descontos
    ADD CONSTRAINT fk_dbunidades__dbturmas_descontos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4198 (class 2606 OID 28205533)
-- Dependencies: 3972 335 351
-- Name: fk_dbunidades__dbturmas_disciplinas__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas
    ADD CONSTRAINT fk_dbunidades__dbturmas_disciplinas__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4201 (class 2606 OID 28205538)
-- Dependencies: 3972 337 351
-- Name: fk_dbunidades__dbturmas_disciplinas_arquivos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas_arquivos
    ADD CONSTRAINT fk_dbunidades__dbturmas_disciplinas_arquivos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4203 (class 2606 OID 28205543)
-- Dependencies: 3972 351 339
-- Name: fk_dbunidades__dbturmas_disciplinas_aulas__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas_aulas
    ADD CONSTRAINT fk_dbunidades__dbturmas_disciplinas_aulas__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4205 (class 2606 OID 28205548)
-- Dependencies: 351 340 3972
-- Name: fk_dbunidades__dbturmas_disciplinas_avaliacao_detalhamento__uni; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas_avaliacao_detalhamento
    ADD CONSTRAINT fk_dbunidades__dbturmas_disciplinas_avaliacao_detalhamento__uni FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4208 (class 2606 OID 28205553)
-- Dependencies: 351 343 3972
-- Name: fk_dbunidades__dbturmas_disciplinas_avaliacoes__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas_avaliacoes
    ADD CONSTRAINT fk_dbunidades__dbturmas_disciplinas_avaliacoes__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4210 (class 2606 OID 28205558)
-- Dependencies: 3972 351 345
-- Name: fk_dbunidades__dbturmas_disciplinas_materiais__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas_materiais
    ADD CONSTRAINT fk_dbunidades__dbturmas_disciplinas_materiais__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4213 (class 2606 OID 28205563)
-- Dependencies: 347 351 3972
-- Name: fk_dbunidades__dbturmas_disciplinas_planoaulas__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas_planoaulas
    ADD CONSTRAINT fk_dbunidades__dbturmas_disciplinas_planoaulas__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4215 (class 2606 OID 28205568)
-- Dependencies: 3972 349 351
-- Name: fk_dbunidades__dbturmas_requisitos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_requisitos
    ADD CONSTRAINT fk_dbunidades__dbturmas_requisitos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4216 (class 2606 OID 28205573)
-- Dependencies: 3972 353 351
-- Name: fk_dbunidades__dbunidades_parametros__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbunidades_parametros
    ADD CONSTRAINT fk_dbunidades__dbunidades_parametros__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4218 (class 2606 OID 28205578)
-- Dependencies: 3972 355 351
-- Name: fk_dbunidades__dbusuarios__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbusuarios
    ADD CONSTRAINT fk_dbunidades__dbusuarios__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4219 (class 2606 OID 28205583)
-- Dependencies: 3972 351 357
-- Name: fk_dbunidades__dbusuarios_erros__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbusuarios_erros
    ADD CONSTRAINT fk_dbunidades__dbusuarios_erros__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4221 (class 2606 OID 28205588)
-- Dependencies: 3972 359 351
-- Name: fk_dbunidades__dbusuarios_historico__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbusuarios_historico
    ADD CONSTRAINT fk_dbunidades__dbusuarios_historico__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4223 (class 2606 OID 28205593)
-- Dependencies: 361 3972 351
-- Name: fk_dbunidades__dbusuarios_privilegios__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbusuarios_privilegios
    ADD CONSTRAINT fk_dbunidades__dbusuarios_privilegios__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4172 (class 2606 OID 28205598)
-- Dependencies: 315 351 3972
-- Name: fk_dbunidades_dbtransacoes_contas_duplicatas__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes_contas_duplicatas
    ADD CONSTRAINT fk_dbunidades_dbtransacoes_contas_duplicatas__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4220 (class 2606 OID 28205603)
-- Dependencies: 355 3980 357
-- Name: fk_dbusuarios__dbusuarios_erros__codigousuario; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbusuarios_erros
    ADD CONSTRAINT fk_dbusuarios__dbusuarios_erros__codigousuario FOREIGN KEY (codigousuario) REFERENCES dbusuarios(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4222 (class 2606 OID 28205608)
-- Dependencies: 355 359 3980
-- Name: fk_dbusuarios__dbusuarios_historico__codigousuario; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbusuarios_historico
    ADD CONSTRAINT fk_dbusuarios__dbusuarios_historico__codigousuario FOREIGN KEY (codigousuario) REFERENCES dbusuarios(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4224 (class 2606 OID 28205613)
-- Dependencies: 361 3980 355
-- Name: fk_dbusuarios__dbusuarios_privilegios__codigousuario; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbusuarios_privilegios
    ADD CONSTRAINT fk_dbusuarios__dbusuarios_privilegios__codigousuario FOREIGN KEY (codigousuario) REFERENCES dbusuarios(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4010 (class 2606 OID 28205618)
-- Dependencies: 154 161 3601
-- Name: pk_dbavaliacoes__dbalunos_notas_codigoavaliacao; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_notas
    ADD CONSTRAINT pk_dbavaliacoes__dbalunos_notas_codigoavaliacao FOREIGN KEY (codigoavaliacao) REFERENCES dbavaliacoes(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


-- Completed on 2012-05-16 00:01:09

--
-- PostgreSQL database dump complete
--

