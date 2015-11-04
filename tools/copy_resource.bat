if not exist "src" mkdir "src"
if not exist "res" mkdir "res"
xcopy /Y /s /Q "..\..\src\*.*" "src"
xcopy /Y /s /Q "..\..\res\*.*" "res"
