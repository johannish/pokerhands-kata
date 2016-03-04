
proc isStraightFlush {hand} {
	if {![isFlush $hand] || ![isStraight $hand]} {
		return 0
	}
	return 1
}

proc isFourOfAKind {hand} {
	return [expr {[dict get [getHandStats $hand] highOccurrenceCount] == 4}]
}

proc isThreeOfKind {hand} {
	return [expr {[dict get [getHandStats $hand] highOccurrenceCount] == 3}]
}

proc getHandStats {hand} {
	set valuesToCount [countCardValues $hand]
	set allCounts [dict values $valuesToCount]
	set highestCount [lindex [lsort -decreasing $allCounts] 0]
	return [dict create highOccurrenceCount $highestCount uniqueValues [dict keys $valuesToCount]]
}

# Assumes a valid hand of 5 cards.
proc isFullHouse {hand} {
	set handStats [getHandStats $hand]
	if {[dict get $handStats highOccurrenceCount] == 3 && [llength [dict get $handStats uniqueValues]] == 2} {
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

proc isStraight {hand} {
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

proc countCardValues {hand} {
	set countsByValue [dict create]
	foreach cardVal [join [dict values $hand]] {
		dict incr countsByValue $cardVal
	}
	return $countsByValue
}
