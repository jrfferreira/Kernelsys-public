<?php 

class TPageExecutionTimer {

    private $executionTime;

    public function __construct(){

        $this->executionTime = microtime(true);

    }

    public function __destruct() {

        print('<hr>'.(microtime(true)-$this->executionTime));

    }

}