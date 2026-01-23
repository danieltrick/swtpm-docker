SWTPM Docker
============

The purpose of this repository is to provide ready to use Docker images of [swtpm](https://github.com/stefanberger/swtpm).

**Docker Hub page:**  
<https://hub.docker.com/r/danieltrick/swtpm-docker>

Usage
-----

In order to start `swtpm` via Docker, just run the following command:
```sh
$ docker run -p 2321:2321 -p 2322:2322 danieltrick/swtpm-docker:r19
```

### Default parameters

By default, `swtpm` will be invoked with the following parameters:
```sh
socket --tpm2 \
--server type=tcp,port=2321,bindaddr=0.0.0.0 \
--ctrl   type=tcp,port=2322,bindaddr=0.0.0.0 \
--flags not-need-init \
--tpmstate dir=/var/lib/swtpm/tpmstate
```

Version history
---------------

| **Release** | **Date**   | **Base system**       | **SWTPM version**                                                                    | **libtpms version**                                                           |
| ------------| ---------- | --------------------- | ------------------------------------------------------------------------------------ | ----------------------------------------------------------------------------- |
| r20         | 2026-01-23 | Alpine 3.23.2         | 0.11.0 / [`d41849c30e78`](https://github.com/stefanberger/swtpm/commit/d41849c30e78) | [`c2a8109f8b44`](https://github.com/stefanberger/libtpms/commit/c2a8109f8b44) |
| r19         | 2026-01-06 | Alpine 3.23.2         | 0.11.0 / [`d41849c30e78`](https://github.com/stefanberger/swtpm/commit/d41849c30e78) | [`fc8820cfaa8b`](https://github.com/stefanberger/libtpms/commit/fc8820cfaa8b) |
| r18         | 2025-12-11 | Alpine 3.23.0         | 0.11.0 / [`d41849c30e78`](https://github.com/stefanberger/swtpm/commit/d41849c30e78) | [`4f71e9b45db1`](https://github.com/stefanberger/libtpms/commit/4f71e9b45db1) |
| r17         | 2025-11-05 | Alpine 3.22.2         | 0.11.0 / [`8084873972b4`](https://github.com/stefanberger/swtpm/commit/8084873972b4) | [`7310725524c2`](https://github.com/stefanberger/libtpms/commit/7310725524c2) |
| r16         | 2025-08-12 | Alpine 3.22.1         | 0.11.0 / [`665486b8179f`](https://github.com/stefanberger/swtpm/commit/665486b8179f) | [`b4d81572c15b`](https://github.com/stefanberger/libtpms/commit/b4d81572c15b) |
| r15         | 2025-06-12 | Alpine 3.22.0         | 0.11.0 / [`4a0e632f3731`](https://github.com/stefanberger/swtpm/commit/4a0e632f3731) | [`04b2d8e9afc0`](https://github.com/stefanberger/libtpms/commit/04b2d8e9afc0) |
| r14         | 2025-02-20 | Alpine 3.21.3         | 0.11.0 / [`0528ac733b76`](https://github.com/stefanberger/swtpm/commit/0528ac733b76) | [`ecb769cdb8dd`](https://github.com/stefanberger/libtpms/commit/ecb769cdb8dd) |
| r13         | 2025-01-23 | Alpine 3.21.2         | 0.11.0 / [`0528ac733b76`](https://github.com/stefanberger/swtpm/commit/0528ac733b76) | [`ecb769cdb8dd`](https://github.com/stefanberger/libtpms/commit/ecb769cdb8dd) |
| r12         | 2025-01-15 | Alpine 3.21.2         | 0.11.0 / [`3d6a8b75b335`](https://github.com/stefanberger/swtpm/commit/3d6a8b75b335) | [`ecb769cdb8dd`](https://github.com/stefanberger/libtpms/commit/ecb769cdb8dd) |
| r11         | 2024-12-06 | Alpine 3.21.0         | 0.11.0 / [`314f5f411b32`](https://github.com/stefanberger/swtpm/commit/314f5f411b32) | [`f22745c72933`](https://github.com/stefanberger/libtpms/commit/f22745c72933) |
| r10         | 2024-09-28 | Alpine 3.20.3         | 0.10.0 / [`2e2124928f38`](https://github.com/stefanberger/swtpm/commit/2e2124928f38) | [`6adb99a42cf6`](https://github.com/stefanberger/libtpms/commit/6adb99a42cf6) |
| r9          | 2024-09-18 | Alpine 3.20.3         | 0.10.0 / [`017f99ceddb0`](https://github.com/stefanberger/swtpm/commit/017f99ceddb0) | [`e898872637b4`](https://github.com/stefanberger/libtpms/commit/e898872637b4) |
| r8          | 2024-09-13 | Alpine 3.20.3         | 0.10.0 / [`28292591cbef`](https://github.com/stefanberger/swtpm/commit/28292591cbef) | [`46548da8edbf`](https://github.com/stefanberger/libtpms/commit/46548da8edbf) |
| r7          | 2024-09-08 | Alpine 3.20.3         | 0.10.0 / [`607eb54b3e52`](https://github.com/stefanberger/swtpm/commit/607eb54b3e52) | [`e983cdf05c4e`](https://github.com/stefanberger/libtpms/commit/e983cdf05c4e) |
| r6          | 2024-09-05 | Alpine 3.20.2         | 0.10.0 / [`607eb54b3e52`](https://github.com/stefanberger/swtpm/commit/607eb54b3e52) | [`e983cdf05c4e`](https://github.com/stefanberger/libtpms/commit/e983cdf05c4e) |
| r5          | 2024-09-01 | Alpine 3.20.2         | 0.10.0 / [`0ddc7ed25491`](https://github.com/stefanberger/swtpm/commit/0ddc7ed25491) | [`f5518e596e65`](https://github.com/stefanberger/libtpms/commit/f5518e596e65) |
| r4          | 2024-08-29 | Alpine 3.20.2         | 0.10.0 / [`54583a87b536`](https://github.com/stefanberger/swtpm/commit/54583a87b536) | [`2dc1af12e5b0`](https://github.com/stefanberger/libtpms/commit/2dc1af12e5b0) |
| r2          | 2024-08-27 | Debian 12, 2024-08-12 | 0.10.0 / [`54583a87b536`](https://github.com/stefanberger/swtpm/commit/54583a87b536) | [`2dc1af12e5b0`](https://github.com/stefanberger/libtpms/commit/2dc1af12e5b0) |
| r1          | 2024-08-27 | Debian 12, 2024-08-12 | 0.10.0 / [`d6ca69ad4622`](https://github.com/stefanberger/swtpm/commit/d6ca69ad4622) | [`92ab42119406`](https://github.com/stefanberger/libtpms/commit/92ab42119406) |
