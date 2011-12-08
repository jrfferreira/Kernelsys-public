<?php 
/**
 * 
 * @author Wagner
 *
 */

class fileMap{
	
	public $classes = array();
	
	/**
	 * 
	 */
	public function __construct(){
		
		$this->classes[2] = '../../classes/app.widgets/TAbas.class.php';
		$this->classes[3] = '../../classes/app.widgets/TAction.class.php';
		$this->classes[4] = '../../classes/app.widgets/TBarCode.class.php';
		$this->classes[5] = '../../classes/app.widgets/TButton.class.php';
		$this->classes[6] = '../../classes/app.widgets/TButtonImg.class.php';
		$this->classes[7] = '../../classes/app.widgets/TChart.class.php';
		$this->classes[8] = '../../classes/app.widgets/TCheckButton.class.php';
		$this->classes[9] = '../../classes/app.widgets/TCheckGroup.class.php';
		$this->classes[10] = '../../classes/app.widgets/TClassJQuery.class.php';
		$this->classes[11] = '../../classes/app.widgets/TCombo.class.php';
		$this->classes[12] = '../../classes/app.widgets/TCookie.class.php';
		$this->classes[13] = '../../classes/app.widgets/TDataGrid.class.php';
		$this->classes[14] = '../../classes/app.widgets/TDataGridAction.class.php';
		$this->classes[15] = '../../classes/app.widgets/TDataGridColumn.class.php';
		$this->classes[16] = '../../classes/app.widgets/TElement.class.php';
		$this->classes[17] = '../../classes/app.widgets/TEntry.class.php';
		$this->classes[18] = '../../classes/app.widgets/TField.class.php';
		$this->classes[19] = '../../classes/app.widgets/TFile.class.php';
		$this->classes[20] = '../../classes/app.widgets/TForm.class.php';
		$this->classes[21] = '../../classes/app.widgets/TFrame.class.php';
		$this->classes[22] = '../../classes/app.widgets/TFrameFile.class.php';
		$this->classes[23] = '../../classes/app.widgets/TGDImage.class.php';
		$this->classes[24] = '../../classes/app.widgets/THidden.class.php';
		$this->classes[25] = '../../classes/app.widgets/TIcon.class.php';
		$this->classes[26] = '../../classes/app.widgets/TImage.class.php';
		$this->classes[27] = '../../classes/app.widgets/TLabel.class.php';
		$this->classes[28] = '../../classes/app.widgets/TMessage.class.php';
		$this->classes[29] = '../../classes/app.widgets/TMultiSelect.class.php';
		$this->classes[30] = '../../classes/app.widgets/TPage.class.php';
		$this->classes[31] = '../../classes/app.widgets/TPanel.class.php';
		$this->classes[32] = '../../classes/app.widgets/TPassword.class.php';
		$this->classes[33] = '../../classes/app.widgets/TQuestion.class.php';
		$this->classes[34] = '../../classes/app.widgets/TRadioButton.class.php';
		$this->classes[35] = '../../classes/app.widgets/TRadioGroup.class.php';
		$this->classes[36] = '../../classes/app.widgets/TSeparator.class.php';
		$this->classes[37] = '../../classes/app.widgets/TSession.class.php';
		$this->classes[38] = '../../classes/app.widgets/TSetAbas.class.php';
		$this->classes[39] = '../../classes/app.widgets/TSetPainel.class.php';
		$this->classes[40] = '../../classes/app.widgets/TStyle.class.php';
		$this->classes[41] = '../../classes/app.widgets/TTable.class.php';
		$this->classes[42] = '../../classes/app.widgets/TTableCell.class.php';
		$this->classes[43] = '../../classes/app.widgets/TTableRow.class.php';
		$this->classes[44] = '../../classes/app.widgets/TText.class.php';
		$this->classes[45] = '../../classes/app.widgets/TTranslation.class.php';
		$this->classes[46] = '../../classes/app.widgets/TViews.class.php';
		$this->classes[47] = '../../classes/app.widgets/TWindow.class.php';
		$this->classes[48] = '../../classes/app.widgets/TWindowPesq.class.php';
		$this->classes[49] = '../../classes/app.view/app.ui/TClassJQuery.class.php';
		$this->classes[50] = '../../classes/app.view/app.custon/TSetCuston.class.php';
		$this->classes[51] = '../../classes/app.krs/TForms.class.php';
		$this->classes[52] = '../../classes/app.krs/TBloco.class.php';
		$this->classes[53] = '../../classes/app.krs/TCompForm.class.php';
		$this->classes[54] = '../../classes/app.krs/TCompLista.class.php';
		//$this->classes[55] = '../../classes/app.krs/TCompSql.class.php';
		$this->classes[56] = '../../classes/app.view/TExecs.class.php';
		//$this->classes[57] = '../../classes/app.krs/TInfoForm.class.php';
		$this->classes[58] = '../../classes/app.view/TInterface.class.php';
		$this->classes[59] = '../../classes/app.view/TMenu.class.php';
		$this->classes[60] = '../../classes/app.view/TRodape.class.php';
		$this->classes[61] = '../../classes/app.krs/TSetAction.class.php';
		$this->classes[62] = '../../classes/app.krs/TSetCampo.class.php';
		$this->classes[63] = '../../classes/app.krs/TSetPesquisa.class.php';
		$this->classes[64] = '../../classes/app.krs/TSetfields.class.php';
		$this->classes[65] = '../../classes/app.krs/TSetlista.class.php';
		$this->classes[66] = '../../classes/app.krs/campos_x_propriedadesRecord.class.php';
		$this->classes[67] = '../../classes/app.krs/formsRecord.class.php';
		$this->classes[68] = '../../classes/app.util/TAlocaDados.class.php';
		$this->classes[69] = '../../classes/app.util/TApendices.class.php';
		$this->classes[70] = '../../classes/app.util/TCloneForm.class.php';
		$this->classes[71] = '../../classes/app.util/TEmail.class.php';
		$this->classes[72] = '../../classes/app.util/TFiltrosList.class.php';
		$this->classes[73] = '../../classes/app.util/TMensagem.class.php';
		$this->classes[74] = '../../classes/app.util/TPath.class.php';
		$this->classes[75] = '../../classes/app.util/TPopulaCampo.class.php';
		$this->classes[76] = '../../classes/app.util/TRequest.class.php';
		$this->classes[77] = '../../classes/app.util/TSetData.class.php';
		$this->classes[78] = '../../classes/app.util/TSetHeader.class.php';
		$this->classes[79] = '../../classes/app.util/TSetMascaras.class.php';
		$this->classes[80] = '../../classes/app.util/TSetPdf.class.php';
		$this->classes[81] = '../../classes/app.util/TStatus.class.php';
		$this->classes[82] = '../../classes/app.util/TUpload.class.php';
		$this->classes[83] = '../../classes/app.util/TValidaCampo.class.php';
		$this->classes[84] = '../../classes/app.util/TXml.class.php';
		$this->classes[85] = '../../classes/app.util/autoload.class.php';
		$this->classes[86] = '../../classes/app.util/setException.class.php';
		$this->classes[87] = '../../classes/app.util/setSomaTotal.class.php';
		$this->classes[88] = '../../classes/app.util/setTipoForm.class.php';
		$this->classes[89] = '../../classes/app.nfe/TNFeModel.class.php';
		$this->classes[90] = '../../classes/app.nfe/TNFeWsdl.class.php';
		$this->classes[91] = '../../classes/app.nfe/danfe.class.php';
		$this->classes[92] = '../../classes/app.model/financeiro/TCaixa.class.php';
		$this->classes[93] = '../../classes/app.model/financeiro/TConciliacaoCaixa.class.php';
		$this->classes[94] = '../../classes/app.model/financeiro/TConvenios.class.php';
		$this->classes[95] = '../../classes/app.model/financeiro/TFechaCaixa.class.php';
		$this->classes[96] = '../../classes/app.model/financeiro/TSetBoleto.class.php';
		$this->classes[97] = '../../classes/app.model/financeiro/TTransacao.class.php';
		$this->classes[98] = '../../classes/app.model/educacional/TAluno.class.php';
		$this->classes[99] = '../../classes/app.model/educacional/TAvaliacao.class.php';
		$this->classes[100] = '../../classes/app.model/educacional/TBiblioteca.class.php';
		$this->classes[101] = '../../classes/app.model/educacional/TCurso.class.php';
		$this->classes[102] = '../../classes/app.model/educacional/TDisciplina.class.php';
		$this->classes[103] = '../../classes/app.model/educacional/TInscricao.class.php';
		$this->classes[104] = '../../classes/app.model/educacional/TLivro.class.php';
		$this->classes[105] = '../../classes/app.model/educacional/TMatricula.class.php';
		$this->classes[106] = '../../classes/app.model/educacional/TProcessoAcademico.class.php';
		$this->classes[107] = '../../classes/app.model/educacional/TProfessor.class.php';
		$this->classes[108] = '../../classes/app.model/educacional/TSecretaria.class.php';
		$this->classes[109] = '../../classes/app.model/educacional/TSolicitacao.class.php';
		$this->classes[110] = '../../classes/app.model/educacional/TTurma.class.php';
		$this->classes[111] = '../../classes/app.model/educacional/TTurmaDisciplinas.class.php';
		$this->classes[112] = '../../classes/app.model/TEtiquetas.class.php';
		$this->classes[113] = '../../classes/app.model/TPessoa.class.php';
		$this->classes[114] = '../../classes/app.model/TProduto.class.php';
		$this->classes[115] = '../../classes/app.model/TUnidade.class.php';
		$this->classes[116] = '../../classes/app.model/TVoice.class.php';
		$this->classes[117] = '../../classes/app.lib/pchart/TChartCore.class.php';
		$this->classes[118] = '../../classes/app.lib/pchart/TChartData.class.php';
		$this->classes[119] = '../../classes/app.lib/fpdf/createpdf.class.php';
		$this->classes[120] = '../../classes/app.lib/fpdf/fpdf.class.php';
		$this->classes[121] = '../../classes/app.lib/fpdf/ufpdf.class.php';
		$this->classes[122] = '../../classes/app.js/includesUI.class.php';
		$this->classes[123] = '../../classes/app.js/loadJs.class.php';
		$this->classes[124] = '../../classes/app.dbo/TConnection.class.php';
		$this->classes[125] = '../../classes/app.dbo/TConstantes.class.php';
		$this->classes[126] = '../../classes/app.dbo/TCriteria.class.php';
		$this->classes[127] = '../../classes/app.dbo/TDados.class.php';
		$this->classes[128] = '../../classes/app.dbo/TDbo.class.php';
		$this->classes[129] = '../../classes/app.dbo/TDbo_kernelsys.class.php';
		$this->classes[130] = '../../classes/app.dbo/TDbo_out.class.php';
		$this->classes[131] = '../../classes/app.dbo/TError.class.php';
		$this->classes[132] = '../../classes/app.dbo/TExeSql.class.php';
		$this->classes[133] = '../../classes/app.dbo/TExpression.class.php';
		$this->classes[134] = '../../classes/app.dbo/TFilter.class.php';
		$this->classes[135] = '../../classes/app.dbo/TLogger.class.php';
		$this->classes[136] = '../../classes/app.dbo/TLoggerHTML.class.php';
		$this->classes[137] = '../../classes/app.dbo/TLoggerTXT.class.php';
		$this->classes[138] = '../../classes/app.dbo/TLoggerXML.class.php';
		$this->classes[139] = '../../classes/app.dbo/TRecord.class.php';
		$this->classes[140] = '../../classes/app.dbo/TRepository.class.php';
		$this->classes[141] = '../../classes/app.dbo/TSqlDelete.class.php';
		$this->classes[142] = '../../classes/app.dbo/TSqlInsert.class.php';
		$this->classes[143] = '../../classes/app.dbo/TSqlInstruction.class.php';
		$this->classes[144] = '../../classes/app.dbo/TSqlSelect.class.php';
		$this->classes[145] = '../../classes/app.dbo/TSqlUpdate.class.php';
		$this->classes[146] = '../../classes/app.dbo/TTransaction.class.php';
		$this->classes[147] = '../../classes/app.dbo/geraCodigo.class.php';
		$this->classes[148] = '../../classes/app.control/app.util/setAluno.class.php';
		$this->classes[149] = '../../classes/app.control/app.util/setDepartamento.class.php';
		$this->classes[150] = '../../classes/app.control/app.util/setDisc.class.php';
		$this->classes[151] = '../../classes/app.control/app.util/setProfessor.class.php';
		$this->classes[152] = '../../classes/app.control/app.util/setTipoMov.class.php';
		$this->classes[153] = '../../classes/app.control/app.util/setTurmaDisciplina.class.php';
		$this->classes[154] = '../../classes/app.control/app.util/viewCurso.class.php';
		$this->classes[155] = '../../classes/app.control/app.scorecard/TScoreCard.class.php';
		$this->classes[156] = '../../classes/app.control/app.financeiro/relatorioCaixaD.class.php';
		$this->classes[157] = '../../classes/app.control/app.financeiro/relatorioCaixaR.class.php';
		$this->classes[158] = '../../classes/app.control/app.financeiro/setComprovante.class.php';
		$this->classes[159] = '../../classes/app.control/app.financeiro/setCriterioFolhaPag.class.php';
		$this->classes[160] = '../../classes/app.control/app.financeiro/setDataBP.class.php';
		$this->classes[161] = '../../classes/app.control/app.financeiro/setPeriodoDRE.class.php';
		$this->classes[162] = '../../classes/app.control/app.financeiro/viewBPatrimonial.class.php';
		$this->classes[163] = '../../classes/app.control/app.financeiro/viewDRE.class.php';
		$this->classes[164] = '../../classes/app.control/app.contratos/setDocumento.class.php';
		$this->classes[165] = '../../classes/app.control/app.alunos/TUserAluno.class.php';
		$this->classes[166] = '../../classes/app.control/app.alunos/viewArquivos.class.php';
		$this->classes[167] = '../../classes/app.control/app.alunos/viewDuplicatas.class.php';
		$this->classes[168] = '../../classes/app.control/app.alunos/viewHistAcadem.class.php';
		$this->classes[169] = '../../classes/app.control/app.alunos/viewOrientacoes.class.php';
		$this->classes[170] = '../../classes/app.control/TSetControl.class.php';
		$this->classes[171] = '../../classes/app.control/TSetModel.class.php';
		$this->classes[172] = '../../classes/app.access/TActionIn.class.php';
		$this->classes[173] = '../../classes/app.access/TCheckLogin.class.php';
		$this->classes[174] = '../../classes/app.access/TGetPrivilegio.class.php';
		$this->classes[175] = '../../classes/app.access/TLogout.class.php';
		$this->classes[176] = '../../classes/app.access/TOccupant.class.php';
		$this->classes[177] = '../../classes/app.access/TPrivilegios.class.php';
		$this->classes[178] = '../../classes/app.access/TSetPrivilegios.class.php';
		$this->classes[179] = '../../classes/app.access/TSetUnidade.class.php';
		$this->classes[180] = '../../classes/app.access/TSetlogin.class.php';
		$this->classes[181] = '../../classes/app.access/TShowPrivilegios.class.php';
		$this->classes[182] = '../../classes/app.access/TUsuario.class.php';
		
	}
	
	/**
	 * 
	 */
    public function getClasses(){ 
        return $this->classes; 
    }

}
?>