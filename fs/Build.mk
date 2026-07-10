targets += fs/core
target.fs/core.kind := source-set
target.fs/core.sources := \
    fs/super.cc fs/inode.cc fs/dcache.cc fs/file_table.cc fs/fd.cc \
    fs/fs_struct.cc fs/namei.cc fs/ramfs/inode.cc fs/ramfs/file.cc \
    fs/ramfs/super.cc fs/vfs_init.cc fs/chardev.cc fs/devfs.cc fs/pipe.cc \
    fs/initramfs.cc

