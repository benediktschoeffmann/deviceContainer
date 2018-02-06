<?php
class Oe24Benchmarker {
	private static $instance;

	private static $startTime;

	private static $buffer = array();

	public static function getInstance() {
	    if (self::$instance === NULL) {
	        self::$instance = new self();
	        self::$startTime = microtime(true);
	        self::$buffer[] = "\n \n \n Oe24Benchmarker Start";
	    }

	    return self::$instance;
	}

	public function setBenchmark($name) {
		$this->setCheckPoint($name);
	}

	public function setCheckPoint($name) {

		$time = microtime(true) - self::$startTime;

		$time = number_format($time, 4, '.', '');
		self::$buffer[] = "Oe24BM::$name: ".$time;
	}

	public function printBenchmarks() {
		if (spunQ::inMode(spunQ::MODE_DEVELOPMENT)) {
			$benchmarks = implode("\n", self::$buffer);
			debug($benchmarks);
		} else {
			error($benchmarks);
		}
	}

	public function getCheckPoints() {
		return self::$buffer;
	}
}
