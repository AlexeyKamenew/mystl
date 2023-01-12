#include <string>

#include "mystl/mystl.hpp"

exported_class::exported_class()
    : m_name {"mystl"}
{
}

auto exported_class::name() const -> const char*
{
  return m_name.c_str();
}
