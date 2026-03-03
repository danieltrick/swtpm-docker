# Change Log

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/).

## r23 - 2026-03-03

### Changed
- swtpm: Updated to revision `f0606348e97a` (2026-03-02)
- libtpms: Updated to revision `9787502b169d` (2026-03-02)

### Fixed
- Implemented workaround for buffer size check failing in `CryptParameterDecryption()` function.

## r22 - 2026-02-24

### Changed
- swtpm: Updated to revision `48358b244da8` (2026-02-12)
- libtpms: Updated to revision `712ab4d53132` (2026-02-23)

## r21 - 2026-01-29

### Changed
- Base system: Updated to `alpine:3.23.3` (2026-01-28)

## r20 - 2026-01-23

### Changed
- libtpms: Updated to revision `c2a8109f8b44` (2026-01-20)

## r19 - 2026-01-06

### Changed
- libtpms: Updated to revision `fc8820cfaa8b` (2026-01-02)
- Base system: Updated to `alpine:3.23.2` (2025-12-18)

## r18 - 2025-12-11

### Changed
- swtpm: Updated to revision `d41849c30e78` (2025-11-30)
- libtpms: Updated to revision `4f71e9b45db1` (2025-12-03)
- Base system: Updated to `alpine:3.23.0` (2025-12-03)

## r17 - 2025-11-05

### Changed
- swtpm: Updated to revision `8084873972b4` (2025-10-01)
- libtpms: Updated to revision `7310725524c2` (2025-10-16)
- Base system: Updated to `alpine:3.22.2` (2025-10-08)

## r16 - 2025-08-12

### Changed
- swtpm: Updated to revision `665486b8179f` (2024-08-06)
- libtpms: Updated to revision `b4d81572c15b` (2025-08-07)
- Base system: Updated to `alpine:3.22.1` (2025-07-15)

## r15 - 2025-06-12

### Changed
- swtpm: Updated to revision `4a0e632f3731` (2024-05-29)
- libtpms: Updated to revision `04b2d8e9afc0` (2025-06-10)
- Base system: Updated to `alpine:3.22.0` (2025-05-30)

## r14 - 2025-02-20

### Changed
- Base system: Updated to `alpine:3.21.3` (2025-02-13)

## r13 - 2025-01-23

### Added
- Enabled multi-platform build for `linux/amd64` and `linux/arm64`

### Changed
- swtpm: Improved *default* command-line parameters for `swtpm` invocation
- swtpm: Updated to revision `0528ac733b76` (2025-01-20)

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
