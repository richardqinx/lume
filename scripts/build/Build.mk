targets += build/host-library-smoke build/host-test-smoke build/phys-library-smoke
target.build/host-library-smoke.kind := host-library
target.build/host-library-smoke.sources := scripts/build/tests/host_library.cc

target.build/host-test-smoke.kind := host-test
target.build/host-test-smoke.sources := scripts/build/tests/host_test.cc
target.build/host-test-smoke.private-deps := build/host-library-smoke

target.build/phys-library-smoke.kind := phys-library
target.build/phys-library-smoke.sources := scripts/build/tests/phys_library.cc
