#ifndef CPP_UTILS_HPP
#define CPP_UTILS_HPP

#include <string>

class Utils {
public:
    static std::string readFile(const std::string& filename);
    static std::vector<std::string> split(const std::string& input, const std::regex& delimiter);
};


#endif //CPP_UTILS_HPP
