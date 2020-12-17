BEGIN { FS = ":|-| or " }

/ or / { # range rule, add all values in both ranges, note field name
	for (i = $2; i <= $3; i++) {
        range[i]
        fieldvalid[$1,i] 
    }
	for (i = $4; i <= $5; i++) {
        range[i]
        fieldvalid[$1,i] 
    }
	fieldnames[$1]
}

/your ticket/ { # protagonists's ticket, mark all fields possible for all indexes
	getline
	FS = ","
	fieldssize = split($0, ticket)
	for (i = 1; i <= fieldssize; i++)
		for (fieldname in fieldnames)
            possible[fieldname, i]
}

/nearby tickets/, 0 { # nearby tickets, calculate whether valid
	invalid = 0
	for (i = 1; i <= NF; i++)
        if (!($i in range))
		    invalid += $i
	errorrate += invalid

    if (invalid == 0) # valid ticket, remove invalid range combinations
        for (; $invalid; invalid++)
            for (fieldname in fieldnames)
                if (!((fieldname, $invalid) in fieldvalid))
                    delete possible[fieldname, invalid]
}

END {
	for (position = 1; position;) { # try each field at each position
		position = 0
		for (field in fieldnames) {
			n = 0

			for (i = 1; i <= fieldssize; i++) { # if not invalidated, mark as possible for this position
				if ((field,i) in possible) {
					n++
					position = i
				}
			}
            
			if (n == 1) { # if field has one possibility, confirm and clean up for other fields
				confirmed[field] = position
				for (x in fieldnames)
                    delete possible[x, position]
			}
		}
	}

	departurefields = 1 # multiply departure fields together
	for (fieldname in confirmed)
        if (fieldname ~ /^departure/)
		    departurefields *= ticket[confirmed[fieldname]]

	print "Part 1 " errorrate
	print "Part 2 " departurefields
}