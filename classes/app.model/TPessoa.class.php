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
     * param <seq> $seqpessoa = seqpessoa
     * return <objeto> pessoa
     */
    public function getPessoa($seqpessoa){
         try{
            if($seqpessoa){
            	$this->obTDbo->setEntidade(TConstantes::DBPESSOA);
                    $criteria = new TCriteria();
                    $criteria->add(new TFilter(TConstantes::SEQUENCIAL,'=',$seqpessoa));
                $retPessoa = $this->obTDbo->select("*", $criteria);
                $this->obPessoa = $retPessoa->fetchObject();

                return $this->obPessoa;
            }else{
                throw new ErrorException("O seqda pessoa é invalido.");
            }
        }catch (Exception $e){
        	$this->obTDbo->rollback();
            new setException($e);
        }
    }

    /**
    * Retorna um objeto contendo os dados do funcionario
    * param <seq> $seqpessoa = seqpessoa
    */

    public function getFuncionario($seqpessoa){
         try{
            if($seqpessoa){

            	$this->obTDbo->setEntidade(TConstantes::VIEW_PESSOAS_FUNCIONARIOS);
                $criteriaFunc = new TCriteria();
                $criteriaFunc->add(new TFilter(TConstantes::SEQUENCIAL,'=',$seqpessoa));
                $retFuncionario = $this->obTDbo->select("funcseq as seq,cargseq,nomecargo,deptseq,nomedepartamento,salaseq,nomesala,dataadmissao", $criteriaFunc);

                if($this->obFuncionario = $retFuncionario->fetchObject()){
                    return $this->obFuncionario;
                }else{
                    return null;
                }

            }else{
                throw new ErrorException("O seq da pessoa é invalido.");
            }
        }catch (Exception $e){
        	$this->obTDbo->rollback();
            new setException($e);
        }
    }

    /**
    * Retorna um objeto contendo os dados da pessoa
    * param <seq> $seqpessoa = seqpessoa
    * param <colunas> $cols = colunas a serem retornadas ex: ["coluna1, coluna2, coluna3..."]
    * return <objeto> pessoa
    */
    public function getFormacao($seqpessoa, $cols = NULL){
       try{
            if($seqpessoa){

                if(!$cols){ $cols = "*";}

            	$this->obTDbo->setEntidade(TConstantes::VIEW_PESSOAS_FORMACOES);
                    $criteria = new TCriteria();
                    $criteria->add(new TFilter('pessseq','=',$seqpessoa));
                $retFormacao = $this->obTDbo->select($cols, $criteria);

                $this->obPessoaFormacao = null;
                if($retFormacao){
                    while($this->obPessoaFormacao = $retFormacao->fetchObject()){
                        $this->vetPessoaFormacao[$this->obPessoaFormacao->seq] = $this->obPessoaFormacao;
                    }
                }
                return $this->vetPessoaFormacao;

            }else{
                throw new ErrorException("O seqda pessoa é invalido.");
            }
       }catch (Exception $e){
        	$this->obTDbo->rollback();
            new setException($e);
       }
    }

    /**
    * Retorna um objeto contendo os dados da pessoa
    * param <seq> $seqpessoa = seqpessoa
    * return <objeto> pessoa
    */
    public function getTitularidade($seqpessoa){

        try{
            $vetFormacao = $this->getFormacao($seqpessoa, "peso");

            if($vetFormacao){
            foreach($vetFormacao as $obFormacao){
                $escolaridades[$obFormacao->peso] = $obFormacao->peso;
            }
                $this->obTDbo->setEntidade(TConstantes::DBPESSOA_TITULARIDADES);
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