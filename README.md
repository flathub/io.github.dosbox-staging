# Flatpak for DOSBox-Staging

Official Flatpak support is available for [DOSBox-Staging](https://dosbox-staging.github.io/), a cross-platform x86/DOS emulation package.

## Installation

This Flatpak is available on
[Flathub](https://flathub.org/apps/details/io.github.dosbox-staging/).
After following the [Flatpak setup guide](https://flatpak.org/setup/),
you can install it by entering the following command in a terminal:

```bash
flatpak install flathub io.github.dosbox-staging -y
```

Once the Flatpak is installed, you can run DOSBox-Staging using your desktop environment's
application launcher, or by running `flatpak run io.github.dosbox-staging` in a terminal.

## Updating

This Flatpak follows the latest stable DOSBox-Staging version.
To update it, run the following command in a terminal:

```bash
flatpak update
```

## Limitations

- For security reasons, this Flatpak is sandboxed and only has access to the
  user's Home folder. You should place any files you need within DOSBox-Staging in
  that folder (or in a sub-folder). Alternatively you can allow additional access
  with the override command. But note that this does not work for all directories
  as some (like ``/usr``) have special restrictions. For instance, to allow access
   to ``/run/media`` where USB devices are typically mounted, run the following command:
    - ``flatpak override --user --filesystem=/run/media io.github.dosbox-staging``
- Likewise, there is no way to access system installed MIDI soundfonts under ``/usr``.
  If you want to use such soundfonts, copy them into your home directory and
  specify the location in your DOSBox-Staging config file.
- You will need a working audio and video setup on the host or DOSBox-Staging will not start.
  - For audio you will need a working PulseAudio or PipeWire setup on the host. If you don't care for audio, you can use the dummy SDL audio driver once you installed the flatpak by running:
    - ``flatpak override --user --env=SDL_AUDIODRIVER=dummy io.github.dosbox-staging``
  - Also currently SDL2 will not use PipeWire by default, to enable it run:
    - ``flatpak override --user --env=SDL_AUDIODRIVER=pipewire --filesystem=xdg-run/pipewire-0:ro io.github.dosbox-staging``
  - For video you will need a working X11 or Wayland setup on the host. Running from a console will not work, as the SDL2 build does not have kms or directfb output enabled. If you run into problems with Wayland, you can force XWayland with:
    - ``flatpak override --user --nosocket=fallback-x11 --nosocket=wayland --socket=x11 --env=SDL_VIDEODRIVER=x11 io.github.dosbox-staging``

Please [create an issue](https://github.com/flathub/io.github.dosbox-staging/issues/new)
if you find any other limitations specific to flatpak that should be documented here.

## Configuration files

Under the default Flatpak configuration, the DOSBox-Staging configuration files are
located in `~/.var/app/io.github.dosbox-staging/config/dosbox/`. To access it with a
graphical file manager, you'll have to make hidden folders visible.

The config file will not initially exist after installing DOSBox-Staging.
You can create one from the DOSBox-Staging command line by running ``config -wcd``.

## Building from source

Install Git, follow the
[flatpak-builder setup guide](https://docs.flatpak.org/en/latest/first-build.html)
then enter the following commands in a terminal:

```bash
git clone --recursive https://github.com/flathub/io.github.dosbox-staging.git
cd io.github.dosbox-staging
flatpak install flathub org.freedesktop.Sdk//22.08 -y
flatpak-builder --force-clean --install --user -y build-dir io.github.dosbox-staging.yml
```

If all goes well, the Flatpak will be installed after building. You can then
run it using your desktop environment's application launcher.

You can speed up incremental builds by installing [ccache](https://ccache.dev/)
and specifying `--ccache` in the flatpak-builder command line (before `build-dir`).
