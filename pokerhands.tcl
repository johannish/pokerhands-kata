
proc isStraightFlush {hand} {
	if {[dict size $hand] > 1} {
		return 0
	}

	set orderedCardVals [lsort -integer [lindex $hand 1]]
	set prevCardVal 0
	for {set x 0} {$x < [llength $orderedCardVals]} {incr x} {
		set cardVal [lindex $orderedCardVals $x]
		if {$cardVal != [expr $prevCardVal + 1]} {
			return 0
		}
		set prevCardVal $cardVal
	}

	return 1
}

proc isFourOfAKind {hand} {
	dict for {suit cardVals} $hand {
		if {[llength $cardVals] >= 4} {
			return 1
		}
	}
	return 0
}

proc isFullHouse {hand} {
	set suitsByValue [invertDict $hand]
	puts $suitsByValue
	set noValueExistsMoreThanThreeTimes 1
	foreach suits [dict values $suitsByValue] {
		if {[llength $suits] > 3} {
			set noValueExistsMoreThanThreeTimes 0
		}
	}
	if {[llength [dict keys $suitsByValue]] == 2 && $noValueExistsMoreThanThreeTimes} {
		return 1
	}
	return 0
}

proc invertDict {dictionary} {
	set inverted [dict create]
	dict for {key val} $dictionary {
		foreach item $val {
			dict lappend inverted $item $key
		}
	}
	return $inverted
}
