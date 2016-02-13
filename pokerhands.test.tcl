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

::tcltest::test isFullHouse_true {
} -body {
    set input [dict create a 1 b 1 c {1 2} d 2]
    return [isFullHouse $input]
} -result {1}

::tcltest::test isFullHouse_true_2 {
} -body {
    set input [dict create a {1 3 3} b {1 3}]
    return [isFullHouse $input]
} -result {1}

::tcltest::test isFullHouse_false {
} -body {
    set input [dict create a 1 b 2 c {3 9} d 4]
    return [isFullHouse $input]
} -result {0}

::tcltest::test isFullHouse_false_2 {
} -body {
    set input [dict create a {1 1 1} b {1 3}]
    return [isFullHouse $input]
} -result {0}

::tcltest::test invertDict {
} -body {
	set input [dict create a {1 2 3} b {1 2}]
    set result [invertDict $input]
    return [expr {$result eq {1 {a b} 2 {a b} 3 a}}]
} -result 1

::tcltest::cleanupTests
