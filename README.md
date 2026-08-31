# UE4SS for Far Far West

Custom [UE4SS](https://github.com/UE4SS-RE/RE-UE4SS) configuration for **Far Far West** (Unreal Engine 5.7).

This repository contains a ready-to-use UE4SS v3.0.1 experimental build with custom AOB signatures that enable full runtime modding support for Far Far West.

## Additions for FrostBurn update
- Game now uses UE version 5.8.1 (hence ue4ss version change)
- `HookProcessLocalScriptFunction` causes immediate startup crashes

## Download

Go to [Releases](../../releases) and download:
- **`UE4SS-FarFarWest-v3.0.1-experimental.zip`** — For players and mod users (lightweight, no debug symbols)
    - **`zDEV-UE4SS-FarFarWest-v3.0.1-experimental.zip`** — For mod developers (includes .pdb debug symbols) _(not available in this fork)_

## Installation

1. Download the release zip for your use case
2. Navigate to your game folder:
   ```
   Steam/steamapps/common/Far Far West Demo/FarFarWest/Binaries/Win64/
   ```
3. Extract the zip so your folder looks like:
   ```
   Win64/
     dwmapi.dll
     FarFarWest-Win64-Shipping.exe
     ue4ss/
       UE4SS.dll
       UE4SS-settings.ini
       UE4SS_Signatures/
         FName_Constructor.lua
         GNatives.lua
       Mods/
   ```
4. Launch the game normally

## Features

- **In-game console** — press **~** (Tilde), **^** (Caret), or **F10**
- **Cheat Manager** — enabled automatically
- **Lua mod support** — place mods in `ue4ss/Mods/`
- **Blueprint mod loading** — via BPModLoaderMod
- **Live View** — real-time UObject inspector (UE4SS GUI)
- **Kismet Debugger** — Blueprint bytecode inspection
- **Object Dumper** — dump all game objects for analysis

## Uninstallation

Delete `dwmapi.dll` and the `ue4ss/` folder from `Win64/`.

## Troubleshooting

| Issue | Fix |
|-------|-----|
| Game crashes on startup | Delete the `ue4ss/cache/` folder |
| GUI doesn't appear | Set `GraphicsAPI = dx11` in `ue4ss/UE4SS-settings.ini` |
| Need more details | Check `ue4ss/UE4SS.log` |

## Technical Details

### Why custom signatures are needed

UE4SS locates engine functions by scanning the game executable for known byte patterns (AOB signatures). Far Far West (UE 5.7) uses patterns that differ from UE4SS's built-in signatures. This build provides custom Lua scripts that supply the correct patterns.

### Custom AOB Signatures

**`UE4SS_Signatures/FName_Constructor.lua`**
- **Target**: `FName::FName(wchar_t const *, enum EFindName)`
- **Method**: Direct scan of function prologue bytes
- Extracted from a blank UE 5.7 Shipping build with PDB symbols via x64dbg

**`UE4SS_Signatures/GNatives.lua`**
- **Target**: `GNatives` global variable (array of native Blueprint function pointers)
- **Method**: Indirect scan — locates the GNatives initialization function, then resolves the variable address via RIP-relative offset

### Settings Changes from Default UE4SS

| Setting | Value | Reason |
|---------|-------|--------|
| `MajorVersion` | `5` | Engine version override |
| `MinorVersion` | `7` | Engine version override |
| `bUseUObjectArrayCache` | `false` | Prevents startup crashes on UE5 |
| `MaxMemoryUsageDuringAssetLoading` | `80` | Prevents out-of-memory issues |

### Known Limitations

- `FUObjectHashTables::Get()` signature is not provided — this is a WIP/unfinished feature in UE4SS itself and has no functional impact on any modding features

## Repository Structure

```
dwmapi.dll                      # DLL proxy loader (placed in Win64/)
ue4ss/
  UE4SS.dll                     # Main UE4SS library
  UE4SS-settings.ini            # Configuration (customized for Far Far West)
  UE4SS_Signatures/             # Custom AOB signature scripts
    FName_Constructor.lua
    GNatives.lua
  Mods/                         # Default UE4SS mods
  CustomGameConfigs/            # Reference configs for other games
  Docs/                         # UE4SS documentation
  MemberVarLayoutTemplates/     # Memory layout templates per UE version
  VTableLayoutTemplates/        # VTable layout templates
```

## Credits

- [ue4ss-far-far-west](https://github.com/anro772/ue4ss-far-far-west) by [anro7722](https://github.com/anro7722)
- [UE4SS](https://github.com/UE4SS-RE/RE-UE4SS) by the [UE4SS team](https://github.com/UE4SS-RE)
