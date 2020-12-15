package com.fedidat.aoc20

import java.nio.charset.Charset

class Utils {
    companion object {
        fun getInput(fileName: String): String =
            this::class.java.classLoader.getResource(fileName).readText(Charset.defaultCharset())
    }
}