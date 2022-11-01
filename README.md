# nothing watch face (1)

## Description 

Nothing Phone (1) inspired watchface. All numbers made from simple dots drawn on canvas, no custom fonts required. Dots size is chosen automatically based on screen size.

## Build

Use Taskfile to ease cli interface:

|Command|Description|Notes|
|---|---|---|
| `task simulator` | launches Connect IQ simulator | launch it once, no specific device required|
| `task build -- venu2plus` | builds project for spefici device | use .env to specify default or consult manifest for available ones
| `task dev -- venu2plus` | deploy project to device | simulator must be launched for this command to succeed

## Screenshots

| Venu 2 Plus | Venu SQ 2 |
|:-:|:-:|
|<img src="screenshots/venu2plus-screenshot.png" alt="venu2plus" width="320"/>| <img src="screenshots/venusq2-screenshot.png" alt="venusq2" width="320"/>|

## Versions

### 0.0.1
- Initial watchface implementation