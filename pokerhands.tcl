
proc isStraightFlush {hand} {
	if {![isFlush $hand] || ![isStraight $hand]} {
		return 0
	}
	return 1
}

proc isFourOfAKind {hand} {
	if {[determineHowManyOfAKind $hand] == 4} {
		return 1
	}
	return 0
}

proc isThreeOfKind {hand} {
	if {[determineHowManyOfAKind $hand] == 3} {
		return 1
	}
	return 0
}

proc determineHowManyOfAKind {hand} {
	set allCounts [dict values [countCardValues $hand]]
	set highestCount [lindex [lsort -decreasing $allCounts] 0]
	return $highestCount
}

# A hand contains only two distinct values;
# each of those values occurs no more than three times
# (assuming a valid hand of 5 cards.)
proc isFullHouse {hand} {
	# TODO: this is lame that countCardValues gets called twice.
	set valueCounts [countCardValues $hand]
	if {[isThreeOfKind $hand] && [llength [dict keys $valueCounts]] == 2} {
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
