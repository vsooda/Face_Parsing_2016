# Face_Parsing_2016

See Face_Parsing_2016/matlab/face_parsing/run_demo.m for details.


Since we change the matlab interface, you need to adapt the Makefile.config to your own machine.

Compile caffe and matlab respectively using "make all -j8" and "make matcaffe" at FaceLabeling/;


note:

ubuntu 16.04 error:

```
Invalid MEX-file '/home/sooda/study/Face_Parsing_2016/matlab/+caffe/private/caffe_.mexa64': /usr/local/MATLAB/R2014a/bin/glnxa64/../../sys/os/glnxa64/libstdc++.so.6: version `GLIBCXX_3.4.21' not found
(required by /home/sooda/study/Face_Parsing_2016/matlab/+caffe/private/caffe_.mexa64)
```

solve:

add `export LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libstdc++.so.6` in ~/.bashrc, then `source ~/.bashrc`
