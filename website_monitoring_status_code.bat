@echo off
setlocal enabledelayedexpansion

echo Website monitoring.
echo ----

set check_urls[0]=https://example1.co.jp
set check_urls[1]=https://example2.co.jp
set check_urls[2]=https://example3.co.jp
set check_urls[3]=https://example4.co.jp

set k=0
:LOOP
  call set check_url=%%check_urls[%k%]%%
  if defined check_url (
    set http_code=
    FOR /F %%i in ('curl.exe -s -k -I -L -o nul -w "%%{http_code}" %check_url%') DO SET http_code=%%i
    
    echo %check_url%
    if !http_code! neq 200 (
      echo -^> !http_code! NG
    ) else (
      echo -^> !http_code! OK
    )
    set /a k=%k%+1
    goto LOOP
  )
:LOOP_END

echo ----

pause

