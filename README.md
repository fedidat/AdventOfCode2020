# AdventOfCode2019

These will be my solutions for [AdventOfCode](https://adventofcode.com/) 2020. This year I'm trying to try out as many languages as possible. Here we go!

## One language a day

### Day 1: Elixir

Nope, this is basically Ruby on Erlang and I dislike Ruby.

### Day 2: Kotlin

As a Java programmer that has been looking towards Kotlin for years, this is... special. But by want of modernizing Java, I think this goes too far. The syntax feels a bit inconsistent, although I may be talking out of inexperience.

### Day 3: Java 15

This is my home language and I really enjoy it, the syntax is so consistent. Java 15 is really powerful as well, too bad half the world is stuck on Java 8.

### Day 4: C++20

Back after many years. It changed a lot and it's decent but you can feel that it's an old language with piles of bandaid. Rust is the worthy successor.

### Day 5: Rust

It's been a year and it's really very powerful. It's notably much better than C++ in most areas but the borrow checker and other features are bothersome for quick prototyping like this. At least everything makes sense.

### Day 6: Typscript and Deno

This is good, perhaps better than Java. Strong typing, syntax that makes sense, easy prototyping almost to the level of Python. Install [Deno](https://deno.land/manual@v1.5.4/getting_started/installation) and run `deno test --allow-read`. Regarding Deno it's a better experience than node.js from the standard library alone, but I've barely tried all the features.

### Day 7: Swift

It was hard to setup for Linux but doable, at least Apple made an effort. And it works rather well, although somewhat Go-like in syntax. The package system is nice.

### Day 8: Python 3 with Jupyter notebook

There's just no beating Python for quick prototyping, although who knows, maybe another language will take the crown.

### Day 9: Go

Just as horrible as I remembered. No exceptions, no generics (and no OOP as far as I'm concerned), extremely limited standard library, very opinionated and limited syntax... Sure, it has some amazing aspects like green threads and build time, but how would anyone accept to work with such limited tooling?

### Day 10: Scala 3 (dotty) with SBT

I didn't get it last year but I'm really digging it now! It's a much more productive Java without going overboard like Kotlin. And I barely scratched the surface as I had no time to explore parallelism. I remember SBT being painful but I now realize it is fairly similar to Gradle but with Scala itself instead of a minor scripting language like Groovy.

### Day 11: C# .NET Core 5.0

Wow it really fell behind Java. You can say it tried to copy it but it didn't go well. That way really painful. In addition, the .sln and .csproj formats are awful and mandatory and LINQ requires unpacking custom objects. I see no future for this language.

### Day 12: Perl

Very flexible scripting language, although it may take some time to get used to reading it, it's hard to decipher... CPAN is solid but I hope to never need to diagnose any issue with it.

### Day 13: Dlang

Another exciting language. It feels oddly close to Rust, I suppose as another system language, but with none of the safety features and much more restricted syntactic sugar. It also feels related to Scala through the pipe design. The learning curve may be slightly steep however, and the package manager is mundane json.

### Day 14: Lua

Cool scripting language, but unlike Perl it actually feels old and is overdue a revamp. The standard library is dangerously lean and the syntax feels limited like Go or Ruby. Anyway, nice for prototyping or for learning but inferior to Python and Perl.

### Day 15: PHP

I'm disappointed the problem wasn't more difficult to test interesting features. It's actually decent, although I've worked with large PHP applications and I know the pain comes later. I also wish I had the occasion to try out Hack. Anyway, it's still PHP, it can't be that good right?

### Day 16: Awk

It feels weird to use AWK as a programming language (as intended really), but it's so powerful for the right purpose. It's excellent for very small prototyping as long as you're dealing with a parsable file.

### Day 17: Haskell

Haskell is famous for its purity, so as a beginner I've had to look at solutions for this algorithmically trivial problem. I would need much more practice to feel comfortable. The ecosystem is also not the most intuitive: ghc, ghci, runghc, cabal, stack, etc. It didn't help that haskell.org was down.

### Day 18: Racket

Scheme is so very different from everything, but it was very helpful today since I had to play with mathematical expressions and parenthesis. It has its uses but I'm not sure I'd use it for general purpose programming. I should do SICP.

### Day 19: Ruby

I still don't like anything about Ruby, it's a bad Python.

### Day 20: Julia

Not the fastest language but very powerful, although I only had time to look at a small subset of the features. This feels similar to Python but with MATLAB-like matrix manipulation.

### Day 21: Dart

Another language by Google, made for dummies. Failed JavaScript killer with ((slightly)) different goals than Go. It's like a weak and inconsistent Java. Do not recommend. Still better than Go.

### Day 22: Common Lisp

Lisp makes it very hard to guess what works and what doesn't, I partly had to look at some solutions. The ecosystem is also not playing very nice, I used SBCL's script mode and print-debugging, and the error messages aren't the clearest, no line numbers or anything. However, the raw simplicity feels very powerful. I wish I could spend more time on a Lisp for a while.

### Day 23: GNU Smalltalk

I was curious about Smalltalk because this was a very influential language, inspiring most object-oriented languages that came after it. And indeed the class system influences all mechanics and its conceptual simplicity is very remarkable. But it's opinionated and feels dated, very lacking in documentation, and beaten to pieces in these regards by by Java or Typescript. At this stage, I feel that this is little more than a piece of history, maybe useful for legacy support. I also tried out Pharo but found it unintuitive and not superior to GNU Smalltalk in the problematic areas.

### Day 24: Clojure

Back from last year, and yet another Lisp after Racket and Common Lisp. Its syntax is very powerful but near unreadable if used to its full potential. I didn't use a lot of the Java interop or Leiningen, but I still lament the lack of a proper ecosystem for debugging and without directly using the REPL or print-debugging.

## Coming up

- General purpose: Groovy
- ML-like languages: Ocaml/ReasonML, Elm, F#
