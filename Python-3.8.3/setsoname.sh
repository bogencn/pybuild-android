patchelf --set-soname libpython3.8.so out/lib/libpython3.8.so.1.0
rm out/lib/libpython3.8.so
mv out/lib/libpython3.8.so.1.0 out/lib/libpython3.8.so

for file in out/lib/python3.8/lib-dynload/*.so; do
    patchelf --replace-needed libpython3.8.so.1.0 libpython3.8.so $file
done