#include <iostream>
#include <vector>
#include <regex>
#include <set>
#include "../Utils.hpp"

class Passport {
public:
    std::map<std::string, std::string> values;
    std::vector<std::string> required {
            "byr", // Birth Year
            "iyr", // Issue Year
            "eyr", // Expiration Year
            "hgt", // Height
            "hcl", // Hair Color
            "ecl", // Eye Color
            "pid", // Passport ID
    };
    std::vector<std::string> optional {
            "cid" //Country ID
    };
    bool valid;

    explicit Passport(const std::vector<std::string>& fields, int version) {
        for (auto& field : fields) {
            std::vector<std::string> tokens = Utils::split(field, std::regex(":"));
            values.insert(std::pair<std::string, std::string>(tokens.at(0), tokens.at(1)));
        }
        valid = version == 1 ? isValid_v1() : isValid_v2();
    }
private:
    bool isValid_v1() {
        return !std::any_of(required.begin(), required.end(),
                            [this](const std::string &field) { return values.count(field) == 0; });
    }

    std::map<std::string, std::string> validations {
        // byr (Birth Year) - four digits; at least 1920 and at most 2002.
        std::pair<std::string, std::string>("byr", "^(19[2-9]\\d|200[12])$"),
        // iyr (Issue Year) - four digits; at least 2010 and at most 2020.
        std::pair<std::string, std::string>("iyr", "^20(1\\d|20)$"),
        // eyr (Expiration Year) - four digits; at least 2020 and at most 2030.
        std::pair<std::string, std::string>("eyr", "^20(2\\d|30)$"),
        // hgt (Height) - a number followed by either cm or in:
        //     If cm, the number must be at least 150 and at most 193.
        //     If in, the number must be at least 59 and at most 76.
        std::pair<std::string, std::string>("hgt", "^(1([5-8]\\d|9[0-3])cm|(59|6\\d|7[0-6])in)$"),
        // hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
        std::pair<std::string, std::string>("hcl", "^#[0-9a-f]{6}$"),
        // ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
        std::pair<std::string, std::string>("ecl", "^(amb|blu|brn|gry|grn|hzl|oth)$"),
        // pid (Passport ID) - a nine-digit number, including leading zeroes.
        std::pair<std::string, std::string>("pid", "^\\d{9}$")
    };
    bool isValid_v2() {
        try {
            if (std::any_of(validations.begin(), validations.end(),
           [this](const std::pair<std::string, std::string>& validation) {
                    return !std::regex_match(values.at(validation.first), std::regex(validation.second));}))
                return false;
        }
        catch (const std::out_of_range& a) {
            return false;
        }
        return true;
    }
};

int solve(const std::string& filename, int version) {
    std::string input = Utils::readFile(filename);
    std::vector<std::string> rawLines = Utils::split(input, std::regex("\n\n"));

    return std::count_if(rawLines.begin(), rawLines.end(), [version](const std::string &line) {
        return Passport(Utils::split(line, std::regex("[\n ]")), version).valid;
    });
}

int main() {
    std::cout << "Part 1 sample answer: " << solve("../input/Day04-part1-sample.txt", 1) << std::endl;
    std::cout << "Part 2 valid answer: " << solve("../input/Day04-part2-valid-sample.txt", 2) << std::endl;
    std::cout << "Part 2 invalid answer: " << solve("../input/Day04-part2-invalid-sample.txt", 2) << std::endl;
    std::cout << "Part 1 answer: " << solve("../input/Day04.txt", 1) << std::endl;
    std::cout << "Part 2 answer: " << solve("../input/Day04.txt", 2) << std::endl;
    return 0;
}
