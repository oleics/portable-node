Portable Node
=============

Scripts
-------

### dl.bat

Downloads all versions of software-products from vendors and
repacks them into ``vendors/[name]/[internal version].7z``. The
download will be skipped if that archive does already exist.

``dl.bat`` takes names of software as its arguments (see the
"How to add software?" section). If no arguments are passed, all
software will be downloaded.

### mk.bat

Bundles multiple software-products into one archive.

A bundled pack is defined within the ``data/packs/`` directory by
a file named ``[name of pack].txt``. Each line of that file is
one version of a software-product previously downloaded. The
format of one line is:

``[name of software],[internal version],[directory]``

[name of software] will be copied to [directory] within the pack.

The pack itself will be archived in ``dist/[name of pack].zip``

### build.bat

Creates a whole portable environment.

``build.bat [name] [name of pack] [name of pack] ...``

The above command creates ``build/[name].zip``. See
``data/layout.txt`` for the directory-layout.

``portable.bat`` inside the .zip will start a portable command-
prompt.

How to add software?
--------------------

### tl;dr

* Create ``scripts/dl/[name].bat``
  Arguments passed by ``dl.bat``: [external version] [directory]
  What to script: Download the [external version] of [name] and
  place all files to [directory] 
* Create ``data/versions/[name].txt``
  Each line is a version. The format of a line is:
  ``[internal version],[external version]``
  Use [internal version] to normalize versions.

### Details

#### [name]

The software has a [name]. It *must* only contain 0-9, a-z, A-Z
and _ (regexp \w) No whitespace or any other characters are
allowed. Also, that [name] *must be* unique among the all the
other software-product-names.

#### The download-script

Now go create a file in ``scripts/dl/`` named ``[name].bat``,
where [name] is the name of the software. This script will be
called by ``dl.bat``.

The arguments passed to ``[name].bat`` are:

* ``version``
  The external version-string of the software.
* ``directory``
  The path to a existing directory to extract all files of the
  software to.

It is totally up to the script to download the correct
``version`` of [name] and copy the files to ``directory``.

Important: The script must copy the root of the software to
``directory``. Not ``teatimer/*``, just ``*``. I hope you
understand what I mean.

#### The versions-file

Having ``scripts/dl/[name].bat`` in place, create a file in
``data/versions/`` named ``[name].txt``. This is where the known
versions for [name] are listed. One version is one line. The
format of one line: ``[internal version],[external version]``

The distinction between internal and external version is made to
provide a mechanism to normalize versions. The [external version]
is the version-string passed to ``scripts/dl/[name].bat``. The
[internal version] will be used for all other operations.

And as nobody likes timestamps in version-strings but the dl-
script of [name] might need it, ``0.1.3,0.1.3-20120105-34-np`` is
just perfect to get rid of those timestamps and other garbage in
version-strings.

#### Final Checklist

 * ``scripts/dl/[name].bat`` created
 * ``data/versions/[name].txt`` created

Now run ``dl.bat [name]``. If it succeeds, look into
``vendors/[name]/`` for ``[internal version].7z``.

The Data Directory
------------------

``./data/versions/*.txt``

The ``*`` is the name

Authors / Contributors
----------------------

* Oliver Leics <oliver.leics@gmail.com>

License / Copyright
-------------------

Copyright (c) 2012 Oliver Leics <oliver.leics@gmail.com>

All rights reserved.