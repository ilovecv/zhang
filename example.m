% sample usage

Calibration = zhang_init( 'IMG_*.jpg', 'mycalib.mat' );
Calibration = zhang_detectcorners( 'mycalib.mat', '~/imager/CALTag-1.0/CALTagData.mat' );
Calibration = zhang_calibrate_init( 'mycalib.mat', true, true, true );
Calibration = zhang_calibrate_optimise( Calibration, false, false );
% to run it again for another 100 iterations from the current point:
Calibration = zhang_calibrate_optimise( Calibration, false, true );
save( 'mycalib.mat', 'Calibration', '-append' );


% alternatively, to avoid writing to disk all the time (but remember to save
% afterwards!) specify just "Calibration" instead of "'mycalib.mat'" as the
% first argument to all the function calls after the first


% note that disabling/enabling images during calibration currently doesn't
% work without manually resetting the parameter vector. If you just change
% the Active property of a particular image, then the parameter vector
% can no longer be properly unpacked because its length is incompatible
% with the number of images. you must call Calibration.x =
% zhang_paramvector(Calibration) after changing any active images. This
% would be nicer in an object-oriented framework, but that would require
% rearchitecting this entire thing... oh, and remember then to run the
% optimisation from the current point, not the initial point (so set the
% last flag to calibrate_optimise to true)


%Note that to create an OpenGL perspective projection matrix from the intrinsic
%calibration matrrix, see:
%http://www.hitlabnz.org/forum/showthread.php?604-argConvGLcpara2-camera-calibration-matrix-to-OpenGl-projection-matrix
%http://www.hitl.washington.edu/artoolkit/mail-archive/message-thread-00653-Re--Questions-concering-.html
%and the function argConvGLcpara2 in ARToolkit
%Basically it looks like:
%[focal  skew      principle_x  0 ]
%[ 0     aspect*f  principle*y  0 ]
%[ 0      0           1         0 ]
%After multiplying a point in camera coordinates (X,Y,Z,1) by this matrix you
%will get a point (X',Y',Z') and then dividing by the 3rd component will give
%(X'',Y'') where you drop the 3rd (one) component.
%Although the actual OpenGL matrix is a little different. See the source code to
%argConvGLcpara2 for the results
