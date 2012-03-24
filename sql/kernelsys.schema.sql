--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_with_oids = false;

--
-- Name: abas; Type: TABLE; Schema: public; Owner: -
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
-- Name: abas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE abas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: abas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE abas_id_seq OWNED BY abas.id;


--
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
    idform character varying(30)
);


--
-- Name: COLUMN blocos.obapendice; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN blocos.obapendice IS 'refenrencia um apêndice para o bloco
classe/metodo

ps. o metodo chamado como apêndice deve retornar sempre um objeto TElement válido';


--
-- Name: blocos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE blocos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: blocos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE blocos_id_seq OWNED BY blocos.id;


--
-- Name: blocos_x_abas; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE blocos_x_abas (
    id integer NOT NULL,
    abaid integer,
    blocoid integer,
    ordem integer DEFAULT 1
);


--
-- Name: blocos_x_abas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE blocos_x_abas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: blocos_x_abas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE blocos_x_abas_id_seq OWNED BY blocos_x_abas.id;


--
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
    autosave character varying(1) DEFAULT 0
);


--
-- Name: COLUMN campos.trigger; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN campos.trigger IS 'função a ser executada quando o campo for carregado';


--
-- Name: COLUMN campos.autosave; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN campos.autosave IS 'Esepecifica se o campo vai ter a capacidade de disparar a função de onSave no formulário.
0 = not autoSave
1 = yes autoSave';


--
-- Name: campos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE campos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: campos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE campos_id_seq OWNED BY campos.id;


--
-- Name: campos_x_blocos; Type: TABLE; Schema: public; Owner: -
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
-- Name: campos_x_blocos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE campos_x_blocos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: campos_x_blocos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE campos_x_blocos_id_seq OWNED BY campos_x_blocos.id;


--
-- Name: campos_x_propriedades_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE campos_x_propriedades_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: campos_x_propriedades; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE campos_x_propriedades (
    campoid integer NOT NULL,
    metodo character varying(30) NOT NULL,
    valor text NOT NULL,
    ativo integer DEFAULT 1 NOT NULL,
    id integer DEFAULT nextval('campos_x_propriedades_id_seq'::regclass) NOT NULL
);


--
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
    ativo character(1) DEFAULT '1'::bpchar
);


--
-- Name: form_button_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE form_button_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: form_button_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE form_button_id_seq OWNED BY form_button.id;


--
-- Name: form_validacao; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE form_validacao (
    id integer NOT NULL,
    formid integer DEFAULT 0
);


--
-- Name: form_validacao_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE form_validacao_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: form_validacao_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE form_validacao_id_seq OWNED BY form_validacao.id;


--
-- Name: form_x_abas; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE form_x_abas (
    id integer NOT NULL,
    formid integer,
    abaid integer,
    ativo character(1) DEFAULT '1'::bpchar,
    ordem integer DEFAULT 0
);


--
-- Name: form_x_abas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE form_x_abas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: form_x_abas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE form_x_abas_id_seq OWNED BY form_x_abas.id;


--
-- Name: form_x_tabelas; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE form_x_tabelas (
    id integer NOT NULL,
    formid integer,
    tabelaid integer,
    ativo character(1) DEFAULT '1'::bpchar
);


--
-- Name: form_x_tabelas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE form_x_tabelas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: form_x_tabelas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE form_x_tabelas_id_seq OWNED BY form_x_tabelas.id;


--
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
    autosave character varying(1) DEFAULT 1 NOT NULL
);


--
-- Name: COLUMN forms.dimensao; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN forms.dimensao IS 'dimenção da janela do form
largura;altura';


--
-- Name: COLUMN forms.botconcluir; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN forms.botconcluir IS 'Habilita ou desabilita o botão padrão do formulário.
0 = desabilitado
1 = ativado
2 = desativado';


--
-- Name: COLUMN forms.botcancelar; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN forms.botcancelar IS 'Habilita ou desabilita o botão padrão [cancelar] do formulário.
0 = desabilitado
1 = ativado
2 = desativado';


--
-- Name: forms_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE forms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: forms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE forms_id_seq OWNED BY forms.id;


--
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
    tipo character(3)
);


--
-- Name: info_empresa_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE info_empresa_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: info_empresa_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE info_empresa_id_seq OWNED BY info_empresa.id;


--
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
    tiporetorno character varying(6)
);


--
-- Name: lista_actions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE lista_actions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: lista_actions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE lista_actions_id_seq OWNED BY lista_actions.id;


--
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
    argumento character varying DEFAULT 0
);


--
-- Name: lista_bnav_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE lista_bnav_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: lista_bnav_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE lista_bnav_id_seq OWNED BY lista_bnav.id;


--
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
    ativo character(1) DEFAULT '1'::bpchar
);


--
-- Name: lista_colunas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE lista_colunas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: lista_colunas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE lista_colunas_id_seq OWNED BY lista_colunas.id;


--
-- Name: lista_fields; Type: TABLE; Schema: public; Owner: -
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
-- Name: lista_fields_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE lista_fields_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: lista_fields_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE lista_fields_id_seq OWNED BY lista_fields.id;


--
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
    aclimite character varying(1) DEFAULT 1
);


--
-- Name: COLUMN lista_form.pesquisa; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN lista_form.pesquisa IS 'padrão dos argumentos de retorno da pesquisa.

campo do formulário=coluna entidade[>coluna label],campo do formulário=coluna entidade[>coluna label]';


--
-- Name: COLUMN lista_form.filtro; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN lista_form.filtro IS 'pos 0 = coluna table
pos 1 = operador logico(=,like,>, etc) pos 2 = operador condicional(OR - AND)
pos 3 = classe ou valor fixo
pos 4 = metodo se o pos 3 for uma classe
pos 5 = se o metodo da classe vai receber o idLista ou não

(O metodo passado como filhtro deve retornar um valor valido e não dever receber nenhum paramentro)';


--
-- Name: COLUMN lista_form.formainclude; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN lista_form.formainclude IS 'define a forma de inclusão da lista (unitaria) ou (multipla)';


--
-- Name: COLUMN lista_form.trigger; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN lista_form.trigger IS 'Ações [JavaScript] a serem executadas quando a lista for carregada ou recarregada

';


--
-- Name: COLUMN lista_form.incontrol; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN lista_form.incontrol IS 'Regras de negócio a serem aplicadas nas ações da lista.
Ex: botão adicionar, excluir, editar
padrão de execução TSetControl';


--
-- Name: COLUMN lista_form.ordem; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN lista_form.ordem IS 'Padrão: (coluna)/(ordenação)?
Ex: id/desc;datacad';


--
-- Name: lista_form_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE lista_form_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: lista_form_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE lista_form_id_seq OWNED BY lista_form.id;


--
-- Name: menu_modulos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE menu_modulos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
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
    ativo character(1) DEFAULT '1'::bpchar
);


--
-- Name: modulos_principais; Type: TABLE; Schema: public; Owner: -
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
-- Name: modulos_principais_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE modulos_principais_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: modulos_principais_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE modulos_principais_id_seq OWNED BY modulos_principais.id;


--
-- Name: tabelas; Type: TABLE; Schema: public; Owner: -
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
-- Name: COLUMN tabelas.colunafilho; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN tabelas.colunafilho IS 'Nome da coluna necessar para todos os filhos da tabela em questão';


--
-- Name: tabelas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE tabelas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tabelas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE tabelas_id_seq OWNED BY tabelas.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE abas ALTER COLUMN id SET DEFAULT nextval('abas_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE blocos ALTER COLUMN id SET DEFAULT nextval('blocos_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE blocos_x_abas ALTER COLUMN id SET DEFAULT nextval('blocos_x_abas_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE campos ALTER COLUMN id SET DEFAULT nextval('campos_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE campos_x_blocos ALTER COLUMN id SET DEFAULT nextval('campos_x_blocos_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE form_button ALTER COLUMN id SET DEFAULT nextval('form_button_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE form_validacao ALTER COLUMN id SET DEFAULT nextval('form_validacao_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE form_x_abas ALTER COLUMN id SET DEFAULT nextval('form_x_abas_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE form_x_tabelas ALTER COLUMN id SET DEFAULT nextval('form_x_tabelas_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE forms ALTER COLUMN id SET DEFAULT nextval('forms_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE info_empresa ALTER COLUMN id SET DEFAULT nextval('info_empresa_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE lista_actions ALTER COLUMN id SET DEFAULT nextval('lista_actions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE lista_bnav ALTER COLUMN id SET DEFAULT nextval('lista_bnav_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE lista_colunas ALTER COLUMN id SET DEFAULT nextval('lista_colunas_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE lista_fields ALTER COLUMN id SET DEFAULT nextval('lista_fields_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE modulos_principais ALTER COLUMN id SET DEFAULT nextval('modulos_principais_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE tabelas ALTER COLUMN id SET DEFAULT nextval('tabelas_id_seq'::regclass);


--
-- Name: pk_abas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY abas
    ADD CONSTRAINT pk_abas PRIMARY KEY (id);


--
-- Name: pk_blocos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY blocos
    ADD CONSTRAINT pk_blocos PRIMARY KEY (id);


--
-- Name: pk_blocos_x_abas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY blocos_x_abas
    ADD CONSTRAINT pk_blocos_x_abas PRIMARY KEY (id);


--
-- Name: pk_campos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY campos
    ADD CONSTRAINT pk_campos PRIMARY KEY (id);


--
-- Name: pk_campos_x_blocos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY campos_x_blocos
    ADD CONSTRAINT pk_campos_x_blocos PRIMARY KEY (id);


--
-- Name: pk_campos_x_propriedades; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY campos_x_propriedades
    ADD CONSTRAINT pk_campos_x_propriedades PRIMARY KEY (id);


--
-- Name: pk_form_button; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY form_button
    ADD CONSTRAINT pk_form_button PRIMARY KEY (id);


--
-- Name: pk_form_validacao; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY form_validacao
    ADD CONSTRAINT pk_form_validacao PRIMARY KEY (id);


--
-- Name: pk_form_x_abas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY form_x_abas
    ADD CONSTRAINT pk_form_x_abas PRIMARY KEY (id);


--
-- Name: pk_form_x_tabelas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY form_x_tabelas
    ADD CONSTRAINT pk_form_x_tabelas PRIMARY KEY (id);


--
-- Name: pk_forms; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY forms
    ADD CONSTRAINT pk_forms PRIMARY KEY (id);


--
-- Name: pk_info_empresa; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY info_empresa
    ADD CONSTRAINT pk_info_empresa PRIMARY KEY (id);


--
-- Name: pk_lista_actions; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY lista_actions
    ADD CONSTRAINT pk_lista_actions PRIMARY KEY (id);


--
-- Name: pk_lista_bnav; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY lista_bnav
    ADD CONSTRAINT pk_lista_bnav PRIMARY KEY (id);


--
-- Name: pk_lista_colunas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY lista_colunas
    ADD CONSTRAINT pk_lista_colunas PRIMARY KEY (id);


--
-- Name: pk_lista_fields; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY lista_fields
    ADD CONSTRAINT pk_lista_fields PRIMARY KEY (id);


--
-- Name: pk_lista_form; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY lista_form
    ADD CONSTRAINT pk_lista_form PRIMARY KEY (id);


--
-- Name: pk_menu_modulos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY menu_modulos
    ADD CONSTRAINT pk_menu_modulos PRIMARY KEY (id);


--
-- Name: pk_modulos_principais; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY modulos_principais
    ADD CONSTRAINT pk_modulos_principais PRIMARY KEY (id);


--
-- Name: pk_tabelas; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tabelas
    ADD CONSTRAINT pk_tabelas PRIMARY KEY (id);


--
-- Name: fki_lista_actions__lista_form__idlista; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_lista_actions__lista_form__idlista ON lista_actions USING btree (idlista);


--
-- Name: fki_menu_modulos__lista_form__lista; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_menu_modulos__lista_form__lista ON menu_modulos USING btree (argumento);


--
-- Name: idx_campos_blocos; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_campos_blocos ON campos_x_blocos USING btree (blocoid, campoid);


--
-- Name: idx_campos_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_campos_id ON campos USING btree (id);


--
-- Name: idx_campos_propriedades; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_campos_propriedades ON campos_x_propriedades USING btree (campoid);


--
-- Name: lista_colunas_listacolunas_fkindex1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX lista_colunas_listacolunas_fkindex1 ON lista_colunas USING btree (lista_form_id);


--
-- Name: lista_form_formlista_fkindex1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX lista_form_formlista_fkindex1 ON lista_form USING btree (forms_id);


--
-- Name: lista_actions__lista_form__idlista; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY lista_actions
    ADD CONSTRAINT lista_actions__lista_form__idlista FOREIGN KEY (idlista) REFERENCES lista_form(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: lista_colunas__lista_form; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY lista_colunas
    ADD CONSTRAINT lista_colunas__lista_form FOREIGN KEY (lista_form_id) REFERENCES lista_form(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

