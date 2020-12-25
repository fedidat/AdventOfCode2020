#!/usr/local/bin/gst -q

Character extend [
    asDigit [
        ^self value - $0 value
    ]
]

Object subclass: Solution [
    | input |
    
    with: the_input [
        input := the_input
    ]

    part1 [
        | cup_ring result current |
        cup_ring := self runGame: false turns: 100 ring_size: 9.
        result := ''.
        current := 1.
        [ (current := cup_ring at: current) ~= 1 ] whileTrue: [
            result := (result, current asString). 
        ].
        ^result.
    ]

    part2 [
        | cup_ring |
        cup_ring := self runGame: true turns: 10_000_000 ring_size:1_000_000.
        ^((cup_ring at: 1) * (cup_ring at: (cup_ring at: 1))).
    ]

    runGame: isPart2 turns: aTurns ring_size: aRing_size [
        | cup_ring current position grabbed destination old_curr_pos |
        
        cup_ring := Array new: aRing_size.
        input fold: [ :a :b | cup_ring at: a put: b ].

        " If part 2, start incrementing from end of original ring "
        (isPart2)
            ifFalse: [
                cup_ring at: input last put: input first.
            ]
            ifTrue: [
                cup_ring at: input last put: 10.
                (10 to: (aRing_size - 1)) do: [ :i | cup_ring at: i put: (i + 1) ].
                cup_ring at: aRing_size put: input first.
            ].

        current := input first.
        (1 to: aTurns) do: [ :turn |
            (turn \\ 10000 = 0) ifTrue: [ stdout nextPutAll: 'Turn: ', turn asString; cr; flush ]. "Print progress"

            position := current.

            " Grab 3 cups "
            grabbed := Set with: 0.
            (1 to: 3) do: [ 
                :i | position := cup_ring at: position.
                grabbed add: position 
            ].

            " Calculate destination for block: current cup value, or if grabbed keep decreasing values "
            destination := current - 1.
            [ grabbed includes: destination ] whileTrue: [
                destination := (destination - 1) \\ (aRing_size + 1)
            ].

            " Put link back into ring "
            old_curr_pos := cup_ring at: current.
            cup_ring at: current     put: (cup_ring at: position).    " Current points to after block "
            cup_ring at: position    put: (cup_ring at: destination). " End block to old after destination "
            cup_ring at: destination put:old_curr_pos.                " Destination is start of block "

            current := cup_ring at: current.
        ].

        ^cup_ring.
    ]
]

Eval [
    " filename := 'day23-sample.txt'. "
    filename := 'day23.txt'.
    input := OrderedCollection new.
    (FileStream open: filename) do: [ :c | input add: c asDigit ].
    sol := Solution new with: input.
    Transcript show: 'Part 1: ', (sol part1) asString. stdout nl.
    Transcript show: 'Part 2: ', (sol part2) asString. stdout nl.
]