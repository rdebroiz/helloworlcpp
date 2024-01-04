#include <yyy/foo/foo.h>

#include <iostream>

void yyy::foo::Foo::trigger() {
    std::cout << "---" << std::endl;
    std::cout << "trigerring yyy::foo." << std::endl;
    std::cout << "---" << std::endl;
    this->xxxBar.trigger();
    std::cout << "---" << std::endl;
    this->xxxFoo.trigger();
    std::cout << "---" << std::endl;
}