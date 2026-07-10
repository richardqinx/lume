# fs/module.mk — VFS subsystem build rules

SRCS_CC += fs/super.cc
SRCS_CC += fs/inode.cc
SRCS_CC += fs/dcache.cc
SRCS_CC += fs/file_table.cc
SRCS_CC += fs/fd.cc
SRCS_CC += fs/fs_struct.cc
SRCS_CC += fs/namei.cc
SRCS_CC += fs/ramfs/inode.cc
SRCS_CC += fs/ramfs/file.cc
SRCS_CC += fs/ramfs/super.cc
SRCS_CC += fs/vfs_init.cc
SRCS_CC += fs/chardev.cc
SRCS_CC += fs/devfs.cc
SRCS_CC += fs/pipe.cc
SRCS_CC += fs/initramfs.cc
