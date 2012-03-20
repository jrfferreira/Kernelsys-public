<?php
/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class TPessoa{

    private $obTDbo;
    private $obPessoa;

    public function __construct(){
        $this->obTDbo = new TDbo();
    }

    /**
     * Retorna um objeto contendo os dados da pessoa
     * param <codigo> $codigopessoa = codigo pessoa
     * return <objeto> pessoa
     */
    public function getPessoa($codigopessoa){
         try{
            if($codigopessoa){
            	$this->obTDbo->setEntidade(TConstantes::DBPESSOAS);
                    $criteria = new TCriteria();
                    $criteria->add(new TFilter('codigo','=',$codigopessoa));
                $retPessoa = $this->obTDbo->select("*", $criteria);
                $this->obPessoa = $retPessoa->fetchObject();
/*
                $entidades = new TKrs('tabelas');
                $critEntidades = new TCriteria();
                $critEntidades->add(new TFilter('tabela_view','ilike','%PESSOAS_TITULARIDADES%'),'OR');
                $critEntidades->add(new TFilter('tabela_view','ilike','%PESSOAS_FUNCIONARIOS%'),'OR');
                $critEntidades->add(new TFilter('tabela_view','ilike','%FUNCIONARIOS_PROFESSORES%'),'OR');
                $critEntidades->add(new TFilter('tabela_view','ilike','%PESSOAS_ALUNOS%'),'OR');
                $critEntidades->add(new TFilter('tabela_view','ilike','%PESSOAS_FORMACOES%'),'OR');
                $retEntidades = $entidades->select('tabela_view',$critEntidades);

                while($t = $retEntidades->fetchObject()){
                    $tabelas = strtoupper($t->tabela_view) . ";";
                }
*/
             
                if($this->obTDbo->checkEntidade("DBPESSOAS_FORMACOES")){
                	$this->obPessoa->formacao = $this->getFormacao($codigopessoa);
                }                
                if($this->obTDbo->checkEntidade("DBPESSOAS_TITULARIDADES")){
                	$this->obPessoa->titularidade = $this->getTitularidade($codigopessoa);
                }
                if($this->obTDbo->checkEntidade("DBPESSOAS_FUNCIONARIOS")){
                	$this->obPessoa->funcionario = $this->getFuncionario($codigopessoa);
                }
                if($this->obTDbo->checkEntidade("DBPESSOAS_ALUNOS")){
                	$this->obPessoa->aluno = $this->getAluno($codigopessoa);
                }
             	if($this->obTDbo->checkEntidade("DBFUNCIONARIOS_PROFESSORES")){
                	$this->obPessoa->professor = $this->getProfessor($codigopessoa);
                }


                return $this->obPessoa;
            }else{
                throw new ErrorException("O codigo da pessoa é invalido.");
            }
        }catch (Exception $e){
        	$this->obTDbo->rollback();
            new setException($e);
        }
    }

     /**
    * Retorna um objeto contendo os dados do funcionario
    * param <codigo> $codigopessoa = codigo pessoa
    */

    public function getFuncionario($codigopessoa){
         try{
            if($codigopessoa){

            	$this->obTDbo->setEntidade(TConstantes::VIEW_PESSOAS_FUNCIONARIOS);
                $criteriaFunc = new TCriteria();
                $criteriaFunc->add(new TFilter('codigo','=',$codigopessoa));
                $retFuncionario = $this->obTDbo->select("codigofuncionario as codigo,codigocargo,nomecargo,codigodepartamento,nomedepartamento,lotacao,nomesala,dataadmissao", $criteriaFunc);

                if($this->obFuncionario = $retFuncionario->fetchObject()){
                    return $this->obFuncionario;
                }else{
                    return null;
                }

            }else{
                throw new ErrorException("O codigo da pessoa é invalido.");
            }
        }catch (Exception $e){
        	$this->obTDbo->rollback();
            new setException($e);
        }
    }
         /**
    * Retorna um objeto contendo os dados do funcionario
    * param <codigo> $codigopessoa = codigo pessoa
    */

    public function getProfessor($codigopessoa){
         try{
            if($codigopessoa){

                $funcionario = $this->getFuncionario($codigopessoa);
            	$obTDbo = new TDbo(TConstantes::VIEW_FUNCIONARIOS_PROFESSORES);
	                $criteriaProfessor = new TCriteria();
	                $criteriaProfessor->add(new TFilter('codigofuncionario','=',$funcionario->codigo));
                $retProfessor = $obTDbo->select("codigo,curriculo,titularidade", $criteriaProfessor);
                if($this->obProfessor = $retProfessor->fetchObject()){
                    return $this->obProfessor;
                }else{
                    return null;
                }

            }else{
                throw new ErrorException("O codigo da pessoa é invalido.");
            }
        }catch (Exception $e){
        	$this->obTDbo->rollback();
            new setException($e);
        }
    }
/**
    * Retorna um objeto contendo os dados do funcionario
    * param <codigo> $codigopessoa = codigo pessoa
    */

    public function getAluno($codigopessoa){
         try{
            if($codigopessoa){

            	$obTDbo = new TDbo(TConstantes::VIEW_PESSOAS_ALUNOS);
	                $criteriaAluno = new TCriteria();
	                $criteriaAluno->add(new TFilter('codigopessoa','=',$codigopessoa));
                $retAluno = $obTDbo->select("codigo", $criteriaAluno);
                $this->obAluno = $retAluno->fetchObject();
                if($this->obAluno){
                    return $this->obAluno;
                }else{
                    return null;
                }

            }else{
                throw new ErrorException("O codigo da pessoa é invalido.");
            }
        }catch (Exception $e){
        	$this->obTDbo->rollback();
            new setException($e);
        }
    }
    /**
    * Retorna um objeto contendo os dados da pessoa
    * param <codigo> $codigopessoa = codigo pessoa
    * param <colunas> $cols = colunas a serem retornadas ex: ["coluna1, coluna2, coluna3..."]
    * return <objeto> pessoa
    */
    public function getFormacao($codigopessoa, $cols = NULL){
       try{
            if($codigopessoa){

                if(!$cols){ $cols = "*";}

            	$this->obTDbo->setEntidade(TConstantes::VIEW_PESSOAS_FORMACOES);
                    $criteria = new TCriteria();
                    $criteria->add(new TFilter('codigopessoa','=',$codigopessoa));
                $retFormacao = $this->obTDbo->select($cols, $criteria);

                $this->obPessoaFormacao = null;
                if($retFormacao){
                    while($this->obPessoaFormacao = $retFormacao->fetchObject()){
                        $this->vetPessoaFormacao[$this->obPessoaFormacao->codigo] = $this->obPessoaFormacao;
                    }
                }
                return $this->vetPessoaFormacao;

            }else{
                throw new ErrorException("O codigo da pessoa é invalido.");
            }
       }catch (Exception $e){
        	$this->obTDbo->rollback();
            new setException($e);
       }
    }

    /**
    * Retorna um objeto contendo os dados da pessoa
    * param <codigo> $codigopessoa = codigo pessoa
    * return <objeto> pessoa
    */
    public function getTitularidade($codigopessoa){

        try{
            $vetFormacao = $this->getFormacao($codigopessoa, "peso");

            if($vetFormacao){
            foreach($vetFormacao as $obFormacao){
                $escolaridades[$obFormacao->peso] = $obFormacao->peso;
            }
                $this->obTDbo->setEntidade(TConstantes::DBPESSOAS_TITULARIDADES);
                    $criteria = new TCriteria();
                    $criteria->add(new TFilter('peso','=',max($escolaridades)));
                $retFormacao = $this->obTDbo->select('nomeacao', $criteria);

                $this->obTitularidade = $retFormacao->fetchObject();

                return($this->obTitularidade->nomeacao);
            }else{
                return null;
            }


       }catch (Exception $e){
        	$this->obTDbo->rollback();
            new setException($e);
       }
       return $retorno;
    }

}