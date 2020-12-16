<?php

function run($filename, $rounds) {
    $input = explode(",", file_get_contents($filename));

    $last_spoken = array_pop($input);
    $round = count($input);
    $memory = array();
    foreach (array_values($input) as $i => $val)
        $memory[$val] = $i + 1;

    while (++$round < $rounds) {
        if (isset($memory[$last_spoken])) {
            $previous_turn = $memory[$last_spoken];
            $memory[$last_spoken] = $round;
            $last_spoken = $round - $previous_turn;
        }
        else {
            $memory[$last_spoken] = $round;
            $last_spoken = 0;
        }
    }

    return $last_spoken;
}

echo "Part 1 (sample): ", run("day15-sample.txt", 2020), "\n";
echo "Part 2 (sample): ", run("day15-sample.txt", 30000000), "\n";
echo "Part 1: ", run("day15.txt", 2020), "\n";
echo "Part 2: ", run("day15.txt", 30000000), "\n";

?>