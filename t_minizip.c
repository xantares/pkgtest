#include <minizip/zip.h>

zip_fileinfo zfi;

int main()
{
    zipFile zf = zipOpen("myarch.zip",APPEND_STATUS_ADDINZIP);
    int ret = zipOpenNewFileInZip(zf,
        "myfile.txt",
        &zfi,
        NULL,   0,
        NULL,   0,
        "my comment for this interior file",
        Z_DEFLATED,
        Z_NO_COMPRESSION
        );
    zipCloseFileInZip(zf);
    zipClose(zf, "my comment for exterior file");
    return 0;
}
