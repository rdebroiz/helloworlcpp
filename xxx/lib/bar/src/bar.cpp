#include <xxx/bar/bar.h>

#include <iostream>

void xxx::bar::Bar::trigger() {
    std::cout << "trigerring bar." << std::endl;
    this->foo.trigger();
}