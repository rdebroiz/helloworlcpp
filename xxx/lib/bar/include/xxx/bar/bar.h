#pragma once

#include <xxx/bar/export.h>

#include <xxx/foo/foo.h>

namespace xxx {
namespace bar {

class XXX_BAR_EXPORT Bar {
    public:
        Bar() = default;
        ~Bar() = default;

        void trigger();

        foo::Foo foo;
};

}
}