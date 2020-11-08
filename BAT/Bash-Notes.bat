
for /f "usebackq tokens=1-2 delims=;" %%a in ("C:\Users\mnova\Desktop\trial01.txt") do (
      for /s "usebackq tokens=1-2 delims=;" %%b in (%%a) do ( echo %%b)
      )