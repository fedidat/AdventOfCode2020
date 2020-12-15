package com.fedidat.aoc20;

import com.google.common.io.Resources;

import java.io.IOException;
import java.nio.charset.StandardCharsets;

@SuppressWarnings("UnstableApiUsage")
public class Utils {
    public static String getResourceInput(String filename) {
        try {
            return Resources.toString(Resources.getResource(filename), StandardCharsets.UTF_8);
        } catch (IOException e) {
            //Assume input exists
            throw new RuntimeException("Could not get input file %s as resource".formatted(filename), e);
        }
    }
}
