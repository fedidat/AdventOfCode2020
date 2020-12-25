(ns day24.core-test
  (:require [clojure.test :as test]
            [day24.core :as sol]))

(test/deftest part1-sample-test
  (test/testing "Part 1 sample"
    (let [input (sol/get-input "day24-sample.txt")]
      (test/is (= (sol/part1 input) 10)))))

(test/deftest part2-sample-test
  (test/testing "Part 2 sample"
    (let [input (sol/get-input "day24-sample.txt")]
      (test/is (= (sol/part2 input) 2208)))))

(test/deftest part1-test
  (test/testing "Part 1"
    (let [input (sol/get-input "day24.txt")]
      (test/is (= (sol/part1 input) 427)))))

(test/deftest part2-test
  (test/testing "Part 2"
    (let [input (sol/get-input "day24.txt")]
      (test/is (= (sol/part2 input) 3837)))))