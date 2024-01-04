#pragma once

#include <yyy/foo/export.h>

#include <xxx/foo/foo.h>
#include <xxx/bar/bar.h>

namespace yyy {
namespace foo {

class YYY_FOO_EXPORT Foo {
    public:
        Foo() = default;
        ~Foo() = default;

        void trigger();

        xxx::foo::Foo xxxFoo;
        xxx::bar::Bar xxxBar;
};

} // eon foo
} // eon yyy