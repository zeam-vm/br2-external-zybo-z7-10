# br2-external-zybo-z7-10

This is a br2-external for [Zybo Z7-10](https://digilent.com/reference/programmable-logic/zybo-z7/start).

## How to use

### create buildroot linux

```
$ cd your/working/dir
$ git clone https://github.com/buildroot/buildroot.git
$ cd buildroot
$ git checkout 2023.08.2
$ make BR2_EXTERNAL=/path/to/this-repo zybo_z7_10_defconfig
$ make
# after build, you can find fw image, output/images/zybo_z7_10.fw

# if you want to configure zybo_z7_10_defconfig, invoke below command
$ make menuconfig
```

### burn fw to SD

```
$ sudo fwup output/images/zybo_z7_10.fw
```
