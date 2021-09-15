#version 120

#include "/lib/defines.glsl"
#include "/lib/colors.glsl"

varying vec2 texcoord;

void main() {
  texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;

  gl_Position = ftransform();
}
