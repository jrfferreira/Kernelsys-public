--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: dominio; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA dominio;


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: atualiza_pessoa_funcionario(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION atualiza_pessoa_funcionario() RETURNS trigger
    LANGUAGE plpgsql
    AS 'DECLARE
	codigos INTEGER;
    BEGIN
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
        RETURN NULL;
    END;';


SET search_path = dominio, pg_catalog;

SET default_with_oids = false;

--
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
-- Name: dbceps_id_seq; Type: SEQUENCE; Schema: dominio; Owner: -
--

CREATE SEQUENCE dbceps_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: dbceps_id_seq; Type: SEQUENCE OWNED BY; Schema: dominio; Owner: -
--

ALTER SEQUENCE dbceps_id_seq OWNED BY dbceps.id;


--
-- Name: dbcidades; Type: TABLE; Schema: dominio; Owner: -
--

CREATE TABLE dbcidades (
    id integer NOT NULL,
    cidade character varying(200),
    codigouf character varying(2),
    codigoibge character varying(30)
);


--
-- Name: dbcidades_id_seq; Type: SEQUENCE; Schema: dominio; Owner: -
--

CREATE SEQUENCE dbcidades_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: dbcidades_id_seq; Type: SEQUENCE OWNED BY; Schema: dominio; Owner: -
--

ALTER SEQUENCE dbcidades_id_seq OWNED BY dbcidades.id;


--
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
-- Name: dbestados_id_seq; Type: SEQUENCE; Schema: dominio; Owner: -
--

CREATE SEQUENCE dbestados_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: dbestados_id_seq; Type: SEQUENCE OWNED BY; Schema: dominio; Owner: -
--

ALTER SEQUENCE dbestados_id_seq OWNED BY dbestados.id;


--
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
-- Name: dbnfe_erros_grupos; Type: TABLE; Schema: dominio; Owner: -
--

CREATE TABLE dbnfe_erros_grupos (
    id integer NOT NULL,
    grupo character varying(1),
    descricao text,
    aplicacao character varying(40)
);


--
-- Name: dbnfe_erros_id_seq; Type: SEQUENCE; Schema: dominio; Owner: -
--

CREATE SEQUENCE dbnfe_erros_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: dbnfe_erros_id_seq; Type: SEQUENCE OWNED BY; Schema: dominio; Owner: -
--

ALTER SEQUENCE dbnfe_erros_id_seq OWNED BY dbnfe_erros.id;


--
-- Name: dbnfe_erros_mensagens; Type: TABLE; Schema: dominio; Owner: -
--

CREATE TABLE dbnfe_erros_mensagens (
    id integer NOT NULL,
    codigo character varying(10),
    descricao text
);


--
-- Name: dbpaises; Type: TABLE; Schema: dominio; Owner: -
--

CREATE TABLE dbpaises (
    id integer NOT NULL,
    pais character varying(200),
    codigopais character varying(30),
    tributacaofavorecida character varying(30)
);


--
-- Name: dbpaises_id_seq; Type: SEQUENCE; Schema: dominio; Owner: -
--

CREATE SEQUENCE dbpaises_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: dbpaises_id_seq; Type: SEQUENCE OWNED BY; Schema: dominio; Owner: -
--

ALTER SEQUENCE dbpaises_id_seq OWNED BY dbpaises.id;


--
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
-- Name: dbwebservices_campos_id_seq; Type: SEQUENCE; Schema: dominio; Owner: -
--

CREATE SEQUENCE dbwebservices_campos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: dbwebservices_campos_id_seq; Type: SEQUENCE OWNED BY; Schema: dominio; Owner: -
--

ALTER SEQUENCE dbwebservices_campos_id_seq OWNED BY dbwebservices_campos.id;


--
-- Name: dbwebservices_id_seq; Type: SEQUENCE; Schema: dominio; Owner: -
--

CREATE SEQUENCE dbwebservices_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: dbwebservices_id_seq; Type: SEQUENCE OWNED BY; Schema: dominio; Owner: -
--

ALTER SEQUENCE dbwebservices_id_seq OWNED BY dbwebservices.id;


SET search_path = public, pg_catalog;

--
-- Name: codigo; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE codigo (
    codigo character varying(20)
);


--
-- Name: codigopessoa; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE codigopessoa (
    codigo character varying(20)
);


--
-- Name: dbalunos_disciplinas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbalunos_disciplinas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: gerador_codigo_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE gerador_codigo_seq
    START WITH 10000000
    INCREMENT BY 1
    MINVALUE 10000000
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbalunos_disciplinas_aproveitamentos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbalunos_disciplinas_aproveitamentos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbalunos_faltas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbalunos_faltas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbalunos_notas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbalunos_notas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbalunos_requisitos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbalunos_requisitos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbalunos_solicitacoes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbalunos_solicitacoes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbalunos_transacoes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbalunos_transacoes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbavaliacoes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbavaliacoes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: dbavaliacoes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dbavaliacoes_id_seq OWNED BY dbavaliacoes.id;


--
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
-- Name: dbavaliacoes_regras_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbavaliacoes_regras_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: dbavaliacoes_regras_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dbavaliacoes_regras_id_seq OWNED BY dbavaliacoes_regras.id;


--
-- Name: dbbalanco_patrimonial_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbbalanco_patrimonial_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbbiblioteca_cdu_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbbiblioteca_cdu_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbcaixa_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbcaixa_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: COLUMN dbcaixa.valorreal; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbcaixa.valorreal IS 'Valor real da conta, sem acresciomos e descontos. Esse valor é o valor atual da conta que pode ser diferente do valor nominal inicial.';


--
-- Name: COLUMN dbcaixa.statusmovimento; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbcaixa.statusmovimento IS 'Status do movimento do caixa

1 = Movimento em aberto
2 = Movimento conferido
3 = Movimento programado
4 = Movimento extornado
5 = Movimento Consolidado';


--
-- Name: dbcaixa_fechamentos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbcaixa_fechamentos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbcaixa_funcionarios_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbcaixa_funcionarios_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: COLUMN dbcaixa_funcionarios.situacao; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbcaixa_funcionarios.situacao IS '1 = Liberado para Movimentações
2 = Aguardando Liberação';


--
-- Name: dbcargos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbcargos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbceps_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbceps_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: dbcidades_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbcidades_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: dbcompras_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbcompras_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbcontas_caixa_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbcontas_caixa_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: COLUMN dbcontas_caixa.situacao; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbcontas_caixa.situacao IS '1 = Liberado para Movimentações.
2 = Aguardando liberação.';


--
-- Name: dbcontas_caixa_historico_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbcontas_caixa_historico_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbcontas_cheques_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbcontas_cheques_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbcontratos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbcontratos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbconvenios_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbconvenios_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: COLUMN dbconvenios.tipoconvenio; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbconvenios.tipoconvenio IS 'Tipo de convênio.

1 = Desconto
2 = Bolsa
3 = Parceria';


--
-- Name: COLUMN dbconvenios.tipotransacao; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbconvenios.tipotransacao IS 'tipo da transação a ser gerada pela associação do convênio a uma pessoa

1 = crédito
2 = débito';


--
-- Name: COLUMN dbconvenios.valor; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbconvenios.valor IS 'valor do crédito/débito a ser gerado em função do escobo do convênio';


--
-- Name: COLUMN dbconvenios.formato; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbconvenios.formato IS 'formato do valor

1 = valor
2 = percentual';


--
-- Name: COLUMN dbconvenios.datavigencia; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbconvenios.datavigencia IS 'data em que o convênio entra em vigor.';


--
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
-- Name: dbconvenios_descontos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbconvenios_descontos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: dbconvenios_descontos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dbconvenios_descontos_id_seq OWNED BY dbconvenios_descontos.id;


--
-- Name: dbcotacoes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbcotacoes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbcrm_demandas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbcrm_demandas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbcurriculos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbcurriculos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbcursos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbcursos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbcursos_areas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbcursos_areas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbcursos_ativos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbcursos_ativos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbcursos_avaliacoes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbcursos_avaliacoes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbcursos_disciplinas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbcursos_disciplinas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbcursos_tipos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbcursos_tipos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbdados_boleto_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbdados_boleto_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbdepartamentos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbdepartamentos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbdisciplinas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbdisciplinas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbdisciplinas_semelhantes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbdisciplinas_semelhantes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbdocumentos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbdocumentos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbestados_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbestados_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: dbfuncionarios_ferias_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbfuncionarios_ferias_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbfuncionarios_folhapagamento_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbfuncionarios_folhapagamento_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbfuncionarios_ocorrencias_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbfuncionarios_ocorrencias_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbfuncionarios_professores_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbfuncionarios_professores_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbfuncionarios_treinamentos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbfuncionarios_treinamentos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbgrade_avaliacoes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbgrade_avaliacoes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: dbgrade_avaliacoes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dbgrade_avaliacoes_id_seq OWNED BY dbgrade_avaliacoes.id;


--
-- Name: dbpaises_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbpaises_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: dbpatrimonios_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbpatrimonios_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbpatrimonios_livros_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbpatrimonios_livros_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbpessoas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbpessoas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbpessoas_alunos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbpessoas_alunos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbpessoas_complemento_pf_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbpessoas_complemento_pf_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbpessoas_complemento_pj_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbpessoas_complemento_pj_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbpessoas_convenios_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbpessoas_convenios_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbpessoas_demandas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbpessoas_demandas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbpessoas_enderecoscobrancas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbpessoas_enderecoscobrancas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbpessoas_formacoes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbpessoas_formacoes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbpessoas_funcionarios_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbpessoas_funcionarios_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbpessoas_inscricoes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbpessoas_inscricoes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbpessoas_livros_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbpessoas_livros_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbpessoas_solicitacoes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbpessoas_solicitacoes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbpessoas_titularidades_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbpessoas_titularidades_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbplano_contas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbplano_contas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbprocessos_academicos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbprocessos_academicos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbprodutos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbprodutos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbprodutos_caracteristicas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbprodutos_caracteristicas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbprodutos_financeiro_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbprodutos_financeiro_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: dbprodutos_formulacao_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbprodutos_formulacao_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: dbprodutos_midia_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbprodutos_midia_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: dbprodutos_parametros_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbprodutos_parametros_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbprodutos_tabelapreco_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbprodutos_tabelapreco_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbprodutos_tipos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbprodutos_tipos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbprodutos_tributos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbprodutos_tributos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbprofessores_areas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbprofessores_areas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbprojetos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbprojetos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbprojetos_colaboradores_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbprojetos_colaboradores_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbprojetos_custos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbprojetos_custos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbprojetos_recursos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbprojetos_recursos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbquestionarios_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbquestionarios_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbquestoes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbquestoes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbquestoes_itens_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbquestoes_itens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbrecados_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbrecados_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbsalas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbsalas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbscorecard_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbscorecard_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbscorecard_sentencas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbscorecard_sentencas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbstatus; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbstatus (
    id integer NOT NULL,
    situacao character varying(180),
    obs text
);


--
-- Name: dbstatus_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbstatus_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: dbstatus_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dbstatus_id_seq OWNED BY dbstatus.id;


--
-- Name: dbtransacoes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbtransacoes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbtransacoes_contas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbtransacoes_contas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: COLUMN dbtransacoes_contas.valorreal; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbtransacoes_contas.valorreal IS 'Valor real da conta, considerando pagamentos parciais da conta.';


--
-- Name: dbtransacoes_contas_duplicatas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbtransacoes_contas_duplicatas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbtransacoes_contas_extornos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbtransacoes_contas_extornos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbtransacoes_contas_situacao_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbtransacoes_contas_situacao_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: dbtransacoes_contas_situacao_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dbtransacoes_contas_situacao_id_seq OWNED BY dbtransacoes_contas_situacao.id;


--
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
-- Name: dbtransacoes_convenios_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbtransacoes_convenios_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: dbtransacoes_convenios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dbtransacoes_convenios_id_seq OWNED BY dbtransacoes_convenios.id;


--
-- Name: dbtransacoes_produtos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbtransacoes_produtos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbtreinamentos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbtreinamentos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbtributos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbtributos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbturmas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbturmas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbturmas_convenios_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbturmas_convenios_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: dbturmas_convenios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dbturmas_convenios_id_seq OWNED BY dbturmas_convenios.id;


--
-- Name: dbturmas_descontos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbturmas_descontos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: COLUMN dbturmas_descontos.tipodesconto; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbturmas_descontos.tipodesconto IS '1 = Desconto Percentual / 2 = Desconto Fixo';


--
-- Name: dbturmas_disciplinas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbturmas_disciplinas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbturmas_disciplinas_arquivos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbturmas_disciplinas_arquivos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbturmas_disciplinas_aulas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbturmas_disciplinas_aulas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbturmas_disciplinas_avaliacao_detalhamento_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbturmas_disciplinas_avaliacao_detalhamento_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: dbturmas_disciplinas_avaliacao_detalhamento_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dbturmas_disciplinas_avaliacao_detalhamento_id_seq OWNED BY dbturmas_disciplinas_avaliacao_detalhamento.id;


--
-- Name: dbturmas_disciplinas_avaliacoes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbturmas_disciplinas_avaliacoes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbturmas_disciplinas_materiais_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbturmas_disciplinas_materiais_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbturmas_disciplinas_planoaulas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbturmas_disciplinas_planoaulas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbturmas_requisitos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbturmas_requisitos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbunidades_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbunidades_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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


--
-- Name: dbunidades_parametros_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbunidades_parametros_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbusuarios_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbusuarios_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbusuarios_erros_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbusuarios_erros_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbusuarios_historico_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbusuarios_historico_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: dbusuarios_privilegios_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbusuarios_privilegios_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
-- Name: COLUMN dbusuarios_privilegios.funcionalidade; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbusuarios_privilegios.funcionalidade IS 'Id da funcionalidade sobre a qual o privilegio se associa.
Caso a funcionalidade seja o modulo principal o valor padrão é [0]';


--
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
-- Name: dbusuarios_senhas_recuperacao; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbusuarios_senhas_recuperacao (
    id integer NOT NULL,
    codigo character varying(20) DEFAULT ((nextval('gerador_codigo_seq'::regclass) || '-'::text) || nextval('gerador_codigo_digito_seq'::regclass)) NOT NULL,
    unidade character varying(30),
    codigoautor character varying(20) DEFAULT '0000'::character varying NOT NULL,
    codigousuario character varying(30),
    chave integer DEFAULT 0,
    senhaantiga integer,
    senhanova integer DEFAULT 0 NOT NULL,
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    ativo character varying(2) DEFAULT '9'::character varying NOT NULL
);


--
-- Name: dbusuarios_senhas_recuperacao_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbusuarios_senhas_recuperacao_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: dbusuarios_senhas_recuperacao_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dbusuarios_senhas_recuperacao_id_seq OWNED BY dbusuarios_senhas_recuperacao.id;


--
-- Name: view_turmas_disciplinas; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_turmas_disciplinas AS
    SELECT t0.id, (t0.codigo)::text AS codigo, (t0.unidade)::text AS unidade, (t0.codigoturma)::text AS codigoturma, (t3.codigocurso)::text AS codigocurso, (t0.codigodisciplina)::text AS codigodisciplina, (t0.codigoprofessor)::text AS codigoprofessor, to_char((t0.datarealizacao)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datarealizacao, to_char((t0.dataatualizacao)::timestamp with time zone, 'DD/MM/YYYY'::text) AS dataatualizacao, (t0.frequencia)::text AS frequencia, t0.datas, (t0.custohoraaula)::text AS custohoraaula, (t0.regimetrabalho)::text AS regimetrabalho, (t0.custohospedagem)::text AS custohospedagem, (t0.custodeslocamento)::text AS custodeslocamento, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t6.nome)::text AS sala, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t2.nome)::text AS nomecurso, (t3.titulo)::text AS nometurma, (t4.titulo)::text AS nomedisciplina, (t4.cargahoraria)::text AS cargahoraria, (t5.nome_razaosocial)::text AS nomeprofessor, ((SELECT count(dbalunos_disciplinas.codigo) AS count FROM dbalunos_disciplinas WHERE (((dbalunos_disciplinas.codigoturmadisciplina)::text = (t0.codigo)::text) AND ((dbalunos_disciplinas.situacao)::text = '2'::text))))::text AS alunos, (t0.codigosala)::text AS codigosala, (t3.codigograde)::text AS codigograde, t3.status, t0.custoalimentacao, t0.custoextra FROM ((((((dbturmas_disciplinas t0 LEFT JOIN dbturmas t3 ON (((t3.codigo)::text = (t0.codigoturma)::text))) LEFT JOIN dbcursos t2 ON (((t2.codigo)::text = (t3.codigocurso)::text))) LEFT JOIN dbdisciplinas t4 ON (((t4.codigo)::text = (t0.codigodisciplina)::text))) LEFT JOIN dbpessoas t5 ON (((t5.codigo)::text = ((SELECT t8.codigopessoa FROM dbpessoas_funcionarios t8 WHERE ((t8.codigo)::text = ((SELECT t9.codigofuncionario FROM dbfuncionarios_professores t9 WHERE ((t9.codigo)::text = (t0.codigoprofessor)::text)))::text)))::text))) LEFT JOIN dbsalas t6 ON (((t6.codigo)::text = (t0.codigosala)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t0.ativo)::text)));


--
-- Name: view_alunos_disciplinas; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_alunos_disciplinas AS
    SELECT t0.id, (t0.codigo)::text AS codigo, (t0.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, (t0.codigoaluno)::text AS codigoaluno, (t0.codigodisciplina)::text AS codigodisciplina, (t0.codigoturmadisciplina)::text AS codigoturmadisciplina, (t0.situacao)::text AS situacao, t0.obs, (t3.nome_razaosocial)::text AS nomepessoa, t4.nometurma, (t5.titulo)::text AS nomedisciplina, t4.codigocurso, t4.codigoturma, t4.nomecurso, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, t4.codigograde FROM (((((dbalunos_disciplinas t0 LEFT JOIN dbpessoas_alunos t2 ON (((t2.codigo)::text = (t0.codigoaluno)::text))) LEFT JOIN dbpessoas t3 ON (((t3.codigo)::text = (t2.codigopessoa)::text))) LEFT JOIN view_turmas_disciplinas t4 ON ((t4.codigo = (t0.codigoturmadisciplina)::text))) LEFT JOIN dbdisciplinas t5 ON (((t5.codigo)::text = (t0.codigodisciplina)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t0.ativo)::text)));


--
-- Name: view_alunos_faltas; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_alunos_faltas AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigoaluno)::text AS codigoaluno, (t1.codigoturmadisciplina)::text AS codigoturmadisciplina, (t1.codigoaula)::text AS codigoaula, to_char((t1.datafalta)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datafalta, (t1.numaula)::text AS numaula, t1.justificativa, t1.obs, (t1.situacao)::text AS situacao, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, t2.titulo AS nomedisciplina FROM ((dbalunos_faltas t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text))) LEFT JOIN dbdisciplinas t2 ON (((t2.codigo)::text = ((SELECT t90.codigodisciplina FROM dbturmas_disciplinas t90 WHERE ((t90.codigo)::text = (t1.codigoturmadisciplina)::text)))::text)));


--
-- Name: view_alunos_notas; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_alunos_notas AS
    SELECT t0.id, (t0.codigo)::text AS codigo, (t0.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, (t0.codigoaluno)::text AS codigoaluno, (t0.codigoturmadisciplina)::text AS codigoturmadisciplina, (t0.codigoavaliacao)::text AS codigoavaliacao, (t0.nota)::text AS nota, (t0.ordemavaliacao)::text AS ordemavaliacao, (t3.nome_razaosocial)::text AS nomepessoa, t4.nometurma, t4.nomedisciplina, t4.codigocurso, t4.codigoturma, t4.nomecurso, t6.avaliacao, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, t4.codigograde FROM (((((dbalunos_notas t0 LEFT JOIN dbpessoas_alunos t2 ON (((t2.codigo)::text = (t0.codigoaluno)::text))) LEFT JOIN dbpessoas t3 ON (((t3.codigo)::text = (t2.codigopessoa)::text))) LEFT JOIN view_turmas_disciplinas t4 ON ((t4.codigo = (t0.codigoturmadisciplina)::text))) LEFT JOIN dbavaliacoes t6 ON (((t6.codigo)::text = (t0.codigoavaliacao)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t0.ativo)::text)));


--
-- Name: view_alunos_solicitacoes; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_alunos_solicitacoes AS
    SELECT t0.id, (t0.codigo)::text AS codigo, (t0.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, (t0.codigoaluno)::text AS codigoaluno, (t0.codigosolicitacao)::text AS codigosolicitacao, (t0.data)::text AS data, t0.justificativa, t0.atendimento, (t0.codigofuncionario)::text AS codigofuncionario, (t0.codigodepartamento)::text AS codigodepartamento, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t0.status)::text AS status, (t4.nome_razaosocial)::text AS nomealuno, (t3.nome_razaosocial)::text AS nomefuncionario, (t5.label)::text AS nomedepartamento, (t6.titulo)::text AS solicitacao FROM ((((((dbalunos_solicitacoes t0 LEFT JOIN dbpessoas_alunos t2 ON (((t2.codigo)::text = (t0.codigoaluno)::text))) LEFT JOIN dbpessoas t4 ON (((t4.codigo)::text = (t2.codigopessoa)::text))) LEFT JOIN dbpessoas t3 ON (((t3.codigo)::text = ((SELECT t5.codigopessoa FROM dbpessoas_funcionarios t5 WHERE ((t5.codigo)::text = (t0.codigofuncionario)::text)))::text))) LEFT JOIN dbprocessos_academicos t6 ON (((t6.codigo)::text = (t0.codigosolicitacao)::text))) LEFT JOIN dbdepartamentos t5 ON (((t5.codigo)::text = (t0.codigodepartamento)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t0.ativo)::text)));


--
-- Name: view_biblioteca_cdu; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_biblioteca_cdu AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.cdu)::text AS cdu, (t1.titulo)::text AS titulo, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbbiblioteca_cdu t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- Name: view_caixa; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_caixa AS
    SELECT t0.id, (t0.codigo)::text AS codigo, (t0.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, (t0.codigoconta)::text AS codigoconta, (t0.codigoplanoconta)::text AS codigoplanoconta, (t0.codigocontacaixa)::text AS codigocontacaixa, (t5.nomeconta)::text AS nomeconta, (t0.codigopessoa)::text AS codigopessoa, (t0.codigotransacao)::text AS codigotransacao, (t0.numdoc)::text AS numdoc, to_char((t0.datadocumento)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datadocumento, (t0.tipomovimentacao)::text AS tipomovimentacao, (t0.tipoduplicata)::text AS tipoduplicata, (t0.valorreal)::text AS valorreal, to_char((t0.vencimento)::timestamp with time zone, 'DD/MM/YYYY'::text) AS vencimento, (t0.formadesconto)::text AS formadesconto, (t0.desconto)::text AS desconto, (t0.multaacrecimo)::text AS multaacrecimo, (t0.valorpago)::text AS valorpago, (t0.valorentrada)::text AS valorentrada, (t0.codigofuncionario)::text AS codigofuncionario, (t0.datapag)::text AS datapag, (t0.formapag)::text AS formapag, (t0.mora)::text AS mora, t0.obs, (t0.statusmovimento)::text AS statusmovimento, (t0.statusconta)::text AS statusconta, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t2.nomeconta)::text AS nomeplanoconta, (t3.nome_razaosocial)::text AS nomepessoa, (t0.codigohistorico)::text AS codigohistorico FROM ((((dbcaixa t0 LEFT JOIN dbcontas_caixa t5 ON (((t5.codigo)::text = (t0.codigocontacaixa)::text))) LEFT JOIN dbplano_contas t2 ON (((t2.codigo)::text = (t0.codigoplanoconta)::text))) LEFT JOIN dbpessoas t3 ON (((t3.codigo)::text = (t0.codigopessoa)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t0.ativo)::text)));


--
-- Name: view_caixa_fechamentos; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_caixa_fechamentos AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.valorprevisto)::text AS valorprevisto, (t1.receitatotal)::text AS receitatotal, (t1.despesatotal)::text AS despesatotal, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbcaixa_fechamentos t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- Name: view_pessoas_funcionarios; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_pessoas_funcionarios AS
    SELECT t0.id, (t2.codigo)::text AS codigofuncionario, (t0.unidade)::text AS unidade, (t0.codigo)::text AS codigo, (t0.nome_razaosocial)::text AS nomefuncionario, (t0.cpf_cnpj)::text AS cpf_cnpj, (t2.codigocargo)::text AS codigocargo, (t3.nomecargo)::text AS nomecargo, (t2.codigodepartamento)::text AS codigodepartamento, (t4.label)::text AS nomedepartamento, (t2.lotacao)::text AS lotacao, (t5.nome)::text AS nomesala, to_char((t2.dataadmissao)::timestamp with time zone, 'DD/MM/YYYY'::text) AS dataadmissao, (t2.ativo)::text AS situacao, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (((((dbpessoas t0 LEFT JOIN dbpessoas_funcionarios t2 ON (((t2.codigopessoa)::text = (t0.codigo)::text))) LEFT JOIN dbcargos t3 ON (((t3.codigo)::text = (t2.codigocargo)::text))) LEFT JOIN dbdepartamentos t4 ON (((t4.codigo)::text = (t2.codigodepartamento)::text))) LEFT JOIN dbsalas t5 ON (((t5.codigo)::text = (t2.lotacao)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t0.ativo)::text))) WHERE ((t0.codigo)::text = (t2.codigopessoa)::text);


--
-- Name: view_caixa_funcionarios; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_caixa_funcionarios AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigofuncionario)::text AS codigofuncionario, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, t1.obs, t2.nomefuncionario, t2.cpf_cnpj, t2.codigocargo, t2.nomecargo, (t1.situacao)::text AS situacao, (t1.codigocontacaixa)::text AS codigocontacaixa, (((t3.tipoconta)::text || ' - '::text) || (t3.nomeconta)::text) AS nomecontacaixa FROM (((dbcaixa_funcionarios t1 LEFT JOIN view_pessoas_funcionarios t2 ON ((t2.codigofuncionario = (t1.codigofuncionario)::text))) LEFT JOIN dbcontas_caixa t3 ON (((t3.codigo)::text = (t1.codigocontacaixa)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- Name: view_cargos; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_cargos AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.nomecargo)::text AS nomecargo, t1.descricao, t1.conhecimentos, t1.habilidades, t1.atitudes, t1.prerequisitos, (t1.cargahoraria)::text AS cargahoraria, (t1.horariotrabalho)::text AS horariotrabalho, t1.maquinasutilizadas, (t1.graurisco)::text AS graurisco, (t1.subordinado)::text AS subordinado, t1.cargoascendente, t1.cargodescendente, (t1.salariobase)::text AS salariobase, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbcargos t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- Name: view_compras; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_compras AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigoproduto)::text AS codigoproduto, (t1.valorunitario)::text AS valorunitario, (t1.tempoentrega)::text AS tempoentrega, (t1.quantidade)::text AS quantidade, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbcompras t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- Name: view_contas_caixa; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_contas_caixa AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.nomeconta)::text AS nomeconta, (t1.tipoconta)::text AS tipoconta, (t1.banco)::text AS banco, (t1.numconta)::text AS numconta, (t1.agencia)::text AS agencia, (t1.saldoinicial)::text AS saldoinicial, ((SELECT sum(dbcaixa.valorpago) AS sum FROM dbcaixa WHERE (((dbcaixa.codigocontacaixa)::text = (t1.codigo)::text) AND ((dbcaixa.tipomovimentacao)::text = 'C'::text))))::text AS entrada, ((SELECT sum(dbcaixa.valorpago) AS sum FROM dbcaixa WHERE (((dbcaixa.codigocontacaixa)::text = (t1.codigo)::text) AND ((dbcaixa.tipomovimentacao)::text = 'D'::text))))::text AS saida, (((t1.saldoinicial)::double precision + ((SELECT sum(temp1.valorpago) AS sum FROM dbcaixa temp1 WHERE (((temp1.codigocontacaixa)::text = (t1.codigo)::text) AND ((temp1.tipomovimentacao)::text = 'C'::text))))::double precision))::text AS saldo, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbcontas_caixa t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- Name: view_contas_caixa_historico; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_contas_caixa_historico AS
    SELECT t1.id, (t2.codigo)::text AS codigo, (t2.unidade)::text AS unidade, (t2.codigoautor)::text AS codigoautor, (t2.codigocontacaixa)::text AS codigocontacaixa, (t1.nomeconta)::text AS nomeconta, (t1.tipoconta)::text AS tipoconta, (t1.banco)::text AS banco, (t1.numconta)::text AS numconta, (t1.agencia)::text AS agencia, ((SELECT sum(dbcaixa.valorpago) AS sum FROM dbcaixa WHERE ((((dbcaixa.codigohistorico)::text = (t2.codigo)::text) AND ((dbcaixa.tipomovimentacao)::text = 'C'::text)) AND ((dbcaixa.formapag)::text = 'Dinheiro'::text))))::text AS entrada_dinheiro, ((SELECT sum(dbcaixa.valorpago) AS sum FROM dbcaixa WHERE ((((dbcaixa.codigohistorico)::text = (t2.codigo)::text) AND ((dbcaixa.tipomovimentacao)::text = 'D'::text)) AND ((dbcaixa.formapag)::text = 'Dinheiro'::text))))::text AS saida_dinheiro, ((SELECT sum(dbcaixa.valorpago) AS sum FROM dbcaixa WHERE ((((dbcaixa.codigohistorico)::text = (t2.codigo)::text) AND ((dbcaixa.tipomovimentacao)::text = 'C'::text)) AND ((dbcaixa.formapag)::text = 'Cheque'::text))))::text AS entrada_cheque, ((SELECT sum(dbcaixa.valorpago) AS sum FROM dbcaixa WHERE ((((dbcaixa.codigohistorico)::text = (t2.codigo)::text) AND ((dbcaixa.tipomovimentacao)::text = 'D'::text)) AND ((dbcaixa.formapag)::text = 'Cheque'::text))))::text AS saida_cheque, ((SELECT sum(dbcaixa.valorpago) AS sum FROM dbcaixa WHERE ((((dbcaixa.codigohistorico)::text = (t2.codigo)::text) AND ((dbcaixa.tipomovimentacao)::text = 'C'::text)) AND ((dbcaixa.formapag)::text = 'Cartão'::text))))::text AS entrada_cartao, ((SELECT sum(dbcaixa.valorpago) AS sum FROM dbcaixa WHERE ((((dbcaixa.codigohistorico)::text = (t2.codigo)::text) AND ((dbcaixa.tipomovimentacao)::text = 'D'::text)) AND ((dbcaixa.formapag)::text = 'Cartão'::text))))::text AS saida_cartao, to_char((t2.datainicio)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datainicio, to_char((t2.datafim)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datafim, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM ((dbcontas_caixa_historico t2 LEFT JOIN dbcontas_caixa t1 ON (((t1.codigo)::text = (t2.codigocontacaixa)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t2.ativo)::text))) WHERE ((t2.ativo)::text = '1'::text);


--
-- Name: view_contas_cheques; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_contas_cheques AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigopessoa)::text AS codigopessoa, (t1.nometitular)::text AS nometitular, (t1.banco)::text AS banco, (t1.agencia)::text AS agencia, (t1.numconta)::text AS numconta, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, t1.obs, (t1.codigocaixa)::text AS codigocaixa, (t1.codigoconta)::text AS codigoconta, (t1.numcheque)::text AS numcheque, (t1.valor)::text AS valor, (t1.cpf_cnpj)::text AS cpf_cnpj FROM (dbcontas_cheques t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- Name: view_contratos; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_contratos AS
    SELECT t0.id, (t0.codigo)::text AS codigo, (t0.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, (t0.codigopessoa)::text AS codigopessoa, (t0.tipodocumento)::text AS tipodocumento, to_char((t0.dataassinatura)::timestamp with time zone, 'DD/MM/YYYY'::text) AS dataassinatura, to_char((t0.datatermino)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datatermino, t0.arquivo, (t0.codigoproduto)::text AS codigoproduto, (t0.tipoassinatura)::text AS tipoassinatura, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t2.nome_razaosocial)::text AS nomepessoa, (t3.titulo)::text AS nomedocumento, (t4.label)::text AS nomeproduto FROM ((((dbcontratos t0 LEFT JOIN dbpessoas t2 ON (((t2.codigo)::text = (t0.codigopessoa)::text))) LEFT JOIN dbdocumentos t3 ON (((t3.codigo)::text = (t0.tipodocumento)::text))) LEFT JOIN dbprodutos t4 ON (((t4.codigo)::text = (t0.codigoproduto)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t0.ativo)::text)));


--
-- Name: view_convenios; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_convenios AS
    SELECT t0.id, (t0.codigo)::text AS codigo, (t0.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, (t0.codigopessoa)::text AS codigopessoa, (t0.titulo)::text AS titulo, t0.descricao, (t0.tipoconvenio)::text AS tipoconvenio, (t0.tipotransacao)::text AS tipotransacao, (t0.datavigencia)::text AS datavigencia, t0.codigoplanoconta, t3.nomeconta AS nomeplanoconta, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t1.nome_razaosocial)::text AS concedente FROM (((dbconvenios t0 LEFT JOIN dbplano_contas t3 ON (((t3.codigo)::text = (t0.codigoplanoconta)::text))) LEFT JOIN dbpessoas t1 ON (((t1.codigo)::text = (t0.codigopessoa)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- Name: view_cotacoes; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_cotacoes AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigoproduto)::text AS codigoproduto, (t1.codigofornecedor)::text AS codigofornecedor, (t1.preco)::text AS preco, (t1.entrega)::text AS entrega, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbcotacoes t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- Name: view_curriculos; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_curriculos AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.nome)::text AS nome, (t1.sexo)::text AS sexo, (t1.datanasc)::text AS datanasc, (t1.cpf)::text AS cpf, (t1.logadouro)::text AS logadouro, (t1.cidade)::text AS cidade, (t1.estado)::text AS estado, (t1.bairro)::text AS bairro, (t1.telefone)::text AS telefone, (t1.celular)::text AS celular, (t1.email)::text AS email, (t1.estadocivil)::text AS estadocivil, (t1.cnh)::text AS cnh, (t1.dependentes)::text AS dependentes, t1.idiomas, (t1.areainteresse)::text AS areainteresse, (t1.areainteresse2)::text AS areainteresse2, (t1.areainteresse3)::text AS areainteresse3, (t1.escolaridade)::text AS escolaridade, t1.cursos, t1.experiencia, t1.obs, t1.resumo, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbcurriculos t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- Name: view_cursos; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_cursos AS
    SELECT t0.id, (t0.codigo)::text AS codigo, (t0.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, (t0.nome)::text AS nome, (t0.codigotipocurso)::text AS codigotipocurso, (t0.codigoareacurso)::text AS codigoareacurso, t0.objetivocurso, t0.publicoalvo, (t0.cargahortotal)::text AS cargahortotal, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t2.titulo)::text AS areacurso, ((SELECT sum(t4.cargahoraria) AS sum FROM dbdisciplinas t4 WHERE ((t4.codigo)::text IN (SELECT t5.codigodisciplina FROM dbcursos_disciplinas t5 WHERE ((t5.codigocurso)::text = (t0.codigo)::text)))))::text AS cargahoraria, (t3.titulo)::text AS tipocurso, ((SELECT count(t5.codigocurso) AS count FROM dbturmas t5 WHERE ((t5.codigocurso)::text = (t0.codigo)::text)))::text AS turmas, (t0.codigograde)::text AS codigograde FROM (((dbcursos t0 LEFT JOIN dbcursos_areas t2 ON (((t2.codigo)::text = (t0.codigoareacurso)::text))) LEFT JOIN dbcursos_tipos t3 ON (((t3.codigo)::text = (t0.codigotipocurso)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t0.ativo)::text)));


--
-- Name: view_cursos_areas; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_cursos_areas AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.titulo)::text AS titulo, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbcursos_areas t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- Name: view_cursos_ativos; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_cursos_ativos AS
    SELECT t4.id, (t4.codigo)::text AS codigo, (t4.unidade)::text AS unidade, (t4.codigoautor)::text AS codigoautor, (t4.titulo)::text AS titulo, (t4.codigocurso)::text AS codigocurso, t4.obs, to_char((t4.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t0.nome)::text AS nome, (t0.codigotipocurso)::text AS codigotipocurso, (t0.codigoareacurso)::text AS codigoareacurso, t0.objetivocurso, t0.publicoalvo, (t0.cargahortotal)::text AS cargahortotal, (t2.titulo)::text AS areacurso, (t3.titulo)::text AS tipocurso FROM ((((dbcursos_ativos t4 LEFT JOIN dbcursos t0 ON (((t0.codigo)::text = (t4.codigocurso)::text))) LEFT JOIN dbcursos_areas t2 ON (((t2.codigo)::text = (t0.codigoareacurso)::text))) LEFT JOIN dbcursos_tipos t3 ON (((t3.codigo)::text = (t0.codigotipocurso)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t4.ativo)::text)));


--
-- Name: view_cursos_disciplinas; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_cursos_disciplinas AS
    SELECT t0.id, (t0.codigo)::text AS codigo, (t0.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, (t0.codigocurso)::text AS codigocurso, (t0.codigodisciplina)::text AS codigodisciplina, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t2.nome)::text AS nomecurso, (t3.titulo)::text AS nomedisciplina, (t3.cargahoraria)::text AS cargahoraria FROM (((dbcursos_disciplinas t0 LEFT JOIN dbcursos t2 ON (((t2.codigo)::text = (t0.codigocurso)::text))) LEFT JOIN dbdisciplinas t3 ON (((t3.codigo)::text = (t0.codigodisciplina)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t0.ativo)::text)));


--
-- Name: view_cursos_tipos; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_cursos_tipos AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.titulo)::text AS titulo, t1.obs, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbcursos_tipos t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- Name: view_departamentos; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_departamentos AS
    SELECT t0.id, (t0.codigo)::text AS codigo, (t0.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, (t0.label)::text AS label, (t0.codigoresponsavel)::text AS codigoresponsavel, (t0.codigosala)::text AS codigosala, t0.obs, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t2.nome_razaosocial)::text AS nomeresponsavel, (t3.nome)::text AS nomesala FROM (((dbdepartamentos t0 LEFT JOIN dbpessoas t2 ON (((t2.codigo)::text = (t0.codigoresponsavel)::text))) LEFT JOIN dbsalas t3 ON (((t3.codigo)::text = (t0.codigosala)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t0.ativo)::text)));


--
-- Name: view_disciplinas; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_disciplinas AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.titulo)::text AS titulo, t1.ementa, t1.programa, t1.competencias, (t1.cargahoraria)::text AS cargahoraria, t1.biografia, t1.metodologia, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbdisciplinas t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- Name: view_disciplinas_semelhantes; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_disciplinas_semelhantes AS
    SELECT t0.id, (t0.codigo)::text AS codigo, (t0.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, (t0.codigodisciplina)::text AS codigodisciplina, (t0.codigodisciplinasemelhante)::text AS codigodisciplinasemelhante, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t3.titulo)::text AS nomedisciplina, (t3.cargahoraria)::text AS cargahoraria, (t4.titulo)::text AS nomedisciplinasemelhante, (t4.cargahoraria)::text AS cargahorariasemelhante FROM (((dbdisciplinas_semelhantes t0 LEFT JOIN dbdisciplinas t3 ON (((t3.codigo)::text = (t0.codigodisciplina)::text))) LEFT JOIN dbdisciplinas t4 ON (((t3.codigo)::text = (t0.codigodisciplinasemelhante)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t0.ativo)::text)));


--
-- Name: view_funcionarios_ferias; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_funcionarios_ferias AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigofuncionario)::text AS codigofuncionario, (t1.dataferiasprevisao)::text AS dataferiasprevisao, (t1.diasferiasprevisao)::text AS diasferiasprevisao, (t1.retornoferiasprevisao)::text AS retornoferiasprevisao, (t1.dataferiasreal)::text AS dataferiasreal, (t1.diasferiasreal)::text AS diasferiasreal, (t1.retornoferiasreal)::text AS retornoferiasreal, (t1.datalimite)::text AS datalimite, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbfuncionarios_ferias t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- Name: view_funcionarios_folhapagamento; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_funcionarios_folhapagamento AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigofuncionario)::text AS codigofuncionario, (t1.nomecargo)::text AS nomecargo, (t1.codcontadebito)::text AS codcontadebito, (t1.referencia)::text AS referencia, (t1.salariobase)::text AS salariobase, (t1.comissao)::text AS comissao, (t1.salariofamilia)::text AS salariofamilia, (t1.adpericulosidade)::text AS adpericulosidade, (t1.adsalubridade)::text AS adsalubridade, (t1.horaextra)::text AS horaextra, (t1.ferias)::text AS ferias, (t1.decimoterceiro)::text AS decimoterceiro, (t1.licensamaternidade)::text AS licensamaternidade, (t1.licensapaternidade)::text AS licensapaternidade, (t1.licensacasamento)::text AS licensacasamento, (t1.licensaobito)::text AS licensaobito, (t1.licensainvalidez)::text AS licensainvalidez, (t1.valetransporte)::text AS valetransporte, (t1.irpf)::text AS irpf, (t1.inss)::text AS inss, (t1.contrsindical)::text AS contrsindical, (t1.totalbruto)::text AS totalbruto, (t1.totalliquido)::text AS totalliquido, (t1.diastrabalhados)::text AS diastrabalhados, (t1.vencimento)::text AS vencimento, (t1.datapag)::text AS datapag, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbfuncionarios_folhapagamento t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- Name: view_funcionarios_ocorrencias; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_funcionarios_ocorrencias AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigofuncionario)::text AS codigofuncionario, (t1.titulo)::text AS titulo, t1.descricao, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbfuncionarios_ocorrencias t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- Name: view_funcionarios_professores; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_funcionarios_professores AS
    SELECT t0.id, (t0.codigo)::text AS codigo, (t0.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, (t0.codigofuncionario)::text AS codigofuncionario, t0.curriculo, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t3.nome_razaosocial)::text AS nomeprofessor, (t3.codigo)::text AS codigopessoa, ((SELECT t4.titularidade FROM dbpessoas_titularidades t4 WHERE ((t4.peso)::text = (SELECT max((t6.peso)::text) AS max FROM dbpessoas_titularidades t6 WHERE ((t6.codigo)::text IN (SELECT t5.codigotitularidade FROM dbpessoas_formacoes t5 WHERE ((t5.codigopessoa)::text = (t2.codigopessoa)::text)))))))::text AS titularidade, ((SELECT t4.nomeacao FROM dbpessoas_titularidades t4 WHERE ((t4.peso)::text = (SELECT max((t6.peso)::text) AS max FROM dbpessoas_titularidades t6 WHERE ((t6.codigo)::text IN (SELECT t5.codigotitularidade FROM dbpessoas_formacoes t5 WHERE ((t5.codigopessoa)::text = (t2.codigopessoa)::text)))))))::text AS nomeacao FROM (((dbfuncionarios_professores t0 LEFT JOIN dbpessoas_funcionarios t2 ON (((t2.codigo)::text = (t0.codigofuncionario)::text))) LEFT JOIN dbpessoas t3 ON (((t3.codigo)::text = (t2.codigopessoa)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t0.ativo)::text)));


--
-- Name: view_funcionarios_treinamentos; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_funcionarios_treinamentos AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigotreinamento)::text AS codigotreinamento, (t1.codigofuncionario)::text AS codigofuncionario, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbfuncionarios_treinamentos t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- Name: view_patrimonios; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_patrimonios AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigofuncionario)::text AS codigofuncionario, (t1.codigoproduto)::text AS codigoproduto, (t1.modelo)::text AS modelo, (t1.marca)::text AS marca, (t1.label)::text AS label, (t1.descricao)::text AS descricao, (t1.tipo)::text AS tipo, (t1.datafabricacao)::text AS datafabricacao, (t1.dataaquisicao)::text AS dataaquisicao, (t1.valornominal)::text AS valornominal, (t1.lotacao)::text AS lotacao, (t1.valorcompra)::text AS valorcompra, (t1.numnf)::text AS numnf, (t1.dataverificacao)::text AS dataverificacao, (t1.foto)::text AS foto, t1.obs, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t2.nomeunidade)::text AS nomeunidade, (t3.nome)::text AS nomesala FROM (((dbpatrimonios t1 LEFT JOIN dbunidades t2 ON (((t2.codigo)::text = (t1.unidade)::text))) LEFT JOIN dbsalas t3 ON (((t3.codigo)::text = (t1.lotacao)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- Name: view_patrimonios_livros; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_patrimonios_livros AS
    SELECT t0.id, (t0.codigo)::text AS codigolivro, (t0.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, (t0.codigopatrimonio)::text AS codigopatrimonio, (t0.codigopatrimonio)::text AS codigo, (t0.autor)::text AS autor, t0.outrosautores, (t0.ano)::text AS ano, (t0.isbn)::text AS isbn, (t0.idioma)::text AS idioma, (t0.paginas)::text AS paginas, (t1.modelo)::text AS edicao, (t1.marca)::text AS editora, (t1.label)::text AS titulo, (t2.cdu)::text AS cdu, (t2.titulo)::text AS titulocdu, (t0.codigopha)::text AS codigopha, (t0.codigocdu)::text AS codigocdu, (t0.tradutor)::text AS tradutor, t0.sinopse, (t0.volume)::text AS volume, t0.sumario, (t1.foto)::text AS foto, ((SELECT count(t3.codigo) AS count FROM dbpessoas_livros t3 WHERE (((t3.codigolivro)::text = (t0.codigo)::text) AND ((t3.situacao)::text = '3'::text))))::text AS locacoes, ((SELECT count(t3.codigo) AS count FROM dbpessoas_livros t3 WHERE (((t3.codigolivro)::text = (t0.codigo)::text) AND ((t3.situacao)::text = '2'::text))))::text AS reservas, ((SELECT t3.codigopessoa FROM dbpessoas_livros t3 WHERE (((t3.codigolivro)::text = (t0.codigo)::text) AND ((t3.situacao)::text = '1'::text))))::text AS codigolocador, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t0.exemplar)::text AS exemplar FROM (((dbpatrimonios_livros t0 LEFT JOIN dbpatrimonios t1 ON (((t1.codigo)::text = (t0.codigopatrimonio)::text))) LEFT JOIN dbbiblioteca_cdu t2 ON (((t2.codigo)::text = (t0.codigocdu)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- Name: view_pessoas; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_pessoas AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.tipo)::text AS tipo, (t1.nome_razaosocial)::text AS nome_razaosocial, (t1.cpf_cnpj)::text AS cpf_cnpj, (t1.rg_inscest)::text AS rg_inscest, (t1.titeleitor_inscmun)::text AS titeleitor_inscmun, t1.logradouro, (t1.bairro)::text AS bairro, (t1.cidade)::text AS cidade, (t1.estado)::text AS estado, (t1.cep)::text AS cep, (t1.caixapostal)::text AS caixapostal, (t1.referencia)::text AS referencia, (t1.tel1)::text AS tel1, (t1.tel2)::text AS tel2, (t1.cel1)::text AS cel1, (t1.cel2)::text AS cel2, (t1.email1)::text AS email1, (t1.email2)::text AS email2, (t1.site)::text AS site, (t1.opcobranca)::text AS opcobranca, (t1.cliente)::text AS cliente, (t1.fornecedor)::text AS fornecedor, (t1.funcionario)::text AS funcionario, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbpessoas t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- Name: view_pessoas_alunos; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_pessoas_alunos AS
    SELECT t0.id, (t0.codigo)::text AS codigo, (t0.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, (t0.codigopessoa)::text AS codigopessoa, (t0.codigotransacao)::text AS codigotransacao, (t0.codigoturma)::text AS codigoturma, (t0.codigocurso)::text AS codigocurso, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t2.titulo)::text AS nometurma, (t3.nomeunidade)::text AS nomeunidade, (t6.nome_razaosocial)::text AS nomepessoa, (t4.nome)::text AS nomecurso FROM (((((dbpessoas_alunos t0 LEFT JOIN dbturmas t2 ON (((t2.codigo)::text = (t0.codigoturma)::text))) LEFT JOIN dbunidades t3 ON (((t3.codigo)::text = (t0.unidade)::text))) LEFT JOIN dbcursos t4 ON (((t4.codigo)::text = ((SELECT t5.codigocurso FROM dbturmas t5 WHERE ((t5.codigo)::text = (t0.codigoturma)::text)))::text))) LEFT JOIN dbpessoas t6 ON (((t6.codigo)::text = (t0.codigopessoa)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t0.ativo)::text)));


--
-- Name: view_pessoas_complemento_pf; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_pessoas_complemento_pf AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigopessoa)::text AS codigopessoa, (t1.estadocivil)::text AS estadocivil, (t1.etinia)::text AS etinia, (t1.datanasc)::text AS datanasc, (t1.sexo)::text AS sexo, (t1.tiposanguineo)::text AS tiposanguineo, (t1.nacionalidade)::text AS nacionalidade, (t1.portadornecessidades)::text AS portadornecessidades, t1.necessidadesespeciais, (t1.numerodependentes)::text AS numerodependentes, (t1.cnh)::text AS cnh, (t1.carteirareservista)::text AS carteirareservista, (t1.rendamensal)::text AS rendamensal, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbpessoas_complemento_pf t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- Name: view_pessoas_complemento_pj; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_pessoas_complemento_pj AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigopessoa)::text AS codigopessoa, (t1.datafundacao)::text AS datafundacao, (t1.gerente)::text AS gerente, (t1.diretor)::text AS diretor, (t1.representante)::text AS representante, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbpessoas_complemento_pj t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- Name: view_pessoas_convenios; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_pessoas_convenios AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, (t1.codigopessoa)::text AS codigopessoa, (t1.codigoconvenio)::text AS codigoconvenio, (t0.titulo)::text AS titulo, t0.descricao, (t0.tipoconvenio)::text AS tipoconvenio, (t0.tipotransacao)::text AS tipotransacao, (t0.valor)::text AS valor, (t0.formato)::text AS formato, (t0.datavigencia)::text AS datavirgencia, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM ((dbpessoas_convenios t1 LEFT JOIN dbconvenios t0 ON (((t1.codigoconvenio)::text = (t0.codigo)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- Name: view_pessoas_demandas; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_pessoas_demandas AS
    SELECT t0.id, (t0.codigo)::text AS codigo, (t0.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, (t0.codigopessoa)::text AS codigopessoa, (t0.codigocurso)::text AS codigocurso, (t0.turno)::text AS turno, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t3.nome)::text AS nomecurso, (t2.nome_razaosocial)::text AS nomepessoa, (t2.tel1)::text AS tel1, (t2.cel1)::text AS cel1, (t2.email1)::text AS email1 FROM (((dbpessoas_demandas t0 LEFT JOIN dbpessoas t2 ON (((t2.codigo)::text = (t0.codigopessoa)::text))) LEFT JOIN dbcursos t3 ON (((t3.codigo)::text = (t0.codigocurso)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t0.ativo)::text)));


--
-- Name: view_pessoas_enderecoscobrancas; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_pessoas_enderecoscobrancas AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigopessoa)::text AS codigopessoa, (t1.nomecobranca)::text AS nomecobranca, (t1.cpf_cnpjcobranca)::text AS cpf_cnpjcobranca, (t1.logradourocobranca)::text AS logradourocobranca, (t1.cidadecobranca)::text AS cidadecobranca, (t1.estadocobranca)::text AS estadocobranca, (t1.cepcobranca)::text AS cepcobranca, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbpessoas_enderecoscobrancas t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- Name: view_pessoas_formacoes; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_pessoas_formacoes AS
    SELECT t0.id, (t0.codigo)::text AS codigo, (t0.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, (t0.codigopessoa)::text AS codigopessoa, (t0.codigotitularidade)::text AS codigotitularidade, (t0.curso)::text AS curso, (t0.instituicao)::text AS instituicao, (t0.anoconclusao)::text AS anoconclusao, t0.observacao, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t3.nome_razaosocial)::text AS nomepessoa, (t2.titularidade)::text AS titularidade, (t2.nomeacao)::text AS nomeacao, (t2.peso)::text AS peso FROM (((dbpessoas_formacoes t0 LEFT JOIN dbpessoas_titularidades t2 ON (((t2.codigo)::text = (t0.codigotitularidade)::text))) LEFT JOIN dbpessoas t3 ON (((t3.codigo)::text = (t0.codigopessoa)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t0.ativo)::text)));


--
-- Name: view_pessoas_inscricoes; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_pessoas_inscricoes AS
    SELECT t0.id, (t0.codigo)::text AS codigo, (t0.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, (t0.codigopessoa)::text AS codigopessoa, (t0.codigotransacao)::text AS codigotransacao, (t0.opcobranca)::text AS opcobranca, (t0.codigoturma)::text AS codigoturma, (t0.codigocurso)::text AS codigocurso, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t2.nome_razaosocial)::text AS nomepessoa, (t2.cpf_cnpj)::text AS cpf_cnpj, (t2.tel1)::text AS telefone, (t2.email1)::text AS email, (t3.titulo)::text AS nometurma, (t3.datainicio)::text AS datainicio, (t3.valortaxa)::text AS valortaxa, (t3.numparcelas)::text AS numparcelas, (t3.valormensal)::text AS valormatricula, (t3.valormensal)::text AS valorparcelas, (t3.valordescontado)::text AS valordescontado, (t4.nome)::text AS nomecurso FROM ((((dbpessoas_inscricoes t0 LEFT JOIN dbpessoas t2 ON (((t2.codigo)::text = (t0.codigopessoa)::text))) LEFT JOIN dbturmas t3 ON (((t3.codigo)::text = (t0.codigoturma)::text))) LEFT JOIN dbcursos t4 ON (((t4.codigo)::text = (t0.codigocurso)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t0.ativo)::text)));


--
-- Name: view_pessoas_livros; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_pessoas_livros AS
    SELECT t0.id, (t0.codigo)::text AS codigo, (t0.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, (t0.codigopessoa)::text AS codigopessoa, (t0.codigolivro)::text AS codigolivro, (t0.previsaosaida)::text AS previsaosaida, (t0.previsaoentrada)::text AS previsaoentrada, (t0.confirmacaosaida)::text AS confirmacaosaida, (t0.confirmacaoentrada)::text AS confirmacaoentrada, (t0.situacao)::text AS situacao, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t1.nome_razaosocial)::text AS nomepessoa, (t3.label)::text AS titulolivro, (t2.autor)::text AS autorlivro, (t3.codigo)::text AS codigopatrimonio FROM ((((dbpessoas_livros t0 LEFT JOIN dbpessoas t1 ON (((t1.codigo)::text = (t0.codigopessoa)::text))) LEFT JOIN dbpatrimonios_livros t2 ON (((t2.codigo)::text = (t0.codigolivro)::text))) LEFT JOIN dbpatrimonios t3 ON (((t3.codigo)::text = (t2.codigopatrimonio)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- Name: view_pessoas_solicitacoes; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_pessoas_solicitacoes AS
    SELECT t0.id, (t0.codigo)::text AS codigo, (t0.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, (t0.codigopessoa)::text AS codigopessoa, (t0.solicitacao)::text AS solicitacao, (t0.data)::text AS data, t0.justificativa, t0.atendimento, (t0.codigofuncionario)::text AS codigofuncionario, (t0.codigodepartamento)::text AS codigodepartamento, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t0.status)::text AS status, (t2.nome_razaosocial)::text AS nomepessoa, (t3.nome_razaosocial)::text AS nomefuncionario, (t4.label)::text AS nomedepartamento FROM ((((dbpessoas_solicitacoes t0 LEFT JOIN dbpessoas t2 ON (((t2.codigo)::text = (t0.codigopessoa)::text))) LEFT JOIN dbpessoas t3 ON (((t3.codigo)::text = ((SELECT t5.codigopessoa FROM dbpessoas_funcionarios t5 WHERE ((t5.codigo)::text = (t0.codigofuncionario)::text)))::text))) LEFT JOIN dbdepartamentos t4 ON (((t4.codigo)::text = (t0.codigodepartamento)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t0.ativo)::text)));


--
-- Name: view_plano_contas; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_plano_contas AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.nomeconta)::text AS nomeconta, (t1.tipoconta)::text AS tipoconta, (t1.categoria)::text AS categoria, (t1.tipocusto)::text AS tipocusto, t1.obs, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbplano_contas t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- Name: view_produtos; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_produtos AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.label)::text AS label, t1.descricao, (t1.valor)::text AS valor, (t1.valoralteravel)::text AS valoralteravel, (t1.tabela)::text AS tabela, t1.obs, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t1.codigotipoproduto)::text AS codigotipoproduto, (t2.titulo)::text AS tipoproduto FROM ((dbprodutos t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text))) LEFT JOIN dbprodutos_tipos t2 ON (((t2.codigo)::text = (t1.codigotipoproduto)::text)));


--
-- Name: view_produtos_caracteristicas; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_produtos_caracteristicas AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigoproduto)::text AS codigoproduto, t1.beneficios, t1.limitacoes, t1.mododeuso, (t1.unid)::text AS unid, (t1.qtde)::text AS qtde, (t1.cor)::text AS cor, (t1.tamanho)::text AS tamanho, (t1.peso)::text AS peso, (t1.altura)::text AS altura, (t1.largura)::text AS largura, (t1.comprimento)::text AS comprimento, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbprodutos_caracteristicas t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- Name: view_produtos_parametros; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_produtos_parametros AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigoproduto)::text AS codigoproduto, (t1.tabela)::text AS tabela, (t1.collabel)::text AS collabel, (t1.colvalor)::text AS colvalor, (t1.coldesc)::text AS coldesc, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t1.codigotipoproduto)::text AS codigotipoproduto, (t2.titulo)::text AS tipoproduto FROM ((dbprodutos_parametros t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text))) LEFT JOIN dbprodutos_tipos t2 ON (((t2.codigo)::text = (t1.codigotipoproduto)::text)));


--
-- Name: view_produtos_turmas; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_produtos_turmas AS
    SELECT t0.id, (t0.codigo)::text AS codigo, (t0.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, (t0.label)::text AS label, t0.descricao, (t0.valor)::text AS valor, (t0.valoralteravel)::text AS valoralteravel, (t0.tabela)::text AS tabela, t0.obs, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t3.nome)::text AS nomecurso, (t2.titulo)::text AS nometurma, (t2.codigoplanoconta)::text AS codigoplanoconta, (t2.datainicio)::text AS datainicio, (t2.datafim)::text AS datafim, (t2.frequenciaaula)::text AS frequenciaaula, (t2.horainicio)::text AS horainicio, (t2.horafim)::text AS horafim, (t2.diasaula)::text AS diasaula, (t2.localaulas)::text AS localaulas, (t2.valortotal)::text AS valortotal, (t2.valortaxa)::text AS valortaxa, (t2.valormatricula)::text AS valormatricula, (t2.valormensal)::text AS valormensal, (t2.valordescontado)::text AS valordescontado, (t2.numparcelas)::text AS numparcelas, (t2.datavencimento)::text AS datavencimento, (t0.codigotipoproduto)::text AS codigotipoproduto, (t5.titulo)::text AS tipoproduto FROM ((((dbprodutos t0 LEFT JOIN dbturmas t2 ON (((t2.codigoproduto)::text = (t0.codigo)::text))) LEFT JOIN dbcursos t3 ON (((t3.codigo)::text = (t2.codigocurso)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t0.ativo)::text))) LEFT JOIN dbprodutos_tipos t5 ON (((t5.codigo)::text = (t0.codigotipoproduto)::text))) WHERE ((t0.tabela)::text = 'dbturma'::text);


--
-- Name: view_professores_areas; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_professores_areas AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigoprofessor)::text AS codigoprofessor, (t1.codigoareacurso)::text AS codigoareacurso, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t2.titulo)::text AS nomeareacurso FROM ((dbprofessores_areas t1 LEFT JOIN dbcursos_areas t2 ON (((t2.codigo)::text = (t1.codigoareacurso)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- Name: view_projetos; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_projetos AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigoproduto)::text AS codigoproduto, (t1.titulo)::text AS titulo, (t1.responsavelnome)::text AS responsavelnome, (t1.responsavelfuncao)::text AS responsavelfuncao, t1.objetivo, (t1.prazo)::text AS prazo, t1.resumo, t1.descrisco, t1.medidasrisco, t1.descresultado, (t1.receitapropria)::text AS receitapropria, (t1.receitaclientes)::text AS receitaclientes, (t1.receitaparceiros)::text AS receitaparceiros, (t1.receitafornecedores)::text AS receitafornecedores, (t1.receitatotal)::text AS receitatotal, (t1.recursostotal)::text AS recursostotal, (t1.custostotal)::text AS custostotal, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbprojetos t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- Name: view_projetos_colaboradores; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_projetos_colaboradores AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigoprojeto)::text AS codigoprojeto, (t1.codigopessoa)::text AS codigopessoa, (t1.funcao)::text AS funcao, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbprojetos_colaboradores t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- Name: view_projetos_custos; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_projetos_custos AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigoprojeto)::text AS codigoprojeto, (t1.item)::text AS item, (t1.valor)::text AS valor, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbprojetos_custos t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- Name: view_projetos_recursos; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_projetos_recursos AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigoprojeto)::text AS codigoprojeto, (t1.recurso)::text AS recurso, (t1.quantidade)::text AS quantidade, (t1.tempo)::text AS tempo, (t1.tipouso)::text AS tipouso, (t1.custounitario)::text AS custounitario, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbprojetos_recursos t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- Name: view_questionarios; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_questionarios AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.titulo)::text AS titulo, (t1.datainicio)::text AS datainicio, (t1.datafim)::text AS datafim, (t1.numquestoes)::text AS numquestoes, (t1.numquestoesmax)::text AS numquestoesmax, (t1.numtentativas)::text AS numtentativas, t1.obs, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbquestionarios t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- Name: view_questoes; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_questoes AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigoquestionario)::text AS codigoquestionario, t1.enunciado, (t1.tipoquestao)::text AS tipoquestao, (t1.valorquestao)::text AS valorquestao, t1.obs, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbquestoes t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- Name: view_questoes_itens; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_questoes_itens AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigoquestao)::text AS codigoquestao, t1.enunciado, (t1.valoritem)::text AS valoritem, t1.obs, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbquestoes_itens t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- Name: view_recados; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_recados AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.nomepessoa)::text AS nomepessoa, (t1.referencia)::text AS referencia, (t1.interessado)::text AS interessado, t1.obs, (t1.tel1)::text AS tel1, (t1.tel2)::text AS tel2, (t1.email)::text AS email, (t1.situacao)::text AS situacao, to_char((t1.retorno)::timestamp with time zone, 'DD/MM/YYYY'::text) AS retorno, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbrecados t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- Name: view_salas; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_salas AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.nome)::text AS nome, t1.endereco, t1.descricao, (t1.salaaula)::text AS salaaula, (t1.codigofuncionario)::text AS codigofuncionario, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t3.nome_razaosocial)::text AS nomefuncionario, (t2.nomeunidade)::text AS nomeunidade FROM (((dbsalas t1 LEFT JOIN dbunidades t2 ON (((t2.codigo)::text = (t1.unidade)::text))) LEFT JOIN dbpessoas t3 ON (((t3.codigo)::text = ((SELECT t4.codigopessoa FROM dbpessoas_funcionarios t4 WHERE ((t4.codigo)::text = (t1.codigofuncionario)::text)))::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- Name: view_scorecard; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_scorecard AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.titulo)::text AS titulo, (t1.meta)::text AS meta, (t1.pareto)::text AS pareto, (t1.codigomodulo)::text AS codigomodulo, (t1.agrupamentoperiodico)::text AS agrupamentoperiodico, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbscorecard t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- Name: view_scorecard_sentencas; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_scorecard_sentencas AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigoscorecard)::text AS codigoscorecard, (t1.tabela)::text AS tabela, (t1.colunax)::text AS colunax, (t1.agrupamentox)::text AS agrupamentox, (t1.colunay)::text AS colunay, (t1.agrupamentoy)::text AS agrupamentoy, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbscorecard_sentencas t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- Name: view_transacoes; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_transacoes AS
    SELECT t0.id, (t0.codigo)::text AS codigo, (t0.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, (t0.codigopessoa)::text AS codigopessoa, (t0.tipomovimentacao)::text AS tipomovimentacao, (t0.valortotal)::text AS valortotal, (t0.desconto)::text AS desconto, (t0.acrescimo)::text AS acrescimo, (t0.valorcorrigido)::text AS valorcorrigido, (t0.formapag)::text AS formapag, (t0.codigoplanoconta)::text AS codigoplanoconta, (t0.numparcelas)::text AS numparcelas, (t0.intervaloparcelas)::text AS intervaloparcelas, (t0.datafixavencimento)::text AS datafixavencimento, (t0.vencimento)::text AS vencimento, (t0.efetivada)::text AS efetivada, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t2.nome_razaosocial)::text AS cliente, (t3.nomeconta)::text AS planoconta, ((SELECT count(dbtransacoes_contas.codigo) AS count FROM dbtransacoes_contas WHERE (((dbtransacoes_contas.codigotransacao)::text = (t0.codigo)::text) AND (dbtransacoes_contas.statusconta = 2))))::text AS numparcelaspagas, ((SELECT sum(dbtransacoes_contas.valorreal) AS sum FROM dbtransacoes_contas WHERE (((dbtransacoes_contas.codigotransacao)::text = (t0.codigo)::text) AND (dbtransacoes_contas.statusconta = 1))))::text AS valorreal, ((SELECT count(dbtransacoes_contas.codigo) AS count FROM dbtransacoes_contas WHERE (((dbtransacoes_contas.codigotransacao)::text = (t0.codigo)::text) AND (dbtransacoes_contas.statusconta = 1))))::text AS numparcelasabertas FROM (((dbtransacoes t0 LEFT JOIN dbpessoas t2 ON (((t2.codigo)::text = (t0.codigopessoa)::text))) LEFT JOIN dbplano_contas t3 ON (((t3.codigo)::text = (t0.codigoplanoconta)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t0.ativo)::text)));


--
-- Name: view_transacoes_contas; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_transacoes_contas AS
    SELECT t0.id, (t0.codigo)::text AS codigo, (t0.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, (t0.codigotransacao)::text AS codigotransacao, (t0.codigopessoa)::text AS codigopessoa, (t0.codigoplanoconta)::text AS codigoplanoconta, (t0.tipomovimentacao)::text AS tipomovimentacao, (t0.valornominal)::text AS valornominal, (t0.valorreal)::text AS valorreal, (t0.numparcela)::text AS numparcela, (t0.desconto)::text AS desconto, to_char((t0.vencimento)::timestamp with time zone, 'DD/MM/YYYY'::text) AS vencimento, t0.obs, (t0.statusconta)::text AS statusconta, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t2.nome_razaosocial)::text AS nomepessoa, (t3.nomeconta)::text AS nomeplanoconta, t0.instrucoespagamento, ((SELECT sum(t4.valorpago) AS sum FROM dbcaixa t4 WHERE ((t4.codigoconta)::text = (t0.codigo)::text)))::text AS valorpago, (t4.codigocontacaixa)::text AS codigocontacaixa, (t4.numdoc)::text AS numdoc, (t4.datadocumento)::text AS datadocumento, (t4.tipoduplicata)::text AS tipoduplicata, (t4.valorreal)::text AS valorrealmovimento, (t4.formadesconto)::text AS formadesconto, (t4.desconto)::text AS descontomovimento, (t4.multaacrecimo)::text AS multaacrecimo, (t4.valorpago)::text AS valorpagomovimento, (t4.valorentrada)::text AS valorentrada, (t4.codigofuncionario)::text AS codigofuncionario, to_char((t4.datapag)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datapag, (t4.formapag)::text AS formapag, (t4.mora)::text AS mora, t4.obs AS obsmovimento, (t4.statusmovimento)::text AS statusmovimento, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, to_char((t4.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datamovimentacao FROM ((((dbtransacoes_contas t0 LEFT JOIN dbpessoas t2 ON (((t2.codigo)::text = (t0.codigopessoa)::text))) LEFT JOIN dbplano_contas t3 ON (((t3.codigo)::text = (t0.codigoplanoconta)::text))) LEFT JOIN dbcaixa t4 ON (((t4.codigoconta)::text = (t0.codigo)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t0.ativo)::text)));


--
-- Name: view_transacoes_contas_duplicatas; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_transacoes_contas_duplicatas AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigoconta)::text AS codigoconta, (t1.codigopessoa)::text AS codigopessoa, (t1.ndocumento)::text AS ndocumento, (t1.dataprocesso)::text AS dataprocesso, (t1.cpfsacado)::text AS cpfsacado, (t1.valordoc)::text AS valordoc, (t1.vencimento)::text AS vencimento, (t1.databaixa)::text AS databaixa, (t1.statusduplicata)::text AS statusduplicata, (t1.tipoduplicata)::text AS tipoduplicata, (t1.classificacao)::text AS classificacao, t1.bkp, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbtransacoes_contas_duplicatas t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- Name: view_transacoes_convenios; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_transacoes_convenios AS
    SELECT t0.id, (t0.codigo)::text AS codigo, (t0.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, (t0.codigotransacao)::text AS codigotransacao, (t0.codigoconvenio)::text AS codigoconvenio, (t2.titulo)::text AS nomeconvenio, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM ((dbtransacoes_convenios t0 LEFT JOIN dbconvenios t2 ON (((t2.codigo)::text = (t0.codigoconvenio)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t0.ativo)::text)));


--
-- Name: view_transacoes_produtos; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_transacoes_produtos AS
    SELECT t0.id, (t0.codigo)::text AS codigo, (t0.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, (t0.codigotransacao)::text AS codigotransacao, (t0.codigoproduto)::text AS codigoproduto, (t0.tabelaproduto)::text AS tabelaproduto, (t0.valornominal)::text AS valornominal, ((t0.valornominal * (t0.quantidade)::double precision))::text AS valortotal, (t0.quantidade)::text AS quantidade, t0.obs, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, t2.descricao, (t2.label)::text AS label FROM ((dbtransacoes_produtos t0 LEFT JOIN dbprodutos t2 ON (((t2.codigo)::text = (t0.codigoproduto)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t0.ativo)::text)));


--
-- Name: view_treinamentos; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_treinamentos AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.nomecurso)::text AS nomecurso, t1.ementa, (t1.cargahoraria)::text AS cargahoraria, (t1.ministrante)::text AS ministrante, (t1.codigotitularidade)::text AS codigotitularidade, t1.curriculoministrante, (t1.instituicaocertificadora)::text AS instituicaocertificadora, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbtreinamentos t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- Name: view_turmas; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_turmas AS
    SELECT (t2.nome)::text AS nomecurso, t0.id, (t0.codigo)::text AS codigo, (t0.unidade)::text AS unidade, (t0.titulo)::text AS titulo, ((SELECT sum(t4.cargahoraria) AS sum FROM dbdisciplinas t4 WHERE ((t4.codigo)::text IN (SELECT t5.codigodisciplina FROM dbturmas_disciplinas t5 WHERE ((t5.codigoturma)::text = (t0.codigo)::text)))))::text AS cargahoraria, (t0.valortaxa)::text AS valortaxa, (t0.valormatricula)::text AS valormatricula, (t0.valormensal)::text AS valormensal, (t0.valordescontado)::text AS valordescontado, (t0.vagas)::text AS vagas, (t0.numparcelas)::text AS numparcelas, (t0.status)::text AS status, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t0.datainicio)::text AS datainicio, (t0.codigoproduto)::text AS codigoproduto, (t3.nomeunidade)::text AS nomeunidade, (t0.codigocurso)::text AS codigocurso, (t4.titulo)::text AS nomecursoativo, ((SELECT count(t5.codigoturma) AS count FROM dbpessoas_inscricoes t5 WHERE ((t5.codigoturma)::text = (t0.codigo)::text)))::text AS inscritos, ((SELECT count(t6.codigoturma) AS count FROM dbpessoas_alunos t6 WHERE ((t6.codigoturma)::text = (t0.codigo)::text)))::text AS matriculados, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t0.codigograde)::text AS codigograde FROM ((((dbturmas t0 LEFT JOIN dbcursos t2 ON (((t2.codigo)::text = (t0.codigocurso)::text))) LEFT JOIN dbcursos_ativos t4 ON (((t4.codigo)::text = (t0.codigocursoativo)::text))) LEFT JOIN dbunidades t3 ON (((t3.codigo)::text = (t0.unidade)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t0.ativo)::text)));


--
-- Name: view_turmas_convenios; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_turmas_convenios AS
    SELECT t0.id, (t0.codigo)::text AS codigo, (t0.unidade)::text AS unidade, (t0.codigoautor)::text AS codigoautor, (t0.codigoturma)::text AS codigoturma, (t0.codigoconvenio)::text AS codigoconvenio, (t2.titulo)::text AS nomeconvenio, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM ((dbturmas_convenios t0 LEFT JOIN dbconvenios t2 ON (((t2.codigo)::text = (t0.codigoconvenio)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t0.ativo)::text)));


--
-- Name: view_turmas_descontos; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_turmas_descontos AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigoturma)::text AS codigoturma, (t1.dialimite)::text AS dialimite, (t1.valordescontado)::text AS valordescontado, t1.obs, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, (t1.tipodesconto)::text AS tipodesconto FROM (dbturmas_descontos t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- Name: view_turmas_disciplinas_arquivos; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_turmas_disciplinas_arquivos AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.tipo)::text AS tipo, (t1.codigoturmadisciplina)::text AS codigoturmadisciplina, (t1.codigoprofessor)::text AS codigoprofessor, (t1.titulo)::text AS titulo, t1.obs, t1.arquivo, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbturmas_disciplinas_arquivos t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- Name: view_turmas_disciplinas_aulas; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_turmas_disciplinas_aulas AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigoturmadisciplina)::text AS codigoturmadisciplina, (t1.dataaula)::text AS dataaula, t1.conteudo, (t1.frequencia)::text AS frequencia, t1.obs, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbturmas_disciplinas_aulas t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- Name: view_turmas_disciplinas_avaliacoes; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_turmas_disciplinas_avaliacoes AS
    SELECT t2.id, (t2.codigo)::text AS codigo, (t2.unidade)::text AS unidade, (t2.codigoautor)::text AS codigoautor, (t2.avaliacao)::text AS avaliacao, (t2.peso)::text AS peso, (t2.ordem)::text AS ordem, (t2.codigoregra)::text AS codigoregra, t2.incontrol, (t2.referencia)::text AS referencia, t2.condicao, (t2.codigograde)::text AS codigograde, to_char((t2.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo, t1.codigoturma, t1.codigo AS codigoturmadisciplina FROM ((dbturmas_disciplinas t1 JOIN dbavaliacoes t2 ON (((t2.codigograde)::text = ((SELECT dbturmas.codigograde FROM dbturmas WHERE ((dbturmas.codigo)::text = (t1.codigoturma)::text)))::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t2.ativo)::text)));


--
-- Name: view_turmas_disciplinas_materiais; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_turmas_disciplinas_materiais AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigoturmadisciplina)::text AS codigoturmadisciplina, (t1.material)::text AS material, t1.descricao, (t1.custo)::text AS custo, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbturmas_disciplinas_materiais t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- Name: view_turmas_disciplinas_planoaulas; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_turmas_disciplinas_planoaulas AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigoturmadisciplina)::text AS codigoturmadisciplina, (t1.codigoprofessor)::text AS codigoprofessor, (t1.dataaula)::text AS dataaula, t1.conteudo, t1.recursos, t1.metodologia, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbturmas_disciplinas_planoaulas t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- Name: view_turmas_requisitos; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_turmas_requisitos AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.codigoturma)::text AS codigoturma, (t1.requisito)::text AS requisito, (t1.situacao)::text AS situacao, t1.obs, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbturmas_requisitos t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- Name: view_unidades; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_unidades AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.nomeunidade)::text AS nomeunidade, (t1.razaosocial)::text AS razaosocial, (t1.cnpj)::text AS cnpj, (t1.inscestadual)::text AS inscestadual, (t1.inscmunicipal)::text AS inscmunicipal, (t1.gerente)::text AS gerente, (t1.diretor)::text AS diretor, (t1.representante)::text AS representante, (t1.logradouro)::text AS logradouro, (t1.bairro)::text AS bairro, (t1.cidade)::text AS cidade, (t1.estado)::text AS estado, (t1.cep)::text AS cep, (t1.email)::text AS email, (t1.telefone)::text AS telefone, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM (dbunidades t1 LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


--
-- Name: view_usuarios; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_usuarios AS
    SELECT t1.id, (t1.codigo)::text AS codigo, (t1.unidade)::text AS unidade, (t1.codigoautor)::text AS codigoautor, (t1.classeuser)::text AS classeuser, (t1.codigopessoa)::text AS codigopessoa, (t2.nome_razaosocial)::text AS nomepessoa, (t1.usuario)::text AS usuario, (t1.senha)::text AS senha, (t1.entidadepai)::text AS entidadepai, (t1.codigotema)::text AS codigotema, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, (t999.id)::text AS ativo, (t999.situacao)::text AS ativotitulo FROM ((dbusuarios t1 LEFT JOIN dbpessoas t2 ON (((t2.codigo)::text = (t1.codigopessoa)::text))) LEFT JOIN dbstatus t999 ON (((t999.id)::text = (t1.ativo)::text)));


SET search_path = dominio, pg_catalog;

--
-- Name: id; Type: DEFAULT; Schema: dominio; Owner: -
--

ALTER TABLE dbceps ALTER COLUMN id SET DEFAULT nextval('dbceps_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: dominio; Owner: -
--

ALTER TABLE dbcidades ALTER COLUMN id SET DEFAULT nextval('dbcidades_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: dominio; Owner: -
--

ALTER TABLE dbestados ALTER COLUMN id SET DEFAULT nextval('dbestados_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: dominio; Owner: -
--

ALTER TABLE dbnfe_erros ALTER COLUMN id SET DEFAULT nextval('dbnfe_erros_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: dominio; Owner: -
--

ALTER TABLE dbpaises ALTER COLUMN id SET DEFAULT nextval('dbpaises_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: dominio; Owner: -
--

ALTER TABLE dbwebservices ALTER COLUMN id SET DEFAULT nextval('dbwebservices_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: dominio; Owner: -
--

ALTER TABLE dbwebservices_campos ALTER COLUMN id SET DEFAULT nextval('dbwebservices_campos_id_seq'::regclass);


SET search_path = public, pg_catalog;

--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE dbavaliacoes ALTER COLUMN id SET DEFAULT nextval('dbavaliacoes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE dbavaliacoes_regras ALTER COLUMN id SET DEFAULT nextval('dbavaliacoes_regras_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE dbconvenios_descontos ALTER COLUMN id SET DEFAULT nextval('dbconvenios_descontos_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE dbgrade_avaliacoes ALTER COLUMN id SET DEFAULT nextval('dbgrade_avaliacoes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE dbstatus ALTER COLUMN id SET DEFAULT nextval('dbstatus_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE dbtransacoes_contas_situacao ALTER COLUMN id SET DEFAULT nextval('dbtransacoes_contas_situacao_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE dbtransacoes_convenios ALTER COLUMN id SET DEFAULT nextval('dbtransacoes_convenios_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE dbturmas_convenios ALTER COLUMN id SET DEFAULT nextval('dbturmas_convenios_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE dbturmas_disciplinas_avaliacao_detalhamento ALTER COLUMN id SET DEFAULT nextval('dbturmas_disciplinas_avaliacao_detalhamento_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE dbusuarios_senhas_recuperacao ALTER COLUMN id SET DEFAULT nextval('dbusuarios_senhas_recuperacao_id_seq'::regclass);


SET search_path = dominio, pg_catalog;

--
-- Name: pk_dbceps; Type: CONSTRAINT; Schema: dominio; Owner: -
--

ALTER TABLE ONLY dbceps
    ADD CONSTRAINT pk_dbceps PRIMARY KEY (id);


--
-- Name: pk_dbcidades; Type: CONSTRAINT; Schema: dominio; Owner: -
--

ALTER TABLE ONLY dbcidades
    ADD CONSTRAINT pk_dbcidades PRIMARY KEY (id);


--
-- Name: pk_dbestados; Type: CONSTRAINT; Schema: dominio; Owner: -
--

ALTER TABLE ONLY dbestados
    ADD CONSTRAINT pk_dbestados PRIMARY KEY (id);


--
-- Name: pk_dbnfe_erros; Type: CONSTRAINT; Schema: dominio; Owner: -
--

ALTER TABLE ONLY dbnfe_erros
    ADD CONSTRAINT pk_dbnfe_erros PRIMARY KEY (id);


--
-- Name: pk_dbnfe_erros_grupos; Type: CONSTRAINT; Schema: dominio; Owner: -
--

ALTER TABLE ONLY dbnfe_erros_grupos
    ADD CONSTRAINT pk_dbnfe_erros_grupos PRIMARY KEY (id);


--
-- Name: pk_dbnfe_erros_mensagens; Type: CONSTRAINT; Schema: dominio; Owner: -
--

ALTER TABLE ONLY dbnfe_erros_mensagens
    ADD CONSTRAINT pk_dbnfe_erros_mensagens PRIMARY KEY (id);


--
-- Name: pk_dbpaises; Type: CONSTRAINT; Schema: dominio; Owner: -
--

ALTER TABLE ONLY dbpaises
    ADD CONSTRAINT pk_dbpaises PRIMARY KEY (id);


--
-- Name: pk_dbwebservices; Type: CONSTRAINT; Schema: dominio; Owner: -
--

ALTER TABLE ONLY dbwebservices
    ADD CONSTRAINT pk_dbwebservices PRIMARY KEY (id);


--
-- Name: pk_dbwebservices_campos; Type: CONSTRAINT; Schema: dominio; Owner: -
--

ALTER TABLE ONLY dbwebservices_campos
    ADD CONSTRAINT pk_dbwebservices_campos PRIMARY KEY (id);


SET search_path = public, pg_catalog;

--
-- Name: dbfuncionarios_professores_uk_codigofuncionario; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfuncionarios_professores
    ADD CONSTRAINT dbfuncionarios_professores_uk_codigofuncionario UNIQUE (codigofuncionario);


--
-- Name: dbusuarios_uk_usuario; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbusuarios
    ADD CONSTRAINT dbusuarios_uk_usuario UNIQUE (usuario);


--
-- Name: pk_dbalunos_disciplinas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_disciplinas
    ADD CONSTRAINT pk_dbalunos_disciplinas PRIMARY KEY (codigo);


--
-- Name: pk_dbalunos_disciplinas_aproveitamentos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_disciplinas_aproveitamentos
    ADD CONSTRAINT pk_dbalunos_disciplinas_aproveitamentos PRIMARY KEY (codigo);


--
-- Name: pk_dbalunos_faltas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_faltas
    ADD CONSTRAINT pk_dbalunos_faltas PRIMARY KEY (codigo);


--
-- Name: pk_dbalunos_notas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_notas
    ADD CONSTRAINT pk_dbalunos_notas PRIMARY KEY (codigo);


--
-- Name: pk_dbalunos_requisitos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_requisitos
    ADD CONSTRAINT pk_dbalunos_requisitos PRIMARY KEY (codigo);


--
-- Name: pk_dbalunos_solicitacoes; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_solicitacoes
    ADD CONSTRAINT pk_dbalunos_solicitacoes PRIMARY KEY (codigo);


--
-- Name: pk_dbalunos_transacoes; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_transacoes
    ADD CONSTRAINT pk_dbalunos_transacoes PRIMARY KEY (codigo);


--
-- Name: pk_dbavaliacoes; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbavaliacoes
    ADD CONSTRAINT pk_dbavaliacoes PRIMARY KEY (codigo);


--
-- Name: pk_dbavaliacoes_regras; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbavaliacoes_regras
    ADD CONSTRAINT pk_dbavaliacoes_regras PRIMARY KEY (codigo);


--
-- Name: pk_dbbalanco_patrimonial; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbbalanco_patrimonial
    ADD CONSTRAINT pk_dbbalanco_patrimonial PRIMARY KEY (codigo);


--
-- Name: pk_dbbiblioteca_cdu; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbbiblioteca_cdu
    ADD CONSTRAINT pk_dbbiblioteca_cdu PRIMARY KEY (codigo);


--
-- Name: pk_dbcaixa; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcaixa
    ADD CONSTRAINT pk_dbcaixa PRIMARY KEY (codigo);


--
-- Name: pk_dbcaixa_fechamentos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcaixa_fechamentos
    ADD CONSTRAINT pk_dbcaixa_fechamentos PRIMARY KEY (codigo);


--
-- Name: pk_dbcaixa_funcionarios; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcaixa_funcionarios
    ADD CONSTRAINT pk_dbcaixa_funcionarios PRIMARY KEY (codigo);


--
-- Name: pk_dbcargos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcargos
    ADD CONSTRAINT pk_dbcargos PRIMARY KEY (codigo);


--
-- Name: pk_dbcheques; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcontas_cheques
    ADD CONSTRAINT pk_dbcheques PRIMARY KEY (codigo);


--
-- Name: pk_dbcompras; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcompras
    ADD CONSTRAINT pk_dbcompras PRIMARY KEY (codigo);


--
-- Name: pk_dbcontas_caixa; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcontas_caixa
    ADD CONSTRAINT pk_dbcontas_caixa PRIMARY KEY (codigo);


--
-- Name: pk_dbcontas_caixa_historico; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcontas_caixa_historico
    ADD CONSTRAINT pk_dbcontas_caixa_historico PRIMARY KEY (codigo);


--
-- Name: pk_dbcontratos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcontratos
    ADD CONSTRAINT pk_dbcontratos PRIMARY KEY (codigo);


--
-- Name: pk_dbconvenios; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbconvenios
    ADD CONSTRAINT pk_dbconvenios PRIMARY KEY (codigo);


--
-- Name: pk_dbconvenios_descontos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbconvenios_descontos
    ADD CONSTRAINT pk_dbconvenios_descontos PRIMARY KEY (codigo);


--
-- Name: pk_dbcotacoes; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcotacoes
    ADD CONSTRAINT pk_dbcotacoes PRIMARY KEY (codigo);


--
-- Name: pk_dbcrm_demandas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcrm_demandas
    ADD CONSTRAINT pk_dbcrm_demandas PRIMARY KEY (codigo);


--
-- Name: pk_dbcurriculos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcurriculos
    ADD CONSTRAINT pk_dbcurriculos PRIMARY KEY (codigo);


--
-- Name: pk_dbcursos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcursos
    ADD CONSTRAINT pk_dbcursos PRIMARY KEY (codigo);


--
-- Name: pk_dbcursos_areas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcursos_areas
    ADD CONSTRAINT pk_dbcursos_areas PRIMARY KEY (codigo);


--
-- Name: pk_dbcursos_ativos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcursos_ativos
    ADD CONSTRAINT pk_dbcursos_ativos PRIMARY KEY (codigo);


--
-- Name: pk_dbcursos_avaliacoes; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcursos_avaliacoes
    ADD CONSTRAINT pk_dbcursos_avaliacoes PRIMARY KEY (codigo);


--
-- Name: pk_dbcursos_disciplinas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcursos_disciplinas
    ADD CONSTRAINT pk_dbcursos_disciplinas PRIMARY KEY (codigo);


--
-- Name: pk_dbcursos_tipos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcursos_tipos
    ADD CONSTRAINT pk_dbcursos_tipos PRIMARY KEY (codigo);


--
-- Name: pk_dbdados_boleto; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbdados_boleto
    ADD CONSTRAINT pk_dbdados_boleto PRIMARY KEY (codigo);


--
-- Name: pk_dbdepartamentos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbdepartamentos
    ADD CONSTRAINT pk_dbdepartamentos PRIMARY KEY (codigo);


--
-- Name: pk_dbdisciplinas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbdisciplinas
    ADD CONSTRAINT pk_dbdisciplinas PRIMARY KEY (codigo);


--
-- Name: pk_dbdisciplinas_semelhantes; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbdisciplinas_semelhantes
    ADD CONSTRAINT pk_dbdisciplinas_semelhantes PRIMARY KEY (codigo);


--
-- Name: pk_dbdocumentos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbdocumentos
    ADD CONSTRAINT pk_dbdocumentos PRIMARY KEY (codigo);


--
-- Name: pk_dbfuncionarios_ferias; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfuncionarios_ferias
    ADD CONSTRAINT pk_dbfuncionarios_ferias PRIMARY KEY (codigo);


--
-- Name: pk_dbfuncionarios_folhapagamento; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfuncionarios_folhapagamento
    ADD CONSTRAINT pk_dbfuncionarios_folhapagamento PRIMARY KEY (codigo);


--
-- Name: pk_dbfuncionarios_ocorrencias; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfuncionarios_ocorrencias
    ADD CONSTRAINT pk_dbfuncionarios_ocorrencias PRIMARY KEY (codigo);


--
-- Name: pk_dbfuncionarios_professores; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfuncionarios_professores
    ADD CONSTRAINT pk_dbfuncionarios_professores PRIMARY KEY (codigo);


--
-- Name: pk_dbfuncionarios_treinamentos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfuncionarios_treinamentos
    ADD CONSTRAINT pk_dbfuncionarios_treinamentos PRIMARY KEY (codigo);


--
-- Name: pk_dbgrade_avaliacoes; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbgrade_avaliacoes
    ADD CONSTRAINT pk_dbgrade_avaliacoes PRIMARY KEY (codigo);


--
-- Name: pk_dbpatrimonios; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpatrimonios
    ADD CONSTRAINT pk_dbpatrimonios PRIMARY KEY (codigo);


--
-- Name: pk_dbpatrimonios_livros; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpatrimonios_livros
    ADD CONSTRAINT pk_dbpatrimonios_livros PRIMARY KEY (codigo);


--
-- Name: pk_dbpessoas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas
    ADD CONSTRAINT pk_dbpessoas PRIMARY KEY (codigo);


--
-- Name: pk_dbpessoas_alunos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_alunos
    ADD CONSTRAINT pk_dbpessoas_alunos PRIMARY KEY (codigo);


--
-- Name: pk_dbpessoas_complemento_pf; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_complemento_pf
    ADD CONSTRAINT pk_dbpessoas_complemento_pf PRIMARY KEY (codigo);


--
-- Name: pk_dbpessoas_complemento_pj; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_complemento_pj
    ADD CONSTRAINT pk_dbpessoas_complemento_pj PRIMARY KEY (codigo);


--
-- Name: pk_dbpessoas_convenios; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_convenios
    ADD CONSTRAINT pk_dbpessoas_convenios PRIMARY KEY (codigo);


--
-- Name: pk_dbpessoas_demandas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_demandas
    ADD CONSTRAINT pk_dbpessoas_demandas PRIMARY KEY (codigo);


--
-- Name: pk_dbpessoas_enderecoscobrancas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_enderecoscobrancas
    ADD CONSTRAINT pk_dbpessoas_enderecoscobrancas PRIMARY KEY (codigo);


--
-- Name: pk_dbpessoas_formacoes; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_formacoes
    ADD CONSTRAINT pk_dbpessoas_formacoes PRIMARY KEY (codigo);


--
-- Name: pk_dbpessoas_funcionarios; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_funcionarios
    ADD CONSTRAINT pk_dbpessoas_funcionarios PRIMARY KEY (codigo);


--
-- Name: pk_dbpessoas_inscricoes; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_inscricoes
    ADD CONSTRAINT pk_dbpessoas_inscricoes PRIMARY KEY (codigo);


--
-- Name: pk_dbpessoas_livros; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_livros
    ADD CONSTRAINT pk_dbpessoas_livros PRIMARY KEY (codigo);


--
-- Name: pk_dbpessoas_solicitacoes; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_solicitacoes
    ADD CONSTRAINT pk_dbpessoas_solicitacoes PRIMARY KEY (codigo);


--
-- Name: pk_dbpessoas_titularidades; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_titularidades
    ADD CONSTRAINT pk_dbpessoas_titularidades PRIMARY KEY (codigo);


--
-- Name: pk_dbplano_contas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbplano_contas
    ADD CONSTRAINT pk_dbplano_contas PRIMARY KEY (codigo);


--
-- Name: pk_dbprocessos_academicos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprocessos_academicos
    ADD CONSTRAINT pk_dbprocessos_academicos PRIMARY KEY (codigo);


--
-- Name: pk_dbprodutos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprodutos
    ADD CONSTRAINT pk_dbprodutos PRIMARY KEY (codigo);


--
-- Name: pk_dbprodutos_insumos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprodutos_caracteristicas
    ADD CONSTRAINT pk_dbprodutos_insumos PRIMARY KEY (codigo);


--
-- Name: pk_dbprodutos_parametros; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprodutos_parametros
    ADD CONSTRAINT pk_dbprodutos_parametros PRIMARY KEY (codigo);


--
-- Name: pk_dbprodutos_tabelapreco; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprodutos_tabelapreco
    ADD CONSTRAINT pk_dbprodutos_tabelapreco PRIMARY KEY (codigo);


--
-- Name: pk_dbprodutos_tipos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprodutos_tipos
    ADD CONSTRAINT pk_dbprodutos_tipos PRIMARY KEY (codigo);


--
-- Name: pk_dbprodutos_tributos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprodutos_tributos
    ADD CONSTRAINT pk_dbprodutos_tributos PRIMARY KEY (codigo);


--
-- Name: pk_dbprofessores_areas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprofessores_areas
    ADD CONSTRAINT pk_dbprofessores_areas PRIMARY KEY (codigo);


--
-- Name: pk_dbprojetos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprojetos
    ADD CONSTRAINT pk_dbprojetos PRIMARY KEY (codigo);


--
-- Name: pk_dbprojetos_colaboradores; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprojetos_colaboradores
    ADD CONSTRAINT pk_dbprojetos_colaboradores PRIMARY KEY (codigo);


--
-- Name: pk_dbprojetos_custos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprojetos_custos
    ADD CONSTRAINT pk_dbprojetos_custos PRIMARY KEY (codigo);


--
-- Name: pk_dbprojetos_recursos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprojetos_recursos
    ADD CONSTRAINT pk_dbprojetos_recursos PRIMARY KEY (codigo);


--
-- Name: pk_dbquestionarios; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbquestionarios
    ADD CONSTRAINT pk_dbquestionarios PRIMARY KEY (codigo);


--
-- Name: pk_dbquestoes; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbquestoes
    ADD CONSTRAINT pk_dbquestoes PRIMARY KEY (codigo);


--
-- Name: pk_dbquestoes_itens; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbquestoes_itens
    ADD CONSTRAINT pk_dbquestoes_itens PRIMARY KEY (codigo);


--
-- Name: pk_dbrecados; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbrecados
    ADD CONSTRAINT pk_dbrecados PRIMARY KEY (codigo);


--
-- Name: pk_dbsalas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbsalas
    ADD CONSTRAINT pk_dbsalas PRIMARY KEY (codigo);


--
-- Name: pk_dbscorecard; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbscorecard
    ADD CONSTRAINT pk_dbscorecard PRIMARY KEY (codigo);


--
-- Name: pk_dbscorecard_sentencas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbscorecard_sentencas
    ADD CONSTRAINT pk_dbscorecard_sentencas PRIMARY KEY (codigo);


--
-- Name: pk_dbstatus; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbstatus
    ADD CONSTRAINT pk_dbstatus PRIMARY KEY (id);


--
-- Name: pk_dbtransacoes; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes
    ADD CONSTRAINT pk_dbtransacoes PRIMARY KEY (codigo);


--
-- Name: pk_dbtransacoes_contas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes_contas
    ADD CONSTRAINT pk_dbtransacoes_contas PRIMARY KEY (codigo);


--
-- Name: pk_dbtransacoes_contas_duplicatas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes_contas_duplicatas
    ADD CONSTRAINT pk_dbtransacoes_contas_duplicatas PRIMARY KEY (codigo);


--
-- Name: pk_dbtransacoes_contas_extornos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes_contas_extornos
    ADD CONSTRAINT pk_dbtransacoes_contas_extornos PRIMARY KEY (codigo);


--
-- Name: pk_dbtransacoes_contas_situacao; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes_contas_situacao
    ADD CONSTRAINT pk_dbtransacoes_contas_situacao PRIMARY KEY (codigo);


--
-- Name: pk_dbtransacoes_convenios; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes_convenios
    ADD CONSTRAINT pk_dbtransacoes_convenios PRIMARY KEY (codigo);


--
-- Name: pk_dbtransacoes_produtos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes_produtos
    ADD CONSTRAINT pk_dbtransacoes_produtos PRIMARY KEY (codigo);


--
-- Name: pk_dbtreinamentos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtreinamentos
    ADD CONSTRAINT pk_dbtreinamentos PRIMARY KEY (codigo);


--
-- Name: pk_dbtributos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtributos
    ADD CONSTRAINT pk_dbtributos PRIMARY KEY (codigo);


--
-- Name: pk_dbturmas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas
    ADD CONSTRAINT pk_dbturmas PRIMARY KEY (codigo);


--
-- Name: pk_dbturmas_convenios; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_convenios
    ADD CONSTRAINT pk_dbturmas_convenios PRIMARY KEY (codigo);


--
-- Name: pk_dbturmas_descontos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_descontos
    ADD CONSTRAINT pk_dbturmas_descontos PRIMARY KEY (codigo);


--
-- Name: pk_dbturmas_disciplinas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas
    ADD CONSTRAINT pk_dbturmas_disciplinas PRIMARY KEY (codigo);


--
-- Name: pk_dbturmas_disciplinas_arquivos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas_arquivos
    ADD CONSTRAINT pk_dbturmas_disciplinas_arquivos PRIMARY KEY (codigo);


--
-- Name: pk_dbturmas_disciplinas_aulas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas_aulas
    ADD CONSTRAINT pk_dbturmas_disciplinas_aulas PRIMARY KEY (codigo);


--
-- Name: pk_dbturmas_disciplinas_avaliacao_detalhamento; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas_avaliacao_detalhamento
    ADD CONSTRAINT pk_dbturmas_disciplinas_avaliacao_detalhamento PRIMARY KEY (codigo);


--
-- Name: pk_dbturmas_disciplinas_avaliacoes; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas_avaliacoes
    ADD CONSTRAINT pk_dbturmas_disciplinas_avaliacoes PRIMARY KEY (codigo);


--
-- Name: pk_dbturmas_disciplinas_materiais; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas_materiais
    ADD CONSTRAINT pk_dbturmas_disciplinas_materiais PRIMARY KEY (codigo);


--
-- Name: pk_dbturmas_disciplinas_planoaulas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas_planoaulas
    ADD CONSTRAINT pk_dbturmas_disciplinas_planoaulas PRIMARY KEY (codigo);


--
-- Name: pk_dbturmas_requisitos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_requisitos
    ADD CONSTRAINT pk_dbturmas_requisitos PRIMARY KEY (codigo);


--
-- Name: pk_dbunidades; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbunidades
    ADD CONSTRAINT pk_dbunidades PRIMARY KEY (codigo);


--
-- Name: pk_dbunidades_parametros; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbunidades_parametros
    ADD CONSTRAINT pk_dbunidades_parametros PRIMARY KEY (codigo);


--
-- Name: pk_dbusuarios; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbusuarios
    ADD CONSTRAINT pk_dbusuarios PRIMARY KEY (codigo);


--
-- Name: pk_dbusuarios_erros; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbusuarios_erros
    ADD CONSTRAINT pk_dbusuarios_erros PRIMARY KEY (codigo);


--
-- Name: pk_dbusuarios_historico; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbusuarios_historico
    ADD CONSTRAINT pk_dbusuarios_historico PRIMARY KEY (codigo);


--
-- Name: pk_dbusuarios_privilegios; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbusuarios_privilegios
    ADD CONSTRAINT pk_dbusuarios_privilegios PRIMARY KEY (codigo);


--
-- Name: pk_dbusuarios_senhas_recuperacao; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbusuarios_senhas_recuperacao
    ADD CONSTRAINT pk_dbusuarios_senhas_recuperacao PRIMARY KEY (codigo);


--
-- Name: pk_id_dbalunos_disciplinas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_disciplinas
    ADD CONSTRAINT pk_id_dbalunos_disciplinas UNIQUE (id);


--
-- Name: pk_id_dbalunos_disciplinas_aproveitamentos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_disciplinas_aproveitamentos
    ADD CONSTRAINT pk_id_dbalunos_disciplinas_aproveitamentos UNIQUE (id);


--
-- Name: pk_id_dbalunos_faltas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_faltas
    ADD CONSTRAINT pk_id_dbalunos_faltas UNIQUE (id);


--
-- Name: pk_id_dbalunos_notas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_notas
    ADD CONSTRAINT pk_id_dbalunos_notas UNIQUE (id);


--
-- Name: pk_id_dbalunos_requisitos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_requisitos
    ADD CONSTRAINT pk_id_dbalunos_requisitos UNIQUE (id);


--
-- Name: pk_id_dbalunos_solicitacoes; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_solicitacoes
    ADD CONSTRAINT pk_id_dbalunos_solicitacoes UNIQUE (id);


--
-- Name: pk_id_dbalunos_transacoes; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_transacoes
    ADD CONSTRAINT pk_id_dbalunos_transacoes UNIQUE (id);


--
-- Name: pk_id_dbavaliacoes; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbavaliacoes
    ADD CONSTRAINT pk_id_dbavaliacoes UNIQUE (id);


--
-- Name: pk_id_dbavaliacoes_regras; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbavaliacoes_regras
    ADD CONSTRAINT pk_id_dbavaliacoes_regras UNIQUE (id);


--
-- Name: pk_id_dbbalanco_patrimonial; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbbalanco_patrimonial
    ADD CONSTRAINT pk_id_dbbalanco_patrimonial UNIQUE (id);


--
-- Name: pk_id_dbbiblioteca_cdu; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbbiblioteca_cdu
    ADD CONSTRAINT pk_id_dbbiblioteca_cdu UNIQUE (id);


--
-- Name: pk_id_dbcaixa; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcaixa
    ADD CONSTRAINT pk_id_dbcaixa UNIQUE (id);


--
-- Name: pk_id_dbcaixa_fechamentos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcaixa_fechamentos
    ADD CONSTRAINT pk_id_dbcaixa_fechamentos UNIQUE (id);


--
-- Name: pk_id_dbcaixa_funcionarios; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcaixa_funcionarios
    ADD CONSTRAINT pk_id_dbcaixa_funcionarios UNIQUE (id);


--
-- Name: pk_id_dbcaixa_historico; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcontas_caixa_historico
    ADD CONSTRAINT pk_id_dbcaixa_historico UNIQUE (id);


--
-- Name: pk_id_dbcargos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcargos
    ADD CONSTRAINT pk_id_dbcargos UNIQUE (id);


--
-- Name: pk_id_dbcheques; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcontas_cheques
    ADD CONSTRAINT pk_id_dbcheques UNIQUE (id);


--
-- Name: pk_id_dbcompras; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcompras
    ADD CONSTRAINT pk_id_dbcompras UNIQUE (id);


--
-- Name: pk_id_dbcontas_caixa; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcontas_caixa
    ADD CONSTRAINT pk_id_dbcontas_caixa UNIQUE (id);


--
-- Name: pk_id_dbcontas_extornos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes_contas_extornos
    ADD CONSTRAINT pk_id_dbcontas_extornos UNIQUE (id);


--
-- Name: pk_id_dbcontratos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcontratos
    ADD CONSTRAINT pk_id_dbcontratos UNIQUE (id);


--
-- Name: pk_id_dbconvenios_descontos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbconvenios_descontos
    ADD CONSTRAINT pk_id_dbconvenios_descontos UNIQUE (id);


--
-- Name: pk_id_dbcotacoes; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcotacoes
    ADD CONSTRAINT pk_id_dbcotacoes UNIQUE (id);


--
-- Name: pk_id_dbcrm_demandas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcrm_demandas
    ADD CONSTRAINT pk_id_dbcrm_demandas UNIQUE (id);


--
-- Name: pk_id_dbcurriculos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcurriculos
    ADD CONSTRAINT pk_id_dbcurriculos UNIQUE (id);


--
-- Name: pk_id_dbcursos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcursos
    ADD CONSTRAINT pk_id_dbcursos UNIQUE (id);


--
-- Name: pk_id_dbcursos_areas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcursos_areas
    ADD CONSTRAINT pk_id_dbcursos_areas UNIQUE (id);


--
-- Name: pk_id_dbcursos_ativos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcursos_ativos
    ADD CONSTRAINT pk_id_dbcursos_ativos UNIQUE (id);


--
-- Name: pk_id_dbcursos_avaliacoes; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcursos_avaliacoes
    ADD CONSTRAINT pk_id_dbcursos_avaliacoes UNIQUE (id);


--
-- Name: pk_id_dbcursos_disciplinas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcursos_disciplinas
    ADD CONSTRAINT pk_id_dbcursos_disciplinas UNIQUE (id);


--
-- Name: pk_id_dbcursos_tipos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcursos_tipos
    ADD CONSTRAINT pk_id_dbcursos_tipos UNIQUE (id);


--
-- Name: pk_id_dbdados_boleto; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbdados_boleto
    ADD CONSTRAINT pk_id_dbdados_boleto UNIQUE (id);


--
-- Name: pk_id_dbdepartamentos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbdepartamentos
    ADD CONSTRAINT pk_id_dbdepartamentos UNIQUE (id);


--
-- Name: pk_id_dbdisciplinas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbdisciplinas
    ADD CONSTRAINT pk_id_dbdisciplinas UNIQUE (id);


--
-- Name: pk_id_dbdisciplinas_semelhantes; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbdisciplinas_semelhantes
    ADD CONSTRAINT pk_id_dbdisciplinas_semelhantes UNIQUE (id);


--
-- Name: pk_id_dbdocumentos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbdocumentos
    ADD CONSTRAINT pk_id_dbdocumentos UNIQUE (id);


--
-- Name: pk_id_dbfuncionarios_ferias; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfuncionarios_ferias
    ADD CONSTRAINT pk_id_dbfuncionarios_ferias UNIQUE (id);


--
-- Name: pk_id_dbfuncionarios_folhapagamento; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfuncionarios_folhapagamento
    ADD CONSTRAINT pk_id_dbfuncionarios_folhapagamento UNIQUE (id);


--
-- Name: pk_id_dbfuncionarios_ocorrencias; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfuncionarios_ocorrencias
    ADD CONSTRAINT pk_id_dbfuncionarios_ocorrencias UNIQUE (id);


--
-- Name: pk_id_dbfuncionarios_professores; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfuncionarios_professores
    ADD CONSTRAINT pk_id_dbfuncionarios_professores UNIQUE (id);


--
-- Name: pk_id_dbfuncionarios_treinamentos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfuncionarios_treinamentos
    ADD CONSTRAINT pk_id_dbfuncionarios_treinamentos UNIQUE (id);


--
-- Name: pk_id_dbgrade_avaliacoes; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbgrade_avaliacoes
    ADD CONSTRAINT pk_id_dbgrade_avaliacoes UNIQUE (id);


--
-- Name: pk_id_dbpatrimonios_livros; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpatrimonios_livros
    ADD CONSTRAINT pk_id_dbpatrimonios_livros UNIQUE (id);


--
-- Name: pk_id_dbpessoas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas
    ADD CONSTRAINT pk_id_dbpessoas UNIQUE (id);


--
-- Name: pk_id_dbpessoas_alunos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_alunos
    ADD CONSTRAINT pk_id_dbpessoas_alunos UNIQUE (id);


--
-- Name: pk_id_dbpessoas_complemento_pj; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_complemento_pj
    ADD CONSTRAINT pk_id_dbpessoas_complemento_pj UNIQUE (id);


--
-- Name: pk_id_dbpessoas_convenios; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_convenios
    ADD CONSTRAINT pk_id_dbpessoas_convenios UNIQUE (id);


--
-- Name: pk_id_dbpessoas_demandas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_demandas
    ADD CONSTRAINT pk_id_dbpessoas_demandas UNIQUE (id);


--
-- Name: pk_id_dbpessoas_formacoes; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_formacoes
    ADD CONSTRAINT pk_id_dbpessoas_formacoes UNIQUE (id);


--
-- Name: pk_id_dbpessoas_funcionarios; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_funcionarios
    ADD CONSTRAINT pk_id_dbpessoas_funcionarios UNIQUE (id);


--
-- Name: pk_id_dbpessoas_inscricoes; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_inscricoes
    ADD CONSTRAINT pk_id_dbpessoas_inscricoes UNIQUE (id);


--
-- Name: pk_id_dbpessoas_livros; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_livros
    ADD CONSTRAINT pk_id_dbpessoas_livros UNIQUE (id);


--
-- Name: pk_id_dbpessoas_solicitacoes; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_solicitacoes
    ADD CONSTRAINT pk_id_dbpessoas_solicitacoes UNIQUE (id);


--
-- Name: pk_id_dbpessoas_titularidades; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_titularidades
    ADD CONSTRAINT pk_id_dbpessoas_titularidades UNIQUE (id);


--
-- Name: pk_id_dbpessos_complemento_pf; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_complemento_pf
    ADD CONSTRAINT pk_id_dbpessos_complemento_pf UNIQUE (id);


--
-- Name: pk_id_dbpesssoas_enderecoscobrancas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_enderecoscobrancas
    ADD CONSTRAINT pk_id_dbpesssoas_enderecoscobrancas UNIQUE (id);


--
-- Name: pk_id_dbplano_contas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbplano_contas
    ADD CONSTRAINT pk_id_dbplano_contas UNIQUE (id);


--
-- Name: pk_id_dbprocessos_academicos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprocessos_academicos
    ADD CONSTRAINT pk_id_dbprocessos_academicos UNIQUE (id);


--
-- Name: pk_id_dbprodutos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprodutos
    ADD CONSTRAINT pk_id_dbprodutos UNIQUE (id);


--
-- Name: pk_id_dbprodutos_insumos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprodutos_caracteristicas
    ADD CONSTRAINT pk_id_dbprodutos_insumos UNIQUE (id);


--
-- Name: pk_id_dbprodutos_parametros; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprodutos_parametros
    ADD CONSTRAINT pk_id_dbprodutos_parametros UNIQUE (id);


--
-- Name: pk_id_dbprodutos_patrimonios; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpatrimonios
    ADD CONSTRAINT pk_id_dbprodutos_patrimonios UNIQUE (id);


--
-- Name: pk_id_dbprodutos_tabelapreco; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprodutos_tabelapreco
    ADD CONSTRAINT pk_id_dbprodutos_tabelapreco UNIQUE (id);


--
-- Name: pk_id_dbprodutos_tipos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprodutos_tipos
    ADD CONSTRAINT pk_id_dbprodutos_tipos UNIQUE (id);


--
-- Name: pk_id_dbprodutos_tributos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprodutos_tributos
    ADD CONSTRAINT pk_id_dbprodutos_tributos UNIQUE (id);


--
-- Name: pk_id_dbprofessores_areas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprofessores_areas
    ADD CONSTRAINT pk_id_dbprofessores_areas UNIQUE (id);


--
-- Name: pk_id_dbprojetos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprojetos
    ADD CONSTRAINT pk_id_dbprojetos UNIQUE (id);


--
-- Name: pk_id_dbprojetos_colaboradores; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprojetos_colaboradores
    ADD CONSTRAINT pk_id_dbprojetos_colaboradores UNIQUE (id);


--
-- Name: pk_id_dbprojetos_custos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprojetos_custos
    ADD CONSTRAINT pk_id_dbprojetos_custos UNIQUE (id);


--
-- Name: pk_id_dbprojetos_recursos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprojetos_recursos
    ADD CONSTRAINT pk_id_dbprojetos_recursos UNIQUE (id);


--
-- Name: pk_id_dbquestionarios; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbquestionarios
    ADD CONSTRAINT pk_id_dbquestionarios UNIQUE (id);


--
-- Name: pk_id_dbquestoes; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbquestoes
    ADD CONSTRAINT pk_id_dbquestoes UNIQUE (id);


--
-- Name: pk_id_dbquestoes_itens; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbquestoes_itens
    ADD CONSTRAINT pk_id_dbquestoes_itens UNIQUE (id);


--
-- Name: pk_id_dbrecados; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbrecados
    ADD CONSTRAINT pk_id_dbrecados UNIQUE (id);


--
-- Name: pk_id_dbsalas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbsalas
    ADD CONSTRAINT pk_id_dbsalas UNIQUE (id);


--
-- Name: pk_id_dbscorecard; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbscorecard
    ADD CONSTRAINT pk_id_dbscorecard UNIQUE (id);


--
-- Name: pk_id_dbscorecard_sentecas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbscorecard_sentencas
    ADD CONSTRAINT pk_id_dbscorecard_sentecas UNIQUE (id);


--
-- Name: pk_id_dbtransacoes; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes
    ADD CONSTRAINT pk_id_dbtransacoes UNIQUE (id);


--
-- Name: pk_id_dbtransacoes_contas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes_contas
    ADD CONSTRAINT pk_id_dbtransacoes_contas UNIQUE (id);


--
-- Name: pk_id_dbtransacoes_contas_duplicatas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes_contas_duplicatas
    ADD CONSTRAINT pk_id_dbtransacoes_contas_duplicatas UNIQUE (id);


--
-- Name: pk_id_dbtransacoes_contas_situacao; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes_contas_situacao
    ADD CONSTRAINT pk_id_dbtransacoes_contas_situacao UNIQUE (id);


--
-- Name: pk_id_dbtransacoes_convenios; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes_convenios
    ADD CONSTRAINT pk_id_dbtransacoes_convenios UNIQUE (id);


--
-- Name: pk_id_dbtransacoes_produtos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes_produtos
    ADD CONSTRAINT pk_id_dbtransacoes_produtos UNIQUE (id);


--
-- Name: pk_id_dbtreinamentos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtreinamentos
    ADD CONSTRAINT pk_id_dbtreinamentos UNIQUE (id);


--
-- Name: pk_id_dbtributos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtributos
    ADD CONSTRAINT pk_id_dbtributos UNIQUE (id);


--
-- Name: pk_id_dbturmas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas
    ADD CONSTRAINT pk_id_dbturmas UNIQUE (id);


--
-- Name: pk_id_dbturmas_convenios; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_convenios
    ADD CONSTRAINT pk_id_dbturmas_convenios UNIQUE (id);


--
-- Name: pk_id_dbturmas_descontos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_descontos
    ADD CONSTRAINT pk_id_dbturmas_descontos UNIQUE (id);


--
-- Name: pk_id_dbturmas_disciplinas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas
    ADD CONSTRAINT pk_id_dbturmas_disciplinas UNIQUE (id);


--
-- Name: pk_id_dbturmas_disciplinas_arquivos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas_arquivos
    ADD CONSTRAINT pk_id_dbturmas_disciplinas_arquivos UNIQUE (id);


--
-- Name: pk_id_dbturmas_disciplinas_aulas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas_aulas
    ADD CONSTRAINT pk_id_dbturmas_disciplinas_aulas UNIQUE (id);


--
-- Name: pk_id_dbturmas_disciplinas_avaliacao_detalhamento; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas_avaliacao_detalhamento
    ADD CONSTRAINT pk_id_dbturmas_disciplinas_avaliacao_detalhamento UNIQUE (id);


--
-- Name: pk_id_dbturmas_disciplinas_avaliacoes; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas_avaliacoes
    ADD CONSTRAINT pk_id_dbturmas_disciplinas_avaliacoes UNIQUE (id);


--
-- Name: pk_id_dbturmas_disciplinas_materiais; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas_materiais
    ADD CONSTRAINT pk_id_dbturmas_disciplinas_materiais UNIQUE (id);


--
-- Name: pk_id_dbturmas_disciplinas_planoaulas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas_planoaulas
    ADD CONSTRAINT pk_id_dbturmas_disciplinas_planoaulas UNIQUE (id);


--
-- Name: pk_id_dbturmas_requisitos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_requisitos
    ADD CONSTRAINT pk_id_dbturmas_requisitos UNIQUE (id);


--
-- Name: pk_id_dbunidades; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbunidades
    ADD CONSTRAINT pk_id_dbunidades UNIQUE (id);


--
-- Name: pk_id_dbunidades_parametros; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbunidades_parametros
    ADD CONSTRAINT pk_id_dbunidades_parametros UNIQUE (id);


--
-- Name: pk_id_dbusuarios; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbusuarios
    ADD CONSTRAINT pk_id_dbusuarios UNIQUE (id);


--
-- Name: pk_id_dbusuarios_erros; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbusuarios_erros
    ADD CONSTRAINT pk_id_dbusuarios_erros UNIQUE (id);


--
-- Name: pk_id_dbusuarios_historico; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbusuarios_historico
    ADD CONSTRAINT pk_id_dbusuarios_historico UNIQUE (id);


--
-- Name: pk_id_dbusuarios_privilegios; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbusuarios_privilegios
    ADD CONSTRAINT pk_id_dbusuarios_privilegios UNIQUE (id);


--
-- Name: pk_id_dbusuarios_senhas_recuperacao; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbusuarios_senhas_recuperacao
    ADD CONSTRAINT pk_id_dbusuarios_senhas_recuperacao UNIQUE (id);


--
-- Name: fki__dbtransacoes_contas__dbcontas_cheques; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki__dbtransacoes_contas__dbcontas_cheques ON dbcontas_cheques USING btree (codigoconta);


--
-- Name: fki_dbcaixa__dbpessoas_cheques__codigocaixa; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_dbcaixa__dbpessoas_cheques__codigocaixa ON dbcontas_cheques USING btree (codigocaixa);


--
-- Name: fki_dbcaixa_funcionarios__dbcaixa__codigocaixafuncionario; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_dbcaixa_funcionarios__dbcaixa__codigocaixafuncionario ON dbcaixa USING btree (codigofuncionario);


--
-- Name: fki_dbcontas_caixa_historico__dbcaixa__codigohistorico; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_dbcontas_caixa_historico__dbcaixa__codigohistorico ON dbcaixa USING btree (codigohistorico);


--
-- Name: fki_dbcontratos__dbpessoas_convenios__codigoconvenio; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_dbcontratos__dbpessoas_convenios__codigoconvenio ON dbpessoas_convenios USING btree (codigoconvenio);


--
-- Name: fki_dbplano_contas_dbconvenios_codigoplanoconta; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_dbplano_contas_dbconvenios_codigoplanoconta ON dbconvenios USING btree (codigoplanoconta);


--
-- Name: fki_dbprodutos_tipos__dbprodutos__codigotipoproduto; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_dbprodutos_tipos__dbprodutos__codigotipoproduto ON dbprodutos_parametros USING btree (codigotipoproduto);


--
-- Name: fki_dbprodutos_tipos__dbprodutos_codigotipoproduto; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_dbprodutos_tipos__dbprodutos_codigotipoproduto ON dbprodutos USING btree (codigotipoproduto);


--
-- Name: idx_usuarios_privilegios; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_usuarios_privilegios ON dbusuarios_privilegios USING btree (codigousuario, funcionalidade);


--
-- Name: atualiza_pessoa_funcionario; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER atualiza_pessoa_funcionario AFTER INSERT OR DELETE OR UPDATE ON dbpessoas FOR EACH ROW EXECUTE PROCEDURE atualiza_pessoa_funcionario();


--
-- Name: fk__dbtransacoes_contas__dbcontas_cheques; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcontas_cheques
    ADD CONSTRAINT fk__dbtransacoes_contas__dbcontas_cheques FOREIGN KEY (codigoconta) REFERENCES dbtransacoes_contas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbalunos__dbalunos_disciplinas__codigoaluno; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_disciplinas
    ADD CONSTRAINT fk_dbalunos__dbalunos_disciplinas__codigoaluno FOREIGN KEY (codigoaluno) REFERENCES dbpessoas_alunos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbalunos__dbalunos_faltas__codigoaluno; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_faltas
    ADD CONSTRAINT fk_dbalunos__dbalunos_faltas__codigoaluno FOREIGN KEY (codigoaluno) REFERENCES dbpessoas_alunos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbalunos__dbalunos_notas__codigoaluno; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_notas
    ADD CONSTRAINT fk_dbalunos__dbalunos_notas__codigoaluno FOREIGN KEY (codigoaluno) REFERENCES dbpessoas_alunos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbalunos_disciplinas__dbalunos_disciplinas_aproveitamentos__; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_disciplinas_aproveitamentos
    ADD CONSTRAINT fk_dbalunos_disciplinas__dbalunos_disciplinas_aproveitamentos__ FOREIGN KEY (codigoalunodisciplina) REFERENCES dbalunos_disciplinas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbavalia_fk_dbgrad_dbgrade_; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbavaliacoes
    ADD CONSTRAINT fk_dbavalia_fk_dbgrad_dbgrade_ FOREIGN KEY (codigograde) REFERENCES dbgrade_avaliacoes(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbbiblioteca_cdu__dbpatrimonios_livros__codigocdu; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpatrimonios_livros
    ADD CONSTRAINT fk_dbbiblioteca_cdu__dbpatrimonios_livros__codigocdu FOREIGN KEY (codigocdu) REFERENCES dbbiblioteca_cdu(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbcaixa__dbpessoas_cheques__codigocaixa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcontas_cheques
    ADD CONSTRAINT fk_dbcaixa__dbpessoas_cheques__codigocaixa FOREIGN KEY (codigocaixa) REFERENCES dbcaixa(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbcargos__dbpessoas_funcionarios__codigocargo; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_funcionarios
    ADD CONSTRAINT fk_dbcargos__dbpessoas_funcionarios__codigocargo FOREIGN KEY (codigocargo) REFERENCES dbcargos(codigo);


--
-- Name: fk_dbcontas_caixa__dbcaixa__codigocontacaixa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcaixa
    ADD CONSTRAINT fk_dbcontas_caixa__dbcaixa__codigocontacaixa FOREIGN KEY (codigocontacaixa) REFERENCES dbcontas_caixa(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbcontas_caixa__dbcaixa__codigocontacaixa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcaixa_funcionarios
    ADD CONSTRAINT fk_dbcontas_caixa__dbcaixa__codigocontacaixa FOREIGN KEY (codigocontacaixa) REFERENCES dbcontas_caixa(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbcontas_caixa__dbcontas_caixa_historico__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcontas_caixa_historico
    ADD CONSTRAINT fk_dbcontas_caixa__dbcontas_caixa_historico__unidade FOREIGN KEY (codigocontacaixa) REFERENCES dbcontas_caixa(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbcontas_caixa_historico__dbcaixa__codigohistorico; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcaixa
    ADD CONSTRAINT fk_dbcontas_caixa_historico__dbcaixa__codigohistorico FOREIGN KEY (codigohistorico) REFERENCES dbcontas_caixa_historico(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbcontratos__dbpessoas_convenios__codigoconvenio; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_convenios
    ADD CONSTRAINT fk_dbcontratos__dbpessoas_convenios__codigoconvenio FOREIGN KEY (codigoconvenio) REFERENCES dbconvenios(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbconvenios__dbconvenios_descontos__codigoconvenio; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbconvenios_descontos
    ADD CONSTRAINT fk_dbconvenios__dbconvenios_descontos__codigoconvenio FOREIGN KEY (codigoconvenio) REFERENCES dbconvenios(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbconvenios__dbtransacoes_convenios__codigoconvenio; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes_convenios
    ADD CONSTRAINT fk_dbconvenios__dbtransacoes_convenios__codigoconvenio FOREIGN KEY (codigoconvenio) REFERENCES dbconvenios(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbconvenios__dbturmas_convenios__codigoconvenio; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_convenios
    ADD CONSTRAINT fk_dbconvenios__dbturmas_convenios__codigoconvenio FOREIGN KEY (codigoconvenio) REFERENCES dbconvenios(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbcursos__dbcursos_ativos__codigocurso; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcursos_ativos
    ADD CONSTRAINT fk_dbcursos__dbcursos_ativos__codigocurso FOREIGN KEY (codigocurso) REFERENCES dbcursos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbcursos__dbcursos_avaliacoes__codigocurso; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcursos_avaliacoes
    ADD CONSTRAINT fk_dbcursos__dbcursos_avaliacoes__codigocurso FOREIGN KEY (codigocurso) REFERENCES dbcursos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbcursos__dbcursos_disciplinas__codigocurso; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcursos_disciplinas
    ADD CONSTRAINT fk_dbcursos__dbcursos_disciplinas__codigocurso FOREIGN KEY (codigocurso) REFERENCES dbcursos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbcursos__dbdisciplinas_semelhantes__codigodisciplinasemelha; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbdisciplinas_semelhantes
    ADD CONSTRAINT fk_dbcursos__dbdisciplinas_semelhantes__codigodisciplinasemelha FOREIGN KEY (codigodisciplina) REFERENCES dbdisciplinas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbcursos__dbpessoas_alunos__codigocurso; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_alunos
    ADD CONSTRAINT fk_dbcursos__dbpessoas_alunos__codigocurso FOREIGN KEY (codigocurso) REFERENCES dbcursos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbcursos__dbpessoas_demandas__codigocurso; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_demandas
    ADD CONSTRAINT fk_dbcursos__dbpessoas_demandas__codigocurso FOREIGN KEY (codigocurso) REFERENCES dbcursos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbcursos__dbpessoas_inscricoes__codigocurso; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_inscricoes
    ADD CONSTRAINT fk_dbcursos__dbpessoas_inscricoes__codigocurso FOREIGN KEY (codigocurso) REFERENCES dbcursos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbcursos__dbturmas__codigocurso; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas
    ADD CONSTRAINT fk_dbcursos__dbturmas__codigocurso FOREIGN KEY (codigocurso) REFERENCES dbcursos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbcursos_areas__dbcursos__codigoareacurso; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcursos
    ADD CONSTRAINT fk_dbcursos_areas__dbcursos__codigoareacurso FOREIGN KEY (codigoareacurso) REFERENCES dbcursos_areas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbcursos_areas__dbprofessores_areas__codigoareacurso; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprofessores_areas
    ADD CONSTRAINT fk_dbcursos_areas__dbprofessores_areas__codigoareacurso FOREIGN KEY (codigoareacurso) REFERENCES dbcursos_areas(codigo);


--
-- Name: fk_dbcursos_ativos__dbturmas__codigocursoativo; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas
    ADD CONSTRAINT fk_dbcursos_ativos__dbturmas__codigocursoativo FOREIGN KEY (codigocursoativo) REFERENCES dbcursos_ativos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbcursos_tipos__dbcursos__codigotipocurso; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcursos
    ADD CONSTRAINT fk_dbcursos_tipos__dbcursos__codigotipocurso FOREIGN KEY (codigotipocurso) REFERENCES dbcursos_tipos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbdepartamentos__dbalunos_solicitacoes__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_solicitacoes
    ADD CONSTRAINT fk_dbdepartamentos__dbalunos_solicitacoes__unidade FOREIGN KEY (codigodepartamento) REFERENCES dbdepartamentos(codigo);


--
-- Name: fk_dbdepartamentos__dbpessoas_funcionarios__codigodepartamento; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_funcionarios
    ADD CONSTRAINT fk_dbdepartamentos__dbpessoas_funcionarios__codigodepartamento FOREIGN KEY (codigodepartamento) REFERENCES dbdepartamentos(codigo);


--
-- Name: fk_dbdepartamentos__dbpessoas_solicitacoes__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_solicitacoes
    ADD CONSTRAINT fk_dbdepartamentos__dbpessoas_solicitacoes__unidade FOREIGN KEY (codigodepartamento) REFERENCES dbdepartamentos(codigo);


--
-- Name: fk_dbdisciplinas__dbcursos_disciplinas__codigodisciplina; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcursos_disciplinas
    ADD CONSTRAINT fk_dbdisciplinas__dbcursos_disciplinas__codigodisciplina FOREIGN KEY (codigodisciplina) REFERENCES dbdisciplinas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbdisciplinas__dbdisciplinas_semelhantes__codigodisciplina; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbdisciplinas_semelhantes
    ADD CONSTRAINT fk_dbdisciplinas__dbdisciplinas_semelhantes__codigodisciplina FOREIGN KEY (codigodisciplina) REFERENCES dbdisciplinas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbdisciplinas__dbturmas_disciplinas__codigodisciplina; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas
    ADD CONSTRAINT fk_dbdisciplinas__dbturmas_disciplinas__codigodisciplina FOREIGN KEY (codigodisciplina) REFERENCES dbdisciplinas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbfuncionarios_professores__dbprofessores_areas__codigoprofe; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprofessores_areas
    ADD CONSTRAINT fk_dbfuncionarios_professores__dbprofessores_areas__codigoprofe FOREIGN KEY (codigoprofessor) REFERENCES dbfuncionarios_professores(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbfuncionarios_professores__dbturmas_disciplinas__codigoprof; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas
    ADD CONSTRAINT fk_dbfuncionarios_professores__dbturmas_disciplinas__codigoprof FOREIGN KEY (codigoprofessor) REFERENCES dbfuncionarios_professores(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbfuncionarios_professores__dbturmas_disciplinas_arquivos__c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas_arquivos
    ADD CONSTRAINT fk_dbfuncionarios_professores__dbturmas_disciplinas_arquivos__c FOREIGN KEY (codigoprofessor) REFERENCES dbfuncionarios_professores(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbfuncionarios_professores__dbturmas_disciplinas_planoaulas_; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas_planoaulas
    ADD CONSTRAINT fk_dbfuncionarios_professores__dbturmas_disciplinas_planoaulas_ FOREIGN KEY (codigoprofessor) REFERENCES dbfuncionarios_professores(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbgrade_avaliacoes__dbcursos_codigograde; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcursos
    ADD CONSTRAINT fk_dbgrade_avaliacoes__dbcursos_codigograde FOREIGN KEY (codigograde) REFERENCES dbgrade_avaliacoes(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbgrade_avaliacoes_dbturmas_disciplinas__CODIGOGRADE; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas
    ADD CONSTRAINT "fk_dbgrade_avaliacoes_dbturmas_disciplinas__CODIGOGRADE" FOREIGN KEY (codigograde) REFERENCES dbgrade_avaliacoes(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbpatrimonios__dbpatrimonios_livros__codigopatrimonio; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpatrimonios_livros
    ADD CONSTRAINT fk_dbpatrimonios__dbpatrimonios_livros__codigopatrimonio FOREIGN KEY (codigopatrimonio) REFERENCES dbpatrimonios(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbpatrimonios_livros__dbpessoas_livros__codigolivro; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_livros
    ADD CONSTRAINT fk_dbpatrimonios_livros__dbpessoas_livros__codigolivro FOREIGN KEY (codigolivro) REFERENCES dbpatrimonios_livros(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbpessoas__dbalunos_solicitacoes__codigoaluno; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_solicitacoes
    ADD CONSTRAINT fk_dbpessoas__dbalunos_solicitacoes__codigoaluno FOREIGN KEY (codigoaluno) REFERENCES dbpessoas_alunos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbpessoas__dbcaixa__codigopessoa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcaixa
    ADD CONSTRAINT fk_dbpessoas__dbcaixa__codigopessoa FOREIGN KEY (codigopessoa) REFERENCES dbpessoas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbpessoas__dbcontratos__codigopessoa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcontratos
    ADD CONSTRAINT fk_dbpessoas__dbcontratos__codigopessoa FOREIGN KEY (codigopessoa) REFERENCES dbpessoas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbpessoas__dbcotacoes__codigofornecedor; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcotacoes
    ADD CONSTRAINT fk_dbpessoas__dbcotacoes__codigofornecedor FOREIGN KEY (codigofornecedor) REFERENCES dbpessoas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbpessoas__dbpessoas_alunos__codigopessoa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_alunos
    ADD CONSTRAINT fk_dbpessoas__dbpessoas_alunos__codigopessoa FOREIGN KEY (codigopessoa) REFERENCES dbpessoas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbpessoas__dbpessoas_complemento_pf__codigopessoa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_complemento_pf
    ADD CONSTRAINT fk_dbpessoas__dbpessoas_complemento_pf__codigopessoa FOREIGN KEY (codigopessoa) REFERENCES dbpessoas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbpessoas__dbpessoas_complemento_pj__codigopessoa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_complemento_pj
    ADD CONSTRAINT fk_dbpessoas__dbpessoas_complemento_pj__codigopessoa FOREIGN KEY (codigopessoa) REFERENCES dbpessoas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbpessoas__dbpessoas_convenios__codigopessoa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_convenios
    ADD CONSTRAINT fk_dbpessoas__dbpessoas_convenios__codigopessoa FOREIGN KEY (codigopessoa) REFERENCES dbpessoas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbpessoas__dbpessoas_demandas__codigopessoa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_demandas
    ADD CONSTRAINT fk_dbpessoas__dbpessoas_demandas__codigopessoa FOREIGN KEY (codigopessoa) REFERENCES dbpessoas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbpessoas__dbpessoas_enderecoscobrancas__codigopessoa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_enderecoscobrancas
    ADD CONSTRAINT fk_dbpessoas__dbpessoas_enderecoscobrancas__codigopessoa FOREIGN KEY (codigopessoa) REFERENCES dbpessoas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbpessoas__dbpessoas_formacoes__codigopessoa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_formacoes
    ADD CONSTRAINT fk_dbpessoas__dbpessoas_formacoes__codigopessoa FOREIGN KEY (codigopessoa) REFERENCES dbpessoas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbpessoas__dbpessoas_formacoes__codigotitularidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_formacoes
    ADD CONSTRAINT fk_dbpessoas__dbpessoas_formacoes__codigotitularidade FOREIGN KEY (codigotitularidade) REFERENCES dbpessoas_titularidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbpessoas__dbpessoas_funcionarios__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_funcionarios
    ADD CONSTRAINT fk_dbpessoas__dbpessoas_funcionarios__unidade FOREIGN KEY (codigopessoa) REFERENCES dbpessoas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbpessoas__dbpessoas_inscricoes__codigopessoa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_inscricoes
    ADD CONSTRAINT fk_dbpessoas__dbpessoas_inscricoes__codigopessoa FOREIGN KEY (codigopessoa) REFERENCES dbpessoas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbpessoas__dbpessoas_livros__codigopessoa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_livros
    ADD CONSTRAINT fk_dbpessoas__dbpessoas_livros__codigopessoa FOREIGN KEY (codigopessoa) REFERENCES dbpessoas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbpessoas__dbpessoas_solicitacoes__codigopessoa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_solicitacoes
    ADD CONSTRAINT fk_dbpessoas__dbpessoas_solicitacoes__codigopessoa FOREIGN KEY (codigopessoa) REFERENCES dbpessoas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbpessoas__dbprojetos_colaboradores__codigopessoa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprojetos_colaboradores
    ADD CONSTRAINT fk_dbpessoas__dbprojetos_colaboradores__codigopessoa FOREIGN KEY (codigopessoa) REFERENCES dbpessoas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbpessoas__dbtransacoes__codigopessoa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes
    ADD CONSTRAINT fk_dbpessoas__dbtransacoes__codigopessoa FOREIGN KEY (codigopessoa) REFERENCES dbpessoas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbpessoas__dbtransacoes_contas__codigopessoa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes_contas
    ADD CONSTRAINT fk_dbpessoas__dbtransacoes_contas__codigopessoa FOREIGN KEY (codigopessoa) REFERENCES dbpessoas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbpessoas__dbtransacoes_contas_duplicatas__codigopessoa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes_contas_duplicatas
    ADD CONSTRAINT fk_dbpessoas__dbtransacoes_contas_duplicatas__codigopessoa FOREIGN KEY (codigopessoa) REFERENCES dbpessoas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbpessoas__dbusuarios__codigousuario; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbusuarios
    ADD CONSTRAINT fk_dbpessoas__dbusuarios__codigousuario FOREIGN KEY (codigopessoa) REFERENCES dbpessoas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbpessoas_alunos__dbalunos_transacoes__codigoaluno; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_transacoes
    ADD CONSTRAINT fk_dbpessoas_alunos__dbalunos_transacoes__codigoaluno FOREIGN KEY (codigoaluno) REFERENCES dbpessoas_alunos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbpessoas_funcionarios__dbalunos_solicitacoes__codigofuncio; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_solicitacoes
    ADD CONSTRAINT fk_dbpessoas_funcionarios__dbalunos_solicitacoes__codigofuncio FOREIGN KEY (codigofuncionario) REFERENCES dbpessoas_funcionarios(codigo);


--
-- Name: fk_dbpessoas_funcionarios__dbcaixa__codigofuncionario; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcaixa
    ADD CONSTRAINT fk_dbpessoas_funcionarios__dbcaixa__codigofuncionario FOREIGN KEY (codigofuncionario) REFERENCES dbpessoas_funcionarios(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbpessoas_funcionarios__dbcaixa_funcionarios__codigofunciona; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcaixa_funcionarios
    ADD CONSTRAINT fk_dbpessoas_funcionarios__dbcaixa_funcionarios__codigofunciona FOREIGN KEY (codigofuncionario) REFERENCES dbpessoas_funcionarios(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbpessoas_funcionarios__dbfuncionarios_ferias__codigofuncion; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfuncionarios_ferias
    ADD CONSTRAINT fk_dbpessoas_funcionarios__dbfuncionarios_ferias__codigofuncion FOREIGN KEY (codigofuncionario) REFERENCES dbpessoas_funcionarios(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbpessoas_funcionarios__dbfuncionarios_folhapagamento__codig; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfuncionarios_folhapagamento
    ADD CONSTRAINT fk_dbpessoas_funcionarios__dbfuncionarios_folhapagamento__codig FOREIGN KEY (codigofuncionario) REFERENCES dbpessoas_funcionarios(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbpessoas_funcionarios__dbfuncionarios_ocorrencias__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfuncionarios_ocorrencias
    ADD CONSTRAINT fk_dbpessoas_funcionarios__dbfuncionarios_ocorrencias__unidade FOREIGN KEY (codigofuncionario) REFERENCES dbpessoas_funcionarios(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbpessoas_funcionarios__dbfuncionarios_professores__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfuncionarios_professores
    ADD CONSTRAINT fk_dbpessoas_funcionarios__dbfuncionarios_professores__unidade FOREIGN KEY (codigofuncionario) REFERENCES dbpessoas_funcionarios(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbpessoas_funcionarios__dbfuncionarios_treinamentos__codigof; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfuncionarios_treinamentos
    ADD CONSTRAINT fk_dbpessoas_funcionarios__dbfuncionarios_treinamentos__codigof FOREIGN KEY (codigofuncionario) REFERENCES dbpessoas_funcionarios(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbpessoas_funcionarios__dbpatrimonios__codigofuncionario; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpatrimonios
    ADD CONSTRAINT fk_dbpessoas_funcionarios__dbpatrimonios__codigofuncionario FOREIGN KEY (codigofuncionario) REFERENCES dbpessoas_funcionarios(codigo);


--
-- Name: fk_dbpessoas_funcionarios__dbpessoas_solicitacoes__codigofuncio; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_solicitacoes
    ADD CONSTRAINT fk_dbpessoas_funcionarios__dbpessoas_solicitacoes__codigofuncio FOREIGN KEY (codigofuncionario) REFERENCES dbpessoas_funcionarios(codigo);


--
-- Name: fk_dbplano_contas__dbtransacoes__codigoplanoconta; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes
    ADD CONSTRAINT fk_dbplano_contas__dbtransacoes__codigoplanoconta FOREIGN KEY (codigoplanoconta) REFERENCES dbplano_contas(codigo);


--
-- Name: fk_dbplano_contas__dbtransacoes_contas__codigoplanoconta; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes_contas
    ADD CONSTRAINT fk_dbplano_contas__dbtransacoes_contas__codigoplanoconta FOREIGN KEY (codigoplanoconta) REFERENCES dbplano_contas(codigo);


--
-- Name: fk_dbplano_contas_dbconvenios_codigoplanoconta; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbconvenios
    ADD CONSTRAINT fk_dbplano_contas_dbconvenios_codigoplanoconta FOREIGN KEY (codigoplanoconta) REFERENCES dbplano_contas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbproduto__dbprodutos_tabelapreco__codigoproduto; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprodutos_tabelapreco
    ADD CONSTRAINT fk_dbproduto__dbprodutos_tabelapreco__codigoproduto FOREIGN KEY (codigoproduto) REFERENCES dbprodutos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbproduto__dbprodutos_tributos__codigoproduto; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprodutos_tributos
    ADD CONSTRAINT fk_dbproduto__dbprodutos_tributos__codigoproduto FOREIGN KEY (codigoproduto) REFERENCES dbprodutos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbprodutos__dbcompras__codigoproduto; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcompras
    ADD CONSTRAINT fk_dbprodutos__dbcompras__codigoproduto FOREIGN KEY (codigoproduto) REFERENCES dbprodutos(codigo);


--
-- Name: fk_dbprodutos__dbcotacoes__codigoproduto; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcotacoes
    ADD CONSTRAINT fk_dbprodutos__dbcotacoes__codigoproduto FOREIGN KEY (codigoproduto) REFERENCES dbprodutos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbprodutos__dbpatrimonios__codigoproduto; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpatrimonios
    ADD CONSTRAINT fk_dbprodutos__dbpatrimonios__codigoproduto FOREIGN KEY (codigoproduto) REFERENCES dbprodutos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbprodutos__dbprodutos_insumos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprodutos_caracteristicas
    ADD CONSTRAINT fk_dbprodutos__dbprodutos_insumos__unidade FOREIGN KEY (codigoproduto) REFERENCES dbprodutos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbprodutos__dbprodutos_parametros__codigoproduto; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprodutos_parametros
    ADD CONSTRAINT fk_dbprodutos__dbprodutos_parametros__codigoproduto FOREIGN KEY (codigoproduto) REFERENCES dbprodutos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbprodutos__dbtransacoes_produtos__codigoproduto; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes_produtos
    ADD CONSTRAINT fk_dbprodutos__dbtransacoes_produtos__codigoproduto FOREIGN KEY (codigoproduto) REFERENCES dbprodutos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbprodutos__dbturmas__codigoproduto; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas
    ADD CONSTRAINT fk_dbprodutos__dbturmas__codigoproduto FOREIGN KEY (codigoproduto) REFERENCES dbprodutos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbprodutos_tipos__dbprodutos__codigotipoproduto; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprodutos
    ADD CONSTRAINT fk_dbprodutos_tipos__dbprodutos__codigotipoproduto FOREIGN KEY (codigotipoproduto) REFERENCES dbprodutos_tipos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbprodutos_tipos__dbprodutos_parametros__codigotipoproduto; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprodutos_parametros
    ADD CONSTRAINT fk_dbprodutos_tipos__dbprodutos_parametros__codigotipoproduto FOREIGN KEY (codigotipoproduto) REFERENCES dbprodutos_tipos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbprojetos__dbprojetos_colaboradores__codigoprojeto; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprojetos_colaboradores
    ADD CONSTRAINT fk_dbprojetos__dbprojetos_colaboradores__codigoprojeto FOREIGN KEY (codigoprojeto) REFERENCES dbprojetos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbprojetos__dbprojetos_custos__codigoprojeto; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprojetos_custos
    ADD CONSTRAINT fk_dbprojetos__dbprojetos_custos__codigoprojeto FOREIGN KEY (codigoprojeto) REFERENCES dbprojetos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbprojetos__dbprojetos_custos__codigoprojeto; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprojetos_recursos
    ADD CONSTRAINT fk_dbprojetos__dbprojetos_custos__codigoprojeto FOREIGN KEY (codigoprojeto) REFERENCES dbprojetos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbquestionarios__dbquestoes__codigoquestionario; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbquestoes
    ADD CONSTRAINT fk_dbquestionarios__dbquestoes__codigoquestionario FOREIGN KEY (codigoquestionario) REFERENCES dbquestionarios(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbquestoes__dbquestoes_itens__codigoquestao; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbquestoes_itens
    ADD CONSTRAINT fk_dbquestoes__dbquestoes_itens__codigoquestao FOREIGN KEY (codigoquestao) REFERENCES dbquestoes(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbsalas__dbdepartamentos__codigosala; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbdepartamentos
    ADD CONSTRAINT fk_dbsalas__dbdepartamentos__codigosala FOREIGN KEY (codigosala) REFERENCES dbsalas(codigo);


--
-- Name: fk_dbsalas__dbturmas_disciplinas__codigosala; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas
    ADD CONSTRAINT fk_dbsalas__dbturmas_disciplinas__codigosala FOREIGN KEY (codigosala) REFERENCES dbsalas(codigo);


--
-- Name: fk_dbscorecard__dbscorecard_sentencas__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbscorecard_sentencas
    ADD CONSTRAINT fk_dbscorecard__dbscorecard_sentencas__unidade FOREIGN KEY (codigoscorecard) REFERENCES dbscorecard(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbtransacoes__dbalunos_transacoes__codigotransacao; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_transacoes
    ADD CONSTRAINT fk_dbtransacoes__dbalunos_transacoes__codigotransacao FOREIGN KEY (codigotransacao) REFERENCES dbtransacoes(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbtransacoes__dbcaixa__codigotransacao; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcaixa
    ADD CONSTRAINT fk_dbtransacoes__dbcaixa__codigotransacao FOREIGN KEY (codigotransacao) REFERENCES dbtransacoes(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbtransacoes__dbpessoas_alunos__codigotransacao; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_alunos
    ADD CONSTRAINT fk_dbtransacoes__dbpessoas_alunos__codigotransacao FOREIGN KEY (codigotransacao) REFERENCES dbtransacoes(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbtransacoes__dbpessoas_inscricoes__codigotransacao; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_inscricoes
    ADD CONSTRAINT fk_dbtransacoes__dbpessoas_inscricoes__codigotransacao FOREIGN KEY (codigotransacao) REFERENCES dbtransacoes(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbtransacoes__dbtransacoes_contas__codigotransacao; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes_contas
    ADD CONSTRAINT fk_dbtransacoes__dbtransacoes_contas__codigotransacao FOREIGN KEY (codigotransacao) REFERENCES dbtransacoes(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbtransacoes__dbtransacoes_convenios__codigotransacao; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes_convenios
    ADD CONSTRAINT fk_dbtransacoes__dbtransacoes_convenios__codigotransacao FOREIGN KEY (codigotransacao) REFERENCES dbtransacoes(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbtransacoes__dbtransacoes_produtos__codigotransacao; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes_produtos
    ADD CONSTRAINT fk_dbtransacoes__dbtransacoes_produtos__codigotransacao FOREIGN KEY (codigotransacao) REFERENCES dbtransacoes(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbtransacoes_contas__db_contas_extornos__codigocontadestino; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes_contas_extornos
    ADD CONSTRAINT fk_dbtransacoes_contas__db_contas_extornos__codigocontadestino FOREIGN KEY (codigocontadestino) REFERENCES dbtransacoes_contas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbtransacoes_contas__db_contas_extornos__codigocontaorigem; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes_contas_extornos
    ADD CONSTRAINT fk_dbtransacoes_contas__db_contas_extornos__codigocontaorigem FOREIGN KEY (codigocontaorigem) REFERENCES dbtransacoes_contas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbtransacoes_contas__dbcaixa__codigoconta; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcaixa
    ADD CONSTRAINT fk_dbtransacoes_contas__dbcaixa__codigoconta FOREIGN KEY (codigoconta) REFERENCES dbtransacoes_contas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbtransacoes_contas__dbtransacoes_contas_duplicatas__codigoc; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes_contas_duplicatas
    ADD CONSTRAINT fk_dbtransacoes_contas__dbtransacoes_contas_duplicatas__codigoc FOREIGN KEY (codigoconta) REFERENCES dbtransacoes_contas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbtreinamentos_dbfuncionarios_treinamentos__codigotreinament; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfuncionarios_treinamentos
    ADD CONSTRAINT fk_dbtreinamentos_dbfuncionarios_treinamentos__codigotreinament FOREIGN KEY (codigotreinamento) REFERENCES dbtreinamentos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbturmas__dbpessoas_alunos__codigoturma; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_alunos
    ADD CONSTRAINT fk_dbturmas__dbpessoas_alunos__codigoturma FOREIGN KEY (codigoturma) REFERENCES dbturmas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbturmas__dbpessoas_inscricoes__codigoturma; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_inscricoes
    ADD CONSTRAINT fk_dbturmas__dbpessoas_inscricoes__codigoturma FOREIGN KEY (codigoturma) REFERENCES dbturmas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbturmas__dbturmas_convenios__codigoturma; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_convenios
    ADD CONSTRAINT fk_dbturmas__dbturmas_convenios__codigoturma FOREIGN KEY (codigoturma) REFERENCES dbturmas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbturmas__dbturmas_descontos__codigoturma; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_descontos
    ADD CONSTRAINT fk_dbturmas__dbturmas_descontos__codigoturma FOREIGN KEY (codigoturma) REFERENCES dbturmas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbturmas__dbturmas_disciplinas__codigoturma; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas
    ADD CONSTRAINT fk_dbturmas__dbturmas_disciplinas__codigoturma FOREIGN KEY (codigoturma) REFERENCES dbturmas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbturmas__dbturmas_requisitos__codigoturma; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_requisitos
    ADD CONSTRAINT fk_dbturmas__dbturmas_requisitos__codigoturma FOREIGN KEY (codigoturma) REFERENCES dbturmas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbturmas_disciplinas__dbalunos_disciplinas__codisciplina; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_disciplinas
    ADD CONSTRAINT fk_dbturmas_disciplinas__dbalunos_disciplinas__codisciplina FOREIGN KEY (codigodisciplina) REFERENCES dbdisciplinas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbturmas_disciplinas__dbalunos_disciplinas__codturmadisc; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_disciplinas
    ADD CONSTRAINT fk_dbturmas_disciplinas__dbalunos_disciplinas__codturmadisc FOREIGN KEY (codigoturmadisciplina) REFERENCES dbturmas_disciplinas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbturmas_disciplinas__dbalunos_faltas__codigoturmadisciplina; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_faltas
    ADD CONSTRAINT fk_dbturmas_disciplinas__dbalunos_faltas__codigoturmadisciplina FOREIGN KEY (codigoturmadisciplina) REFERENCES dbturmas_disciplinas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbturmas_disciplinas__dbalunos_notas__codigoturmadisciplina; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_notas
    ADD CONSTRAINT fk_dbturmas_disciplinas__dbalunos_notas__codigoturmadisciplina FOREIGN KEY (codigoturmadisciplina) REFERENCES dbturmas_disciplinas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbturmas_disciplinas__dbturmas_disciplinas_arquivos__codigot; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas_arquivos
    ADD CONSTRAINT fk_dbturmas_disciplinas__dbturmas_disciplinas_arquivos__codigot FOREIGN KEY (codigoturmadisciplina) REFERENCES dbturmas_disciplinas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbturmas_disciplinas__dbturmas_disciplinas_aulas__codigoturm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas_aulas
    ADD CONSTRAINT fk_dbturmas_disciplinas__dbturmas_disciplinas_aulas__codigoturm FOREIGN KEY (codigoturmadisciplina) REFERENCES dbturmas_disciplinas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbturmas_disciplinas__dbturmas_disciplinas_avaliacao_detalha; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas_avaliacao_detalhamento
    ADD CONSTRAINT fk_dbturmas_disciplinas__dbturmas_disciplinas_avaliacao_detalha FOREIGN KEY (codigoturmadisciplina) REFERENCES dbturmas_disciplinas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbturmas_disciplinas__dbturmas_disciplinas_avaliacoes__codig; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas_avaliacoes
    ADD CONSTRAINT fk_dbturmas_disciplinas__dbturmas_disciplinas_avaliacoes__codig FOREIGN KEY (codigoturmadisciplina) REFERENCES dbturmas_disciplinas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbturmas_disciplinas__dbturmas_disciplinas_materiais__codigo; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas_materiais
    ADD CONSTRAINT fk_dbturmas_disciplinas__dbturmas_disciplinas_materiais__codigo FOREIGN KEY (codigoturmadisciplina) REFERENCES dbturmas_disciplinas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbturmas_disciplinas__dbturmas_disciplinas_planoaulas__codig; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas_planoaulas
    ADD CONSTRAINT fk_dbturmas_disciplinas__dbturmas_disciplinas_planoaulas__codig FOREIGN KEY (codigoturmadisciplina) REFERENCES dbturmas_disciplinas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbturmas_disciplinas_aulas__dbalunos_faltas__codigoaula; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_faltas
    ADD CONSTRAINT fk_dbturmas_disciplinas_aulas__dbalunos_faltas__codigoaula FOREIGN KEY (codigoaula) REFERENCES dbturmas_disciplinas_aulas(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbturmas_disciplinas_avaliacoes; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas_avaliacoes
    ADD CONSTRAINT fk_dbturmas_disciplinas_avaliacoes FOREIGN KEY (codigopai) REFERENCES dbturmas_disciplinas_avaliacoes(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbturmas_requisitos__dbalunos_requisitos_codigoaula; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_requisitos
    ADD CONSTRAINT fk_dbturmas_requisitos__dbalunos_requisitos_codigoaula FOREIGN KEY (codigorequisito) REFERENCES dbturmas_requisitos(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbalunos_disciplinas__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_disciplinas
    ADD CONSTRAINT fk_dbunidades__dbalunos_disciplinas__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbalunos_disciplinas_aproveitamentos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_disciplinas_aproveitamentos
    ADD CONSTRAINT fk_dbunidades__dbalunos_disciplinas_aproveitamentos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbalunos_faltas__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_faltas
    ADD CONSTRAINT fk_dbunidades__dbalunos_faltas__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbalunos_notas__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_notas
    ADD CONSTRAINT fk_dbunidades__dbalunos_notas__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbalunos_requisitos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_requisitos
    ADD CONSTRAINT fk_dbunidades__dbalunos_requisitos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbalunos_solicitacoes__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_solicitacoes
    ADD CONSTRAINT fk_dbunidades__dbalunos_solicitacoes__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbalunos_transacoes__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_transacoes
    ADD CONSTRAINT fk_dbunidades__dbalunos_transacoes__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbbalanco_patrimonial__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbbalanco_patrimonial
    ADD CONSTRAINT fk_dbunidades__dbbalanco_patrimonial__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbbiblioteca_cdu__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbbiblioteca_cdu
    ADD CONSTRAINT fk_dbunidades__dbbiblioteca_cdu__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbcaixa__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcaixa
    ADD CONSTRAINT fk_dbunidades__dbcaixa__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbcaixa_fechamentos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcaixa_fechamentos
    ADD CONSTRAINT fk_dbunidades__dbcaixa_fechamentos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbcaixa_funcionarios__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcaixa_funcionarios
    ADD CONSTRAINT fk_dbunidades__dbcaixa_funcionarios__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbcargos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcargos
    ADD CONSTRAINT fk_dbunidades__dbcargos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbcheques__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcontas_cheques
    ADD CONSTRAINT fk_dbunidades__dbcheques__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbcompras__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcompras
    ADD CONSTRAINT fk_dbunidades__dbcompras__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbcontas_caixa__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcontas_caixa
    ADD CONSTRAINT fk_dbunidades__dbcontas_caixa__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbcontas_caixa_historico__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcontas_caixa_historico
    ADD CONSTRAINT fk_dbunidades__dbcontas_caixa_historico__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbcontratos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcontratos
    ADD CONSTRAINT fk_dbunidades__dbcontratos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbconvenios_descontos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbconvenios_descontos
    ADD CONSTRAINT fk_dbunidades__dbconvenios_descontos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbcotacoes__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcotacoes
    ADD CONSTRAINT fk_dbunidades__dbcotacoes__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbcrm_demandas__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcrm_demandas
    ADD CONSTRAINT fk_dbunidades__dbcrm_demandas__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbcurriculos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcurriculos
    ADD CONSTRAINT fk_dbunidades__dbcurriculos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbcursos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcursos
    ADD CONSTRAINT fk_dbunidades__dbcursos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbcursos_areas__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcursos_areas
    ADD CONSTRAINT fk_dbunidades__dbcursos_areas__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbcursos_ativos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcursos_ativos
    ADD CONSTRAINT fk_dbunidades__dbcursos_ativos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbcursos_avaliacoes__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcursos_avaliacoes
    ADD CONSTRAINT fk_dbunidades__dbcursos_avaliacoes__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbcursos_disciplinas__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcursos_disciplinas
    ADD CONSTRAINT fk_dbunidades__dbcursos_disciplinas__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbcursos_tipos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcursos_tipos
    ADD CONSTRAINT fk_dbunidades__dbcursos_tipos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbdados_boleto__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbdados_boleto
    ADD CONSTRAINT fk_dbunidades__dbdados_boleto__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbdepartamentos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbdepartamentos
    ADD CONSTRAINT fk_dbunidades__dbdepartamentos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbdisciplinas__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbdisciplinas
    ADD CONSTRAINT fk_dbunidades__dbdisciplinas__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbdisciplinas_semelhantes__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbdisciplinas_semelhantes
    ADD CONSTRAINT fk_dbunidades__dbdisciplinas_semelhantes__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbdocumentos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbdocumentos
    ADD CONSTRAINT fk_dbunidades__dbdocumentos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbfuncionarios_ferias__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfuncionarios_ferias
    ADD CONSTRAINT fk_dbunidades__dbfuncionarios_ferias__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbfuncionarios_folhapagamento__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfuncionarios_folhapagamento
    ADD CONSTRAINT fk_dbunidades__dbfuncionarios_folhapagamento__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbfuncionarios_ocorrencias__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfuncionarios_ocorrencias
    ADD CONSTRAINT fk_dbunidades__dbfuncionarios_ocorrencias__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbfuncionarios_professores__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfuncionarios_professores
    ADD CONSTRAINT fk_dbunidades__dbfuncionarios_professores__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbfuncionarios_treinamentos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfuncionarios_treinamentos
    ADD CONSTRAINT fk_dbunidades__dbfuncionarios_treinamentos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbpatrimonios__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpatrimonios
    ADD CONSTRAINT fk_dbunidades__dbpatrimonios__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbpatrimonios_livros__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpatrimonios_livros
    ADD CONSTRAINT fk_dbunidades__dbpatrimonios_livros__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbpessoas__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas
    ADD CONSTRAINT fk_dbunidades__dbpessoas__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbpessoas_alunos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_alunos
    ADD CONSTRAINT fk_dbunidades__dbpessoas_alunos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbpessoas_complemento_pf__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_complemento_pf
    ADD CONSTRAINT fk_dbunidades__dbpessoas_complemento_pf__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbpessoas_complemento_pj__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_complemento_pj
    ADD CONSTRAINT fk_dbunidades__dbpessoas_complemento_pj__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbpessoas_convenios__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_convenios
    ADD CONSTRAINT fk_dbunidades__dbpessoas_convenios__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbpessoas_demandas__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_demandas
    ADD CONSTRAINT fk_dbunidades__dbpessoas_demandas__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbpessoas_enderecoscobrancas__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_enderecoscobrancas
    ADD CONSTRAINT fk_dbunidades__dbpessoas_enderecoscobrancas__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbpessoas_formacoes__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_formacoes
    ADD CONSTRAINT fk_dbunidades__dbpessoas_formacoes__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbpessoas_funcionarios__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_funcionarios
    ADD CONSTRAINT fk_dbunidades__dbpessoas_funcionarios__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbpessoas_inscricoes__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_inscricoes
    ADD CONSTRAINT fk_dbunidades__dbpessoas_inscricoes__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbpessoas_livros__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_livros
    ADD CONSTRAINT fk_dbunidades__dbpessoas_livros__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbpessoas_solicitacoes__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_solicitacoes
    ADD CONSTRAINT fk_dbunidades__dbpessoas_solicitacoes__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbpessoas_titularidades__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoas_titularidades
    ADD CONSTRAINT fk_dbunidades__dbpessoas_titularidades__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbplano_contas__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbplano_contas
    ADD CONSTRAINT fk_dbunidades__dbplano_contas__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbprocessos_academicos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprocessos_academicos
    ADD CONSTRAINT fk_dbunidades__dbprocessos_academicos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbprodutos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprodutos
    ADD CONSTRAINT fk_dbunidades__dbprodutos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbprodutos_insumos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprodutos_caracteristicas
    ADD CONSTRAINT fk_dbunidades__dbprodutos_insumos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbprodutos_parametros__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprodutos_parametros
    ADD CONSTRAINT fk_dbunidades__dbprodutos_parametros__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbprodutos_tabelapreco__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprodutos_tabelapreco
    ADD CONSTRAINT fk_dbunidades__dbprodutos_tabelapreco__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbprodutos_tipos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprodutos_tipos
    ADD CONSTRAINT fk_dbunidades__dbprodutos_tipos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbprodutos_tributos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprodutos_tributos
    ADD CONSTRAINT fk_dbunidades__dbprodutos_tributos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbprofessores_areas__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprofessores_areas
    ADD CONSTRAINT fk_dbunidades__dbprofessores_areas__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbprojetos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprojetos
    ADD CONSTRAINT fk_dbunidades__dbprojetos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbprojetos_colaboradores__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprojetos_colaboradores
    ADD CONSTRAINT fk_dbunidades__dbprojetos_colaboradores__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbprojetos_custos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprojetos_custos
    ADD CONSTRAINT fk_dbunidades__dbprojetos_custos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbprojetos_recursos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprojetos_recursos
    ADD CONSTRAINT fk_dbunidades__dbprojetos_recursos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbquestionarios__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbquestionarios
    ADD CONSTRAINT fk_dbunidades__dbquestionarios__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbquestoes__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbquestoes
    ADD CONSTRAINT fk_dbunidades__dbquestoes__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbquestoes_itens__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbquestoes_itens
    ADD CONSTRAINT fk_dbunidades__dbquestoes_itens__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbsalas__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbsalas
    ADD CONSTRAINT fk_dbunidades__dbsalas__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbscorecard__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbscorecard
    ADD CONSTRAINT fk_dbunidades__dbscorecard__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbscorecard_sentencas__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbscorecard_sentencas
    ADD CONSTRAINT fk_dbunidades__dbscorecard_sentencas__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbtransacoes__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes
    ADD CONSTRAINT fk_dbunidades__dbtransacoes__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbtransacoes_contas__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes_contas
    ADD CONSTRAINT fk_dbunidades__dbtransacoes_contas__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbtransacoes_contas_extornos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes_contas_extornos
    ADD CONSTRAINT fk_dbunidades__dbtransacoes_contas_extornos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbtransacoes_convenios__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes_convenios
    ADD CONSTRAINT fk_dbunidades__dbtransacoes_convenios__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbtransacoes_produtos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes_produtos
    ADD CONSTRAINT fk_dbunidades__dbtransacoes_produtos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbtreinamentos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtreinamentos
    ADD CONSTRAINT fk_dbunidades__dbtreinamentos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbtributos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtributos
    ADD CONSTRAINT fk_dbunidades__dbtributos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbturmas__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas
    ADD CONSTRAINT fk_dbunidades__dbturmas__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbturmas_convenios__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_convenios
    ADD CONSTRAINT fk_dbunidades__dbturmas_convenios__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbturmas_descontos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_descontos
    ADD CONSTRAINT fk_dbunidades__dbturmas_descontos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbturmas_disciplinas__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas
    ADD CONSTRAINT fk_dbunidades__dbturmas_disciplinas__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbturmas_disciplinas_arquivos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas_arquivos
    ADD CONSTRAINT fk_dbunidades__dbturmas_disciplinas_arquivos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbturmas_disciplinas_aulas__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas_aulas
    ADD CONSTRAINT fk_dbunidades__dbturmas_disciplinas_aulas__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbturmas_disciplinas_avaliacao_detalhamento__uni; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas_avaliacao_detalhamento
    ADD CONSTRAINT fk_dbunidades__dbturmas_disciplinas_avaliacao_detalhamento__uni FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbturmas_disciplinas_avaliacoes__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas_avaliacoes
    ADD CONSTRAINT fk_dbunidades__dbturmas_disciplinas_avaliacoes__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbturmas_disciplinas_materiais__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas_materiais
    ADD CONSTRAINT fk_dbunidades__dbturmas_disciplinas_materiais__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbturmas_disciplinas_planoaulas__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_disciplinas_planoaulas
    ADD CONSTRAINT fk_dbunidades__dbturmas_disciplinas_planoaulas__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbturmas_requisitos__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturmas_requisitos
    ADD CONSTRAINT fk_dbunidades__dbturmas_requisitos__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbunidades_parametros__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbunidades_parametros
    ADD CONSTRAINT fk_dbunidades__dbunidades_parametros__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbusuarios__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbusuarios
    ADD CONSTRAINT fk_dbunidades__dbusuarios__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbusuarios_erros__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbusuarios_erros
    ADD CONSTRAINT fk_dbunidades__dbusuarios_erros__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbusuarios_historico__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbusuarios_historico
    ADD CONSTRAINT fk_dbunidades__dbusuarios_historico__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbusuarios_privilegios__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbusuarios_privilegios
    ADD CONSTRAINT fk_dbunidades__dbusuarios_privilegios__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades__dbusuarios_senhas_recuperacao__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbusuarios_senhas_recuperacao
    ADD CONSTRAINT fk_dbunidades__dbusuarios_senhas_recuperacao__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbunidades_dbtransacoes_contas_duplicatas__unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacoes_contas_duplicatas
    ADD CONSTRAINT fk_dbunidades_dbtransacoes_contas_duplicatas__unidade FOREIGN KEY (unidade) REFERENCES dbunidades(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbusuarios__dbusuarios_erros__codigousuario; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbusuarios_erros
    ADD CONSTRAINT fk_dbusuarios__dbusuarios_erros__codigousuario FOREIGN KEY (codigousuario) REFERENCES dbusuarios(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbusuarios__dbusuarios_historico__codigousuario; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbusuarios_historico
    ADD CONSTRAINT fk_dbusuarios__dbusuarios_historico__codigousuario FOREIGN KEY (codigousuario) REFERENCES dbusuarios(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbusuarios__dbusuarios_privilegios__codigousuario; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbusuarios_privilegios
    ADD CONSTRAINT fk_dbusuarios__dbusuarios_privilegios__codigousuario FOREIGN KEY (codigousuario) REFERENCES dbusuarios(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_dbusuarios__dbusuarios_senhas_recuperacao__codigousuario; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbusuarios_senhas_recuperacao
    ADD CONSTRAINT fk_dbusuarios__dbusuarios_senhas_recuperacao__codigousuario FOREIGN KEY (codigousuario) REFERENCES dbusuarios(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: pk_dbavaliacoes__dbalunos_notas_codigoavaliacao; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbalunos_notas
    ADD CONSTRAINT pk_dbavaliacoes__dbalunos_notas_codigoavaliacao FOREIGN KEY (codigoavaliacao) REFERENCES dbavaliacoes(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

