targets += mm/core
target.mm/core.kind := source-set
target.mm/core.sources := \
    mm/memblock.cc mm/pmm.cc mm/slab.cc mm/vmm.cc mm/vma.cc \
    mm/page_cache.cc mm/tlb.cc

