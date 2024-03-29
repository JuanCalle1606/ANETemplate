REM Get the path to the script and trim to get the directory.
@echo off
SET SZIP="C:\Program Files\7-Zip\7z.exe"
SET AIR_PATH="C:\Users\User\source\SDK\AIRSDK_Windows\bin\"
echo Setting path to current directory to:
SET pathtome=%~dp0
echo %pathtome%

SET projectName=HelloWorldANE

REM Setup the directory.
echo Making directories.

IF NOT EXIST %pathtome%platforms mkdir %pathtome%platforms
IF NOT EXIST %pathtome%platforms\  %pathtome%platforms\
IF NOT EXIST %pathtome%platforms\x86  %pathtome%platforms\x86
IF NOT EXIST %pathtome%platforms\x86\release mkdir %pathtome%platforms\x86\release
IF NOT EXIST %pathtome%platforms\x64  %pathtome%platforms\x64
IF NOT EXIST %pathtome%platforms\x64\release mkdir %pathtome%platforms\x64\release

REM Copy SWC into place.
echo Copying SWC into place.
echo %pathtome%..\bin\%projectName%.swc
copy %pathtome%..\bin\%projectName%.swc %pathtome%

REM contents of SWC.
echo Extracting files form SWC.
echo %pathtome%%projectName%.swc
copy %pathtome%%projectName%.swc %pathtome%%projectName%Extract.swc
ren %pathtome%%projectName%Extract.swc %projectName%Extract.zip

call %SZIP% e %pathtome%%projectName%Extract.zip -o%pathtome%

del %pathtome%%projectName%Extract.zip

REM Copy library.swf to folders.
echo Copying library.swf into place.
copy %pathtome%library.swf %pathtome%platforms\x86\release
copy %pathtome%library.swf %pathtome%platforms\x64\release


REM Copy native libraries into place.
echo Copying native libraries into place.

copy %pathtome%..\..\native_library\%projectName%\x86\Release\%projectName%.dll %pathtome%platforms\x86\release
copy %pathtome%..\..\native_library\%projectName%\x64\Release\%projectName%.dll %pathtome%platforms\x64\release

copy %pathtome%..\..\native_library\%projectName%\x86\Release\%projectName%Lib.dll %pathtome%platforms\x86\release
copy %pathtome%..\..\native_library\%projectName%\x64\Release\%projectName%Lib.dll %pathtome%platforms\x64\release


REM Run the build command.
echo Building Release.
call %AIR_PATH%adt.bat -package -target ane %pathtome%%projectName%.ane %pathtome%extension_win.xml -swc %pathtome%%projectName%.swc ^
-platform Windows-x86 -C %pathtome%platforms\x86\release %projectName%.dll %projectName%Lib.dll library.swf ^
-platform Windows-x86-64 -C %pathtome%platforms\x64\release %projectName%.dll %projectName%Lib.dll library.swf

call DEL /F /Q /A %pathtome%platforms\x86\release\%projectName%.dll
call DEL /F /Q /A %pathtome%platforms\x86\release\%projectName%Lib.dll
call DEL /F /Q /A %pathtome%platforms\x86\release\library.swf
call DEL /F /Q /A %pathtome%platforms\x64\release\%projectName%.dll
call DEL /F /Q /A %pathtome%platforms\x64\release\%projectName%Lib.dll
call DEL /F /Q /A %pathtome%platforms\x64\release\library.swf
call DEL /F /Q /A %pathtome%%projectName%.swc
call DEL /F /Q /A %pathtome%library.swf
call DEL /F /Q /A %pathtome%catalog.xml

echo FIN
