You can build this iso if you have the right version of Archiso.

Archiso is a package supplied by Arch Linux that will always undergo changes.

You can follow up the versions via this link.

https://www.archlinux.org/packages/extra/any/archiso/

We are now using this version


archiso-version=archiso 84-1


sudo pacman -Q archiso and you will know your version


Downgrade to this version via a command in the terminal if you have a higher version.

`sudo downgrade archiso`

and choose the right version. 

Add it to the ignore list of pacman.


If you have a lower version then update your system. Check to see if archiso is not added to 
your /etc/pacman.conf in the list of ignores. Delete it if it is in there. Then update.
