
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
