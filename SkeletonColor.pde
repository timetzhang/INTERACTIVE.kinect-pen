import processing.video.*;

/*
Thomas Sanchez Lengeling.
 http://codigogenerativo.com/
 
 KinectPV2, Kinect for Windows v2 library for processing
 
 Skeleton color map example.
 Skeleton (x,y) positions are mapped to match the color Frame
 */

import KinectPV2.KJoint;
import KinectPV2.*;
import java.util.Iterator;

KinectPV2 kinect;
ArrayList<Particle> plist = new ArrayList<Particle>();
Movie movie;

void setup() {
  size(1920, 1080, P3D);

  kinect = new KinectPV2(this);

  kinect.enableSkeletonColorMap(true);
  kinect.enableColorImg(true);

  kinect.init();

  movie = new Movie(this, "v.mov");
  movie.loop();
  background(20);
}

void movieEvent(Movie m) {
  m.read();
}

void draw() {
  background(20);

  image(movie, 0, 0, width, height);
  //image(kinect.getColorImage(), 0, 0, width, height);

  ArrayList<KSkeleton> skeletonArray =  kinect.getSkeletonColorMap();

  //individual JOINTS
  for (int i = 0; i < skeletonArray.size(); i++) {
    KSkeleton skeleton = (KSkeleton) skeletonArray.get(i);
    if (skeleton.isTracked()) {
      KJoint[] joints = skeleton.getJoints();

      drawJoint(joints, KinectPV2.JointType_HandTipRight);
      drawJoint(joints, KinectPV2.JointType_HandTipLeft);

      //draw different color for each hand state
      //drawHandState(joints[KinectPV2.JointType_HandRight]);
      //drawHandState(joints[KinectPV2.JointType_HandLeft]);
    }
  }

  fill(255, 0, 0);
  text(frameRate, 50, 50);
}

//draw joint
void drawJoint(KJoint[] joints, int jointType) {
  plist.add(new Particle(new PVector(joints[jointType].getX(), joints[jointType].getY(), joints[jointType].getZ())));
  Iterator<Particle> it = plist.iterator();

  while (it.hasNext()) {
    Particle p = it.next();
    p.run();
    if (p.isDead()) {
      it.remove();
    }
  }
}
