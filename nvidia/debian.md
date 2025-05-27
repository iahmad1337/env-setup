# Official nvidia documentation [SOLUTION]

## 1. Install cuda
- [Documentation](https://docs.nvidia.com/cuda/cuda-installation-guide-linux)

TL;DR:
- install suitable deb from [cuda download
  page](https://developer.nvidia.com/cuda-downloads)
- do step 3.9, reboot
- do step 10 + clone [samples](https://github.com/nvidia/cuda-samples) - they
  will compile but won't work, because there are no nvidia drivers yet

## 2. Install drivers
- [Documentation](https://docs.nvidia.com/datacenter/tesla/driver-installation-guide/index.html)

I precisely followed the instruction + did some tweaks.
Here's a brief history (everything performed under the root):
```bash
export arch_ext=amd64
export arch=x86_64
export distro=debian12
apt search "linux-headers"
apt search "linux-headers-$(uname -r)"
apt install linux-headers-6.1.0-35-amd64
apt search nvidia-driver-assistant
apt install nvidia-driver-assistant
nvidia-driver-assistant
nvidia-driver-assistant --install --module-flavor closed

# Here, nvidia-driver-assistant said, that it conflicts with package libnppc11, so we purge it
apt --fix-broken install  # don't know, if this was mandatory
apt search libnppc11
apt purge libnppc11
nvidia-driver-assistant --install --module-flavor closed
reboot
```

And voila, `nvtop` now works and shows both amd iGPU and the nvidia card!

Also, check that the compiled cuda samples now work.

# Debian wiki [FAIL]
OS - debian 12 (bookworm):
```
$ uname --all
Linux localhost 6.1.0-35-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.1.137-1 (2025-05-07) x86_64 GNU/Linux
```

There are multiple ways to install the drivers, I chose the easiest one - the
default package (535 display driver + cuda):
- Debian wiki:
    - [original link](https://wiki.debian.org/NvidiaGraphicsDrivers)
    - [wayback machine](https://web.archive.org/web/20250516214951/https://wiki.debian.org/NvidiaGraphicsDrivers/)

didn't work!!!!


# Other useful sources
- [Ubuntu tutorial](https://documentation.ubuntu.com/server/how-to/graphics/install-nvidia-drivers/index.html)
- [Nvidia tutorial for linux](https://docs.nvidia.com/cuda/cuda-installation-guide-linux)
- [Nvidia cuda toolkit installe](https://developer.nvidia.com/cuda-downloads) -
  didn't work
- [CUDA samples](https://github.com/NVIDIA/cuda-samples) - useful to check,
  whether nvcc works
