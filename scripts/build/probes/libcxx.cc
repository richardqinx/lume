// SPDX-License-Identifier: GPL-2.0-or-later

#include <array>
#include <atomic>
#include <optional>
#include <span>
#include <string_view>
#include <type_traits>

constexpr std::array<int, 3> kValues{1, 2, 3};
static_assert(kValues[2] == 3);
static_assert(std::is_same_v<std::span<const int>::element_type, const int>);
static_assert(std::string_view{"libc++"}.size() == 6);

using Optional = std::optional<unsigned long>;
using Atomic = std::atomic<unsigned long>;
