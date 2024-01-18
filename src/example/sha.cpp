#include "example/sha.hpp"
#include <openssl/evp.h>

namespace example {

bool SHA1Calculator::calculateSHA1(const std::string& filePath, std::string& sha1CS) {
    FILE* file = fopen(filePath.c_str(), "rb");
    if (!file) {
        return false;
    }

    EVP_MD_CTX* mdContext = EVP_MD_CTX_new();
    if (!mdContext) {
        fclose(file);
        return false;
    }

    const int bufSize = 1024;
    unsigned char buffer[bufSize];

    EVP_DigestInit(mdContext, EVP_sha1());

    size_t bytesRead;
    while ((bytesRead = fread(buffer, 1, bufSize, file)) > 0) {
        EVP_DigestUpdate(mdContext, buffer, bytesRead);
    }

    EVP_DigestFinal(mdContext, buffer, nullptr);

    sha1CS.clear();
    for (int i = 0; i < EVP_MD_size(EVP_sha1()); ++i) {
        sha1CS += charToHex(buffer[i]);
    }

    EVP_MD_CTX_free(mdContext);
    fclose(file);

    return true;
}

std::string SHA1Calculator::charToHex(unsigned char c) {
    const char hexDigits[] = "0123456789abcdef";
    std::string result;
    result += hexDigits[c >> 4];
    result += hexDigits[c & 0xf];
    return result;
}

} // namespace example
