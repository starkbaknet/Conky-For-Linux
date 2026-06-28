# Conky For Linux

![Conky](https://img.shields.io/badge/Conky-%23000000.svg?style=for-the-badge&logo=conky&logoColor=white)

A transparent left-sidebar system monitor for Linux desktops, tuned for **Fedora / GNOME Wayland** with a Casio-style world-time clock, hardware stats, and live graphs.

## Features

- **World-time clock** — LCD-style time on the left, day/date on the right, centered divider (drawn with Cairo + DSEG7 fonts)
- **System** — hostname, Fedora version, kernel, uptime, battery
- **CPU** — i5-13420H load, temperature, usage graph, top processes
- **GPU** — NVIDIA stats via `nvidia-smi` (utilization, VRAM in MB/GB, temp, clock, power)
- **Memory** — RAM and swap with progress bars (GB formatting)
- **Storage** — root partition usage and NVMe read/write graphs
- **Network** — Wi-Fi (`wlp4s0`) and Ethernet (`eno1`) with upload/download graphs
- **GNOME-friendly** — `own_window_type = desktop` with XWayland to avoid workspace stacking glitches

## Project layout

```
Conky-For-Linux/
├── Titus.conkyrc          # Main Conky configuration
├── watch.lua              # Cairo-drawn Casio world-time clock
├── conky-startup.sh       # Start / restart Conky
├── fonts/
│   ├── DSEG7Classic-Regular.ttf
│   └── DSEG7ClassicMini-Regular.ttf
└── scripts/
    ├── gpu-util.sh        # GPU utilization for graphs
    ├── gpu-vram.sh        # VRAM in MB / GB
    ├── gpu-vram-pct.sh    # VRAM usage percentage
    ├── ram-gb.sh          # RAM in GB
    ├── swap-gb.sh         # Swap in GB / MB
    ├── disk-gb.sh         # Disk usage in GB
    ├── watch-day.sh       # Day label for clock (optional)
    └── watch-date.sh      # Date label for clock (optional)
```

## Requirements

- [Conky](https://github.com/brndnmtthws/conky) 1.20+ with **Lua** and **Cairo** support
- `nvidia-smi` (for NVIDIA GPU section)
- **Open Sans** (included on Fedora; used for stat labels)

### Fedora

```bash
sudo dnf install conky
```

### Debian / Ubuntu

```bash
sudo apt update
sudo apt install conky-all
```

## Installation

1. Clone the repository:

```bash
git clone https://gitlab.com/starkbaknet/Conky-For-Linux.git
cd Conky-For-Linux
```

2. Install fonts (recommended, for Cairo clock rendering):

```bash
mkdir -p ~/.local/share/fonts
cp fonts/*.ttf ~/.local/share/fonts/
fc-cache -f ~/.local/share/fonts
```

3. Make the startup script executable:

```bash
chmod +x conky-startup.sh scripts/*.sh
```

4. Start Conky:

```bash
bash conky-startup.sh
```

The startup script stops any existing instance using this config, then launches Conky with `Titus.conkyrc` from the repo directory.

## Autostart on login

**GNOME — Startup Applications**

1. Open *Startup Applications*
2. Add a new entry:
   - **Name:** Conky
   - **Command:** `/path/to/Conky-For-Linux/conky-startup.sh`

Or add a systemd user service / `.desktop` file in `~/.config/autostart/` pointing to `conky-startup.sh`.

## Customization

### Paths

`Titus.conkyrc` and `watch.lua` use absolute paths under the repo (for example `/home/you/dev/Conky-For-Linux/...`). If you move the project, update:

- `lua_load` in `Titus.conkyrc`
- Script paths in the `conky.text` section
- Font paths in `watch.lua` (or rely on system-installed DSEG fonts after `fc-cache`)

### Network interfaces

Edit `Titus.conkyrc` if your interfaces differ from:

- Wi-Fi: `wlp4s0`
- Ethernet: `eno1`

### Disk partition

Storage I/O targets `nvme0n1p3`. Change the `diskiograph_*` and `diskio_*` lines if your root device is different.

### Clock

Adjust size, padding, and divider position in `watch.lua`:

- `inset` — inner padding of the clock box
- `bh` — clock box height
- Font sizes for time (`36`) and date (`14`)

### Position on screen

In `Titus.conkyrc`:

- `alignment` — panel corner (`top_left` by default)
- `gap_x` / `gap_y` — offset from screen edges
- `minimum_width` / `maximum_width` — sidebar width

## Troubleshooting

| Issue | Fix |
|-------|-----|
| Conky appears on top when switching workspaces | Ensure `own_window_type = 'desktop'` and `out_to_x = true`, `out_to_wayland = false` (GNOME Wayland) |
| Clock font missing / boxes instead of digits | Run the font install step above and restart Conky |
| GPU section empty | Check `nvidia-smi` works in a terminal |
| Duplicate Conky windows | Run `bash conky-startup.sh` (it kills old instances first) |

## License

Conky configuration and scripts: use and modify freely.

**DSEG7 fonts** ([keshikan/DSEG](https://github.com/keshikan/DSEG)) are under the [SIL Open Font License 1.1](https://scripts.sil.org/OFL).
