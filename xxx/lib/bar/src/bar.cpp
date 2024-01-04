#include <xxx/bar/bar.h>

#include <iostream>

void xxx::bar::Bar::trigger() {
    std::cout << "trigerring xxx::bar." << std::endl;
    this->foo.trigger();
}