--
-- PostgreSQL database dump
--

-- Dumped from database version 9.2.4
-- Dumped by pg_dump version 9.2.2
-- Started on 2013-06-13 13:57:05 BRT

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 208 (class 3079 OID 11995)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2459 (class 0 OID 0)
-- Dependencies: 208
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_with_oids = false;

CREATE TABLE dbunidades
(
  id serial NOT NULL,
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
  usuaseq integer,
  unidseq integer,
  datacad date,
  ativo integer
);

CREATE TABLE dbunidades_parametros
(
  id serial NOT NULL,
  unidade character varying(30),
  codigoautor character varying(20) NOT NULL DEFAULT '0000'::character varying,
  parametro character varying(60),
  valor character varying(180),
  obs text,
  usuaseq integer,
  unidseq integer,
  datacad date,
  ativo integer
);

CREATE TABLE dbpessoas
(
  id serial NOT NULL,
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
  opcobranca character varying(20) NOT NULL DEFAULT '1'::character varying,
  cliente character varying(1) DEFAULT '0'::character varying,
  fornecedor character varying(1) DEFAULT '0'::character varying,
  funcionario character varying(1) DEFAULT '0'::character varying,
  foto text,
  usuaseq integer,
  unidseq integer,
  datacad date,
  ativo integer
);

CREATE TABLE dbusuarios
(
  id serial NOT NULL,
  classeuser character varying(20),
  pessseq character varying(30),
  usuario character varying(80) NOT NULL DEFAULT 'user'::character varying,
  senha character varying(60),
  entidadepai character varying(255),
  codigotema character varying(20) NOT NULL DEFAULT '0'::character varying,
  lastip character varying(80),
  lastaccess character varying(30),
  lastpass character varying(30),
  usuaseq integer,
  unidseq integer,
  datacad date,
  ativo integer
);

-- Table: dbusuarios_privilegios

-- DROP TABLE dbusuarios_privilegios;

CREATE TABLE dbusuarios_privilegios
(
  id serial NOT NULL,
  codigousuario character varying(30),
  funcionalidade integer DEFAULT 0,
  modulo integer,
  nivel integer NOT NULL DEFAULT 0,
  usuaseq integer,
  unidseq integer,
  datacad date,
  ativo integer
);

COMMENT ON COLUMN dbusuarios_privilegios.funcionalidade IS 'Id da funcionalidade sobre a qual o privilegio se associa.
Caso a funcionalidade seja o modulo principal o valor padrão é [0]';
COMMENT ON COLUMN dbusuarios_privilegios.nivel IS 'Nivel de acesso na hierarquia do sistema

0 = módulo principal
1 = módulos secundários
2 = opções da lista
       1 = adicionar
       2 = editar
       3 = excluir
       4 = Aceita replicação
       5 = Aceita Seleção
       6 = Visualizar Apêndice

9 = Opções de sublista
       1 = adicionar
       2 = editar
       3 = excluir
       4 = Aceita replicação
       5 = Aceita Seleção
       6 = Visualizar Apêndice
       

';

--
-- TOC entry 168 (class 1259 OID 46167)
-- Name: abas; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE abas (
    id integer NOT NULL,
    idaba character varying(30),
    nomeaba character varying(40),
    obapendice character varying(110) DEFAULT '-'::character varying NOT NULL,
    action character varying(200) DEFAULT '-'::character varying NOT NULL,
    impressao character(1) DEFAULT '0'::bpchar,
    ordem integer DEFAULT 0,
    usuaseq integer,
    unidseq integer,
    datacad date,
    ativo integer
);


--
-- TOC entry 169 (class 1259 OID 46174)
-- Name: abas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE abas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2460 (class 0 OID 0)
-- Dependencies: 169
-- Name: abas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE abas_id_seq OWNED BY abas.id;


--
-- TOC entry 170 (class 1259 OID 46176)
-- Name: blocos; Type: TABLE; Schema: public; Owner: -
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
    idform character varying(30),
    usuaseq integer,
    unidseq integer,
    datacad date
);


--
-- TOC entry 2461 (class 0 OID 0)
-- Dependencies: 170
-- Name: COLUMN blocos.obapendice; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN blocos.obapendice IS 'refenrencia um apêndice para o bloco
classe/metodo

ps. o metodo chamado como apêndice deve retornar sempre um objeto TElement válido';


--
-- TOC entry 171 (class 1259 OID 46186)
-- Name: blocos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE blocos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2462 (class 0 OID 0)
-- Dependencies: 171
-- Name: blocos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE blocos_id_seq OWNED BY blocos.id;


--
-- TOC entry 172 (class 1259 OID 46188)
-- Name: blocos_x_abas; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE blocos_x_abas (
    id integer NOT NULL,
    abaid integer,
    blocoid integer,
    ordem integer DEFAULT 1,
    usuaseq integer,
    unidseq integer,
    datacad date,
    ativo integer
);


--
-- TOC entry 173 (class 1259 OID 46192)
-- Name: blocos_x_abas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE blocos_x_abas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2463 (class 0 OID 0)
-- Dependencies: 173
-- Name: blocos_x_abas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE blocos_x_abas_id_seq OWNED BY blocos_x_abas.id;


--
-- TOC entry 174 (class 1259 OID 46194)
-- Name: campos; Type: TABLE; Schema: public; Owner: -
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
    autosave character varying(1) DEFAULT 0,
    usuaseq integer,
    unidseq integer,
    datacad date
);


--
-- TOC entry 2464 (class 0 OID 0)
-- Dependencies: 174
-- Name: COLUMN campos.trigger; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN campos.trigger IS 'função a ser executada quando o campo for carregado';


--
-- TOC entry 2465 (class 0 OID 0)
-- Dependencies: 174
-- Name: COLUMN campos.autosave; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN campos.autosave IS 'Esepecifica se o campo vai ter a capacidade de disparar a função de onSave no formulário.
0 = not autoSave
1 = yes autoSave';


--
-- TOC entry 175 (class 1259 OID 46208)
-- Name: campos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE campos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2466 (class 0 OID 0)
-- Dependencies: 175
-- Name: campos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE campos_id_seq OWNED BY campos.id;


--
-- TOC entry 176 (class 1259 OID 46210)
-- Name: campos_x_blocos; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE campos_x_blocos (
    id integer NOT NULL,
    blocoid integer,
    campoid integer,
    mostrarcampo character(1),
    formato character(3),
    ordem integer DEFAULT 0 NOT NULL,
    usuaseq integer,
    unidseq integer,
    datacad date,
    ativo integer
);


--
-- TOC entry 177 (class 1259 OID 46214)
-- Name: campos_x_blocos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE campos_x_blocos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2467 (class 0 OID 0)
-- Dependencies: 177
-- Name: campos_x_blocos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE campos_x_blocos_id_seq OWNED BY campos_x_blocos.id;


--
-- TOC entry 178 (class 1259 OID 46216)
-- Name: campos_x_propriedades_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE campos_x_propriedades_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 179 (class 1259 OID 46218)
-- Name: campos_x_propriedades; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE campos_x_propriedades (
    campoid integer NOT NULL,
    metodo character varying(30) NOT NULL,
    valor text NOT NULL,
    ativo integer DEFAULT 1 NOT NULL,
    id integer DEFAULT nextval('campos_x_propriedades_id_seq'::regclass) NOT NULL,
    usuaseq integer,
    unidseq integer,
    datacad date
);


--
-- TOC entry 2468 (class 0 OID 0)
-- Dependencies: 179
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
-- TOC entry 180 (class 1259 OID 46226)
-- Name: form_button; Type: TABLE; Schema: public; Owner: -
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
    ativo character(1) DEFAULT '1'::bpchar,
    usuaseq integer,
    unidseq integer,
    datacad date
);


--
-- TOC entry 181 (class 1259 OID 46234)
-- Name: form_button_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE form_button_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2469 (class 0 OID 0)
-- Dependencies: 181
-- Name: form_button_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE form_button_id_seq OWNED BY form_button.id;


--
-- TOC entry 182 (class 1259 OID 46236)
-- Name: form_validacao; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE form_validacao (
    id integer NOT NULL,
    formid integer DEFAULT 0,
    usuaseq integer,
    unidseq integer,
    datacad date,
    ativo integer
);


--
-- TOC entry 183 (class 1259 OID 46240)
-- Name: form_validacao_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE form_validacao_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2470 (class 0 OID 0)
-- Dependencies: 183
-- Name: form_validacao_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE form_validacao_id_seq OWNED BY form_validacao.id;


--
-- TOC entry 184 (class 1259 OID 46242)
-- Name: form_x_abas; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE form_x_abas (
    id integer NOT NULL,
    formid integer,
    abaid integer,
    ativo character(1) DEFAULT '1'::bpchar,
    ordem integer DEFAULT 0,
    usuaseq integer,
    unidseq integer,
    datacad date
);


--
-- TOC entry 185 (class 1259 OID 46247)
-- Name: form_x_abas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE form_x_abas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2471 (class 0 OID 0)
-- Dependencies: 185
-- Name: form_x_abas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE form_x_abas_id_seq OWNED BY form_x_abas.id;


--
-- TOC entry 186 (class 1259 OID 46249)
-- Name: form_x_tabelas; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE form_x_tabelas (
    id integer NOT NULL,
    formid integer,
    tabelaid integer,
    ativo character(1) DEFAULT '1'::bpchar,
    usuaseq integer,
    unidseq integer,
    datacad date
);


--
-- TOC entry 187 (class 1259 OID 46253)
-- Name: form_x_tabelas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE form_x_tabelas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2472 (class 0 OID 0)
-- Dependencies: 187
-- Name: form_x_tabelas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE form_x_tabelas_id_seq OWNED BY form_x_tabelas.id;


--
-- TOC entry 188 (class 1259 OID 46255)
-- Name: forms; Type: TABLE; Schema: public; Owner: -
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
    autosave character varying(1) DEFAULT 1 NOT NULL,
    usuaseq integer,
    unidseq integer,
    datacad date
);


--
-- TOC entry 2473 (class 0 OID 0)
-- Dependencies: 188
-- Name: COLUMN forms.dimensao; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN forms.dimensao IS 'dimenção da janela do form
largura;altura';


--
-- TOC entry 2474 (class 0 OID 0)
-- Dependencies: 188
-- Name: COLUMN forms.botconcluir; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN forms.botconcluir IS 'Habilita ou desabilita o botão padrão do formulário.
0 = desabilitado
1 = ativado
2 = desativado';


--
-- TOC entry 2475 (class 0 OID 0)
-- Dependencies: 188
-- Name: COLUMN forms.botcancelar; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN forms.botcancelar IS 'Habilita ou desabilita o botão padrão [cancelar] do formulário.
0 = desabilitado
1 = ativado
2 = desativado';


--
-- TOC entry 189 (class 1259 OID 46264)
-- Name: forms_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE forms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2476 (class 0 OID 0)
-- Dependencies: 189
-- Name: forms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE forms_id_seq OWNED BY forms.id;


--
-- TOC entry 190 (class 1259 OID 46266)
-- Name: info_empresa; Type: TABLE; Schema: public; Owner: -
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
    tipo character(3),
    usuaseq integer,
    unidseq integer,
    datacad date,
    ativo integer
);


--
-- TOC entry 191 (class 1259 OID 46272)
-- Name: info_empresa_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE info_empresa_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2477 (class 0 OID 0)
-- Dependencies: 191
-- Name: info_empresa_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE info_empresa_id_seq OWNED BY info_empresa.id;


--
-- TOC entry 192 (class 1259 OID 46274)
-- Name: lista_actions; Type: TABLE; Schema: public; Owner: -
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
    tiporetorno character varying(6),
    usuaseq integer,
    unidseq integer,
    datacad date
);


--
-- TOC entry 193 (class 1259 OID 46288)
-- Name: lista_actions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE lista_actions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2478 (class 0 OID 0)
-- Dependencies: 193
-- Name: lista_actions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE lista_actions_id_seq OWNED BY lista_actions.id;


--
-- TOC entry 194 (class 1259 OID 46290)
-- Name: lista_bnav; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE lista_bnav (
    id integer NOT NULL,
    lista_form_id integer DEFAULT 0 NOT NULL,
    nome character varying(40),
    tipocampo character varying(30),
    label character varying(60),
    metodo character varying(40),
    funcaojs character varying(50),
    argumento character varying DEFAULT 0,
    usuaseq integer,
    unidseq integer,
    datacad date,
    ativo integer
);


--
-- TOC entry 195 (class 1259 OID 46298)
-- Name: lista_bnav_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE lista_bnav_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2479 (class 0 OID 0)
-- Dependencies: 195
-- Name: lista_bnav_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE lista_bnav_id_seq OWNED BY lista_bnav.id;


--
-- TOC entry 196 (class 1259 OID 46300)
-- Name: lista_colunas; Type: TABLE; Schema: public; Owner: -
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
    ativo character(1) DEFAULT '1'::bpchar,
    usuaseq integer,
    unidseq integer,
    datacad date
);


--
-- TOC entry 197 (class 1259 OID 46315)
-- Name: lista_colunas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE lista_colunas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2480 (class 0 OID 0)
-- Dependencies: 197
-- Name: lista_colunas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE lista_colunas_id_seq OWNED BY lista_colunas.id;


--
-- TOC entry 198 (class 1259 OID 46317)
-- Name: lista_fields; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE lista_fields (
    id integer NOT NULL,
    idlista integer DEFAULT 0 NOT NULL,
    nomecol character varying(70) DEFAULT '-'::character varying NOT NULL,
    labelcol character varying(60),
    idcampo integer DEFAULT 0 NOT NULL,
    ordem integer DEFAULT 0 NOT NULL,
    ativo character(1) DEFAULT '1'::bpchar NOT NULL,
    usuaseq integer,
    unidseq integer,
    datacad date
);


--
-- TOC entry 199 (class 1259 OID 46325)
-- Name: lista_fields_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE lista_fields_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2481 (class 0 OID 0)
-- Dependencies: 199
-- Name: lista_fields_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE lista_fields_id_seq OWNED BY lista_fields.id;


--
-- TOC entry 200 (class 1259 OID 46327)
-- Name: lista_form; Type: TABLE; Schema: public; Owner: -
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
    ordem character varying(250) DEFAULT 'datacad/desc;id/desc'::character varying,
    aclimite character varying(1) DEFAULT 1,
    usuaseq integer,
    unidseq integer,
    datacad date
);


--
-- TOC entry 2482 (class 0 OID 0)
-- Dependencies: 200
-- Name: COLUMN lista_form.pesquisa; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN lista_form.pesquisa IS 'padrão dos argumentos de retorno da pesquisa.

campo do formulário=coluna entidade[>coluna label],campo do formulário=coluna entidade[>coluna label]';


--
-- TOC entry 2483 (class 0 OID 0)
-- Dependencies: 200
-- Name: COLUMN lista_form.filtro; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN lista_form.filtro IS 'pos 0 = coluna table
pos 1 = operador logico(=,like,>, etc) pos 2 = operador condicional(OR - AND)
pos 3 = classe ou valor fixo
pos 4 = metodo se o pos 3 for uma classe
pos 5 = se o metodo da classe vai receber o idLista ou não

(O metodo passado como filhtro deve retornar um valor valido e não dever receber nenhum paramentro)';


--
-- TOC entry 2484 (class 0 OID 0)
-- Dependencies: 200
-- Name: COLUMN lista_form.formainclude; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN lista_form.formainclude IS 'define a forma de inclusão da lista (unitaria) ou (multipla)';


--
-- TOC entry 2485 (class 0 OID 0)
-- Dependencies: 200
-- Name: COLUMN lista_form.trigger; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN lista_form.trigger IS 'Ações [JavaScript] a serem executadas quando a lista for carregada ou recarregada

';


--
-- TOC entry 2486 (class 0 OID 0)
-- Dependencies: 200
-- Name: COLUMN lista_form.incontrol; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN lista_form.incontrol IS 'Regras de negócio a serem aplicadas nas ações da lista.
Ex: botão adicionar, excluir, editar
padrão de execução TSetControl';


--
-- TOC entry 2487 (class 0 OID 0)
-- Dependencies: 200
-- Name: COLUMN lista_form.ordem; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN lista_form.ordem IS 'Padrão: (coluna)/(ordenação)?
Ex: id/desc;datacad';


--
-- TOC entry 201 (class 1259 OID 46348)
-- Name: lista_form_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE lista_form_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2488 (class 0 OID 0)
-- Dependencies: 201
-- Name: lista_form_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE lista_form_id_seq OWNED BY lista_form.id;


--
-- TOC entry 202 (class 1259 OID 46350)
-- Name: menu_modulos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE menu_modulos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 203 (class 1259 OID 46352)
-- Name: menu_modulos; Type: TABLE; Schema: public; Owner: -
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
    ativo character(1) DEFAULT '1'::bpchar,
    usuaseq integer,
    unidseq integer,
    datacad date
);


--
-- TOC entry 204 (class 1259 OID 46361)
-- Name: modulos_principais; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE modulos_principais (
    id integer NOT NULL,
    modulo character varying(60),
    labelmodulo character varying(80),
    nivel integer,
    ordem integer DEFAULT 0,
    ativo character(1) DEFAULT '1'::bpchar,
    usuaseq integer,
    unidseq integer,
    datacad date
);


--
-- TOC entry 205 (class 1259 OID 46366)
-- Name: modulos_principais_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE modulos_principais_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2489 (class 0 OID 0)
-- Dependencies: 205
-- Name: modulos_principais_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE modulos_principais_id_seq OWNED BY modulos_principais.id;


--
-- TOC entry 206 (class 1259 OID 46368)
-- Name: tabelas; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE tabelas (
    id integer NOT NULL,
    tabela character varying(120) NOT NULL,
    tabela_view character varying(120) DEFAULT '-'::character varying NOT NULL,
    tabpai character varying(120) DEFAULT '-'::character varying NOT NULL,
    ativo integer DEFAULT 1 NOT NULL,
    colunafilho character varying(40),
    usuaseq integer,
    unidseq integer,
    datacad date
);


--
-- TOC entry 2490 (class 0 OID 0)
-- Dependencies: 206
-- Name: COLUMN tabelas.colunafilho; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN tabelas.colunafilho IS 'Nome da coluna necessar para todos os filhos da tabela em questão';


--
-- TOC entry 207 (class 1259 OID 46374)
-- Name: tabelas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE tabelas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2491 (class 0 OID 0)
-- Dependencies: 207
-- Name: tabelas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE tabelas_id_seq OWNED BY tabelas.id;


--
-- TOC entry 2309 (class 2604 OID 46376)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY abas ALTER COLUMN id SET DEFAULT nextval('abas_id_seq'::regclass);


--
-- TOC entry 2314 (class 2604 OID 46377)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY blocos ALTER COLUMN id SET DEFAULT nextval('blocos_id_seq'::regclass);


--
-- TOC entry 2316 (class 2604 OID 46378)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY blocos_x_abas ALTER COLUMN id SET DEFAULT nextval('blocos_x_abas_id_seq'::regclass);


--
-- TOC entry 2325 (class 2604 OID 46379)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY campos ALTER COLUMN id SET DEFAULT nextval('campos_id_seq'::regclass);


--
-- TOC entry 2327 (class 2604 OID 46380)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY campos_x_blocos ALTER COLUMN id SET DEFAULT nextval('campos_x_blocos_id_seq'::regclass);


--
-- TOC entry 2332 (class 2604 OID 46381)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY form_button ALTER COLUMN id SET DEFAULT nextval('form_button_id_seq'::regclass);


--
-- TOC entry 2334 (class 2604 OID 46382)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY form_validacao ALTER COLUMN id SET DEFAULT nextval('form_validacao_id_seq'::regclass);


--
-- TOC entry 2337 (class 2604 OID 46383)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY form_x_abas ALTER COLUMN id SET DEFAULT nextval('form_x_abas_id_seq'::regclass);


--
-- TOC entry 2339 (class 2604 OID 46384)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY form_x_tabelas ALTER COLUMN id SET DEFAULT nextval('form_x_tabelas_id_seq'::regclass);


--
-- TOC entry 2346 (class 2604 OID 46385)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY forms ALTER COLUMN id SET DEFAULT nextval('forms_id_seq'::regclass);


--
-- TOC entry 2347 (class 2604 OID 46386)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY info_empresa ALTER COLUMN id SET DEFAULT nextval('info_empresa_id_seq'::regclass);


--
-- TOC entry 2356 (class 2604 OID 46387)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY lista_actions ALTER COLUMN id SET DEFAULT nextval('lista_actions_id_seq'::regclass);


--
-- TOC entry 2359 (class 2604 OID 46388)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY lista_bnav ALTER COLUMN id SET DEFAULT nextval('lista_bnav_id_seq'::regclass);


--
-- TOC entry 2369 (class 2604 OID 46389)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY lista_colunas ALTER COLUMN id SET DEFAULT nextval('lista_colunas_id_seq'::regclass);


--
-- TOC entry 2375 (class 2604 OID 46390)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY lista_fields ALTER COLUMN id SET DEFAULT nextval('lista_fields_id_seq'::regclass);


--
-- TOC entry 2399 (class 2604 OID 46391)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY modulos_principais ALTER COLUMN id SET DEFAULT nextval('modulos_principais_id_seq'::regclass);


--
-- TOC entry 2403 (class 2604 OID 46392)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY tabelas ALTER COLUMN id SET DEFAULT nextval('tabelas_id_seq'::regclass);


--
-- TOC entry 2405 (class 2606 OID 46394)
-- Name: pk_abas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY abas
    ADD CONSTRAINT pk_abas PRIMARY KEY (id);


--
-- TOC entry 2407 (class 2606 OID 46396)
-- Name: pk_blocos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY blocos
    ADD CONSTRAINT pk_blocos PRIMARY KEY (id);


--
-- TOC entry 2409 (class 2606 OID 46398)
-- Name: pk_blocos_x_abas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY blocos_x_abas
    ADD CONSTRAINT pk_blocos_x_abas PRIMARY KEY (id);


--
-- TOC entry 2412 (class 2606 OID 46400)
-- Name: pk_campos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY campos
    ADD CONSTRAINT pk_campos PRIMARY KEY (id);


--
-- TOC entry 2415 (class 2606 OID 46402)
-- Name: pk_campos_x_blocos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY campos_x_blocos
    ADD CONSTRAINT pk_campos_x_blocos PRIMARY KEY (id);


--
-- TOC entry 2418 (class 2606 OID 46404)
-- Name: pk_campos_x_propriedades; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY campos_x_propriedades
    ADD CONSTRAINT pk_campos_x_propriedades PRIMARY KEY (id);


--
-- TOC entry 2420 (class 2606 OID 46406)
-- Name: pk_form_button; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY form_button
    ADD CONSTRAINT pk_form_button PRIMARY KEY (id);


--
-- TOC entry 2422 (class 2606 OID 46408)
-- Name: pk_form_validacao; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY form_validacao
    ADD CONSTRAINT pk_form_validacao PRIMARY KEY (id);


--
-- TOC entry 2424 (class 2606 OID 46410)
-- Name: pk_form_x_abas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY form_x_abas
    ADD CONSTRAINT pk_form_x_abas PRIMARY KEY (id);


--
-- TOC entry 2426 (class 2606 OID 46412)
-- Name: pk_form_x_tabelas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY form_x_tabelas
    ADD CONSTRAINT pk_form_x_tabelas PRIMARY KEY (id);


--
-- TOC entry 2428 (class 2606 OID 46414)
-- Name: pk_forms; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY forms
    ADD CONSTRAINT pk_forms PRIMARY KEY (id);


--
-- TOC entry 2430 (class 2606 OID 46416)
-- Name: pk_info_empresa; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY info_empresa
    ADD CONSTRAINT pk_info_empresa PRIMARY KEY (id);


--
-- TOC entry 2433 (class 2606 OID 46418)
-- Name: pk_lista_actions; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY lista_actions
    ADD CONSTRAINT pk_lista_actions PRIMARY KEY (id);


--
-- TOC entry 2435 (class 2606 OID 46420)
-- Name: pk_lista_bnav; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY lista_bnav
    ADD CONSTRAINT pk_lista_bnav PRIMARY KEY (id);


--
-- TOC entry 2438 (class 2606 OID 46422)
-- Name: pk_lista_colunas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY lista_colunas
    ADD CONSTRAINT pk_lista_colunas PRIMARY KEY (id);


--
-- TOC entry 2440 (class 2606 OID 46424)
-- Name: pk_lista_fields; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY lista_fields
    ADD CONSTRAINT pk_lista_fields PRIMARY KEY (id);


--
-- TOC entry 2443 (class 2606 OID 46426)
-- Name: pk_lista_form; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY lista_form
    ADD CONSTRAINT pk_lista_form PRIMARY KEY (id);


--
-- TOC entry 2446 (class 2606 OID 46428)
-- Name: pk_menu_modulos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY menu_modulos
    ADD CONSTRAINT pk_menu_modulos PRIMARY KEY (id);


--
-- TOC entry 2448 (class 2606 OID 46430)
-- Name: pk_modulos_principais; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY modulos_principais
    ADD CONSTRAINT pk_modulos_principais PRIMARY KEY (id);


--
-- TOC entry 2450 (class 2606 OID 46432)
-- Name: pk_tabelas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tabelas
    ADD CONSTRAINT pk_tabelas PRIMARY KEY (id);


--
-- TOC entry 2431 (class 1259 OID 46433)
-- Name: fki_lista_actions__lista_form__idlista; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_lista_actions__lista_form__idlista ON lista_actions USING btree (idlista);


--
-- TOC entry 2444 (class 1259 OID 46434)
-- Name: fki_menu_modulos__lista_form__lista; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_menu_modulos__lista_form__lista ON menu_modulos USING btree (argumento);


--
-- TOC entry 2413 (class 1259 OID 46435)
-- Name: idx_campos_blocos; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_campos_blocos ON campos_x_blocos USING btree (blocoid, campoid);


--
-- TOC entry 2410 (class 1259 OID 46436)
-- Name: idx_campos_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_campos_id ON campos USING btree (id);


--
-- TOC entry 2416 (class 1259 OID 46437)
-- Name: idx_campos_propriedades; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_campos_propriedades ON campos_x_propriedades USING btree (campoid);


--
-- TOC entry 2436 (class 1259 OID 46438)
-- Name: lista_colunas_listacolunas_fkindex1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX lista_colunas_listacolunas_fkindex1 ON lista_colunas USING btree (lista_form_id);


--
-- TOC entry 2441 (class 1259 OID 46439)
-- Name: lista_form_formlista_fkindex1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX lista_form_formlista_fkindex1 ON lista_form USING btree (forms_id);


--
-- TOC entry 2451 (class 2606 OID 46440)
-- Name: lista_actions__lista_form__idlista; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY lista_actions
    ADD CONSTRAINT lista_actions__lista_form__idlista FOREIGN KEY (idlista) REFERENCES lista_form(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2452 (class 2606 OID 46445)
-- Name: lista_colunas__lista_form; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY lista_colunas
    ADD CONSTRAINT lista_colunas__lista_form FOREIGN KEY (lista_form_id) REFERENCES lista_form(id) ON UPDATE CASCADE ON DELETE CASCADE;


-- Completed on 2013-06-13 13:57:05 BRT

--
-- PostgreSQL database dump complete
--

