package require tcltest

source ./pokerhands.tcl

::tcltest::test isStraightFlush_multipleSuits_false {
} -body {
	set input [dict create a {1 2 3} b 5 c 1]
	return [isStraightFlush $input]
} -result {0}

::tcltest::test isStraightFlush_singleSuit_false {
} -body {
	set input [dict create a {1 2 3 5 1}]
	return [isStraightFlush $input]
} -result {0}

::tcltest::test isStraightFlush_true {
} -body {
	set input [dict create a {1 2 3 4 5}]
	return [isStraightFlush $input]
} -result {1}

::tcltest::test isFourOfAKind_true {
} -body {
	set input [dict create a {1 2 3 4} b 1]
	return [isFourOfAKind $input]
} -result {1}

::tcltest::test isFourOfAKind_false {
} -body {
	set input [dict create a {1 2 3} b {1 2}]
	return [isFourOfAKind $input]
} -result {0}

::tcltest::cleanupTests
