#include <string>

#include "mystl/mystl.hpp"

auto main() -> int
{
  auto const exported = exported_class {};

  return std::string("mystl") == exported.name() ? 0 : 1;
}
