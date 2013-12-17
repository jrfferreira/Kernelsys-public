--

CREATE FUNCTION reset_sequence(tablename text, columnname text, sequence_name text) RETURNS void
    LANGUAGE plpgsql
    AS $$  
      DECLARE 
      BEGIN 

      EXECUTE 'SELECT setval( ''' || sequence_name  || ''', ' || '(SELECT MAX(' || columnname || ') FROM ' || tablename || ')' || '+1)';



      END;  

    $$;


--
-- TOC entry 161 (class 1259 OID 16387)
-- Dependencies: 5
-- Name: aluno_nota_frequencia_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE aluno_nota_frequencia_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


SET default_with_oids = false;

--
-- TOC entry 162 (class 1259 OID 16389)
-- Dependencies: 2675 5
-- Name: aluno_nota_frequencia; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE aluno_nota_frequencia (
    seq integer DEFAULT nextval('aluno_nota_frequencia_seq_seq'::regclass) NOT NULL,
    aluno character varying(160),
    alunseq bigint,
    tudiseq bigint,
    disciplina character varying(160),
    curso character varying(160),
    turma character varying(160),
    nota double precision,
    frequencia double precision,
    professor character varying(160),
    aprovacaofrequencias boolean,
    aprovacaomedia boolean,
    aprovacaogeral boolean,
    situacao bigint
);


--
-- TOC entry 163 (class 1259 OID 16396)
-- Dependencies: 5
-- Name: dbaluno_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbaluno_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 164 (class 1259 OID 16398)
-- Dependencies: 2676 2677 2678 2679 5
-- Name: dbaluno; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbaluno (
    seq integer DEFAULT nextval('dbaluno_seq_seq'::regclass) NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq bigint DEFAULT 0 NOT NULL,
    pessseq bigint NOT NULL,
    transeq bigint,
    turmseq bigint NOT NULL,
    cursseq bigint NOT NULL,
    datacad date DEFAULT ('now'::text)::date,
    statseq bigint DEFAULT 1 NOT NULL
);


--
-- TOC entry 4041 (class 0 OID 0)
-- Dependencies: 164
-- Name: COLUMN dbaluno.pessseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbaluno.pessseq IS 'Sequencial da pessoa vinculada ao papel de aluno';


--
-- TOC entry 4042 (class 0 OID 0)
-- Dependencies: 164
-- Name: COLUMN dbaluno.transeq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbaluno.transeq IS 'Sequencial da transacao financeira do aluno';


--
-- TOC entry 4043 (class 0 OID 0)
-- Dependencies: 164
-- Name: COLUMN dbaluno.turmseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbaluno.turmseq IS 'Sequencial da turma a qual o aluno esta vinculada';


--
-- TOC entry 4044 (class 0 OID 0)
-- Dependencies: 164
-- Name: COLUMN dbaluno.cursseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbaluno.cursseq IS 'Sequencial do curso que o aluno frequenta';


--
-- TOC entry 165 (class 1259 OID 16405)
-- Dependencies: 5
-- Name: dbaluno_disciplina_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbaluno_disciplina_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 166 (class 1259 OID 16407)
-- Dependencies: 2680 2681 2682 2683 2684 2685 5
-- Name: dbaluno_disciplina; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbaluno_disciplina (
    seq integer DEFAULT nextval('dbaluno_disciplina_seq_seq'::regclass) NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq bigint DEFAULT 0 NOT NULL,
    alunseq bigint NOT NULL,
    discseq bigint NOT NULL,
    tudiseq bigint,
    stadseq bigint DEFAULT 1 NOT NULL,
    obs text,
    datacad date DEFAULT ('now'::text)::date,
    dataalteracao date DEFAULT ('now'::text)::date NOT NULL,
    statseq bigint DEFAULT 1 NOT NULL
);


--
-- TOC entry 4045 (class 0 OID 0)
-- Dependencies: 166
-- Name: COLUMN dbaluno_disciplina.alunseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbaluno_disciplina.alunseq IS 'Sequencial do aluno';


--
-- TOC entry 4046 (class 0 OID 0)
-- Dependencies: 166
-- Name: COLUMN dbaluno_disciplina.discseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbaluno_disciplina.discseq IS 'Sequencial da Disciplina';


--
-- TOC entry 4047 (class 0 OID 0)
-- Dependencies: 166
-- Name: COLUMN dbaluno_disciplina.tudiseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbaluno_disciplina.tudiseq IS 'Sequencial da turma x disciplina';


--
-- TOC entry 4048 (class 0 OID 0)
-- Dependencies: 166
-- Name: COLUMN dbaluno_disciplina.stadseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbaluno_disciplina.stadseq IS 'Sequencial da situaco do aluno na disciplina';


--
-- TOC entry 167 (class 1259 OID 16419)
-- Dependencies: 5
-- Name: dbaluno_requisito_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbaluno_requisito_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 168 (class 1259 OID 16421)
-- Dependencies: 2686 2687 2688 2689 5
-- Name: dbaluno_requisito; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbaluno_requisito (
    seq integer DEFAULT nextval('dbaluno_requisito_seq_seq'::regclass) NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq bigint DEFAULT 0 NOT NULL,
    alunseq bigint NOT NULL,
    retuseq bigint NOT NULL,
    obs text,
    datacad date DEFAULT ('now'::text)::date,
    statseq bigint DEFAULT 1 NOT NULL
);


--
-- TOC entry 4049 (class 0 OID 0)
-- Dependencies: 168
-- Name: COLUMN dbaluno_requisito.alunseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbaluno_requisito.alunseq IS 'Sequencial do aluno';


--
-- TOC entry 4050 (class 0 OID 0)
-- Dependencies: 168
-- Name: COLUMN dbaluno_requisito.retuseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbaluno_requisito.retuseq IS 'Sequencial do requisito da turma';


--
-- TOC entry 169 (class 1259 OID 16431)
-- Dependencies: 5
-- Name: dbaluno_solicitacao_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbaluno_solicitacao_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 170 (class 1259 OID 16433)
-- Dependencies: 2690 2691 2692 2693 2694 5
-- Name: dbaluno_solicitacao; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbaluno_solicitacao (
    seq integer DEFAULT nextval('dbaluno_solicitacao_seq_seq'::regclass) NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq bigint DEFAULT 0 NOT NULL,
    alunseq bigint NOT NULL,
    data date DEFAULT ('now'::text)::date,
    solicitacao text NOT NULL,
    justificativa text,
    atendimento text,
    pessseq bigint,
    deptseq bigint NOT NULL,
    stslseq bigint NOT NULL,
    datacad date DEFAULT ('now'::text)::date,
    statseq bigint DEFAULT 1 NOT NULL
);


--
-- TOC entry 4051 (class 0 OID 0)
-- Dependencies: 170
-- Name: COLUMN dbaluno_solicitacao.alunseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbaluno_solicitacao.alunseq IS 'Sequencial do aluno';


--
-- TOC entry 4052 (class 0 OID 0)
-- Dependencies: 170
-- Name: COLUMN dbaluno_solicitacao.pessseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbaluno_solicitacao.pessseq IS 'Sequencial da pessoa atendende';


--
-- TOC entry 4053 (class 0 OID 0)
-- Dependencies: 170
-- Name: COLUMN dbaluno_solicitacao.deptseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbaluno_solicitacao.deptseq IS 'Sequencial do departamento responsavel';


--
-- TOC entry 4054 (class 0 OID 0)
-- Dependencies: 170
-- Name: COLUMN dbaluno_solicitacao.stslseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbaluno_solicitacao.stslseq IS 'Sequencial da situacao da solicitacao';


--
-- TOC entry 171 (class 1259 OID 16444)
-- Dependencies: 5
-- Name: dbaproveitamento_disciplina_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbaproveitamento_disciplina_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 172 (class 1259 OID 16446)
-- Dependencies: 2695 2696 2697 2698 5
-- Name: dbaproveitamento_disciplina; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbaproveitamento_disciplina (
    seq integer DEFAULT nextval('dbaproveitamento_disciplina_seq_seq'::regclass) NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq character varying(20) DEFAULT '0000'::character varying NOT NULL,
    aldiseq bigint NOT NULL,
    nomedisciplina character varying(200) NOT NULL,
    cargahoraria numeric NOT NULL,
    ementa text,
    nota numeric(2,2) NOT NULL,
    frequencia numeric NOT NULL,
    obs text,
    datacad date DEFAULT ('now'::text)::date,
    pessseq bigint NOT NULL,
    ano character(4) NOT NULL,
    statseq bigint DEFAULT 1 NOT NULL
);


--
-- TOC entry 4055 (class 0 OID 0)
-- Dependencies: 172
-- Name: COLUMN dbaproveitamento_disciplina.aldiseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbaproveitamento_disciplina.aldiseq IS 'Sequencial da disciplina exigida';


--
-- TOC entry 4056 (class 0 OID 0)
-- Dependencies: 172
-- Name: COLUMN dbaproveitamento_disciplina.pessseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbaproveitamento_disciplina.pessseq IS 'Sequencial da pessoa juridica onde o aluno cursou a disciplina';


--
-- TOC entry 173 (class 1259 OID 16456)
-- Dependencies: 5
-- Name: dbarea_curso_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbarea_curso_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 174 (class 1259 OID 16458)
-- Dependencies: 2699 2700 2701 2702 5
-- Name: dbarea_curso; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbarea_curso (
    seq integer DEFAULT nextval('dbarea_curso_seq_seq'::regclass) NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq bigint DEFAULT 0 NOT NULL,
    titulo character varying(200) NOT NULL,
    descricao text,
    datacad date DEFAULT ('now'::text)::date,
    statseq bigint DEFAULT 1 NOT NULL
);


--
-- TOC entry 175 (class 1259 OID 16468)
-- Dependencies: 5
-- Name: dbavaliacao_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbavaliacao_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 176 (class 1259 OID 16470)
-- Dependencies: 2703 2704 2705 2706 2707 2708 2709 5
-- Name: dbavaliacao; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbavaliacao (
    seq integer DEFAULT nextval('dbavaliacao_seq_seq'::regclass) NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq bigint DEFAULT 0 NOT NULL,
    avaliacao character varying(50) NOT NULL,
    peso bigint DEFAULT 1 NOT NULL,
    ordem bigint DEFAULT 1 NOT NULL,
    rgavseq bigint NOT NULL,
    incontrol text,
    referencia character varying(50),
    condicao text DEFAULT '1'::text,
    gdavseq bigint NOT NULL,
    datacad date DEFAULT ('now'::text)::date,
    statseq bigint DEFAULT 1 NOT NULL
);


--
-- TOC entry 4057 (class 0 OID 0)
-- Dependencies: 176
-- Name: COLUMN dbavaliacao.rgavseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbavaliacao.rgavseq IS 'Sequencial da regra da avaliacao';


--
-- TOC entry 4058 (class 0 OID 0)
-- Dependencies: 176
-- Name: COLUMN dbavaliacao.gdavseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbavaliacao.gdavseq IS 'Sequencial da grade de avaliacoes';


--
-- TOC entry 177 (class 1259 OID 16483)
-- Dependencies: 5
-- Name: dbbalanco_patrimonial_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbbalanco_patrimonial_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 178 (class 1259 OID 16485)
-- Dependencies: 2710 2711 2712 2713 2714 2715 2716 2717 2718 2719 2720 2721 2722 2723 2724 2725 2726 2727 2728 2729 2730 2731 2732 2733 2734 2735 5
-- Name: dbbalanco_patrimonial; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbbalanco_patrimonial (
    seq integer DEFAULT nextval('dbbalanco_patrimonial_seq_seq'::regclass) NOT NULL,
    unidseq bigint,
    usuaseq bigint DEFAULT 0,
    totcirculanteativo real DEFAULT (0)::real,
    totcaixaativo real DEFAULT (0)::real,
    totreceberativo real DEFAULT (0)::real,
    estoqueativo real DEFAULT (0)::real,
    despantecipadasativo real DEFAULT (0)::real,
    realizavelativo real DEFAULT (0)::real,
    totpermaneteativo real DEFAULT (0)::real,
    maquinarioativo real DEFAULT (0)::real,
    prediosativo real DEFAULT (0)::real,
    moveisativo real DEFAULT (0)::real,
    veiculosativo real DEFAULT (0)::real,
    totalativo real DEFAULT (0)::real,
    totpermanentepassivo real DEFAULT (0)::real,
    funcionariospassivo real DEFAULT (0)::real,
    tributospassivo real DEFAULT (0)::real,
    fornecedorespassivo real DEFAULT (0)::real,
    exigivelpassivo real DEFAULT (0)::real,
    totcirculantepassivo real DEFAULT (0)::real,
    patrimonioliquidopassivo real DEFAULT (0)::real,
    capitalsocialpassivo real DEFAULT (0)::real,
    lucroprejuizopassivo real DEFAULT (0)::real,
    totalpassivo real DEFAULT (0)::real,
    datacad date DEFAULT ('now'::text)::date,
    statseq bigint DEFAULT 1
);


--
-- TOC entry 179 (class 1259 OID 16514)
-- Dependencies: 5
-- Name: dbboleto_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbboleto_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 180 (class 1259 OID 16516)
-- Dependencies: 2736 2737 2738 2739 2740 2741 2742 2743 2744 5
-- Name: dbboleto; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbboleto (
    seq integer DEFAULT nextval('dbboleto_seq_seq'::regclass) NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq bigint DEFAULT 0 NOT NULL,
    parcseq bigint NOT NULL,
    ndocumento character varying(60),
    dataprocesso date DEFAULT ('now'::text)::date,
    cpfsacado character varying(15) DEFAULT '0'::character varying,
    valordoc real,
    vencimento date DEFAULT ('now'::text)::date,
    databaixa date DEFAULT ('now'::text)::date,
    stboseq bigint DEFAULT 1 NOT NULL,
    tipoboleto character varying(2),
    classificacao character varying(30),
    bkp text,
    datacad date DEFAULT ('now'::text)::date,
    statseq bigint DEFAULT 1 NOT NULL
);


--
-- TOC entry 4059 (class 0 OID 0)
-- Dependencies: 180
-- Name: COLUMN dbboleto.parcseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbboleto.parcseq IS 'Sequencial identificador da parcela';


--
-- TOC entry 4060 (class 0 OID 0)
-- Dependencies: 180
-- Name: COLUMN dbboleto.stboseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbboleto.stboseq IS 'Sequencial da situacao do boleto';


--
-- TOC entry 181 (class 1259 OID 16531)
-- Dependencies: 5
-- Name: dbboleto_estrutura_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbboleto_estrutura_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 182 (class 1259 OID 16533)
-- Dependencies: 2745 2746 2747 2748 2749 5
-- Name: dbboleto_estrutura; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbboleto_estrutura (
    seq integer DEFAULT nextval('dbboleto_estrutura_seq_seq'::regclass) NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq bigint DEFAULT 0 NOT NULL,
    cofiseq bigint NOT NULL,
    agencia character varying(10),
    conta character varying(10),
    digito character varying(5),
    carteira character varying(4),
    identificacao character varying(60),
    pessnmrf character varying(30),
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
    tipoduplicata character varying(2) DEFAULT '-'::character varying,
    datacad date DEFAULT ('now'::text)::date,
    statseq bigint DEFAULT 1 NOT NULL
);


--
-- TOC entry 183 (class 1259 OID 16544)
-- Dependencies: 5
-- Name: dbcaixa_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbcaixa_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 184 (class 1259 OID 16546)
-- Dependencies: 2750 2751 2752 2753 2754 2755 2756 2757 2758 2759 2760 5
-- Name: dbcaixa; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbcaixa (
    seq integer DEFAULT nextval('dbcaixa_seq_seq'::regclass) NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq bigint DEFAULT 0 NOT NULL,
    parcseq bigint NOT NULL,
    plcoseq bigint NOT NULL,
    cofiseq bigint NOT NULL,
    stpaseq bigint DEFAULT 2 NOT NULL,
    transeq bigint NOT NULL,
    boleseq bigint,
    tipo character(1) NOT NULL,
    valor real NOT NULL,
    vencimento date DEFAULT ('now'::text)::date,
    formadesconto character varying(4) DEFAULT 'vl'::character varying,
    desconto real DEFAULT (0)::real,
    acrescimo real DEFAULT (0)::real,
    valorfinal real NOT NULL,
    valorentrada real NOT NULL,
    cxfuseq bigint NOT NULL,
    datapag date DEFAULT ('now'::text)::date NOT NULL,
    fmpgseq bigint NOT NULL,
    multa real,
    obs text,
    stmoseq bigint DEFAULT 1 NOT NULL,
    fecfseq bigint,
    datacad date DEFAULT ('now'::text)::date,
    statseq bigint DEFAULT 1 NOT NULL
);


--
-- TOC entry 4061 (class 0 OID 0)
-- Dependencies: 184
-- Name: COLUMN dbcaixa.parcseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbcaixa.parcseq IS 'Sequencial da parcela movimentada';


--
-- TOC entry 4062 (class 0 OID 0)
-- Dependencies: 184
-- Name: COLUMN dbcaixa.plcoseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbcaixa.plcoseq IS 'Sequencial do plano de conta';


--
-- TOC entry 4063 (class 0 OID 0)
-- Dependencies: 184
-- Name: COLUMN dbcaixa.cofiseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbcaixa.cofiseq IS 'Sequencial da conta financeira de entrada/saida';


--
-- TOC entry 4064 (class 0 OID 0)
-- Dependencies: 184
-- Name: COLUMN dbcaixa.stpaseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbcaixa.stpaseq IS 'Sequencial da Situacao da parcela';


--
-- TOC entry 4065 (class 0 OID 0)
-- Dependencies: 184
-- Name: COLUMN dbcaixa.transeq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbcaixa.transeq IS 'Sequencial da transacao da conta';


--
-- TOC entry 4066 (class 0 OID 0)
-- Dependencies: 184
-- Name: COLUMN dbcaixa.boleseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbcaixa.boleseq IS 'Sequencial do boleto';


--
-- TOC entry 4067 (class 0 OID 0)
-- Dependencies: 184
-- Name: COLUMN dbcaixa.tipo; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbcaixa.tipo IS ' C = Credito
D = Debito';


--
-- TOC entry 4068 (class 0 OID 0)
-- Dependencies: 184
-- Name: COLUMN dbcaixa.valor; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbcaixa.valor IS 'Valor real da conta, sem acresciomos e descontos. Esse valor é o valor atual da conta que pode ser diferente do valor nominal inicial.';


--
-- TOC entry 4069 (class 0 OID 0)
-- Dependencies: 184
-- Name: COLUMN dbcaixa.fmpgseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbcaixa.fmpgseq IS 'Sequencial da Forma de Pagamento';


--
-- TOC entry 4070 (class 0 OID 0)
-- Dependencies: 184
-- Name: COLUMN dbcaixa.stmoseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbcaixa.stmoseq IS 'Sequencial da situacao do movimento';


--
-- TOC entry 185 (class 1259 OID 16563)
-- Dependencies: 5
-- Name: dbcaixa_funcionario_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbcaixa_funcionario_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 186 (class 1259 OID 16565)
-- Dependencies: 2761 2762 2763 2764 2765 5
-- Name: dbcaixa_funcionario; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbcaixa_funcionario (
    seq integer DEFAULT nextval('dbcaixa_funcionario_seq_seq'::regclass) NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq bigint DEFAULT 0 NOT NULL,
    funcseq bigint NOT NULL,
    obs text,
    titulo character varying(120),
    datacad date DEFAULT ('now'::text)::date,
    stcfseq bigint DEFAULT 1 NOT NULL,
    cofiseq bigint NOT NULL,
    statseq bigint DEFAULT 1 NOT NULL
);


--
-- TOC entry 4071 (class 0 OID 0)
-- Dependencies: 186
-- Name: COLUMN dbcaixa_funcionario.funcseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbcaixa_funcionario.funcseq IS 'Sequencial do funcionario responsavel';


--
-- TOC entry 4072 (class 0 OID 0)
-- Dependencies: 186
-- Name: COLUMN dbcaixa_funcionario.stcfseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbcaixa_funcionario.stcfseq IS 'Sequencial da situacao do caixa do funcionario';


--
-- TOC entry 4073 (class 0 OID 0)
-- Dependencies: 186
-- Name: COLUMN dbcaixa_funcionario.cofiseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbcaixa_funcionario.cofiseq IS 'Sequencial da conta financeira permitida';


--
-- TOC entry 187 (class 1259 OID 16576)
-- Dependencies: 5
-- Name: dbcargo_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbcargo_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 188 (class 1259 OID 16578)
-- Dependencies: 2766 2767 2768 2769 2770 5
-- Name: dbcargo; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbcargo (
    seq integer DEFAULT nextval('dbcargo_seq_seq'::regclass) NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq bigint DEFAULT 0 NOT NULL,
    nomecargo character varying(80) NOT NULL,
    descricao text,
    conhecimentos text,
    habilidades text,
    atitudes text,
    prerequisitos text,
    cargahoraria character varying(3),
    horariotrabalho character varying(80),
    maquinasutilizadas text,
    graurisco character varying(80),
    cargseq bigint,
    cargoascendente text,
    cargodescendente text,
    salariobase real DEFAULT (0)::real,
    datacad date DEFAULT ('now'::text)::date,
    statseq bigint DEFAULT 1 NOT NULL
);


--
-- TOC entry 4074 (class 0 OID 0)
-- Dependencies: 188
-- Name: COLUMN dbcargo.cargseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbcargo.cargseq IS 'Sequencial do cargo superior';


--
-- TOC entry 189 (class 1259 OID 16589)
-- Dependencies: 5
-- Name: dbcdu_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbcdu_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 190 (class 1259 OID 16591)
-- Dependencies: 2771 2772 2773 2774 5
-- Name: dbcdu; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbcdu (
    seq integer DEFAULT nextval('dbcdu_seq_seq'::regclass) NOT NULL,
    unidseq bigint,
    usuaseq bigint DEFAULT 0,
    cdu character varying(30),
    titulo character varying(200),
    datacad date DEFAULT ('now'::text)::date,
    statseq bigint DEFAULT 1
);


--
-- TOC entry 191 (class 1259 OID 16598)
-- Dependencies: 5
-- Name: dbcheque_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbcheque_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 192 (class 1259 OID 16600)
-- Dependencies: 2775 2776 2777 2778 5
-- Name: dbcheque; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbcheque (
    seq integer DEFAULT nextval('dbcheque_seq_seq'::regclass) NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq bigint DEFAULT 0 NOT NULL,
    nometitular character varying(180),
    banco character varying(120),
    agencia character varying(45),
    numconta character varying(45),
    datacad date DEFAULT ('now'::text)::date,
    obs text,
    caixseq bigint NOT NULL,
    numcheque character varying(240),
    pessnmrf numeric,
    valor real,
    statseq bigint DEFAULT 1 NOT NULL
);


--
-- TOC entry 193 (class 1259 OID 16610)
-- Dependencies: 5
-- Name: dbconta_financeira_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbconta_financeira_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 194 (class 1259 OID 16612)
-- Dependencies: 2779 2780 2781 2782 2783 2784 2785 5
-- Name: dbconta_financeira; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbconta_financeira (
    seq integer DEFAULT nextval('dbconta_financeira_seq_seq'::regclass) NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq bigint DEFAULT 0 NOT NULL,
    nomeconta character varying(80) NOT NULL,
    tipo character(1),
    banco character varying(60) DEFAULT '-'::character varying,
    numconta character varying(12) DEFAULT '-'::character varying,
    agencia character varying(8) DEFAULT '-'::character varying,
    saldoinicial real NOT NULL,
    datacad date DEFAULT ('now'::text)::date,
    statseq bigint DEFAULT 1 NOT NULL
);


--
-- TOC entry 4075 (class 0 OID 0)
-- Dependencies: 194
-- Name: COLUMN dbconta_financeira.tipo; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbconta_financeira.tipo IS 'B,C';


--
-- TOC entry 195 (class 1259 OID 16622)
-- Dependencies: 5
-- Name: dbconvenio_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbconvenio_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 196 (class 1259 OID 16624)
-- Dependencies: 2786 2787 2788 2789 5
-- Name: dbconvenio; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbconvenio (
    seq integer DEFAULT nextval('dbconvenio_seq_seq'::regclass) NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq bigint NOT NULL,
    pessseq bigint NOT NULL,
    titulo character varying(100) NOT NULL,
    descricao text,
    tconseq bigint NOT NULL,
    valor real,
    formato bigint,
    datavigencia date DEFAULT ('now'::text)::date NOT NULL,
    plcoseq bigint NOT NULL,
    datacad date DEFAULT ('now'::text)::date,
    statseq bigint DEFAULT 1 NOT NULL
);


--
-- TOC entry 4076 (class 0 OID 0)
-- Dependencies: 196
-- Name: COLUMN dbconvenio.pessseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbconvenio.pessseq IS 'Sequencial da pessoa responsavel pelo convenio';


--
-- TOC entry 4077 (class 0 OID 0)
-- Dependencies: 196
-- Name: COLUMN dbconvenio.tconseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbconvenio.tconseq IS 'Sequencial do tipo de convenio';


--
-- TOC entry 4078 (class 0 OID 0)
-- Dependencies: 196
-- Name: COLUMN dbconvenio.valor; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbconvenio.valor IS 'valor do crédito/débito a ser gerado em função do escobo do convênio';


--
-- TOC entry 4079 (class 0 OID 0)
-- Dependencies: 196
-- Name: COLUMN dbconvenio.formato; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbconvenio.formato IS 'formato do valor

1 = valor
2 = percentual';


--
-- TOC entry 4080 (class 0 OID 0)
-- Dependencies: 196
-- Name: COLUMN dbconvenio.datavigencia; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbconvenio.datavigencia IS 'data em que o convênio entra em vigor.';


--
-- TOC entry 197 (class 1259 OID 16634)
-- Dependencies: 5
-- Name: dbconvenio_desconto_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbconvenio_desconto_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 198 (class 1259 OID 16636)
-- Dependencies: 2790 2791 2792 2793 5
-- Name: dbconvenio_desconto; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbconvenio_desconto (
    seq integer DEFAULT nextval('dbconvenio_desconto_seq_seq'::regclass) NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq bigint DEFAULT 0 NOT NULL,
    convseq bigint NOT NULL,
    dialimite character varying(2) NOT NULL,
    valor real NOT NULL,
    obs text,
    datacad date DEFAULT ('now'::text)::date,
    statseq bigint DEFAULT 1 NOT NULL
);


--
-- TOC entry 199 (class 1259 OID 16646)
-- Dependencies: 5
-- Name: dbcotacao_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbcotacao_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 200 (class 1259 OID 16648)
-- Dependencies: 2794 2795 2796 2797 5
-- Name: dbcotacao; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbcotacao (
    seq integer DEFAULT nextval('dbcotacao_seq_seq'::regclass) NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq bigint DEFAULT 0 NOT NULL,
    prodseq bigint NOT NULL,
    pessseq bigint NOT NULL,
    valor real NOT NULL,
    entrega numeric,
    datacad date DEFAULT ('now'::text)::date,
    statseq bigint DEFAULT 1 NOT NULL
);


--
-- TOC entry 4081 (class 0 OID 0)
-- Dependencies: 200
-- Name: COLUMN dbcotacao.prodseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbcotacao.prodseq IS 'Sequencial do produto';


--
-- TOC entry 4082 (class 0 OID 0)
-- Dependencies: 200
-- Name: COLUMN dbcotacao.pessseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbcotacao.pessseq IS 'Sequencial do fornecedor';


--
-- TOC entry 201 (class 1259 OID 16658)
-- Dependencies: 5
-- Name: dbcurriculo_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbcurriculo_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 202 (class 1259 OID 16660)
-- Dependencies: 2798 2799 2800 2801 2802 5
-- Name: dbcurriculo; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbcurriculo (
    seq integer DEFAULT nextval('dbcurriculo_seq_seq'::regclass) NOT NULL,
    unidseq bigint,
    usuaseq bigint DEFAULT 0,
    nome character varying(60),
    sexo character(1),
    datanasc date DEFAULT ('now'::text)::date,
    cpf numeric,
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
    datacad date DEFAULT ('now'::text)::date,
    statseq bigint DEFAULT 1 NOT NULL
);


--
-- TOC entry 203 (class 1259 OID 16671)
-- Dependencies: 5
-- Name: dbcurso_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbcurso_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 204 (class 1259 OID 16673)
-- Dependencies: 2803 2804 2805 2806 5
-- Name: dbcurso; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbcurso (
    seq integer DEFAULT nextval('dbcurso_seq_seq'::regclass) NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq bigint DEFAULT 0 NOT NULL,
    titulo character varying(200) NOT NULL,
    pjcuseq bigint NOT NULL,
    obs text,
    datacad date DEFAULT ('now'::text)::date,
    statseq bigint DEFAULT 1 NOT NULL
);


--
-- TOC entry 4083 (class 0 OID 0)
-- Dependencies: 204
-- Name: COLUMN dbcurso.pjcuseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbcurso.pjcuseq IS 'Sequencial do projeto de curso';


--
-- TOC entry 205 (class 1259 OID 16683)
-- Dependencies: 5
-- Name: dbdemanda_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbdemanda_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 206 (class 1259 OID 16685)
-- Dependencies: 2807 2808 2809 2810 5
-- Name: dbdemanda; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbdemanda (
    seq integer DEFAULT nextval('dbdemanda_seq_seq'::regclass) NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq bigint DEFAULT 0 NOT NULL,
    pessseq bigint NOT NULL,
    cursseq bigint NOT NULL,
    turno character varying(100),
    datacad date DEFAULT ('now'::text)::date,
    statseq bigint DEFAULT 1 NOT NULL
);


--
-- TOC entry 207 (class 1259 OID 16692)
-- Dependencies: 5
-- Name: dbdepartamento_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbdepartamento_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 208 (class 1259 OID 16694)
-- Dependencies: 2811 2812 2813 2814 5
-- Name: dbdepartamento; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbdepartamento (
    seq integer DEFAULT nextval('dbdepartamento_seq_seq'::regclass) NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq bigint DEFAULT 0 NOT NULL,
    label character varying(120),
    funcseq bigint,
    salaseq bigint NOT NULL,
    obs text,
    datacad date DEFAULT ('now'::text)::date,
    statseq bigint DEFAULT 1 NOT NULL
);


--
-- TOC entry 4084 (class 0 OID 0)
-- Dependencies: 208
-- Name: COLUMN dbdepartamento.funcseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbdepartamento.funcseq IS 'Identificador do sequencial do funcionario responsavel pelo departamento';


--
-- TOC entry 4085 (class 0 OID 0)
-- Dependencies: 208
-- Name: COLUMN dbdepartamento.salaseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbdepartamento.salaseq IS 'Identificador do sequencial de qual sala o departamento esta alocado';


--
-- TOC entry 209 (class 1259 OID 16704)
-- Dependencies: 5
-- Name: dbdisciplina_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbdisciplina_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 210 (class 1259 OID 16706)
-- Dependencies: 2815 2816 2817 2818 5
-- Name: dbdisciplina; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbdisciplina (
    seq integer DEFAULT nextval('dbdisciplina_seq_seq'::regclass) NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq bigint DEFAULT 0 NOT NULL,
    titulo character varying(200) NOT NULL,
    ementa text,
    programa text,
    competencias text,
    cargahoraria numeric NOT NULL,
    biografia text,
    metodologia text,
    datacad date DEFAULT ('now'::text)::date,
    statseq bigint DEFAULT 1 NOT NULL
);


--
-- TOC entry 211 (class 1259 OID 16716)
-- Dependencies: 5
-- Name: dbdisciplina_similar_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbdisciplina_similar_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 212 (class 1259 OID 16718)
-- Dependencies: 2819 2820 2821 2822 5
-- Name: dbdisciplina_similar; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbdisciplina_similar (
    seq integer DEFAULT nextval('dbdisciplina_similar_seq_seq'::regclass) NOT NULL,
    unidseq bigint,
    usuaseq bigint DEFAULT 0,
    discseq bigint,
    disiseq bigint,
    datacad date DEFAULT ('now'::text)::date,
    statseq bigint DEFAULT 1
);


--
-- TOC entry 4086 (class 0 OID 0)
-- Dependencies: 212
-- Name: COLUMN dbdisciplina_similar.discseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbdisciplina_similar.discseq IS 'Sequencial da disciplina';


--
-- TOC entry 4087 (class 0 OID 0)
-- Dependencies: 212
-- Name: COLUMN dbdisciplina_similar.disiseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbdisciplina_similar.disiseq IS 'Sequencial da disciplina semelhante';


--
-- TOC entry 213 (class 1259 OID 16725)
-- Dependencies: 5
-- Name: dbdocumentos_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbdocumentos_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 214 (class 1259 OID 16727)
-- Dependencies: 2823 2824 2825 2826 5
-- Name: dbdocumentos; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbdocumentos (
    seq integer DEFAULT nextval('dbdocumentos_seq_seq'::regclass) NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq bigint DEFAULT 0 NOT NULL,
    titulo character varying(80),
    tipo character varying(20),
    modelodocumento text,
    modeloassinaturadigital text,
    modeloassinaturareal text,
    modelotestemunha text,
    datacad date DEFAULT ('now'::text)::date,
    statseq bigint DEFAULT 1 NOT NULL
);


--
-- TOC entry 215 (class 1259 OID 16737)
-- Dependencies: 5
-- Name: dbemail_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbemail_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 216 (class 1259 OID 16739)
-- Dependencies: 2827 2828 5
-- Name: dbemail; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbemail (
    seq integer DEFAULT nextval('dbemail_seq_seq'::regclass) NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq bigint NOT NULL,
    pessseq bigint NOT NULL,
    titulo character varying(30) NOT NULL,
    email character varying(200) NOT NULL,
    datacad date DEFAULT ('now'::text)::date,
    statseq bigint NOT NULL
);


--
-- TOC entry 217 (class 1259 OID 16744)
-- Dependencies: 5
-- Name: dbendereco_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbendereco_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 218 (class 1259 OID 16746)
-- Dependencies: 2829 2830 2831 5
-- Name: dbendereco; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbendereco (
    seq integer DEFAULT nextval('dbendereco_seq_seq'::regclass) NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq bigint NOT NULL,
    pessseq bigint NOT NULL,
    endereco character varying(200) NOT NULL,
    complemento character varying(200),
    bairro character varying(120) NOT NULL,
    cidade character varying(120) NOT NULL,
    estado character varying(100) NOT NULL,
    cep numeric NOT NULL,
    datacad date DEFAULT ('now'::text)::date,
    statseq bigint DEFAULT 1 NOT NULL
);


--
-- TOC entry 219 (class 1259 OID 16755)
-- Dependencies: 5
-- Name: dbfalta_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbfalta_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 220 (class 1259 OID 16757)
-- Dependencies: 2832 2833 2834 2835 2836 2837 5
-- Name: dbfalta; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbfalta (
    seq integer DEFAULT nextval('dbfalta_seq_seq'::regclass) NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq bigint DEFAULT 0 NOT NULL,
    alunseq bigint NOT NULL,
    tudiseq bigint NOT NULL,
    tdalseq bigint NOT NULL,
    datafalta date DEFAULT ('now'::text)::date NOT NULL,
    frequencia numeric DEFAULT 0 NOT NULL,
    justificativa text,
    obs text,
    deferido boolean NOT NULL,
    datacad date DEFAULT ('now'::text)::date,
    statseq bigint DEFAULT 1 NOT NULL
);


--
-- TOC entry 4088 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN dbfalta.alunseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbfalta.alunseq IS 'Sequencial do Aluno';


--
-- TOC entry 4089 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN dbfalta.tudiseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbfalta.tudiseq IS 'Sequencial da turma x disciplina';


--
-- TOC entry 4090 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN dbfalta.tdalseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbfalta.tdalseq IS 'Sequencial da aula';


--
-- TOC entry 4091 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN dbfalta.deferido; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbfalta.deferido IS 'Se a falta foi computada ou nao';


--
-- TOC entry 221 (class 1259 OID 16769)
-- Dependencies: 5
-- Name: dbfechamento_caixa_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbfechamento_caixa_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 222 (class 1259 OID 16771)
-- Dependencies: 2838 2839 2840 2841 5
-- Name: dbfechamento_caixa; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbfechamento_caixa (
    seq integer DEFAULT nextval('dbfechamento_caixa_seq_seq'::regclass) NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq bigint DEFAULT 0 NOT NULL,
    valorprevisto real NOT NULL,
    receitatotal real NOT NULL,
    despesatotal real NOT NULL,
    datacad date DEFAULT ('now'::text)::date,
    statseq bigint DEFAULT 1 NOT NULL
);


--
-- TOC entry 223 (class 1259 OID 16778)
-- Dependencies: 2842 2843 2844 5
-- Name: dbfechamento_conta_financeira; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbfechamento_conta_financeira (
    seq integer NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq bigint DEFAULT 0 NOT NULL,
    cofiseq bigint NOT NULL,
    datainicio date NOT NULL,
    datafim date,
    datacad date DEFAULT ('now'::text)::date,
    statseq bigint DEFAULT 1 NOT NULL
);


--
-- TOC entry 224 (class 1259 OID 16784)
-- Dependencies: 5
-- Name: dbforma_pagamento_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbforma_pagamento_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 225 (class 1259 OID 16786)
-- Dependencies: 2845 2846 5
-- Name: dbforma_pagamento; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbforma_pagamento (
    seq integer DEFAULT nextval('dbforma_pagamento_seq_seq'::regclass) NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq bigint NOT NULL,
    titulo character varying(30),
    datacad date DEFAULT ('now'::text)::date,
    statseq bigint NOT NULL
);


--
-- TOC entry 226 (class 1259 OID 16791)
-- Dependencies: 5
-- Name: dbfuncionario_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbfuncionario_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 227 (class 1259 OID 16793)
-- Dependencies: 2847 2848 2849 2850 2851 2852 5
-- Name: dbfuncionario; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbfuncionario (
    seq integer DEFAULT nextval('dbfuncionario_seq_seq'::regclass) NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq bigint DEFAULT 0 NOT NULL,
    pessseq bigint NOT NULL,
    cargseq bigint,
    deptseq bigint NOT NULL,
    dataadmissao date DEFAULT ('now'::text)::date,
    relatorioexame text,
    dataexame date DEFAULT ('now'::text)::date,
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
    datacad date DEFAULT ('now'::text)::date,
    statseq bigint DEFAULT 1 NOT NULL
);


--
-- TOC entry 4092 (class 0 OID 0)
-- Dependencies: 227
-- Name: COLUMN dbfuncionario.pessseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbfuncionario.pessseq IS 'identificador do sequencial a qual pessoa o registro pertence';


--
-- TOC entry 4093 (class 0 OID 0)
-- Dependencies: 227
-- Name: COLUMN dbfuncionario.deptseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbfuncionario.deptseq IS 'Sequencial identificador de Departamento ao qual o funcionario pertence';


--
-- TOC entry 228 (class 1259 OID 16805)
-- Dependencies: 5
-- Name: dbfuncionario_ocorrencia_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbfuncionario_ocorrencia_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 229 (class 1259 OID 16807)
-- Dependencies: 2853 2854 2855 2856 5
-- Name: dbfuncionario_ocorrencia; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbfuncionario_ocorrencia (
    seq integer DEFAULT nextval('dbfuncionario_ocorrencia_seq_seq'::regclass) NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq bigint DEFAULT 0 NOT NULL,
    funcseq bigint NOT NULL,
    titulo character varying(180),
    descricao text,
    datacad date DEFAULT ('now'::text)::date,
    statseq bigint DEFAULT 1 NOT NULL
);


--
-- TOC entry 4094 (class 0 OID 0)
-- Dependencies: 229
-- Name: COLUMN dbfuncionario_ocorrencia.funcseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbfuncionario_ocorrencia.funcseq IS 'Sequencial do funcionario';


--
-- TOC entry 230 (class 1259 OID 16817)
-- Dependencies: 5
-- Name: dbfuncionario_treinamento_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbfuncionario_treinamento_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 231 (class 1259 OID 16819)
-- Dependencies: 2857 2858 2859 2860 5
-- Name: dbfuncionario_treinamento; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbfuncionario_treinamento (
    seq integer DEFAULT nextval('dbfuncionario_treinamento_seq_seq'::regclass) NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq bigint DEFAULT 0 NOT NULL,
    treiseq bigint NOT NULL,
    funcseq bigint NOT NULL,
    datacad date DEFAULT ('now'::text)::date,
    statseq bigint DEFAULT 1 NOT NULL
);


--
-- TOC entry 4095 (class 0 OID 0)
-- Dependencies: 231
-- Name: COLUMN dbfuncionario_treinamento.treiseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbfuncionario_treinamento.treiseq IS 'Sequencial do treinamento';


--
-- TOC entry 4096 (class 0 OID 0)
-- Dependencies: 231
-- Name: COLUMN dbfuncionario_treinamento.funcseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbfuncionario_treinamento.funcseq IS 'Sequencial do funcionario';


--
-- TOC entry 232 (class 1259 OID 16826)
-- Dependencies: 5
-- Name: dbgrade_avaliacao_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbgrade_avaliacao_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 233 (class 1259 OID 16828)
-- Dependencies: 2861 2862 2863 2864 5
-- Name: dbgrade_avaliacao; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbgrade_avaliacao (
    seq integer DEFAULT nextval('dbgrade_avaliacao_seq_seq'::regclass) NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq bigint DEFAULT 0 NOT NULL,
    titulo character varying(100) NOT NULL,
    observacoes text,
    datacad date DEFAULT ('now'::text)::date,
    statseq bigint DEFAULT 1 NOT NULL
);


--
-- TOC entry 234 (class 1259 OID 16838)
-- Dependencies: 5
-- Name: dbinscricao_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbinscricao_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 235 (class 1259 OID 16840)
-- Dependencies: 2865 2866 2867 2868 2869 2870 5
-- Name: dbinscricao; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbinscricao (
    seq integer DEFAULT nextval('dbinscricao_seq_seq'::regclass) NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq bigint DEFAULT 0 NOT NULL,
    pessseq bigint NOT NULL,
    transeq bigint,
    turmseq bigint NOT NULL,
    vencimentomatricula date DEFAULT ('now'::text)::date,
    vencimentotaxa date DEFAULT ('now'::text)::date,
    datacad date DEFAULT ('now'::text)::date,
    statseq bigint DEFAULT 1 NOT NULL
);


--
-- TOC entry 4097 (class 0 OID 0)
-- Dependencies: 235
-- Name: COLUMN dbinscricao.pessseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbinscricao.pessseq IS 'Sequencial da pessoa inscrita';


--
-- TOC entry 4098 (class 0 OID 0)
-- Dependencies: 235
-- Name: COLUMN dbinscricao.transeq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbinscricao.transeq IS 'Sequencial da transacao da inscricao';


--
-- TOC entry 4099 (class 0 OID 0)
-- Dependencies: 235
-- Name: COLUMN dbinscricao.turmseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbinscricao.turmseq IS 'Sequencial da turma inscrita';


--
-- TOC entry 236 (class 1259 OID 16849)
-- Dependencies: 5
-- Name: dblivro_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dblivro_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 237 (class 1259 OID 16851)
-- Dependencies: 2871 2872 2873 2874 5
-- Name: dblivro; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dblivro (
    seq integer DEFAULT nextval('dblivro_seq_seq'::regclass) NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq bigint DEFAULT 0 NOT NULL,
    patrseq bigint NOT NULL,
    autor character varying(200),
    outrosautores text,
    ano character(4),
    isbn character varying(80),
    idioma character varying(80),
    paginas numeric(12,0),
    cphaseq bigint,
    ccduseq bigint,
    tradutor character varying(180),
    sinopse text,
    sumario text,
    datacad date DEFAULT ('now'::text)::date,
    volume character varying(40),
    exemplar character varying(40),
    statseq bigint DEFAULT 1 NOT NULL
);


--
-- TOC entry 4100 (class 0 OID 0)
-- Dependencies: 237
-- Name: COLUMN dblivro.patrseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dblivro.patrseq IS 'Sequencial do patrimonio que representa o livro
';


--
-- TOC entry 238 (class 1259 OID 16861)
-- Dependencies: 5
-- Name: dblocacao_livro_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dblocacao_livro_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 239 (class 1259 OID 16863)
-- Dependencies: 2875 2876 2877 2878 2879 2880 2881 2882 2883 5
-- Name: dblocacao_livro; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dblocacao_livro (
    seq integer DEFAULT nextval('dblocacao_livro_seq_seq'::regclass) NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq bigint DEFAULT 0 NOT NULL,
    pessseq bigint NOT NULL,
    livrseq bigint NOT NULL,
    previsaosaida date DEFAULT ('now'::text)::date NOT NULL,
    previsaoentrada date DEFAULT ('now'::text)::date NOT NULL,
    confirmacaosaida date DEFAULT ('now'::text)::date,
    confirmacaoentrada date DEFAULT ('now'::text)::date,
    stlvseq bigint DEFAULT 1 NOT NULL,
    datacad date DEFAULT ('now'::text)::date,
    statseq bigint DEFAULT 1 NOT NULL
);


--
-- TOC entry 4101 (class 0 OID 0)
-- Dependencies: 239
-- Name: COLUMN dblocacao_livro.pessseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dblocacao_livro.pessseq IS 'Sequencial da pessoa que locou o livro';


--
-- TOC entry 4102 (class 0 OID 0)
-- Dependencies: 239
-- Name: COLUMN dblocacao_livro.livrseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dblocacao_livro.livrseq IS 'Sequencial do livro';


--
-- TOC entry 240 (class 1259 OID 16875)
-- Dependencies: 5
-- Name: dbnota_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbnota_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 241 (class 1259 OID 16877)
-- Dependencies: 2884 2885 2886 2887 5
-- Name: dbnota; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbnota (
    seq integer DEFAULT nextval('dbnota_seq_seq'::regclass) NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq bigint DEFAULT 0 NOT NULL,
    alunseq bigint NOT NULL,
    tudiseq bigint NOT NULL,
    avalseq bigint NOT NULL,
    nota numeric NOT NULL,
    datacad date DEFAULT ('now'::text)::date,
    statseq bigint DEFAULT 1 NOT NULL
);


--
-- TOC entry 4103 (class 0 OID 0)
-- Dependencies: 241
-- Name: COLUMN dbnota.alunseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbnota.alunseq IS 'Sequencial do aluno';


--
-- TOC entry 4104 (class 0 OID 0)
-- Dependencies: 241
-- Name: COLUMN dbnota.tudiseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbnota.tudiseq IS 'Sequencial da Turma x Disciplina';


--
-- TOC entry 4105 (class 0 OID 0)
-- Dependencies: 241
-- Name: COLUMN dbnota.avalseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbnota.avalseq IS 'Sequencial da Avaliacao';


--
-- TOC entry 242 (class 1259 OID 16887)
-- Dependencies: 2889 2890 5
-- Name: dbparametro_produto; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbparametro_produto (
    seq integer NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq bigint NOT NULL,
    tabela character varying(60),
    collabel character varying(60),
    colvalor character varying(200),
    coldesc character varying(80),
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    tpprseq bigint NOT NULL,
    statseq bigint DEFAULT 1 NOT NULL
);


--
-- TOC entry 243 (class 1259 OID 16892)
-- Dependencies: 242 5
-- Name: dbparametro_produto_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbparametro_produto_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4106 (class 0 OID 0)
-- Dependencies: 243
-- Name: dbparametro_produto_seq_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dbparametro_produto_seq_seq OWNED BY dbparametro_produto.seq;


--
-- TOC entry 244 (class 1259 OID 16894)
-- Dependencies: 5
-- Name: dbparcela_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbparcela_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 245 (class 1259 OID 16896)
-- Dependencies: 2891 2892 2893 2894 2895 2896 2897 2898 5
-- Name: dbparcela; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbparcela (
    seq integer DEFAULT nextval('dbparcela_seq_seq'::regclass) NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq bigint DEFAULT 0 NOT NULL,
    transeq bigint NOT NULL,
    plcoseq bigint NOT NULL,
    tipo character(1) NOT NULL,
    valorinicial real NOT NULL,
    valoratual real DEFAULT (0)::real NOT NULL,
    numero bigint,
    desconto real DEFAULT (0)::real,
    vencimento date DEFAULT ('now'::text)::date NOT NULL,
    obs text,
    stpaseq bigint DEFAULT 1 NOT NULL,
    datacad date DEFAULT ('now'::text)::date,
    instrucoespagamento text,
    statseq bigint DEFAULT 1 NOT NULL
);


--
-- TOC entry 4107 (class 0 OID 0)
-- Dependencies: 245
-- Name: COLUMN dbparcela.transeq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbparcela.transeq IS 'Sequencial da Transacao que a parcela pertence';


--
-- TOC entry 4108 (class 0 OID 0)
-- Dependencies: 245
-- Name: COLUMN dbparcela.plcoseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbparcela.plcoseq IS 'Sequencial do Plano de Contas';


--
-- TOC entry 4109 (class 0 OID 0)
-- Dependencies: 245
-- Name: COLUMN dbparcela.valoratual; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbparcela.valoratual IS 'Valor real da conta, considerando pagamentos parciais da conta.';


--
-- TOC entry 4110 (class 0 OID 0)
-- Dependencies: 245
-- Name: COLUMN dbparcela.stpaseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbparcela.stpaseq IS 'Sequencial da Situacao da conta';


--
-- TOC entry 246 (class 1259 OID 16910)
-- Dependencies: 5
-- Name: dbparcela_estorno_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbparcela_estorno_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 247 (class 1259 OID 16912)
-- Dependencies: 2899 2900 2901 2902 2903 2904 5
-- Name: dbparcela_estorno; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbparcela_estorno (
    seq integer DEFAULT nextval('dbparcela_estorno_seq_seq'::regclass) NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq bigint DEFAULT 0 NOT NULL,
    paorseq bigint NOT NULL,
    paatseq bigint NOT NULL,
    tiesseq bigint NOT NULL,
    valor real DEFAULT (0)::real NOT NULL,
    dataestorno date DEFAULT ('now'::text)::date NOT NULL,
    datacad date DEFAULT ('now'::text)::date,
    statseq bigint DEFAULT 1 NOT NULL
);


--
-- TOC entry 4111 (class 0 OID 0)
-- Dependencies: 247
-- Name: COLUMN dbparcela_estorno.paorseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbparcela_estorno.paorseq IS 'Sequencial da Parcela Original
';


--
-- TOC entry 4112 (class 0 OID 0)
-- Dependencies: 247
-- Name: COLUMN dbparcela_estorno.paatseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbparcela_estorno.paatseq IS 'Sequencial da parcela atual';


--
-- TOC entry 4113 (class 0 OID 0)
-- Dependencies: 247
-- Name: COLUMN dbparcela_estorno.tiesseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbparcela_estorno.tiesseq IS 'Sequencial do tipo de estorno';


--
-- TOC entry 248 (class 1259 OID 16921)
-- Dependencies: 5
-- Name: dbpatrimonio_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbpatrimonio_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 249 (class 1259 OID 16923)
-- Dependencies: 2905 2906 2907 2908 2909 2910 2911 2912 2913 2914 5
-- Name: dbpatrimonio; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbpatrimonio (
    seq integer DEFAULT nextval('dbpatrimonio_seq_seq'::regclass) NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq bigint DEFAULT 0 NOT NULL,
    funcseq bigint NOT NULL,
    prodseq bigint NOT NULL,
    modelo character varying(255),
    marca character varying(255),
    label character varying(255),
    descricao character varying(250),
    tipo character varying(80),
    datafabricacao date DEFAULT ('now'::text)::date,
    dataaquisicao date DEFAULT ('now'::text)::date,
    valornominal real DEFAULT (0)::real,
    salaseq bigint NOT NULL,
    valorcompra real DEFAULT (0)::real,
    numnf character varying(80),
    dataverificacao date DEFAULT ('now'::text)::date,
    foto character varying(255) DEFAULT '../app.view/app.images/imgnotfound.jpg'::character varying,
    obs text,
    datacad date DEFAULT ('now'::text)::date,
    statseq bigint DEFAULT 1 NOT NULL
);


--
-- TOC entry 4114 (class 0 OID 0)
-- Dependencies: 249
-- Name: COLUMN dbpatrimonio.funcseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbpatrimonio.funcseq IS 'Sequencial do funcionario responsavel pelo patrimonio';


--
-- TOC entry 4115 (class 0 OID 0)
-- Dependencies: 249
-- Name: COLUMN dbpatrimonio.prodseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbpatrimonio.prodseq IS 'Sequencial do produto que representa o patrimonio';


--
-- TOC entry 4116 (class 0 OID 0)
-- Dependencies: 249
-- Name: COLUMN dbpatrimonio.salaseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbpatrimonio.salaseq IS 'Sequencial da sala de alocacao do produto';


--
-- TOC entry 250 (class 1259 OID 16939)
-- Dependencies: 5
-- Name: dbpessoa_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbpessoa_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 251 (class 1259 OID 16941)
-- Dependencies: 2915 2916 2917 2918 2919 2920 2921 5
-- Name: dbpessoa; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbpessoa (
    seq integer DEFAULT nextval('dbpessoa_seq_seq'::regclass) NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq bigint,
    tipo character(1) DEFAULT 'F'::bpchar,
    pessnmrz character varying(160),
    pessnmrf numeric NOT NULL,
    pessrgie character varying(20),
    pessteim character varying(20),
    cliente boolean DEFAULT false,
    fornecedor boolean DEFAULT false,
    funcionario boolean DEFAULT false,
    datacad date DEFAULT ('now'::text)::date,
    foto text,
    statseq bigint DEFAULT 9 NOT NULL,
    email_principal character varying(180),
    email_secundario character varying(180)
);


--
-- TOC entry 4117 (class 0 OID 0)
-- Dependencies: 251
-- Name: COLUMN dbpessoa.statseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbpessoa.statseq IS 'Sequencial que identifica o status do registro';


--
-- TOC entry 252 (class 1259 OID 16954)
-- Dependencies: 5
-- Name: dbpessoa_fisica_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbpessoa_fisica_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 253 (class 1259 OID 16956)
-- Dependencies: 2922 2923 2924 2925 2926 5
-- Name: dbpessoa_fisica; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbpessoa_fisica (
    seq integer DEFAULT nextval('dbpessoa_fisica_seq_seq'::regclass) NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq bigint DEFAULT 0 NOT NULL,
    pessseq bigint NOT NULL,
    estadocivil character varying(100),
    etinia character varying(100),
    datanasc date DEFAULT ('now'::text)::date,
    sexo character varying(2),
    tiposanguineo character varying(5),
    nacionalidade character varying(100),
    portadornecessidades character varying(20),
    necessidadesespeciais text,
    numerodependentes character varying(10),
    cnh character varying(40),
    carteirareservista character varying(40),
    rendamensal real,
    datacad date DEFAULT ('now'::text)::date,
    statseq bigint DEFAULT 1 NOT NULL
);


--
-- TOC entry 4118 (class 0 OID 0)
-- Dependencies: 253
-- Name: COLUMN dbpessoa_fisica.pessseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbpessoa_fisica.pessseq IS 'identificador do sequencial a qual pessoa o registro pertence';


--
-- TOC entry 254 (class 1259 OID 16967)
-- Dependencies: 5
-- Name: dbpessoa_juridica_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbpessoa_juridica_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 255 (class 1259 OID 16969)
-- Dependencies: 2927 2928 2929 2930 2931 5
-- Name: dbpessoa_juridica; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbpessoa_juridica (
    seq integer DEFAULT nextval('dbpessoa_juridica_seq_seq'::regclass) NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq bigint DEFAULT 0 NOT NULL,
    pessseq bigint NOT NULL,
    datafundacao date DEFAULT ('now'::text)::date,
    gerente character varying(180),
    diretor character varying(180),
    representante character varying(180),
    datacad date DEFAULT ('now'::text)::date,
    statseq bigint DEFAULT 1 NOT NULL
);


--
-- TOC entry 4119 (class 0 OID 0)
-- Dependencies: 255
-- Name: COLUMN dbpessoa_juridica.pessseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbpessoa_juridica.pessseq IS 'identificador do sequencial a qual pessoa o registro pertence';


--
-- TOC entry 256 (class 1259 OID 16980)
-- Dependencies: 5
-- Name: dbpessoa_titularidade_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbpessoa_titularidade_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 257 (class 1259 OID 16982)
-- Dependencies: 2932 2933 2934 2935 5
-- Name: dbpessoa_titularidade; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbpessoa_titularidade (
    seq integer DEFAULT nextval('dbpessoa_titularidade_seq_seq'::regclass) NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq bigint NOT NULL,
    pessseq bigint NOT NULL,
    tituseq bigint NOT NULL,
    curso character varying(180) NOT NULL,
    instituicao character varying(180) DEFAULT '1'::character varying NOT NULL,
    anoconclusao numeric(4,0) NOT NULL,
    observacao text,
    datacad date DEFAULT ('now'::text)::date,
    statseq bigint DEFAULT 1 NOT NULL
);


--
-- TOC entry 4120 (class 0 OID 0)
-- Dependencies: 257
-- Name: COLUMN dbpessoa_titularidade.pessseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbpessoa_titularidade.pessseq IS 'identificador do sequencial a qual pessoa o registro pertence';


--
-- TOC entry 258 (class 1259 OID 16992)
-- Dependencies: 5
-- Name: dbpha_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbpha_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 259 (class 1259 OID 16994)
-- Dependencies: 2936 2937 2938 2939 5
-- Name: dbpha; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbpha (
    seq integer DEFAULT nextval('dbpha_seq_seq'::regclass) NOT NULL,
    unidseq bigint,
    usuaseq bigint DEFAULT 0,
    pha character varying(30),
    titulo character varying(200),
    datacad date DEFAULT ('now'::text)::date,
    statseq bigint DEFAULT 1
);


--
-- TOC entry 260 (class 1259 OID 17001)
-- Dependencies: 5
-- Name: dbplano_conta_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbplano_conta_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 261 (class 1259 OID 17003)
-- Dependencies: 2940 2941 2942 2943 2944 5
-- Name: dbplano_conta; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbplano_conta (
    seq integer DEFAULT nextval('dbplano_conta_seq_seq'::regclass) NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq bigint DEFAULT 0 NOT NULL,
    nomeconta character varying(60) NOT NULL,
    tipoconta character varying(1),
    tipocusto character varying(1) DEFAULT '-'::character varying NOT NULL,
    obs text,
    datacad date DEFAULT ('now'::text)::date,
    statseq bigint DEFAULT 1 NOT NULL
);


--
-- TOC entry 262 (class 1259 OID 17014)
-- Dependencies: 5
-- Name: dbprocesso_academico_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbprocesso_academico_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 263 (class 1259 OID 17016)
-- Dependencies: 2945 2946 2947 2948 5
-- Name: dbprocesso_academico; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbprocesso_academico (
    seq integer DEFAULT nextval('dbprocesso_academico_seq_seq'::regclass) NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq bigint DEFAULT 0 NOT NULL,
    titulo character varying(200) NOT NULL,
    procedimento text NOT NULL,
    requisitos text,
    alteratransacao boolean NOT NULL,
    datacad date DEFAULT ('now'::text)::date,
    formseq bigint NOT NULL,
    statseq bigint DEFAULT 1 NOT NULL
);


--
-- TOC entry 264 (class 1259 OID 17026)
-- Dependencies: 5
-- Name: dbproduto_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbproduto_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 265 (class 1259 OID 17028)
-- Dependencies: 2949 2950 2951 2952 2953 2954 5
-- Name: dbproduto; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbproduto (
    seq integer DEFAULT nextval('dbproduto_seq_seq'::regclass) NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq bigint DEFAULT 0 NOT NULL,
    label character varying(200),
    tpprseq bigint NOT NULL,
    descricao text,
    valor real DEFAULT (0)::real NOT NULL,
    valoralteravel boolean DEFAULT true NOT NULL,
    tabela character varying(30),
    obs text,
    datacad date DEFAULT ('now'::text)::date,
    statseq bigint DEFAULT 1 NOT NULL
);


--
-- TOC entry 266 (class 1259 OID 17040)
-- Dependencies: 5
-- Name: dbprofessor_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbprofessor_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 267 (class 1259 OID 17042)
-- Dependencies: 2955 2956 2957 2958 5
-- Name: dbprofessor; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbprofessor (
    seq integer DEFAULT nextval('dbprofessor_seq_seq'::regclass) NOT NULL,
    unidseq bigint,
    usuaseq bigint DEFAULT 0,
    pessseq bigint,
    curriculo text,
    datacad date DEFAULT ('now'::text)::date,
    statseq bigint DEFAULT 1
);


--
-- TOC entry 4121 (class 0 OID 0)
-- Dependencies: 267
-- Name: COLUMN dbprofessor.pessseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbprofessor.pessseq IS 'Sequencial da pessoa do papel de professor';


--
-- TOC entry 268 (class 1259 OID 17052)
-- Dependencies: 5
-- Name: dbprofessor_area_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbprofessor_area_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 269 (class 1259 OID 17054)
-- Dependencies: 2959 2960 2961 2962 5
-- Name: dbprofessor_area; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbprofessor_area (
    seq integer DEFAULT nextval('dbprofessor_area_seq_seq'::regclass) NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq bigint DEFAULT 0 NOT NULL,
    profseq bigint NOT NULL,
    arcuseq bigint NOT NULL,
    datacad date DEFAULT ('now'::text)::date,
    statseq bigint DEFAULT 1 NOT NULL
);


--
-- TOC entry 270 (class 1259 OID 17061)
-- Dependencies: 5
-- Name: dbprojeto_curso_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbprojeto_curso_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 271 (class 1259 OID 17063)
-- Dependencies: 2963 2964 2965 2966 2967 2968 5
-- Name: dbprojeto_curso; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbprojeto_curso (
    seq integer DEFAULT nextval('dbprojeto_curso_seq_seq'::regclass) NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq bigint DEFAULT 0 NOT NULL,
    nome character varying(200) NOT NULL,
    tpcuseq bigint NOT NULL,
    arcuseq bigint NOT NULL,
    objetivo text,
    publicoalvo text,
    mercadodetrabalho text,
    cargahoraria numeric,
    gdavseq bigint NOT NULL,
    datacad date DEFAULT ('now'::text)::date,
    statseq bigint DEFAULT 1 NOT NULL,
    stpcseq bigint DEFAULT 4 NOT NULL,
    identificador character varying(20) DEFAULT '--'::character varying NOT NULL
);


--
-- TOC entry 4122 (class 0 OID 0)
-- Dependencies: 271
-- Name: COLUMN dbprojeto_curso.tpcuseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbprojeto_curso.tpcuseq IS 'Sequencial do tipo de curso';


--
-- TOC entry 4123 (class 0 OID 0)
-- Dependencies: 271
-- Name: COLUMN dbprojeto_curso.arcuseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbprojeto_curso.arcuseq IS 'Sequencial da area do curso';


--
-- TOC entry 4124 (class 0 OID 0)
-- Dependencies: 271
-- Name: COLUMN dbprojeto_curso.gdavseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbprojeto_curso.gdavseq IS 'Sequencial da grade de avaliacoes do curso';


--
-- TOC entry 272 (class 1259 OID 17073)
-- Dependencies: 5
-- Name: dbprojeto_curso_disciplina_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbprojeto_curso_disciplina_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 273 (class 1259 OID 17075)
-- Dependencies: 2969 2970 2971 2972 5
-- Name: dbprojeto_curso_disciplina; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbprojeto_curso_disciplina (
    seq integer DEFAULT nextval('dbprojeto_curso_disciplina_seq_seq'::regclass) NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq bigint DEFAULT 0 NOT NULL,
    pjcuseq bigint NOT NULL,
    discseq bigint NOT NULL,
    datacad date DEFAULT ('now'::text)::date,
    statseq bigint DEFAULT 1 NOT NULL
);


--
-- TOC entry 4125 (class 0 OID 0)
-- Dependencies: 273
-- Name: COLUMN dbprojeto_curso_disciplina.pjcuseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbprojeto_curso_disciplina.pjcuseq IS 'Sequencial do projeto de curso';


--
-- TOC entry 4126 (class 0 OID 0)
-- Dependencies: 273
-- Name: COLUMN dbprojeto_curso_disciplina.discseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbprojeto_curso_disciplina.discseq IS 'Sequencial da dsiciplina';


--
-- TOC entry 274 (class 1259 OID 17082)
-- Dependencies: 5
-- Name: dbrecado_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbrecado_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 275 (class 1259 OID 17084)
-- Dependencies: 2973 2974 2975 2976 2977 2978 5
-- Name: dbrecado; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbrecado (
    seq integer DEFAULT nextval('dbrecado_seq_seq'::regclass) NOT NULL,
    unidseq bigint,
    usuaseq bigint DEFAULT 0,
    nomepessoa character varying(255),
    referencia character varying(255),
    interessado character varying(255),
    obs text,
    tel1 character varying(20),
    tel2 character varying(20),
    email character varying(255),
    datacad date DEFAULT ('now'::text)::date,
    situacao character varying(40) DEFAULT 'Aberto'::character varying,
    retorno date DEFAULT ('now'::text)::date,
    statseq bigint DEFAULT 1
);


--
-- TOC entry 276 (class 1259 OID 17096)
-- Dependencies: 5
-- Name: dbregra_avaliacao_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbregra_avaliacao_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 277 (class 1259 OID 17098)
-- Dependencies: 2979 2980 2981 2982 5
-- Name: dbregra_avaliacao; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbregra_avaliacao (
    seq integer DEFAULT nextval('dbregra_avaliacao_seq_seq'::regclass) NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq bigint DEFAULT 0 NOT NULL,
    titulo character varying(100) NOT NULL,
    observacoes text,
    datacad date DEFAULT ('now'::text)::date,
    statseq bigint DEFAULT 1 NOT NULL
);


--
-- TOC entry 278 (class 1259 OID 17108)
-- Dependencies: 5
-- Name: dbrequisito_turma_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbrequisito_turma_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 279 (class 1259 OID 17110)
-- Dependencies: 2983 2984 2985 2986 5
-- Name: dbrequisito_turma; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbrequisito_turma (
    seq integer DEFAULT nextval('dbrequisito_turma_seq_seq'::regclass) NOT NULL,
    unidseq bigint,
    usuaseq bigint DEFAULT 0,
    turmseq bigint,
    requisito character varying(60),
    obs text,
    datacad date DEFAULT ('now'::text)::date,
    statseq bigint DEFAULT 1
);


--
-- TOC entry 280 (class 1259 OID 17120)
-- Dependencies: 5
-- Name: dbsala_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbsala_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 281 (class 1259 OID 17122)
-- Dependencies: 2987 2988 2989 2990 2991 5
-- Name: dbsala; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbsala (
    seq integer DEFAULT nextval('dbsala_seq_seq'::regclass) NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq bigint DEFAULT 0 NOT NULL,
    nome character varying(160),
    endereco text,
    descricao text,
    salaaula boolean DEFAULT false,
    datacad date DEFAULT ('now'::text)::date,
    capacidade character varying(4),
    statseq bigint DEFAULT 1 NOT NULL
);


--
-- TOC entry 282 (class 1259 OID 17133)
-- Dependencies: 5
-- Name: dbsituacao_boleto_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbsituacao_boleto_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 283 (class 1259 OID 17135)
-- Dependencies: 2992 2993 5
-- Name: dbsituacao_boleto; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbsituacao_boleto (
    seq integer DEFAULT nextval('dbsituacao_boleto_seq_seq'::regclass) NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq bigint NOT NULL,
    titulo character varying(30),
    datacad date DEFAULT ('now'::text)::date,
    statseq bigint NOT NULL
);


--
-- TOC entry 284 (class 1259 OID 17140)
-- Dependencies: 5
-- Name: dbsituacao_caixa_funcionario_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbsituacao_caixa_funcionario_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 285 (class 1259 OID 17142)
-- Dependencies: 2994 2995 5
-- Name: dbsituacao_caixa_funcionario; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbsituacao_caixa_funcionario (
    seq integer DEFAULT nextval('dbsituacao_caixa_funcionario_seq_seq'::regclass) NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq bigint NOT NULL,
    titulo character varying(30),
    datacad date DEFAULT ('now'::text)::date,
    statseq bigint NOT NULL
);


--
-- TOC entry 286 (class 1259 OID 17147)
-- Dependencies: 5
-- Name: dbsituacao_movimento_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbsituacao_movimento_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 287 (class 1259 OID 17149)
-- Dependencies: 2996 2997 5
-- Name: dbsituacao_movimento; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbsituacao_movimento (
    seq integer DEFAULT nextval('dbsituacao_movimento_seq_seq'::regclass) NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq bigint NOT NULL,
    titulo character varying(30),
    datacad date DEFAULT ('now'::text)::date,
    statseq bigint NOT NULL
);


--
-- TOC entry 288 (class 1259 OID 17154)
-- Dependencies: 5
-- Name: dbsituacao_parcela_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbsituacao_parcela_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 289 (class 1259 OID 17156)
-- Dependencies: 2998 2999 5
-- Name: dbsituacao_parcela; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbsituacao_parcela (
    seq integer DEFAULT nextval('dbsituacao_parcela_seq_seq'::regclass) NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq bigint NOT NULL,
    titulo character varying(30),
    datacad date DEFAULT ('now'::text)::date,
    statseq bigint NOT NULL
);


--
-- TOC entry 290 (class 1259 OID 17161)
-- Dependencies: 5
-- Name: dbsituacao_turma_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbsituacao_turma_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 291 (class 1259 OID 17163)
-- Dependencies: 3000 3001 3002 3003 5
-- Name: dbsituacao_turma; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbsituacao_turma (
    seq integer DEFAULT nextval('dbsituacao_turma_seq_seq'::regclass) NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq bigint DEFAULT 0,
    titulo character varying(200) NOT NULL,
    datacad date DEFAULT ('now'::text)::date,
    statseq bigint DEFAULT 1 NOT NULL
);


--
-- TOC entry 292 (class 1259 OID 17170)
-- Dependencies: 5
-- Name: dbstatus_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbstatus_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 293 (class 1259 OID 17172)
-- Dependencies: 3004 3005 3006 5
-- Name: dbstatus; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbstatus (
    seq integer DEFAULT nextval('dbstatus_seq_seq'::regclass) NOT NULL,
    unidseq bigint,
    usuaseq bigint,
    statdesc character varying(80) NOT NULL,
    datacad date DEFAULT ('now'::text)::date,
    statseq bigint DEFAULT 9
);


--
-- TOC entry 294 (class 1259 OID 17178)
-- Dependencies: 5
-- Name: dbtelefone_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbtelefone_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 295 (class 1259 OID 17180)
-- Dependencies: 3007 3008 5
-- Name: dbtelefone; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbtelefone (
    seq integer DEFAULT nextval('dbtelefone_seq_seq'::regclass) NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq bigint NOT NULL,
    pessseq bigint NOT NULL,
    telefone numeric NOT NULL,
    codigoarea numeric NOT NULL,
    datacad date DEFAULT ('now'::text)::date,
    statseq bigint NOT NULL,
    tpteseq integer
);


--
-- TOC entry 296 (class 1259 OID 17188)
-- Dependencies: 5
-- Name: dbtipo_convenio_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbtipo_convenio_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 297 (class 1259 OID 17190)
-- Dependencies: 3009 3010 5
-- Name: dbtipo_convenio; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbtipo_convenio (
    seq integer DEFAULT nextval('dbtipo_convenio_seq_seq'::regclass) NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq bigint NOT NULL,
    titulo character varying(30),
    datacad date DEFAULT ('now'::text)::date,
    statseq bigint NOT NULL
);


--
-- TOC entry 298 (class 1259 OID 17195)
-- Dependencies: 5
-- Name: dbtipo_curso_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbtipo_curso_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 299 (class 1259 OID 17197)
-- Dependencies: 3011 3012 3013 3014 5
-- Name: dbtipo_curso; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbtipo_curso (
    seq integer DEFAULT nextval('dbtipo_curso_seq_seq'::regclass) NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq bigint DEFAULT 0 NOT NULL,
    titulo character varying(200) NOT NULL,
    obs text,
    datacad date DEFAULT ('now'::text)::date,
    statseq bigint DEFAULT 1 NOT NULL
);


--
-- TOC entry 300 (class 1259 OID 17207)
-- Dependencies: 5
-- Name: dbtipo_estorno_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbtipo_estorno_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 301 (class 1259 OID 17209)
-- Dependencies: 3015 3016 5
-- Name: dbtipo_estorno; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbtipo_estorno (
    seq integer DEFAULT nextval('dbtipo_estorno_seq_seq'::regclass) NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq bigint NOT NULL,
    titulo character varying(30),
    datacad date DEFAULT ('now'::text)::date,
    statseq bigint NOT NULL
);


--
-- TOC entry 302 (class 1259 OID 17214)
-- Dependencies: 3017 5
-- Name: dbtipo_produto; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbtipo_produto (
    seq integer NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq bigint NOT NULL,
    titulo character varying(30),
    datacad date DEFAULT ('now'::text)::date,
    statseq bigint NOT NULL
);


--
-- TOC entry 303 (class 1259 OID 17218)
-- Dependencies: 3018 5
-- Name: dbtipo_telefone; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbtipo_telefone (
    seq integer NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq bigint NOT NULL,
    tptedesc character varying(40) NOT NULL,
    prioridade numeric NOT NULL,
    datacad date DEFAULT ('now'::text)::date,
    statseq bigint NOT NULL
);


--
-- TOC entry 304 (class 1259 OID 17225)
-- Dependencies: 5
-- Name: dbtitularidade_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbtitularidade_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 305 (class 1259 OID 17227)
-- Dependencies: 3019 3020 3021 3022 5
-- Name: dbtitularidade; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbtitularidade (
    seq integer DEFAULT nextval('dbtitularidade_seq_seq'::regclass) NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq bigint DEFAULT 0 NOT NULL,
    titulo character varying(200) NOT NULL,
    nomeacao character varying(20) NOT NULL,
    descricao text,
    peso smallint NOT NULL,
    datacad date DEFAULT ('now'::text)::date,
    statseq bigint DEFAULT 1 NOT NULL
);


--
-- TOC entry 306 (class 1259 OID 17237)
-- Dependencies: 5
-- Name: dbtransacao_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbtransacao_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 307 (class 1259 OID 17239)
-- Dependencies: 3023 3024 3025 3026 3027 3028 3029 3030 3031 3032 3033 3034 5
-- Name: dbtransacao; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbtransacao (
    seq integer DEFAULT nextval('dbtransacao_seq_seq'::regclass) NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq bigint DEFAULT 0 NOT NULL,
    pessseq bigint NOT NULL,
    valortotal real,
    desconto real DEFAULT (0)::real,
    acrescimo real DEFAULT (0)::real,
    valorcorrigido real DEFAULT (0)::real,
    formapag character varying(255),
    plcoseq bigint NOT NULL,
    numparcelas character varying(20) DEFAULT '0'::character varying,
    intervaloparcelas bigint DEFAULT 0,
    datafixavencimento boolean DEFAULT false NOT NULL,
    vencimento date DEFAULT ('now'::text)::date NOT NULL,
    efetivada character varying(2) DEFAULT '0'::character varying,
    datacad date DEFAULT ('now'::text)::date,
    obs text,
    statseq bigint DEFAULT 1 NOT NULL
);


--
-- TOC entry 308 (class 1259 OID 17257)
-- Dependencies: 5
-- Name: dbtransacao_aluno_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbtransacao_aluno_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 309 (class 1259 OID 17259)
-- Dependencies: 3035 3036 3037 3038 5
-- Name: dbtransacao_aluno; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbtransacao_aluno (
    seq integer DEFAULT nextval('dbtransacao_aluno_seq_seq'::regclass) NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq bigint DEFAULT 0 NOT NULL,
    alunseq bigint NOT NULL,
    transeq bigint NOT NULL,
    datacad date DEFAULT ('now'::text)::date,
    statseq bigint DEFAULT 1 NOT NULL
);


--
-- TOC entry 310 (class 1259 OID 17266)
-- Dependencies: 5
-- Name: dbtransacao_convenio_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbtransacao_convenio_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 311 (class 1259 OID 17268)
-- Dependencies: 3039 3040 3041 3042 5
-- Name: dbtransacao_convenio; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbtransacao_convenio (
    seq integer DEFAULT nextval('dbtransacao_convenio_seq_seq'::regclass) NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq bigint DEFAULT 0 NOT NULL,
    transeq bigint NOT NULL,
    convseq bigint NOT NULL,
    datacad date DEFAULT ('now'::text)::date,
    statseq bigint DEFAULT 1 NOT NULL
);


--
-- TOC entry 4127 (class 0 OID 0)
-- Dependencies: 311
-- Name: COLUMN dbtransacao_convenio.transeq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbtransacao_convenio.transeq IS 'Sequencial da transacao associada';


--
-- TOC entry 4128 (class 0 OID 0)
-- Dependencies: 311
-- Name: COLUMN dbtransacao_convenio.convseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbtransacao_convenio.convseq IS 'Sequencial do convenio associado';


--
-- TOC entry 312 (class 1259 OID 17275)
-- Dependencies: 5
-- Name: dbtransacao_produto_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbtransacao_produto_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 313 (class 1259 OID 17277)
-- Dependencies: 3043 3044 3045 3046 3047 3048 5
-- Name: dbtransacao_produto; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbtransacao_produto (
    seq integer DEFAULT nextval('dbtransacao_produto_seq_seq'::regclass) NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq bigint DEFAULT 0 NOT NULL,
    transeq bigint NOT NULL,
    prodseq bigint NOT NULL,
    tabelaproduto character varying(30),
    valornominal real DEFAULT (0)::real NOT NULL,
    quantidade numeric DEFAULT 1.00 NOT NULL,
    obs text,
    datacad date DEFAULT ('now'::text)::date,
    statseq bigint DEFAULT 1 NOT NULL
);


--
-- TOC entry 4129 (class 0 OID 0)
-- Dependencies: 313
-- Name: COLUMN dbtransacao_produto.transeq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbtransacao_produto.transeq IS 'Sequencial da transacao em que o produto esta envolvido';


--
-- TOC entry 4130 (class 0 OID 0)
-- Dependencies: 313
-- Name: COLUMN dbtransacao_produto.prodseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbtransacao_produto.prodseq IS 'Sequencial do produto envolvido';


--
-- TOC entry 314 (class 1259 OID 17289)
-- Dependencies: 5
-- Name: dbtreinamento_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbtreinamento_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 315 (class 1259 OID 17291)
-- Dependencies: 3049 3050 3051 3052 5
-- Name: dbtreinamento; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbtreinamento (
    seq integer DEFAULT nextval('dbtreinamento_seq_seq'::regclass) NOT NULL,
    unidseq bigint,
    usuaseq bigint DEFAULT 0,
    nomecurso character varying(80) NOT NULL,
    ementa text,
    cargahoraria character varying(5) NOT NULL,
    ministrante character varying(80),
    tituseq bigint,
    curriculoministrante text,
    instituicaocertificadora character varying(160),
    datacad date DEFAULT ('now'::text)::date,
    statseq bigint DEFAULT 1
);


--
-- TOC entry 316 (class 1259 OID 17301)
-- Dependencies: 5
-- Name: dbturma_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbturma_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 317 (class 1259 OID 17303)
-- Dependencies: 3053 3054 3055 3056 3057 3058 3059 3060 3061 3062 3063 3064 3065 3066 3067 3068 3069 3070 3071 3072 3073 3074 3075 3076 3077 5
-- Name: dbturma; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbturma (
    seq integer DEFAULT nextval('dbturma_seq_seq'::regclass) NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq bigint DEFAULT 0 NOT NULL,
    prodseq bigint NOT NULL,
    titulo character varying(150) DEFAULT '-'::character varying NOT NULL,
    cursseq bigint NOT NULL,
    cargahoraria numeric,
    plcoseq bigint NOT NULL,
    datainicio date DEFAULT ('now'::text)::date NOT NULL,
    datafim date DEFAULT ('now'::text)::date NOT NULL,
    frequenciaaula character varying(80),
    horainicio time without time zone NOT NULL,
    horafim time without time zone NOT NULL,
    diasaula character varying(200) NOT NULL,
    unalseq bigint,
    valortotal real DEFAULT (0)::real NOT NULL,
    valortaxa real DEFAULT 0,
    valormatricula real DEFAULT (0)::real NOT NULL,
    valormensal real DEFAULT (0)::real,
    parcelas numeric DEFAULT 1 NOT NULL,
    datainiciovencimentos date DEFAULT ('now'::text)::date NOT NULL,
    custolanche real DEFAULT (0)::real,
    custovaletransporte real DEFAULT (0)::real,
    custoapostila real DEFAULT (0)::real,
    custobrinde real DEFAULT (0)::real,
    custoparceiro real DEFAULT (0)::real,
    custoaluguel real DEFAULT (0)::real,
    custocertificado real DEFAULT (0)::real,
    custodiversos real DEFAULT (0)::real,
    pessseq bigint DEFAULT 0 NOT NULL,
    sttuseq bigint DEFAULT 0 NOT NULL,
    padraovencimento numeric DEFAULT 0,
    aceitainscricao boolean DEFAULT true NOT NULL,
    vagas numeric NOT NULL,
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    statseq bigint DEFAULT 1 NOT NULL,
    localaulas character varying(200)
);


--
-- TOC entry 4131 (class 0 OID 0)
-- Dependencies: 317
-- Name: COLUMN dbturma.prodseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbturma.prodseq IS 'Sequencial do produto que representa a conta financeiramente';


--
-- TOC entry 4132 (class 0 OID 0)
-- Dependencies: 317
-- Name: COLUMN dbturma.cursseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbturma.cursseq IS 'Sequencial do Curso que represetna a Turma';


--
-- TOC entry 4133 (class 0 OID 0)
-- Dependencies: 317
-- Name: COLUMN dbturma.unalseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbturma.unalseq IS 'unidseq em que as aulas ocorrerao';


--
-- TOC entry 4134 (class 0 OID 0)
-- Dependencies: 317
-- Name: COLUMN dbturma.pessseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbturma.pessseq IS 'Sequencial que identeifica a pessoa coordenadora da Turma';


--
-- TOC entry 4135 (class 0 OID 0)
-- Dependencies: 317
-- Name: COLUMN dbturma.sttuseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbturma.sttuseq IS 'Sequencial da situacao da turma';


--
-- TOC entry 318 (class 1259 OID 17334)
-- Dependencies: 5
-- Name: dbturma_convenio_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbturma_convenio_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 319 (class 1259 OID 17336)
-- Dependencies: 3078 3079 3080 3081 5
-- Name: dbturma_convenio; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbturma_convenio (
    seq integer DEFAULT nextval('dbturma_convenio_seq_seq'::regclass) NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq bigint DEFAULT 0 NOT NULL,
    turmseq bigint NOT NULL,
    convseq bigint NOT NULL,
    datacad date DEFAULT ('now'::text)::date,
    statseq bigint DEFAULT 1 NOT NULL
);


--
-- TOC entry 4136 (class 0 OID 0)
-- Dependencies: 319
-- Name: COLUMN dbturma_convenio.turmseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbturma_convenio.turmseq IS 'Sequencial da turma';


--
-- TOC entry 4137 (class 0 OID 0)
-- Dependencies: 319
-- Name: COLUMN dbturma_convenio.convseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbturma_convenio.convseq IS 'Sequencial do convenio';


--
-- TOC entry 320 (class 1259 OID 17343)
-- Dependencies: 5
-- Name: dbturma_disciplina_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbturma_disciplina_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 321 (class 1259 OID 17345)
-- Dependencies: 3082 3083 3084 3085 3086 3087 3088 3089 3090 3091 3092 5
-- Name: dbturma_disciplina; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbturma_disciplina (
    seq integer DEFAULT nextval('dbturma_disciplina_seq_seq'::regclass) NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq bigint DEFAULT 0 NOT NULL,
    turmseq bigint NOT NULL,
    discseq bigint NOT NULL,
    profseq bigint,
    salaseq bigint,
    datarealizacao date DEFAULT ('now'::text)::date,
    dataatualizacao date DEFAULT ('now'::text)::date,
    frequencia numeric NOT NULL,
    datas text,
    gdavseq bigint,
    custohoraaula real DEFAULT (0)::real,
    custohospedagem real DEFAULT (0)::real,
    custodeslocamento real DEFAULT (0)::real,
    custoalimentacao real DEFAULT (0)::real,
    custoextra real DEFAULT (0)::real,
    regimetrabalho character varying(80),
    datacad date DEFAULT ('now'::text)::date,
    statseq bigint DEFAULT 1 NOT NULL
);


--
-- TOC entry 4138 (class 0 OID 0)
-- Dependencies: 321
-- Name: COLUMN dbturma_disciplina.turmseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbturma_disciplina.turmseq IS 'Sequencial da turma';


--
-- TOC entry 4139 (class 0 OID 0)
-- Dependencies: 321
-- Name: COLUMN dbturma_disciplina.discseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbturma_disciplina.discseq IS 'Sequencial da disciplina';


--
-- TOC entry 4140 (class 0 OID 0)
-- Dependencies: 321
-- Name: COLUMN dbturma_disciplina.profseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbturma_disciplina.profseq IS 'Sequencial do professor';


--
-- TOC entry 4141 (class 0 OID 0)
-- Dependencies: 321
-- Name: COLUMN dbturma_disciplina.salaseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbturma_disciplina.salaseq IS 'Sequencial da Sala';


--
-- TOC entry 4142 (class 0 OID 0)
-- Dependencies: 321
-- Name: COLUMN dbturma_disciplina.gdavseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbturma_disciplina.gdavseq IS 'Sequencial da grade de avaliacoes';


--
-- TOC entry 322 (class 1259 OID 17362)
-- Dependencies: 5
-- Name: dbturma_disciplina_arquivo_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbturma_disciplina_arquivo_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 323 (class 1259 OID 17364)
-- Dependencies: 3093 3094 3095 3096 3097 5
-- Name: dbturma_disciplina_arquivo; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbturma_disciplina_arquivo (
    seq integer DEFAULT nextval('dbturma_disciplina_arquivo_seq_seq'::regclass) NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq bigint DEFAULT 0 NOT NULL,
    tipo character(1) DEFAULT '1'::bpchar NOT NULL,
    tudiseq bigint NOT NULL,
    profseq bigint NOT NULL,
    titulo character varying(200) NOT NULL,
    obs text,
    arquivo text,
    datacad date DEFAULT ('now'::text)::date,
    statseq bigint DEFAULT 1 NOT NULL
);


--
-- TOC entry 4143 (class 0 OID 0)
-- Dependencies: 323
-- Name: COLUMN dbturma_disciplina_arquivo.tudiseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbturma_disciplina_arquivo.tudiseq IS 'Sequencial da turma x disciplina';


--
-- TOC entry 4144 (class 0 OID 0)
-- Dependencies: 323
-- Name: COLUMN dbturma_disciplina_arquivo.profseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbturma_disciplina_arquivo.profseq IS 'Sequencial do professor';


--
-- TOC entry 324 (class 1259 OID 17375)
-- Dependencies: 5
-- Name: dbturma_disciplina_aula_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbturma_disciplina_aula_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 325 (class 1259 OID 17377)
-- Dependencies: 3098 3099 3100 3101 3102 3103 5
-- Name: dbturma_disciplina_aula; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbturma_disciplina_aula (
    seq integer DEFAULT nextval('dbturma_disciplina_aula_seq_seq'::regclass) NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq bigint DEFAULT 0 NOT NULL,
    tudiseq bigint NOT NULL,
    dataaula date DEFAULT ('now'::text)::date NOT NULL,
    conteudo text,
    frequencia numeric DEFAULT 1 NOT NULL,
    obs text,
    datacad date DEFAULT ('now'::text)::date,
    statseq bigint DEFAULT 1 NOT NULL
);


--
-- TOC entry 4145 (class 0 OID 0)
-- Dependencies: 325
-- Name: COLUMN dbturma_disciplina_aula.tudiseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbturma_disciplina_aula.tudiseq IS 'Sequencial da turma x disciplina';


--
-- TOC entry 326 (class 1259 OID 17389)
-- Dependencies: 5
-- Name: dbturma_disciplina_avaliacao_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbturma_disciplina_avaliacao_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 327 (class 1259 OID 17391)
-- Dependencies: 3104 3105 3106 3107 5
-- Name: dbturma_disciplina_avaliacao; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbturma_disciplina_avaliacao (
    seq integer DEFAULT nextval('dbturma_disciplina_avaliacao_seq_seq'::regclass) NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq bigint DEFAULT 0 NOT NULL,
    tudiseq bigint NOT NULL,
    avalseq bigint NOT NULL,
    descricao text,
    porcentagem numeric NOT NULL,
    datacad date DEFAULT ('now'::text)::date,
    statseq bigint DEFAULT 1 NOT NULL
);


--
-- TOC entry 4146 (class 0 OID 0)
-- Dependencies: 327
-- Name: COLUMN dbturma_disciplina_avaliacao.tudiseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbturma_disciplina_avaliacao.tudiseq IS 'Sequencial da turma x disciplina';


--
-- TOC entry 328 (class 1259 OID 17401)
-- Dependencies: 5
-- Name: dbturma_disciplina_material_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbturma_disciplina_material_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 329 (class 1259 OID 17403)
-- Dependencies: 3108 3109 3110 3111 3112 5
-- Name: dbturma_disciplina_material; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbturma_disciplina_material (
    seq integer DEFAULT nextval('dbturma_disciplina_material_seq_seq'::regclass) NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq bigint DEFAULT 0 NOT NULL,
    tudiseq bigint NOT NULL,
    titulo character varying(180) NOT NULL,
    descricao text,
    custo real DEFAULT (0)::real NOT NULL,
    datacad date DEFAULT ('now'::text)::date,
    statseq bigint DEFAULT 1 NOT NULL
);


--
-- TOC entry 4147 (class 0 OID 0)
-- Dependencies: 329
-- Name: COLUMN dbturma_disciplina_material.tudiseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbturma_disciplina_material.tudiseq IS 'Sequencial da turma x disciplina';


--
-- TOC entry 330 (class 1259 OID 17414)
-- Dependencies: 5
-- Name: dbturma_disciplina_planoaula_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbturma_disciplina_planoaula_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 331 (class 1259 OID 17416)
-- Dependencies: 3113 3114 3115 3116 3117 5
-- Name: dbturma_disciplina_planoaula; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbturma_disciplina_planoaula (
    seq integer DEFAULT nextval('dbturma_disciplina_planoaula_seq_seq'::regclass) NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq bigint DEFAULT 0 NOT NULL,
    tudiseq bigint NOT NULL,
    profseq bigint NOT NULL,
    dataaula date DEFAULT ('now'::text)::date NOT NULL,
    conteudo text,
    recursos text,
    metodologia text,
    datacad date DEFAULT ('now'::text)::date,
    statseq bigint DEFAULT 1 NOT NULL
);


--
-- TOC entry 4148 (class 0 OID 0)
-- Dependencies: 331
-- Name: COLUMN dbturma_disciplina_planoaula.tudiseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbturma_disciplina_planoaula.tudiseq IS 'Sequencial da turma x disciplina';


--
-- TOC entry 4149 (class 0 OID 0)
-- Dependencies: 331
-- Name: COLUMN dbturma_disciplina_planoaula.profseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbturma_disciplina_planoaula.profseq IS 'Sequencial do professor';


--
-- TOC entry 332 (class 1259 OID 17427)
-- Dependencies: 5
-- Name: dbunidade_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbunidade_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 333 (class 1259 OID 17429)
-- Dependencies: 3118 3119 3120 5
-- Name: dbunidade; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbunidade (
    seq integer DEFAULT nextval('dbunidade_seq_seq'::regclass) NOT NULL,
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
-- TOC entry 4150 (class 0 OID 0)
-- Dependencies: 333
-- Name: TABLE dbunidade; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE dbunidade IS 'Empresas cadastradas no sistema';


--
-- TOC entry 334 (class 1259 OID 17438)
-- Dependencies: 5
-- Name: dbunidade_parametro_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbunidade_parametro_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 335 (class 1259 OID 17440)
-- Dependencies: 3121 3122 3123 3124 5
-- Name: dbunidade_parametro; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbunidade_parametro (
    seq integer DEFAULT nextval('dbunidade_parametro_seq_seq'::regclass) NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq bigint DEFAULT 0 NOT NULL,
    parametro character varying(60) NOT NULL,
    valor character varying(180) NOT NULL,
    obs text,
    datacad date DEFAULT ('now'::text)::date,
    statseq bigint DEFAULT 1 NOT NULL
);


--
-- TOC entry 336 (class 1259 OID 17450)
-- Dependencies: 5
-- Name: dbusuario_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbusuario_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 337 (class 1259 OID 17452)
-- Dependencies: 3125 3126 3127 3128 3129 3130 5
-- Name: dbusuario; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbusuario (
    seq integer DEFAULT nextval('dbusuario_seq_seq'::regclass) NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq bigint DEFAULT 0,
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
-- TOC entry 4151 (class 0 OID 0)
-- Dependencies: 337
-- Name: TABLE dbusuario; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE dbusuario IS 'Armazena os usuarios do sistema';


--
-- TOC entry 338 (class 1259 OID 17461)
-- Dependencies: 5
-- Name: dbusuario_privilegio_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dbusuario_privilegio_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 339 (class 1259 OID 17463)
-- Dependencies: 3131 3132 3133 3134 3135 3136 5
-- Name: dbusuario_privilegio; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dbusuario_privilegio (
    seq integer DEFAULT nextval('dbusuario_privilegio_seq_seq'::regclass) NOT NULL,
    unidseq bigint NOT NULL,
    usuaseq bigint DEFAULT 0 NOT NULL,
    funcionalidade bigint DEFAULT 0 NOT NULL,
    modulo bigint NOT NULL,
    nivel bigint DEFAULT 0 NOT NULL,
    datacad date DEFAULT ('now'::text)::date NOT NULL,
    statseq bigint DEFAULT 1 NOT NULL
);


--
-- TOC entry 4152 (class 0 OID 0)
-- Dependencies: 339
-- Name: COLUMN dbusuario_privilegio.usuaseq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbusuario_privilegio.usuaseq IS 'Identificador do sequencial do usuario privilegiado';


--
-- TOC entry 4153 (class 0 OID 0)
-- Dependencies: 339
-- Name: COLUMN dbusuario_privilegio.funcionalidade; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbusuario_privilegio.funcionalidade IS 'Id da funcionalidade sobre a qual o privilegio se associa.
Caso a funcionalidade seja o modulo principal o valor padrão é [0]';


--
-- TOC entry 4154 (class 0 OID 0)
-- Dependencies: 339
-- Name: COLUMN dbusuario_privilegio.nivel; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN dbusuario_privilegio.nivel IS 'Nivel de acesso na hierarquia do sistema

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
-- TOC entry 340 (class 1259 OID 17472)
-- Dependencies: 3792 5
-- Name: view_aluno; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_aluno AS
    SELECT t0.seq, t0.unidseq, t0.usuaseq, t0.pessseq, t0.transeq, t0.turmseq, t0.cursseq, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, t999.seq AS statseq, t999.statdesc, t2.titulo AS nometurma, t3.nomeunidade, t6.pessnmrz AS nomepessoa, t4.nome AS nomecurso FROM (((((dbaluno t0 LEFT JOIN dbturma t2 ON ((t2.seq = t0.turmseq))) LEFT JOIN dbunidade t3 ON ((t3.seq = t0.unidseq))) LEFT JOIN dbprojeto_curso t4 ON ((t4.seq = (SELECT t5.pjcuseq FROM dbcurso t5 WHERE (t5.seq = (SELECT t7.cursseq FROM dbturma t7 WHERE (t7.seq = t0.turmseq))))))) LEFT JOIN dbpessoa t6 ON ((t6.seq = t0.pessseq))) LEFT JOIN dbstatus t999 ON ((t999.seq = t0.statseq)));


--
-- TOC entry 341 (class 1259 OID 17477)
-- Dependencies: 3793 5
-- Name: view_aluno_disciplina; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_aluno_disciplina AS
    SELECT t1.seq, t1.unidseq, t1.usuaseq, t1.alunseq, t1.discseq, t1.tudiseq, t1.stadseq, t1.obs, to_char((t1.dataalteracao)::timestamp with time zone, 'DD/MM/YYYY'::text) AS dataalteracao, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, t999.seq AS statseq, t999.statdesc, t5.titulo AS nometurma, t6.titulo AS nomedisciplina, t2.pessseq, t3.pessnmrz AS nomepessoa, t9.nome AS nomecurso, t8.seq AS cursseq, t5.seq AS turmseq, t9.gdavseq FROM ((((((((dbaluno_disciplina t1 LEFT JOIN dbaluno t2 ON ((t2.seq = t1.alunseq))) LEFT JOIN dbpessoa t3 ON ((t3.seq = t2.pessseq))) LEFT JOIN dbstatus t999 ON ((t999.seq = t1.statseq))) LEFT JOIN dbturma_disciplina t4 ON ((t4.seq = t1.tudiseq))) LEFT JOIN dbturma t5 ON ((t5.seq = t4.turmseq))) LEFT JOIN dbdisciplina t6 ON ((t6.seq = t1.discseq))) LEFT JOIN dbcurso t8 ON ((t8.seq = t5.cursseq))) LEFT JOIN dbprojeto_curso t9 ON ((t9.seq = t8.pjcuseq)));


--
-- TOC entry 342 (class 1259 OID 17482)
-- Dependencies: 3794 5
-- Name: view_aluno_solicitacao; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_aluno_solicitacao AS
    SELECT t0.seq, t0.unidseq, t0.usuaseq, t0.alunseq, t0.seq AS soliseq, t0.data, t0.justificativa, t0.atendimento, t0.pessseq, t0.deptseq, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, t999.seq AS statseq, t999.statdesc, t0.stslseq, t4.pessnmrz AS nomealuno, t3.pessnmrz AS nomefuncionario, t5.label AS nomedepartamento, t0.solicitacao FROM (((((dbaluno_solicitacao t0 LEFT JOIN dbaluno t2 ON ((t2.seq = t0.alunseq))) LEFT JOIN dbpessoa t4 ON ((t4.seq = t2.pessseq))) LEFT JOIN dbpessoa t3 ON ((t3.seq = t0.pessseq))) LEFT JOIN dbdepartamento t5 ON ((t5.seq = t0.deptseq))) LEFT JOIN dbstatus t999 ON ((t999.seq = t0.statseq)));


--
-- TOC entry 343 (class 1259 OID 17487)
-- Dependencies: 3795 5
-- Name: view_area_curso; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_area_curso AS
    SELECT t1.seq, t1.unidseq, t1.usuaseq, t1.titulo, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, t999.seq AS statseq, t999.statdesc FROM (dbarea_curso t1 LEFT JOIN dbstatus t999 ON ((t999.seq = t1.statseq)));


--
-- TOC entry 344 (class 1259 OID 17491)
-- Dependencies: 3796 5
-- Name: view_boleto; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_boleto AS
    SELECT t1.seq, t1.unidseq, t1.usuaseq, t1.parcseq, t2.transeq, t3.pessseq, t1.ndocumento, t1.dataprocesso, t1.cpfsacado, t1.valordoc, t1.vencimento, t1.databaixa, t1.stboseq, t1.tipoboleto, t1.classificacao, t1.bkp, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, t999.seq AS statseq, t999.statdesc FROM (((dbboleto t1 LEFT JOIN dbparcela t2 ON ((t2.seq = t1.parcseq))) LEFT JOIN dbtransacao t3 ON ((t3.seq = t2.transeq))) LEFT JOIN dbstatus t999 ON ((t999.seq = t1.statseq)));


--
-- TOC entry 345 (class 1259 OID 17496)
-- Dependencies: 3797 5
-- Name: view_caixa; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_caixa AS
    SELECT t0.seq, t0.unidseq, t0.usuaseq, t0.parcseq, t0.plcoseq, t0.cofiseq, t5.nomeconta, t6.pessseq, t4.transeq, t7.ndocumento, to_char((t7.databaixa)::timestamp with time zone, 'DD/MM/YYYY'::text) AS databaixa, t0.tipo, t7.tipoboleto, t0.valor, to_char((t0.vencimento)::timestamp with time zone, 'DD/MM/YYYY'::text) AS vencimento, t0.formadesconto, t0.desconto, t0.acrescimo, t0.valorfinal, t0.valorentrada, t0.cxfuseq, t0.datapag, t0.fmpgseq, t0.obs, t0.stmoseq, t0.stpaseq, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, t999.seq AS statseq, t999.statdesc, t2.nomeconta AS nomeplanoconta, t3.pessnmrz AS nomepessoa, t0.fecfseq, t8.funcseq, t9.titulo AS formapag FROM (((((((((dbcaixa t0 LEFT JOIN dbconta_financeira t5 ON ((t5.seq = t0.cofiseq))) LEFT JOIN dbplano_conta t2 ON ((t2.seq = t0.plcoseq))) LEFT JOIN dbparcela t4 ON ((t4.seq = t0.parcseq))) LEFT JOIN dbtransacao t6 ON ((t6.seq = t4.transeq))) LEFT JOIN dbpessoa t3 ON ((t3.seq = t6.pessseq))) LEFT JOIN dbcaixa_funcionario t8 ON ((t8.seq = t0.cxfuseq))) LEFT JOIN dbboleto t7 ON ((t7.seq = t0.boleseq))) LEFT JOIN dbforma_pagamento t9 ON ((t9.seq = t0.fmpgseq))) LEFT JOIN dbstatus t999 ON ((t999.seq = t0.statseq)));


--
-- TOC entry 346 (class 1259 OID 17501)
-- Dependencies: 3798 5
-- Name: view_funcionario; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_funcionario AS
    SELECT t0.seq, t2.seq AS funcseq, t0.unidseq, t0.pessnmrz AS nomefuncionario, t0.pessnmrf, t2.cargseq, t3.nomecargo, t2.deptseq, t4.label AS nomedepartamento, t5.nome AS sala, t5.nome AS nomesala, to_char((t2.dataadmissao)::timestamp with time zone, 'DD/MM/YYYY'::text) AS dataadmissao, t2.statseq AS situacao, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, t999.seq AS statseq, t999.statdesc, t6.telefone AS telefone1, t7.telefone AS telefone2, t0.email_principal, t0.email_secundario FROM (((((((dbpessoa t0 LEFT JOIN dbfuncionario t2 ON ((t2.pessseq = t0.seq))) LEFT JOIN dbcargo t3 ON ((t3.seq = t2.cargseq))) LEFT JOIN dbdepartamento t4 ON ((t4.seq = t2.deptseq))) LEFT JOIN dbsala t5 ON ((t5.seq = t4.salaseq))) LEFT JOIN dbstatus t999 ON ((t999.seq = t0.statseq))) LEFT JOIN dbtelefone t6 ON (((t6.pessseq = t0.seq) AND (t6.tpteseq = 1)))) LEFT JOIN dbtelefone t7 ON (((t7.pessseq = t0.seq) AND (t7.tpteseq = 2)))) WHERE (t0.seq = t2.pessseq);


--
-- TOC entry 347 (class 1259 OID 17506)
-- Dependencies: 3799 5
-- Name: view_caixa_funcionario; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_caixa_funcionario AS
    SELECT t1.seq, t1.unidseq, t1.usuaseq, t1.funcseq, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, t999.seq AS statseq, t999.statdesc, t1.obs, t2.nomefuncionario, t2.pessnmrf, t2.cargseq, t2.nomecargo, t1.stcfseq, t1.cofiseq, (((t3.tipo)::text || ' - '::text) || (t3.nomeconta)::text) AS nomecontacaixa FROM (((dbcaixa_funcionario t1 LEFT JOIN view_funcionario t2 ON ((t2.funcseq = t1.funcseq))) LEFT JOIN dbconta_financeira t3 ON ((t3.seq = t1.cofiseq))) LEFT JOIN dbstatus t999 ON ((t999.seq = t1.statseq)));


--
-- TOC entry 348 (class 1259 OID 17511)
-- Dependencies: 3800 5
-- Name: view_cargo; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_cargo AS
    SELECT t1.seq, t1.unidseq, t1.usuaseq, t1.nomecargo, t1.descricao, t1.conhecimentos, t1.habilidades, t1.atitudes, t1.prerequisitos, t1.cargahoraria, t1.horariotrabalho, t1.maquinasutilizadas, t1.graurisco, t1.cargoascendente, t1.cargodescendente, t1.salariobase, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, t999.seq AS statseq, t999.statdesc FROM (dbcargo t1 LEFT JOIN dbstatus t999 ON ((t999.seq = t1.statseq)));


--
-- TOC entry 349 (class 1259 OID 17516)
-- Dependencies: 3801 5
-- Name: view_cdu; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_cdu AS
    SELECT t1.seq, t1.unidseq, t1.usuaseq, t1.cdu, t1.titulo, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, t999.seq AS statseq, t999.statdesc FROM (dbcdu t1 LEFT JOIN dbstatus t999 ON ((t999.seq = t1.statseq)));


--
-- TOC entry 350 (class 1259 OID 17520)
-- Dependencies: 3802 5
-- Name: view_cheque; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_cheque AS
    SELECT t1.seq, t1.unidseq, t1.usuaseq, t1.nometitular, t1.banco, t1.agencia, t1.numconta, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, t999.seq AS statseq, t999.statdesc, t1.obs, t1.caixseq, t1.numcheque, t1.valor, t1.pessnmrf FROM (dbcheque t1 LEFT JOIN dbstatus t999 ON ((t999.seq = t1.statseq)));


--
-- TOC entry 351 (class 1259 OID 17525)
-- Dependencies: 3803 5
-- Name: view_conta_financeira; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_conta_financeira AS
    SELECT t1.seq, t1.unidseq, t1.usuaseq, t1.nomeconta, t1.tipo, t1.banco, t1.numconta, t1.agencia, t1.saldoinicial, (SELECT sum(dbcaixa.valorfinal) AS sum FROM dbcaixa WHERE ((dbcaixa.cofiseq = t1.seq) AND (dbcaixa.tipo = 'C'::bpchar))) AS entrada, (SELECT sum(dbcaixa.valorfinal) AS sum FROM dbcaixa WHERE ((dbcaixa.cofiseq = t1.seq) AND (dbcaixa.tipo = 'D'::bpchar))) AS saida, ((t1.saldoinicial)::double precision + ((SELECT sum(temp1.valorfinal) AS sum FROM dbcaixa temp1 WHERE ((temp1.cofiseq = t1.seq) AND (temp1.tipo = 'C'::bpchar))))::double precision) AS saldo, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, t999.seq AS statseq, t999.statdesc FROM (dbconta_financeira t1 LEFT JOIN dbstatus t999 ON ((t999.seq = t1.statseq)));


--
-- TOC entry 352 (class 1259 OID 17530)
-- Dependencies: 3804 5
-- Name: view_convenio; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_convenio AS
    SELECT t0.seq, t0.unidseq, t0.usuaseq, t0.pessseq, t0.titulo, t0.descricao, t0.tconseq, t0.formato, t0.datavigencia, t0.plcoseq, t3.nomeconta AS nomeplanoconta, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, t999.seq AS statseq, t999.statdesc, t1.pessnmrz AS concedente FROM (((dbconvenio t0 LEFT JOIN dbplano_conta t3 ON ((t3.seq = t0.plcoseq))) LEFT JOIN dbpessoa t1 ON ((t1.seq = t0.pessseq))) LEFT JOIN dbstatus t999 ON ((t999.seq = t1.statseq)));


--
-- TOC entry 353 (class 1259 OID 17535)
-- Dependencies: 3805 5
-- Name: view_cotacao; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_cotacao AS
    SELECT t1.seq, t1.unidseq, t1.usuaseq, t1.prodseq, t1.pessseq, t1.valor, t1.entrega, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, t999.seq AS statseq, t999.statdesc FROM (dbcotacao t1 LEFT JOIN dbstatus t999 ON ((t999.seq = t1.statseq)));


--
-- TOC entry 354 (class 1259 OID 17539)
-- Dependencies: 3806 5
-- Name: view_curriculo; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_curriculo AS
    SELECT t1.seq, t1.unidseq, t1.usuaseq, t1.nome, t1.sexo, t1.datanasc, t1.cpf, t1.logadouro, t1.cidade, t1.estado, t1.bairro, t1.telefone, t1.celular, t1.email, t1.estadocivil, t1.cnh, t1.dependentes, t1.idiomas, t1.areainteresse, t1.areainteresse2, t1.areainteresse3, t1.escolaridade, t1.cursos, t1.experiencia, t1.obs, t1.resumo, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, t999.seq AS statseq, t999.statdesc FROM (dbcurriculo t1 LEFT JOIN dbstatus t999 ON ((t999.seq = t1.statseq)));


--
-- TOC entry 355 (class 1259 OID 17544)
-- Dependencies: 3807 5
-- Name: view_curso; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_curso AS
    SELECT t4.seq, t4.unidseq, t4.usuaseq, t4.titulo, t4.pjcuseq, t4.obs, to_char((t4.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, t999.seq AS statseq, t999.statdesc, t0.nome, t0.tpcuseq, t0.arcuseq, t0.objetivo, t0.publicoalvo, t0.cargahoraria, t2.titulo AS areacurso, t3.titulo AS tipocurso FROM ((((dbcurso t4 LEFT JOIN dbprojeto_curso t0 ON ((t0.seq = t4.pjcuseq))) LEFT JOIN dbarea_curso t2 ON ((t2.seq = t0.arcuseq))) LEFT JOIN dbtipo_curso t3 ON ((t3.seq = t0.tpcuseq))) LEFT JOIN dbstatus t999 ON ((t999.seq = t4.statseq)));


--
-- TOC entry 356 (class 1259 OID 17549)
-- Dependencies: 3808 5
-- Name: view_curso_disciplina; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_curso_disciplina AS
    SELECT t2.seq, t0.unidseq, t0.usuaseq, t0.pjcuseq, t3.seq AS discseq, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, t999.seq AS statseq, t999.statdesc, t1.nome AS nomecurso, t3.titulo AS nomedisciplina, t3.cargahoraria, t0.seq AS cursseq FROM ((((dbcurso t0 JOIN dbprojeto_curso t1 ON ((t1.seq = t0.pjcuseq))) JOIN dbprojeto_curso_disciplina t2 ON ((t2.pjcuseq = t0.pjcuseq))) LEFT JOIN dbdisciplina t3 ON ((t3.seq = t2.discseq))) LEFT JOIN dbstatus t999 ON ((t999.seq = t0.statseq)));


--
-- TOC entry 357 (class 1259 OID 17554)
-- Dependencies: 3809 5
-- Name: view_demanda; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_demanda AS
    SELECT t0.seq, t0.unidseq, t0.usuaseq, t0.pessseq, t0.cursseq, t0.turno, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, t999.seq AS statseq, t999.statdesc, t4.nome AS nomecurso, t2.pessnmrz AS nomepessoa FROM ((((dbdemanda t0 LEFT JOIN dbpessoa t2 ON ((t2.seq = t0.pessseq))) LEFT JOIN dbcurso t3 ON ((t3.seq = t0.cursseq))) LEFT JOIN dbprojeto_curso t4 ON ((t4.seq = t3.pjcuseq))) LEFT JOIN dbstatus t999 ON ((t999.seq = t0.statseq)));


--
-- TOC entry 358 (class 1259 OID 17559)
-- Dependencies: 3810 5
-- Name: view_departamento; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_departamento AS
    SELECT t0.seq, t0.unidseq, t0.usuaseq, t0.label, t0.funcseq, t0.salaseq, t0.obs, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, t999.seq AS statseq, t999.statdesc, t2.pessnmrz AS nomeresponsavel, t3.nome AS nomesala FROM (((dbdepartamento t0 LEFT JOIN dbpessoa t2 ON ((t2.seq = (SELECT dbfuncionario.pessseq FROM dbfuncionario WHERE (dbfuncionario.seq = t0.funcseq))))) LEFT JOIN dbsala t3 ON ((t3.seq = t0.salaseq))) LEFT JOIN dbstatus t999 ON ((t999.seq = t0.statseq)));


--
-- TOC entry 359 (class 1259 OID 17564)
-- Dependencies: 3811 5
-- Name: view_disciplina; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_disciplina AS
    SELECT t1.seq, t1.unidseq, t1.usuaseq, t1.titulo, t1.ementa, t1.programa, t1.competencias, t1.cargahoraria, t1.biografia, t1.metodologia, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, t999.seq AS statseq, t999.statdesc FROM (dbdisciplina t1 LEFT JOIN dbstatus t999 ON ((t999.seq = t1.statseq)));


--
-- TOC entry 360 (class 1259 OID 17569)
-- Dependencies: 3812 5
-- Name: view_disciplina_similar; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_disciplina_similar AS
    SELECT t0.seq, t0.unidseq, t0.usuaseq, t0.discseq, t0.disiseq, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, t999.seq AS statseq, t999.statdesc, t3.titulo AS nomedisciplina, t3.cargahoraria, t4.titulo AS nomedisciplinasemelhante, t4.cargahoraria AS cargahorariasemelhante FROM (((dbdisciplina_similar t0 LEFT JOIN dbdisciplina t3 ON ((t3.seq = t0.discseq))) LEFT JOIN dbdisciplina t4 ON ((t3.seq = t0.disiseq))) LEFT JOIN dbstatus t999 ON ((t999.seq = t0.statseq)));


--
-- TOC entry 361 (class 1259 OID 17574)
-- Dependencies: 3813 5
-- Name: view_falta; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_falta AS
    SELECT t1.seq, t1.unidseq, t1.usuaseq, t1.alunseq, t1.tudiseq, t1.tdalseq, to_char((t1.datafalta)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datafalta, t1.frequencia, t1.justificativa, t1.obs, t1.deferido, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, t999.seq AS statseq, t999.statdesc, t2.titulo AS nomedisciplina FROM ((dbfalta t1 LEFT JOIN dbstatus t999 ON ((t999.seq = t1.statseq))) LEFT JOIN dbdisciplina t2 ON ((t2.seq = (SELECT t90.discseq FROM dbturma_disciplina t90 WHERE (t90.seq = t1.tudiseq)))));


--
-- TOC entry 362 (class 1259 OID 17579)
-- Dependencies: 3814 5
-- Name: view_fchamento_conta_financeira; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_fchamento_conta_financeira AS
    SELECT t1.seq, t2.unidseq, t2.usuaseq, t2.cofiseq, t1.nomeconta, t1.tipo, t1.banco, t1.numconta, t1.agencia, (SELECT sum(dbcaixa.valorfinal) AS sum FROM dbcaixa WHERE (((dbcaixa.fecfseq = t2.seq) AND (dbcaixa.tipo = 'C'::bpchar)) AND (dbcaixa.fmpgseq = 1))) AS entrada_dinheiro, (SELECT sum(dbcaixa.valorfinal) AS sum FROM dbcaixa WHERE (((dbcaixa.fecfseq = t2.seq) AND (dbcaixa.tipo = 'D'::bpchar)) AND (dbcaixa.fmpgseq = 1))) AS saida_dinheiro, (SELECT sum(dbcaixa.valorfinal) AS sum FROM dbcaixa WHERE (((dbcaixa.fecfseq = t2.seq) AND (dbcaixa.tipo = 'C'::bpchar)) AND (dbcaixa.fmpgseq = 4))) AS entrada_cheque, (SELECT sum(dbcaixa.valorfinal) AS sum FROM dbcaixa WHERE (((dbcaixa.fecfseq = t2.seq) AND (dbcaixa.tipo = 'D'::bpchar)) AND (dbcaixa.fmpgseq = 4))) AS saida_cheque, (SELECT sum(dbcaixa.valorfinal) AS sum FROM dbcaixa WHERE (((dbcaixa.fecfseq = t2.seq) AND (dbcaixa.tipo = 'C'::bpchar)) AND (dbcaixa.fmpgseq = 3))) AS entrada_cartao, (SELECT sum(dbcaixa.valorfinal) AS sum FROM dbcaixa WHERE (((dbcaixa.fecfseq = t2.seq) AND (dbcaixa.tipo = 'D'::bpchar)) AND (dbcaixa.fmpgseq = 3))) AS saida_cartao, to_char((t2.datainicio)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datainicio, to_char((t2.datafim)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datafim, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, t999.seq AS statseq, t999.statdesc FROM ((dbfechamento_conta_financeira t2 LEFT JOIN dbconta_financeira t1 ON ((t1.seq = t2.cofiseq))) LEFT JOIN dbstatus t999 ON ((t999.seq = t2.statseq))) WHERE (t2.statseq = (1)::bigint);


--
-- TOC entry 363 (class 1259 OID 17584)
-- Dependencies: 3815 5
-- Name: view_fechamento_caixa; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_fechamento_caixa AS
    SELECT t1.seq, t1.unidseq, t1.usuaseq, t1.valorprevisto, t1.receitatotal, t1.despesatotal, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, t999.seq AS statseq, t999.statdesc FROM (dbfechamento_caixa t1 LEFT JOIN dbstatus t999 ON ((t999.seq = t1.statseq)));


--
-- TOC entry 364 (class 1259 OID 17588)
-- Dependencies: 3816 5
-- Name: view_funcionario_ocorrencia; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_funcionario_ocorrencia AS
    SELECT t1.seq, t1.unidseq, t1.usuaseq, t1.funcseq, t1.titulo, t1.descricao, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, t999.seq AS statseq, t999.statdesc FROM (dbfuncionario_ocorrencia t1 LEFT JOIN dbstatus t999 ON ((t999.seq = t1.statseq)));


--
-- TOC entry 365 (class 1259 OID 17592)
-- Dependencies: 3817 5
-- Name: view_funcionario_treinamento; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_funcionario_treinamento AS
    SELECT t1.seq, t1.unidseq, t1.usuaseq, t1.treiseq, t1.funcseq, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, t999.seq AS statseq, t999.statdesc FROM (dbfuncionario_treinamento t1 LEFT JOIN dbstatus t999 ON ((t999.seq = t1.statseq)));


--
-- TOC entry 366 (class 1259 OID 17596)
-- Dependencies: 3818 5
-- Name: view_inscricao; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_inscricao AS
    SELECT t0.seq, t0.unidseq, t0.usuaseq, t0.pessseq, t0.transeq, t0.turmseq, t4.seq AS cursseq, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, t999.seq AS statseq, t999.statdesc, t2.pessnmrz AS nomepessoa, t2.pessnmrf, t3.titulo AS nometurma, t3.datainicio, t3.valortaxa, t3.parcelas, t3.valormatricula, t3.valormensal AS valorparcelas, t5.nome AS nomecurso, t0.vencimentomatricula, t0.vencimentotaxa, t3.datainiciovencimentos, t3.padraovencimento FROM (((((dbinscricao t0 LEFT JOIN dbpessoa t2 ON ((t2.seq = t0.pessseq))) LEFT JOIN dbturma t3 ON ((t3.seq = t0.turmseq))) LEFT JOIN dbcurso t4 ON ((t4.seq = t3.cursseq))) LEFT JOIN dbprojeto_curso t5 ON ((t5.seq = t4.pjcuseq))) LEFT JOIN dbstatus t999 ON ((t999.seq = t0.statseq)));


--
-- TOC entry 367 (class 1259 OID 17601)
-- Dependencies: 3819 5
-- Name: view_livro; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_livro AS
    SELECT t0.seq, t0.seq AS livrseq, t0.unidseq, t0.usuaseq, t0.patrseq, t0.autor, t0.outrosautores, t0.ano, t0.isbn, t0.idioma, t0.paginas, t1.modelo AS edicao, t1.marca AS editora, t1.label AS titulo, t2.cdu, t2.titulo AS titulocdu, t0.cphaseq, t0.ccduseq, t0.tradutor, t0.sinopse, t0.volume, t0.sumario, t1.foto, (SELECT count(t3.seq) AS count FROM dblocacao_livro t3 WHERE ((t3.livrseq = t0.seq) AND (t3.stlvseq = (3)::bigint))) AS locacoes, (SELECT count(t3.seq) AS count FROM dblocacao_livro t3 WHERE ((t3.livrseq = t0.seq) AND (t3.stlvseq = (2)::bigint))) AS reservas, (SELECT t3.pessseq FROM dblocacao_livro t3 WHERE ((t3.livrseq = t0.seq) AND (t3.stlvseq = (1)::bigint))) AS codigolocador, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, t999.seq AS statseq, t999.statdesc, t0.exemplar FROM (((dblivro t0 LEFT JOIN dbpatrimonio t1 ON ((t1.seq = t0.patrseq))) LEFT JOIN dbcdu t2 ON ((t2.seq = t0.ccduseq))) LEFT JOIN dbstatus t999 ON ((t999.seq = t1.statseq)));


--
-- TOC entry 368 (class 1259 OID 17606)
-- Dependencies: 3820 5
-- Name: view_nota; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_nota AS
    SELECT t1.seq, t1.unidseq, t1.usuaseq, t1.alunseq, t1.tudiseq, t1.avalseq, t1.nota, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, t999.seq AS statseq, t999.statdesc, t5.titulo AS nometurma, t6.titulo AS nomedisciplina, t2.pessseq, t3.pessnmrz AS nomepessoa, t7.avaliacao, t7.ordem FROM (((((((dbnota t1 LEFT JOIN dbaluno t2 ON ((t2.seq = t1.alunseq))) LEFT JOIN dbpessoa t3 ON ((t3.seq = t2.pessseq))) LEFT JOIN dbstatus t999 ON ((t999.seq = t1.statseq))) LEFT JOIN dbturma_disciplina t4 ON ((t4.seq = t1.tudiseq))) LEFT JOIN dbturma t5 ON ((t5.seq = t4.turmseq))) LEFT JOIN dbdisciplina t6 ON ((t6.seq = t4.discseq))) LEFT JOIN dbavaliacao t7 ON ((t7.seq = t1.avalseq)));


--
-- TOC entry 369 (class 1259 OID 17611)
-- Dependencies: 3821 5
-- Name: view_parcela; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_parcela AS
    SELECT t0.seq, t0.unidseq, t0.usuaseq, t0.transeq, t1.pessseq, t0.plcoseq, t0.tipo, t0.valorinicial, t0.valoratual, t0.numero, t0.desconto, to_char((t0.vencimento)::timestamp with time zone, 'DD/MM/YYYY'::text) AS vencimento, t0.obs, t0.stpaseq, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, t2.pessnmrz AS nomepessoa, t3.nomeconta AS nomeplanoconta, t0.instrucoespagamento, t999.seq AS statseq, t999.statdesc AS statdescr, t5.valorfinal AS valorfinal_credito, t6.valorfinal AS valorfinal_debito, t8.titulo AS stpadesc FROM (((((((dbparcela t0 LEFT JOIN dbtransacao t1 ON ((t1.seq = t0.transeq))) LEFT JOIN dbpessoa t2 ON ((t2.seq = t1.pessseq))) LEFT JOIN dbplano_conta t3 ON ((t3.seq = t0.plcoseq))) LEFT JOIN dbstatus t999 ON ((t999.seq = t0.statseq))) LEFT JOIN dbsituacao_parcela t8 ON ((t8.seq = t0.stpaseq))) LEFT JOIN (SELECT sum(dbcaixa.valorfinal) AS valorfinal, dbcaixa.parcseq FROM dbcaixa WHERE (dbcaixa.tipo = 'C'::bpchar) GROUP BY dbcaixa.parcseq) t5 ON ((t0.seq = t5.parcseq))) LEFT JOIN (SELECT sum(dbcaixa.valorfinal) AS valorfinal, dbcaixa.parcseq FROM dbcaixa WHERE (dbcaixa.tipo = 'D'::bpchar) GROUP BY dbcaixa.parcseq) t6 ON ((t0.seq = t6.parcseq)));


--
-- TOC entry 370 (class 1259 OID 17616)
-- Dependencies: 3822 5
-- Name: view_patrimonio; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_patrimonio AS
    SELECT t1.seq, t1.unidseq, t1.usuaseq, t1.funcseq, t1.prodseq, t1.modelo, t1.marca, t1.label, t1.descricao, t1.tipo, t1.datafabricacao, t1.dataaquisicao, t1.valornominal, t1.salaseq, t1.valorcompra, t1.numnf, t1.dataverificacao, t1.foto, t1.obs, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, t999.seq AS statseq, t999.statdesc, t2.nomeunidade, t3.nome AS nomesala FROM (((dbpatrimonio t1 LEFT JOIN dbunidade t2 ON ((t2.seq = t1.unidseq))) LEFT JOIN dbsala t3 ON ((t3.seq = t1.salaseq))) LEFT JOIN dbstatus t999 ON ((t999.seq = t1.statseq)));


--
-- TOC entry 371 (class 1259 OID 17621)
-- Dependencies: 3823 5
-- Name: view_pessoa; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_pessoa AS
    SELECT t1.seq, t1.unidseq, t1.usuaseq, t1.tipo, t1.pessnmrz, t1.pessnmrf, t1.pessrgie, t1.pessteim, t1.cliente, t1.fornecedor, t1.funcionario, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, t999.seq AS statseq, t999.statdesc, t2.telefone AS telefone1, t3.telefone AS telefone2, t1.email_principal, t1.email_secundario FROM (((dbpessoa t1 LEFT JOIN dbtelefone t2 ON (((t2.pessseq = t1.seq) AND (t2.tpteseq = 1)))) LEFT JOIN dbtelefone t3 ON (((t3.pessseq = t1.seq) AND (t3.tpteseq = 2)))) LEFT JOIN dbstatus t999 ON ((t999.seq = t1.statseq)));


--
-- TOC entry 372 (class 1259 OID 17626)
-- Dependencies: 3824 5
-- Name: view_pessoa_convenio; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_pessoa_convenio AS
    SELECT t1.seq, t1.unidseq, t0.usuaseq, t2.seq AS pessseq, t2.pessnmrz AS nomepessoa, t1.convseq, t0.titulo, t0.descricao, t0.tconseq, t0.valor, t0.formato, t0.datavigencia AS datavirgencia, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, t999.seq AS statseq, t999.statdesc FROM (((dbtransacao_convenio t1 LEFT JOIN dbconvenio t0 ON ((t1.convseq = t0.seq))) LEFT JOIN dbpessoa t2 ON ((t2.seq = t0.pessseq))) LEFT JOIN dbstatus t999 ON ((t999.seq = t1.statseq)));


--
-- TOC entry 373 (class 1259 OID 17631)
-- Dependencies: 3825 5
-- Name: view_pessoa_fisica; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_pessoa_fisica AS
    SELECT t1.seq, t1.unidseq, t1.usuaseq, t1.pessseq, t1.estadocivil, t1.etinia, t1.datanasc, t1.sexo, t1.tiposanguineo, t1.nacionalidade, t1.portadornecessidades, t1.necessidadesespeciais, t1.numerodependentes, t1.cnh, t1.carteirareservista, t1.rendamensal, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, t999.seq AS statseq, t999.statdesc FROM (dbpessoa_fisica t1 LEFT JOIN dbstatus t999 ON ((t999.seq = t1.statseq)));


--
-- TOC entry 374 (class 1259 OID 17636)
-- Dependencies: 3826 5
-- Name: view_pessoa_juridica; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_pessoa_juridica AS
    SELECT t1.seq, t1.unidseq, t1.usuaseq, t1.pessseq, t1.datafundacao, t1.gerente, t1.diretor, t1.representante, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, t999.seq AS statseq, t999.statdesc FROM (dbpessoa_juridica t1 LEFT JOIN dbstatus t999 ON ((t999.seq = t1.statseq)));


--
-- TOC entry 375 (class 1259 OID 17640)
-- Dependencies: 3827 5
-- Name: view_pessoa_titularidade; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_pessoa_titularidade AS
    SELECT t0.seq, t0.unidseq, t0.usuaseq, t0.pessseq, t0.tituseq, t0.curso, t0.instituicao, t0.anoconclusao, t0.observacao, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, t999.seq AS statseq, t999.statdesc, t3.pessnmrz AS nomepessoa, t2.titulo AS titularidade, t2.nomeacao, t2.peso, t4.seq AS profseq, t5.seq AS funcseq FROM (((((dbpessoa_titularidade t0 LEFT JOIN dbtitularidade t2 ON ((t2.seq = t0.tituseq))) LEFT JOIN dbpessoa t3 ON ((t3.seq = t0.pessseq))) LEFT JOIN dbprofessor t4 ON ((t4.pessseq = t3.seq))) LEFT JOIN dbfuncionario t5 ON ((t5.pessseq = t3.seq))) LEFT JOIN dbstatus t999 ON ((t999.seq = t0.statseq)));


--
-- TOC entry 376 (class 1259 OID 17645)
-- Dependencies: 3828 5
-- Name: view_pessoas_livros; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_pessoas_livros AS
    SELECT t0.seq, t0.unidseq, t0.usuaseq, t0.pessseq, t0.livrseq, t0.previsaosaida, t0.previsaoentrada, t0.confirmacaosaida, t0.confirmacaoentrada, t0.stlvseq, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, t999.seq AS statseq, t999.statdesc, t1.pessnmrz AS nomepessoa, t3.label AS titulolivro, t2.autor AS autorlivro, t3.seq AS patrseq FROM ((((dblocacao_livro t0 LEFT JOIN dbpessoa t1 ON ((t1.seq = t0.pessseq))) LEFT JOIN dblivro t2 ON ((t2.seq = t0.livrseq))) LEFT JOIN dbpatrimonio t3 ON ((t3.seq = t2.patrseq))) LEFT JOIN dbstatus t999 ON ((t999.seq = t1.statseq)));


--
-- TOC entry 377 (class 1259 OID 17650)
-- Dependencies: 3829 5
-- Name: view_plano_conta; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_plano_conta AS
    SELECT t1.seq, t1.unidseq, t1.usuaseq, t1.nomeconta, t1.tipoconta, t1.tipocusto, t1.obs, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, t999.seq AS statseq, t999.statdesc FROM (dbplano_conta t1 LEFT JOIN dbstatus t999 ON ((t999.seq = t1.statseq)));


--
-- TOC entry 378 (class 1259 OID 17654)
-- Dependencies: 3830 5
-- Name: view_produto; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_produto AS
    SELECT t1.seq, t1.unidseq, t1.usuaseq, t1.label, t1.descricao, t1.valor, t1.valoralteravel, t1.tabela, t1.obs, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, t999.seq AS statseq, t999.statdesc, t1.tpprseq, t2.titulo AS tipoproduto FROM ((dbproduto t1 LEFT JOIN dbstatus t999 ON ((t999.seq = t1.statseq))) LEFT JOIN dbtipo_produto t2 ON ((t2.seq = t1.tpprseq)));


--
-- TOC entry 379 (class 1259 OID 17659)
-- Dependencies: 3831 5
-- Name: view_produto_turma; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_produto_turma AS
    SELECT t0.seq, t0.unidseq, t0.usuaseq, t0.label, t0.descricao, t0.valor, t0.valoralteravel, t0.tabela, t0.obs, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, t999.seq AS statseq, t999.statdesc, t4.nome AS nomecurso, t2.titulo AS nometurma, t2.plcoseq, t2.datainicio, t2.datafim, t2.frequenciaaula AS frequencia, t2.horainicio, t2.horafim, t2.diasaula, t2.unalseq, t6.nomeunidade AS localaula, t2.valortotal, t2.valortaxa, t2.valormatricula, t2.valormensal, t2.parcelas, t2.datainiciovencimentos, t0.tpprseq, t5.titulo AS tipoproduto FROM ((((((dbproduto t0 LEFT JOIN dbturma t2 ON ((t2.prodseq = t0.seq))) LEFT JOIN dbcurso t3 ON ((t3.seq = t2.cursseq))) LEFT JOIN dbprojeto_curso t4 ON ((t4.seq = t3.pjcuseq))) LEFT JOIN dbstatus t999 ON ((t999.seq = t0.statseq))) LEFT JOIN dbunidade t6 ON ((t6.seq = t2.unalseq))) LEFT JOIN dbtipo_produto t5 ON ((t5.seq = t0.tpprseq))) WHERE ((t0.tabela)::text = 'dbturma'::text);


--
-- TOC entry 380 (class 1259 OID 17664)
-- Dependencies: 3832 5
-- Name: view_professor; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_professor AS
    SELECT t0.seq, t0.unidseq, t0.usuaseq, t0.pessseq, t0.curriculo, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, t999.seq AS statseq, t999.statdesc, t3.pessnmrz AS nomeprofessor, (SELECT t2.titulo FROM (dbpessoa_titularidade t1 LEFT JOIN dbtitularidade t2 ON ((t1.tituseq = t2.seq))) WHERE (t1.pessseq = t3.seq) ORDER BY t2.peso DESC LIMIT 1) AS titulo, (SELECT t2.nomeacao FROM (dbpessoa_titularidade t1 LEFT JOIN dbtitularidade t2 ON ((t1.tituseq = t2.seq))) WHERE (t1.pessseq = t3.seq) ORDER BY t2.peso DESC LIMIT 1) AS nomeacao, t6.telefone AS telefone1, t7.telefone AS telefone2, t3.email_principal, t3.email_secundario FROM ((((dbprofessor t0 LEFT JOIN dbpessoa t3 ON ((t3.seq = t0.pessseq))) LEFT JOIN dbtelefone t6 ON (((t6.pessseq = t3.seq) AND (t6.tpteseq = 1)))) LEFT JOIN dbtelefone t7 ON (((t7.pessseq = t3.seq) AND (t7.tpteseq = 2)))) LEFT JOIN dbstatus t999 ON ((t999.seq = t0.statseq)));


--
-- TOC entry 381 (class 1259 OID 17669)
-- Dependencies: 3833 5
-- Name: view_professor_area; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_professor_area AS
    SELECT t1.seq, t1.unidseq, t1.usuaseq, t1.profseq, t1.arcuseq, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, t999.seq AS statseq, t999.statdesc, t2.titulo AS nomeareacurso FROM ((dbprofessor_area t1 LEFT JOIN dbarea_curso t2 ON ((t2.seq = t1.arcuseq))) LEFT JOIN dbstatus t999 ON ((t999.seq = t1.statseq)));


--
-- TOC entry 382 (class 1259 OID 17674)
-- Dependencies: 3834 5
-- Name: view_projeto_curso; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_projeto_curso AS
    SELECT t1.seq, t1.unidseq, t1.usuaseq, t1.nome, t1.tpcuseq, t1.arcuseq, t1.objetivo, t1.publicoalvo, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, t999.seq AS statseq, t999.statdesc, t2.titulo AS areacurso, (SELECT sum(t4.cargahoraria) AS sum FROM dbdisciplina t4 WHERE (t4.seq IN (SELECT t5.discseq FROM dbprojeto_curso_disciplina t5 WHERE (t5.pjcuseq = t1.seq)))) AS cargahoraria, t3.titulo AS tipocurso, (SELECT count(t5.cursseq) AS count FROM dbturma t5 WHERE (t5.cursseq = t1.seq)) AS turmas, t1.gdavseq, t1.identificador, t1.stpcseq FROM (((dbprojeto_curso t1 LEFT JOIN dbarea_curso t2 ON ((t2.seq = t1.arcuseq))) LEFT JOIN dbtipo_curso t3 ON ((t3.seq = t1.tpcuseq))) LEFT JOIN dbstatus t999 ON ((t999.seq = t1.statseq)));


--
-- TOC entry 383 (class 1259 OID 17679)
-- Dependencies: 3835 5
-- Name: view_projeto_curso_disciplina; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_projeto_curso_disciplina AS
    SELECT t2.seq, t2.pjcuseq, t1.unidseq, t1.usuaseq, t3.seq AS discseq, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, t999.seq AS statseq, t999.statdesc, t1.nome AS nomecurso, t3.titulo AS nomedisciplina, t3.cargahoraria FROM (((dbprojeto_curso_disciplina t2 JOIN dbprojeto_curso t1 ON ((t2.pjcuseq = t1.seq))) LEFT JOIN dbdisciplina t3 ON ((t3.seq = t2.discseq))) LEFT JOIN dbstatus t999 ON ((t999.seq = t1.statseq)));


--
-- TOC entry 384 (class 1259 OID 17684)
-- Dependencies: 3836 5
-- Name: view_recado; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_recado AS
    SELECT t1.seq, t1.unidseq, t1.usuaseq, t1.nomepessoa, t1.referencia, t1.interessado, t1.obs, t1.tel1, t1.tel2, t1.email, t1.situacao, to_char((t1.retorno)::timestamp with time zone, 'DD/MM/YYYY'::text) AS retorno, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, t999.seq AS statseq, t999.statdesc FROM (dbrecado t1 LEFT JOIN dbstatus t999 ON ((t999.seq = t1.statseq)));


--
-- TOC entry 385 (class 1259 OID 17689)
-- Dependencies: 3837 5
-- Name: view_requisito_turma; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_requisito_turma AS
    SELECT t1.seq, t1.unidseq, t1.usuaseq, t1.turmseq, t1.requisito, t1.obs, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, t999.seq AS statseq, t999.statdesc FROM (dbrequisito_turma t1 LEFT JOIN dbstatus t999 ON ((t999.seq = t1.statseq)));


--
-- TOC entry 386 (class 1259 OID 17693)
-- Dependencies: 3838 5
-- Name: view_sala; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_sala AS
    SELECT t1.seq, t1.unidseq, t1.usuaseq, t1.nome, t1.endereco, t1.descricao, t1.salaaula, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, t999.seq AS statseq, t999.statdesc, t2.nomeunidade FROM ((dbsala t1 LEFT JOIN dbunidade t2 ON ((t2.seq = t1.unidseq))) LEFT JOIN dbstatus t999 ON ((t999.seq = t1.statseq)));


--
-- TOC entry 387 (class 1259 OID 17698)
-- Dependencies: 3839 5
-- Name: view_tipo_curso; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_tipo_curso AS
    SELECT t1.seq, t1.unidseq, t1.usuaseq, t1.titulo, t1.obs, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, t999.seq AS statseq, t999.statdesc FROM (dbtipo_curso t1 LEFT JOIN dbstatus t999 ON ((t999.seq = t1.statseq)));


--
-- TOC entry 388 (class 1259 OID 17702)
-- Dependencies: 3840 5
-- Name: view_transacao; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_transacao AS
    SELECT t0.seq, t0.unidseq, t0.usuaseq, t0.pessseq, t0.valortotal, t0.desconto, t0.acrescimo, t0.valorcorrigido, t0.formapag, t0.plcoseq, t0.numparcelas, t0.intervaloparcelas, t0.datafixavencimento, t0.vencimento, t0.efetivada, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, t999.seq AS statseq, t999.statdesc, t2.pessnmrz AS cliente, t3.nomeconta AS planoconta, (SELECT count(dbparcela.seq) AS count FROM dbparcela WHERE ((dbparcela.transeq = t0.seq) AND (dbparcela.stpaseq = 2))) AS numparcelaspagas, (SELECT sum(dbparcela.valoratual) AS sum FROM dbparcela WHERE ((dbparcela.transeq = t0.seq) AND (dbparcela.stpaseq = 1))) AS valoratual, (SELECT count(dbparcela.seq) AS count FROM dbparcela WHERE ((dbparcela.transeq = t0.seq) AND (dbparcela.stpaseq = 1))) AS numparcelasabertas FROM (((dbtransacao t0 LEFT JOIN dbpessoa t2 ON ((t2.seq = t0.pessseq))) LEFT JOIN dbplano_conta t3 ON ((t3.seq = t0.plcoseq))) LEFT JOIN dbstatus t999 ON ((t999.seq = t0.statseq)));


--
-- TOC entry 389 (class 1259 OID 17707)
-- Dependencies: 3841 5
-- Name: view_transacao_convenio; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_transacao_convenio AS
    SELECT t0.seq, t0.unidseq, t0.usuaseq, t0.transeq, t0.convseq, t2.titulo AS nomeconvenio, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, t999.seq AS statseq, t999.statdesc FROM ((dbtransacao_convenio t0 LEFT JOIN dbconvenio t2 ON ((t2.seq = t0.convseq))) LEFT JOIN dbstatus t999 ON ((t999.seq = t0.statseq)));


--
-- TOC entry 390 (class 1259 OID 17712)
-- Dependencies: 3842 5
-- Name: view_transacao_produto; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_transacao_produto AS
    SELECT t0.seq, t0.unidseq, t0.usuaseq, t0.transeq, t0.prodseq, t0.valornominal, (t0.valornominal * (t0.quantidade)::double precision) AS valortotal, t0.quantidade, t0.obs, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, t999.seq AS statseq, t999.statdesc, t2.descricao, t2.label FROM ((dbtransacao_produto t0 LEFT JOIN dbproduto t2 ON ((t2.seq = t0.prodseq))) LEFT JOIN dbstatus t999 ON ((t999.seq = t0.statseq)));


--
-- TOC entry 391 (class 1259 OID 17717)
-- Dependencies: 3843 5
-- Name: view_treinamento; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_treinamento AS
    SELECT t1.seq, t1.unidseq, t1.usuaseq, t1.nomecurso, t1.ementa, t1.cargahoraria, t1.ministrante, t1.tituseq, t1.curriculoministrante, t1.instituicaocertificadora, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, t999.seq AS statseq, t999.statdesc FROM (dbtreinamento t1 LEFT JOIN dbstatus t999 ON ((t999.seq = t1.statseq)));


--
-- TOC entry 392 (class 1259 OID 17722)
-- Dependencies: 3844 5
-- Name: view_turma; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_turma AS
    SELECT t2.nome AS nomeprojetocurso, t0.seq, t0.unidseq, t0.titulo, t0.aceitainscricao, (SELECT sum(t4.cargahoraria) AS sum FROM dbdisciplina t4 WHERE (t4.seq IN (SELECT t5.discseq FROM dbturma_disciplina t5 WHERE (t5.turmseq = t0.seq)))) AS cargahoraria, t0.valortaxa, t0.valormatricula, t0.valormensal, t0.vagas, t0.parcelas, t0.sttuseq, t999.seq AS statseq, t999.statdesc, t0.datainicio, t0.prodseq, t3.nomeunidade, t0.cursseq, t4.titulo AS nomecurso, (SELECT count(t5.turmseq) AS count FROM dbinscricao t5 WHERE (t5.turmseq = t0.seq)) AS inscritos, (SELECT count(t6.turmseq) AS count FROM dbaluno t6 WHERE (t6.turmseq = t0.seq)) AS matriculados, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, t2.gdavseq FROM ((((dbturma t0 LEFT JOIN dbcurso t4 ON ((t4.seq = t0.cursseq))) LEFT JOIN dbprojeto_curso t2 ON ((t2.seq = t4.pjcuseq))) LEFT JOIN dbunidade t3 ON ((t3.seq = t0.unidseq))) LEFT JOIN dbstatus t999 ON ((t999.seq = t0.statseq)));


--
-- TOC entry 393 (class 1259 OID 17727)
-- Dependencies: 3845 5
-- Name: view_turma_convenio; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_turma_convenio AS
    SELECT t0.seq, t0.unidseq, t0.usuaseq, t0.turmseq, t0.convseq, t2.titulo AS nomeconvenio, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, t999.seq AS statseq, t999.statdesc FROM ((dbturma_convenio t0 LEFT JOIN dbconvenio t2 ON ((t2.seq = t0.convseq))) LEFT JOIN dbstatus t999 ON ((t999.seq = t0.statseq)));


--
-- TOC entry 394 (class 1259 OID 17732)
-- Dependencies: 3846 5
-- Name: view_turma_convenio_desconto; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_turma_convenio_desconto AS
    SELECT t1.seq, t1.unidseq, t1.usuaseq, t1.turmseq, t2.dialimite, t2.valor, t2.obs, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, t999.seq AS statseq, t999.statdesc FROM ((dbturma_convenio t1 JOIN dbconvenio_desconto t2 ON ((t2.convseq = t1.convseq))) LEFT JOIN dbstatus t999 ON ((t999.seq = t1.statseq)));


--
-- TOC entry 395 (class 1259 OID 17737)
-- Dependencies: 3847 5
-- Name: view_turma_disciplina; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_turma_disciplina AS
    SELECT t0.seq, t0.unidseq, t0.turmseq, t3.cursseq, t0.discseq, t0.profseq, to_char((t0.datarealizacao)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datarealizacao, to_char((t0.dataatualizacao)::timestamp with time zone, 'DD/MM/YYYY'::text) AS dataatualizacao, t0.frequencia, t0.datas, t0.custohoraaula, t0.regimetrabalho, t0.custohospedagem, t0.custodeslocamento, to_char((t0.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, t6.nome AS sala, t999.seq AS statseq, t999.statdesc, t2.titulo AS nomecurso, t3.titulo AS nometurma, t4.titulo AS nomedisciplina, t4.cargahoraria, t5.pessnmrz AS nomeprofessor, (SELECT count(dbaluno_disciplina.seq) AS count FROM dbaluno_disciplina WHERE ((dbaluno_disciplina.tudiseq = t0.seq) AND (dbaluno_disciplina.stadseq = (2)::bigint))) AS alunos, t0.salaseq, t7.gdavseq, t3.sttuseq, t0.custoalimentacao, t0.custoextra FROM (((((((dbturma_disciplina t0 LEFT JOIN dbturma t3 ON ((t3.seq = t0.turmseq))) LEFT JOIN dbcurso t2 ON ((t2.seq = t3.cursseq))) LEFT JOIN dbprojeto_curso t7 ON ((t7.seq = t2.pjcuseq))) LEFT JOIN dbdisciplina t4 ON ((t4.seq = t0.discseq))) LEFT JOIN dbpessoa t5 ON ((t5.seq = (SELECT t9.pessseq FROM dbprofessor t9 WHERE (t9.seq = t0.profseq))))) LEFT JOIN dbsala t6 ON ((t6.seq = t0.salaseq))) LEFT JOIN dbstatus t999 ON ((t999.seq = t0.statseq)));


--
-- TOC entry 396 (class 1259 OID 17742)
-- Dependencies: 3848 5
-- Name: view_turma_disciplina_arquivo; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_turma_disciplina_arquivo AS
    SELECT t1.seq, t1.unidseq, t1.usuaseq, t1.tipo, t1.tudiseq, t1.profseq, t1.titulo, t1.obs, t1.arquivo, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, t999.seq AS statseq, t999.statdesc FROM (dbturma_disciplina_arquivo t1 LEFT JOIN dbstatus t999 ON ((t999.seq = t1.statseq)));


--
-- TOC entry 397 (class 1259 OID 17746)
-- Dependencies: 3849 5
-- Name: view_turma_disciplina_aula; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_turma_disciplina_aula AS
    SELECT t1.seq, t1.unidseq, t1.usuaseq, t1.tudiseq, t1.dataaula, t1.conteudo, t1.frequencia, t1.obs, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, t999.seq AS statseq, t999.statdesc FROM (dbturma_disciplina_aula t1 LEFT JOIN dbstatus t999 ON ((t999.seq = t1.statseq)));


--
-- TOC entry 398 (class 1259 OID 17750)
-- Dependencies: 3850 5
-- Name: view_turma_disciplina_avaliacao; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_turma_disciplina_avaliacao AS
    SELECT t2.seq, t2.unidseq, t2.usuaseq, t2.avaliacao, t2.peso, t2.ordem, t2.rgavseq, t2.incontrol, t2.referencia, t2.condicao, t2.gdavseq, to_char((t2.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, t999.seq AS statseq, t999.statdesc, t1.turmseq, t1.seq AS tudiseq FROM ((dbturma_disciplina t1 LEFT JOIN dbavaliacao t2 ON ((t2.gdavseq = t1.gdavseq))) LEFT JOIN dbstatus t999 ON ((t999.seq = t2.statseq)));


--
-- TOC entry 399 (class 1259 OID 17755)
-- Dependencies: 3851 5
-- Name: view_turma_disciplina_material; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_turma_disciplina_material AS
    SELECT t1.seq, t1.unidseq, t1.usuaseq, t1.tudiseq, t1.titulo, t1.descricao, t1.custo, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, t999.seq AS statseq, t999.statdesc FROM (dbturma_disciplina_material t1 LEFT JOIN dbstatus t999 ON ((t999.seq = t1.statseq)));


--
-- TOC entry 400 (class 1259 OID 17759)
-- Dependencies: 3852 5
-- Name: view_turma_disciplina_planoaula; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_turma_disciplina_planoaula AS
    SELECT t1.seq, t1.unidseq, t1.usuaseq, t1.tudiseq, t1.profseq, t1.dataaula, t1.conteudo, t1.recursos, t1.metodologia, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, t999.seq AS statseq, t999.statdesc FROM (dbturma_disciplina_planoaula t1 LEFT JOIN dbstatus t999 ON ((t999.seq = t1.statseq)));


--
-- TOC entry 401 (class 1259 OID 17763)
-- Dependencies: 3853 5
-- Name: view_unidade; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_unidade AS
    SELECT t1.seq, t1.unidseq, t1.usuaseq, t1.nomeunidade, t1.razaosocial, t1.cnpj, t1.inscestadual, t1.inscmunicipal, t1.gerente, t1.diretor, t1.representante, t1.logradouro, t1.bairro, t1.cidade, t1.estado, t1.cep, t1.email, t1.telefone, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, t999.seq AS statseq, t999.statdesc FROM (dbunidade t1 LEFT JOIN dbstatus t999 ON ((t999.seq = t1.statseq)));


--
-- TOC entry 402 (class 1259 OID 17768)
-- Dependencies: 3854 5
-- Name: view_usuario; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW view_usuario AS
    SELECT t1.seq, t1.unidseq, t1.usuaseq, t1.classeuser, t1.pessseq, t2.pessnmrz AS nomepessoa, t1.usuario, t1.senha, t1.entidadepai, t1.temaseq, to_char((t1.datacad)::timestamp with time zone, 'DD/MM/YYYY'::text) AS datacad, t999.seq AS statseq, t999.statdesc FROM ((dbusuario t1 LEFT JOIN dbpessoa t2 ON ((t2.seq = t1.pessseq))) LEFT JOIN dbstatus t999 ON ((t999.seq = t1.statseq)));


--
-- TOC entry 2888 (class 2604 OID 17773)
-- Dependencies: 243 242
-- Name: seq; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbparametro_produto ALTER COLUMN seq SET DEFAULT nextval('dbparametro_produto_seq_seq'::regclass);


--
-- TOC entry 3856 (class 0 OID 16389)
-- Dependencies: 162 4034
-- Data for Name: aluno_nota_frequencia; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4155 (class 0 OID 0)
-- Dependencies: 161
-- Name: aluno_nota_frequencia_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('aluno_nota_frequencia_seq_seq', 1, false);


--
-- TOC entry 3858 (class 0 OID 16398)
-- Dependencies: 164 4034
-- Data for Name: dbaluno; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3860 (class 0 OID 16407)
-- Dependencies: 166 4034
-- Data for Name: dbaluno_disciplina; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4156 (class 0 OID 0)
-- Dependencies: 165
-- Name: dbaluno_disciplina_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbaluno_disciplina_seq_seq', 28387, true);


--
-- TOC entry 3862 (class 0 OID 16421)
-- Dependencies: 168 4034
-- Data for Name: dbaluno_requisito; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4157 (class 0 OID 0)
-- Dependencies: 167
-- Name: dbaluno_requisito_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbaluno_requisito_seq_seq', 1, false);


--
-- TOC entry 4158 (class 0 OID 0)
-- Dependencies: 163
-- Name: dbaluno_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbaluno_seq_seq', 1322, true);


--
-- TOC entry 3864 (class 0 OID 16433)
-- Dependencies: 170 4034
-- Data for Name: dbaluno_solicitacao; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4159 (class 0 OID 0)
-- Dependencies: 169
-- Name: dbaluno_solicitacao_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbaluno_solicitacao_seq_seq', 1, false);


--
-- TOC entry 3866 (class 0 OID 16446)
-- Dependencies: 172 4034
-- Data for Name: dbaproveitamento_disciplina; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4160 (class 0 OID 0)
-- Dependencies: 171
-- Name: dbaproveitamento_disciplina_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbaproveitamento_disciplina_seq_seq', 1, false);


--
-- TOC entry 3868 (class 0 OID 16458)
-- Dependencies: 174 4034
-- Data for Name: dbarea_curso; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO dbarea_curso (seq, unidseq, usuaseq, titulo, descricao, datacad, statseq) VALUES (1, 1, 1, 'Gestão', NULL, '2009-03-14', 1);
INSERT INTO dbarea_curso (seq, unidseq, usuaseq, titulo, descricao, datacad, statseq) VALUES (2, 1, 1, 'Educação', NULL, '2009-03-14', 1);
INSERT INTO dbarea_curso (seq, unidseq, usuaseq, titulo, descricao, datacad, statseq) VALUES (3, 1, 1, 'Direito', NULL, '2009-03-14', 1);
INSERT INTO dbarea_curso (seq, unidseq, usuaseq, titulo, descricao, datacad, statseq) VALUES (4, 1, 1, 'Engenharia', NULL, '2009-03-14', 1);
INSERT INTO dbarea_curso (seq, unidseq, usuaseq, titulo, descricao, datacad, statseq) VALUES (5, 1, 1, 'Saúde', NULL, '2009-03-14', 1);
INSERT INTO dbarea_curso (seq, unidseq, usuaseq, titulo, descricao, datacad, statseq) VALUES (6, 1, 1, 'Tecnologia', NULL, '2009-03-24', 1);
INSERT INTO dbarea_curso (seq, unidseq, usuaseq, titulo, descricao, datacad, statseq) VALUES (7, 1, 1, 'Idiomas', NULL, '2009-03-25', 1);
INSERT INTO dbarea_curso (seq, unidseq, usuaseq, titulo, descricao, datacad, statseq) VALUES (8, 1, 1, 'Design', NULL, '2009-03-25', 1);


--
-- TOC entry 4161 (class 0 OID 0)
-- Dependencies: 173
-- Name: dbarea_curso_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbarea_curso_seq_seq', 15, true);


--
-- TOC entry 3870 (class 0 OID 16470)
-- Dependencies: 176 4034
-- Data for Name: dbavaliacao; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO dbavaliacao (seq, unidseq, usuaseq, avaliacao, peso, ordem, rgavseq, incontrol, referencia, condicao, gdavseq, datacad, statseq) VALUES (2, 1, 1, 'AV{2}', 1, 2, 1, 'setArredondamentoNota', NULL, '1', 3, '2011-04-08', 1);
INSERT INTO dbavaliacao (seq, unidseq, usuaseq, avaliacao, peso, ordem, rgavseq, incontrol, referencia, condicao, gdavseq, datacad, statseq) VALUES (1, 1, 1, 'AV{1}', 1, 1, 1, 'setArredondamentoNota', NULL, '1', 3, '2011-04-08', 1);
INSERT INTO dbavaliacao (seq, unidseq, usuaseq, avaliacao, peso, ordem, rgavseq, incontrol, referencia, condicao, gdavseq, datacad, statseq) VALUES (3, 1, 1, 'AV{3}', 1, 3, 5, 'setArredondamentoNota', NULL, '? (AV{1} + AV{2})/2 < 6', 3, '2011-04-08', 1);
INSERT INTO dbavaliacao (seq, unidseq, usuaseq, avaliacao, peso, ordem, rgavseq, incontrol, referencia, condicao, gdavseq, datacad, statseq) VALUES (7, 1, 1, 'AV{1}', 1, 1, 1, NULL, NULL, '1', 1, '2011-04-14', 1);


--
-- TOC entry 4162 (class 0 OID 0)
-- Dependencies: 175
-- Name: dbavaliacao_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbavaliacao_seq_seq', 11, true);


--
-- TOC entry 3872 (class 0 OID 16485)
-- Dependencies: 178 4034
-- Data for Name: dbbalanco_patrimonial; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4163 (class 0 OID 0)
-- Dependencies: 177
-- Name: dbbalanco_patrimonial_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbbalanco_patrimonial_seq_seq', 1, false);


--
-- TOC entry 3874 (class 0 OID 16516)
-- Dependencies: 180 4034
-- Data for Name: dbboleto; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3876 (class 0 OID 16533)
-- Dependencies: 182 4034
-- Data for Name: dbboleto_estrutura; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO dbboleto_estrutura (seq, unidseq, usuaseq, cofiseq, agencia, conta, digito, carteira, identificacao, pessnmrf, endereco, cidade_uf, cedente, taxa_administrativa, moeda, dias_prazo, instrucao1, instrucao2, instrucao3, instrucao4, inst_cliente1, inst_cliente2, tipoduplicata, datacad, statseq) VALUES (1, 1, 1, 2, '0014', '03395', '8', '24', 'GRUPO ADMINIST PROFISSIONAL LTDA', '07.945.909/0001-61', 'Rua XXXXX', 'Anápolis', 'GRUPO ADMINIST PROFISSIONAL LTDA', '0', 'R$', '3', 'Não receber após 30 dias do vencimento', 'Multa de 2%', NULL, NULL, '', '', 'DM', '2010-03-08', 1);


--
-- TOC entry 4164 (class 0 OID 0)
-- Dependencies: 181
-- Name: dbboleto_estrutura_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbboleto_estrutura_seq_seq', 3, true);


--
-- TOC entry 4165 (class 0 OID 0)
-- Dependencies: 179
-- Name: dbboleto_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbboleto_seq_seq', 18960, true);


--
-- TOC entry 3878 (class 0 OID 16546)
-- Dependencies: 184 4034
-- Data for Name: dbcaixa; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3880 (class 0 OID 16565)
-- Dependencies: 186 4034
-- Data for Name: dbcaixa_funcionario; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4166 (class 0 OID 0)
-- Dependencies: 185
-- Name: dbcaixa_funcionario_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbcaixa_funcionario_seq_seq', 23, true);


--
-- TOC entry 4167 (class 0 OID 0)
-- Dependencies: 183
-- Name: dbcaixa_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbcaixa_seq_seq', 5093, true);


--
-- TOC entry 3882 (class 0 OID 16578)
-- Dependencies: 188 4034
-- Data for Name: dbcargo; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO dbcargo (seq, unidseq, usuaseq, nomecargo, descricao, conhecimentos, habilidades, atitudes, prerequisitos, cargahoraria, horariotrabalho, maquinasutilizadas, graurisco, cargseq, cargoascendente, cargodescendente, salariobase, datacad, statseq) VALUES (3, 1, 1, 'Diretor Geral', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2013-07-30', 1);
INSERT INTO dbcargo (seq, unidseq, usuaseq, nomecargo, descricao, conhecimentos, habilidades, atitudes, prerequisitos, cargahoraria, horariotrabalho, maquinasutilizadas, graurisco, cargseq, cargoascendente, cargodescendente, salariobase, datacad, statseq) VALUES (4, 1, 1, 'Coordenador de Curso', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2013-07-30', 1);
INSERT INTO dbcargo (seq, unidseq, usuaseq, nomecargo, descricao, conhecimentos, habilidades, atitudes, prerequisitos, cargahoraria, horariotrabalho, maquinasutilizadas, graurisco, cargseq, cargoascendente, cargodescendente, salariobase, datacad, statseq) VALUES (5, 1, 1, 'Recepcionista', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2013-07-30', 1);
INSERT INTO dbcargo (seq, unidseq, usuaseq, nomecargo, descricao, conhecimentos, habilidades, atitudes, prerequisitos, cargahoraria, horariotrabalho, maquinasutilizadas, graurisco, cargseq, cargoascendente, cargodescendente, salariobase, datacad, statseq) VALUES (6, 1, 1, 'Serviços Gerais', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2013-07-30', 1);
INSERT INTO dbcargo (seq, unidseq, usuaseq, nomecargo, descricao, conhecimentos, habilidades, atitudes, prerequisitos, cargahoraria, horariotrabalho, maquinasutilizadas, graurisco, cargseq, cargoascendente, cargodescendente, salariobase, datacad, statseq) VALUES (7, 1, 1, 'Diretor Academico', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2013-07-30', 1);
INSERT INTO dbcargo (seq, unidseq, usuaseq, nomecargo, descricao, conhecimentos, habilidades, atitudes, prerequisitos, cargahoraria, horariotrabalho, maquinasutilizadas, graurisco, cargseq, cargoascendente, cargodescendente, salariobase, datacad, statseq) VALUES (8, 1, 1, 'Diretor Administrativo e Financeiro', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2013-07-30', 1);
INSERT INTO dbcargo (seq, unidseq, usuaseq, nomecargo, descricao, conhecimentos, habilidades, atitudes, prerequisitos, cargahoraria, horariotrabalho, maquinasutilizadas, graurisco, cargseq, cargoascendente, cargodescendente, salariobase, datacad, statseq) VALUES (10, 1, 1, 'Estagiário', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2013-07-30', 1);
INSERT INTO dbcargo (seq, unidseq, usuaseq, nomecargo, descricao, conhecimentos, habilidades, atitudes, prerequisitos, cargahoraria, horariotrabalho, maquinasutilizadas, graurisco, cargseq, cargoascendente, cargodescendente, salariobase, datacad, statseq) VALUES (1, 1, 1, 'Bibliotecária', 'Executar sob supervisão, atividades de preparo técnico de material bibliográfico ou documental da biblioteca ou arquivo; Participar da elaboração de projetos de implantação, manutenção, avaliação e treinamento de bibliotecas e arquivos setoriais e do acompanhamento de entrada e saída de dados dos sistemas automatizados; Atender consultas de usuários da biblioteca e arquivo; Participar de grupos de trabalho internos e externos; Efetuar, sob supervisão, pesquisas bibliográficas; Controlar, sob supervisão, a entrada e saída de material bibliográfico.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2013-07-30', 1);
INSERT INTO dbcargo (seq, unidseq, usuaseq, nomecargo, descricao, conhecimentos, habilidades, atitudes, prerequisitos, cargahoraria, horariotrabalho, maquinasutilizadas, graurisco, cargseq, cargoascendente, cargodescendente, salariobase, datacad, statseq) VALUES (11, 1, 1, 'Gerente Administrativa', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2013-07-30', 1);
INSERT INTO dbcargo (seq, unidseq, usuaseq, nomecargo, descricao, conhecimentos, habilidades, atitudes, prerequisitos, cargahoraria, horariotrabalho, maquinasutilizadas, graurisco, cargseq, cargoascendente, cargodescendente, salariobase, datacad, statseq) VALUES (9, 1, 1, 'Consultor', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2013-07-30', 8);
INSERT INTO dbcargo (seq, unidseq, usuaseq, nomecargo, descricao, conhecimentos, habilidades, atitudes, prerequisitos, cargahoraria, horariotrabalho, maquinasutilizadas, graurisco, cargseq, cargoascendente, cargodescendente, salariobase, datacad, statseq) VALUES (13, 1, 1, 'Gerente Comercial', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2013-07-30', 1);
INSERT INTO dbcargo (seq, unidseq, usuaseq, nomecargo, descricao, conhecimentos, habilidades, atitudes, prerequisitos, cargahoraria, horariotrabalho, maquinasutilizadas, graurisco, cargseq, cargoascendente, cargodescendente, salariobase, datacad, statseq) VALUES (12, 1, 1, 'Professor(a)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2013-07-30', 1);
INSERT INTO dbcargo (seq, unidseq, usuaseq, nomecargo, descricao, conhecimentos, habilidades, atitudes, prerequisitos, cargahoraria, horariotrabalho, maquinasutilizadas, graurisco, cargseq, cargoascendente, cargodescendente, salariobase, datacad, statseq) VALUES (2, 1, 1, 'Secretário Academico', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2013-07-30', 1);


--
-- TOC entry 4168 (class 0 OID 0)
-- Dependencies: 187
-- Name: dbcargo_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbcargo_seq_seq', 14, true);


--
-- TOC entry 3884 (class 0 OID 16591)
-- Dependencies: 190 4034
-- Data for Name: dbcdu; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4169 (class 0 OID 0)
-- Dependencies: 189
-- Name: dbcdu_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbcdu_seq_seq', 1, false);


--
-- TOC entry 3886 (class 0 OID 16600)
-- Dependencies: 192 4034
-- Data for Name: dbcheque; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4170 (class 0 OID 0)
-- Dependencies: 191
-- Name: dbcheque_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbcheque_seq_seq', 1, false);


--
-- TOC entry 3888 (class 0 OID 16612)
-- Dependencies: 194 4034
-- Data for Name: dbconta_financeira; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO dbconta_financeira (seq, unidseq, usuaseq, nomeconta, tipo, banco, numconta, agencia, saldoinicial, datacad, statseq) VALUES (1, 1, 1, 'Banco Bradesco', 'B', 'Bradesco', '0001008-1', '1716-7', 1, '2009-03-16', 1);
INSERT INTO dbconta_financeira (seq, unidseq, usuaseq, nomeconta, tipo, banco, numconta, agencia, saldoinicial, datacad, statseq) VALUES (2, 1, 1, 'Caixa GAP', 'C', '-', '-', '-', 1, '2009-03-16', 1);
INSERT INTO dbconta_financeira (seq, unidseq, usuaseq, nomeconta, tipo, banco, numconta, agencia, saldoinicial, datacad, statseq) VALUES (3, 1, 1, 'Banco CEF', 'B', 'CAIXA', '00000363-9', '0014', 1, '2009-03-16', 1);


--
-- TOC entry 4171 (class 0 OID 0)
-- Dependencies: 193
-- Name: dbconta_financeira_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbconta_financeira_seq_seq', 4, true);


--
-- TOC entry 3890 (class 0 OID 16624)
-- Dependencies: 196 4034
-- Data for Name: dbconvenio; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3892 (class 0 OID 16636)
-- Dependencies: 198 4034
-- Data for Name: dbconvenio_desconto; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4172 (class 0 OID 0)
-- Dependencies: 197
-- Name: dbconvenio_desconto_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbconvenio_desconto_seq_seq', 45, true);


--
-- TOC entry 4173 (class 0 OID 0)
-- Dependencies: 195
-- Name: dbconvenio_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbconvenio_seq_seq', 59, true);


--
-- TOC entry 3894 (class 0 OID 16648)
-- Dependencies: 200 4034
-- Data for Name: dbcotacao; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4174 (class 0 OID 0)
-- Dependencies: 199
-- Name: dbcotacao_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbcotacao_seq_seq', 1, false);


--
-- TOC entry 3896 (class 0 OID 16660)
-- Dependencies: 202 4034
-- Data for Name: dbcurriculo; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4175 (class 0 OID 0)
-- Dependencies: 201
-- Name: dbcurriculo_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbcurriculo_seq_seq', 1, false);


--
-- TOC entry 3898 (class 0 OID 16673)
-- Dependencies: 204 4034
-- Data for Name: dbcurso; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4176 (class 0 OID 0)
-- Dependencies: 203
-- Name: dbcurso_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbcurso_seq_seq', 69, true);


--
-- TOC entry 3900 (class 0 OID 16685)
-- Dependencies: 206 4034
-- Data for Name: dbdemanda; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4177 (class 0 OID 0)
-- Dependencies: 205
-- Name: dbdemanda_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbdemanda_seq_seq', 493, true);


--
-- TOC entry 3902 (class 0 OID 16694)
-- Dependencies: 208 4034
-- Data for Name: dbdepartamento; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO dbdepartamento (seq, unidseq, usuaseq, label, funcseq, salaseq, obs, datacad, statseq) VALUES (6, 1, 1, 'Coordenação de Curso', NULL, 1, NULL, '2010-11-14', 1);
INSERT INTO dbdepartamento (seq, unidseq, usuaseq, label, funcseq, salaseq, obs, datacad, statseq) VALUES (3, 1, 1, 'Direção Administrativa e Financeira', NULL, 1, NULL, '2010-11-14', 1);
INSERT INTO dbdepartamento (seq, unidseq, usuaseq, label, funcseq, salaseq, obs, datacad, statseq) VALUES (2, 1, 1, 'Direção Academica', NULL, 1, NULL, '2010-11-14', 1);
INSERT INTO dbdepartamento (seq, unidseq, usuaseq, label, funcseq, salaseq, obs, datacad, statseq) VALUES (5, 1, 1, 'Biblioteca', NULL, 4, NULL, '2010-11-14', 1);
INSERT INTO dbdepartamento (seq, unidseq, usuaseq, label, funcseq, salaseq, obs, datacad, statseq) VALUES (4, 1, 1, 'Secretaria Acadêmica', NULL, 3, NULL, '2010-11-14', 1);


--
-- TOC entry 4178 (class 0 OID 0)
-- Dependencies: 207
-- Name: dbdepartamento_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbdepartamento_seq_seq', 7, true);


--
-- TOC entry 3904 (class 0 OID 16706)
-- Dependencies: 210 4034
-- Data for Name: dbdisciplina; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4179 (class 0 OID 0)
-- Dependencies: 209
-- Name: dbdisciplina_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbdisciplina_seq_seq', 639, true);


--
-- TOC entry 3906 (class 0 OID 16718)
-- Dependencies: 212 4034
-- Data for Name: dbdisciplina_similar; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4180 (class 0 OID 0)
-- Dependencies: 211
-- Name: dbdisciplina_similar_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbdisciplina_similar_seq_seq', 1, false);


--
-- TOC entry 3908 (class 0 OID 16727)
-- Dependencies: 214 4034
-- Data for Name: dbdocumentos; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4181 (class 0 OID 0)
-- Dependencies: 213
-- Name: dbdocumentos_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbdocumentos_seq_seq', 1, false);


--
-- TOC entry 3910 (class 0 OID 16739)
-- Dependencies: 216 4034
-- Data for Name: dbemail; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4182 (class 0 OID 0)
-- Dependencies: 215
-- Name: dbemail_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbemail_seq_seq', 6123, true);


--
-- TOC entry 3912 (class 0 OID 16746)
-- Dependencies: 218 4034
-- Data for Name: dbendereco; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4183 (class 0 OID 0)
-- Dependencies: 217
-- Name: dbendereco_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbendereco_seq_seq', 14279, true);


--
-- TOC entry 3914 (class 0 OID 16757)
-- Dependencies: 220 4034
-- Data for Name: dbfalta; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4184 (class 0 OID 0)
-- Dependencies: 219
-- Name: dbfalta_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbfalta_seq_seq', 11194, true);


--
-- TOC entry 3916 (class 0 OID 16771)
-- Dependencies: 222 4034
-- Data for Name: dbfechamento_caixa; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4185 (class 0 OID 0)
-- Dependencies: 221
-- Name: dbfechamento_caixa_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbfechamento_caixa_seq_seq', 1, false);


--
-- TOC entry 3917 (class 0 OID 16778)
-- Dependencies: 223 4034
-- Data for Name: dbfechamento_conta_financeira; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO dbfechamento_conta_financeira (seq, unidseq, usuaseq, cofiseq, datainicio, datafim, datacad, statseq) VALUES (2, 1, 1, 1, '2011-05-27', '2011-05-27', '2011-05-27', 1);
INSERT INTO dbfechamento_conta_financeira (seq, unidseq, usuaseq, cofiseq, datainicio, datafim, datacad, statseq) VALUES (3, 1, 1, 1, '2011-05-27', '2011-05-27', '2011-05-27', 1);
INSERT INTO dbfechamento_conta_financeira (seq, unidseq, usuaseq, cofiseq, datainicio, datafim, datacad, statseq) VALUES (8, 1, 1, 1, '2011-05-27', '2011-06-21', '2011-05-27', 1);
INSERT INTO dbfechamento_conta_financeira (seq, unidseq, usuaseq, cofiseq, datainicio, datafim, datacad, statseq) VALUES (11, 1, 1, 1, '2011-06-21', '2012-03-14', '2011-06-21', 1);
INSERT INTO dbfechamento_conta_financeira (seq, unidseq, usuaseq, cofiseq, datainicio, datafim, datacad, statseq) VALUES (14, 1, 1, 1, '2012-03-14', '2012-05-27', '2012-03-14', 1);
INSERT INTO dbfechamento_conta_financeira (seq, unidseq, usuaseq, cofiseq, datainicio, datafim, datacad, statseq) VALUES (17, 1, 1, 1, '2012-05-27', NULL, '2012-05-27', 8);
INSERT INTO dbfechamento_conta_financeira (seq, unidseq, usuaseq, cofiseq, datainicio, datafim, datacad, statseq) VALUES (4, 1, 1, 2, '2011-05-27', '2011-05-27', '2011-05-27', 1);
INSERT INTO dbfechamento_conta_financeira (seq, unidseq, usuaseq, cofiseq, datainicio, datafim, datacad, statseq) VALUES (5, 1, 1, 2, '2011-05-27', '2011-05-27', '2011-05-27', 1);
INSERT INTO dbfechamento_conta_financeira (seq, unidseq, usuaseq, cofiseq, datainicio, datafim, datacad, statseq) VALUES (9, 1, 1, 2, '2011-05-27', '2011-06-21', '2011-05-27', 1);
INSERT INTO dbfechamento_conta_financeira (seq, unidseq, usuaseq, cofiseq, datainicio, datafim, datacad, statseq) VALUES (12, 1, 1, 2, '2011-06-21', '2012-03-14', '2011-06-21', 1);
INSERT INTO dbfechamento_conta_financeira (seq, unidseq, usuaseq, cofiseq, datainicio, datafim, datacad, statseq) VALUES (15, 1, 1, 2, '2012-03-14', '2012-05-27', '2012-03-14', 1);
INSERT INTO dbfechamento_conta_financeira (seq, unidseq, usuaseq, cofiseq, datainicio, datafim, datacad, statseq) VALUES (18, 1, 1, 2, '2012-05-27', NULL, '2012-05-27', 8);
INSERT INTO dbfechamento_conta_financeira (seq, unidseq, usuaseq, cofiseq, datainicio, datafim, datacad, statseq) VALUES (6, 1, 1, 3, '2011-05-27', '2011-05-27', '2011-05-27', 1);
INSERT INTO dbfechamento_conta_financeira (seq, unidseq, usuaseq, cofiseq, datainicio, datafim, datacad, statseq) VALUES (7, 1, 1, 3, '2011-05-27', '2011-05-27', '2011-05-27', 1);
INSERT INTO dbfechamento_conta_financeira (seq, unidseq, usuaseq, cofiseq, datainicio, datafim, datacad, statseq) VALUES (10, 1, 1, 3, '2011-05-27', '2011-06-21', '2011-05-27', 1);
INSERT INTO dbfechamento_conta_financeira (seq, unidseq, usuaseq, cofiseq, datainicio, datafim, datacad, statseq) VALUES (13, 1, 1, 3, '2011-06-21', '2012-03-14', '2011-06-21', 1);
INSERT INTO dbfechamento_conta_financeira (seq, unidseq, usuaseq, cofiseq, datainicio, datafim, datacad, statseq) VALUES (16, 1, 1, 3, '2012-03-14', '2012-05-27', '2012-03-14', 1);
INSERT INTO dbfechamento_conta_financeira (seq, unidseq, usuaseq, cofiseq, datainicio, datafim, datacad, statseq) VALUES (19, 1, 1, 3, '2012-05-27', NULL, '2012-05-27', 8);


--
-- TOC entry 3919 (class 0 OID 16786)
-- Dependencies: 225 4034
-- Data for Name: dbforma_pagamento; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO dbforma_pagamento (seq, unidseq, usuaseq, titulo, datacad, statseq) VALUES (1, 1, 1, 'Dinheiro', '2013-08-01', 1);
INSERT INTO dbforma_pagamento (seq, unidseq, usuaseq, titulo, datacad, statseq) VALUES (2, 1, 1, 'Boleto', '2013-08-01', 1);
INSERT INTO dbforma_pagamento (seq, unidseq, usuaseq, titulo, datacad, statseq) VALUES (3, 1, 1, 'Cartão', '2013-08-01', 1);
INSERT INTO dbforma_pagamento (seq, unidseq, usuaseq, titulo, datacad, statseq) VALUES (4, 1, 1, 'Cheque', '2013-08-01', 1);


--
-- TOC entry 4186 (class 0 OID 0)
-- Dependencies: 224
-- Name: dbforma_pagamento_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbforma_pagamento_seq_seq', 5, true);


--
-- TOC entry 3921 (class 0 OID 16793)
-- Dependencies: 227 4034
-- Data for Name: dbfuncionario; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO dbfuncionario (seq, unidseq, usuaseq, pessseq, cargseq, deptseq, dataadmissao, relatorioexame, dataexame, regimecontrato, empterc, perfil, foto, cbo, pis_pasep, salario, gratificacao, beneficios, valorbeneficios, ferias, pagbanco, pagagencia, pagconta, pagvencimento, contadebito, numerodependentes, obs, datacad, statseq) VALUES (1, 1, 1, 1, 1, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '134.71541.31-3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2010-11-25', 1);


--
-- TOC entry 3923 (class 0 OID 16807)
-- Dependencies: 229 4034
-- Data for Name: dbfuncionario_ocorrencia; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4187 (class 0 OID 0)
-- Dependencies: 228
-- Name: dbfuncionario_ocorrencia_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbfuncionario_ocorrencia_seq_seq', 1, false);


--
-- TOC entry 4188 (class 0 OID 0)
-- Dependencies: 226
-- Name: dbfuncionario_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbfuncionario_seq_seq', 295, true);


--
-- TOC entry 3925 (class 0 OID 16819)
-- Dependencies: 231 4034
-- Data for Name: dbfuncionario_treinamento; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4189 (class 0 OID 0)
-- Dependencies: 230
-- Name: dbfuncionario_treinamento_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbfuncionario_treinamento_seq_seq', 1, false);


--
-- TOC entry 3927 (class 0 OID 16828)
-- Dependencies: 233 4034
-- Data for Name: dbgrade_avaliacao; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO dbgrade_avaliacao (seq, unidseq, usuaseq, titulo, observacoes, datacad, statseq) VALUES (3, 1, 1, 'Fibra Modelo', 'Grade de Avaliações conforme o regimento', '2011-04-08', 1);
INSERT INTO dbgrade_avaliacao (seq, unidseq, usuaseq, titulo, observacoes, datacad, statseq) VALUES (1, 1, 1, 'Pós Graduação GAP', NULL, '2011-04-14', 1);


--
-- TOC entry 4190 (class 0 OID 0)
-- Dependencies: 232
-- Name: dbgrade_avaliacao_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbgrade_avaliacao_seq_seq', 5, true);


--
-- TOC entry 3929 (class 0 OID 16840)
-- Dependencies: 235 4034
-- Data for Name: dbinscricao; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4191 (class 0 OID 0)
-- Dependencies: 234
-- Name: dbinscricao_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbinscricao_seq_seq', 2175, true);


--
-- TOC entry 3931 (class 0 OID 16851)
-- Dependencies: 237 4034
-- Data for Name: dblivro; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4192 (class 0 OID 0)
-- Dependencies: 236
-- Name: dblivro_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dblivro_seq_seq', 1387, true);


--
-- TOC entry 3933 (class 0 OID 16863)
-- Dependencies: 239 4034
-- Data for Name: dblocacao_livro; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4193 (class 0 OID 0)
-- Dependencies: 238
-- Name: dblocacao_livro_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dblocacao_livro_seq_seq', 1069, true);


--
-- TOC entry 3935 (class 0 OID 16877)
-- Dependencies: 241 4034
-- Data for Name: dbnota; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4194 (class 0 OID 0)
-- Dependencies: 240
-- Name: dbnota_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbnota_seq_seq', 10196, true);


--
-- TOC entry 3936 (class 0 OID 16887)
-- Dependencies: 242 4034
-- Data for Name: dbparametro_produto; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO dbparametro_produto (seq, unidseq, usuaseq, tabela, collabel, colvalor, coldesc, datacad, tpprseq, statseq) VALUES (1, 1, 1, 'dbturma', 'titulo', 'valortotal', 'TCurso;getLabel;cursseq', '2013-10-21', 3, 1);
INSERT INTO dbparametro_produto (seq, unidseq, usuaseq, tabela, collabel, colvalor, coldesc, datacad, tpprseq, statseq) VALUES (2, 1, 1, 'dblivro', '', '', '', '2013-10-21', 5, 1);
INSERT INTO dbparametro_produto (seq, unidseq, usuaseq, tabela, collabel, colvalor, coldesc, datacad, tpprseq, statseq) VALUES (3, 1, 1, 'dbparcela', 'seq', 'valoratual', 'obs', '2013-10-21', 7, 1);
INSERT INTO dbparametro_produto (seq, unidseq, usuaseq, tabela, collabel, colvalor, coldesc, datacad, tpprseq, statseq) VALUES (4, 1, 1, 'dbpatrimonio', 'label', 'valorcompra', 'descricao', '2013-10-21', 5, 1);


--
-- TOC entry 4195 (class 0 OID 0)
-- Dependencies: 243
-- Name: dbparametro_produto_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbparametro_produto_seq_seq', 4, true);


--
-- TOC entry 3939 (class 0 OID 16896)
-- Dependencies: 245 4034
-- Data for Name: dbparcela; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3941 (class 0 OID 16912)
-- Dependencies: 247 4034
-- Data for Name: dbparcela_estorno; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4196 (class 0 OID 0)
-- Dependencies: 246
-- Name: dbparcela_estorno_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbparcela_estorno_seq_seq', 1, false);


--
-- TOC entry 4197 (class 0 OID 0)
-- Dependencies: 244
-- Name: dbparcela_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbparcela_seq_seq', 26988, true);


--
-- TOC entry 3943 (class 0 OID 16923)
-- Dependencies: 249 4034
-- Data for Name: dbpatrimonio; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4198 (class 0 OID 0)
-- Dependencies: 248
-- Name: dbpatrimonio_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbpatrimonio_seq_seq', 1400, true);


--
-- TOC entry 3945 (class 0 OID 16941)
-- Dependencies: 251 4034
-- Data for Name: dbpessoa; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO dbpessoa (seq, unidseq, usuaseq, tipo, pessnmrz, pessnmrf, pessrgie, pessteim, cliente, fornecedor, funcionario, datacad, foto, statseq, email_principal, email_secundario) VALUES (1, 1, NULL, 'F', 'Administrador', 0, '', '', false, false, true, '2009-11-04', NULL, 1, NULL, NULL);


--
-- TOC entry 3947 (class 0 OID 16956)
-- Dependencies: 253 4034
-- Data for Name: dbpessoa_fisica; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4199 (class 0 OID 0)
-- Dependencies: 252
-- Name: dbpessoa_fisica_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbpessoa_fisica_seq_seq', 937, true);


--
-- TOC entry 3949 (class 0 OID 16969)
-- Dependencies: 255 4034
-- Data for Name: dbpessoa_juridica; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4200 (class 0 OID 0)
-- Dependencies: 254
-- Name: dbpessoa_juridica_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbpessoa_juridica_seq_seq', 61, true);


--
-- TOC entry 4201 (class 0 OID 0)
-- Dependencies: 250
-- Name: dbpessoa_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbpessoa_seq_seq', 2360, true);


--
-- TOC entry 4202 (class 0 OID 0)
-- Dependencies: 256
-- Name: dbpessoa_titularidade_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbpessoa_titularidade_seq_seq', 936, true);


--
-- TOC entry 3953 (class 0 OID 16994)
-- Dependencies: 259 4034
-- Data for Name: dbpha; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4203 (class 0 OID 0)
-- Dependencies: 258
-- Name: dbpha_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbpha_seq_seq', 1, false);


--
-- TOC entry 3955 (class 0 OID 17003)
-- Dependencies: 261 4034
-- Data for Name: dbplano_conta; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO dbplano_conta (seq, unidseq, usuaseq, nomeconta, tipoconta, tipocusto, obs, datacad, statseq) VALUES (37, 1, 1, 'Receita Financeira', 'C', 'V', NULL, '2010-10-14', 1);
INSERT INTO dbplano_conta (seq, unidseq, usuaseq, nomeconta, tipoconta, tipocusto, obs, datacad, statseq) VALUES (38, 1, 1, 'Despesa Financeira', 'D', 'V', NULL, '2010-10-14', 1);
INSERT INTO dbplano_conta (seq, unidseq, usuaseq, nomeconta, tipoconta, tipocusto, obs, datacad, statseq) VALUES (35, 1, 1, 'Encargos', 'D', 'V', '0', '2009-04-03', 1);
INSERT INTO dbplano_conta (seq, unidseq, usuaseq, nomeconta, tipoconta, tipocusto, obs, datacad, statseq) VALUES (1, 1, 1, 'Aluguel', 'D', 'F', '0', '2009-03-16', 1);
INSERT INTO dbplano_conta (seq, unidseq, usuaseq, nomeconta, tipoconta, tipocusto, obs, datacad, statseq) VALUES (2, 1, 1, 'Funcionario', 'D', 'F', '0', '2009-03-16', 1);
INSERT INTO dbplano_conta (seq, unidseq, usuaseq, nomeconta, tipoconta, tipocusto, obs, datacad, statseq) VALUES (4, 1, 1, 'Saneago', 'D', 'F', '0', '2009-03-18', 1);
INSERT INTO dbplano_conta (seq, unidseq, usuaseq, nomeconta, tipoconta, tipocusto, obs, datacad, statseq) VALUES (5, 1, 1, 'Contadora', 'D', 'F', '0', '2009-03-18', 1);
INSERT INTO dbplano_conta (seq, unidseq, usuaseq, nomeconta, tipoconta, tipocusto, obs, datacad, statseq) VALUES (6, 1, 1, 'Funcionario', 'D', 'F', '0', '2009-03-18', 1);
INSERT INTO dbplano_conta (seq, unidseq, usuaseq, nomeconta, tipoconta, tipocusto, obs, datacad, statseq) VALUES (7, 1, 1, 'Gasolina', 'D', 'V', '0', '2009-03-18', 1);
INSERT INTO dbplano_conta (seq, unidseq, usuaseq, nomeconta, tipoconta, tipocusto, obs, datacad, statseq) VALUES (8, 1, 1, 'Grafica', 'D', 'V', '0', '2009-03-18', 1);
INSERT INTO dbplano_conta (seq, unidseq, usuaseq, nomeconta, tipoconta, tipocusto, obs, datacad, statseq) VALUES (9, 1, 1, 'Imposto', 'D', 'F', '0', '2009-03-18', 1);
INSERT INTO dbplano_conta (seq, unidseq, usuaseq, nomeconta, tipoconta, tipocusto, obs, datacad, statseq) VALUES (10, 1, 1, 'Lanche', 'D', 'V', '0', '2009-03-18', 1);
INSERT INTO dbplano_conta (seq, unidseq, usuaseq, nomeconta, tipoconta, tipocusto, obs, datacad, statseq) VALUES (13, 1, 1, 'Outros', 'D', 'V', '0', '2009-03-18', 1);
INSERT INTO dbplano_conta (seq, unidseq, usuaseq, nomeconta, tipoconta, tipocusto, obs, datacad, statseq) VALUES (11, 1, 1, 'Refeicao', 'D', 'V', '0', '2009-03-18', 1);
INSERT INTO dbplano_conta (seq, unidseq, usuaseq, nomeconta, tipoconta, tipocusto, obs, datacad, statseq) VALUES (12, 1, 1, 'Material de Consumo', 'D', 'V', '0', '2009-03-18', 1);
INSERT INTO dbplano_conta (seq, unidseq, usuaseq, nomeconta, tipoconta, tipocusto, obs, datacad, statseq) VALUES (14, 1, 1, 'Papelaria', 'D', 'V', '0', '2009-03-18', 1);
INSERT INTO dbplano_conta (seq, unidseq, usuaseq, nomeconta, tipoconta, tipocusto, obs, datacad, statseq) VALUES (15, 1, 1, 'Pro Labore', 'D', 'F', '0', '2009-03-18', 1);
INSERT INTO dbplano_conta (seq, unidseq, usuaseq, nomeconta, tipoconta, tipocusto, obs, datacad, statseq) VALUES (16, 1, 1, 'Professor', 'D', 'V', '0', '2009-03-18', 1);
INSERT INTO dbplano_conta (seq, unidseq, usuaseq, nomeconta, tipoconta, tipocusto, obs, datacad, statseq) VALUES (17, 1, 1, 'Servicos Terceiros', 'D', 'V', '0', '2009-03-18', 1);
INSERT INTO dbplano_conta (seq, unidseq, usuaseq, nomeconta, tipoconta, tipocusto, obs, datacad, statseq) VALUES (18, 1, 1, 'Tarifa Bancaria', 'D', 'V', '0', '2009-03-18', 1);
INSERT INTO dbplano_conta (seq, unidseq, usuaseq, nomeconta, tipoconta, tipocusto, obs, datacad, statseq) VALUES (19, 1, 1, 'Vale Transporte', 'D', 'F', '0', '2009-03-18', 1);
INSERT INTO dbplano_conta (seq, unidseq, usuaseq, nomeconta, tipoconta, tipocusto, obs, datacad, statseq) VALUES (20, 1, 1, 'Emprestimo', 'D', 'F', '0', '2009-03-18', 1);
INSERT INTO dbplano_conta (seq, unidseq, usuaseq, nomeconta, tipoconta, tipocusto, obs, datacad, statseq) VALUES (21, 1, 1, 'Energia', 'D', 'F', '0', '2009-03-18', 1);
INSERT INTO dbplano_conta (seq, unidseq, usuaseq, nomeconta, tipoconta, tipocusto, obs, datacad, statseq) VALUES (22, 1, 1, 'Manutencao', 'D', 'V', '0', '2009-03-18', 1);
INSERT INTO dbplano_conta (seq, unidseq, usuaseq, nomeconta, tipoconta, tipocusto, obs, datacad, statseq) VALUES (23, 1, 1, 'Publicidade', 'D', 'V', '0', '2009-03-18', 1);
INSERT INTO dbplano_conta (seq, unidseq, usuaseq, nomeconta, tipoconta, tipocusto, obs, datacad, statseq) VALUES (24, 1, 1, 'Telefone', 'D', 'F', '0', '2009-03-18', 1);
INSERT INTO dbplano_conta (seq, unidseq, usuaseq, nomeconta, tipoconta, tipocusto, obs, datacad, statseq) VALUES (25, 1, 1, 'Treinamento', 'D', 'V', '0', '2009-03-18', 1);
INSERT INTO dbplano_conta (seq, unidseq, usuaseq, nomeconta, tipoconta, tipocusto, obs, datacad, statseq) VALUES (26, 1, 1, 'Xerox', 'D', 'F', '0', '2009-03-18', 1);
INSERT INTO dbplano_conta (seq, unidseq, usuaseq, nomeconta, tipoconta, tipocusto, obs, datacad, statseq) VALUES (27, 1, 1, 'Investimento', 'D', 'V', '0', '2009-03-18', 1);
INSERT INTO dbplano_conta (seq, unidseq, usuaseq, nomeconta, tipoconta, tipocusto, obs, datacad, statseq) VALUES (28, 1, 1, 'Consultoria', 'C', 'F', '0', '2009-03-18', 1);
INSERT INTO dbplano_conta (seq, unidseq, usuaseq, nomeconta, tipoconta, tipocusto, obs, datacad, statseq) VALUES (29, 1, 1, 'Treinamento', 'C', 'V', '0', '2009-03-18', 1);
INSERT INTO dbplano_conta (seq, unidseq, usuaseq, nomeconta, tipoconta, tipocusto, obs, datacad, statseq) VALUES (30, 1, 1, 'Pos Graduacao', 'C', 'F', '0', '2009-03-18', 1);
INSERT INTO dbplano_conta (seq, unidseq, usuaseq, nomeconta, tipoconta, tipocusto, obs, datacad, statseq) VALUES (31, 1, 1, 'Cursos Informatica', 'C', 'V', '0', '2009-03-18', 1);
INSERT INTO dbplano_conta (seq, unidseq, usuaseq, nomeconta, tipoconta, tipocusto, obs, datacad, statseq) VALUES (32, 1, 1, 'Recursos Humanos', 'C', 'V', '0', '2009-03-18', 1);
INSERT INTO dbplano_conta (seq, unidseq, usuaseq, nomeconta, tipoconta, tipocusto, obs, datacad, statseq) VALUES (33, 1, 1, 'Outros', 'C', 'V', '0', '2009-03-18', 1);
INSERT INTO dbplano_conta (seq, unidseq, usuaseq, nomeconta, tipoconta, tipocusto, obs, datacad, statseq) VALUES (34, 1, 1, 'Aluguel de Sala', 'C', 'V', '0', '2009-03-18', 1);


--
-- TOC entry 4204 (class 0 OID 0)
-- Dependencies: 260
-- Name: dbplano_conta_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbplano_conta_seq_seq', 40, true);


--
-- TOC entry 3957 (class 0 OID 17016)
-- Dependencies: 263 4034
-- Data for Name: dbprocesso_academico; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO dbprocesso_academico (seq, unidseq, usuaseq, titulo, procedimento, requisitos, alteratransacao, datacad, formseq, statseq) VALUES (44, 1, 1, 'Segunda Via do Diploma', '', NULL, false, '2010-09-15', 0, 9);
INSERT INTO dbprocesso_academico (seq, unidseq, usuaseq, titulo, procedimento, requisitos, alteratransacao, datacad, formseq, statseq) VALUES (15, 1, 1, 'Boleto', 'É um título de cobrança pagável em qualquer agência bancária do território nacional durante o período no qual o título de cobrança ainda não venceu, ou seja, até a data de vencimento. Após o vencimento, o boleto só poderá ser pago no banco que o emitiu, salvo as regras estipuladas pela Instituição para não receber após a data de vencimento.', NULL, false, '2010-09-15', 0, 9);
INSERT INTO dbprocesso_academico (seq, unidseq, usuaseq, titulo, procedimento, requisitos, alteratransacao, datacad, formseq, statseq) VALUES (16, 1, 1, 'Bolsas', 'São incentivos ao aluno para auxiliar nos custos dos seus estudos.

As bolsas oferecidas pela Universidade são: PROUNI, bolsa do artigo 170 - estudo e pesquisa, bolsa do artigo 171, bolsa em projetos de pesquisa (PUIC, PIBIC, PMUC), bolsa em projetos de extensão.', NULL, false, '2010-09-15', 0, 9);
INSERT INTO dbprocesso_academico (seq, unidseq, usuaseq, titulo, procedimento, requisitos, alteratransacao, datacad, formseq, statseq) VALUES (21, 1, 1, 'ENEM', 'O ENEM é uma avaliação realizada pelo Ministério da Educação, e também mais uma forma de Ingresso na Universidade. Pode ser realizado por alunos concluintes ou egressos do ensino médio.', NULL, false, '2010-09-15', 0, 9);
INSERT INTO dbprocesso_academico (seq, unidseq, usuaseq, titulo, procedimento, requisitos, alteratransacao, datacad, formseq, statseq) VALUES (26, 1, 1, 'Licença Gestante', 'À gestante é oferecido o atendimento especial de Licença de Gestação. Conforme prevê a Lei no. 6.202, de 17/4/75 a partir do oitavo mês, a gestante tem direito a 90 dias de licença, ou seja, um mês antes do parto e dois após, comprovado mediante atestado médico.', NULL, false, '2010-09-15', 0, 9);
INSERT INTO dbprocesso_academico (seq, unidseq, usuaseq, titulo, procedimento, requisitos, alteratransacao, datacad, formseq, statseq) VALUES (4, 1, 1, 'Abandono de Curso', 'É a não-efetivação de matrícula pelo aluno para um novo período letivo ocasionando a desvinculação com o curso e com a Universidade. Será também considerado em situação de abandono o aluno que atingiu o limite permitido de períodos em trancamento e deixou de matricular-se no período letivo imediatamente subsequente.', NULL, false, '2010-09-15', 431, 1);
INSERT INTO dbprocesso_academico (seq, unidseq, usuaseq, titulo, procedimento, requisitos, alteratransacao, datacad, formseq, statseq) VALUES (27, 1, 1, 'Licença Médica: Atestado Médico ou Odontológico', 'O regime adotado para os cursos presenciais é o da presença obrigatória, nos termos da lei. Assim, a falta às atividades acadêmicas em face de compromisso médico ou odontológico – agendado ou não – não abona as faltas, mas apenas as justifica. Se comunicado com antecedência, facultará ao docente a proposição de atividades pedagógicas compensatórias. Noutra hipótese, a falta permanecerá, sendo apenas justificada.', NULL, false, '2010-09-15', 0, 9);
INSERT INTO dbprocesso_academico (seq, unidseq, usuaseq, titulo, procedimento, requisitos, alteratransacao, datacad, formseq, statseq) VALUES (28, 1, 1, 'Matrícula de Aluno Ingressante', 'É a matrícula dos candidatos aprovados em processo seletivo. Deverá ser realizada atendendo à legislação vigente e às normas institucionais. A falta de um dos documentos estipulados no edital implicará a não-efetivação da matrícula, não cabendo recurso, nem lhe sendo facultada a matrícula condicional. ', NULL, false, '2010-09-15', 0, 9);
INSERT INTO dbprocesso_academico (seq, unidseq, usuaseq, titulo, procedimento, requisitos, alteratransacao, datacad, formseq, statseq) VALUES (5, 1, 1, 'Abono de Faltas', 'Não há abono de faltas com exceção dos casos amparados pela Lei no 4.375/64, em seu artigo 60, parágrafo 4 e pelo Decreto Lei no 715/69 ou seja, militar convocado para manobra ou exercício de ato cívico.', NULL, false, '2010-09-15', 432, 9);
INSERT INTO dbprocesso_academico (seq, unidseq, usuaseq, titulo, procedimento, requisitos, alteratransacao, datacad, formseq, statseq) VALUES (12, 1, 1, 'Atestado de Matrícula', 'É o documento que comprova a regularidade da matrícula do aluno no curso e na Instituição de Ensino.', NULL, false, '2010-09-15', 435, 9);
INSERT INTO dbprocesso_academico (seq, unidseq, usuaseq, titulo, procedimento, requisitos, alteratransacao, datacad, formseq, statseq) VALUES (29, 1, 1, 'Matrícula de Processos', 'É a matrícula dos candidatos aprovados em processos de transferência interna e externa, reingresso, retorno, remanejamento de campus, troca de turno, destrancamento de matrícula e permanência para nova habilitação.', NULL, false, '2010-09-15', 0, 9);
INSERT INTO dbprocesso_academico (seq, unidseq, usuaseq, titulo, procedimento, requisitos, alteratransacao, datacad, formseq, statseq) VALUES (30, 1, 1, 'Migração de Currículo', 'É a transferência do aluno de um currículo já existente para um em implantação. Pode ser realizada somente mediante documento de anuência do aluno e de análise de aproveitamento de disciplinas, pelo coordenador do curso.', NULL, false, '2010-09-15', 0, 9);
INSERT INTO dbprocesso_academico (seq, unidseq, usuaseq, titulo, procedimento, requisitos, alteratransacao, datacad, formseq, statseq) VALUES (31, 1, 1, 'Pré-requisito', 'São as condições que o aluno deve necessariamente cumprir para que possa matricular-se em uma determinada disciplina ou atividade prevista no projeto do curso. A condição pode ser a aprovação em disciplina ou disciplinas, atividades ou exame de proficiência. É responsabilidade do aluno observar os pré-requisitos determinados no projeto pedagógico do curso.

O pedido será encaminhado para avaliação do Coordenador do Curso e caso seja deferido, a disciplina solicitada será incluída automaticamente, na matrícula do aluno.', NULL, false, '2010-09-15', 0, 9);
INSERT INTO dbprocesso_academico (seq, unidseq, usuaseq, titulo, procedimento, requisitos, alteratransacao, datacad, formseq, statseq) VALUES (36, 1, 1, 'Troca de Turno', 'É a transferência de um turno para o outro, dentro do mesmo campus ou unidseq, quando o curso é oferecido em dois ou mais turnos distintos.', NULL, false, '2010-09-15', 0, 9);
INSERT INTO dbprocesso_academico (seq, unidseq, usuaseq, titulo, procedimento, requisitos, alteratransacao, datacad, formseq, statseq) VALUES (37, 1, 1, 'Prouni', 'Programa Universidade para todos foi criado pela MP. 213/2004 e institucionalizado pela Lei no 11.096, de 13 de janeiro de 2005, cuja finalidade é a concessão de bolsas de estudos integrais e parciais a estudantes de baixa renda para cursos de graduação e seqüenciais de formação específica, em instituições privadas de educação superior.

Para conhecer os procedimentos, visite o link do PROUNI no Portal Universidade.', NULL, false, '2010-09-15', 0, 9);
INSERT INTO dbprocesso_academico (seq, unidseq, usuaseq, titulo, procedimento, requisitos, alteratransacao, datacad, formseq, statseq) VALUES (39, 1, 1, 'Refinanciamento de Débitos', 'É regulamentado através de instrução normativa semestral que oferece condições para parcelamento de dívida de mensalidade do semestre corrente. As datas para refinanciamentos são divulgadas no decorrer de cada semestre no Informativo de Matrícula e no site da Universidade.', NULL, false, '2010-09-15', 0, 9);
INSERT INTO dbprocesso_academico (seq, unidseq, usuaseq, titulo, procedimento, requisitos, alteratransacao, datacad, formseq, statseq) VALUES (40, 1, 1, 'Reingresso', 'É a forma de ingresso destinada a portador de diploma de curso superior de graduação ou sequencial de formação específica para um novo curso ou habilitação.', NULL, false, '2010-09-15', 0, 9);
INSERT INTO dbprocesso_academico (seq, unidseq, usuaseq, titulo, procedimento, requisitos, alteratransacao, datacad, formseq, statseq) VALUES (41, 1, 1, 'Relevação de Perda de Prazo', 'Conforme Instrução Normativa PROAC n° 01/2002, a Relevação de Perda de Prazo se aplica a toda e qualquer espécie de solicitação para a qual esteja fixada data ou prazo limite para ingresso do pedido no protocolo da Universidade. Tem a finalidade de dar uma nova oportunidade ao aluno, de requerer a solicitação específica que deixou de cumprir, no prazo estabelecido em Calendário Acadêmico, Edital, Regulamento Interno ou por determinação da Universidade. A aceitação do requerimento de relevação de perda de prazo não garante ao aluno o deferimento de seu pedido específico. Na solicitação, o aluno deverá indicar o processo em que deixou de cumprir o prazo.', NULL, false, '2010-09-15', 0, 9);
INSERT INTO dbprocesso_academico (seq, unidseq, usuaseq, titulo, procedimento, requisitos, alteratransacao, datacad, formseq, statseq) VALUES (19, 1, 1, 'Desistência de Vaga', 'É a desvinculação total do aluno com o curso e a Instituição, protocolada pelo aluno ou seu representante legal. O aluno só pode solicitá-la caso não tenha, no semestre, concluído nenhuma disciplina em que tenha se matriculado.', NULL, false, '2010-09-15', 0, 9);
INSERT INTO dbprocesso_academico (seq, unidseq, usuaseq, titulo, procedimento, requisitos, alteratransacao, datacad, formseq, statseq) VALUES (18, 1, 1, 'Crédito Acadêmico', 'É a unidade que corresponde a um conjunto de conteúdos e atividades exigidas para a integralização do curso. Cada crédito corresponde a 15 horas-aula.', NULL, false, '2010-09-15', 0, 9);
INSERT INTO dbprocesso_academico (seq, unidseq, usuaseq, titulo, procedimento, requisitos, alteratransacao, datacad, formseq, statseq) VALUES (32, 1, 1, 'Trancamento de Disciplina', 'É a desistência do aluno, com matrícula regular, de continuar cursando uma ou mais disciplinas.

A partir do trancamento da disciplina, o aluno está isento de pagar as parcelas vincendas, no entanto, não é restituído dos valores pagos.', NULL, false, '2010-09-15', 0, 9);
INSERT INTO dbprocesso_academico (seq, unidseq, usuaseq, titulo, procedimento, requisitos, alteratransacao, datacad, formseq, statseq) VALUES (42, 1, 1, 'Remanejamento de Campus', 'É a transferência do aluno entre os campi ou unidades de aluno da Universidade para curso idêntico àquele em que esteja regularmente matriculado. Pode dar-se nas seguintes situações:

Aluno regularmente matriculado;
Aluno com matricula trancada. Neste último caso, o remanejamento fica condicionado ao período de validade do trancamento de matrícula. Nas duas situações, o remanejamento fica condicionado à existência de vaga e à solicitação de requerimento no setor de atendimento ao aluno.
Maiores informações acesse o Portal da Universidade no menu Informações Acadêmicas/Remanejamento de Campus.', NULL, false, '2010-09-15', 0, 9);
INSERT INTO dbprocesso_academico (seq, unidseq, usuaseq, titulo, procedimento, requisitos, alteratransacao, datacad, formseq, statseq) VALUES (34, 1, 1, 'Transferência Externa do Exterior', 'É a passagem do vínculo (matrícula) que o aluno tem com o estabelecimento de origem estrangeira, para um estabelecimento no Brasil.', NULL, false, '2010-09-15', 0, 9);
INSERT INTO dbprocesso_academico (seq, unidseq, usuaseq, titulo, procedimento, requisitos, alteratransacao, datacad, formseq, statseq) VALUES (45, 1, 1, 'Semestre Letivo', 'É o período definido pela IES para distribuição das atividades acadêmicas de um curso durante o período de um semestre, representado por cem dias de trabalho escolar efetivo. Na Universidade, o semestre letivo tem duração de 20 semanas, excluído o período de avaliação final.

Confira a data inicial e final que compreende ao Semestre Letivo de cada ano no Portal Universidade no menu Informações Acadêmicas/Calendário Acadêmico.', NULL, false, '2010-09-15', 0, 9);
INSERT INTO dbprocesso_academico (seq, unidseq, usuaseq, titulo, procedimento, requisitos, alteratransacao, datacad, formseq, statseq) VALUES (11, 1, 1, 'Atestado de Frequência', 'É o documento que comprova a freqüência do aluno nas disciplinas em que estiver efetivamente matriculado e cursando.', NULL, false, '2010-09-15', 0, 9);
INSERT INTO dbprocesso_academico (seq, unidseq, usuaseq, titulo, procedimento, requisitos, alteratransacao, datacad, formseq, statseq) VALUES (23, 1, 1, 'Histórico Escolar', 'É o documento oficial que representa o desempenho acadêmico do aluno e contém o registro de todas as atividades acadêmicas previstas na organização curricular e resultados obtidos durante o seu vínculo com a Instituição de Ensino.', NULL, false, '2010-09-15', 439, 1);
INSERT INTO dbprocesso_academico (seq, unidseq, usuaseq, titulo, procedimento, requisitos, alteratransacao, datacad, formseq, statseq) VALUES (25, 1, 1, 'Justificativa de Faltas', 'É a situação em que o aluno, regularmente matriculado e amparado pela legislação (Lei 6.202/75), necessita de uma programação que possibilite a apreensão e compreensão dos conteúdos estabelecidos em técnicas e procedimentos especiais, adequados às peculiaridades dos casos e dos componentescurriculares. Pode ser também facultada aos alunos portadores de afecções congênitas ou adquiridas, traumatismos ou outras condições mórbidas que determinem incapacidade relativa, conforme lei 1044/69. A justificativa de faltas difere do abono de faltas', NULL, false, '2010-09-15', 440, 9);
INSERT INTO dbprocesso_academico (seq, unidseq, usuaseq, titulo, procedimento, requisitos, alteratransacao, datacad, formseq, statseq) VALUES (33, 1, 1, 'Transferência Externa', 'É a transferência do vínculo do aluno de curso de graduação ou pós-graduação stricto sensu de um estabelecimento de origem para outro estabelecimento de destino.', NULL, false, '2010-09-15', 471, 1);
INSERT INTO dbprocesso_academico (seq, unidseq, usuaseq, titulo, procedimento, requisitos, alteratransacao, datacad, formseq, statseq) VALUES (22, 1, 1, 'Guia de Transferência', 'E o documento oficial exigido e emitido pela Universidade e que transfere o vínculo do aluno com o curso para outra instituição de Ensino Superior para prosseguimento de seus estudos. Se o vínculo de matrícula não existir, a Guia de Transferência não poderá ser expedida.', NULL, false, '2010-09-15', 438, 9);
INSERT INTO dbprocesso_academico (seq, unidseq, usuaseq, titulo, procedimento, requisitos, alteratransacao, datacad, formseq, statseq) VALUES (43, 1, 1, 'Ressarcimento para Desistência do Curso', 'É a possibilidade de resgatar 80% do valor pago referente a matrícula. A diferença é retida em função de despesas administrativas. Pode ser realizado até 1(um) dia útil antes do início das aulas.', NULL, false, '2010-09-15', 442, 9);
INSERT INTO dbprocesso_academico (seq, unidseq, usuaseq, titulo, procedimento, requisitos, alteratransacao, datacad, formseq, statseq) VALUES (20, 1, 1, 'Reabertura de Matrícula', 'O destrancamento de matrícula é a solicitação formal da continuidade dos estudos de aluno com matrícula trancada. A solicitação de destrancamento de matrícula pode ser cumulada com solicitação de transferência interna, remanejamento de campus ou troca de turno, devendo o aluno, para tanto, realizar pedidos concomitantes.', NULL, false, '2010-09-15', 437, 1);
INSERT INTO dbprocesso_academico (seq, unidseq, usuaseq, titulo, procedimento, requisitos, alteratransacao, datacad, formseq, statseq) VALUES (46, 1, 1, 'Trancamento de Curso', 'Consiste na interrupção temporária dos estudos, solicitado pelo aluno, através de requerimento.', NULL, false, '2010-09-15', 473, 1);
INSERT INTO dbprocesso_academico (seq, unidseq, usuaseq, titulo, procedimento, requisitos, alteratransacao, datacad, formseq, statseq) VALUES (24, 1, 1, 'Integralização Curricular', 'É a conclusão e a aprovação em todas as disciplinas e atividades previstas na organização curricular expresso no Projeto Pedagógico do curso.', NULL, false, '2010-09-15', 0, 9);
INSERT INTO dbprocesso_academico (seq, unidseq, usuaseq, titulo, procedimento, requisitos, alteratransacao, datacad, formseq, statseq) VALUES (1, 1, 1, 'Revisão de Avaliação Final', 'A solicitação de Revisão de Avaliação Final é regulamentada pela Resolução CÂM-EN no. 03/91, e com exceção dos Cursos que possuem Resolução própria, o pedido deverá ser realizado no prazo de até 48 horas úteis, após a data de publicação do resultado da avaliação final. O não preenchimento deste requisito implicará no indeferimento do requerimento.', NULL, false, '2010-09-15', 0, 9);
INSERT INTO dbprocesso_academico (seq, unidseq, usuaseq, titulo, procedimento, requisitos, alteratransacao, datacad, formseq, statseq) VALUES (2, 1, 1, 'Retorno', 'É a possibilidade de obtenção de vaga por ex-alunos da Universidade que tenham abandonado ou desistido do curso.

O retorno é realizado para o mesmo curso e para o currículo em vigor no semestre para o qual foi definido o retorno.

Para maiores informações acesse o Portal da Universidade no menu Informações Acadêmicas/Retorno.', NULL, false, '2010-09-15', 0, 9);
INSERT INTO dbprocesso_academico (seq, unidseq, usuaseq, titulo, procedimento, requisitos, alteratransacao, datacad, formseq, statseq) VALUES (3, 1, 1, 'Revisão de Avaliação', 'A solicitação de Revisão de Avaliação é regulamentada pela Resolução CÂM-EN no. 03/91 e, com exceção dos Cursos que possuem Resolução própria, o pedido deverá ser realizado no prazo de até 48 horas úteis, após a data de publicação do resultado da avaliação. O não preenchimento deste requisito implicará no indeferimento do requerimento.', NULL, false, '2010-09-15', 0, 9);
INSERT INTO dbprocesso_academico (seq, unidseq, usuaseq, titulo, procedimento, requisitos, alteratransacao, datacad, formseq, statseq) VALUES (7, 1, 1, 'Apostilamento de Diploma', 'O apostilamento de diploma consiste no acréscimo ou alteração de informação constantes no diploma, mediante averbação no verso do mesmo.

O apostilamento de diploma poderá ocorrer nos seguintes casos:

Alteração comprovada do nome do aluno;
Correção do número do RG;
Conclusão de nova habilitação para determinados curso como Comunicação social (jornalismo, publicidade e propaganda ou cinema e vídeo), Letras (inglês, espanhol, italiano) e outros.', NULL, false, '2010-09-15', 0, 9);
INSERT INTO dbprocesso_academico (seq, unidseq, usuaseq, titulo, procedimento, requisitos, alteratransacao, datacad, formseq, statseq) VALUES (9, 1, 1, 'Atestado de Formado', 'É o documento que comprova a situação acadêmica do aluno que já integralizou o currículo e que já colou grau, atestando a data da cerimônia de outorga de grau e a fase em que se encontra o processo de emissão do diploma.', NULL, false, '2010-09-15', 0, 9);
INSERT INTO dbprocesso_academico (seq, unidseq, usuaseq, titulo, procedimento, requisitos, alteratransacao, datacad, formseq, statseq) VALUES (10, 1, 1, 'Atestado de Formando', 'É o documento que comprova a situação do aluno prestes a integralizar o curso, ou de aluno que, tendo já integralizado o currículo, ainda não tenha recebido a outorga de grau, embora com data já definida.', NULL, false, '2010-09-15', 0, 9);
INSERT INTO dbprocesso_academico (seq, unidseq, usuaseq, titulo, procedimento, requisitos, alteratransacao, datacad, formseq, statseq) VALUES (13, 1, 1, 'Avaliação Presencial 2ª Chamada', 'A solicitação de prova de 2ª chamada destina-se a alunos matriculados em cursos ou disciplinas a distância e que, por motivo justificado e comprovado, não puderam realizar a prova na data prevista pelo professor. Com exceção dos Cursos que possuem regulamentação própria, o pedido deverá ser realizado no prazo de até 48 horas úteis, após a data da prova.', NULL, false, '2010-09-15', 0, 9);
INSERT INTO dbprocesso_academico (seq, unidseq, usuaseq, titulo, procedimento, requisitos, alteratransacao, datacad, formseq, statseq) VALUES (14, 1, 1, 'Benefício', 'São vantagens disponibilizadas aos alunos, professores e funcionários que compõe a Universidade.', NULL, false, '2010-09-15', 0, 9);
INSERT INTO dbprocesso_academico (seq, unidseq, usuaseq, titulo, procedimento, requisitos, alteratransacao, datacad, formseq, statseq) VALUES (35, 1, 1, 'Transferência Interna', 'É a transferência do aluno de um curso para outro, dentro da Universidade.', NULL, false, '2010-09-15', 472, 1);
INSERT INTO dbprocesso_academico (seq, unidseq, usuaseq, titulo, procedimento, requisitos, alteratransacao, datacad, formseq, statseq) VALUES (38, 1, 1, 'Prova de Segunda Chamada', 'A solicitação de prova de 2ª chamada destina-se a alunos que, por motivo justificado e comprovado, não puderam realizar a prova na data prevista pelo professor. Com exceção dos Cursos que possuem regulamentação própria, o pedido deverá ser realizado no prazo de até 48 horas úteis, após a data da prova.', NULL, false, '2010-09-15', 441, 9);
INSERT INTO dbprocesso_academico (seq, unidseq, usuaseq, titulo, procedimento, requisitos, alteratransacao, datacad, formseq, statseq) VALUES (8, 1, 1, 'Aproveitamento de Disciplina', 'É o resultado da análise de equivalência entre disciplinas cursadas em outros cursos da Universidade ou em outras Instituições de Ensino Superior (IES) e as disciplinas da matriz curricular do curso no qual o aluno está matriculado. Este processo objetiva o aproveitamento e validação das disciplinas já cursadas, com as do curso atual. Para serem consideradas equivalentes, a disciplina a ser aproveitada precisa corresponder em 75% do conteúdo e ter carga horária igual ou superior àquela que se quer validar.', NULL, false, '2010-09-15', 434, 1);
INSERT INTO dbprocesso_academico (seq, unidseq, usuaseq, titulo, procedimento, requisitos, alteratransacao, datacad, formseq, statseq) VALUES (47, 1, 1, 'Regularização de Aluno Especial', 'Consiste na correção da grade de disciplinas do aluno.', NULL, false, '2011-02-05', 454, 1);
INSERT INTO dbprocesso_academico (seq, unidseq, usuaseq, titulo, procedimento, requisitos, alteratransacao, datacad, formseq, statseq) VALUES (6, 1, 1, 'Revalidação de Diploma', 'Para ingresso em cursos superiores, os alunos formados no exterior, salvo em países com os quais o Brasil possui acordos, deverão ter seu diploma revalidado, conforme determina a legislação.', NULL, false, '2010-09-15', 433, 9);
INSERT INTO dbprocesso_academico (seq, unidseq, usuaseq, titulo, procedimento, requisitos, alteratransacao, datacad, formseq, statseq) VALUES (17, 1, 1, 'Colação de Grau em Gabinete', 'Poderá ser outorgado o grau em data e local determinado pelo Reitor, ou por quem com delegação para tal e na presença de, no mínimo, dois professores, ao aluno formando que não puder receber o grau na sessão solene, por motivo justificado e devidamente comprovado, desde que formalmente solicitado.

Para a colação de grau, o aluno não poderá ter nenhuma pendência de documentos na Universidade.', NULL, false, '2010-09-15', 436, 9);


--
-- TOC entry 4205 (class 0 OID 0)
-- Dependencies: 262
-- Name: dbprocesso_academico_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbprocesso_academico_seq_seq', 48, true);


--
-- TOC entry 3959 (class 0 OID 17028)
-- Dependencies: 265 4034
-- Data for Name: dbproduto; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4206 (class 0 OID 0)
-- Dependencies: 264
-- Name: dbproduto_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbproduto_seq_seq', 1819, true);


--
-- TOC entry 3961 (class 0 OID 17042)
-- Dependencies: 267 4034
-- Data for Name: dbprofessor; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3963 (class 0 OID 17054)
-- Dependencies: 269 4034
-- Data for Name: dbprofessor_area; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4207 (class 0 OID 0)
-- Dependencies: 268
-- Name: dbprofessor_area_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbprofessor_area_seq_seq', 99, true);


--
-- TOC entry 4208 (class 0 OID 0)
-- Dependencies: 266
-- Name: dbprofessor_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbprofessor_seq_seq', 317, true);


--
-- TOC entry 3965 (class 0 OID 17063)
-- Dependencies: 271 4034
-- Data for Name: dbprojeto_curso; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3967 (class 0 OID 17075)
-- Dependencies: 273 4034
-- Data for Name: dbprojeto_curso_disciplina; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4209 (class 0 OID 0)
-- Dependencies: 272
-- Name: dbprojeto_curso_disciplina_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbprojeto_curso_disciplina_seq_seq', 1457, true);


--
-- TOC entry 4210 (class 0 OID 0)
-- Dependencies: 270
-- Name: dbprojeto_curso_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbprojeto_curso_seq_seq', 134, true);


--
-- TOC entry 3969 (class 0 OID 17084)
-- Dependencies: 275 4034
-- Data for Name: dbrecado; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4211 (class 0 OID 0)
-- Dependencies: 274
-- Name: dbrecado_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbrecado_seq_seq', 284, true);


--
-- TOC entry 3971 (class 0 OID 17098)
-- Dependencies: 277 4034
-- Data for Name: dbregra_avaliacao; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO dbregra_avaliacao (seq, unidseq, usuaseq, titulo, observacoes, datacad, statseq) VALUES (1, 1, 1, 'Avaliação Comum', NULL, '2011-04-08', 1);
INSERT INTO dbregra_avaliacao (seq, unidseq, usuaseq, titulo, observacoes, datacad, statseq) VALUES (3, 1, 1, 'Avaliação de Recuperação por Agregação relacionada à Avaliações', NULL, '2011-04-08', 1);
INSERT INTO dbregra_avaliacao (seq, unidseq, usuaseq, titulo, observacoes, datacad, statseq) VALUES (2, 1, 1, 'Avaliação de Recuperação por Substituição relacionada à Avaliações', NULL, '2011-04-08', 1);
INSERT INTO dbregra_avaliacao (seq, unidseq, usuaseq, titulo, observacoes, datacad, statseq) VALUES (4, 1, 1, 'Avaliação de Recuperação por Substituição relacionada à Média', NULL, '2011-04-08', 1);
INSERT INTO dbregra_avaliacao (seq, unidseq, usuaseq, titulo, observacoes, datacad, statseq) VALUES (5, 1, 1, 'Avaliação de Recuperação por Agregação relacionada à Média', NULL, '2011-04-08', 1);


--
-- TOC entry 4212 (class 0 OID 0)
-- Dependencies: 276
-- Name: dbregra_avaliacao_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbregra_avaliacao_seq_seq', 6, true);


--
-- TOC entry 3973 (class 0 OID 17110)
-- Dependencies: 279 4034
-- Data for Name: dbrequisito_turma; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4213 (class 0 OID 0)
-- Dependencies: 278
-- Name: dbrequisito_turma_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbrequisito_turma_seq_seq', 192, true);


--
-- TOC entry 3975 (class 0 OID 17122)
-- Dependencies: 281 4034
-- Data for Name: dbsala; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO dbsala (seq, unidseq, usuaseq, nome, endereco, descricao, salaaula, datacad, capacidade, statseq) VALUES (8, 1, 1, 'Laboratório de informática', 'Praça Manoel Demostenes', 'Composta por mesas e cadeiras', true, '2009-03-14', '25', 1);
INSERT INTO dbsala (seq, unidseq, usuaseq, nome, endereco, descricao, salaaula, datacad, capacidade, statseq) VALUES (6, 1, 1, 'Sala de aula média', 'Praça Manoel Demostenes', 'Sala composta por carteiras', true, '2009-03-14', '50', 1);
INSERT INTO dbsala (seq, unidseq, usuaseq, nome, endereco, descricao, salaaula, datacad, capacidade, statseq) VALUES (5, 1, 1, 'Sala de aula pequena - frente', 'Praça Manoel Demostenes', 'Sala de aula composta por carteiras', true, '2009-03-14', '45', 1);
INSERT INTO dbsala (seq, unidseq, usuaseq, nome, endereco, descricao, salaaula, datacad, capacidade, statseq) VALUES (1, 1, 1, 'Sala Diretoria', 'Praça Manoel Demostenes', '03 mesas de trabalho, 01 armario grande, 01 armario baixo, 01 criado com 03 gavetas. ', false, '2009-03-14', '06', 1);
INSERT INTO dbsala (seq, unidseq, usuaseq, nome, endereco, descricao, salaaula, datacad, capacidade, statseq) VALUES (7, 1, 1, 'Sala de Aula Havard', 'Praça Manoel Demostenes', 'Sala estilo auditorio com mesas fixas e cadeiras giratorias', true, '2009-03-14', '60', 1);
INSERT INTO dbsala (seq, unidseq, usuaseq, nome, endereco, descricao, salaaula, datacad, capacidade, statseq) VALUES (4, 1, 1, 'Biblioteca', 'Praça Manoel Demostenes', 'Estantes fixas, mesa oval para 6 pessoas, 1 mesa com cadeira para bibliotecaria, 03 baias de computador fixo, 02 baias de estudo individual e 01 estante. ', false, '2009-03-14', '12', 1);
INSERT INTO dbsala (seq, unidseq, usuaseq, nome, endereco, descricao, salaaula, datacad, capacidade, statseq) VALUES (3, 1, 1, 'Recepção', 'Praça Manoel Demostenes', '', false, '2009-03-14', '03', 1);
INSERT INTO dbsala (seq, unidseq, usuaseq, nome, endereco, descricao, salaaula, datacad, capacidade, statseq) VALUES (2, 1, 1, 'Sala de Professores e Consultores', 'Praça Manoel Demostenes', '01 mesa de reuniao e trabalho com 04 cadeiras giratorias, 01 diva, 01 mesa com 02 computadores fixo, 01 armario.', false, '2009-03-14', '7', 1);
INSERT INTO dbsala (seq, unidseq, usuaseq, nome, endereco, descricao, salaaula, datacad, capacidade, statseq) VALUES (9, 1, 1, 'Sala do Coordenador', 'Praça Manoel Demostenes', '01 mesa com computador fixo e 01 armario fixo. ', false, '2010-10-16', '3', 1);
INSERT INTO dbsala (seq, unidseq, usuaseq, nome, endereco, descricao, salaaula, datacad, capacidade, statseq) VALUES (10, 1, 1, 'Treinamento Odontologico', 'Praça Manoel Demostenes', '', false, '2010-10-16', '20', 1);


--
-- TOC entry 4214 (class 0 OID 0)
-- Dependencies: 280
-- Name: dbsala_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbsala_seq_seq', 11, true);


--
-- TOC entry 3977 (class 0 OID 17135)
-- Dependencies: 283 4034
-- Data for Name: dbsituacao_boleto; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO dbsituacao_boleto (seq, unidseq, usuaseq, titulo, datacad, statseq) VALUES (1, 1, 1, 'Ativo', '2013-08-01', 1);
INSERT INTO dbsituacao_boleto (seq, unidseq, usuaseq, titulo, datacad, statseq) VALUES (9, 1, 1, 'Inativo', '2013-08-01', 1);
INSERT INTO dbsituacao_boleto (seq, unidseq, usuaseq, titulo, datacad, statseq) VALUES (2, 1, 1, 'Pago', '2013-09-13', 1);


--
-- TOC entry 4215 (class 0 OID 0)
-- Dependencies: 282
-- Name: dbsituacao_boleto_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbsituacao_boleto_seq_seq', 10, true);


--
-- TOC entry 3979 (class 0 OID 17142)
-- Dependencies: 285 4034
-- Data for Name: dbsituacao_caixa_funcionario; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO dbsituacao_caixa_funcionario (seq, unidseq, usuaseq, titulo, datacad, statseq) VALUES (1, 1, 1, 'Liberado para Movimentações', '2013-07-31', 1);
INSERT INTO dbsituacao_caixa_funcionario (seq, unidseq, usuaseq, titulo, datacad, statseq) VALUES (2, 1, 1, 'Aguardando Liberação', '2013-07-31', 1);


--
-- TOC entry 4216 (class 0 OID 0)
-- Dependencies: 284
-- Name: dbsituacao_caixa_funcionario_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbsituacao_caixa_funcionario_seq_seq', 3, true);


--
-- TOC entry 3981 (class 0 OID 17149)
-- Dependencies: 287 4034
-- Data for Name: dbsituacao_movimento; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO dbsituacao_movimento (seq, unidseq, usuaseq, titulo, datacad, statseq) VALUES (1, 1, 1, 'Aberto', '2013-08-06', 1);
INSERT INTO dbsituacao_movimento (seq, unidseq, usuaseq, titulo, datacad, statseq) VALUES (2, 1, 1, 'Conferido', '2013-08-06', 1);
INSERT INTO dbsituacao_movimento (seq, unidseq, usuaseq, titulo, datacad, statseq) VALUES (3, 1, 1, 'Programado', '2013-08-06', 1);
INSERT INTO dbsituacao_movimento (seq, unidseq, usuaseq, titulo, datacad, statseq) VALUES (4, 1, 1, 'Extornado', '2013-08-06', 1);
INSERT INTO dbsituacao_movimento (seq, unidseq, usuaseq, titulo, datacad, statseq) VALUES (5, 1, 1, 'Consolidado', '2013-08-06', 1);


--
-- TOC entry 4217 (class 0 OID 0)
-- Dependencies: 286
-- Name: dbsituacao_movimento_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbsituacao_movimento_seq_seq', 6, true);


--
-- TOC entry 3983 (class 0 OID 17156)
-- Dependencies: 289 4034
-- Data for Name: dbsituacao_parcela; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO dbsituacao_parcela (seq, unidseq, usuaseq, titulo, datacad, statseq) VALUES (1, 1, 1, 'conta em aberto', '2013-07-31', 1);
INSERT INTO dbsituacao_parcela (seq, unidseq, usuaseq, titulo, datacad, statseq) VALUES (2, 1, 1, 'conta paga', '2013-07-31', 1);
INSERT INTO dbsituacao_parcela (seq, unidseq, usuaseq, titulo, datacad, statseq) VALUES (3, 1, 1, 'conta parcialmente paga', '2013-07-31', 1);
INSERT INTO dbsituacao_parcela (seq, unidseq, usuaseq, titulo, datacad, statseq) VALUES (4, 1, 1, 'conta extornada', '2013-07-31', 1);
INSERT INTO dbsituacao_parcela (seq, unidseq, usuaseq, titulo, datacad, statseq) VALUES (5, 1, 1, 'conta programada', '2013-07-31', 1);
INSERT INTO dbsituacao_parcela (seq, unidseq, usuaseq, titulo, datacad, statseq) VALUES (6, 1, 1, 'conta negociada', '2013-07-31', 1);
INSERT INTO dbsituacao_parcela (seq, unidseq, usuaseq, titulo, datacad, statseq) VALUES (7, 1, 1, 'conta anulada', '2013-07-31', 1);
INSERT INTO dbsituacao_parcela (seq, unidseq, usuaseq, titulo, datacad, statseq) VALUES (8, 1, 1, 'Conta Suspensa', '2013-07-31', 1);


--
-- TOC entry 4218 (class 0 OID 0)
-- Dependencies: 288
-- Name: dbsituacao_parcela_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbsituacao_parcela_seq_seq', 9, true);


--
-- TOC entry 3985 (class 0 OID 17163)
-- Dependencies: 291 4034
-- Data for Name: dbsituacao_turma; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO dbsituacao_turma (seq, unidseq, usuaseq, titulo, datacad, statseq) VALUES (1, 1, 1, 'Aberta', '2013-07-31', 1);
INSERT INTO dbsituacao_turma (seq, unidseq, usuaseq, titulo, datacad, statseq) VALUES (2, 1, 1, 'Adiada', '2013-07-31', 1);
INSERT INTO dbsituacao_turma (seq, unidseq, usuaseq, titulo, datacad, statseq) VALUES (3, 1, 1, 'Cancelada', '2013-07-31', 1);
INSERT INTO dbsituacao_turma (seq, unidseq, usuaseq, titulo, datacad, statseq) VALUES (4, 1, 1, 'Concluida', '2013-07-31', 1);
INSERT INTO dbsituacao_turma (seq, unidseq, usuaseq, titulo, datacad, statseq) VALUES (5, 1, 1, 'Em Andamento', '2013-07-31', 1);


--
-- TOC entry 4219 (class 0 OID 0)
-- Dependencies: 290
-- Name: dbsituacao_turma_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbsituacao_turma_seq_seq', 6, true);


--
-- TOC entry 3987 (class 0 OID 17172)
-- Dependencies: 293 4034
-- Data for Name: dbstatus; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO dbstatus (seq, unidseq, usuaseq, statdesc, datacad, statseq) VALUES (1, NULL, NULL, 'Ativo', '2013-07-30', 1);
INSERT INTO dbstatus (seq, unidseq, usuaseq, statdesc, datacad, statseq) VALUES (2, NULL, NULL, 'Inativo', '2013-07-30', 1);
INSERT INTO dbstatus (seq, unidseq, usuaseq, statdesc, datacad, statseq) VALUES (8, NULL, NULL, 'Rascunho', '2013-07-30', 1);
INSERT INTO dbstatus (seq, unidseq, usuaseq, statdesc, datacad, statseq) VALUES (9, NULL, NULL, 'Inválido', '2013-07-30', 1);
INSERT INTO dbstatus (seq, unidseq, usuaseq, statdesc, datacad, statseq) VALUES (4, NULL, NULL, 'Rascunho', '2013-11-25', 1);


--
-- TOC entry 4220 (class 0 OID 0)
-- Dependencies: 292
-- Name: dbstatus_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbstatus_seq_seq', 10, true);


--
-- TOC entry 3989 (class 0 OID 17180)
-- Dependencies: 295 4034
-- Data for Name: dbtelefone; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4221 (class 0 OID 0)
-- Dependencies: 294
-- Name: dbtelefone_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbtelefone_seq_seq', 9340, true);


--
-- TOC entry 3991 (class 0 OID 17190)
-- Dependencies: 297 4034
-- Data for Name: dbtipo_convenio; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO dbtipo_convenio (seq, unidseq, usuaseq, titulo, datacad, statseq) VALUES (1, 1, 1, 'Desconto', '2013-07-31', 1);
INSERT INTO dbtipo_convenio (seq, unidseq, usuaseq, titulo, datacad, statseq) VALUES (2, 1, 1, 'Bolsa', '2013-07-31', 1);
INSERT INTO dbtipo_convenio (seq, unidseq, usuaseq, titulo, datacad, statseq) VALUES (3, 1, 1, 'Parceria', '2013-07-31', 1);


--
-- TOC entry 4222 (class 0 OID 0)
-- Dependencies: 296
-- Name: dbtipo_convenio_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbtipo_convenio_seq_seq', 4, true);


--
-- TOC entry 3993 (class 0 OID 17197)
-- Dependencies: 299 4034
-- Data for Name: dbtipo_curso; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO dbtipo_curso (seq, unidseq, usuaseq, titulo, obs, datacad, statseq) VALUES (1, 1, 1, 'Regular', '', '2009-08-28', 1);
INSERT INTO dbtipo_curso (seq, unidseq, usuaseq, titulo, obs, datacad, statseq) VALUES (2, 1, 1, 'Qualificação', '', '2009-08-28', 1);
INSERT INTO dbtipo_curso (seq, unidseq, usuaseq, titulo, obs, datacad, statseq) VALUES (3, 1, 1, 'Aperfeiçoamento', '', '2009-08-28', 1);
INSERT INTO dbtipo_curso (seq, unidseq, usuaseq, titulo, obs, datacad, statseq) VALUES (4, 1, 1, 'Técnico', '', '2009-08-28', 1);
INSERT INTO dbtipo_curso (seq, unidseq, usuaseq, titulo, obs, datacad, statseq) VALUES (5, 1, 1, 'Complementação Técnica', '', '2009-08-28', 1);
INSERT INTO dbtipo_curso (seq, unidseq, usuaseq, titulo, obs, datacad, statseq) VALUES (6, 1, 1, 'Especialização Técnica', '', '2009-08-28', 1);
INSERT INTO dbtipo_curso (seq, unidseq, usuaseq, titulo, obs, datacad, statseq) VALUES (8, 1, 1, 'Graduação Tecnológica', '', '2009-08-28', 1);
INSERT INTO dbtipo_curso (seq, unidseq, usuaseq, titulo, obs, datacad, statseq) VALUES (9, 1, 1, 'Graduação Licenciatura', '', '2009-08-28', 1);
INSERT INTO dbtipo_curso (seq, unidseq, usuaseq, titulo, obs, datacad, statseq) VALUES (10, 1, 1, 'Graduação Bacharelado', '', '2009-08-28', 1);
INSERT INTO dbtipo_curso (seq, unidseq, usuaseq, titulo, obs, datacad, statseq) VALUES (11, 1, 1, 'Pós Graduação Especialização/MBA', '', '2009-08-28', 1);
INSERT INTO dbtipo_curso (seq, unidseq, usuaseq, titulo, obs, datacad, statseq) VALUES (12, 1, 1, 'Pós Graduação Mestrado', '', '2009-08-28', 1);
INSERT INTO dbtipo_curso (seq, unidseq, usuaseq, titulo, obs, datacad, statseq) VALUES (13, 1, 1, 'Pós Graduação Doutorado', '', '2009-08-28', 1);
INSERT INTO dbtipo_curso (seq, unidseq, usuaseq, titulo, obs, datacad, statseq) VALUES (7, 1, 1, 'Sequencial', NULL, '2009-08-28', 1);
INSERT INTO dbtipo_curso (seq, unidseq, usuaseq, titulo, obs, datacad, statseq) VALUES (14, 1, 1, 'Vestibular', NULL, '2012-01-14', 1);


--
-- TOC entry 4223 (class 0 OID 0)
-- Dependencies: 298
-- Name: dbtipo_curso_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbtipo_curso_seq_seq', 18, true);


--
-- TOC entry 3995 (class 0 OID 17209)
-- Dependencies: 301 4034
-- Data for Name: dbtipo_estorno; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4224 (class 0 OID 0)
-- Dependencies: 300
-- Name: dbtipo_estorno_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbtipo_estorno_seq_seq', 1, false);


--
-- TOC entry 3996 (class 0 OID 17214)
-- Dependencies: 302 4034
-- Data for Name: dbtipo_produto; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO dbtipo_produto (seq, unidseq, usuaseq, titulo, datacad, statseq) VALUES (1, 1, 1, 'Insumo', '2010-08-12', 1);
INSERT INTO dbtipo_produto (seq, unidseq, usuaseq, titulo, datacad, statseq) VALUES (7, 1, 1, 'Negociação', '2010-08-12', 1);
INSERT INTO dbtipo_produto (seq, unidseq, usuaseq, titulo, datacad, statseq) VALUES (6, 1, 1, 'Contrato', '2010-08-12', 1);
INSERT INTO dbtipo_produto (seq, unidseq, usuaseq, titulo, datacad, statseq) VALUES (5, 1, 1, 'Patrimonio', '2010-08-12', 1);
INSERT INTO dbtipo_produto (seq, unidseq, usuaseq, titulo, datacad, statseq) VALUES (4, 1, 1, 'Revenda', '2010-08-12', 1);
INSERT INTO dbtipo_produto (seq, unidseq, usuaseq, titulo, datacad, statseq) VALUES (3, 1, 1, 'Serviço', '2010-08-12', 1);
INSERT INTO dbtipo_produto (seq, unidseq, usuaseq, titulo, datacad, statseq) VALUES (2, 1, 1, 'Consumo', '2010-08-12', 1);


--
-- TOC entry 3997 (class 0 OID 17218)
-- Dependencies: 303 4034
-- Data for Name: dbtipo_telefone; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO dbtipo_telefone (seq, unidseq, usuaseq, tptedesc, prioridade, datacad, statseq) VALUES (1, 1, 1, 'Telefone Principal', 2, '2013-08-21', 1);
INSERT INTO dbtipo_telefone (seq, unidseq, usuaseq, tptedesc, prioridade, datacad, statseq) VALUES (2, 1, 1, 'Telefone Secundário', 3, '2013-08-21', 1);
INSERT INTO dbtipo_telefone (seq, unidseq, usuaseq, tptedesc, prioridade, datacad, statseq) VALUES (3, 1, 1, 'Celular Principal', 1, '2013-08-21', 1);
INSERT INTO dbtipo_telefone (seq, unidseq, usuaseq, tptedesc, prioridade, datacad, statseq) VALUES (4, 1, 1, 'Celular Secundário', 4, '2013-08-21', 1);


--
-- TOC entry 3999 (class 0 OID 17227)
-- Dependencies: 305 4034
-- Data for Name: dbtitularidade; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO dbtitularidade (seq, unidseq, usuaseq, titulo, nomeacao, descricao, peso, datacad, statseq) VALUES (9, 1, 1, 'Pós-Doutorado', 'Pós-Doutor', NULL, 9, '2010-03-31', 1);
INSERT INTO dbtitularidade (seq, unidseq, usuaseq, titulo, nomeacao, descricao, peso, datacad, statseq) VALUES (8, 1, 1, 'Doutorado', 'Doutor', NULL, 8, '2010-03-31', 1);
INSERT INTO dbtitularidade (seq, unidseq, usuaseq, titulo, nomeacao, descricao, peso, datacad, statseq) VALUES (7, 1, 1, 'Mestrado', 'Mestre', NULL, 7, '2010-03-31', 1);
INSERT INTO dbtitularidade (seq, unidseq, usuaseq, titulo, nomeacao, descricao, peso, datacad, statseq) VALUES (6, 1, 1, 'Especialização', 'Especialista', NULL, 6, '2010-03-31', 1);
INSERT INTO dbtitularidade (seq, unidseq, usuaseq, titulo, nomeacao, descricao, peso, datacad, statseq) VALUES (5, 1, 1, 'Graduação', 'Graduado', NULL, 5, '2010-03-31', 1);
INSERT INTO dbtitularidade (seq, unidseq, usuaseq, titulo, nomeacao, descricao, peso, datacad, statseq) VALUES (1, 1, 1, 'Ensino Fundamental', 'Alfabetizado', NULL, 1, '2010-03-31', 1);
INSERT INTO dbtitularidade (seq, unidseq, usuaseq, titulo, nomeacao, descricao, peso, datacad, statseq) VALUES (4, 1, 1, 'Ensino 2º Grau', 'Alfabetizado', NULL, 4, '2010-03-31', 1);
INSERT INTO dbtitularidade (seq, unidseq, usuaseq, titulo, nomeacao, descricao, peso, datacad, statseq) VALUES (3, 1, 1, 'Ensino Segunda Fase (1º Grau)', 'Alfabetizado', NULL, 3, '2010-03-31', 1);
INSERT INTO dbtitularidade (seq, unidseq, usuaseq, titulo, nomeacao, descricao, peso, datacad, statseq) VALUES (2, 1, 1, 'Ensino Primeira Fase (1º Grau)', 'Alfabetizado', NULL, 2, '2010-03-31', 1);


--
-- TOC entry 4225 (class 0 OID 0)
-- Dependencies: 304
-- Name: dbtitularidade_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbtitularidade_seq_seq', 10, true);


--
-- TOC entry 4001 (class 0 OID 17239)
-- Dependencies: 307 4034
-- Data for Name: dbtransacao; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4003 (class 0 OID 17259)
-- Dependencies: 309 4034
-- Data for Name: dbtransacao_aluno; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4226 (class 0 OID 0)
-- Dependencies: 308
-- Name: dbtransacao_aluno_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbtransacao_aluno_seq_seq', 1, false);


--
-- TOC entry 4005 (class 0 OID 17268)
-- Dependencies: 311 4034
-- Data for Name: dbtransacao_convenio; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4227 (class 0 OID 0)
-- Dependencies: 310
-- Name: dbtransacao_convenio_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbtransacao_convenio_seq_seq', 1499, true);


--
-- TOC entry 4007 (class 0 OID 17277)
-- Dependencies: 313 4034
-- Data for Name: dbtransacao_produto; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4228 (class 0 OID 0)
-- Dependencies: 312
-- Name: dbtransacao_produto_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbtransacao_produto_seq_seq', 3722, true);


--
-- TOC entry 4229 (class 0 OID 0)
-- Dependencies: 306
-- Name: dbtransacao_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbtransacao_seq_seq', 3668, true);


--
-- TOC entry 4009 (class 0 OID 17291)
-- Dependencies: 315 4034
-- Data for Name: dbtreinamento; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4230 (class 0 OID 0)
-- Dependencies: 314
-- Name: dbtreinamento_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbtreinamento_seq_seq', 1, false);


--
-- TOC entry 4011 (class 0 OID 17303)
-- Dependencies: 317 4034
-- Data for Name: dbturma; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4013 (class 0 OID 17336)
-- Dependencies: 319 4034
-- Data for Name: dbturma_convenio; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4231 (class 0 OID 0)
-- Dependencies: 318
-- Name: dbturma_convenio_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbturma_convenio_seq_seq', 93, true);


--
-- TOC entry 4015 (class 0 OID 17345)
-- Dependencies: 321 4034
-- Data for Name: dbturma_disciplina; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4017 (class 0 OID 17364)
-- Dependencies: 323 4034
-- Data for Name: dbturma_disciplina_arquivo; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4232 (class 0 OID 0)
-- Dependencies: 322
-- Name: dbturma_disciplina_arquivo_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbturma_disciplina_arquivo_seq_seq', 1, false);


--
-- TOC entry 4019 (class 0 OID 17377)
-- Dependencies: 325 4034
-- Data for Name: dbturma_disciplina_aula; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4233 (class 0 OID 0)
-- Dependencies: 324
-- Name: dbturma_disciplina_aula_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbturma_disciplina_aula_seq_seq', 982, true);


--
-- TOC entry 4021 (class 0 OID 17391)
-- Dependencies: 327 4034
-- Data for Name: dbturma_disciplina_avaliacao; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4234 (class 0 OID 0)
-- Dependencies: 326
-- Name: dbturma_disciplina_avaliacao_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbturma_disciplina_avaliacao_seq_seq', 1, false);


--
-- TOC entry 4023 (class 0 OID 17403)
-- Dependencies: 329 4034
-- Data for Name: dbturma_disciplina_material; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4235 (class 0 OID 0)
-- Dependencies: 328
-- Name: dbturma_disciplina_material_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbturma_disciplina_material_seq_seq', 1, false);


--
-- TOC entry 4025 (class 0 OID 17416)
-- Dependencies: 331 4034
-- Data for Name: dbturma_disciplina_planoaula; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4236 (class 0 OID 0)
-- Dependencies: 330
-- Name: dbturma_disciplina_planoaula_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbturma_disciplina_planoaula_seq_seq', 1, false);


--
-- TOC entry 4237 (class 0 OID 0)
-- Dependencies: 320
-- Name: dbturma_disciplina_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbturma_disciplina_seq_seq', 2643, true);


--
-- TOC entry 4238 (class 0 OID 0)
-- Dependencies: 316
-- Name: dbturma_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbturma_seq_seq', 221, true);


--
-- TOC entry 4027 (class 0 OID 17429)
-- Dependencies: 333 4034
-- Data for Name: dbunidade; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO dbunidade (seq, unidseq, usuaseq, nomeunidade, razaosocial, cnpj, inscestadual, inscmunicipal, gerente, diretor, representante, logradouro, bairro, cidade, estado, cep, email, telefone, datacad, statseq) VALUES (1, 1, NULL, 'GAP-Anápolis', 'Grupo de Administração Profissional Ltda PE', '07.945.909/0001-61', '0', '55350', 'Polyanna Rezende Milhomem Marinho', '', '', 'Praça Manoel Demóstenes, n.78', 'Jundíai', 'Anápolis', 'GO', '75.113-590', '0', '(62)3943-2143', '2009-12-30', 1);


--
-- TOC entry 4029 (class 0 OID 17440)
-- Dependencies: 335 4034
-- Data for Name: dbunidade_parametro; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO dbunidade_parametro (seq, unidseq, usuaseq, parametro, valor, obs, datacad, statseq) VALUES (12, 1, 1, 'biblioteca_planocontas', '10011249-549', 'Codigo do plano de contas da biblioteca', '2010-04-23', 1);
INSERT INTO dbunidade_parametro (seq, unidseq, usuaseq, parametro, valor, obs, datacad, statseq) VALUES (6, 1, 1, 'biblioteca_valormultaatraso_aluno', '1.5', 'Valor em reais (R$) por dia de atraso na devolução do livro pelo Aluno', '2010-04-21', 1);
INSERT INTO dbunidade_parametro (seq, unidseq, usuaseq, parametro, valor, obs, datacad, statseq) VALUES (11, 1, 1, 'biblioteca_vencimentomulta', '30', 'Número de dias para pagamento da multa', '2010-04-23', 1);
INSERT INTO dbunidade_parametro (seq, unidseq, usuaseq, parametro, valor, obs, datacad, statseq) VALUES (7, 1, 1, 'biblioteca_valormultaatraso_professor', '1.5', 'Valor em reais (R$) por dia de atraso na devolução do livro pelo Professor', '2010-04-21', 1);
INSERT INTO dbunidade_parametro (seq, unidseq, usuaseq, parametro, valor, obs, datacad, statseq) VALUES (1, 1, 1, 'academico_medianotas', '6', 'Valor minimo para aprovação por notas', '2010-04-14', 1);
INSERT INTO dbunidade_parametro (seq, unidseq, usuaseq, parametro, valor, obs, datacad, statseq) VALUES (3, 1, 1, 'academico_mediapresenca', '75', 'Valor em porcentagem minimo para aprovação por presença', '2010-04-14', 1);
INSERT INTO dbunidade_parametro (seq, unidseq, usuaseq, parametro, valor, obs, datacad, statseq) VALUES (10, 1, 1, 'biblioteca_autorizalocacaosaldodevedor', '1', 'Valor booleano para permitir a locação de livros mesmo com saldo devedor', '2010-04-22', 1);
INSERT INTO dbunidade_parametro (seq, unidseq, usuaseq, parametro, valor, obs, datacad, statseq) VALUES (8, 1, 1, 'biblioteca_limitelocacao_aluno', '2', 'Número máximo de livros que um aluno pode locar', '2010-04-21', 1);
INSERT INTO dbunidade_parametro (seq, unidseq, usuaseq, parametro, valor, obs, datacad, statseq) VALUES (9, 1, 1, 'biblioteca_limitelocacao_professor', '3', 'Número máximo de livros que um professor pode locar', '2010-04-21', 1);
INSERT INTO dbunidade_parametro (seq, unidseq, usuaseq, parametro, valor, obs, datacad, statseq) VALUES (13, 1, 1, 'padrao_boleto', '../../sysboleto/boleto_petrus.php', NULL, '2010-08-24', 1);
INSERT INTO dbunidade_parametro (seq, unidseq, usuaseq, parametro, valor, obs, datacad, statseq) VALUES (14, 1, 1, 'enviarEmail', '0', NULL, '2010-12-08', 1);
INSERT INTO dbunidade_parametro (seq, unidseq, usuaseq, parametro, valor, obs, datacad, statseq) VALUES (15, 1, 1, 'matricula_independente', '1', 'Configura se a transação de Isncrição gera o boleto da Matricula ou se é apenas gerada quando efetivar a matricula', '2011-01-28', 1);
INSERT INTO dbunidade_parametro (seq, unidseq, usuaseq, parametro, valor, obs, datacad, statseq) VALUES (17, 1, 1, 'listapresenca_datascampos', '1', 'configura a quantidade de campos por data na lista de presença', '2011-01-31', 1);
INSERT INTO dbunidade_parametro (seq, unidseq, usuaseq, parametro, valor, obs, datacad, statseq) VALUES (16, 1, 1, 'listapresenca_datas', '4', NULL, '2011-01-28', 1);
INSERT INTO dbunidade_parametro (seq, unidseq, usuaseq, parametro, valor, obs, datacad, statseq) VALUES (18, 1, 1, 'senhainicial', 'gapbrasil', NULL, '2011-04-14', 1);
INSERT INTO dbunidade_parametro (seq, unidseq, usuaseq, parametro, valor, obs, datacad, statseq) VALUES (5, 1, 1, 'biblioteca_prazodevolucaolivro_professor', '15', 'Prazo em dias para a devolução do livro pelo Professor', '2010-04-21', 1);
INSERT INTO dbunidade_parametro (seq, unidseq, usuaseq, parametro, valor, obs, datacad, statseq) VALUES (4, 1, 1, 'biblioteca_prazodevolucaolivro_aluno', '15', 'Prazo em dias para a devolução do livro pelo Aluno', '2010-04-21', 1);
INSERT INTO dbunidade_parametro (seq, unidseq, usuaseq, parametro, valor, obs, datacad, statseq) VALUES (37, 1, 1, 'financeiro_intervalo_parcela', '30', 'Número padrão de dias para o intervalo entre parcelas', '2013-09-24', 1);


--
-- TOC entry 4239 (class 0 OID 0)
-- Dependencies: 334
-- Name: dbunidade_parametro_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbunidade_parametro_seq_seq', 39, true);


--
-- TOC entry 4240 (class 0 OID 0)
-- Dependencies: 332
-- Name: dbunidade_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbunidade_seq_seq', 3, true);


--
-- TOC entry 4031 (class 0 OID 17452)
-- Dependencies: 337 4034
-- Data for Name: dbusuario; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO dbusuario (seq, unidseq, usuaseq, classeuser, pessseq, usuario, senha, entidadepai, temaseq, datacad, lastip, lastaccess, lastpass, statseq) VALUES (1, 1, NULL, NULL, 1, 'admin', NULL, '1', 17, '2013-07-30', NULL, NULL, NULL, 1);
INSERT INTO dbusuario (seq, unidseq, usuaseq, classeuser, pessseq, usuario, senha, entidadepai, temaseq, datacad, lastip, lastaccess, lastpass, statseq) VALUES (3, 1, NULL, NULL, 1, 'admin.educacional', '839961a972a465e9b41bc00ff78ab557', '1', 17, '2009-12-30', '189.59.28.191', '1374607868', NULL, 1);


--
-- TOC entry 4033 (class 0 OID 17463)
-- Dependencies: 339 4034
-- Data for Name: dbusuario_privilegio; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10502, 1, 3, 0, 9, 0, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10527, 1, 3, 13, 109, 1, '2010-04-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10528, 1, 3, 10, 108, 1, '2009-02-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10529, 1, 3, 5, 45, 1, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10530, 1, 3, 9, 20, 1, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10531, 1, 3, 3, 81, 1, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10532, 1, 3, 31, 2, 2, '2010-05-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10533, 1, 3, 31, 3, 2, '2010-05-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10534, 1, 3, 1, 2, 2, '2010-05-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10535, 1, 3, 151, 1, 2, '2010-05-25', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10536, 1, 3, 72, 3, 2, '2010-05-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10537, 1, 3, 72, 2, 2, '2010-05-25', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10538, 1, 3, 75, 2, 2, '2010-05-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10539, 1, 3, 72, 1, 2, '2010-05-25', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10540, 1, 3, 13, 105, 1, '2010-05-25', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10541, 1, 3, 2, 104, 1, '2010-05-25', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10542, 1, 3, 151, 2, 2, '2010-05-25', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10543, 1, 3, 151, 3, 2, '2010-05-25', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10544, 1, 3, 2, 422, 7, '2010-06-04', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10545, 1, 3, 75, 3, 2, '2010-05-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10546, 1, 3, 38, 1, 2, '2010-05-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10547, 1, 3, 1, 1, 2, '2010-05-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10548, 1, 3, 8, 1, 2, '2010-05-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10549, 1, 3, 8, 3, 2, '2010-05-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10550, 1, 3, 14, 2, 2, '2010-05-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10551, 1, 3, 38, 2, 2, '2010-05-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10552, 1, 3, 38, 3, 2, '2010-05-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10553, 1, 3, 10, 1, 2, '2010-05-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10554, 1, 3, 10, 2, 2, '2010-05-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10555, 1, 3, 78, 2, 2, '2010-05-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10556, 1, 3, 20, 1, 2, '2010-05-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10557, 1, 3, 20, 2, 2, '2010-05-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10558, 1, 3, 20, 3, 2, '2010-05-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10559, 1, 3, 9, 1, 2, '2010-05-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10560, 1, 3, 9, 3, 2, '2010-05-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10561, 1, 3, 9, 2, 2, '2010-05-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10562, 1, 3, 10, 3, 2, '2010-05-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10563, 1, 3, 13, 1, 2, '2010-05-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10564, 1, 3, 13, 3, 2, '2010-05-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10565, 1, 3, 64, 1, 2, '2010-05-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10566, 1, 3, 332, 1, 2, '2010-05-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10567, 1, 3, 332, 2, 2, '2010-05-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10568, 1, 3, 332, 3, 2, '2010-05-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10569, 1, 3, 21, 1, 2, '2010-05-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10570, 1, 3, 75, 1, 2, '2010-05-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10571, 1, 3, 21, 2, 2, '2010-05-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10572, 1, 3, 21, 3, 2, '2010-05-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10573, 1, 3, 24, 1, 2, '2010-05-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10574, 1, 3, 24, 2, 2, '2010-05-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10575, 1, 3, 26, 1, 2, '2010-05-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10576, 1, 3, 26, 2, 2, '2010-05-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10577, 1, 3, 31, 1, 2, '2010-05-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10578, 1, 3, 27, 3, 2, '2010-05-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10579, 1, 3, 27, 2, 2, '2010-05-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10580, 1, 3, 27, 1, 2, '2010-05-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10581, 1, 3, 26, 3, 2, '2010-05-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10582, 1, 3, 34, 1, 2, '2010-05-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10583, 1, 3, 34, 2, 2, '2010-05-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10584, 1, 3, 34, 3, 2, '2010-05-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10585, 1, 3, 40, 1, 2, '2010-05-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10586, 1, 3, 40, 3, 2, '2010-05-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10587, 1, 3, 89, 1, 2, '2010-05-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10588, 1, 3, 40, 2, 2, '2010-05-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10589, 1, 3, 77, 1, 2, '2010-05-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10590, 1, 3, 77, 2, 2, '2010-05-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10591, 1, 3, 77, 3, 2, '2010-05-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10593, 1, 3, 30, 1, 2, '2010-05-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10594, 1, 3, 30, 2, 2, '2010-05-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10595, 1, 3, 30, 3, 2, '2010-05-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10596, 1, 3, 320, 1, 2, '2010-05-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10597, 1, 3, 320, 2, 2, '2010-05-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10598, 1, 3, 320, 3, 2, '2010-05-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10599, 1, 3, 6, 1, 2, '2010-05-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10600, 1, 3, 6, 2, 2, '2010-05-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10601, 1, 3, 6, 3, 2, '2010-05-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10602, 1, 3, 7, 1, 2, '2010-05-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10603, 1, 3, 7, 2, 2, '2010-05-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10604, 1, 3, 89, 2, 2, '2010-05-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10605, 1, 3, 89, 3, 2, '2010-05-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10606, 1, 3, 17, 3, 2, '2010-05-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10607, 1, 3, 17, 2, 2, '2010-05-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10608, 1, 3, 376, 317, 5, '2010-06-04', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10609, 1, 3, 64, 2, 2, '2010-05-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10610, 1, 3, 64, 3, 2, '2010-05-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10611, 1, 3, 12, 2, 2, '2010-05-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10612, 1, 3, 12, 3, 2, '2010-05-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10613, 1, 3, 4, 2, 2, '2010-05-27', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10614, 1, 3, 4, 1, 2, '2010-05-27', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10615, 1, 3, 4, 3, 2, '2010-05-27', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10616, 1, 3, 90, 1, 2, '2010-05-27', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10617, 1, 3, 90, 2, 2, '2010-05-27', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10618, 1, 3, 5, 1, 2, '2010-05-27', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10619, 1, 3, 5, 2, 2, '2010-05-27', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10620, 1, 3, 5, 3, 2, '2010-05-27', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10621, 1, 3, 1, 1, 1, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10622, 1, 3, 1, 2, 1, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10623, 1, 3, 3, 1, 2, '2010-05-27', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10624, 1, 3, 3, 2, 2, '2010-05-27', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10625, 1, 3, 3, 3, 2, '2010-05-27', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10626, 1, 3, 39, 1, 2, '2010-05-27', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10627, 1, 3, 39, 2, 2, '2010-05-27', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10628, 1, 3, 39, 3, 2, '2010-05-27', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10629, 1, 3, 422, 422, 8, '2010-06-04', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10630, 1, 3, 333, 3, 2, '2010-06-02', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10631, 1, 3, 311, 661, 1, '2010-06-02', 2);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10632, 1, 3, 1, 3, 6, '2010-06-04', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10633, 1, 3, 130, 3, 3, '2010-06-04', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10634, 1, 3, 130, 4, 3, '2010-06-04', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10635, 1, 3, 130, 5, 3, '2010-06-04', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10636, 1, 3, 130, 336, 3, '2010-06-04', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10637, 1, 3, 130, 337, 3, '2010-06-04', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10638, 1, 3, 130, 338, 3, '2010-06-04', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10639, 1, 3, 130, 339, 3, '2010-06-04', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10640, 1, 3, 130, 345, 3, '2010-06-04', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10641, 1, 3, 79, 247, 5, '2010-06-04', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10642, 1, 3, 130, 2, 3, '2010-06-04', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10643, 1, 3, 1, 3, 2, '2010-05-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10644, 1, 3, 130, 1, 3, '2010-06-04', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10645, 1, 3, 1, 1, 5, '2010-06-04', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10646, 1, 3, 1, 2, 5, '2010-06-04', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10647, 1, 3, 1, 3, 5, '2010-06-04', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10648, 1, 3, 1, 77, 5, '2010-06-04', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10649, 1, 3, 1, 267, 5, '2010-06-04', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10650, 1, 3, 267, 200, 6, '2010-06-04', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10651, 1, 3, 1, 1, 6, '2010-06-04', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10652, 1, 3, 77, 96, 6, '2010-06-04', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10653, 1, 3, 6, 45, 5, '2010-06-04', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10654, 1, 3, 1, 2, 6, '2010-06-04', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10655, 1, 3, 45, 59, 6, '2010-06-04', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10656, 1, 3, 6, 54, 5, '2010-06-04', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10657, 1, 3, 2, 12, 6, '2010-06-04', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10658, 1, 3, 3, 87, 6, '2010-06-04', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10659, 1, 3, 8, 24, 5, '2010-06-04', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10660, 1, 3, 24, 32, 6, '2010-06-04', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10661, 1, 3, 54, 70, 6, '2010-06-04', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10662, 1, 3, 24, 33, 6, '2010-06-04', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10663, 1, 3, 33, 633, 7, '2010-06-04', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10664, 1, 3, 349, 290, 5, '2010-06-04', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10665, 1, 3, 290, 224, 6, '2010-06-04', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10666, 1, 3, 3, 89, 6, '2010-06-04', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10667, 1, 3, 341, 282, 5, '2010-06-04', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10668, 1, 3, 282, 216, 6, '2010-06-04', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10669, 1, 3, 224, 482, 7, '2010-06-04', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10670, 1, 3, 224, 486, 7, '2010-06-04', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10671, 1, 3, 224, 485, 7, '2010-06-04', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10672, 1, 3, 224, 483, 7, '2010-06-04', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10673, 1, 3, 1, 421, 7, '2010-06-04', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10674, 1, 3, 421, 421, 8, '2010-06-04', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10675, 1, 3, 1, 323, 7, '2010-06-04', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10676, 1, 3, 323, 323, 8, '2010-06-04', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10677, 1, 3, 67, 221, 5, '2010-06-04', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10678, 1, 3, 67, 223, 5, '2010-06-04', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10679, 1, 3, 223, 144, 6, '2010-06-04', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10680, 1, 3, 371, 312, 5, '2010-06-04', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10681, 1, 3, 221, 143, 6, '2010-06-04', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10682, 1, 3, 372, 313, 5, '2010-06-04', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10683, 1, 3, 313, 247, 6, '2010-06-04', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10684, 1, 3, 72, 222, 5, '2010-06-04', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10685, 1, 3, 222, 150, 6, '2010-06-04', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10686, 1, 3, 222, 151, 6, '2010-06-04', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10687, 1, 3, 17, 1, 2, '2010-05-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10688, 1, 3, 317, 251, 6, '2010-06-04', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10689, 1, 3, 72, 226, 5, '2010-06-04', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10690, 1, 3, 376, 1, 2, '2010-06-04', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10691, 1, 3, 376, 3, 2, '2010-06-04', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10692, 1, 3, 226, 171, 6, '2010-06-07', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10693, 1, 3, 226, 152, 6, '2010-06-07', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10694, 1, 3, 365, 2, 2, '2010-06-07', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10695, 1, 3, 365, 306, 5, '2010-06-07', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10696, 1, 3, 215, 425, 3, '2010-06-07', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10697, 1, 3, 215, 424, 3, '2010-06-07', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10698, 1, 3, 215, 422, 3, '2010-06-07', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10699, 1, 3, 306, 240, 6, '2010-06-07', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10700, 1, 3, 5, 55, 5, '2010-06-16', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10701, 1, 3, 55, 201, 6, '2010-06-16', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10702, 1, 3, 374, 1, 2, '2010-06-16', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10703, 1, 3, 374, 2, 2, '2010-06-16', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10704, 1, 3, 374, 3, 2, '2010-06-16', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10705, 1, 3, 3, 11, 5, '2010-06-21', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10706, 1, 3, 11, 14, 6, '2010-06-21', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10707, 1, 3, 5, 21, 5, '2010-06-21', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10708, 1, 3, 21, 26, 6, '2010-06-21', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10709, 1, 3, 335, 1, 2, '2010-06-21', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10710, 1, 3, 335, 3, 2, '2010-06-21', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10711, 1, 3, 335, 276, 5, '2010-06-21', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10712, 1, 3, 276, 210, 6, '2010-06-21', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10713, 1, 3, 3, 117, 1, '2010-06-22', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10714, 1, 3, 381, 727, 3, '2010-06-22', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10715, 1, 3, 381, 728, 3, '2010-06-22', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10716, 1, 3, 381, 733, 3, '2010-06-22', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10717, 1, 3, 381, 732, 3, '2010-06-22', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10718, 1, 3, 381, 731, 3, '2010-06-22', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10719, 1, 3, 381, 730, 3, '2010-06-22', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10720, 1, 3, 381, 729, 3, '2010-06-22', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10721, 1, 3, 83, 1, 2, '2010-06-23', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10722, 1, 3, 83, 2, 2, '2010-06-23', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10723, 1, 3, 83, 239, 5, '2010-06-23', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10724, 1, 3, 239, 184, 6, '2010-06-23', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10725, 1, 3, 3, 118, 1, '2010-06-25', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10726, 1, 3, 383, 322, 5, '2010-06-25', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10727, 1, 3, 322, 256, 6, '2010-06-25', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10728, 1, 3, 389, 2, 2, '2010-06-25', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10729, 1, 3, 389, 3, 2, '2010-06-25', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10730, 1, 3, 383, 323, 5, '2010-06-25', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10731, 1, 3, 323, 257, 6, '2010-06-25', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10732, 1, 3, 390, 2, 2, '2010-06-25', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10733, 1, 3, 390, 3, 2, '2010-06-25', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10734, 1, 3, 83, 3, 2, '2010-06-28', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10735, 1, 3, 83, 4, 2, '2010-06-28', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10736, 1, 3, 270, 3, 2, '2010-06-29', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10737, 1, 3, 270, 2, 2, '2010-06-29', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10738, 1, 3, 270, 1, 2, '2010-06-29', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10739, 1, 3, 266, 1, 2, '2010-06-29', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10740, 1, 3, 266, 261, 5, '2010-06-29', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10741, 1, 3, 261, 191, 6, '2010-06-29', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10742, 1, 3, 264, 1, 2, '2010-06-29', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10743, 1, 3, 264, 260, 5, '2010-06-29', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10744, 1, 3, 260, 190, 6, '2010-06-29', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10745, 1, 3, 260, 198, 6, '2010-06-29', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10746, 1, 3, 260, 193, 6, '2010-06-29', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10747, 1, 3, 4, 19, 5, '2010-06-30', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10748, 1, 3, 354, 1, 2, '2010-06-30', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10749, 1, 3, 354, 3, 2, '2010-06-30', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10750, 1, 3, 295, 229, 6, '2010-06-30', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10751, 1, 3, 229, 71, 7, '2010-06-30', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10752, 1, 3, 71, 71, 8, '2010-06-30', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10753, 1, 3, 221, 141, 6, '2010-07-07', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10754, 1, 3, 207, 379, 3, '2010-07-07', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10755, 1, 3, 207, 380, 3, '2010-07-07', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10756, 1, 3, 207, 509, 3, '2010-07-07', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10757, 1, 3, 67, 2, 2, '2010-05-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10758, 1, 3, 295, 258, 6, '2010-07-14', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10759, 1, 3, 19, 23, 6, '2010-06-30', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10760, 1, 3, 395, 5, 2, '2010-07-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10761, 1, 3, 354, 295, 5, '2010-06-30', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10762, 1, 3, 393, 5, 2, '2010-07-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10763, 1, 3, 5, 34, 5, '2010-07-27', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10764, 1, 3, 34, 46, 6, '2010-07-27', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10765, 1, 3, 355, 1, 2, '2010-07-27', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10766, 1, 3, 355, 2, 2, '2010-07-27', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10767, 1, 3, 355, 3, 2, '2010-07-27', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10768, 1, 3, 355, 296, 5, '2010-07-27', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10769, 1, 3, 296, 230, 6, '2010-07-27', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10770, 1, 3, 4, 18, 5, '2010-07-28', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10771, 1, 3, 397, 2, 2, '2010-07-28', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10772, 1, 3, 397, 324, 5, '2010-07-28', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10773, 1, 3, 324, 260, 6, '2010-07-28', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10774, 1, 3, 60, 1, 2, '2010-07-28', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10775, 1, 3, 60, 2, 2, '2010-07-28', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10776, 1, 3, 60, 3, 2, '2010-07-28', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10777, 1, 3, 399, 2, 2, '2010-07-28', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10778, 1, 3, 399, 268, 5, '2010-07-28', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10779, 1, 3, 268, 202, 6, '2010-07-28', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10780, 1, 3, 375, 1, 2, '2010-07-28', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10781, 1, 3, 375, 2, 2, '2010-07-28', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10782, 1, 3, 375, 3, 2, '2010-07-28', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10783, 1, 3, 375, 316, 5, '2010-07-28', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10784, 1, 3, 316, 250, 6, '2010-07-28', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10785, 1, 3, 10, 115, 1, '2010-05-17', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10786, 1, 3, 10, 92, 1, '2010-07-28', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10787, 1, 3, 3, 41, 1, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (16379, 1, 3, 471, 372, 5, '2011-09-27', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11201, 1, 3, 377, 318, 5, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10592, 1, 3, 0, 4, 0, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (18227, 1, 3, 475, 2, 2, '2012-02-21', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10920, 1, 3, 0, 12, 0, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10412, 1, 3, 371, 2, 2, '2010-06-04', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10413, 1, 3, 352, 5, 2, '2010-08-05', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10414, 1, 3, 29, 2, 2, '2010-08-05', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10415, 1, 3, 59, 2, 2, '2010-08-05', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10416, 1, 3, 367, 308, 5, '2010-08-05', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10417, 1, 3, 369, 310, 5, '2010-08-05', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10418, 1, 3, 370, 2, 2, '2010-08-05', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10419, 1, 3, 312, 246, 6, '2010-08-05', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10420, 1, 3, 29, 64, 5, '2010-08-05', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10421, 1, 3, 352, 293, 5, '2010-08-05', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10422, 1, 3, 59, 39, 5, '2010-08-05', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10423, 1, 3, 308, 242, 6, '2010-08-05', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10424, 1, 3, 310, 244, 6, '2010-08-05', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10425, 1, 3, 370, 3, 2, '2010-08-05', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10426, 1, 3, 236, 398, 3, '2010-08-05', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10427, 1, 3, 64, 141, 6, '2010-08-05', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10428, 1, 3, 293, 227, 6, '2010-08-05', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10429, 1, 3, 39, 54, 6, '2010-08-05', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10430, 1, 3, 18, 265, 5, '2010-08-05', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10431, 1, 3, 18, 263, 5, '2010-08-05', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10432, 1, 3, 18, 264, 5, '2010-08-05', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10433, 1, 3, 236, 543, 3, '2010-08-05', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10434, 1, 3, 64, 144, 6, '2010-08-05', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10435, 1, 3, 367, 1, 2, '2010-08-05', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10436, 1, 3, 265, 197, 6, '2010-08-05', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10437, 1, 3, 263, 195, 6, '2010-08-05', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10438, 1, 3, 0, 8, 0, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10439, 1, 3, 0, 11, 0, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10440, 1, 3, 4, 53, 1, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10441, 1, 3, 4, 54, 1, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10442, 1, 3, 4, 52, 1, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10443, 1, 3, 5, 51, 1, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10444, 1, 3, 4, 50, 1, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10445, 1, 3, 5, 49, 1, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10446, 1, 3, 5, 48, 1, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10447, 1, 3, 3, 47, 1, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10448, 1, 3, 2, 105, 1, '2009-01-14', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10449, 1, 3, 1, 46, 1, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10450, 1, 3, 3, 43, 1, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10451, 1, 3, 5, 44, 1, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10452, 1, 3, 13, 4, 1, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10453, 1, 3, 3, 39, 1, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10455, 1, 3, 3, 32, 1, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10456, 1, 3, 2, 7, 1, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10457, 1, 3, 4, 61, 1, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10458, 1, 3, 1, 58, 1, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10459, 1, 3, 4, 60, 1, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10460, 1, 3, 5, 57, 1, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10461, 1, 3, 2, 10, 1, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10462, 1, 3, 13, 6, 1, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10463, 1, 3, 2, 13, 1, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10464, 1, 3, 0, 2, 0, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10465, 1, 3, 3, 31, 1, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10466, 1, 3, 10, 26, 1, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10467, 1, 3, 3, 29, 1, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10468, 1, 3, 10, 24, 1, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10469, 1, 3, 3, 33, 1, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10470, 1, 3, 3, 34, 1, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10471, 1, 3, 10, 25, 1, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10472, 1, 3, 7, 17, 1, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10473, 1, 3, 4, 56, 1, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10474, 1, 3, 3, 103, 1, '2009-11-13', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10475, 1, 3, 2, 95, 1, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10476, 1, 3, 3, 30, 1, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10477, 1, 3, 1, 96, 1, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10478, 1, 3, 7, 16, 1, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10479, 1, 3, 2, 89, 1, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10480, 1, 3, 5, 90, 1, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10481, 1, 3, 13, 5, 1, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10482, 1, 3, 13, 102, 1, '2009-11-06', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10483, 1, 3, 7, 14, 1, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10484, 1, 3, 2, 63, 1, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10485, 1, 3, 12, 101, 1, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10486, 1, 3, 2, 65, 1, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10487, 1, 3, 2, 100, 1, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10488, 1, 3, 3, 88, 1, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10489, 1, 3, 10, 27, 1, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10490, 1, 3, 3, 87, 1, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10491, 1, 3, 5, 99, 1, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10492, 1, 3, 4, 98, 1, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10493, 1, 3, 4, 94, 1, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10494, 1, 3, 4, 97, 1, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10496, 1, 3, 5, 83, 1, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10497, 1, 3, 11, 84, 1, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10498, 1, 3, 4, 82, 1, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10499, 1, 3, 2, 66, 1, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10500, 1, 3, 0, 6, 0, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10501, 1, 3, 0, 7, 0, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10503, 1, 3, 4, 93, 1, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10504, 1, 3, 3, 77, 1, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10505, 1, 3, 13, 75, 1, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10506, 1, 3, 13, 74, 1, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10507, 1, 3, 3, 80, 1, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10508, 1, 3, 3, 78, 1, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10509, 1, 3, 3, 40, 1, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10510, 1, 3, 3, 79, 1, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10512, 1, 3, 4, 55, 1, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10513, 1, 3, 4, 8, 1, '2010-05-07', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10514, 1, 3, 8, 107, 1, '2009-02-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10515, 1, 3, 8, 106, 1, '2009-02-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10516, 1, 3, 13, 3, 1, '2010-04-27', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10517, 1, 3, 12, 115, 1, '2010-04-22', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10518, 1, 3, 12, 114, 1, '2010-04-21', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10519, 1, 3, 3, 91, 1, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10520, 1, 3, 12, 113, 1, '2010-04-21', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10521, 1, 3, 0, 10, 0, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10522, 1, 3, 10, 86, 1, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10523, 1, 3, 12, 112, 1, '2010-04-21', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10524, 1, 3, 12, 111, 1, '2010-04-21', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10525, 1, 3, 12, 110, 1, '2010-04-20', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10526, 1, 3, 3, 116, 1, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10788, 1, 3, 64, 173, 6, '2010-08-05', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10789, 1, 3, 367, 2, 2, '2010-08-05', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10790, 1, 3, 369, 2, 2, '2010-08-05', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10791, 1, 3, 370, 1, 2, '2010-08-05', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10792, 1, 3, 67, 1, 2, '2010-08-13', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10793, 1, 3, 372, 1, 2, '2010-08-13', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10794, 1, 3, 15, 233, 5, '2010-08-19', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10795, 1, 3, 233, 259, 6, '2010-08-19', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10796, 1, 3, 233, 161, 6, '2010-08-19', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10797, 1, 3, 360, 2, 2, '2010-08-19', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10798, 1, 3, 342, 1, 2, '2010-08-24', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10799, 1, 3, 342, 3, 2, '2010-08-24', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10800, 1, 3, 342, 2, 2, '2010-08-24', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10801, 1, 3, 0, 5, 0, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10802, 1, 3, 19, 1, 2, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10803, 1, 3, 19, 2, 2, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10804, 1, 3, 19, 3, 2, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10805, 1, 3, 7, 246, 5, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10806, 1, 3, 7, 23, 5, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10807, 1, 3, 23, 30, 6, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10808, 1, 3, 30, 101, 7, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10809, 1, 3, 101, 101, 8, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10810, 1, 3, 30, 103, 7, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10811, 1, 3, 103, 103, 8, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10812, 1, 3, 23, 165, 6, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10813, 1, 3, 351, 1, 2, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10814, 1, 3, 351, 3, 2, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10815, 1, 3, 7, 3, 2, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10816, 1, 3, 59, 692, 7, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10817, 1, 3, 692, 692, 8, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10818, 1, 3, 59, 407, 7, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10819, 1, 3, 407, 407, 8, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10820, 1, 3, 59, 242, 7, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10821, 1, 3, 242, 242, 8, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10822, 1, 3, 59, 243, 7, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10823, 1, 3, 243, 243, 8, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10824, 1, 3, 59, 625, 7, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10825, 1, 3, 625, 625, 8, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10826, 1, 3, 59, 244, 7, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10827, 1, 3, 6, 46, 5, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10828, 1, 3, 46, 60, 6, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10829, 1, 3, 60, 251, 7, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10830, 1, 3, 251, 251, 8, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10831, 1, 3, 60, 252, 7, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10832, 1, 3, 6, 53, 5, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10833, 1, 3, 53, 99, 6, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10834, 1, 3, 53, 69, 6, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10835, 1, 3, 349, 1, 2, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10836, 1, 3, 349, 2, 2, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10837, 1, 3, 349, 3, 2, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10838, 1, 3, 54, 100, 6, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10839, 1, 3, 361, 302, 5, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10840, 1, 3, 302, 236, 6, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10841, 1, 3, 351, 292, 5, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10842, 1, 3, 292, 226, 6, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10843, 1, 3, 23, 164, 6, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10844, 1, 3, 350, 291, 5, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10845, 1, 3, 291, 225, 6, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10846, 1, 3, 246, 31, 6, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10847, 1, 3, 31, 102, 7, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10848, 1, 3, 102, 102, 8, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10849, 1, 3, 19, 42, 5, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10850, 1, 3, 42, 56, 6, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10851, 1, 3, 19, 48, 5, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10852, 1, 3, 48, 62, 6, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10853, 1, 3, 19, 49, 5, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10854, 1, 3, 49, 63, 6, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10855, 1, 3, 20, 43, 5, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10856, 1, 3, 43, 57, 6, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10857, 1, 3, 43, 58, 6, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10858, 1, 3, 20, 44, 5, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10859, 1, 3, 44, 112, 6, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10860, 1, 3, 20, 200, 5, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10861, 1, 3, 200, 113, 6, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10862, 1, 3, 20, 201, 5, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10863, 1, 3, 201, 114, 6, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10864, 1, 3, 20, 202, 5, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10865, 1, 3, 202, 115, 6, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10866, 1, 3, 22, 1, 2, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10867, 1, 3, 22, 2, 2, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10868, 1, 3, 22, 3, 2, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10869, 1, 3, 22, 50, 5, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10870, 1, 3, 50, 64, 6, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10871, 1, 3, 50, 65, 6, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10872, 1, 3, 338, 1, 2, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10873, 1, 3, 338, 2, 2, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10874, 1, 3, 338, 3, 2, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10875, 1, 3, 338, 279, 5, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10876, 1, 3, 279, 213, 6, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10877, 1, 3, 33, 1, 2, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10878, 1, 3, 33, 2, 2, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10879, 1, 3, 33, 3, 2, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10880, 1, 3, 33, 68, 5, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10881, 1, 3, 68, 84, 6, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10882, 1, 3, 68, 85, 6, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10883, 1, 3, 68, 86, 6, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10884, 1, 3, 71, 1, 2, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10885, 1, 3, 71, 2, 2, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10886, 1, 3, 71, 3, 2, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10887, 1, 3, 71, 1, 5, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10888, 1, 3, 71, 2, 5, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10889, 1, 3, 71, 3, 5, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10890, 1, 3, 341, 1, 2, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10891, 1, 3, 341, 2, 2, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10892, 1, 3, 341, 3, 2, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10893, 1, 3, 71, 4, 5, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10894, 1, 3, 4, 130, 6, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10895, 1, 3, 4, 13, 6, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10896, 1, 3, 334, 1, 2, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10897, 1, 3, 334, 2, 2, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10898, 1, 3, 334, 3, 2, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10899, 1, 3, 334, 275, 5, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10900, 1, 3, 275, 209, 6, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10901, 1, 3, 71, 225, 5, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10902, 1, 3, 225, 146, 6, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10903, 1, 3, 58, 255, 5, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10904, 1, 3, 255, 183, 6, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10905, 1, 3, 366, 2, 2, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10906, 1, 3, 366, 307, 5, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10907, 1, 3, 307, 241, 6, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10908, 1, 3, 58, 40, 5, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10909, 1, 3, 40, 116, 6, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10910, 1, 3, 364, 1, 2, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10911, 1, 3, 364, 2, 2, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10912, 1, 3, 364, 3, 2, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10913, 1, 3, 364, 305, 5, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10914, 1, 3, 305, 239, 6, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10915, 1, 3, 58, 41, 5, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10916, 1, 3, 41, 117, 6, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10917, 1, 3, 348, 289, 5, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10918, 1, 3, 289, 223, 6, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10919, 1, 3, 367, 3, 2, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10921, 1, 3, 267, 262, 5, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10922, 1, 3, 262, 192, 6, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10923, 1, 3, 270, 259, 5, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10924, 1, 3, 259, 189, 6, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10925, 1, 3, 239, 167, 6, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10926, 1, 3, 239, 185, 6, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10927, 1, 3, 239, 186, 6, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10928, 1, 3, 83, 257, 5, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10929, 1, 3, 257, 187, 6, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10930, 1, 3, 83, 258, 5, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10931, 1, 3, 258, 188, 6, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10932, 1, 3, 83, 240, 5, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10933, 1, 3, 240, 168, 6, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10934, 1, 3, 5, 20, 5, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10935, 1, 3, 20, 177, 6, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10936, 1, 3, 20, 25, 6, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10937, 1, 3, 55, 157, 6, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10938, 1, 3, 374, 315, 5, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10939, 1, 3, 315, 249, 6, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10940, 1, 3, 87, 18, 5, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10941, 1, 3, 87, 249, 5, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10942, 1, 3, 249, 179, 6, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10943, 1, 3, 353, 294, 5, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10944, 1, 3, 294, 228, 6, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10945, 1, 3, 87, 34, 5, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10946, 1, 3, 87, 88, 5, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10947, 1, 3, 88, 98, 6, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10948, 1, 3, 343, 1, 2, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10949, 1, 3, 343, 2, 2, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10950, 1, 3, 343, 3, 2, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10951, 1, 3, 343, 284, 5, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10952, 1, 3, 284, 218, 6, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10953, 1, 3, 39, 71, 5, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10954, 1, 3, 71, 91, 6, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10955, 1, 3, 90, 253, 5, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10956, 1, 3, 71, 166, 6, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10957, 1, 3, 337, 1, 2, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10958, 1, 3, 337, 3, 2, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10959, 1, 3, 337, 278, 5, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10960, 1, 3, 278, 212, 6, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10961, 1, 3, 11, 15, 6, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10962, 1, 3, 3, 13, 5, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10963, 1, 3, 13, 19, 6, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10964, 1, 3, 3, 14, 5, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10965, 1, 3, 14, 16, 6, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10966, 1, 3, 3, 15, 5, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10967, 1, 3, 15, 17, 6, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10968, 1, 3, 3, 16, 5, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10969, 1, 3, 16, 18, 6, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10970, 1, 3, 18, 22, 6, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10971, 1, 3, 85, 1, 2, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10972, 1, 3, 85, 2, 2, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10973, 1, 3, 85, 3, 2, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10974, 1, 3, 85, 245, 5, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10975, 1, 3, 245, 174, 6, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10976, 1, 3, 253, 182, 6, '2010-08-26', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10977, 1, 3, 2, 119, 1, '2010-09-06', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10978, 1, 3, 7, 120, 1, '2010-09-06', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10979, 1, 3, 9, 121, 1, '2010-09-06', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10982, 1, 3, 3, 122, 1, '2010-09-16', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10983, 1, 3, 3, 336, 5, '2010-09-16', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10984, 1, 3, 336, 264, 6, '2010-09-16', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10985, 1, 3, 413, 1, 2, '2010-09-16', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10986, 1, 3, 413, 2, 2, '2010-09-16', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10987, 1, 3, 413, 3, 2, '2010-09-16', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10988, 1, 3, 1, 341, 5, '2010-09-23', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10989, 1, 3, 1, 123, 1, '2010-09-23', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10990, 1, 3, 426, 1, 2, '2010-09-23', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10991, 1, 3, 426, 2, 2, '2010-09-23', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10992, 1, 3, 426, 3, 2, '2010-09-23', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10994, 1, 3, 440, 354, 5, '2010-10-05', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10995, 1, 3, 354, 273, 6, '2010-10-05', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10996, 1, 3, 444, 2, 2, '2010-10-05', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10997, 1, 3, 47, 87, 5, '2010-09-29', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10998, 1, 3, 428, 343, 5, '2010-09-29', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10999, 1, 3, 343, 269, 6, '2010-09-29', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11000, 1, 3, 429, 1, 2, '2010-09-29', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11001, 1, 3, 429, 2, 2, '2010-09-29', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11002, 1, 3, 429, 3, 2, '2010-09-29', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11003, 1, 3, 434, 348, 5, '2010-10-05', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11004, 1, 3, 348, 272, 6, '2010-10-05', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11005, 1, 3, 428, 2, 2, '2010-10-05', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11006, 1, 3, 429, 344, 5, '2010-10-05', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11007, 1, 3, 344, 270, 6, '2010-10-05', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11008, 1, 3, 413, 337, 5, '2010-12-15', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11009, 1, 3, 337, 265, 6, '2010-12-15', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11010, 1, 3, 4, 359, 5, '2010-12-15', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11011, 1, 3, 359, 276, 6, '2010-12-15', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11012, 1, 3, 446, 1, 2, '2010-12-15', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11013, 1, 3, 446, 2, 2, '2010-12-15', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11014, 1, 3, 446, 3, 2, '2010-12-15', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11015, 1, 3, 446, 360, 5, '2010-12-15', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11016, 1, 3, 360, 277, 6, '2010-12-15', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11017, 1, 3, 5, 4, 2, '2011-01-07', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11018, 1, 3, 320, 361, 5, '2011-01-19', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11019, 1, 3, 361, 278, 6, '2011-01-19', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11020, 1, 3, 448, 1, 2, '2011-01-19', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11021, 1, 3, 448, 3, 2, '2011-01-19', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11022, 1, 3, 448, 2, 2, '2011-01-19', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11023, 1, 3, 320, 266, 5, '2011-01-19', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11024, 1, 3, 5, 365, 5, '2011-01-19', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11025, 1, 3, 365, 282, 6, '2011-01-19', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11026, 1, 3, 452, 1, 2, '2011-01-19', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11027, 1, 3, 452, 2, 2, '2011-01-19', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11028, 1, 3, 452, 3, 2, '2011-01-19', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11029, 1, 3, 452, 366, 5, '2011-01-19', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11030, 1, 3, 366, 283, 6, '2011-01-19', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11031, 1, 3, 67, 363, 5, '2011-01-31', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11032, 1, 3, 363, 280, 6, '2011-01-31', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11033, 1, 3, 450, 1, 2, '2011-01-31', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11034, 1, 3, 450, 3, 2, '2011-01-31', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11035, 1, 3, 2, 125, 1, '2011-02-22', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11036, 1, 3, 2, 126, 1, '2011-02-22', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11037, 1, 3, 13, 31, 5, '2011-03-11', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11038, 1, 3, 31, 42, 6, '2011-03-11', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11039, 1, 3, 31, 207, 6, '2011-03-11', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11040, 1, 3, 13, 274, 5, '2011-03-11', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11041, 1, 3, 274, 43, 6, '2011-03-11', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11042, 1, 3, 72, 321, 5, '2011-03-11', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11043, 1, 3, 321, 152, 6, '2011-03-11', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11044, 1, 3, 306, 255, 6, '2011-03-11', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11045, 1, 3, 12, 30, 5, '2011-03-11', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11046, 1, 3, 30, 40, 6, '2011-03-11', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11047, 1, 3, 11, 29, 5, '2011-03-11', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11048, 1, 3, 29, 39, 6, '2011-03-11', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11049, 1, 3, 10, 28, 5, '2011-03-11', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11050, 1, 3, 28, 38, 6, '2011-03-11', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11051, 1, 3, 17, 35, 5, '2011-03-11', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11052, 1, 3, 35, 51, 6, '2011-03-11', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11053, 1, 3, 41, 75, 5, '2011-03-11', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11054, 1, 3, 41, 76, 5, '2011-03-11', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11055, 1, 3, 67, 3, 2, '2011-03-11', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11056, 1, 3, 372, 3, 2, '2011-03-11', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11057, 1, 3, 372, 317, 5, '2011-03-11', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11058, 1, 3, 223, 261, 6, '2011-03-11', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11059, 1, 3, 312, 255, 6, '2011-03-11', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11060, 1, 3, 450, 2, 2, '2011-03-11', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11061, 1, 3, 450, 364, 5, '2011-03-11', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11062, 1, 3, 364, 281, 6, '2011-03-11', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11063, 1, 3, 389, 31, 5, '2011-03-11', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11064, 1, 3, 389, 274, 5, '2011-03-11', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11065, 1, 3, 390, 32, 5, '2011-03-11', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11066, 1, 3, 32, 44, 6, '2011-03-11', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11067, 1, 3, 32, 253, 6, '2011-03-11', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11068, 1, 3, 390, 273, 5, '2011-03-11', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11069, 1, 3, 273, 45, 6, '2011-03-11', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11070, 1, 3, 332, 272, 5, '2011-03-11', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11071, 1, 3, 272, 206, 6, '2011-03-11', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11072, 1, 3, 64, 262, 6, '2011-03-11', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11073, 1, 3, 418, 338, 5, '2011-03-11', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11074, 1, 3, 338, 266, 6, '2011-03-11', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11075, 1, 3, 418, 339, 5, '2011-03-11', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11076, 1, 3, 14, 33, 5, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11077, 1, 3, 33, 4, 6, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11078, 1, 3, 33, 194, 6, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11079, 1, 3, 14, 6, 5, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11080, 1, 3, 38, 73, 5, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11081, 1, 3, 73, 155, 6, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11082, 1, 3, 73, 93, 6, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11083, 1, 3, 78, 234, 5, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11084, 1, 3, 234, 162, 6, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11085, 1, 3, 234, 163, 6, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11086, 1, 3, 78, 340, 5, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11087, 1, 3, 405, 329, 5, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11088, 1, 3, 15, 3, 2, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11089, 1, 3, 15, 72, 5, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11090, 1, 3, 15, 328, 5, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11091, 1, 3, 459, 3, 2, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11092, 1, 3, 459, 210, 5, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11093, 1, 3, 460, 3, 2, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11094, 1, 3, 460, 335, 5, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11095, 1, 3, 405, 332, 5, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11096, 1, 3, 46, 80, 5, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11097, 1, 3, 46, 81, 5, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11098, 1, 3, 46, 82, 5, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11099, 1, 3, 82, 97, 6, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11100, 1, 3, 46, 83, 5, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11101, 1, 3, 46, 84, 5, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11102, 1, 3, 46, 85, 5, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11103, 1, 3, 46, 86, 5, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11104, 1, 3, 21, 47, 5, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11105, 1, 3, 47, 67, 6, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11106, 1, 3, 21, 70, 5, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11107, 1, 3, 24, 57, 5, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11108, 1, 3, 57, 71, 6, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11109, 1, 3, 26, 58, 5, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11110, 1, 3, 58, 77, 6, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11111, 1, 3, 58, 72, 6, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11112, 1, 3, 58, 73, 6, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11113, 1, 3, 26, 59, 5, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11114, 1, 3, 59, 74, 6, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11115, 1, 3, 26, 60, 5, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11116, 1, 3, 60, 75, 6, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11117, 1, 3, 339, 1, 2, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11118, 1, 3, 339, 2, 2, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11119, 1, 3, 339, 3, 2, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11120, 1, 3, 339, 280, 5, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11121, 1, 3, 280, 214, 6, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11122, 1, 3, 26, 61, 5, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11123, 1, 3, 31, 66, 5, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11124, 1, 3, 66, 82, 6, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11125, 1, 3, 66, 275, 6, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11126, 1, 3, 31, 67, 5, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11127, 1, 3, 67, 83, 6, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11128, 1, 3, 347, 1, 2, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11129, 1, 3, 347, 2, 2, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11130, 1, 3, 347, 3, 2, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11131, 1, 3, 347, 288, 5, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11132, 1, 3, 288, 222, 6, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11133, 1, 3, 34, 69, 5, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11134, 1, 3, 69, 90, 6, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11135, 1, 3, 40, 74, 5, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11136, 1, 3, 74, 94, 6, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11137, 1, 3, 74, 95, 6, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11138, 1, 3, 75, 228, 5, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11139, 1, 3, 228, 154, 6, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11140, 1, 3, 75, 270, 5, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11141, 1, 3, 270, 205, 6, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11142, 1, 3, 75, 271, 5, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11143, 1, 3, 271, 204, 6, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11144, 1, 3, 77, 231, 5, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11145, 1, 3, 231, 159, 6, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11146, 1, 3, 30, 65, 5, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11147, 1, 3, 65, 81, 6, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11148, 1, 3, 266, 199, 6, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11149, 1, 3, 448, 362, 5, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11150, 1, 3, 362, 279, 6, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11151, 1, 3, 4, 124, 1, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11152, 1, 3, 59, 211, 5, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11153, 1, 3, 211, 131, 6, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11154, 1, 3, 406, 330, 5, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11155, 1, 3, 406, 333, 5, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11156, 1, 3, 264, 196, 6, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11157, 1, 3, 370, 311, 5, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11158, 1, 3, 311, 245, 6, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11159, 1, 3, 368, 309, 5, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11160, 1, 3, 309, 243, 6, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11161, 1, 3, 60, 213, 5, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11162, 1, 3, 213, 132, 6, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11163, 1, 3, 213, 133, 6, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11164, 1, 3, 60, 214, 5, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11165, 1, 3, 214, 134, 6, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11166, 1, 3, 60, 215, 5, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11167, 1, 3, 215, 135, 6, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11168, 1, 3, 407, 331, 5, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11169, 1, 3, 407, 334, 5, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11170, 1, 3, 54, 95, 5, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11171, 1, 3, 50, 91, 5, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11172, 1, 3, 76, 1, 2, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11173, 1, 3, 76, 2, 2, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11174, 1, 3, 76, 3, 2, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11175, 1, 3, 76, 230, 5, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11176, 1, 3, 230, 158, 6, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11177, 1, 3, 63, 218, 5, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11178, 1, 3, 63, 269, 5, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11179, 1, 3, 328, 325, 5, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11180, 1, 3, 32, 67, 5, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11181, 1, 3, 44, 78, 5, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11182, 1, 3, 44, 79, 5, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11183, 1, 3, 49, 89, 5, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11184, 1, 3, 49, 90, 5, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11185, 1, 3, 52, 93, 5, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11186, 1, 3, 53, 94, 5, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11187, 1, 3, 61, 216, 5, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11188, 1, 3, 62, 217, 5, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11189, 1, 3, 217, 137, 6, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11190, 1, 3, 260, 254, 5, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11191, 1, 3, 261, 256, 5, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11192, 1, 3, 431, 345, 5, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11193, 1, 3, 345, 271, 6, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11194, 1, 3, 432, 346, 5, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11195, 1, 3, 346, 271, 6, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11196, 1, 3, 433, 347, 5, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11197, 1, 3, 347, 271, 6, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11198, 1, 3, 348, 271, 6, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11199, 1, 3, 362, 303, 5, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11200, 1, 3, 303, 237, 6, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11202, 1, 3, 318, 252, 6, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11203, 1, 3, 378, 319, 5, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11204, 1, 3, 319, 254, 6, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11205, 1, 3, 435, 349, 5, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11206, 1, 3, 349, 271, 6, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11207, 1, 3, 436, 350, 5, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11208, 1, 3, 350, 271, 6, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11209, 1, 3, 437, 351, 5, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11210, 1, 3, 351, 271, 6, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11211, 1, 3, 438, 352, 5, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11212, 1, 3, 352, 271, 6, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11213, 1, 3, 439, 353, 5, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11214, 1, 3, 353, 271, 6, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11215, 1, 3, 354, 271, 6, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11216, 1, 3, 444, 358, 5, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11217, 1, 3, 358, 274, 6, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11218, 1, 3, 441, 355, 5, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11219, 1, 3, 355, 271, 6, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11220, 1, 3, 442, 356, 5, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11221, 1, 3, 356, 271, 6, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11222, 1, 3, 454, 367, 5, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11223, 1, 3, 367, 284, 6, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11224, 1, 3, 367, 285, 6, '2011-04-01', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11225, 1, 3, 7, 127, 1, '2011-04-07', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11226, 1, 3, 463, 1, 2, '2011-04-07', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11227, 1, 3, 463, 2, 2, '2011-04-07', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11228, 1, 3, 463, 3, 2, '2011-04-07', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11229, 1, 3, 463, 368, 5, '2011-04-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11230, 1, 3, 368, 286, 6, '2011-04-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11232, 1, 3, 464, 1, 2, '2011-04-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11233, 1, 3, 464, 2, 2, '2011-04-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11234, 1, 3, 464, 3, 2, '2011-04-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11235, 1, 3, 464, 369, 5, '2011-04-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11236, 1, 3, 2, 128, 1, '2011-04-11', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10981, 1, 3, 0, 3, 0, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (19991, 1, 3, 3, 129, 1, '2012-06-24', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (19992, 1, 3, 478, 377, 5, '2012-06-24', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (19993, 1, 3, 478, 2, 2, '2012-06-24', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (19994, 1, 3, 377, 296, 6, '2012-06-24', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (19995, 1, 3, 480, 5, 2, '2012-06-24', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (19910, 1, 3, 474, 375, 5, '2012-05-11', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10980, 1, 3, 0, 13, 0, '2009-11-06', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (16377, 1, 3, 18, 370, 5, '2011-09-27', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10495, 1, 3, 9, 85, 1, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10993, 1, 3, 0, 0, 0, '2010-09-28', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (16378, 1, 3, 351, 293, 6, '2011-09-27', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (16380, 1, 3, 372, 271, 6, '2011-09-27', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (16381, 1, 3, 472, 373, 5, '2011-09-27', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (16382, 1, 3, 373, 271, 6, '2011-09-27', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (16383, 1, 3, 473, 374, 5, '2011-09-27', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10454, 1, 3, 9, 19, 1, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (11231, 1, 3, 368, 287, 6, '2011-04-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (16384, 1, 3, 374, 271, 6, '2011-09-27', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (16385, 1, 3, 374, 294, 6, '2011-09-27', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (16386, 1, 3, 345, 292, 6, '2011-09-27', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (10511, 1, 3, 0, 1, 0, '2010-03-08', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (22584, 1, 3, 13, 130, 1, '2013-02-10', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (22585, 1, 3, 483, 379, 5, '2013-02-10', 1);
INSERT INTO dbusuario_privilegio (seq, unidseq, usuaseq, funcionalidade, modulo, nivel, datacad, statseq) VALUES (23783, 1, 3, 31, 4, 2, '2013-02-23', 1);


--
-- TOC entry 4241 (class 0 OID 0)
-- Dependencies: 338
-- Name: dbusuario_privilegio_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbusuario_privilegio_seq_seq', 36685, true);


--
-- TOC entry 4242 (class 0 OID 0)
-- Dependencies: 336
-- Name: dbusuario_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dbusuario_seq_seq', 1199, true);


--
-- TOC entry 3138 (class 2606 OID 29908)
-- Dependencies: 162 162 4035
-- Name: pk_aluno_nota_frequencia; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY aluno_nota_frequencia
    ADD CONSTRAINT pk_aluno_nota_frequencia PRIMARY KEY (seq);


--
-- TOC entry 3140 (class 2606 OID 29910)
-- Dependencies: 164 164 4035
-- Name: pk_dbaluno; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbaluno
    ADD CONSTRAINT pk_dbaluno PRIMARY KEY (seq);


--
-- TOC entry 3142 (class 2606 OID 29912)
-- Dependencies: 166 166 4035
-- Name: pk_dbaluno_disciplina; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbaluno_disciplina
    ADD CONSTRAINT pk_dbaluno_disciplina PRIMARY KEY (seq);


--
-- TOC entry 3144 (class 2606 OID 29914)
-- Dependencies: 168 168 4035
-- Name: pk_dbaluno_requisito; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbaluno_requisito
    ADD CONSTRAINT pk_dbaluno_requisito PRIMARY KEY (seq);


--
-- TOC entry 3146 (class 2606 OID 29916)
-- Dependencies: 170 170 4035
-- Name: pk_dbaluno_solicitacao; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbaluno_solicitacao
    ADD CONSTRAINT pk_dbaluno_solicitacao PRIMARY KEY (seq);


--
-- TOC entry 3148 (class 2606 OID 29918)
-- Dependencies: 172 172 4035
-- Name: pk_dbaproveitamento_disciplina; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbaproveitamento_disciplina
    ADD CONSTRAINT pk_dbaproveitamento_disciplina PRIMARY KEY (seq);


--
-- TOC entry 3150 (class 2606 OID 29920)
-- Dependencies: 174 174 4035
-- Name: pk_dbarea_curso; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbarea_curso
    ADD CONSTRAINT pk_dbarea_curso PRIMARY KEY (seq);


--
-- TOC entry 3152 (class 2606 OID 29922)
-- Dependencies: 176 176 4035
-- Name: pk_dbavaliacao; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbavaliacao
    ADD CONSTRAINT pk_dbavaliacao PRIMARY KEY (seq);


--
-- TOC entry 3154 (class 2606 OID 29924)
-- Dependencies: 178 178 4035
-- Name: pk_dbbalanco_patrimonial; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbbalanco_patrimonial
    ADD CONSTRAINT pk_dbbalanco_patrimonial PRIMARY KEY (seq);


--
-- TOC entry 3157 (class 2606 OID 29926)
-- Dependencies: 180 180 4035
-- Name: pk_dbboleto; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbboleto
    ADD CONSTRAINT pk_dbboleto PRIMARY KEY (seq);


--
-- TOC entry 3159 (class 2606 OID 29928)
-- Dependencies: 182 182 4035
-- Name: pk_dbboleto_estrutura; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbboleto_estrutura
    ADD CONSTRAINT pk_dbboleto_estrutura PRIMARY KEY (seq);


--
-- TOC entry 3162 (class 2606 OID 29930)
-- Dependencies: 184 184 4035
-- Name: pk_dbcaixa; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcaixa
    ADD CONSTRAINT pk_dbcaixa PRIMARY KEY (seq);


--
-- TOC entry 3164 (class 2606 OID 29932)
-- Dependencies: 186 186 4035
-- Name: pk_dbcaixa_funcionario; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcaixa_funcionario
    ADD CONSTRAINT pk_dbcaixa_funcionario PRIMARY KEY (seq);


--
-- TOC entry 3166 (class 2606 OID 29934)
-- Dependencies: 188 188 4035
-- Name: pk_dbcargo; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcargo
    ADD CONSTRAINT pk_dbcargo PRIMARY KEY (seq);


--
-- TOC entry 3168 (class 2606 OID 29936)
-- Dependencies: 190 190 4035
-- Name: pk_dbcdu; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcdu
    ADD CONSTRAINT pk_dbcdu PRIMARY KEY (seq);


--
-- TOC entry 3172 (class 2606 OID 29938)
-- Dependencies: 192 192 4035
-- Name: pk_dbcheque; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcheque
    ADD CONSTRAINT pk_dbcheque PRIMARY KEY (seq);


--
-- TOC entry 3174 (class 2606 OID 29940)
-- Dependencies: 194 194 4035
-- Name: pk_dbconta_financeira; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbconta_financeira
    ADD CONSTRAINT pk_dbconta_financeira PRIMARY KEY (seq);


--
-- TOC entry 3177 (class 2606 OID 29942)
-- Dependencies: 196 196 4035
-- Name: pk_dbconvenio; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbconvenio
    ADD CONSTRAINT pk_dbconvenio PRIMARY KEY (seq);


--
-- TOC entry 3179 (class 2606 OID 29944)
-- Dependencies: 198 198 4035
-- Name: pk_dbconvenio_desconto; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbconvenio_desconto
    ADD CONSTRAINT pk_dbconvenio_desconto PRIMARY KEY (seq);


--
-- TOC entry 3181 (class 2606 OID 29946)
-- Dependencies: 200 200 4035
-- Name: pk_dbcotacao; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcotacao
    ADD CONSTRAINT pk_dbcotacao PRIMARY KEY (seq);


--
-- TOC entry 3183 (class 2606 OID 29948)
-- Dependencies: 202 202 4035
-- Name: pk_dbcurriculo; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcurriculo
    ADD CONSTRAINT pk_dbcurriculo PRIMARY KEY (seq);


--
-- TOC entry 3185 (class 2606 OID 29950)
-- Dependencies: 204 204 4035
-- Name: pk_dbcurso; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcurso
    ADD CONSTRAINT pk_dbcurso PRIMARY KEY (seq);


--
-- TOC entry 3187 (class 2606 OID 29952)
-- Dependencies: 206 206 4035
-- Name: pk_dbdemanda; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbdemanda
    ADD CONSTRAINT pk_dbdemanda PRIMARY KEY (seq);


--
-- TOC entry 3189 (class 2606 OID 29954)
-- Dependencies: 208 208 4035
-- Name: pk_dbdepartamento; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbdepartamento
    ADD CONSTRAINT pk_dbdepartamento PRIMARY KEY (seq);


--
-- TOC entry 3191 (class 2606 OID 29956)
-- Dependencies: 210 210 4035
-- Name: pk_dbdisciplina; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbdisciplina
    ADD CONSTRAINT pk_dbdisciplina PRIMARY KEY (seq);


--
-- TOC entry 3193 (class 2606 OID 29958)
-- Dependencies: 212 212 4035
-- Name: pk_dbdisciplina_similar; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbdisciplina_similar
    ADD CONSTRAINT pk_dbdisciplina_similar PRIMARY KEY (seq);


--
-- TOC entry 3195 (class 2606 OID 29960)
-- Dependencies: 214 214 4035
-- Name: pk_dbdocumentos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbdocumentos
    ADD CONSTRAINT pk_dbdocumentos PRIMARY KEY (seq);


--
-- TOC entry 3198 (class 2606 OID 29962)
-- Dependencies: 216 216 4035
-- Name: pk_dbemail; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbemail
    ADD CONSTRAINT pk_dbemail PRIMARY KEY (seq);


--
-- TOC entry 3201 (class 2606 OID 29964)
-- Dependencies: 218 218 4035
-- Name: pk_dbendereco; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbendereco
    ADD CONSTRAINT pk_dbendereco PRIMARY KEY (seq);


--
-- TOC entry 3203 (class 2606 OID 29966)
-- Dependencies: 220 220 4035
-- Name: pk_dbfalta; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfalta
    ADD CONSTRAINT pk_dbfalta PRIMARY KEY (seq);


--
-- TOC entry 3205 (class 2606 OID 29968)
-- Dependencies: 222 222 4035
-- Name: pk_dbfechamento_caixa; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfechamento_caixa
    ADD CONSTRAINT pk_dbfechamento_caixa PRIMARY KEY (seq);


--
-- TOC entry 3207 (class 2606 OID 29970)
-- Dependencies: 223 223 4035
-- Name: pk_dbfechamento_conta_financei; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfechamento_conta_financeira
    ADD CONSTRAINT pk_dbfechamento_conta_financei PRIMARY KEY (seq);


--
-- TOC entry 3210 (class 2606 OID 29972)
-- Dependencies: 225 225 4035
-- Name: pk_dbforma_pagamento; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbforma_pagamento
    ADD CONSTRAINT pk_dbforma_pagamento PRIMARY KEY (seq);


--
-- TOC entry 3212 (class 2606 OID 29974)
-- Dependencies: 227 227 4035
-- Name: pk_dbfuncionario; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfuncionario
    ADD CONSTRAINT pk_dbfuncionario PRIMARY KEY (seq);


--
-- TOC entry 3214 (class 2606 OID 29976)
-- Dependencies: 229 229 4035
-- Name: pk_dbfuncionario_ocorrencia; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfuncionario_ocorrencia
    ADD CONSTRAINT pk_dbfuncionario_ocorrencia PRIMARY KEY (seq);


--
-- TOC entry 3216 (class 2606 OID 29978)
-- Dependencies: 231 231 4035
-- Name: pk_dbfuncionario_treinamento; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfuncionario_treinamento
    ADD CONSTRAINT pk_dbfuncionario_treinamento PRIMARY KEY (seq);


--
-- TOC entry 3218 (class 2606 OID 29980)
-- Dependencies: 233 233 4035
-- Name: pk_dbgrade_avaliacao; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbgrade_avaliacao
    ADD CONSTRAINT pk_dbgrade_avaliacao PRIMARY KEY (seq);


--
-- TOC entry 3220 (class 2606 OID 29982)
-- Dependencies: 235 235 4035
-- Name: pk_dbinscricao; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbinscricao
    ADD CONSTRAINT pk_dbinscricao PRIMARY KEY (seq);


--
-- TOC entry 3222 (class 2606 OID 29984)
-- Dependencies: 237 237 4035
-- Name: pk_dblivro; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dblivro
    ADD CONSTRAINT pk_dblivro PRIMARY KEY (seq);


--
-- TOC entry 3224 (class 2606 OID 29986)
-- Dependencies: 239 239 4035
-- Name: pk_dblocacao_livro; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dblocacao_livro
    ADD CONSTRAINT pk_dblocacao_livro PRIMARY KEY (seq);


--
-- TOC entry 3226 (class 2606 OID 29988)
-- Dependencies: 241 241 4035
-- Name: pk_dbnota; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbnota
    ADD CONSTRAINT pk_dbnota PRIMARY KEY (seq);


--
-- TOC entry 3228 (class 2606 OID 29990)
-- Dependencies: 245 245 4035
-- Name: pk_dbparcela; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbparcela
    ADD CONSTRAINT pk_dbparcela PRIMARY KEY (seq);


--
-- TOC entry 3230 (class 2606 OID 29992)
-- Dependencies: 247 247 4035
-- Name: pk_dbparcela_estorno; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbparcela_estorno
    ADD CONSTRAINT pk_dbparcela_estorno PRIMARY KEY (seq);


--
-- TOC entry 3232 (class 2606 OID 29994)
-- Dependencies: 249 249 4035
-- Name: pk_dbpatrimonio; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpatrimonio
    ADD CONSTRAINT pk_dbpatrimonio PRIMARY KEY (seq);


--
-- TOC entry 3234 (class 2606 OID 29996)
-- Dependencies: 251 251 4035
-- Name: pk_dbpessoa; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoa
    ADD CONSTRAINT pk_dbpessoa PRIMARY KEY (seq);


--
-- TOC entry 3237 (class 2606 OID 29998)
-- Dependencies: 253 253 4035
-- Name: pk_dbpessoa_fisica; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoa_fisica
    ADD CONSTRAINT pk_dbpessoa_fisica PRIMARY KEY (seq);


--
-- TOC entry 3239 (class 2606 OID 30000)
-- Dependencies: 255 255 4035
-- Name: pk_dbpessoa_juridica; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoa_juridica
    ADD CONSTRAINT pk_dbpessoa_juridica PRIMARY KEY (seq);


--
-- TOC entry 3241 (class 2606 OID 30002)
-- Dependencies: 257 257 4035
-- Name: pk_dbpessoa_titularidade; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoa_titularidade
    ADD CONSTRAINT pk_dbpessoa_titularidade PRIMARY KEY (seq);


--
-- TOC entry 3243 (class 2606 OID 30004)
-- Dependencies: 259 259 4035
-- Name: pk_dbpha; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpha
    ADD CONSTRAINT pk_dbpha PRIMARY KEY (seq);


--
-- TOC entry 3245 (class 2606 OID 30006)
-- Dependencies: 261 261 4035
-- Name: pk_dbplano_conta; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbplano_conta
    ADD CONSTRAINT pk_dbplano_conta PRIMARY KEY (seq);


--
-- TOC entry 3247 (class 2606 OID 30008)
-- Dependencies: 263 263 4035
-- Name: pk_dbprocesso_academico; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprocesso_academico
    ADD CONSTRAINT pk_dbprocesso_academico PRIMARY KEY (seq);


--
-- TOC entry 3249 (class 2606 OID 30010)
-- Dependencies: 265 265 4035
-- Name: pk_dbproduto; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbproduto
    ADD CONSTRAINT pk_dbproduto PRIMARY KEY (seq);


--
-- TOC entry 3251 (class 2606 OID 30012)
-- Dependencies: 267 267 4035
-- Name: pk_dbprofessor; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprofessor
    ADD CONSTRAINT pk_dbprofessor PRIMARY KEY (seq);


--
-- TOC entry 3253 (class 2606 OID 30014)
-- Dependencies: 269 269 4035
-- Name: pk_dbprofessor_area; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprofessor_area
    ADD CONSTRAINT pk_dbprofessor_area PRIMARY KEY (seq);


--
-- TOC entry 3255 (class 2606 OID 30016)
-- Dependencies: 271 271 4035
-- Name: pk_dbprojeto_curso; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprojeto_curso
    ADD CONSTRAINT pk_dbprojeto_curso PRIMARY KEY (seq);


--
-- TOC entry 3257 (class 2606 OID 30018)
-- Dependencies: 273 273 4035
-- Name: pk_dbprojeto_curso_disciplina; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprojeto_curso_disciplina
    ADD CONSTRAINT pk_dbprojeto_curso_disciplina PRIMARY KEY (seq);


--
-- TOC entry 3259 (class 2606 OID 30020)
-- Dependencies: 275 275 4035
-- Name: pk_dbrecado; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbrecado
    ADD CONSTRAINT pk_dbrecado PRIMARY KEY (seq);


--
-- TOC entry 3261 (class 2606 OID 30022)
-- Dependencies: 277 277 4035
-- Name: pk_dbregra_avaliacao; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbregra_avaliacao
    ADD CONSTRAINT pk_dbregra_avaliacao PRIMARY KEY (seq);


--
-- TOC entry 3263 (class 2606 OID 30024)
-- Dependencies: 279 279 4035
-- Name: pk_dbrequisito_turma; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbrequisito_turma
    ADD CONSTRAINT pk_dbrequisito_turma PRIMARY KEY (seq);


--
-- TOC entry 3265 (class 2606 OID 30026)
-- Dependencies: 281 281 4035
-- Name: pk_dbsala; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbsala
    ADD CONSTRAINT pk_dbsala PRIMARY KEY (seq);


--
-- TOC entry 3267 (class 2606 OID 30028)
-- Dependencies: 283 283 4035
-- Name: pk_dbsituacao_boleto; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbsituacao_boleto
    ADD CONSTRAINT pk_dbsituacao_boleto PRIMARY KEY (seq);


--
-- TOC entry 3269 (class 2606 OID 30030)
-- Dependencies: 285 285 4035
-- Name: pk_dbsituacao_caixa_funcionari; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbsituacao_caixa_funcionario
    ADD CONSTRAINT pk_dbsituacao_caixa_funcionari PRIMARY KEY (seq);


--
-- TOC entry 3271 (class 2606 OID 30032)
-- Dependencies: 287 287 4035
-- Name: pk_dbsituacao_movimento; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbsituacao_movimento
    ADD CONSTRAINT pk_dbsituacao_movimento PRIMARY KEY (seq);


--
-- TOC entry 3273 (class 2606 OID 30034)
-- Dependencies: 289 289 4035
-- Name: pk_dbsituacao_parcela; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbsituacao_parcela
    ADD CONSTRAINT pk_dbsituacao_parcela PRIMARY KEY (seq);


--
-- TOC entry 3275 (class 2606 OID 30036)
-- Dependencies: 291 291 4035
-- Name: pk_dbsituacao_turma; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbsituacao_turma
    ADD CONSTRAINT pk_dbsituacao_turma PRIMARY KEY (seq);


--
-- TOC entry 3277 (class 2606 OID 30038)
-- Dependencies: 293 293 4035
-- Name: pk_dbstatus; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbstatus
    ADD CONSTRAINT pk_dbstatus PRIMARY KEY (seq);


--
-- TOC entry 3279 (class 2606 OID 30040)
-- Dependencies: 295 295 4035
-- Name: pk_dbtelefone; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtelefone
    ADD CONSTRAINT pk_dbtelefone PRIMARY KEY (seq);


--
-- TOC entry 3281 (class 2606 OID 30042)
-- Dependencies: 297 297 4035
-- Name: pk_dbtipo_convenio; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtipo_convenio
    ADD CONSTRAINT pk_dbtipo_convenio PRIMARY KEY (seq);


--
-- TOC entry 3283 (class 2606 OID 30044)
-- Dependencies: 299 299 4035
-- Name: pk_dbtipo_curso; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtipo_curso
    ADD CONSTRAINT pk_dbtipo_curso PRIMARY KEY (seq);


--
-- TOC entry 3285 (class 2606 OID 30046)
-- Dependencies: 301 301 4035
-- Name: pk_dbtipo_estorno; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtipo_estorno
    ADD CONSTRAINT pk_dbtipo_estorno PRIMARY KEY (seq);


--
-- TOC entry 3287 (class 2606 OID 30048)
-- Dependencies: 302 302 4035
-- Name: pk_dbtipo_produto; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtipo_produto
    ADD CONSTRAINT pk_dbtipo_produto PRIMARY KEY (seq);


--
-- TOC entry 3289 (class 2606 OID 30050)
-- Dependencies: 303 303 4035
-- Name: pk_dbtipo_telefone; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtipo_telefone
    ADD CONSTRAINT pk_dbtipo_telefone PRIMARY KEY (seq);


--
-- TOC entry 3291 (class 2606 OID 30052)
-- Dependencies: 305 305 4035
-- Name: pk_dbtitularidade; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtitularidade
    ADD CONSTRAINT pk_dbtitularidade PRIMARY KEY (seq);


--
-- TOC entry 3293 (class 2606 OID 30054)
-- Dependencies: 307 307 4035
-- Name: pk_dbtransacao; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacao
    ADD CONSTRAINT pk_dbtransacao PRIMARY KEY (seq);


--
-- TOC entry 3295 (class 2606 OID 30056)
-- Dependencies: 309 309 4035
-- Name: pk_dbtransacao_aluno; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacao_aluno
    ADD CONSTRAINT pk_dbtransacao_aluno PRIMARY KEY (seq);


--
-- TOC entry 3297 (class 2606 OID 30058)
-- Dependencies: 311 311 4035
-- Name: pk_dbtransacao_convenio; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacao_convenio
    ADD CONSTRAINT pk_dbtransacao_convenio PRIMARY KEY (seq);


--
-- TOC entry 3299 (class 2606 OID 30060)
-- Dependencies: 313 313 4035
-- Name: pk_dbtransacao_produto; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacao_produto
    ADD CONSTRAINT pk_dbtransacao_produto PRIMARY KEY (seq);


--
-- TOC entry 3301 (class 2606 OID 30062)
-- Dependencies: 315 315 4035
-- Name: pk_dbtreinamento; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtreinamento
    ADD CONSTRAINT pk_dbtreinamento PRIMARY KEY (seq);


--
-- TOC entry 3303 (class 2606 OID 30064)
-- Dependencies: 317 317 4035
-- Name: pk_dbturma; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturma
    ADD CONSTRAINT pk_dbturma PRIMARY KEY (seq);


--
-- TOC entry 3305 (class 2606 OID 30066)
-- Dependencies: 319 319 4035
-- Name: pk_dbturma_convenio; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturma_convenio
    ADD CONSTRAINT pk_dbturma_convenio PRIMARY KEY (seq);


--
-- TOC entry 3307 (class 2606 OID 30068)
-- Dependencies: 321 321 4035
-- Name: pk_dbturma_disciplina; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturma_disciplina
    ADD CONSTRAINT pk_dbturma_disciplina PRIMARY KEY (seq);


--
-- TOC entry 3309 (class 2606 OID 30070)
-- Dependencies: 323 323 4035
-- Name: pk_dbturma_disciplina_arquivo; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturma_disciplina_arquivo
    ADD CONSTRAINT pk_dbturma_disciplina_arquivo PRIMARY KEY (seq);


--
-- TOC entry 3311 (class 2606 OID 30072)
-- Dependencies: 325 325 4035
-- Name: pk_dbturma_disciplina_aula; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturma_disciplina_aula
    ADD CONSTRAINT pk_dbturma_disciplina_aula PRIMARY KEY (seq);


--
-- TOC entry 3313 (class 2606 OID 30074)
-- Dependencies: 327 327 4035
-- Name: pk_dbturma_disciplina_avaliaca; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturma_disciplina_avaliacao
    ADD CONSTRAINT pk_dbturma_disciplina_avaliaca PRIMARY KEY (seq);


--
-- TOC entry 3315 (class 2606 OID 30076)
-- Dependencies: 329 329 4035
-- Name: pk_dbturma_disciplina_material; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturma_disciplina_material
    ADD CONSTRAINT pk_dbturma_disciplina_material PRIMARY KEY (seq);


--
-- TOC entry 3317 (class 2606 OID 30078)
-- Dependencies: 331 331 4035
-- Name: pk_dbturma_disciplina_planoaul; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturma_disciplina_planoaula
    ADD CONSTRAINT pk_dbturma_disciplina_planoaul PRIMARY KEY (seq);


--
-- TOC entry 3319 (class 2606 OID 30080)
-- Dependencies: 333 333 4035
-- Name: pk_dbunidade; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbunidade
    ADD CONSTRAINT pk_dbunidade PRIMARY KEY (seq);


--
-- TOC entry 3321 (class 2606 OID 30082)
-- Dependencies: 335 335 4035
-- Name: pk_dbunidade_parametro; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbunidade_parametro
    ADD CONSTRAINT pk_dbunidade_parametro PRIMARY KEY (seq);


--
-- TOC entry 3323 (class 2606 OID 30084)
-- Dependencies: 337 337 4035
-- Name: pk_dbusuario; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbusuario
    ADD CONSTRAINT pk_dbusuario PRIMARY KEY (seq);


--
-- TOC entry 3327 (class 2606 OID 30086)
-- Dependencies: 339 339 4035
-- Name: pk_dbusuario_privilegio; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbusuario_privilegio
    ADD CONSTRAINT pk_dbusuario_privilegio PRIMARY KEY (seq);


--
-- TOC entry 3169 (class 1259 OID 30087)
-- Dependencies: 192 4035
-- Name: fki__dbparcela_dbcheque; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX fki__dbparcela_dbcheque ON dbcheque USING btree (seq);


--
-- TOC entry 3170 (class 1259 OID 30088)
-- Dependencies: 192 4035
-- Name: fki_dbcaixa__dbcheque__caixseq; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_dbcaixa__dbcheque__caixseq ON dbcheque USING btree (caixseq);


--
-- TOC entry 3160 (class 1259 OID 30089)
-- Dependencies: 184 4035
-- Name: fki_dbcaixa_cxfuseq; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_dbcaixa_cxfuseq ON dbcaixa USING btree (cxfuseq);


--
-- TOC entry 3175 (class 1259 OID 30090)
-- Dependencies: 196 4035
-- Name: fki_dbconvenio_plcoseq; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_dbconvenio_plcoseq ON dbconvenio USING btree (plcoseq);


--
-- TOC entry 3325 (class 1259 OID 30091)
-- Dependencies: 339 4035
-- Name: id_dbusuario_privilegio; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX id_dbusuario_privilegio ON dbusuario_privilegio USING btree (funcionalidade);


--
-- TOC entry 3199 (class 1259 OID 30092)
-- Dependencies: 218 218 4035
-- Name: in_ende; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX in_ende ON dbendereco USING btree (pessseq, cep);


--
-- TOC entry 3208 (class 1259 OID 30093)
-- Dependencies: 225 225 4035
-- Name: in_fmpg; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX in_fmpg ON dbforma_pagamento USING btree (seq, titulo);


--
-- TOC entry 3196 (class 1259 OID 30094)
-- Dependencies: 216 216 4035
-- Name: in_mail; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX in_mail ON dbemail USING btree (pessseq, email);


--
-- TOC entry 3155 (class 1259 OID 30095)
-- Dependencies: 180 180 4035
-- Name: index_dbboleto; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_dbboleto ON dbboleto USING btree (parcseq, ndocumento);


--
-- TOC entry 3235 (class 1259 OID 30096)
-- Dependencies: 251 4035
-- Name: uk_dbpessoas; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX uk_dbpessoas ON dbpessoa USING btree (pessnmrf);


--
-- TOC entry 3324 (class 1259 OID 30097)
-- Dependencies: 337 4035
-- Name: uk_dbusuario; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX uk_dbusuario ON dbusuario USING btree (usuario);


--
-- TOC entry 3351 (class 2606 OID 30098)
-- Dependencies: 3141 166 172 4035
-- Name: fk_aldi_apdi_aldiseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbaproveitamento_disciplina
    ADD CONSTRAINT fk_aldi_apdi_aldiseq FOREIGN KEY (aldiseq) REFERENCES dbaluno_disciplina(seq) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3334 (class 2606 OID 30103)
-- Dependencies: 3139 164 166 4035
-- Name: fk_alun_aldi_alunseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbaluno_disciplina
    ADD CONSTRAINT fk_alun_aldi_alunseq FOREIGN KEY (alunseq) REFERENCES dbaluno(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3340 (class 2606 OID 30108)
-- Dependencies: 3139 164 168 4035
-- Name: fk_alun_alrq_alunseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbaluno_requisito
    ADD CONSTRAINT fk_alun_alrq_alunseq FOREIGN KEY (alunseq) REFERENCES dbaluno(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3345 (class 2606 OID 30113)
-- Dependencies: 3139 164 170 4035
-- Name: fk_alun_also_alunseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbaluno_solicitacao
    ADD CONSTRAINT fk_alun_also_alunseq FOREIGN KEY (alunseq) REFERENCES dbaluno(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3447 (class 2606 OID 30118)
-- Dependencies: 3139 164 220 4035
-- Name: fk_alun_falt_alunseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfalta
    ADD CONSTRAINT fk_alun_falt_alunseq FOREIGN KEY (alunseq) REFERENCES dbaluno(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3495 (class 2606 OID 30123)
-- Dependencies: 3139 164 241 4035
-- Name: fk_alun_nota_alunseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbnota
    ADD CONSTRAINT fk_alun_nota_alunseq FOREIGN KEY (alunseq) REFERENCES dbaluno(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3618 (class 2606 OID 30128)
-- Dependencies: 3139 164 309 4035
-- Name: fk_alun_tral_alunseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacao_aluno
    ADD CONSTRAINT fk_alun_tral_alunseq FOREIGN KEY (alunseq) REFERENCES dbaluno(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3553 (class 2606 OID 30133)
-- Dependencies: 3149 174 271 4035
-- Name: fk_arcu_pjcu_arcuseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprojeto_curso
    ADD CONSTRAINT fk_arcu_pjcu_arcuseq FOREIGN KEY (arcuseq) REFERENCES dbarea_curso(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3548 (class 2606 OID 30138)
-- Dependencies: 3149 174 269 4035
-- Name: fk_arcu_prar_arcuseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprofessor_area
    ADD CONSTRAINT fk_arcu_prar_arcuseq FOREIGN KEY (arcuseq) REFERENCES dbarea_curso(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3496 (class 2606 OID 30143)
-- Dependencies: 3151 176 241 4035
-- Name: fk_aval_nota_avalseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbnota
    ADD CONSTRAINT fk_aval_nota_avalseq FOREIGN KEY (avalseq) REFERENCES dbavaliacao(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3369 (class 2606 OID 30148)
-- Dependencies: 3156 180 184 4035
-- Name: fk_bole_caix_boleseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcaixa
    ADD CONSTRAINT fk_bole_caix_boleseq FOREIGN KEY (boleseq) REFERENCES dbboleto(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3394 (class 2606 OID 30153)
-- Dependencies: 3161 184 192 4035
-- Name: fk_caix_cheq_caixseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcheque
    ADD CONSTRAINT fk_caix_cheq_caixseq FOREIGN KEY (caixseq) REFERENCES dbcaixa(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3387 (class 2606 OID 30158)
-- Dependencies: 3165 188 188 4035
-- Name: fk_carg_carg_cargseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcargo
    ADD CONSTRAINT fk_carg_carg_cargseq FOREIGN KEY (cargseq) REFERENCES dbcargo(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3463 (class 2606 OID 30163)
-- Dependencies: 3165 188 227 4035
-- Name: fk_carg_func_cargseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfuncionario
    ADD CONSTRAINT fk_carg_func_cargseq FOREIGN KEY (cargseq) REFERENCES dbcargo(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3485 (class 2606 OID 30168)
-- Dependencies: 3167 190 237 4035
-- Name: fk_ccdu_livr_ccduseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dblivro
    ADD CONSTRAINT fk_ccdu_livr_ccduseq FOREIGN KEY (ccduseq) REFERENCES dbcdu(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3365 (class 2606 OID 30173)
-- Dependencies: 3173 194 182 4035
-- Name: fk_cofi_boes_cofiseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbboleto_estrutura
    ADD CONSTRAINT fk_cofi_boes_cofiseq FOREIGN KEY (cofiseq) REFERENCES dbconta_financeira(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3370 (class 2606 OID 30178)
-- Dependencies: 3173 194 184 4035
-- Name: fk_cofi_caix_cofiseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcaixa
    ADD CONSTRAINT fk_cofi_caix_cofiseq FOREIGN KEY (cofiseq) REFERENCES dbconta_financeira(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3381 (class 2606 OID 30183)
-- Dependencies: 3173 194 186 4035
-- Name: fk_cofi_cxfu_cofiseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcaixa_funcionario
    ADD CONSTRAINT fk_cofi_cxfu_cofiseq FOREIGN KEY (cofiseq) REFERENCES dbconta_financeira(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3456 (class 2606 OID 30188)
-- Dependencies: 3173 194 223 4035
-- Name: fk_cofi_fecf_cofiseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfechamento_conta_financeira
    ADD CONSTRAINT fk_cofi_fecf_cofiseq FOREIGN KEY (cofiseq) REFERENCES dbconta_financeira(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3406 (class 2606 OID 30193)
-- Dependencies: 3176 196 198 4035
-- Name: fk_conv_code_convseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbconvenio_desconto
    ADD CONSTRAINT fk_conv_code_convseq FOREIGN KEY (convseq) REFERENCES dbconvenio(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3623 (class 2606 OID 30198)
-- Dependencies: 3176 196 311 4035
-- Name: fk_conv_trco_convseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacao_convenio
    ADD CONSTRAINT fk_conv_trco_convseq FOREIGN KEY (convseq) REFERENCES dbconvenio(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3644 (class 2606 OID 30203)
-- Dependencies: 3176 196 319 4035
-- Name: fk_conv_tuco_convseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturma_convenio
    ADD CONSTRAINT fk_conv_tuco_convseq FOREIGN KEY (convseq) REFERENCES dbconvenio(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3486 (class 2606 OID 30208)
-- Dependencies: 3242 259 237 4035
-- Name: fk_cpha_livr_cphaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dblivro
    ADD CONSTRAINT fk_cpha_livr_cphaseq FOREIGN KEY (cphaseq) REFERENCES dbpha(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3328 (class 2606 OID 30213)
-- Dependencies: 3184 204 164 4035
-- Name: fk_curs_alun_cursseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbaluno
    ADD CONSTRAINT fk_curs_alun_cursseq FOREIGN KEY (cursseq) REFERENCES dbcurso(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3636 (class 2606 OID 30218)
-- Dependencies: 3184 204 317 4035
-- Name: fk_curs_turm_cursseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturma
    ADD CONSTRAINT fk_curs_turm_cursseq FOREIGN KEY (cursseq) REFERENCES dbcurso(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3457 (class 2606 OID 30223)
-- Dependencies: 3322 337 223 4035
-- Name: fk_dbfecham_usua_fecf_dbusuari; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfechamento_conta_financeira
    ADD CONSTRAINT fk_dbfecham_usua_fecf_dbusuari FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3346 (class 2606 OID 30228)
-- Dependencies: 3188 208 170 4035
-- Name: fk_dept_also_deptseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbaluno_solicitacao
    ADD CONSTRAINT fk_dept_also_deptseq FOREIGN KEY (deptseq) REFERENCES dbdepartamento(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3464 (class 2606 OID 30233)
-- Dependencies: 3188 208 227 4035
-- Name: fk_dept_func_deptseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfuncionario
    ADD CONSTRAINT fk_dept_func_deptseq FOREIGN KEY (deptseq) REFERENCES dbdepartamento(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3335 (class 2606 OID 30238)
-- Dependencies: 3190 210 166 4035
-- Name: fk_disc_aldi_discseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbaluno_disciplina
    ADD CONSTRAINT fk_disc_aldi_discseq FOREIGN KEY (discseq) REFERENCES dbdisciplina(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3433 (class 2606 OID 30243)
-- Dependencies: 3190 210 212 4035
-- Name: fk_disc_disi_discseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbdisciplina_similar
    ADD CONSTRAINT fk_disc_disi_discseq FOREIGN KEY (discseq) REFERENCES dbdisciplina(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3434 (class 2606 OID 30248)
-- Dependencies: 3190 210 212 4035
-- Name: fk_disc_disi_disiseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbdisciplina_similar
    ADD CONSTRAINT fk_disc_disi_disiseq FOREIGN KEY (disiseq) REFERENCES dbdisciplina(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3559 (class 2606 OID 30253)
-- Dependencies: 3190 210 273 4035
-- Name: fk_disc_pjcd_discseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprojeto_curso_disciplina
    ADD CONSTRAINT fk_disc_pjcd_discseq FOREIGN KEY (discseq) REFERENCES dbdisciplina(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3649 (class 2606 OID 30258)
-- Dependencies: 3190 210 321 4035
-- Name: fk_disc_tudi_discseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturma_disciplina
    ADD CONSTRAINT fk_disc_tudi_discseq FOREIGN KEY (discseq) REFERENCES dbdisciplina(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3519 (class 2606 OID 30263)
-- Dependencies: 3318 333 251 4035
-- Name: fk_empr_pess_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoa
    ADD CONSTRAINT fk_empr_pess_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3371 (class 2606 OID 30268)
-- Dependencies: 3206 223 184 4035
-- Name: fk_fecf_caix_fecfseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcaixa
    ADD CONSTRAINT fk_fecf_caix_fecfseq FOREIGN KEY (fecfseq) REFERENCES dbfechamento_conta_financeira(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3372 (class 2606 OID 30273)
-- Dependencies: 3209 225 184 4035
-- Name: fk_fmpg_caix_fmpgseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcaixa
    ADD CONSTRAINT fk_fmpg_caix_fmpgseq FOREIGN KEY (fmpgseq) REFERENCES dbforma_pagamento(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3382 (class 2606 OID 30278)
-- Dependencies: 3211 227 186 4035
-- Name: fk_func_cxfu_funcseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcaixa_funcionario
    ADD CONSTRAINT fk_func_cxfu_funcseq FOREIGN KEY (funcseq) REFERENCES dbfuncionario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3425 (class 2606 OID 30283)
-- Dependencies: 3211 227 208 4035
-- Name: fk_func_dept_pfunseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbdepartamento
    ADD CONSTRAINT fk_func_dept_pfunseq FOREIGN KEY (funcseq) REFERENCES dbfuncionario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3468 (class 2606 OID 30288)
-- Dependencies: 3211 227 229 4035
-- Name: fk_func_fuoc_funcseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfuncionario_ocorrencia
    ADD CONSTRAINT fk_func_fuoc_funcseq FOREIGN KEY (funcseq) REFERENCES dbfuncionario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3472 (class 2606 OID 30293)
-- Dependencies: 3211 227 231 4035
-- Name: fk_func_futr_funcseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfuncionario_treinamento
    ADD CONSTRAINT fk_func_futr_funcseq FOREIGN KEY (funcseq) REFERENCES dbfuncionario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3513 (class 2606 OID 30298)
-- Dependencies: 3211 227 249 4035
-- Name: fk_func_patr_funcseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpatrimonio
    ADD CONSTRAINT fk_func_patr_funcseq FOREIGN KEY (funcseq) REFERENCES dbfuncionario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3355 (class 2606 OID 30303)
-- Dependencies: 3217 233 176 4035
-- Name: fk_gdav_aval_gdavseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbavaliacao
    ADD CONSTRAINT fk_gdav_aval_gdavseq FOREIGN KEY (gdavseq) REFERENCES dbgrade_avaliacao(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3554 (class 2606 OID 30308)
-- Dependencies: 3217 233 271 4035
-- Name: fk_gdav_pjcu_gdavseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprojeto_curso
    ADD CONSTRAINT fk_gdav_pjcu_gdavseq FOREIGN KEY (gdavseq) REFERENCES dbgrade_avaliacao(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3650 (class 2606 OID 30313)
-- Dependencies: 3217 233 321 4035
-- Name: fk_gdav_tudi_gdavseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturma_disciplina
    ADD CONSTRAINT fk_gdav_tudi_gdavseq FOREIGN KEY (gdavseq) REFERENCES dbgrade_avaliacao(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3491 (class 2606 OID 30318)
-- Dependencies: 3221 237 239 4035
-- Name: fk_livr_loli_livrseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dblocacao_livro
    ADD CONSTRAINT fk_livr_loli_livrseq FOREIGN KEY (livrseq) REFERENCES dblivro(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3360 (class 2606 OID 30323)
-- Dependencies: 3227 245 180 4035
-- Name: fk_parc_bole_parcseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbboleto
    ADD CONSTRAINT fk_parc_bole_parcseq FOREIGN KEY (parcseq) REFERENCES dbparcela(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3373 (class 2606 OID 30328)
-- Dependencies: 3227 245 184 4035
-- Name: fk_parc_caix_parcseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcaixa
    ADD CONSTRAINT fk_parc_caix_parcseq FOREIGN KEY (parcseq) REFERENCES dbparcela(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3507 (class 2606 OID 30333)
-- Dependencies: 3227 245 247 4035
-- Name: fk_parc_paes_paatseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbparcela_estorno
    ADD CONSTRAINT fk_parc_paes_paatseq FOREIGN KEY (paatseq) REFERENCES dbparcela(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3508 (class 2606 OID 30338)
-- Dependencies: 3227 245 247 4035
-- Name: fk_parc_paes_paorseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbparcela_estorno
    ADD CONSTRAINT fk_parc_paes_paorseq FOREIGN KEY (paorseq) REFERENCES dbparcela(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3487 (class 2606 OID 30343)
-- Dependencies: 3231 249 237 4035
-- Name: fk_patr_livr_patrseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dblivro
    ADD CONSTRAINT fk_patr_livr_patrseq FOREIGN KEY (patrseq) REFERENCES dbpatrimonio(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3347 (class 2606 OID 30348)
-- Dependencies: 3233 251 170 4035
-- Name: fk_pess_also_pessseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbaluno_solicitacao
    ADD CONSTRAINT fk_pess_also_pessseq FOREIGN KEY (pessseq) REFERENCES dbpessoa(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3410 (class 2606 OID 30353)
-- Dependencies: 3233 251 200 4035
-- Name: fk_pess_cota_pessseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcotacao
    ADD CONSTRAINT fk_pess_cota_pessseq FOREIGN KEY (pessseq) REFERENCES dbpessoa(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3592 (class 2606 OID 30358)
-- Dependencies: 3233 251 295 4035
-- Name: fk_pess_fone_pessseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtelefone
    ADD CONSTRAINT fk_pess_fone_pessseq FOREIGN KEY (pessseq) REFERENCES dbpessoa(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3418 (class 2606 OID 30363)
-- Dependencies: 3254 271 204 4035
-- Name: fk_pjcu_curs_pjcuseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcurso
    ADD CONSTRAINT fk_pjcu_curs_pjcuseq FOREIGN KEY (pjcuseq) REFERENCES dbprojeto_curso(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3560 (class 2606 OID 30368)
-- Dependencies: 3254 271 273 4035
-- Name: fk_pjcu_pjcd_pjcuseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprojeto_curso_disciplina
    ADD CONSTRAINT fk_pjcu_pjcd_pjcuseq FOREIGN KEY (pjcuseq) REFERENCES dbprojeto_curso(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3374 (class 2606 OID 30373)
-- Dependencies: 3244 261 184 4035
-- Name: fk_plco_caix_plcoseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcaixa
    ADD CONSTRAINT fk_plco_caix_plcoseq FOREIGN KEY (plcoseq) REFERENCES dbplano_conta(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3401 (class 2606 OID 30378)
-- Dependencies: 3244 261 196 4035
-- Name: fk_plco_conv_convseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbconvenio
    ADD CONSTRAINT fk_plco_conv_convseq FOREIGN KEY (plcoseq) REFERENCES dbplano_conta(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3501 (class 2606 OID 30383)
-- Dependencies: 3244 261 245 4035
-- Name: fk_plco_parc_plcoseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbparcela
    ADD CONSTRAINT fk_plco_parc_plcoseq FOREIGN KEY (plcoseq) REFERENCES dbplano_conta(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3614 (class 2606 OID 30388)
-- Dependencies: 3244 261 307 4035
-- Name: fk_plco_tran_plcoseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacao
    ADD CONSTRAINT fk_plco_tran_plcoseq FOREIGN KEY (plcoseq) REFERENCES dbplano_conta(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3637 (class 2606 OID 30393)
-- Dependencies: 3244 261 317 4035
-- Name: fk_plco_turm_plcoseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturma
    ADD CONSTRAINT fk_plco_turm_plcoseq FOREIGN KEY (plcoseq) REFERENCES dbplano_conta(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3411 (class 2606 OID 30398)
-- Dependencies: 3248 265 200 4035
-- Name: fk_prod_cota_prodseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcotacao
    ADD CONSTRAINT fk_prod_cota_prodseq FOREIGN KEY (prodseq) REFERENCES dbproduto(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3514 (class 2606 OID 30403)
-- Dependencies: 3248 265 249 4035
-- Name: fk_prod_patr_prodseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpatrimonio
    ADD CONSTRAINT fk_prod_patr_prodseq FOREIGN KEY (prodseq) REFERENCES dbproduto(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3638 (class 2606 OID 30408)
-- Dependencies: 3248 265 317 4035
-- Name: fk_prod_turm_prodseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturma
    ADD CONSTRAINT fk_prod_turm_prodseq FOREIGN KEY (prodseq) REFERENCES dbproduto(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3549 (class 2606 OID 30413)
-- Dependencies: 3250 267 269 4035
-- Name: fk_prof_prar_profseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprofessor_area
    ADD CONSTRAINT fk_prof_prar_profseq FOREIGN KEY (profseq) REFERENCES dbprofessor(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3657 (class 2606 OID 30418)
-- Dependencies: 3250 267 323 4035
-- Name: fk_prof_tdaq_profseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturma_disciplina_arquivo
    ADD CONSTRAINT fk_prof_tdaq_profseq FOREIGN KEY (profseq) REFERENCES dbprofessor(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3674 (class 2606 OID 30423)
-- Dependencies: 3250 267 331 4035
-- Name: fk_prof_tdaq_profseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturma_disciplina_planoaula
    ADD CONSTRAINT fk_prof_tdaq_profseq FOREIGN KEY (profseq) REFERENCES dbprofessor(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3651 (class 2606 OID 30428)
-- Dependencies: 3250 267 321 4035
-- Name: fk_prof_tudi_profseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturma_disciplina
    ADD CONSTRAINT fk_prof_tudi_profseq FOREIGN KEY (profseq) REFERENCES dbprofessor(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3341 (class 2606 OID 30433)
-- Dependencies: 3262 279 168 4035
-- Name: fk_retu_alrq_retuseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbaluno_requisito
    ADD CONSTRAINT fk_retu_alrq_retuseq FOREIGN KEY (retuseq) REFERENCES dbrequisito_turma(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3356 (class 2606 OID 30438)
-- Dependencies: 3260 277 176 4035
-- Name: fk_rgav_aval_rgavseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbavaliacao
    ADD CONSTRAINT fk_rgav_aval_rgavseq FOREIGN KEY (rgavseq) REFERENCES dbregra_avaliacao(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3426 (class 2606 OID 30443)
-- Dependencies: 3264 281 208 4035
-- Name: fk_sala_dept_salaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbdepartamento
    ADD CONSTRAINT fk_sala_dept_salaseq FOREIGN KEY (salaseq) REFERENCES dbsala(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3515 (class 2606 OID 30448)
-- Dependencies: 3264 281 249 4035
-- Name: fk_sala_patr_salaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpatrimonio
    ADD CONSTRAINT fk_sala_patr_salaseq FOREIGN KEY (salaseq) REFERENCES dbsala(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3652 (class 2606 OID 30453)
-- Dependencies: 3264 281 321 4035
-- Name: fk_sala_tudi_salaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturma_disciplina
    ADD CONSTRAINT fk_sala_tudi_salaseq FOREIGN KEY (salaseq) REFERENCES dbsala(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3336 (class 2606 OID 30458)
-- Dependencies: 3276 293 166 4035
-- Name: fk_stat_aldi_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbaluno_disciplina
    ADD CONSTRAINT fk_stat_aldi_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3342 (class 2606 OID 30463)
-- Dependencies: 3276 293 168 4035
-- Name: fk_stat_alrq_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbaluno_requisito
    ADD CONSTRAINT fk_stat_alrq_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3348 (class 2606 OID 30468)
-- Dependencies: 3276 293 170 4035
-- Name: fk_stat_also_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbaluno_solicitacao
    ADD CONSTRAINT fk_stat_also_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3329 (class 2606 OID 30473)
-- Dependencies: 3276 293 164 4035
-- Name: fk_stat_alun_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbaluno
    ADD CONSTRAINT fk_stat_alun_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3352 (class 2606 OID 30478)
-- Dependencies: 3276 293 174 4035
-- Name: fk_stat_arcu_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbarea_curso
    ADD CONSTRAINT fk_stat_arcu_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3357 (class 2606 OID 30483)
-- Dependencies: 3276 293 176 4035
-- Name: fk_stat_aval_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbavaliacao
    ADD CONSTRAINT fk_stat_aval_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3361 (class 2606 OID 30488)
-- Dependencies: 3276 293 180 4035
-- Name: fk_stat_bole_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbboleto
    ADD CONSTRAINT fk_stat_bole_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3375 (class 2606 OID 30493)
-- Dependencies: 3276 293 184 4035
-- Name: fk_stat_caix_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcaixa
    ADD CONSTRAINT fk_stat_caix_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3388 (class 2606 OID 30498)
-- Dependencies: 3276 293 188 4035
-- Name: fk_stat_carg_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcargo
    ADD CONSTRAINT fk_stat_carg_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3391 (class 2606 OID 30503)
-- Dependencies: 3276 293 190 4035
-- Name: fk_stat_ccdu_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcdu
    ADD CONSTRAINT fk_stat_ccdu_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3395 (class 2606 OID 30508)
-- Dependencies: 3276 293 192 4035
-- Name: fk_stat_cheq_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcheque
    ADD CONSTRAINT fk_stat_cheq_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3407 (class 2606 OID 30513)
-- Dependencies: 3276 293 198 4035
-- Name: fk_stat_code_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbconvenio_desconto
    ADD CONSTRAINT fk_stat_code_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3366 (class 2606 OID 30518)
-- Dependencies: 3276 293 182 4035
-- Name: fk_stat_coes_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbboleto_estrutura
    ADD CONSTRAINT fk_stat_coes_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3398 (class 2606 OID 30523)
-- Dependencies: 3276 293 194 4035
-- Name: fk_stat_cofi_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbconta_financeira
    ADD CONSTRAINT fk_stat_cofi_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3402 (class 2606 OID 30528)
-- Dependencies: 3276 293 196 4035
-- Name: fk_stat_conv_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbconvenio
    ADD CONSTRAINT fk_stat_conv_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3412 (class 2606 OID 30533)
-- Dependencies: 3276 293 200 4035
-- Name: fk_stat_cota_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcotacao
    ADD CONSTRAINT fk_stat_cota_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3532 (class 2606 OID 30538)
-- Dependencies: 3276 293 259 4035
-- Name: fk_stat_cpha_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpha
    ADD CONSTRAINT fk_stat_cpha_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3415 (class 2606 OID 30543)
-- Dependencies: 3276 293 202 4035
-- Name: fk_stat_curr_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcurriculo
    ADD CONSTRAINT fk_stat_curr_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3419 (class 2606 OID 30548)
-- Dependencies: 3276 293 204 4035
-- Name: fk_stat_curs_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcurso
    ADD CONSTRAINT fk_stat_curs_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3383 (class 2606 OID 30553)
-- Dependencies: 3276 293 186 4035
-- Name: fk_stat_cxfu_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcaixa_funcionario
    ADD CONSTRAINT fk_stat_cxfu_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3422 (class 2606 OID 30558)
-- Dependencies: 3276 293 206 4035
-- Name: fk_stat_dema_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbdemanda
    ADD CONSTRAINT fk_stat_dema_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3427 (class 2606 OID 30563)
-- Dependencies: 3276 293 208 4035
-- Name: fk_stat_dept_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbdepartamento
    ADD CONSTRAINT fk_stat_dept_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3430 (class 2606 OID 30568)
-- Dependencies: 3276 293 210 4035
-- Name: fk_stat_disc_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbdisciplina
    ADD CONSTRAINT fk_stat_disc_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3435 (class 2606 OID 30573)
-- Dependencies: 3276 293 212 4035
-- Name: fk_stat_disi_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbdisciplina_similar
    ADD CONSTRAINT fk_stat_disi_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3438 (class 2606 OID 30578)
-- Dependencies: 3276 293 214 4035
-- Name: fk_stat_docu_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbdocumentos
    ADD CONSTRAINT fk_stat_docu_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3444 (class 2606 OID 30583)
-- Dependencies: 3276 293 218 4035
-- Name: fk_stat_ende_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbendereco
    ADD CONSTRAINT fk_stat_ende_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3448 (class 2606 OID 30588)
-- Dependencies: 3276 293 220 4035
-- Name: fk_stat_falt_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfalta
    ADD CONSTRAINT fk_stat_falt_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3458 (class 2606 OID 30593)
-- Dependencies: 3276 293 223 4035
-- Name: fk_stat_fecf_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfechamento_conta_financeira
    ADD CONSTRAINT fk_stat_fecf_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3453 (class 2606 OID 30598)
-- Dependencies: 3276 293 222 4035
-- Name: fk_stat_fecx_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfechamento_caixa
    ADD CONSTRAINT fk_stat_fecx_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3460 (class 2606 OID 30603)
-- Dependencies: 3276 293 225 4035
-- Name: fk_stat_fmpg_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbforma_pagamento
    ADD CONSTRAINT fk_stat_fmpg_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3593 (class 2606 OID 30608)
-- Dependencies: 3276 293 295 4035
-- Name: fk_stat_fone_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtelefone
    ADD CONSTRAINT fk_stat_fone_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3465 (class 2606 OID 30613)
-- Dependencies: 3276 293 227 4035
-- Name: fk_stat_func_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfuncionario
    ADD CONSTRAINT fk_stat_func_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3469 (class 2606 OID 30618)
-- Dependencies: 3276 293 229 4035
-- Name: fk_stat_fuoc_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfuncionario_ocorrencia
    ADD CONSTRAINT fk_stat_fuoc_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3473 (class 2606 OID 30623)
-- Dependencies: 3276 293 231 4035
-- Name: fk_stat_futr_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfuncionario_treinamento
    ADD CONSTRAINT fk_stat_futr_statseq FOREIGN KEY (unidseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3477 (class 2606 OID 30628)
-- Dependencies: 3276 293 233 4035
-- Name: fk_stat_gdav_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbgrade_avaliacao
    ADD CONSTRAINT fk_stat_gdav_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3480 (class 2606 OID 30633)
-- Dependencies: 3276 293 235 4035
-- Name: fk_stat_insc_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbinscricao
    ADD CONSTRAINT fk_stat_insc_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3492 (class 2606 OID 30638)
-- Dependencies: 3276 293 239 4035
-- Name: fk_stat_loli_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dblocacao_livro
    ADD CONSTRAINT fk_stat_loli_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3441 (class 2606 OID 30643)
-- Dependencies: 3276 293 216 4035
-- Name: fk_stat_mail_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbemail
    ADD CONSTRAINT fk_stat_mail_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3497 (class 2606 OID 30648)
-- Dependencies: 3276 293 241 4035
-- Name: fk_stat_nota_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbnota
    ADD CONSTRAINT fk_stat_nota_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3509 (class 2606 OID 30653)
-- Dependencies: 3276 293 247 4035
-- Name: fk_stat_paes_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbparcela_estorno
    ADD CONSTRAINT fk_stat_paes_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3502 (class 2606 OID 30658)
-- Dependencies: 3276 293 245 4035
-- Name: fk_stat_parc_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbparcela
    ADD CONSTRAINT fk_stat_parc_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3488 (class 2606 OID 30663)
-- Dependencies: 3276 293 237 4035
-- Name: fk_stat_patl_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dblivro
    ADD CONSTRAINT fk_stat_patl_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3516 (class 2606 OID 30668)
-- Dependencies: 3276 293 249 4035
-- Name: fk_stat_patr_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpatrimonio
    ADD CONSTRAINT fk_stat_patr_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3520 (class 2606 OID 30673)
-- Dependencies: 3276 293 251 4035
-- Name: fk_stat_pess_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoa
    ADD CONSTRAINT fk_stat_pess_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3522 (class 2606 OID 30678)
-- Dependencies: 3276 293 253 4035
-- Name: fk_stat_pfis_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoa_fisica
    ADD CONSTRAINT fk_stat_pfis_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3561 (class 2606 OID 30683)
-- Dependencies: 3276 293 273 4035
-- Name: fk_stat_pjcd_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprojeto_curso_disciplina
    ADD CONSTRAINT fk_stat_pjcd_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3555 (class 2606 OID 30688)
-- Dependencies: 3276 293 271 4035
-- Name: fk_stat_pjcu_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprojeto_curso
    ADD CONSTRAINT fk_stat_pjcu_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3525 (class 2606 OID 30693)
-- Dependencies: 3276 293 255 4035
-- Name: fk_stat_pjur_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoa_juridica
    ADD CONSTRAINT fk_stat_pjur_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3535 (class 2606 OID 30698)
-- Dependencies: 3276 293 261 4035
-- Name: fk_stat_plco_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbplano_conta
    ADD CONSTRAINT fk_stat_plco_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3538 (class 2606 OID 30703)
-- Dependencies: 3276 293 263 4035
-- Name: fk_stat_prac_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprocesso_academico
    ADD CONSTRAINT fk_stat_prac_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3550 (class 2606 OID 30708)
-- Dependencies: 3276 293 269 4035
-- Name: fk_stat_prar_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprofessor_area
    ADD CONSTRAINT fk_stat_prar_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3541 (class 2606 OID 30713)
-- Dependencies: 3276 293 265 4035
-- Name: fk_stat_prod_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbproduto
    ADD CONSTRAINT fk_stat_prod_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3545 (class 2606 OID 30718)
-- Dependencies: 3276 293 267 4035
-- Name: fk_stat_prof_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprofessor
    ADD CONSTRAINT fk_stat_prof_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3528 (class 2606 OID 30723)
-- Dependencies: 3276 293 257 4035
-- Name: fk_stat_ptit_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoa_titularidade
    ADD CONSTRAINT fk_stat_ptit_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3567 (class 2606 OID 30728)
-- Dependencies: 3276 293 279 4035
-- Name: fk_stat_retu_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbrequisito_turma
    ADD CONSTRAINT fk_stat_retu_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3564 (class 2606 OID 30733)
-- Dependencies: 3276 293 277 4035
-- Name: fk_stat_rgav_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbregra_avaliacao
    ADD CONSTRAINT fk_stat_rgav_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3571 (class 2606 OID 30738)
-- Dependencies: 3276 293 281 4035
-- Name: fk_stat_sala_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbsala
    ADD CONSTRAINT fk_stat_sala_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3589 (class 2606 OID 30743)
-- Dependencies: 3276 293 293 4035
-- Name: fk_stat_stat_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbstatus
    ADD CONSTRAINT fk_stat_stat_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3574 (class 2606 OID 30748)
-- Dependencies: 3276 293 283 4035
-- Name: fk_stat_stbo_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbsituacao_boleto
    ADD CONSTRAINT fk_stat_stbo_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3577 (class 2606 OID 30753)
-- Dependencies: 3276 293 285 4035
-- Name: fk_stat_stcf_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbsituacao_caixa_funcionario
    ADD CONSTRAINT fk_stat_stcf_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3583 (class 2606 OID 30758)
-- Dependencies: 3276 293 289 4035
-- Name: fk_stat_stco_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbsituacao_parcela
    ADD CONSTRAINT fk_stat_stco_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3580 (class 2606 OID 30763)
-- Dependencies: 3276 293 287 4035
-- Name: fk_stat_stmo_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbsituacao_movimento
    ADD CONSTRAINT fk_stat_stmo_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3586 (class 2606 OID 30768)
-- Dependencies: 3276 293 291 4035
-- Name: fk_stat_sttu_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbsituacao_turma
    ADD CONSTRAINT fk_stat_sttu_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3596 (class 2606 OID 30773)
-- Dependencies: 3276 293 297 4035
-- Name: fk_stat_tcon_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtipo_convenio
    ADD CONSTRAINT fk_stat_tcon_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3658 (class 2606 OID 30778)
-- Dependencies: 3276 293 323 4035
-- Name: fk_stat_tdaq_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturma_disciplina_arquivo
    ADD CONSTRAINT fk_stat_tdaq_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3666 (class 2606 OID 30783)
-- Dependencies: 3276 293 327 4035
-- Name: fk_stat_tdaq_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturma_disciplina_avaliacao
    ADD CONSTRAINT fk_stat_tdaq_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3670 (class 2606 OID 30788)
-- Dependencies: 3276 293 329 4035
-- Name: fk_stat_tdma_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturma_disciplina_material
    ADD CONSTRAINT fk_stat_tdma_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3675 (class 2606 OID 30793)
-- Dependencies: 3276 293 331 4035
-- Name: fk_stat_tdpa_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturma_disciplina_planoaula
    ADD CONSTRAINT fk_stat_tdpa_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3602 (class 2606 OID 30798)
-- Dependencies: 3276 293 301 4035
-- Name: fk_stat_ties_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtipo_estorno
    ADD CONSTRAINT fk_stat_ties_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3611 (class 2606 OID 30803)
-- Dependencies: 3276 293 305 4035
-- Name: fk_stat_titu_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtitularidade
    ADD CONSTRAINT fk_stat_titu_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3599 (class 2606 OID 30808)
-- Dependencies: 3276 293 299 4035
-- Name: fk_stat_tpcu_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtipo_curso
    ADD CONSTRAINT fk_stat_tpcu_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3605 (class 2606 OID 30813)
-- Dependencies: 3276 293 302 4035
-- Name: fk_stat_tppr_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtipo_produto
    ADD CONSTRAINT fk_stat_tppr_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3608 (class 2606 OID 30818)
-- Dependencies: 3276 293 303 4035
-- Name: fk_stat_tpte_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtipo_telefone
    ADD CONSTRAINT fk_stat_tpte_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3619 (class 2606 OID 30823)
-- Dependencies: 3276 293 309 4035
-- Name: fk_stat_tral_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacao_aluno
    ADD CONSTRAINT fk_stat_tral_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3615 (class 2606 OID 30828)
-- Dependencies: 3276 293 307 4035
-- Name: fk_stat_tran_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacao
    ADD CONSTRAINT fk_stat_tran_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3624 (class 2606 OID 30833)
-- Dependencies: 3276 293 311 4035
-- Name: fk_stat_trco_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacao_convenio
    ADD CONSTRAINT fk_stat_trco_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3632 (class 2606 OID 30838)
-- Dependencies: 3276 293 315 4035
-- Name: fk_stat_trei_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtreinamento
    ADD CONSTRAINT fk_stat_trei_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3628 (class 2606 OID 30843)
-- Dependencies: 3276 293 313 4035
-- Name: fk_stat_trpr_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacao_produto
    ADD CONSTRAINT fk_stat_trpr_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3645 (class 2606 OID 30848)
-- Dependencies: 3276 293 319 4035
-- Name: fk_stat_tuco_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturma_convenio
    ADD CONSTRAINT fk_stat_tuco_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3653 (class 2606 OID 30853)
-- Dependencies: 3276 293 321 4035
-- Name: fk_stat_tudi_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturma_disciplina
    ADD CONSTRAINT fk_stat_tudi_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3662 (class 2606 OID 30858)
-- Dependencies: 3276 293 325 4035
-- Name: fk_stat_tudl_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturma_disciplina_aula
    ADD CONSTRAINT fk_stat_tudl_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3639 (class 2606 OID 30863)
-- Dependencies: 3276 293 317 4035
-- Name: fk_stat_turm_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturma
    ADD CONSTRAINT fk_stat_turm_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3679 (class 2606 OID 30868)
-- Dependencies: 3276 293 333 4035
-- Name: fk_stat_unid_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbunidade
    ADD CONSTRAINT fk_stat_unid_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3682 (class 2606 OID 30873)
-- Dependencies: 3276 293 335 4035
-- Name: fk_stat_unpa_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbunidade_parametro
    ADD CONSTRAINT fk_stat_unpa_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3685 (class 2606 OID 30878)
-- Dependencies: 3276 293 337 4035
-- Name: fk_stat_usua_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbusuario
    ADD CONSTRAINT fk_stat_usua_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3688 (class 2606 OID 30883)
-- Dependencies: 3276 293 339 4035
-- Name: fk_stat_usup_statseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbusuario_privilegio
    ADD CONSTRAINT fk_stat_usup_statseq FOREIGN KEY (statseq) REFERENCES dbstatus(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3362 (class 2606 OID 30888)
-- Dependencies: 3266 283 180 4035
-- Name: fk_stbo_bole_stboseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbboleto
    ADD CONSTRAINT fk_stbo_bole_stboseq FOREIGN KEY (stboseq) REFERENCES dbsituacao_boleto(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3384 (class 2606 OID 30893)
-- Dependencies: 3268 285 186 4035
-- Name: fk_stcf_cxfu_stcfseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcaixa_funcionario
    ADD CONSTRAINT fk_stcf_cxfu_stcfseq FOREIGN KEY (stcfseq) REFERENCES dbsituacao_caixa_funcionario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3376 (class 2606 OID 30898)
-- Dependencies: 3270 287 184 4035
-- Name: fk_stmo_caix_stmoseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcaixa
    ADD CONSTRAINT fk_stmo_caix_stmoseq FOREIGN KEY (stmoseq) REFERENCES dbsituacao_movimento(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3377 (class 2606 OID 30903)
-- Dependencies: 3272 289 184 4035
-- Name: fk_stpa_caix_stpaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcaixa
    ADD CONSTRAINT fk_stpa_caix_stpaseq FOREIGN KEY (stpaseq) REFERENCES dbsituacao_parcela(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3503 (class 2606 OID 30908)
-- Dependencies: 3272 289 245 4035
-- Name: fk_stpa_parc_stpaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbparcela
    ADD CONSTRAINT fk_stpa_parc_stpaseq FOREIGN KEY (stpaseq) REFERENCES dbsituacao_parcela(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3640 (class 2606 OID 30913)
-- Dependencies: 3274 291 317 4035
-- Name: fk_sttu_turm_sttuseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturma
    ADD CONSTRAINT fk_sttu_turm_sttuseq FOREIGN KEY (sttuseq) REFERENCES dbsituacao_turma(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3403 (class 2606 OID 30918)
-- Dependencies: 3280 297 196 4035
-- Name: fk_tcon_conv_tconseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbconvenio
    ADD CONSTRAINT fk_tcon_conv_tconseq FOREIGN KEY (tconseq) REFERENCES dbtipo_convenio(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3449 (class 2606 OID 30923)
-- Dependencies: 3310 325 220 4035
-- Name: fk_tdal_falta_tdalseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfalta
    ADD CONSTRAINT fk_tdal_falta_tdalseq FOREIGN KEY (tdalseq) REFERENCES dbturma_disciplina_aula(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3510 (class 2606 OID 30928)
-- Dependencies: 3284 301 247 4035
-- Name: fk_ties_paes_tiesseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbparcela_estorno
    ADD CONSTRAINT fk_ties_paes_tiesseq FOREIGN KEY (tiesseq) REFERENCES dbtipo_estorno(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3529 (class 2606 OID 30933)
-- Dependencies: 3290 305 257 4035
-- Name: fk_titu_ptit_tituseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoa_titularidade
    ADD CONSTRAINT fk_titu_ptit_tituseq FOREIGN KEY (tituseq) REFERENCES dbtitularidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3633 (class 2606 OID 30938)
-- Dependencies: 3290 305 315 4035
-- Name: fk_titu_trei_tituseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtreinamento
    ADD CONSTRAINT fk_titu_trei_tituseq FOREIGN KEY (tituseq) REFERENCES dbtitularidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3556 (class 2606 OID 30943)
-- Dependencies: 3282 299 271 4035
-- Name: fk_tpcu_pjcu_tpcuseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprojeto_curso
    ADD CONSTRAINT fk_tpcu_pjcu_tpcuseq FOREIGN KEY (tpcuseq) REFERENCES dbtipo_curso(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3542 (class 2606 OID 30948)
-- Dependencies: 3286 302 265 4035
-- Name: fk_tppr_prod_tpprseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbproduto
    ADD CONSTRAINT fk_tppr_prod_tpprseq FOREIGN KEY (tpprseq) REFERENCES dbtipo_produto(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3330 (class 2606 OID 30953)
-- Dependencies: 3292 307 164 4035
-- Name: fk_tran_alun_transeq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbaluno
    ADD CONSTRAINT fk_tran_alun_transeq FOREIGN KEY (transeq) REFERENCES dbtransacao(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3378 (class 2606 OID 30958)
-- Dependencies: 3292 307 184 4035
-- Name: fk_tran_caix_transeq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcaixa
    ADD CONSTRAINT fk_tran_caix_transeq FOREIGN KEY (transeq) REFERENCES dbtransacao(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3481 (class 2606 OID 30963)
-- Dependencies: 3292 307 235 4035
-- Name: fk_tran_insc_transeq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbinscricao
    ADD CONSTRAINT fk_tran_insc_transeq FOREIGN KEY (transeq) REFERENCES dbtransacao(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3504 (class 2606 OID 30968)
-- Dependencies: 3292 307 245 4035
-- Name: fk_tran_parc_transeq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbparcela
    ADD CONSTRAINT fk_tran_parc_transeq FOREIGN KEY (transeq) REFERENCES dbtransacao(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3620 (class 2606 OID 30973)
-- Dependencies: 3292 307 309 4035
-- Name: fk_tran_tral_transeq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacao_aluno
    ADD CONSTRAINT fk_tran_tral_transeq FOREIGN KEY (transeq) REFERENCES dbtransacao(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3625 (class 2606 OID 30978)
-- Dependencies: 3292 307 311 4035
-- Name: fk_tran_trco_transeq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacao_convenio
    ADD CONSTRAINT fk_tran_trco_transeq FOREIGN KEY (transeq) REFERENCES dbtransacao(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3629 (class 2606 OID 30983)
-- Dependencies: 3292 307 313 4035
-- Name: fk_tran_trpr_trancseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacao_produto
    ADD CONSTRAINT fk_tran_trpr_trancseq FOREIGN KEY (transeq) REFERENCES dbtransacao(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3474 (class 2606 OID 30988)
-- Dependencies: 3300 315 231 4035
-- Name: fk_trei_futr_treiseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfuncionario_treinamento
    ADD CONSTRAINT fk_trei_futr_treiseq FOREIGN KEY (treiseq) REFERENCES dbtreinamento(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3337 (class 2606 OID 30993)
-- Dependencies: 3306 321 166 4035
-- Name: fk_tudi_aldi_tudiseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbaluno_disciplina
    ADD CONSTRAINT fk_tudi_aldi_tudiseq FOREIGN KEY (tudiseq) REFERENCES dbturma_disciplina(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3450 (class 2606 OID 30998)
-- Dependencies: 3306 321 220 4035
-- Name: fk_tudi_falt_tudiseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfalta
    ADD CONSTRAINT fk_tudi_falt_tudiseq FOREIGN KEY (tudiseq) REFERENCES dbturma_disciplina(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3498 (class 2606 OID 31003)
-- Dependencies: 3306 321 241 4035
-- Name: fk_tudi_nota_tudiseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbnota
    ADD CONSTRAINT fk_tudi_nota_tudiseq FOREIGN KEY (tudiseq) REFERENCES dbturma_disciplina(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3663 (class 2606 OID 31008)
-- Dependencies: 3306 321 325 4035
-- Name: fk_tudi_tdal_tudiseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturma_disciplina_aula
    ADD CONSTRAINT fk_tudi_tdal_tudiseq FOREIGN KEY (tudiseq) REFERENCES dbturma_disciplina(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3667 (class 2606 OID 31013)
-- Dependencies: 3306 321 327 4035
-- Name: fk_tudi_tdal_tudiseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturma_disciplina_avaliacao
    ADD CONSTRAINT fk_tudi_tdal_tudiseq FOREIGN KEY (tudiseq) REFERENCES dbturma_disciplina(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3659 (class 2606 OID 31018)
-- Dependencies: 3306 321 323 4035
-- Name: fk_tudi_tdaq_tudiseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturma_disciplina_arquivo
    ADD CONSTRAINT fk_tudi_tdaq_tudiseq FOREIGN KEY (tudiseq) REFERENCES dbturma_disciplina(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3671 (class 2606 OID 31023)
-- Dependencies: 3306 321 329 4035
-- Name: fk_tudi_tdma_tudiseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturma_disciplina_material
    ADD CONSTRAINT fk_tudi_tdma_tudiseq FOREIGN KEY (tudiseq) REFERENCES dbturma_disciplina(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3676 (class 2606 OID 31028)
-- Dependencies: 3306 321 331 4035
-- Name: fk_tudi_tdpa_tudiseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturma_disciplina_planoaula
    ADD CONSTRAINT fk_tudi_tdpa_tudiseq FOREIGN KEY (tudiseq) REFERENCES dbturma_disciplina(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3331 (class 2606 OID 31033)
-- Dependencies: 3302 317 164 4035
-- Name: fk_turm_alun_turmseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbaluno
    ADD CONSTRAINT fk_turm_alun_turmseq FOREIGN KEY (turmseq) REFERENCES dbturma(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3482 (class 2606 OID 31038)
-- Dependencies: 3302 317 235 4035
-- Name: fk_turm_insc_turmseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbinscricao
    ADD CONSTRAINT fk_turm_insc_turmseq FOREIGN KEY (turmseq) REFERENCES dbturma(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3568 (class 2606 OID 31043)
-- Dependencies: 3302 317 279 4035
-- Name: fk_turm_retu_turmseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbrequisito_turma
    ADD CONSTRAINT fk_turm_retu_turmseq FOREIGN KEY (turmseq) REFERENCES dbturma(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3646 (class 2606 OID 31048)
-- Dependencies: 3302 317 319 4035
-- Name: fk_turm_tuco_turmseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturma_convenio
    ADD CONSTRAINT fk_turm_tuco_turmseq FOREIGN KEY (turmseq) REFERENCES dbturma(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3654 (class 2606 OID 31053)
-- Dependencies: 3302 317 321 4035
-- Name: fk_turm_tudi_turmseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturma_disciplina
    ADD CONSTRAINT fk_turm_tudi_turmseq FOREIGN KEY (turmseq) REFERENCES dbturma(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3338 (class 2606 OID 31058)
-- Dependencies: 3318 333 166 4035
-- Name: fk_unid_aldi_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbaluno_disciplina
    ADD CONSTRAINT fk_unid_aldi_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3343 (class 2606 OID 31063)
-- Dependencies: 3318 333 168 4035
-- Name: fk_unid_alrq_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbaluno_requisito
    ADD CONSTRAINT fk_unid_alrq_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3349 (class 2606 OID 31068)
-- Dependencies: 3318 333 170 4035
-- Name: fk_unid_also_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbaluno_solicitacao
    ADD CONSTRAINT fk_unid_also_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3332 (class 2606 OID 31073)
-- Dependencies: 3318 333 164 4035
-- Name: fk_unid_alun_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbaluno
    ADD CONSTRAINT fk_unid_alun_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3353 (class 2606 OID 31078)
-- Dependencies: 3318 333 174 4035
-- Name: fk_unid_arcu_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbarea_curso
    ADD CONSTRAINT fk_unid_arcu_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3358 (class 2606 OID 31083)
-- Dependencies: 3318 333 176 4035
-- Name: fk_unid_aval_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbavaliacao
    ADD CONSTRAINT fk_unid_aval_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3367 (class 2606 OID 31088)
-- Dependencies: 3318 333 182 4035
-- Name: fk_unid_boes_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbboleto_estrutura
    ADD CONSTRAINT fk_unid_boes_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3363 (class 2606 OID 31093)
-- Dependencies: 3318 333 180 4035
-- Name: fk_unid_bole_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbboleto
    ADD CONSTRAINT fk_unid_bole_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3379 (class 2606 OID 31098)
-- Dependencies: 3318 333 184 4035
-- Name: fk_unid_caix_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcaixa
    ADD CONSTRAINT fk_unid_caix_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3389 (class 2606 OID 31103)
-- Dependencies: 3318 333 188 4035
-- Name: fk_unid_carg_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcargo
    ADD CONSTRAINT fk_unid_carg_unidseq FOREIGN KEY (cargseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3392 (class 2606 OID 31108)
-- Dependencies: 3318 333 190 4035
-- Name: fk_unid_ccdu_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcdu
    ADD CONSTRAINT fk_unid_ccdu_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3396 (class 2606 OID 31113)
-- Dependencies: 3318 333 192 4035
-- Name: fk_unid_cheq_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcheque
    ADD CONSTRAINT fk_unid_cheq_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3408 (class 2606 OID 31118)
-- Dependencies: 3318 333 198 4035
-- Name: fk_unid_code_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbconvenio_desconto
    ADD CONSTRAINT fk_unid_code_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3399 (class 2606 OID 31123)
-- Dependencies: 3318 333 194 4035
-- Name: fk_unid_cofi_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbconta_financeira
    ADD CONSTRAINT fk_unid_cofi_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3404 (class 2606 OID 31128)
-- Dependencies: 3318 333 196 4035
-- Name: fk_unid_conv_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbconvenio
    ADD CONSTRAINT fk_unid_conv_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3413 (class 2606 OID 31133)
-- Dependencies: 3318 333 200 4035
-- Name: fk_unid_cota_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcotacao
    ADD CONSTRAINT fk_unid_cota_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3533 (class 2606 OID 31138)
-- Dependencies: 3318 333 259 4035
-- Name: fk_unid_cpha_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpha
    ADD CONSTRAINT fk_unid_cpha_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3416 (class 2606 OID 31143)
-- Dependencies: 3318 333 202 4035
-- Name: fk_unid_curr_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcurriculo
    ADD CONSTRAINT fk_unid_curr_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3420 (class 2606 OID 31148)
-- Dependencies: 3318 333 204 4035
-- Name: fk_unid_curs_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcurso
    ADD CONSTRAINT fk_unid_curs_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3385 (class 2606 OID 31153)
-- Dependencies: 3318 333 186 4035
-- Name: fk_unid_cxfu_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcaixa_funcionario
    ADD CONSTRAINT fk_unid_cxfu_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3423 (class 2606 OID 31158)
-- Dependencies: 3318 333 206 4035
-- Name: fk_unid_dema_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbdemanda
    ADD CONSTRAINT fk_unid_dema_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3428 (class 2606 OID 31163)
-- Dependencies: 3318 333 208 4035
-- Name: fk_unid_dept_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbdepartamento
    ADD CONSTRAINT fk_unid_dept_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3431 (class 2606 OID 31168)
-- Dependencies: 3318 333 210 4035
-- Name: fk_unid_disc_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbdisciplina
    ADD CONSTRAINT fk_unid_disc_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3436 (class 2606 OID 31173)
-- Dependencies: 3318 333 212 4035
-- Name: fk_unid_disi_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbdisciplina_similar
    ADD CONSTRAINT fk_unid_disi_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3439 (class 2606 OID 31178)
-- Dependencies: 3318 333 214 4035
-- Name: fk_unid_docu_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbdocumentos
    ADD CONSTRAINT fk_unid_docu_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3445 (class 2606 OID 31183)
-- Dependencies: 3318 333 218 4035
-- Name: fk_unid_ende_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbendereco
    ADD CONSTRAINT fk_unid_ende_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3451 (class 2606 OID 31188)
-- Dependencies: 3318 333 220 4035
-- Name: fk_unid_falt_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfalta
    ADD CONSTRAINT fk_unid_falt_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3459 (class 2606 OID 31193)
-- Dependencies: 3318 333 223 4035
-- Name: fk_unid_fecf_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfechamento_conta_financeira
    ADD CONSTRAINT fk_unid_fecf_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3454 (class 2606 OID 31198)
-- Dependencies: 3318 333 222 4035
-- Name: fk_unid_fecx_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfechamento_caixa
    ADD CONSTRAINT fk_unid_fecx_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3461 (class 2606 OID 31203)
-- Dependencies: 3318 333 225 4035
-- Name: fk_unid_fmpg_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbforma_pagamento
    ADD CONSTRAINT fk_unid_fmpg_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3594 (class 2606 OID 31208)
-- Dependencies: 3318 333 295 4035
-- Name: fk_unid_fone_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtelefone
    ADD CONSTRAINT fk_unid_fone_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3466 (class 2606 OID 31213)
-- Dependencies: 3318 333 227 4035
-- Name: fk_unid_func_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfuncionario
    ADD CONSTRAINT fk_unid_func_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3470 (class 2606 OID 31218)
-- Dependencies: 3318 333 229 4035
-- Name: fk_unid_fuoc_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfuncionario_ocorrencia
    ADD CONSTRAINT fk_unid_fuoc_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3475 (class 2606 OID 31223)
-- Dependencies: 3318 333 231 4035
-- Name: fk_unid_futr_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfuncionario_treinamento
    ADD CONSTRAINT fk_unid_futr_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3478 (class 2606 OID 31228)
-- Dependencies: 3318 333 233 4035
-- Name: fk_unid_gdav_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbgrade_avaliacao
    ADD CONSTRAINT fk_unid_gdav_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3483 (class 2606 OID 31233)
-- Dependencies: 3318 333 235 4035
-- Name: fk_unid_insc_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbinscricao
    ADD CONSTRAINT fk_unid_insc_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3493 (class 2606 OID 31238)
-- Dependencies: 3318 333 239 4035
-- Name: fk_unid_loli_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dblocacao_livro
    ADD CONSTRAINT fk_unid_loli_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3442 (class 2606 OID 31243)
-- Dependencies: 3318 333 216 4035
-- Name: fk_unid_mail_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbemail
    ADD CONSTRAINT fk_unid_mail_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3499 (class 2606 OID 31248)
-- Dependencies: 3318 333 241 4035
-- Name: fk_unid_nota_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbnota
    ADD CONSTRAINT fk_unid_nota_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3511 (class 2606 OID 31253)
-- Dependencies: 3318 333 247 4035
-- Name: fk_unid_paes_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbparcela_estorno
    ADD CONSTRAINT fk_unid_paes_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3505 (class 2606 OID 31258)
-- Dependencies: 3318 333 245 4035
-- Name: fk_unid_parc_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbparcela
    ADD CONSTRAINT fk_unid_parc_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3489 (class 2606 OID 31263)
-- Dependencies: 3318 333 237 4035
-- Name: fk_unid_patl_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dblivro
    ADD CONSTRAINT fk_unid_patl_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3517 (class 2606 OID 31268)
-- Dependencies: 3318 333 249 4035
-- Name: fk_unid_patr_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpatrimonio
    ADD CONSTRAINT fk_unid_patr_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3523 (class 2606 OID 31273)
-- Dependencies: 3318 333 253 4035
-- Name: fk_unid_pfis_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoa_fisica
    ADD CONSTRAINT fk_unid_pfis_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3562 (class 2606 OID 31278)
-- Dependencies: 3318 333 273 4035
-- Name: fk_unid_pjcd_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprojeto_curso_disciplina
    ADD CONSTRAINT fk_unid_pjcd_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3557 (class 2606 OID 31283)
-- Dependencies: 3318 333 271 4035
-- Name: fk_unid_pjcu_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprojeto_curso
    ADD CONSTRAINT fk_unid_pjcu_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3526 (class 2606 OID 31288)
-- Dependencies: 3318 333 255 4035
-- Name: fk_unid_pjur_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoa_juridica
    ADD CONSTRAINT fk_unid_pjur_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3536 (class 2606 OID 31293)
-- Dependencies: 3318 333 261 4035
-- Name: fk_unid_plco_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbplano_conta
    ADD CONSTRAINT fk_unid_plco_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3539 (class 2606 OID 31298)
-- Dependencies: 3318 333 263 4035
-- Name: fk_unid_prac_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprocesso_academico
    ADD CONSTRAINT fk_unid_prac_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3551 (class 2606 OID 31303)
-- Dependencies: 3318 333 269 4035
-- Name: fk_unid_prar_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprofessor_area
    ADD CONSTRAINT fk_unid_prar_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3543 (class 2606 OID 31308)
-- Dependencies: 3318 333 265 4035
-- Name: fk_unid_prod_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbproduto
    ADD CONSTRAINT fk_unid_prod_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3546 (class 2606 OID 31313)
-- Dependencies: 3318 333 267 4035
-- Name: fk_unid_prof_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprofessor
    ADD CONSTRAINT fk_unid_prof_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3530 (class 2606 OID 31318)
-- Dependencies: 3318 333 257 4035
-- Name: fk_unid_ptit_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoa_titularidade
    ADD CONSTRAINT fk_unid_ptit_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3569 (class 2606 OID 31323)
-- Dependencies: 3318 333 279 4035
-- Name: fk_unid_retu_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbrequisito_turma
    ADD CONSTRAINT fk_unid_retu_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3565 (class 2606 OID 31328)
-- Dependencies: 3318 333 277 4035
-- Name: fk_unid_rgav_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbregra_avaliacao
    ADD CONSTRAINT fk_unid_rgav_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3572 (class 2606 OID 31333)
-- Dependencies: 3318 333 281 4035
-- Name: fk_unid_sala_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbsala
    ADD CONSTRAINT fk_unid_sala_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3590 (class 2606 OID 31338)
-- Dependencies: 3318 333 293 4035
-- Name: fk_unid_stat_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbstatus
    ADD CONSTRAINT fk_unid_stat_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3575 (class 2606 OID 31343)
-- Dependencies: 3318 333 283 4035
-- Name: fk_unid_stbo_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbsituacao_boleto
    ADD CONSTRAINT fk_unid_stbo_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3578 (class 2606 OID 31348)
-- Dependencies: 3318 333 285 4035
-- Name: fk_unid_stcf_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbsituacao_caixa_funcionario
    ADD CONSTRAINT fk_unid_stcf_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3584 (class 2606 OID 31353)
-- Dependencies: 3318 333 289 4035
-- Name: fk_unid_stco_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbsituacao_parcela
    ADD CONSTRAINT fk_unid_stco_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3581 (class 2606 OID 31358)
-- Dependencies: 3318 333 287 4035
-- Name: fk_unid_stmo_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbsituacao_movimento
    ADD CONSTRAINT fk_unid_stmo_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3587 (class 2606 OID 31363)
-- Dependencies: 3318 333 291 4035
-- Name: fk_unid_sttu_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbsituacao_turma
    ADD CONSTRAINT fk_unid_sttu_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3597 (class 2606 OID 31368)
-- Dependencies: 3318 333 297 4035
-- Name: fk_unid_tcon_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtipo_convenio
    ADD CONSTRAINT fk_unid_tcon_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3660 (class 2606 OID 31373)
-- Dependencies: 3318 333 323 4035
-- Name: fk_unid_tdaq_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturma_disciplina_arquivo
    ADD CONSTRAINT fk_unid_tdaq_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3668 (class 2606 OID 31378)
-- Dependencies: 3318 333 327 4035
-- Name: fk_unid_tdav_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturma_disciplina_avaliacao
    ADD CONSTRAINT fk_unid_tdav_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3672 (class 2606 OID 31383)
-- Dependencies: 3318 333 329 4035
-- Name: fk_unid_tdma_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturma_disciplina_material
    ADD CONSTRAINT fk_unid_tdma_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3677 (class 2606 OID 31388)
-- Dependencies: 3318 333 331 4035
-- Name: fk_unid_tdpa_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturma_disciplina_planoaula
    ADD CONSTRAINT fk_unid_tdpa_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3603 (class 2606 OID 31393)
-- Dependencies: 3318 333 301 4035
-- Name: fk_unid_ties_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtipo_estorno
    ADD CONSTRAINT fk_unid_ties_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3612 (class 2606 OID 31398)
-- Dependencies: 3318 333 305 4035
-- Name: fk_unid_titu_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtitularidade
    ADD CONSTRAINT fk_unid_titu_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3600 (class 2606 OID 31403)
-- Dependencies: 3318 333 299 4035
-- Name: fk_unid_tpcu_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtipo_curso
    ADD CONSTRAINT fk_unid_tpcu_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3606 (class 2606 OID 31408)
-- Dependencies: 3318 333 302 4035
-- Name: fk_unid_tppr_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtipo_produto
    ADD CONSTRAINT fk_unid_tppr_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3609 (class 2606 OID 31413)
-- Dependencies: 3318 333 303 4035
-- Name: fk_unid_tpte_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtipo_telefone
    ADD CONSTRAINT fk_unid_tpte_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3621 (class 2606 OID 31418)
-- Dependencies: 3318 333 309 4035
-- Name: fk_unid_tral_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacao_aluno
    ADD CONSTRAINT fk_unid_tral_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3616 (class 2606 OID 31423)
-- Dependencies: 3318 333 307 4035
-- Name: fk_unid_tran_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacao
    ADD CONSTRAINT fk_unid_tran_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3626 (class 2606 OID 31428)
-- Dependencies: 3318 333 311 4035
-- Name: fk_unid_trco_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacao_convenio
    ADD CONSTRAINT fk_unid_trco_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3634 (class 2606 OID 31433)
-- Dependencies: 3318 333 315 4035
-- Name: fk_unid_trei_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtreinamento
    ADD CONSTRAINT fk_unid_trei_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3630 (class 2606 OID 31438)
-- Dependencies: 3318 333 313 4035
-- Name: fk_unid_trpr_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacao_produto
    ADD CONSTRAINT fk_unid_trpr_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3647 (class 2606 OID 31443)
-- Dependencies: 3318 333 319 4035
-- Name: fk_unid_tuco_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturma_convenio
    ADD CONSTRAINT fk_unid_tuco_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3655 (class 2606 OID 31448)
-- Dependencies: 3318 333 321 4035
-- Name: fk_unid_tudi_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturma_disciplina
    ADD CONSTRAINT fk_unid_tudi_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3664 (class 2606 OID 31453)
-- Dependencies: 3318 333 325 4035
-- Name: fk_unid_tudl_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturma_disciplina_aula
    ADD CONSTRAINT fk_unid_tudl_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3641 (class 2606 OID 31458)
-- Dependencies: 3318 333 317 4035
-- Name: fk_unid_turm_unalseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturma
    ADD CONSTRAINT fk_unid_turm_unalseq FOREIGN KEY (unalseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3642 (class 2606 OID 31463)
-- Dependencies: 3318 333 317 4035
-- Name: fk_unid_turm_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturma
    ADD CONSTRAINT fk_unid_turm_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3680 (class 2606 OID 31468)
-- Dependencies: 3318 333 333 4035
-- Name: fk_unid_unid_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbunidade
    ADD CONSTRAINT fk_unid_unid_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3683 (class 2606 OID 31473)
-- Dependencies: 3318 333 335 4035
-- Name: fk_unid_unpa_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbunidade_parametro
    ADD CONSTRAINT fk_unid_unpa_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3686 (class 2606 OID 31478)
-- Dependencies: 3318 333 337 4035
-- Name: fk_unid_usua_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbusuario
    ADD CONSTRAINT fk_unid_usua_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3689 (class 2606 OID 31483)
-- Dependencies: 3318 333 339 4035
-- Name: fk_unid_usup_unidseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbusuario_privilegio
    ADD CONSTRAINT fk_unid_usup_unidseq FOREIGN KEY (unidseq) REFERENCES dbunidade(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3339 (class 2606 OID 31488)
-- Dependencies: 3322 337 166 4035
-- Name: fk_usua_aldi_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbaluno_disciplina
    ADD CONSTRAINT fk_usua_aldi_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3344 (class 2606 OID 31493)
-- Dependencies: 3322 337 168 4035
-- Name: fk_usua_alrq_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbaluno_requisito
    ADD CONSTRAINT fk_usua_alrq_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3350 (class 2606 OID 31498)
-- Dependencies: 3322 337 170 4035
-- Name: fk_usua_also_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbaluno_solicitacao
    ADD CONSTRAINT fk_usua_also_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3333 (class 2606 OID 31503)
-- Dependencies: 3322 337 164 4035
-- Name: fk_usua_alun_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbaluno
    ADD CONSTRAINT fk_usua_alun_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3354 (class 2606 OID 31508)
-- Dependencies: 3322 337 174 4035
-- Name: fk_usua_arcu_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbarea_curso
    ADD CONSTRAINT fk_usua_arcu_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3359 (class 2606 OID 31513)
-- Dependencies: 3322 337 176 4035
-- Name: fk_usua_aval_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbavaliacao
    ADD CONSTRAINT fk_usua_aval_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3368 (class 2606 OID 31518)
-- Dependencies: 3322 337 182 4035
-- Name: fk_usua_boes_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbboleto_estrutura
    ADD CONSTRAINT fk_usua_boes_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3364 (class 2606 OID 31523)
-- Dependencies: 3322 337 180 4035
-- Name: fk_usua_bole_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbboleto
    ADD CONSTRAINT fk_usua_bole_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3380 (class 2606 OID 31528)
-- Dependencies: 3322 337 184 4035
-- Name: fk_usua_caix_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcaixa
    ADD CONSTRAINT fk_usua_caix_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3390 (class 2606 OID 31533)
-- Dependencies: 3322 337 188 4035
-- Name: fk_usua_carg_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcargo
    ADD CONSTRAINT fk_usua_carg_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3393 (class 2606 OID 31538)
-- Dependencies: 3322 337 190 4035
-- Name: fk_usua_ccdu_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcdu
    ADD CONSTRAINT fk_usua_ccdu_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3397 (class 2606 OID 31543)
-- Dependencies: 3322 337 192 4035
-- Name: fk_usua_cheq_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcheque
    ADD CONSTRAINT fk_usua_cheq_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3409 (class 2606 OID 31548)
-- Dependencies: 3322 337 198 4035
-- Name: fk_usua_code_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbconvenio_desconto
    ADD CONSTRAINT fk_usua_code_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3400 (class 2606 OID 31553)
-- Dependencies: 3322 337 194 4035
-- Name: fk_usua_cofi_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbconta_financeira
    ADD CONSTRAINT fk_usua_cofi_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3405 (class 2606 OID 31558)
-- Dependencies: 3322 337 196 4035
-- Name: fk_usua_conv_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbconvenio
    ADD CONSTRAINT fk_usua_conv_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3414 (class 2606 OID 31563)
-- Dependencies: 3322 337 200 4035
-- Name: fk_usua_cota_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcotacao
    ADD CONSTRAINT fk_usua_cota_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3534 (class 2606 OID 31568)
-- Dependencies: 3322 337 259 4035
-- Name: fk_usua_cpha_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpha
    ADD CONSTRAINT fk_usua_cpha_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3417 (class 2606 OID 31573)
-- Dependencies: 3322 337 202 4035
-- Name: fk_usua_curr_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcurriculo
    ADD CONSTRAINT fk_usua_curr_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3421 (class 2606 OID 31578)
-- Dependencies: 3322 337 204 4035
-- Name: fk_usua_curs_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcurso
    ADD CONSTRAINT fk_usua_curs_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3386 (class 2606 OID 31583)
-- Dependencies: 3322 337 186 4035
-- Name: fk_usua_cxfu_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbcaixa_funcionario
    ADD CONSTRAINT fk_usua_cxfu_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3424 (class 2606 OID 31588)
-- Dependencies: 3322 337 206 4035
-- Name: fk_usua_dema_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbdemanda
    ADD CONSTRAINT fk_usua_dema_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3429 (class 2606 OID 31593)
-- Dependencies: 3322 337 208 4035
-- Name: fk_usua_dept_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbdepartamento
    ADD CONSTRAINT fk_usua_dept_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3432 (class 2606 OID 31598)
-- Dependencies: 3322 337 210 4035
-- Name: fk_usua_disc_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbdisciplina
    ADD CONSTRAINT fk_usua_disc_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3437 (class 2606 OID 31603)
-- Dependencies: 3322 337 212 4035
-- Name: fk_usua_disi_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbdisciplina_similar
    ADD CONSTRAINT fk_usua_disi_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3440 (class 2606 OID 31608)
-- Dependencies: 3322 337 214 4035
-- Name: fk_usua_docu_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbdocumentos
    ADD CONSTRAINT fk_usua_docu_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3446 (class 2606 OID 31613)
-- Dependencies: 3322 337 218 4035
-- Name: fk_usua_ende_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbendereco
    ADD CONSTRAINT fk_usua_ende_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3452 (class 2606 OID 31618)
-- Dependencies: 3322 337 220 4035
-- Name: fk_usua_falt_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfalta
    ADD CONSTRAINT fk_usua_falt_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3455 (class 2606 OID 31623)
-- Dependencies: 3322 337 222 4035
-- Name: fk_usua_fecx_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfechamento_caixa
    ADD CONSTRAINT fk_usua_fecx_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3462 (class 2606 OID 31628)
-- Dependencies: 3322 337 225 4035
-- Name: fk_usua_fmpg_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbforma_pagamento
    ADD CONSTRAINT fk_usua_fmpg_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3595 (class 2606 OID 31633)
-- Dependencies: 3322 337 295 4035
-- Name: fk_usua_fone_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtelefone
    ADD CONSTRAINT fk_usua_fone_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3471 (class 2606 OID 31638)
-- Dependencies: 3322 337 229 4035
-- Name: fk_usua_fuoc_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfuncionario_ocorrencia
    ADD CONSTRAINT fk_usua_fuoc_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3476 (class 2606 OID 31643)
-- Dependencies: 3322 337 231 4035
-- Name: fk_usua_futr_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfuncionario_treinamento
    ADD CONSTRAINT fk_usua_futr_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3479 (class 2606 OID 31648)
-- Dependencies: 3322 337 233 4035
-- Name: fk_usua_gdav_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbgrade_avaliacao
    ADD CONSTRAINT fk_usua_gdav_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3484 (class 2606 OID 31653)
-- Dependencies: 3322 337 235 4035
-- Name: fk_usua_insc_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbinscricao
    ADD CONSTRAINT fk_usua_insc_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3494 (class 2606 OID 31658)
-- Dependencies: 3322 337 239 4035
-- Name: fk_usua_loli_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dblocacao_livro
    ADD CONSTRAINT fk_usua_loli_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3443 (class 2606 OID 31663)
-- Dependencies: 3322 337 216 4035
-- Name: fk_usua_mail_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbemail
    ADD CONSTRAINT fk_usua_mail_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3500 (class 2606 OID 31668)
-- Dependencies: 3322 337 241 4035
-- Name: fk_usua_nota_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbnota
    ADD CONSTRAINT fk_usua_nota_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3512 (class 2606 OID 31673)
-- Dependencies: 3322 337 247 4035
-- Name: fk_usua_paes_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbparcela_estorno
    ADD CONSTRAINT fk_usua_paes_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3506 (class 2606 OID 31678)
-- Dependencies: 3322 337 245 4035
-- Name: fk_usua_parc_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbparcela
    ADD CONSTRAINT fk_usua_parc_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3490 (class 2606 OID 31683)
-- Dependencies: 3322 337 237 4035
-- Name: fk_usua_patl_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dblivro
    ADD CONSTRAINT fk_usua_patl_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3518 (class 2606 OID 31688)
-- Dependencies: 3322 337 249 4035
-- Name: fk_usua_patr_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpatrimonio
    ADD CONSTRAINT fk_usua_patr_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3521 (class 2606 OID 31693)
-- Dependencies: 3322 337 251 4035
-- Name: fk_usua_pess_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoa
    ADD CONSTRAINT fk_usua_pess_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3524 (class 2606 OID 31698)
-- Dependencies: 3322 337 253 4035
-- Name: fk_usua_pfis_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoa_fisica
    ADD CONSTRAINT fk_usua_pfis_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3467 (class 2606 OID 31703)
-- Dependencies: 3322 337 227 4035
-- Name: fk_usua_pfun_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbfuncionario
    ADD CONSTRAINT fk_usua_pfun_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3563 (class 2606 OID 31708)
-- Dependencies: 3322 337 273 4035
-- Name: fk_usua_pjcd_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprojeto_curso_disciplina
    ADD CONSTRAINT fk_usua_pjcd_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3558 (class 2606 OID 31713)
-- Dependencies: 3322 337 271 4035
-- Name: fk_usua_pjcu_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprojeto_curso
    ADD CONSTRAINT fk_usua_pjcu_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3527 (class 2606 OID 31718)
-- Dependencies: 3322 337 255 4035
-- Name: fk_usua_pjur_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoa_juridica
    ADD CONSTRAINT fk_usua_pjur_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3537 (class 2606 OID 31723)
-- Dependencies: 3322 337 261 4035
-- Name: fk_usua_plco_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbplano_conta
    ADD CONSTRAINT fk_usua_plco_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3540 (class 2606 OID 31728)
-- Dependencies: 3322 337 263 4035
-- Name: fk_usua_prac_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprocesso_academico
    ADD CONSTRAINT fk_usua_prac_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3552 (class 2606 OID 31733)
-- Dependencies: 3322 337 269 4035
-- Name: fk_usua_prar_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprofessor_area
    ADD CONSTRAINT fk_usua_prar_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3544 (class 2606 OID 31738)
-- Dependencies: 3322 337 265 4035
-- Name: fk_usua_prod_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbproduto
    ADD CONSTRAINT fk_usua_prod_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3547 (class 2606 OID 31743)
-- Dependencies: 3322 337 267 4035
-- Name: fk_usua_prof_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbprofessor
    ADD CONSTRAINT fk_usua_prof_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3531 (class 2606 OID 31748)
-- Dependencies: 3322 337 257 4035
-- Name: fk_usua_ptit_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbpessoa_titularidade
    ADD CONSTRAINT fk_usua_ptit_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3570 (class 2606 OID 31753)
-- Dependencies: 3322 337 279 4035
-- Name: fk_usua_retu_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbrequisito_turma
    ADD CONSTRAINT fk_usua_retu_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3566 (class 2606 OID 31758)
-- Dependencies: 3322 337 277 4035
-- Name: fk_usua_rgav_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbregra_avaliacao
    ADD CONSTRAINT fk_usua_rgav_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3573 (class 2606 OID 31763)
-- Dependencies: 3322 337 281 4035
-- Name: fk_usua_sala_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbsala
    ADD CONSTRAINT fk_usua_sala_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3591 (class 2606 OID 31768)
-- Dependencies: 3322 337 293 4035
-- Name: fk_usua_stat_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbstatus
    ADD CONSTRAINT fk_usua_stat_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3576 (class 2606 OID 31773)
-- Dependencies: 3322 337 283 4035
-- Name: fk_usua_stbo_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbsituacao_boleto
    ADD CONSTRAINT fk_usua_stbo_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3579 (class 2606 OID 31778)
-- Dependencies: 3322 337 285 4035
-- Name: fk_usua_stcf_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbsituacao_caixa_funcionario
    ADD CONSTRAINT fk_usua_stcf_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3585 (class 2606 OID 31783)
-- Dependencies: 3322 337 289 4035
-- Name: fk_usua_stco_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbsituacao_parcela
    ADD CONSTRAINT fk_usua_stco_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3582 (class 2606 OID 31788)
-- Dependencies: 3322 337 287 4035
-- Name: fk_usua_stmo_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbsituacao_movimento
    ADD CONSTRAINT fk_usua_stmo_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3588 (class 2606 OID 31793)
-- Dependencies: 3322 337 291 4035
-- Name: fk_usua_sttu_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbsituacao_turma
    ADD CONSTRAINT fk_usua_sttu_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3598 (class 2606 OID 31798)
-- Dependencies: 3322 337 297 4035
-- Name: fk_usua_tcon_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtipo_convenio
    ADD CONSTRAINT fk_usua_tcon_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3665 (class 2606 OID 31803)
-- Dependencies: 3322 337 325 4035
-- Name: fk_usua_tdal_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturma_disciplina_aula
    ADD CONSTRAINT fk_usua_tdal_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3661 (class 2606 OID 31808)
-- Dependencies: 3322 337 323 4035
-- Name: fk_usua_tdar_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturma_disciplina_arquivo
    ADD CONSTRAINT fk_usua_tdar_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3669 (class 2606 OID 31813)
-- Dependencies: 3322 337 327 4035
-- Name: fk_usua_tdav_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturma_disciplina_avaliacao
    ADD CONSTRAINT fk_usua_tdav_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3673 (class 2606 OID 31818)
-- Dependencies: 3322 337 329 4035
-- Name: fk_usua_tdma_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturma_disciplina_material
    ADD CONSTRAINT fk_usua_tdma_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3678 (class 2606 OID 31823)
-- Dependencies: 3322 337 331 4035
-- Name: fk_usua_tdpa_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturma_disciplina_planoaula
    ADD CONSTRAINT fk_usua_tdpa_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3604 (class 2606 OID 31828)
-- Dependencies: 3322 337 301 4035
-- Name: fk_usua_ties_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtipo_estorno
    ADD CONSTRAINT fk_usua_ties_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3613 (class 2606 OID 31833)
-- Dependencies: 3322 337 305 4035
-- Name: fk_usua_titu_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtitularidade
    ADD CONSTRAINT fk_usua_titu_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3601 (class 2606 OID 31838)
-- Dependencies: 3322 337 299 4035
-- Name: fk_usua_tpcu_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtipo_curso
    ADD CONSTRAINT fk_usua_tpcu_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3607 (class 2606 OID 31843)
-- Dependencies: 3322 337 302 4035
-- Name: fk_usua_tppr_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtipo_produto
    ADD CONSTRAINT fk_usua_tppr_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3610 (class 2606 OID 31848)
-- Dependencies: 3322 337 303 4035
-- Name: fk_usua_tpte_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtipo_telefone
    ADD CONSTRAINT fk_usua_tpte_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3622 (class 2606 OID 31853)
-- Dependencies: 3322 337 309 4035
-- Name: fk_usua_tral_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacao_aluno
    ADD CONSTRAINT fk_usua_tral_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3617 (class 2606 OID 31858)
-- Dependencies: 3322 337 307 4035
-- Name: fk_usua_tran_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacao
    ADD CONSTRAINT fk_usua_tran_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3627 (class 2606 OID 31863)
-- Dependencies: 3322 337 311 4035
-- Name: fk_usua_trco_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacao_convenio
    ADD CONSTRAINT fk_usua_trco_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3635 (class 2606 OID 31868)
-- Dependencies: 3322 337 315 4035
-- Name: fk_usua_trei_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtreinamento
    ADD CONSTRAINT fk_usua_trei_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3631 (class 2606 OID 31873)
-- Dependencies: 3322 337 313 4035
-- Name: fk_usua_trpr_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbtransacao_produto
    ADD CONSTRAINT fk_usua_trpr_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3648 (class 2606 OID 31878)
-- Dependencies: 3322 337 319 4035
-- Name: fk_usua_tuco_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturma_convenio
    ADD CONSTRAINT fk_usua_tuco_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3656 (class 2606 OID 31883)
-- Dependencies: 3322 337 321 4035
-- Name: fk_usua_tudi_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturma_disciplina
    ADD CONSTRAINT fk_usua_tudi_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3643 (class 2606 OID 31888)
-- Dependencies: 3322 337 317 4035
-- Name: fk_usua_turm_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbturma
    ADD CONSTRAINT fk_usua_turm_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3681 (class 2606 OID 31893)
-- Dependencies: 3322 337 333 4035
-- Name: fk_usua_unid_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbunidade
    ADD CONSTRAINT fk_usua_unid_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3684 (class 2606 OID 31898)
-- Dependencies: 3322 337 335 4035
-- Name: fk_usua_unpa_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbunidade_parametro
    ADD CONSTRAINT fk_usua_unpa_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3687 (class 2606 OID 31903)
-- Dependencies: 3322 337 337 4035
-- Name: fk_usua_usua_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbusuario
    ADD CONSTRAINT fk_usua_usua_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3690 (class 2606 OID 31908)
-- Dependencies: 3322 337 339 4035
-- Name: fk_usua_usup_usuaseq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dbusuario_privilegio
    ADD CONSTRAINT fk_usua_usup_usuaseq FOREIGN KEY (usuaseq) REFERENCES dbusuario(seq) ON UPDATE RESTRICT ON DELETE RESTRICT;


-- Completed on 2013-11-28 12:02:35 BRST

--
-- PostgreSQL database dump complete
--

