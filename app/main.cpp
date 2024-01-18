#include "example/sha.hpp"
#include <iostream>

using namespace example;

int main(void) {
  SHA1Calculator shaCalc;

  std::string filePath = "example.txt";
  std::string sha1CS;
  std::cout << "Testing SHA1" << std::endl;
  if (shaCalc.calculateSHA1(filePath, sha1CS)) {
    std::cout << "SHA-1 checksum for file " << filePath << ": " << sha1CS
              << std::endl;
  }
}