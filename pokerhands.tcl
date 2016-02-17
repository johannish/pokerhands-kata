
proc isStraightFlush {hand} {
	if {![isFlush $hand]} {
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

# A hand contains only two distinct values;
# each of those values occurs no more than three times
# (assuming a valid hand of 5 cards.)
proc isFullHouse {hand} {
	set valueCounts [dict create]
	foreach cardVal [join [dict values $hand]] {
		set tuple [dict incr valueCounts $cardVal]
		set count [dict get $tuple $cardVal]
		if {$count > 3} {
			return 0
		}
	}
	if {[llength [dict keys $valueCounts]] == 2} {
		return 1
	} else {
		return 0
	}
}

proc isFlush {hand} {
	if {[dict size $hand] > 1} {
		return 0
	}
	return 1
}
