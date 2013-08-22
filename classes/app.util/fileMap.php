<?php

require_once('../app.widgets/TSession.class.php');

class fileMap {
	public $classes = array ();
	public $package = array ();
	protected $obsession; 
	public function __construct() {
		$this->obsession = new TSession();
		
		$this->classes ['TGetCurso'] = '../../classes/inscricao/TGetCurso.class.php';
		$this->classes ['TSetInscricao'] = '../../classes/inscricao/TSetInscricao.class.php';
		$this->classes ['TAbas'] = '../../classes/app.widgets/TAbas.class.php';
		$this->classes ['TAction'] = '../../classes/app.widgets/TAction.class.php';
		$this->classes ['TBarCode'] = '../../classes/app.widgets/TBarCode.class.php';
		$this->classes ['TButton'] = '../../classes/app.widgets/TButton.class.php';
		$this->classes ['TButtonImg'] = '../../classes/app.widgets/TButtonImg.class.php';
		$this->classes ['TChart'] = '../../classes/app.widgets/TChart.class.php';
		$this->classes ['TCheckButton'] = '../../classes/app.widgets/TCheckButton.class.php';
		$this->classes ['TCheckGroup'] = '../../classes/app.widgets/TCheckGroup.class.php';
		$this->classes ['TClassJQuery'] = '../../classes/app.widgets/TClassJQuery.class.php';
		$this->classes ['TCombo'] = '../../classes/app.widgets/TCombo.class.php';
		$this->classes ['TCookie'] = '../../classes/app.widgets/TCookie.class.php';
		$this->classes ['TDataGrid'] = '../../classes/app.widgets/TDataGrid.class.php';
		$this->classes ['TDataGridAction'] = '../../classes/app.widgets/TDataGridAction.class.php';
		$this->classes ['TDataGridColumn'] = '../../classes/app.widgets/TDataGridColumn.class.php';
		$this->classes ['TElement'] = '../../classes/app.widgets/TElement.class.php';
		$this->classes ['TEntry'] = '../../classes/app.widgets/TEntry.class.php';
		$this->classes ['TBetweenDate'] = '../../classes/app.widgets/TBetweenDate.class.php';
		$this->classes ['TField'] = '../../classes/app.widgets/TField.class.php';
		$this->classes ['TFile'] = '../../classes/app.widgets/TFile.class.php';
		$this->classes ['TForm'] = '../../classes/app.widgets/TForm.class.php';
		$this->classes ['TFrame'] = '../../classes/app.widgets/TFrame.class.php';
		$this->classes ['TFrameFile'] = '../../classes/app.widgets/TFrameFile.class.php';
		$this->classes ['TGDImage'] = '../../classes/app.widgets/TGDImage.class.php';
		$this->classes ['THidden'] = '../../classes/app.widgets/THidden.class.php';
		$this->classes ['TIcon'] = '../../classes/app.widgets/TIcon.class.php';
		$this->classes ['TImage'] = '../../classes/app.widgets/TImage.class.php';
		$this->classes ['TLabel'] = '../../classes/app.widgets/TLabel.class.php';
		$this->classes ['TMessage'] = '../../classes/app.widgets/TMessage.class.php';
		$this->classes ['TMultiSelect'] = '../../classes/app.widgets/TMultiSelect.class.php';
		$this->classes ['TPage'] = '../../classes/app.widgets/TPage.class.php';
		$this->classes ['TPanel'] = '../../classes/app.widgets/TPanel.class.php';
		$this->classes ['TPassword'] = '../../classes/app.widgets/TPassword.class.php';
		$this->classes ['TQuestion'] = '../../classes/app.widgets/TQuestion.class.php';
		$this->classes ['TRadioButton'] = '../../classes/app.widgets/TRadioButton.class.php';
		$this->classes ['TRadioGroup'] = '../../classes/app.widgets/TRadioGroup.class.php';
		$this->classes ['TSeparator'] = '../../classes/app.widgets/TSeparator.class.php';
		$this->classes ['TSession'] = '../../classes/app.widgets/TSession.class.php';
		$this->classes ['TSetAbas'] = '../../classes/app.widgets/TSetAbas.class.php';
		$this->classes ['TSetPainel'] = '../../classes/app.widgets/TSetPainel.class.php';
		$this->classes ['TStyle'] = '../../classes/app.widgets/TStyle.class.php';
		$this->classes ['TTable'] = '../../classes/app.widgets/TTable.class.php';
		$this->classes ['TTableCell'] = '../../classes/app.widgets/TTableCell.class.php';
		$this->classes ['TTableRow'] = '../../classes/app.widgets/TTableRow.class.php';
		$this->classes ['TText'] = '../../classes/app.widgets/TText.class.php';
		$this->classes ['TTranslation'] = '../../classes/app.widgets/TTranslation.class.php';
		$this->classes ['TViews'] = '../../classes/app.widgets/TViews.class.php';
		$this->classes ['TWindow'] = '../../classes/app.widgets/TWindow.class.php';
		$this->classes ['TWindowPesq'] = '../../classes/app.widgets/TWindowPesq.class.php';
		$this->classes ['TClassJQuery'] = '../../classes/app.view/app.ui/TClassJQuery.class.php';
		$this->classes ['TSetCuston'] = '../../classes/app.view/app.custon/TSetCuston.class.php';
		$this->classes ['TMain'] = '../../classes/app.view/TMain.class.php';
		$this->classes ['TInterface'] = '../../classes/app.view/TInterface.class.php';
		$this->classes ['TMenu'] = '../../classes/app.view/TMenu.class.php';
		$this->classes ['TRodape'] = '../../classes/app.view/TRodape.class.php';
		$this->classes ['TAlocaDados'] = '../../classes/app.util/TAlocaDados.class.php';
		$this->classes ['TApendices'] = '../../classes/app.util/TApendices.class.php';
		$this->classes ['TCloneForm'] = '../../classes/app.util/TCloneForm.class.php';
		$this->classes ['TEmail'] = '../../classes/app.util/TEmail.class.php';
		$this->classes ['TFiltrosList'] = '../../classes/app.util/TFiltrosList.class.php';
		$this->classes ['TMensagem'] = '../../classes/app.util/TMensagem.class.php';
		$this->classes ['TPageExecutionTimer'] = '../../classes/app.util/TPageExecutionTimer.class.php';
		$this->classes ['TPath'] = '../../classes/app.util/TPath.class.php';
		$this->classes ['TPopulaCampo'] = '../../classes/app.util/TPopulaCampo.class.php';
		$this->classes ['TRequest'] = '../../classes/app.util/TRequest.class.php';
		$this->classes ['TSetData'] = '../../classes/app.util/TSetData.class.php';
		$this->classes ['TSetHeader'] = '../../classes/app.util/TSetHeader.class.php';
		$this->classes ['TSetMascaras'] = '../../classes/app.util/TSetMascaras.class.php';
		$this->classes ['TSetPdf'] = '../../classes/app.util/TSetPdf.class.php';
		$this->classes ['TStatus'] = '../../classes/app.util/TStatus.class.php';
		$this->classes ['TUpload'] = '../../classes/app.util/TUpload.class.php';
		$this->classes ['TValidaCampo'] = '../../classes/app.util/TValidaCampo.class.php';
		$this->classes ['TXml'] = '../../classes/app.util/TXml.class.php';
		$this->classes ['autoload'] = '../../classes/app.util/autoload.class.php';
		$this->classes ['setException'] = '../../classes/app.util/setException.class.php';
		$this->classes ['setSomaTotal'] = '../../classes/app.util/setSomaTotal.class.php';
		$this->classes ['setTipoForm'] = '../../classes/app.util/setTipoForm.class.php';
		$this->classes ['TNFeModel'] = '../../classes/app.nfe/TNFeModel.class.php';
		$this->classes ['TNFeWsdl'] = '../../classes/app.nfe/TNFeWsdl.class.php';
		$this->classes ['danfe'] = '../../classes/app.nfe/danfe.class.php';
		$this->classes ['TEtiquetas'] = '../../classes/app.model/TEtiquetas.class.php';
		$this->classes ['TPessoa'] = '../../classes/app.model/TPessoa.class.php';
		$this->classes ['TProduto'] = '../../classes/app.model/TProduto.class.php';
		$this->classes ['TUnidade'] = '../../classes/app.model/TUnidade.class.php';
		$this->classes ['TVoice'] = '../../classes/app.model/TVoice.class.php';
		$this->classes ['TChartCore'] = '../../classes/app.lib/pchart/TChartCore.class.php';
		$this->classes ['TChartData'] = '../../classes/app.lib/pchart/TChartData.class.php';
		$this->classes ['createpdf'] = '../../classes/app.lib/fpdf/createpdf.class.php';
		$this->classes ['fpdf'] = '../../classes/app.lib/fpdf/fpdf.class.php';
		$this->classes ['ufpdf'] = '../../classes/app.lib/fpdf/ufpdf.class.php';
		$this->classes ['TBloco'] = '../../classes/app.krs/TBloco.class.php';
		$this->classes ['TCompForm'] = '../../classes/app.krs/TCompForm.class.php';
		$this->classes ['TCompLista'] = '../../classes/app.krs/TCompLista.class.php';
		$this->classes ['TForms'] = '../../classes/app.krs/TForms.class.php';
		$this->classes ['TKrs'] = '../../classes/app.krs/TKrs.class.php';
		$this->classes ['TKrsStatement'] = '../../classes/app.krs/TKrsStatement.class.php';
		$this->classes ['TSetAction'] = '../../classes/app.krs/TSetAction.class.php';
		$this->classes ['TSetCampo'] = '../../classes/app.krs/TSetCampo.class.php';
		$this->classes ['TSetPesquisa'] = '../../classes/app.krs/TSetPesquisa.class.php';
		$this->classes ['TSetfields'] = '../../classes/app.krs/TSetfields.class.php';
		$this->classes ['TSetlista'] = '../../classes/app.krs/TSetlista.class.php';
		$this->classes ['TSqlCompiler'] = '../../classes/app.krs/TSqlCompiler.class.php';
		$this->classes ['campos_x_propriedadesRecord'] = '../../classes/app.krs/campos_x_propriedadesRecord.class.php';
		$this->classes ['formsRecord'] = '../../classes/app.krs/formsRecord.class.php';
		$this->classes ['includesUI'] = '../../classes/app.js/includesUI.class.php';
		$this->classes ['loadJs'] = '../../classes/app.js/loadJs.class.php';
		$this->classes ['TConnection'] = '../../classes/app.dbo/TConnection.class.php';
		$this->classes ['TConstantes'] = '../../classes/app.util/TConstantes.class.php';
		$this->classes ['TCriteria'] = '../../classes/app.dbo/TCriteria.class.php';
		$this->classes ['TDados'] = '../../classes/app.dbo/TDados.class.php';
		$this->classes ['TDbo'] = '../../classes/app.dbo/TDbo.class.php';
		$this->classes ['TDbo_kernelsys'] = '../../classes/app.dbo/TDbo_kernelsys.class.php';
		$this->classes ['TDbo_out'] = '../../classes/app.dbo/TDbo_out.class.php';
		$this->classes ['TError'] = '../../classes/app.dbo/TError.class.php';
		$this->classes ['TExeSql'] = '../../classes/app.dbo/TExeSql.class.php';
		$this->classes ['TExpression'] = '../../classes/app.dbo/TExpression.class.php';
		$this->classes ['TFilter'] = '../../classes/app.dbo/TFilter.class.php';
		$this->classes ['TLogger'] = '../../classes/app.dbo/TLogger.class.php';
		$this->classes ['TLoggerHTML'] = '../../classes/app.dbo/TLoggerHTML.class.php';
		$this->classes ['TLoggerTXT'] = '../../classes/app.dbo/TLoggerTXT.class.php';
		$this->classes ['TLoggerXML'] = '../../classes/app.dbo/TLoggerXML.class.php';
		$this->classes ['TRecord'] = '../../classes/app.dbo/TRecord.class.php';
		$this->classes ['TRepository'] = '../../classes/app.dbo/TRepository.class.php';
		$this->classes ['TSqlDelete'] = '../../classes/app.dbo/TSqlDelete.class.php';
		$this->classes ['TSqlInsert'] = '../../classes/app.dbo/TSqlInsert.class.php';
		$this->classes ['TSqlInstruction'] = '../../classes/app.dbo/TSqlInstruction.class.php';
		$this->classes ['TSqlSelect'] = '../../classes/app.dbo/TSqlSelect.class.php';
		$this->classes ['TSqlUpdate'] = '../../classes/app.dbo/TSqlUpdate.class.php';
		$this->classes ['TTransaction'] = '../../classes/app.dbo/TTransaction.class.php';
		$this->classes ['geraseq'] = '../../classes/app.dbo/geraseq.class.php';
		$this->classes ['TSetControl'] = '../../classes/app.control/TSetControl.class.php';
		$this->classes ['TSetModel'] = '../../classes/app.control/TSetModel.class.php';
		$this->classes ['TActionIn'] = '../../classes/app.access/TActionIn.class.php';
		$this->classes ['TCheckLogin'] = '../../classes/app.access/TCheckLogin.class.php';
		$this->classes ['TGetPrivilegio'] = '../../classes/app.access/TGetPrivilegio.class.php';
		$this->classes ['TLogout'] = '../../classes/app.access/TLogout.class.php';
		$this->classes ['TOccupant'] = '../../classes/app.access/TOccupant.class.php';
		$this->classes ['TPrivilegios'] = '../../classes/app.access/TPrivilegios.class.php';
		$this->classes ['TSetPrivilegios'] = '../../classes/app.access/TSetPrivilegios.class.php';
		$this->classes ['TSetUnidade'] = '../../classes/app.access/TSetUnidade.class.php';
		$this->classes ['TSetlogin'] = '../../classes/app.access/TSetlogin.class.php';
		$this->classes ['TShowPrivilegios'] = '../../classes/app.access/TShowPrivilegios.class.php';
		$this->classes ['TUsuario'] = '../../classes/app.access/TUsuario.class.php';

		/* Classes do package SCP */
		$this->package ['scp'] = array(
			'DocumentoBo' => '../../classes/app.bo/scp/financeiro/DocumentoBO.class.php',
			'MovimentoCaixaBo' => '../../classes/app.bo/scp/financeiro/MovimentoCaixaBO.class.php',
			'BaixaDocumentoBO' => '../../classes/app.bo/scp/financeiro/BaixaDocumentoBO.class.php'
		);

		/* Classes do package EDU */
		$this->package ['edu'] = array(
			'setAluno' => '../../classes/app.control/edu/app.util/setAluno.class.php',
			'setDepartamento' => '../../classes/app.control/edu/app.util/setDepartamento.class.php',
			'setDisc' => '../../classes/app.control/edu/app.util/setDisc.class.php',
			'setProfessor' => '../../classes/app.control/edu/app.util/setProfessor.class.php',
			'setTipoMov' => '../../classes/app.control/edu/app.util/setTipoMov.class.php',
			'setTurmaDisciplina' => '../../classes/app.control/edu/app.util/setTurmaDisciplina.class.php',
			'viewCurso' => '../../classes/app.control/edu/app.util/viewCurso.class.php',
			'TScoreCard' => '../../classes/app.control/edu/app.scorecard/TScoreCard.class.php',
			'relatorioCaixaD' => '../../classes/app.control/edu/app.financeiro/relatorioCaixaD.class.php',
			'relatorioCaixaR' => '../../classes/app.control/edu/app.financeiro/relatorioCaixaR.class.php',
			'setComprovante' => '../../classes/app.control/edu/app.financeiro/setComprovante.class.php',
			'setCriterioFolhaPag' => '../../classes/app.control/edu/app.financeiro/setCriterioFolhaPag.class.php',
			'setDataBP' => '../../classes/app.control/edu/app.financeiro/setDataBP.class.php',
			'setPeriodoDRE' => '../../classes/app.control/edu/app.financeiro/setPeriodoDRE.class.php',
			'viewBPatrimonial' => '../../classes/app.control/edu/app.financeiro/viewBPatrimonial.class.php',
			'viewDRE' => '../../classes/app.control/edu/app.financeiro/viewDRE.class.php',
			'setDocumento' => '../../classes/app.control/edu/app.contratos/setDocumento.class.php',
			'TUserAluno' => '../../classes/app.control/edu/app.alunos/TUserAluno.class.php',
			'viewArquivos' => '../../classes/app.control/edu/app.alunos/viewArquivos.class.php',
			'viewDuplicatas' => '../../classes/app.control/edu/app.alunos/viewDuplicatas.class.php',
			'viewHistAcadem' => '../../classes/app.control/edu/app.alunos/viewHistAcadem.class.php',
			'viewOrientacoes' => '../../classes/app.control/edu/app.alunos/viewOrientacoes.class.php',
			'TCaixa' => '../../classes/app.model/edu/financeiro/TCaixa.class.php',
			'TConciliacaoCaixa' => '../../classes/app.model/edu/financeiro/TConciliacaoCaixa.class.php',
			'TConvenios' => '../../classes/app.model/edu/financeiro/TConvenios.class.php',
			'TFechaCaixa' => '../../classes/app.model/edu/financeiro/TFechaCaixa.class.php',
			'TSetBoleto' => '../../classes/app.model/edu/financeiro/TSetBoleto.class.php',
			'TTransacao' => '../../classes/app.model/edu/financeiro/TTransacao.class.php',
			'TAluno' => '../../classes/app.model/edu/educacional/TAluno.class.php',
			'TAvaliacao' => '../../classes/app.model/edu/educacional/TAvaliacao.class.php',
			'TBiblioteca' => '../../classes/app.model/edu/educacional/TBiblioteca.class.php',
			'TCurso' => '../../classes/app.model/edu/educacional/TCurso.class.php',
			'TDisciplina' => '../../classes/app.model/edu/educacional/TDisciplina.class.php',
			'TInscricao' => '../../classes/app.model/edu/educacional/TInscricao.class.php',
			'TLivro' => '../../classes/app.model/edu/educacional/TLivro.class.php',
			'TMatricula' => '../../classes/app.model/edu/educacional/TMatricula.class.php',
			'TProcessoAcademico' => '../../classes/app.model/edu/educacional/TProcessoAcademico.class.php',
			'TProfessor' => '../../classes/app.model/edu/educacional/TProfessor.class.php',
			'TSecretaria' => '../../classes/app.model/edu/educacional/TSecretaria.class.php',
			'TSolicitacao' => '../../classes/app.model/edu/educacional/TSolicitacao.class.php',
			'TTurma' => '../../classes/app.model/edu/educacional/TTurma.class.php',
			'TTurmaDisciplinas' => '../../classes/app.model/edu/educacional/TTurmaDisciplinas.class.php'
		);
		
		
	}
	public function getClasses($class = null) {
		if (! empty ( $class )) {
			$returnClass = $this->classes [$class];
			if(!$returnClass) 
				$returnClass = $this->package [ $this->obsession->getValue('package') ] [$class];
			if (empty ( $returnClass )) {
				return false;
			} else {
				return $returnClass;
			}
		} else {
			return array_merge( $this->classes, $this->package [ $this->obsession->getValue('package') ] );
		}
	}
}