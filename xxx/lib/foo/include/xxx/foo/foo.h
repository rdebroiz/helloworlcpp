#pragma once

#include <xxx/foo/export.h>
#include <xxx/foo/foo.h>

namespace xxx {
namespace foo {

class XXX_FOO_EXPORT Foo {
    public:
        Foo() = default;
        ~Foo() = default;

        void trigger();
};

}
}