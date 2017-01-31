import javax.vecmath.*;

PMatrix3D[][] map=new PMatrix3D[2000][2000];

PMatrix3D defaultMat, mainMat, pokesenMat, streetMat;
Quat4f mainQuat, pokesenQuat, streetQuat;

void initMap() {
  defaultMat=new PMatrix3D(
  0000.9596, 0000.9257, -0001.4909, 0, 
  0000.5036, 0001.4823, 0001.2446, 0, 
  0001.6809, -0000.9725, 0000.4781, 0, 
  0000.0000, 0000.0000, 0000.0000, 0001.0000
    );
  mainMat=new PMatrix3D(
  0000.9596, 0000.9257, -0001.4909, 0, 
  0000.5036, 0001.4823, 0001.2446, 0, 
  0001.6809, -0000.9725, 0000.4781, 0, 
  0000.0000, 0000.0000, 0000.0000, 0001.0000
    );
  streetMat=new PMatrix3D( 
  0001.8916, 0000.3544, -0000.5443, 0, 
  0000.2801, 0001.0672, 0001.6681, 0, 
  0000.5859, -0001.6540, 0000.9597, 0, 
  000.0000, 000.0000, 000.0000, 001.0000);
  mainQuat=toQu(mainMat);
  streetQuat=toQu(streetMat);

  if (moveCamera) {

    for (int i=0; i<map.length; i++) {
      for (int j=0; j<map[0].length; j++) {
        if (i<920) {
          map[i][j]=toMat(streetQuat);//streetMat;
          continue;
        }
        if (970<i) {
          map[i][j]=toMat(mainQuat);//mainMat;
          continue;
        }
        map[i][j]=mean(streetQuat, mainQuat, (i-920)/50.0);
      }
    }
  } else {
    for (int i=0; i<map.length; i++) {
      for (int j=0; j<map[0].length; j++) {
        map[i][j]=streetMat;
      }
    }
  }
}
void setCamera() {
  int hx1=((int)hx)/5+map.length/2;
  int hy1=((int)hy)/5+map[0].length/2;
  println(hx1+" "+hy1);
  applyMatrix(map[hx1][hy1]);
}


class Map {
  PMatrix3D mat;
  Map(PMatrix3D mat) {
    this.mat=mat;
  }
  Map() {
    mat=new PMatrix3D(1, 0, 0, 0, 
    0, 1, 0, 0, 
    0, 0, 1, 0, 
    0, 0, 0, 1);
  }
}

Quat4f toQu(PMatrix3D m) {
  Matrix4f tmp=new Matrix4f(m.m00, m.m01, m.m02, m.m03, 
  m.m10, m.m11, m.m12, m.m13, 
  m.m20, m.m21, m.m22, m.m23, 
  m.m30, m.m31, m.m32, m.m33);
  Quat4f q=new Quat4f();
  tmp.get(q);
  return q;
}

PMatrix3D toMat(Quat4f a) {
  Matrix4f m=new Matrix4f();
  m.set(a);
  return new PMatrix3D(m.m00, m.m01, m.m02, m.m03, 
  m.m10, m.m11, m.m12, m.m13, 
  m.m20, m.m21, m.m22, m.m23, 
  m.m30, m.m31, m.m32, m.m33);
}

PMatrix3D mean(Quat4f a, Quat4f b, float i) {
  Quat4f c=new Quat4f(a);
  c.interpolate(b, i);
  return toMat(c);
}

