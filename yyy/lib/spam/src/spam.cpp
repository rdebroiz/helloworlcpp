#include <yyy/spam/spam.h>

#include <iostream>

void yyy::spam::Spam::trigger() {
    std::cout << "---" << std::endl;
    std::cout << "trigerring spam." << std::endl;
    std::cout << "---" << std::endl;
    this->bar.trigger();
    std::cout << "---" << std::endl;
    this->foo.trigger();
    std::cout << "---" << std::endl;
}