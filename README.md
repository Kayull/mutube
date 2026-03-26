# μTube

MuTube enhances YouTube on Apple TV with [TizenTube Cobalt](https://github.com/reisxd/TizenTubeCobalt)'s userscript,
which removes ads and adds support for features like SponsorBlock.

## Setup

MuTube has been tested with YouTube 4.54.01 on an Apple TV 4K.

### Requirements

1. `uv` (used to run `patcher.py` and resolve script dependencies)
2. Xcode Command Line Tools (`xcrun` + `clang` with the AppleTV SDK)
3. A decrypted YouTube IPA

### Build

```bash
make
```

`make` looks for the decrypted IPA in this order:

1. `IPA=...` passed on the command line
2. `./ipa/YouTube_4.54.01_decrypted.ipa`
3. The only `.ipa` file under `./ipa/`

Examples:

```bash
mkdir -p ipa
cp /path/to/YouTube_decrypted.ipa ./ipa/
make
```

```bash
make IPA=/path/to/YouTube_decrypted.ipa
```

Output: `mutube.ipa`

Optional printf tracing in stubs:

```bash
make PRINTF_LOGS=1
```

## Usage

Sideload the generated `mutube.ipa` onto your Apple TV using a tool like [Sideloadly](https://sideloadly.io/).
Once installed, open the YouTube app and you should see a popup on the top right corner indicating that
TizenTube has loaded successfully.
