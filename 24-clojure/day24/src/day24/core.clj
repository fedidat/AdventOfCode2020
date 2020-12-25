(ns day24.core
  (:require [clojure.java.io :as io]
            [clojure.string :as str]))

(def directions
  (zipmap ["nw" "ne" "e" "w" "sw" "se"]
          (for [dy [-1 0 1] dx (if (zero? dy) [2 -2] [-1 1])]
            (fn [[x y]] [(+ x dx) (+ y dy)]))))

(defn get-input [filename]
  (map #(re-seq #"e|se|sw|w|nw|ne" %)
       (str/split-lines (slurp (io/resource filename)))))

(defn path-to-tile [path]
  (reduce #((directions %2) %1) [0 0] path))

(defn black-tiles [input]
  (reduce (fn [bs t] (if (bs t) (disj bs t) (conj bs t))) #{}
          (map path-to-tile input)))

(defn neighbors [tile]
  (map #(% tile) (vals directions)))

(defn flip-all [tiles]
  (set (for [[tile n] (frequencies (mapcat neighbors tiles))
             :when (or (= n 2) (and (<= 1 n 2) (tiles tile)))]
         tile)))

(defn part1 [input] (count (black-tiles input)))
(defn part2 [input] (->> (iterate - (black-tiles input)) (drop 100) first count))

(defn -main []
  (let [input (get-input "day24.txt")]
    (println "Part 1:" (part1 input))
    (println "Part 2:" (part2 input))))
