# Change Log

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/).

## r13 - 2025-01-23

### Added
- Enabled multi-platform build for `linux/amd64` and `linux/arm64`

### Changed
- Improved *default* command-line parameters for `swtpm` invocation

## r12 - 2025-01-15

### Changed
- swtpm: Updated to revision `3d6a8b75b335` (2024-12-27)
- libtpms: Updated to revision `ecb769cdb8dd` (2024-12-16)
- Base system: Updated to `alpine:3.21.2` (2025-01-08)

## r11 - 2024-12-06

### Changed
- swtpm: Updated to revision `314f5f411b32` (2024-12-02)
- libtpms: Updated to revision `f22745c72933` (2024-11-15)
- Base system: Updated to `alpine:3.21.0` (2024-12-05)

## r10 - 2024-09-28

### Changed
- swtpm: Updated to revision `2e2124928f38` (2024-09-27)
- libtpms: Updated to revision `6adb99a42cf6` (2024-09-24)

## r9 - 2024-09-18

### Added
- Included `swtpm_{bios,cert,ioctl,localca,setup}` tools in the image.

### Changed
- swtpm: Updated to revision `017f99ceddb0` (2024-09-17)
- libtpms: Updated to revision `e898872637b4` (2024-09-13)

## r8 - 2024-09-13

### Changed
- swtpm: Updated to revision `28292591cbef` (2024-09-12)
- libtpms: Updated to revision `46548da8edbf` (2024-09-12)

## r7 - 2024-09-08

### Changed
- Base system: Updated to `alpine:3.20.3` (2024-09-06)

## r6 - 2024-09-05

### Changed
- swtpm: Updated to revision `607eb54b3e52` (2024-09-03)
- libtpms: Updated to revision `e983cdf05c4e` (2024-09-03)

## r5 - 2024-09-01

### Changed
- swtpm: Updated to revision `0ddc7ed25491` (2024-08-30)
- libtpms: Updated to revision `f5518e596e65` (2024-08-31)

## r4 - 2024-08-29

### Changed
- Implemented Multi-stage build to further reduce image size.

## r3 - 2024-08-29

### Changed
- Switched base system from `debian:bookworm-slim` to `alpine:3.20.2`

## r2 - 2024-08-27

### Changed
- swtpm: Updated to revision `54583a87b536` (2024-08-27)
- libtpms: Updated to revision `2dc1af12e5b0` (2024-08-21)
- Switched base system from `debian:bookworm` to `debian:bookworm-slim`

## r1 - 2024-08-27

- This is the first public release of this project.
