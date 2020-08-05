PYTHONOUT=pythonout
patchelf --set-soname libpython3.8.so ${PYTHONOUT}/lib/libpython3.8.so.1.0
rm ${PYTHONOUT}/lib/libpython3.8.so
mv ${PYTHONOUT}/lib/libpython3.8.so.1.0 ${PYTHONOUT}/lib/libpython3.8.so
patchelf --replace-needed libpython3.8.so.1.0 libpython3.8.so ${PYTHONOUT}/bin/python3.8
for file in ${PYTHONOUT}/lib/python3.8/lib-dynload/*.so; do
    patchelf --replace-needed libpython3.8.so.1.0 libpython3.8.so $file
done