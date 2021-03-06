# Installation

## As an SPM package
To install SwifterLog type the following:

    $ git clone https://github.com/Balancingrock/SwifterLog

This will create a directory SwifterLog with the project contained in it.

Go down in the directory that was created:

    $ cd SwifterLog

Then perform a SPM build.

    $ swift build

## As a modular framework

To install SwifterLog type the following:

    $ git clone https://github.com/Balancingrock/SwifterLog

Then create the Xcode project

    $ swift package generate-xcodeproj

Open the Xcode project just created.

Select the frameworks in Xcode, navigate to the `Build Settings` subsection `Packaging` and set the `Defines Module` option to `yes`

Build the project.

This creates a modular framework (in products).

Use the frameworks in other projects by including all of them in the Xcode project under the target `General` settings, subsection `Embedded Binaries`.

Then use "import SwifterLog" in the source code to expose the API.

## Install as source code

It is of course also possible to use SwifterLog as sourcecode. If so, simply add the sources from the VJson, SwifterSockets (from `Packages`)and the SwifterLog subdirectories (from `Sources`) to the project target.

If the networking destination is not needed, do not include the sources from Ascii, VJson and SwifterSockets and set the active compiler condition `SWIFTERLOG_DISABLE_NETWORK_TARGET`.

## Optional removal of Ascii, VJson and SwifterSockets dependency

By default SwifterLog also needs Ascii, VJson and SwifterSockets for the networking target. If the networking target is not needed, that code can be excluded by adding an Active Compilation Condition:

In the xcode project, the SwifterLog framework target, select the `Build Settings` and under `Swift Compiler - Custom Flags` add `SWIFTERLOG_DISABLE_NETWORK_TARGET` to the `Active Compiler Conditions`.

Also remove the Ascii, VJson and SwifterSockets from the `Linked Frameworks and Libraries` settings under the `General` tab for the SwifterLog target.
