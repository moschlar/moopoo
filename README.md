# MooPoo - An amateur [Gentoo Linux](http://gentoo.org) portage tree overlay

**This is an overlay for Portage - the [Gentoo Linux](http://gentoo.org) package manager.**

**It contains ebuild that seem useful to moschlar and gravitino, both passionate users of Gentoo Linux.**

> The name `MooPoo` is an hommage to Larry the Cow, Gentoos official mascot.

## Special features

At the moment, the eclass for using **[FontPro](https://github.com/sebschub/FontPro)** and
the corresponding ebuilds for **MyriadPro** and **MinionPro** are the most awesome features in this overlay.

## Using this overlay

To use this overlay, you need to have `dev-vcs/git` installed.
Then clone this repository, e.g. `git clone git://github.com/moschlar/moopoo.git`.

Now you need to edit the overlay to your `make.conf` file:
If you are already using overlays, you propably have an existing `PORTDIR_OVERLAY` variable in your `make.conf`,
if not, define it. Then you add `/path/to/directory/moopoo/` to `PORTDIR_OVERLAY` and you're ready to go.
