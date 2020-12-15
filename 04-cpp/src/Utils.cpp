//
// Created by ben on 12/4/20.
//

#include <sstream>
#include <fstream>
#include <vector>
#include <regex>
#include "Utils.hpp"

std::string Utils::readFile(const std::string& filename) {
    std::ifstream ifs(filename);
    return std::string((std::istreambuf_iterator<char>(ifs)),
                  (std::istreambuf_iterator<char>()));
}

std::vector<std::string> Utils::split(const std::string& input, const std::regex& delimiter) {
    std::sregex_token_iterator first{input.begin(), input.end(), delimiter, -1}, last;
    return std::vector<std::string>{first, last};
}
