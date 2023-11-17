#pragma once

#include <xxx/foo/foo.h>
#include <xxx/bar/bar.h>

namespace yyy {
namespace spam {

class Spam {
    public:
        Spam() = default;
        ~Spam() = default;

        void trigger();

        xxx::foo::Foo foo;
        xxx::bar::Bar bar;
};

}
}