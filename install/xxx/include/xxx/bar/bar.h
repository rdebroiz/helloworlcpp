#pragma once

#include <xxx/foo/foo.h>

namespace xxx {
namespace bar {

class Bar {
    public:
        Bar() = default;
        ~Bar() = default;

        void trigger();

        foo::Foo foo;
};

}
}