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
		
		$this->classes[] = '../../classes/app.widgets/TAbas.class.php';
		$this->classes[] = '../../classes/app.widgets/TAction.class.php';
		$this->classes[] = '../../classes/app.widgets/TBarCode.class.php';
		$this->classes[] = '../../classes/app.widgets/TButton.class.php';
		$this->classes[] = '../../classes/app.widgets/TButtonImg.class.php';
		$this->classes[] = '../../classes/app.widgets/TChart.class.php';
		$this->classes[] = '../../classes/app.widgets/TCheckButton.class.php';
		$this->classes[] = '../../classes/app.widgets/TCheckGroup.class.php';
		$this->classes[] = '../../classes/app.widgets/TClassJQuery.class.php';
		$this->classes[] = '../../classes/app.widgets/TCombo.class.php';
		$this->classes[] = '../../classes/app.widgets/TCookie.class.php';
		$this->classes[] = '../../classes/app.widgets/TDataGrid.class.php';
		$this->classes[] = '../../classes/app.widgets/TDataGridAction.class.php';
		$this->classes[] = '../../classes/app.widgets/TDataGridColumn.class.php';
		$this->classes[] = '../../classes/app.widgets/TElement.class.php';
		$this->classes[] = '../../classes/app.widgets/TEntry.class.php';
		$this->classes[] = '../../classes/app.widgets/TField.class.php';
		$this->classes[] = '../../classes/app.widgets/TFile.class.php';
		$this->classes[] = '../../classes/app.widgets/TForm.class.php';
		$this->classes[] = '../../classes/app.widgets/TFrame.class.php';
		$this->classes[] = '../../classes/app.widgets/TFrameFile.class.php';
		$this->classes[] = '../../classes/app.widgets/TGDImage.class.php';
		$this->classes[] = '../../classes/app.widgets/THidden.class.php';
		$this->classes[] = '../../classes/app.widgets/TIcon.class.php';
		$this->classes[] = '../../classes/app.widgets/TImage.class.php';
		$this->classes[] = '../../classes/app.widgets/TLabel.class.php';
		$this->classes[] = '../../classes/app.widgets/TMessage.class.php';
		$this->classes[] = '../../classes/app.widgets/TMultiSelect.class.php';
		$this->classes[] = '../../classes/app.widgets/TPage.class.php';
		$this->classes[] = '../../classes/app.widgets/TPanel.class.php';
		$this->classes[] = '../../classes/app.widgets/TPassword.class.php';
		$this->classes[] = '../../classes/app.widgets/TQuestion.class.php';
		$this->classes[] = '../../classes/app.widgets/TRadioButton.class.php';
		$this->classes[] = '../../classes/app.widgets/TRadioGroup.class.php';
		$this->classes[] = '../../classes/app.widgets/TSeparator.class.php';
		$this->classes[] = '../../classes/app.widgets/TSession.class.php';
		$this->classes[] = '../../classes/app.widgets/TSetAbas.class.php';
		$this->classes[] = '../../classes/app.widgets/TSetPainel.class.php';
		$this->classes[] = '../../classes/app.widgets/TStyle.class.php';
		$this->classes[] = '../../classes/app.widgets/TTable.class.php';
		$this->classes[] = '../../classes/app.widgets/TTableCell.class.php';
		$this->classes[] = '../../classes/app.widgets/TTableRow.class.php';
		$this->classes[] = '../../classes/app.widgets/TText.class.php';
		$this->classes[] = '../../classes/app.widgets/TTranslation.class.php';
		$this->classes[] = '../../classes/app.widgets/TViews.class.php';
		$this->classes[] = '../../classes/app.widgets/TWindow.class.php';
		$this->classes[] = '../../classes/app.widgets/TWindowPesq.class.php';
		$this->classes[] = '../../classes/app.view/app.ui/TClassJQuery.class.php';
		$this->classes[] = '../../classes/app.view/app.custon/TSetCuston.class.php';
		$this->classes[] = '../../classes/app.krs/TForms.class.php';
		$this->classes[] = '../../classes/app.krs/TBloco.class.php';
		$this->classes[] = '../../classes/app.krs/TCompForm.class.php';
		$this->classes[] = '../../classes/app.krs/TCompLista.class.php';
		//$this->classes[] = '../../classes/app.krs/TCompSql.class.php';
		$this->classes[] = '../../classes/app.view/TExecs.class.php';
		//$this->classes[] = '../../classes/app.krs/TInfoForm.class.php';
		$this->classes[] = '../../classes/app.view/TInterface.class.php';
		$this->classes[] = '../../classes/app.view/TMenu.class.php';
		$this->classes[] = '../../classes/app.view/TRodape.class.php';
		$this->classes[] = '../../classes/app.krs/TSetAction.class.php';
		$this->classes[] = '../../classes/app.krs/TSetCampo.class.php';
		$this->classes[] = '../../classes/app.krs/TSetPesquisa.class.php';
		$this->classes[] = '../../classes/app.krs/TSetfields.class.php';
		$this->classes[] = '../../classes/app.krs/TSetlista.class.php';
		$this->classes[] = '../../classes/app.krs/campos_x_propriedadesRecord.class.php';
		$this->classes[] = '../../classes/app.krs/formsRecord.class.php';
		$this->classes[] = '../../classes/app.util/TAlocaDados.class.php';
		$this->classes[] = '../../classes/app.util/TApendices.class.php';
		$this->classes[] = '../../classes/app.util/TCloneForm.class.php';
		$this->classes[] = '../../classes/app.util/TEmail.class.php';
		$this->classes[] = '../../classes/app.util/TFiltrosList.class.php';
		$this->classes[] = '../../classes/app.util/TMensagem.class.php';
		$this->classes[] = '../../classes/app.util/TPath.class.php';
		$this->classes[] = '../../classes/app.util/TPopulaCampo.class.php';
		$this->classes[] = '../../classes/app.util/TRequest.class.php';
		$this->classes[] = '../../classes/app.util/TSetData.class.php';
		$this->classes[] = '../../classes/app.util/TSetHeader.class.php';
		$this->classes[] = '../../classes/app.util/TSetMascaras.class.php';
		$this->classes[] = '../../classes/app.util/TSetPdf.class.php';
		$this->classes[] = '../../classes/app.util/TStatus.class.php';
		$this->classes[] = '../../classes/app.util/TUpload.class.php';
		$this->classes[] = '../../classes/app.util/TValidaCampo.class.php';
		$this->classes[] = '../../classes/app.util/TXml.class.php';
		$this->classes[] = '../../classes/app.util/autoload.class.php';
		$this->classes[] = '../../classes/app.util/setException.class.php';
		$this->classes[] = '../../classes/app.util/setSomaTotal.class.php';
		$this->classes[] = '../../classes/app.util/setTipoForm.class.php';
		$this->classes[] = '../../classes/app.nfe/TNFeModel.class.php';
		$this->classes[] = '../../classes/app.nfe/TNFeWsdl.class.php';
		$this->classes[] = '../../classes/app.nfe/danfe.class.php';
		$this->classes[] = '../../classes/app.model/financeiro/TCaixa.class.php';
		$this->classes[] = '../../classes/app.model/financeiro/TConciliacaoCaixa.class.php';
		$this->classes[] = '../../classes/app.model/financeiro/TConvenios.class.php';
		$this->classes[] = '../../classes/app.model/financeiro/TFechaCaixa.class.php';
		$this->classes[] = '../../classes/app.model/financeiro/TSetBoleto.class.php';
		$this->classes[] = '../../classes/app.model/financeiro/TTransacao.class.php';
		$this->classes[] = '../../classes/app.model/educacional/TAluno.class.php';
		$this->classes[] = '../../classes/app.model/educacional/TAvaliacao.class.php';
		$this->classes[] = '../../classes/app.model/educacional/TBiblioteca.class.php';
		$this->classes[] = '../../classes/app.model/educacional/TCurso.class.php';
		$this->classes[] = '../../classes/app.model/educacional/TDisciplina.class.php';
		$this->classes[] = '../../classes/app.model/educacional/TInscricao.class.php';
		$this->classes[] = '../../classes/app.model/educacional/TLivro.class.php';
		$this->classes[] = '../../classes/app.model/educacional/TMatricula.class.php';
		$this->classes[] = '../../classes/app.model/educacional/TProcessoAcademico.class.php';
		$this->classes[] = '../../classes/app.model/educacional/TProfessor.class.php';
		$this->classes[] = '../../classes/app.model/educacional/TSecretaria.class.php';
		$this->classes[] = '../../classes/app.model/educacional/TSolicitacao.class.php';
		$this->classes[] = '../../classes/app.model/educacional/TTurma.class.php';
		$this->classes[] = '../../classes/app.model/educacional/TTurmaDisciplinas.class.php';
		$this->classes[] = '../../classes/app.model/TEtiquetas.class.php';
		$this->classes[] = '../../classes/app.model/TPessoa.class.php';
		$this->classes[] = '../../classes/app.model/TProduto.class.php';
		$this->classes[] = '../../classes/app.model/TUnidade.class.php';
		$this->classes[] = '../../classes/app.model/TVoice.class.php';
		$this->classes[] = '../../classes/app.lib/pchart/TChartCore.class.php';
		$this->classes[] = '../../classes/app.lib/pchart/TChartData.class.php';
		$this->classes[] = '../../classes/app.lib/fpdf/createpdf.class.php';
		$this->classes[] = '../../classes/app.lib/fpdf/fpdf.class.php';
		$this->classes[] = '../../classes/app.lib/fpdf/ufpdf.class.php';
		$this->classes[] = '../../classes/app.js/includesUI.class.php';
		$this->classes[] = '../../classes/app.js/loadJs.class.php';
		$this->classes[] = '../../classes/app.dbo/TConnection.class.php';
		$this->classes[] = '../../classes/app.dbo/TConstantes.class.php';
		$this->classes[] = '../../classes/app.dbo/TCriteria.class.php';
		$this->classes[] = '../../classes/app.dbo/TDados.class.php';
		$this->classes[] = '../../classes/app.dbo/TDbo.class.php';
		$this->classes[] = '../../classes/app.dbo/TDbo_kernelsys.class.php';
		$this->classes[] = '../../classes/app.dbo/TDbo_out.class.php';
		$this->classes[] = '../../classes/app.dbo/TError.class.php';
		$this->classes[] = '../../classes/app.dbo/TExeSql.class.php';
		$this->classes[] = '../../classes/app.dbo/TExpression.class.php';
		$this->classes[] = '../../classes/app.dbo/TFilter.class.php';
		$this->classes[] = '../../classes/app.dbo/TLogger.class.php';
		$this->classes[] = '../../classes/app.dbo/TLoggerHTML.class.php';
		$this->classes[] = '../../classes/app.dbo/TLoggerTXT.class.php';
		$this->classes[] = '../../classes/app.dbo/TLoggerXML.class.php';
		$this->classes[] = '../../classes/app.dbo/TRecord.class.php';
		$this->classes[] = '../../classes/app.dbo/TRepository.class.php';
		$this->classes[] = '../../classes/app.dbo/TSqlDelete.class.php';
		$this->classes[] = '../../classes/app.dbo/TSqlInsert.class.php';
		$this->classes[] = '../../classes/app.dbo/TSqlInstruction.class.php';
		$this->classes[] = '../../classes/app.dbo/TSqlSelect.class.php';
		$this->classes[] = '../../classes/app.dbo/TSqlUpdate.class.php';
		$this->classes[] = '../../classes/app.dbo/TTransaction.class.php';
		$this->classes[] = '../../classes/app.dbo/geraCodigo.class.php';
		$this->classes[] = '../../classes/app.control/app.util/setAluno.class.php';
		$this->classes[] = '../../classes/app.control/app.util/setDepartamento.class.php';
		$this->classes[] = '../../classes/app.control/app.util/setDisc.class.php';
		$this->classes[] = '../../classes/app.control/app.util/setProfessor.class.php';
		$this->classes[] = '../../classes/app.control/app.util/setTipoMov.class.php';
		$this->classes[] = '../../classes/app.control/app.util/setTurmaDisciplina.class.php';
		$this->classes[] = '../../classes/app.control/app.util/viewCurso.class.php';
		$this->classes[] = '../../classes/app.control/app.scorecard/TScoreCard.class.php';
		$this->classes[] = '../../classes/app.control/app.financeiro/relatorioCaixaD.class.php';
		$this->classes[] = '../../classes/app.control/app.financeiro/relatorioCaixaR.class.php';
		$this->classes[] = '../../classes/app.control/app.financeiro/setComprovante.class.php';
		$this->classes[] = '../../classes/app.control/app.financeiro/setCriterioFolhaPag.class.php';
		$this->classes[] = '../../classes/app.control/app.financeiro/setDataBP.class.php';
		$this->classes[] = '../../classes/app.control/app.financeiro/setPeriodoDRE.class.php';
		$this->classes[] = '../../classes/app.control/app.financeiro/viewBPatrimonial.class.php';
		$this->classes[] = '../../classes/app.control/app.financeiro/viewDRE.class.php';
		$this->classes[] = '../../classes/app.control/app.contratos/setDocumento.class.php';
		$this->classes[] = '../../classes/app.control/app.alunos/TUserAluno.class.php';
		$this->classes[] = '../../classes/app.control/app.alunos/viewArquivos.class.php';
		$this->classes[] = '../../classes/app.control/app.alunos/viewDuplicatas.class.php';
		$this->classes[] = '../../classes/app.control/app.alunos/viewHistAcadem.class.php';
		$this->classes[] = '../../classes/app.control/app.alunos/viewOrientacoes.class.php';
		$this->classes[] = '../../classes/app.control/TSetControl.class.php';
		$this->classes[] = '../../classes/app.control/TSetModel.class.php';
		$this->classes[] = '../../classes/app.access/TActionIn.class.php';
		$this->classes[] = '../../classes/app.access/TCheckLogin.class.php';
		$this->classes[] = '../../classes/app.access/TGetPrivilegio.class.php';
		$this->classes[] = '../../classes/app.access/TLogout.class.php';
		$this->classes[] = '../../classes/app.access/TOccupant.class.php';
		$this->classes[] = '../../classes/app.access/TPrivilegios.class.php';
		$this->classes[] = '../../classes/app.access/TSetPrivilegios.class.php';
		$this->classes[] = '../../classes/app.access/TSetUnidade.class.php';
		$this->classes[] = '../../classes/app.access/TSetlogin.class.php';
		$this->classes[] = '../../classes/app.access/TShowPrivilegios.class.php';
		$this->classes[] = '../../classes/app.access/TUsuario.class.php';
		$this->classes[] = '../../classes/app.krs/TKrs.class.php';
		$this->classes[] = '../../classes/app.krs/TKrsStatement.class.php';
		
	}
	
	/**
	 * 
	 */
    public function getClasses(){ 
        return $this->classes; 
    }

}
?>