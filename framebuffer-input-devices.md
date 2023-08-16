# Framebuffer input devices in Linux

Camera devices under Linux (or e.g. Petalinux on an Xilinix FPGA device) are often mapped from the device-tree via the DMA to the kernel framebuffer device. A detailed overview can be found here: www.kernel.org/framebuffers. When the screen is matched to `/dev/fb0` and the input device to `/dev/fb1` we could simply copy the camera image on the screen with:

`cat /dev/fb1 > /dev/fb0`

The following example shows a resource-efficient access to the framebuffer input device using memory mapping in a Qt GUI class...

    // standard c includes
    #include <fcntl.h>
    #include <unistd.h>

    // standard c++ includes
    #include <iostream>

    // linux includes
    #include <sys/ioctl.h>
    #include <sys/mman.h>

    // qt includes
    #include <QtGui>

    int main ()
    {
      int fx;                     // the optical cam width
      int fy;                     // the optical cam heiht
      int fbdev;                  // file descriptor fro the framebuffer device. 
      unsigned char* fb;          // optical cam framebufer pointer

      // first open the framebuffer device file
      fbdev = open("/dev/fb1", O_RDONLY);
      if (fbdev == -1) 
      {
        std::cout << "ERROR: cannot open framebuffer device file." << std::endl;
        return -1;
      }

      // get the framebuffer screen metadata
      struct fb_var_screeninfo screen_info;
      if (ioctl(fbdev, FBIOGET_VSCREENINFO, &amp;screen_info)) 
      {
        std::cout << "ERROR: get screen info error." << std::endl;
        return -2;
      }
      fx = screen_info.xres;
      fy = screen_info.yres;
      int bp = screen_info.bits_per_pixel/8; // byte per pixel
      std::cout << "INFO: Camera Reolution = (" << fx << ", " << fy << ", " << bp << "Byte" << ")" << std::endl;

      // generate the memory map
      fb = (unsigned char*)mmap(0,fx*fy*bp, PROT_READ, MAP_SHARED, fbdev, 0);
      if (fb == MAP_FAILED)
      {
        std::cout << "ERROR: mmap error." << std::endl;
        return -3;
      }

      // instantiate the Qt GUI element
      QImage fbImage(fb ,fx, fy, QImage::Format_RGB32);
      ...
      // we could now resize the image and paint it on the screen...
      ...

      return 0;
    }
