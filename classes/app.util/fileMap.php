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
		
		$this->classes['TAbas'] = '../../classes/app.widgets/TAbas.class.php';
		$this->classes['TAction'] = '../../classes/app.widgets/TAction.class.php';
		$this->classes['TBarCode'] = '../../classes/app.widgets/TBarCode.class.php';
		$this->classes['TButton'] = '../../classes/app.widgets/TButton.class.php';
		$this->classes['TButtonImg'] = '../../classes/app.widgets/TButtonImg.class.php';
		$this->classes['TChart'] = '../../classes/app.widgets/TChart.class.php';
		$this->classes['TCheckButton'] = '../../classes/app.widgets/TCheckButton.class.php';
		$this->classes['TCheckGroup'] = '../../classes/app.widgets/TCheckGroup.class.php';
		$this->classes['TClassJQuery'] = '../../classes/app.widgets/TClassJQuery.class.php';
		$this->classes['TCombo'] = '../../classes/app.widgets/TCombo.class.php';
		$this->classes['TCookie'] = '../../classes/app.widgets/TCookie.class.php';
		$this->classes['TDataGrid'] = '../../classes/app.widgets/TDataGrid.class.php';
		$this->classes['TDataGridAction'] = '../../classes/app.widgets/TDataGridAction.class.php';
		$this->classes['TDataGridColumn'] = '../../classes/app.widgets/TDataGridColumn.class.php';
		$this->classes['TElement'] = '../../classes/app.widgets/TElement.class.php';
		$this->classes['TEntry'] = '../../classes/app.widgets/TEntry.class.php';
		$this->classes['TField'] = '../../classes/app.widgets/TField.class.php';
		$this->classes['TFile'] = '../../classes/app.widgets/TFile.class.php';
		$this->classes['TForm'] = '../../classes/app.widgets/TForm.class.php';
		$this->classes['TFrame'] = '../../classes/app.widgets/TFrame.class.php';
		$this->classes['TFrameFile'] = '../../classes/app.widgets/TFrameFile.class.php';
		$this->classes['TGDImage'] = '../../classes/app.widgets/TGDImage.class.php';
		$this->classes['THidden'] = '../../classes/app.widgets/THidden.class.php';
		$this->classes['TIcon'] = '../../classes/app.widgets/TIcon.class.php';
		$this->classes['TImage'] = '../../classes/app.widgets/TImage.class.php';
		$this->classes['TLabel'] = '../../classes/app.widgets/TLabel.class.php';
		$this->classes['TMessage'] = '../../classes/app.widgets/TMessage.class.php';
		$this->classes['TMultiSelect'] = '../../classes/app.widgets/TMultiSelect.class.php';
		$this->classes['TPage'] = '../../classes/app.widgets/TPage.class.php';
		$this->classes['TPanel'] = '../../classes/app.widgets/TPanel.class.php';
		$this->classes['TPassword'] = '../../classes/app.widgets/TPassword.class.php';
		$this->classes['TQuestion'] = '../../classes/app.widgets/TQuestion.class.php';
		$this->classes['TRadioButton'] = '../../classes/app.widgets/TRadioButton.class.php';
		$this->classes['TRadioGroup'] = '../../classes/app.widgets/TRadioGroup.class.php';
		$this->classes['TSeparator'] = '../../classes/app.widgets/TSeparator.class.php';
		$this->classes['TSession'] = '../../classes/app.widgets/TSession.class.php';
		$this->classes['TSetAbas'] = '../../classes/app.widgets/TSetAbas.class.php';
		$this->classes['TSetPainel'] = '../../classes/app.widgets/TSetPainel.class.php';
		$this->classes['TStyle'] = '../../classes/app.widgets/TStyle.class.php';
		$this->classes['TTable'] = '../../classes/app.widgets/TTable.class.php';
		$this->classes['TTableCell'] = '../../classes/app.widgets/TTableCell.class.php';
		$this->classes['TTableRow'] = '../../classes/app.widgets/TTableRow.class.php';
		$this->classes['TText'] = '../../classes/app.widgets/TText.class.php';
		$this->classes['TTranslation'] = '../../classes/app.widgets/TTranslation.class.php';
		$this->classes['TViews'] = '../../classes/app.widgets/TViews.class.php';
		$this->classes['TWindow'] = '../../classes/app.widgets/TWindow.class.php';
		$this->classes['TWindowPesq'] = '../../classes/app.widgets/TWindowPesq.class.php';
		$this->classes['TClassJQuery'] = '../../classes/app.view/app.ui/TClassJQuery.class.php';
		$this->classes['TSetCuston'] = '../../classes/app.view/app.custon/TSetCuston.class.php';
		$this->classes['TForms'] = '../../classes/app.krs/TForms.class.php';
		$this->classes['TBloco'] = '../../classes/app.krs/TBloco.class.php';
		$this->classes['TCompForm'] = '../../classes/app.krs/TCompForm.class.php';
		$this->classes['TCompLista'] = '../../classes/app.krs/TCompLista.class.php';
		//$this->classes['TCompSql'] = '../../classes/app.krs/TCompSql.class.php';
		$this->classes['TExecs'] = '../../classes/app.view/TExecs.class.php';
		//$this->classes['TInfoForm'] = '../../classes/app.krs/TInfoForm.class.php';
		$this->classes['TInterface'] = '../../classes/app.view/TInterface.class.php';
		$this->classes['TMenu'] = '../../classes/app.view/TMenu.class.php';
		$this->classes['TRodape'] = '../../classes/app.view/TRodape.class.php';
		$this->classes['TSetAction'] = '../../classes/app.krs/TSetAction.class.php';
		$this->classes['TSetCampo'] = '../../classes/app.krs/TSetCampo.class.php';
		$this->classes['TSetPesquisa'] = '../../classes/app.krs/TSetPesquisa.class.php';
		$this->classes['TSetfields'] = '../../classes/app.krs/TSetfields.class.php';
		$this->classes['TSetlista'] = '../../classes/app.krs/TSetlista.class.php';
		$this->classes['campos_x_propriedadesRecord'] = '../../classes/app.krs/campos_x_propriedadesRecord.class.php';
		$this->classes['formsRecord'] = '../../classes/app.krs/formsRecord.class.php';
		$this->classes['TAlocaDados'] = '../../classes/app.util/TAlocaDados.class.php';
		$this->classes['TApendices'] = '../../classes/app.util/TApendices.class.php';
		$this->classes['TCloneForm'] = '../../classes/app.util/TCloneForm.class.php';
		$this->classes['TEmail'] = '../../classes/app.util/TEmail.class.php';
		$this->classes['TFiltrosList'] = '../../classes/app.util/TFiltrosList.class.php';
		$this->classes['TMensagem'] = '../../classes/app.util/TMensagem.class.php';
		$this->classes['TPath'] = '../../classes/app.util/TPath.class.php';
		$this->classes['TPopulaCampo'] = '../../classes/app.util/TPopulaCampo.class.php';
		$this->classes['TRequest'] = '../../classes/app.util/TRequest.class.php';
		$this->classes['TSetData'] = '../../classes/app.util/TSetData.class.php';
		$this->classes['TSetHeader'] = '../../classes/app.util/TSetHeader.class.php';
		$this->classes['TSetMascaras'] = '../../classes/app.util/TSetMascaras.class.php';
		$this->classes['TSetPdf'] = '../../classes/app.util/TSetPdf.class.php';
		$this->classes['TStatus'] = '../../classes/app.util/TStatus.class.php';
		$this->classes['TUpload'] = '../../classes/app.util/TUpload.class.php';
		$this->classes['TValidaCampo'] = '../../classes/app.util/TValidaCampo.class.php';
		$this->classes['TXml'] = '../../classes/app.util/TXml.class.php';
		$this->classes['autoload'] = '../../classes/app.util/autoload.class.php';
		$this->classes['setException'] = '../../classes/app.util/setException.class.php';
		$this->classes['setSomaTotal'] = '../../classes/app.util/setSomaTotal.class.php';
		$this->classes['setTipoForm'] = '../../classes/app.util/setTipoForm.class.php';
		$this->classes['TNFeModel'] = '../../classes/app.nfe/TNFeModel.class.php';
		$this->classes['TNFeWsdl'] = '../../classes/app.nfe/TNFeWsdl.class.php';
		$this->classes['danfe'] = '../../classes/app.nfe/danfe.class.php';
		$this->classes['TCaixa'] = '../../classes/app.model/financeiro/TCaixa.class.php';
		$this->classes['TConciliacaoCaixa'] = '../../classes/app.model/financeiro/TConciliacaoCaixa.class.php';
		$this->classes['TConvenios'] = '../../classes/app.model/financeiro/TConvenios.class.php';
		$this->classes['TFechaCaixa'] = '../../classes/app.model/financeiro/TFechaCaixa.class.php';
		$this->classes['TSetBoleto'] = '../../classes/app.model/financeiro/TSetBoleto.class.php';
		$this->classes['TTransacao'] = '../../classes/app.model/financeiro/TTransacao.class.php';
		$this->classes['TAluno'] = '../../classes/app.model/educacional/TAluno.class.php';
		$this->classes['TAvaliacao'] = '../../classes/app.model/educacional/TAvaliacao.class.php';
		$this->classes['TBiblioteca'] = '../../classes/app.model/educacional/TBiblioteca.class.php';
		$this->classes['TCurso'] = '../../classes/app.model/educacional/TCurso.class.php';
		$this->classes['TDisciplina'] = '../../classes/app.model/educacional/TDisciplina.class.php';
		$this->classes['TInscricao'] = '../../classes/app.model/educacional/TInscricao.class.php';
		$this->classes['TLivro'] = '../../classes/app.model/educacional/TLivro.class.php';
		$this->classes['TMatricula'] = '../../classes/app.model/educacional/TMatricula.class.php';
		$this->classes['TProcessoAcademico'] = '../../classes/app.model/educacional/TProcessoAcademico.class.php';
		$this->classes['TProfessor'] = '../../classes/app.model/educacional/TProfessor.class.php';
		$this->classes['TSecretaria'] = '../../classes/app.model/educacional/TSecretaria.class.php';
		$this->classes['TSolicitacao'] = '../../classes/app.model/educacional/TSolicitacao.class.php';
		$this->classes['TTurma'] = '../../classes/app.model/educacional/TTurma.class.php';
		$this->classes['TTurmaDisciplinas'] = '../../classes/app.model/educacional/TTurmaDisciplinas.class.php';
		$this->classes['TEtiquetas'] = '../../classes/app.model/TEtiquetas.class.php';
		$this->classes['TPessoa'] = '../../classes/app.model/TPessoa.class.php';
		$this->classes['TProduto'] = '../../classes/app.model/TProduto.class.php';
		$this->classes['TUnidade'] = '../../classes/app.model/TUnidade.class.php';
		$this->classes['TVoice'] = '../../classes/app.model/TVoice.class.php';
		$this->classes['TChartCore'] = '../../classes/app.lib/pchart/TChartCore.class.php';
		$this->classes['TChartData'] = '../../classes/app.lib/pchart/TChartData.class.php';
		$this->classes['createpdf'] = '../../classes/app.lib/fpdf/createpdf.class.php';
		$this->classes['fpdf'] = '../../classes/app.lib/fpdf/fpdf.class.php';
		$this->classes['ufpdf'] = '../../classes/app.lib/fpdf/ufpdf.class.php';
		$this->classes['includesUI'] = '../../classes/app.js/includesUI.class.php';
		$this->classes['loadJs'] = '../../classes/app.js/loadJs.class.php';
		$this->classes['TConnection'] = '../../classes/app.dbo/TConnection.class.php';
		$this->classes['TConstantes'] = '../../classes/app.dbo/TConstantes.class.php';
		$this->classes['TCriteria'] = '../../classes/app.dbo/TCriteria.class.php';
		$this->classes['TDados'] = '../../classes/app.dbo/TDados.class.php';
		$this->classes['TDbo'] = '../../classes/app.dbo/TDbo.class.php';
		$this->classes['TDbo_kernelsys'] = '../../classes/app.dbo/TDbo_kernelsys.class.php';
		$this->classes['TDbo_out'] = '../../classes/app.dbo/TDbo_out.class.php';
		$this->classes['TError'] = '../../classes/app.dbo/TError.class.php';
		$this->classes['TExeSql'] = '../../classes/app.dbo/TExeSql.class.php';
		$this->classes['TExpression'] = '../../classes/app.dbo/TExpression.class.php';
		$this->classes['TFilter'] = '../../classes/app.dbo/TFilter.class.php';
		$this->classes['TLogger'] = '../../classes/app.dbo/TLogger.class.php';
		$this->classes['TLoggerHTML'] = '../../classes/app.dbo/TLoggerHTML.class.php';
		$this->classes['TLoggerTXT'] = '../../classes/app.dbo/TLoggerTXT.class.php';
		$this->classes['TLoggerXML'] = '../../classes/app.dbo/TLoggerXML.class.php';
		$this->classes['TRecord'] = '../../classes/app.dbo/TRecord.class.php';
		$this->classes['TRepository'] = '../../classes/app.dbo/TRepository.class.php';
		$this->classes['TSqlDelete'] = '../../classes/app.dbo/TSqlDelete.class.php';
		$this->classes['TSqlInsert'] = '../../classes/app.dbo/TSqlInsert.class.php';
		$this->classes['TSqlInstruction'] = '../../classes/app.dbo/TSqlInstruction.class.php';
		$this->classes['TSqlSelect'] = '../../classes/app.dbo/TSqlSelect.class.php';
		$this->classes['TSqlUpdate'] = '../../classes/app.dbo/TSqlUpdate.class.php';
		$this->classes['TTransaction'] = '../../classes/app.dbo/TTransaction.class.php';
		$this->classes['geraCodigo'] = '../../classes/app.dbo/geraCodigo.class.php';
		$this->classes['setAluno'] = '../../classes/app.control/app.util/setAluno.class.php';
		$this->classes['setDepartamento'] = '../../classes/app.control/app.util/setDepartamento.class.php';
		$this->classes['setDisc'] = '../../classes/app.control/app.util/setDisc.class.php';
		$this->classes['setProfessor'] = '../../classes/app.control/app.util/setProfessor.class.php';
		$this->classes['setTipoMov'] = '../../classes/app.control/app.util/setTipoMov.class.php';
		$this->classes['setTurmaDisciplina'] = '../../classes/app.control/app.util/setTurmaDisciplina.class.php';
		$this->classes['viewCurso'] = '../../classes/app.control/app.util/viewCurso.class.php';
		$this->classes['TScoreCard'] = '../../classes/app.control/app.scorecard/TScoreCard.class.php';
		$this->classes['relatorioCaixaD'] = '../../classes/app.control/app.financeiro/relatorioCaixaD.class.php';
		$this->classes['relatorioCaixaR'] = '../../classes/app.control/app.financeiro/relatorioCaixaR.class.php';
		$this->classes['setComprovante'] = '../../classes/app.control/app.financeiro/setComprovante.class.php';
		$this->classes['setCriterioFolhaPag'] = '../../classes/app.control/app.financeiro/setCriterioFolhaPag.class.php';
		$this->classes['setDataBP'] = '../../classes/app.control/app.financeiro/setDataBP.class.php';
		$this->classes['setPeriodoDRE'] = '../../classes/app.control/app.financeiro/setPeriodoDRE.class.php';
		$this->classes['viewBPatrimonial'] = '../../classes/app.control/app.financeiro/viewBPatrimonial.class.php';
		$this->classes['viewDRE'] = '../../classes/app.control/app.financeiro/viewDRE.class.php';
		$this->classes['setDocumento'] = '../../classes/app.control/app.contratos/setDocumento.class.php';
		$this->classes['TUserAluno'] = '../../classes/app.control/app.alunos/TUserAluno.class.php';
		$this->classes['viewArquivos'] = '../../classes/app.control/app.alunos/viewArquivos.class.php';
		$this->classes['viewDuplicatas'] = '../../classes/app.control/app.alunos/viewDuplicatas.class.php';
		$this->classes['viewHistAcadem'] = '../../classes/app.control/app.alunos/viewHistAcadem.class.php';
		$this->classes['viewOrientacoes'] = '../../classes/app.control/app.alunos/viewOrientacoes.class.php';
		$this->classes['TSetControl'] = '../../classes/app.control/TSetControl.class.php';
		$this->classes['TSetModel'] = '../../classes/app.control/TSetModel.class.php';
		$this->classes['TActionIn'] = '../../classes/app.access/TActionIn.class.php';
		$this->classes['TCheckLogin'] = '../../classes/app.access/TCheckLogin.class.php';
		$this->classes['TGetPrivilegio'] = '../../classes/app.access/TGetPrivilegio.class.php';
		$this->classes['TLogout'] = '../../classes/app.access/TLogout.class.php';
		$this->classes['TOccupant'] = '../../classes/app.access/TOccupant.class.php';
		$this->classes['TPrivilegios'] = '../../classes/app.access/TPrivilegios.class.php';
		$this->classes['TSetPrivilegios'] = '../../classes/app.access/TSetPrivilegios.class.php';
		$this->classes['TSetUnidade'] = '../../classes/app.access/TSetUnidade.class.php';
		$this->classes['TSetlogin'] = '../../classes/app.access/TSetlogin.class.php';
		$this->classes['TShowPrivilegios'] = '../../classes/app.access/TShowPrivilegios.class.php';
		$this->classes['TUsuario'] = '../../classes/app.access/TUsuario.class.php';
		$this->classes['TKrs'] = '../../classes/app.krs/TKrs.class.php';
		$this->classes['TKrsStatement'] = '../../classes/app.krs/TKrsStatement.class.php';
		
	}
	
	/**
	 * 
	 */
    public function getClasses($class = null){ 
    	if(!empty($class)){
    		$returnClass = $this->classes[$class];
    		if(empty($returnClass)){
    			return false;
    		}else{
    			return $returnClass;
    		}
    	}else{
        	return $this->classes; 
    	}
    }

}