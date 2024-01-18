#ifndef SHA1_HPP
#define SHA1_HPP

#include <string>
#include <vector>

namespace example {
class SHA1Calculator {
public:
    bool calculateSHA1(const std::string& filePath, std::string& sha1Checksum);

private:
        std::string charToHex(unsigned char c);
};
} //namespace example
#endif // SHA1_CALCULATOR_HPP
