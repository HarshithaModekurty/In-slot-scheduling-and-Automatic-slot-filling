#pragma once

#include <string>
#include <vector>

#include "instruction.h"

namespace sched {

Program parseAssemblyFile(const std::string& path);
Program parseAssemblyString(const std::string& source);

}  // namespace sched
